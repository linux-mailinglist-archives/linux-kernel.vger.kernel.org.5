Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9105478A395
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjH0X7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjH0X6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2022.outbound.protection.outlook.com [40.92.22.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE44107
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2XQL1XYduN3LhS7vrkO2x4XCT/AuC2T6gajspK5NzWBl0uYdE2e3VGgYrW3RvX5D9uFtFq6c1L7z0+Tp77YoYbt0UQkBo1L+0sdl6NVdP6OKCpk1hm6Wh2yDVpuabfJAWamfAVtaxI6btZGLlvtUdeyx8fksy32nhUNLnFlVIpiPR+YlmlBpClpQomqXBN5B+IsMec0u3bMRu5yAxjITB3B9OJhMRHMVht5hkcX0ETWL/mwVJea4HRAleNNsfwCRDE92PhV4wL/pDKIfg6/hy7Y64/e6gMVIt82z4sIpFOEbPpUEWK8aCI8F4Y2VUJni1sxaOC/0u7oFaOT6YSWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxNVss8CSnrbiwhM9kntjdQD3vVM2SL298XHRVmebsU=;
 b=Q4LY8Nz7c8WWUad1GslL3p8kcdFRrk00IPUl4BfkR11kwmN9pKjdv3TZVilB1fGhdpu1/JhGTDkDg+vlDX2izBPKIK8eJjo+EegWpVdD6H4GolTZpIiICoW7cp1zIRV2QjFP0iiYZiVw6kukMAJQRYP28UtdkFNhZSlFO9BU3t+tpgSql2hWagqq7faayQ/B9Vud/rGbsWr1PkAJ8BtfnQhKmBxDuGcdiyYQdGaropIc4Diw6ZIafDmbzoZPL43zbk6J0BIQcQn7wBBB4TqjlPbyKwXa53jR3ry0VuvzU/aoApehSH3Ej49csqoRgkWDDpzp3zmAyUKhFhuCipcuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxNVss8CSnrbiwhM9kntjdQD3vVM2SL298XHRVmebsU=;
 b=k3Xuvwi+YbFTnbo4HgsL1wRyfYNvnbyUCfm8iVIgz3jXeb4s7axJoX2tc/l+SiknPoyndfP5CBzMFq9JbVLDehVvwfwfUV/bj7JIMk4dXZ8TmNk8kT8d1YzyOLmQR1oCBnNLtTLXF7q7rcCdq/ewq8BZxltrj8pNZcRs+Icoee6hK5znSr5YjKrLv3X7tBvjHEUNbqHioGaVMx/T3Z8sgstIp+0TL/QzhJSP9CnzQQr7f6IACA07AyW6Vsn5nvpf9yfDR4azZfCSqUkhB7o0gf+86nFEX9DC9vJZVQx4r6yXRFkmOrCtyafeje1U3QrrvulGnQ/sZll0PROYvNM0EA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:48 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:48 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 5/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:21 -0400
Message-ID: <PH7PR11MB76433CBD4E41E88647C84C06BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693180346.git.ozlinux@hotmail.com>
References: <cover.1693180346.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [TUnJ83RNP8y+cqhYh+QqTRrh1pqeRuthyCvYfqDMc9GusnSUcoeHQiqUjHH2LPsD]
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e9630d0489b3a584284affb7a4a26b59d8213d36.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: e879f8af-aa90-464b-0585-08dba7598e43
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKwOrD9bpH1mMEw/bv3t64CC+epm0uAjNJKd8PsFdowr4Bp966J8mlZixSwsnvVFo/IRJyMTWAXCDlSjQ0Eu1+V6mkQQ5dMBId/GRqQ0DilzWrfKV1CbSIXvIJCdt18NKwY/yOOa6vkgobLh9aI6Jwrb/CjOIqHWTlr0fvd0HZhApw31TIWOGjCoRgmfLqNqcDyZNLiDR1pjN7l42PD9RBryicOAJGw+O622WWrwNNHlBH7JrCEiZNDGNCqUq4CarCNb5eKJjYBVn4J5lLXHfJdvBDwWY/SrPmS6JvV/V0LmvHqkOfYnJndPKYiTWvVUx8jwAuYDbMKnBpA7KBnWN2oFWjYTTVdB5qKCyPHYgG55VAeGLUX676nw1QPBY/pwNDoZn30v1qVLKh4AOZGkw2sXIc+4psUQkxLazTKr4ZzaE0cIwkHy5lV9lj75Hz0KhoLqUKxIP1kvIU1fzhiNkn00rcPmLiVcB7Fgctu7BAKTFkUQnft9WRBEg6iz1IxSYdXWySs/rtIRLgPpN01ZTlw+rkF00f448+V/a17C/HkNtgUTWoDmNETuBuFkIWqrvSkkfsydNV5VVPEl4x8rv5JAFDKps7Hj3wu499OvHXW6OA95odCMFDZRs+5fwV0ymvpMwvOhthHbM3e5z/0j7KjtgLoMe+jdXGrqOPa2vYG6D+1UZSdNarTXGAKRvsS9XEJ9eBwefgaDxTcJvFiOID04/oH28Uv2PR8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxraUcSL8CWeIDeL8jIN3ry7l4cgeVpA/blwRifo1bIIgFob9OP41RWGKoicAX51c/e+jTFj1UQxz4iLPiLv/gpasjChU7XfK4MV50f6zAgQXZk2qlUHifD/WanrJVNK+CbHYLTfURZAQA91EQhijnfYk9elBXc97zYodQ12iVo5gH7rTOh2tnt1oeM8Z4ky4WwhyWGk7pa6NBoPTa7bwD7vVK2qVKWHMBlvXqjjhu52OIaNSCTeknMyUQsRBMpty0imb4WN4rbffDeEHxm9x6suoxFr8+YXui5TjtQqizK43YvEZjyfb7SnG6p6ea90+r7vrLBIOyYcXDLNQ/5hWtPqihzY8tgWejJiL4Uk6bIHnBzypkCqJS1HmkNA3Lgo5FreOutAEb9oMDQ0VHViicmRcBjXgaYQzs/8pINSptUQi8cUlk/yIOH0xtlkMDAPppEOb3DI0QuE5jWaMUwbagyh6i0odHlSMiqhGBvQ6I//aqRxyfHU2qBmNXR3u18UIqQUS9uKLHWJBRXjLVjrZhKgG/X9VuBn/q8KMH9USzK2rHLxACgACb6PxuDteTmPeUW3mUa2M5UjaXrCdZuwSJI01yYV8XyBQWlOKBmw7NZz31AWuuJqm5RCWMM/Lml+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lThYsBKvPZO+3wuZyRF2qLuSfJSlSggJnQzKtz0r0S2Q21bWocvYTajWpGN+?=
 =?us-ascii?Q?i5hVdvniPZBQv4scdaVG7ktlB1XMelhcNCJixhLKiNMU9Tm8Z+1FE3o2jfo/?=
 =?us-ascii?Q?3YKqY57sk4UQiQtK5OzdPkfUWhahgcOX2nTmwqmDaAY9kbOLsE7N9FkAtmS+?=
 =?us-ascii?Q?gMdEnU2/XwzAdFnS5DH6l4szQm+BofNgmdNva0DtEKkwV1LHXyY+IoozWpzj?=
 =?us-ascii?Q?bzKUsy+7/ghhc1ZUF5gqAPuzMXKtb/ix+YofGsrLBeET6FhPqaiMVaHI1aEb?=
 =?us-ascii?Q?lzKqPH9kc1PaYYcNEyvDdw7I/+Rzh3SRnYftLLMZVgw007GhfEhMGMAhlV8m?=
 =?us-ascii?Q?7wz6UFiuBmP5A4Wtyf3lTR5xCZ2kJxWY7zancWARHZ7c/Cs2Jy7smf/5DlQ1?=
 =?us-ascii?Q?PUqyN/k5F+6MW+6TZq2hMkhwMihSjc92wWkKRBlx86wmwimL9HswyU69e2uj?=
 =?us-ascii?Q?GSaxDol0F03w1+Hcpmx1Mr+y87z2Y7Z7FKQ5h/jUhf7hz0zpM1XlgFMTPjtC?=
 =?us-ascii?Q?HoGh7Uc0faY3UoX0yeDAwsX2mAqoFqIUBiiWMGogfykGE/DCsWjSwefBMj1X?=
 =?us-ascii?Q?ob7gslVCRwxbmlvF4cjCfWX62Asw/GSVvKoBPexl+yauuZBswAIZD9rPOrs5?=
 =?us-ascii?Q?26dTe4Eg/7zjMO+LRBc4SsdtGSgMbyN0gm20e9egIqE0tVQZ16ZaO3+VG2dz?=
 =?us-ascii?Q?ho1FVQc5G6KuhqAJQoUaREzD5kjHvbm4wf/W6zUhaU5T9wsr8fx62bCD1TOo?=
 =?us-ascii?Q?5TcFRBqtaGJ/MXg71Pj3REH9LgSKtxrj8dBlyJfKKP6TwXQc32d2sCfok1vH?=
 =?us-ascii?Q?t2kHJGkOcX9d8b8+AeiI37jOACS9NElhDWR3AFail0y4LQ25ubxG8Z6BQ85t?=
 =?us-ascii?Q?Y1ezh0H6p6WyBlCLOsfqhg571+z989pgTv6ik4Dg1hGB3RCEBm55Zp3V3VdB?=
 =?us-ascii?Q?R5WT0INiPzFwWiiwGcSsiIvK6JKY2elf5heBLNOYsll19RJrI8tD0ZVWSQuJ?=
 =?us-ascii?Q?umF+mGYGb3JcI6XQMZymJPI7I2uil4XU/jnAM1SpaCJ2BMlccYfjFd2osfK6?=
 =?us-ascii?Q?sNi96PHDEHaiaBf05rxNxIcqXxEAmpJ683omZZEK8O4EZcqFLfLFzULag6DU?=
 =?us-ascii?Q?qiwb+y+6eoeDB8uPOVxYvSF1YtyK50N3Ji+i68kS8YO7aBkrG3gvBjyd4r+O?=
 =?us-ascii?Q?sgedI3mOasDk/66s/Z6Rbq5L0juWDtL6htmzKGZpNFVszaByOVwQ5pqdvITE?=
 =?us-ascii?Q?l02Ftg+ytzz3s99QS0vyidagZnWVjdRWgkQQEo39lA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e879f8af-aa90-464b-0585-08dba7598e43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:48.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly 
v3: Fixed a problem where I forgot to rename all instances of a struct

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 2cdbcbd8a97b..b9852994882b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -244,7 +244,7 @@ enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
 };
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
-- 
2.39.3

