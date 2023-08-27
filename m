Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B078A1C1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjH0VOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjH0VOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:14:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2061.outbound.protection.outlook.com [40.92.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40BFB9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsuaXkjL2FhtB4SmZ6v/Q+HjeDSX7nD0nRth+R9k743soQivK0Z6gzj/5/91tTZhy+vZVQUBpRWAHh1U4ApemDZc6IgzAf8WolYbo/pKLlzE6u5qHpHi4Y2n4MALuDjef32ghNho2Y+U50ZP0BiLEhYH5q5wdyzu1l1Fo394RthgO9RuX/1vc656hK6TbahxUfTaf4pYN24EW9/YpyH5+fwBp01bFzDG8eHtW1QHWoULFgy0r9U0mEnh4HCAhXyE1rrIQQ4NjWQC0um7TX8OgiXngsAxl1qgyiOpDCFHXXpWvrXS3qQ1T5M6+RHowcxydGtbKV/7ECzpjMt6BMuTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYV+omyHyPP61oyBbJeHRbXe1Ob/QV2SjPYSWYGmmg0=;
 b=IOzcKac/1YJ0jiUpQTx9JuYue6oIy++TrVHwFln3qY2g+ltOcLH4YHCzrt/9RUPphQK7+pWBa3d770pPcbu1i6jjrTdjLahVkCQ5SLlbdcaZQAZHgEQTrOyazQa9dUyvnQSFj6riYz6Spz4aWkkwbKIn62Z4sE+5+bd+ti4AC8V5yjpsQKjZOYxLPycDYVDyFJh4fomgwXAM0mQgiHXH2/k9eFniBR5yIobv60/09FfmOHjVESdqMhMqZ4aoF9AKXpmMOrQaJoKfGaynS9VulSwG5c8X/75Zp4/9lB8x+dV6i2RNcob15hCZcQdS8YbqHb9jq60+qJ3H9+0kEt37OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYV+omyHyPP61oyBbJeHRbXe1Ob/QV2SjPYSWYGmmg0=;
 b=r5VaW9yTV9hp9/OnGKw38WcBPC8PDoqf9F8dK0eDbNnkjeMVA9IGFLPk0nIJWBKvOYPeT/V9cCGIyDVV0oaOkwl90mvUefizzt+WUefzQF6xoKDerCXragohJXaGdj8CSwXDTonvsdvzOMz6j6Vo+ytigM8dyiytboRqICWdGWZoKIm3H/23tqn09HbQfkFXSqeugDHh6PlwfDMdUpUoXqQu5e0GJvIk9EZfx9fZFMfreYFjdonrGL5YhP5S4cEuBOqp4ArsMEdnDbcCmr+fF2qIEpnP0Iqkg17z9cAHUNIXMUD2neL8Bs/ygkab9XCxxWjM7bKLZAVnvDTJ5bP+yw==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:14:07 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:14:07 +0000
Date:   Sun, 27 Aug 2023 17:14:04 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 4/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB76431AD0671A7D3F4CC0EBD4BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [atUtHzHWdgADKiFe+ZSqzlwpLKirc11CzIbzTFPciuv3wGv03XlGoHX6ajc/JKOo]
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <4oouducumpbhyb6kybpf6ifl5s6ieavrpc2fkgcrneecultdyc@a7ocoierux5x>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3ce870-544e-4205-87e1-08dba7428c4c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqlLWevWXf/P94/MlidRfI1uIkzeZZnGUSCgk1fs03T+aP0jOW480NRZCmZYioZfcaA6EavwwuOcWwqKu2oLUJ018/UNRfunH6zN9J5OfrGI5foPD1PQMTezNzCloI6gG5eECNPUqOETguao510ZH2mnmP6c1w0PHjXrQXs49zgJuRA9c7bpcv6g94+UkD4703dMGMWEb9Qbnf2Z9z61kD9ohTkCUYZDdb7yh3k809yP4sNXf0hKAXU5SnwTGj0pxF74yt0bmXOg3JyZ7fnEGdEf12YLHorwKy0jCZERY0d+uQnQU+2Nz+wxuNwGv6CpGfymg3zVtNptV2y9oZujdAgsX8IC4/Fw3zV5dypTcw/FNo7Mv9BsrDkJViw70JfyJjKKWqQ6hRLaAPTlwteCsI/pPW5yNFP9gq8JQ1ntsDMTFbC0/L1lqtxjM6qCSfDVWCY0771eWeMdBkn/FLCj+DIrySsYp09DchUUdrOLBteppqQQyCdQ25sUYQNKNcCLrg950PEbmyuJuTY/yEUQ+me+8T6+zaG026Ig1+tYoVJ/xCmKtua2KuIgVQd1mX0j
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jeMZEqebkPOZqw+54vcSrwOtl5VLBqu2rgGzO39Bfdqo7yXu/bphnhFQERvE?=
 =?us-ascii?Q?6AWBK7NRgz7imxvJLSGr4qGL70rSP8qmKFzXAdBu5qMWzwW1hDAGG5DQGLfh?=
 =?us-ascii?Q?nwY9xzVAlSfzSXtb4WvBUX/3XmgIxSiJk/UETwLJXLpxJuWDJYMfzIRtpfxm?=
 =?us-ascii?Q?F2WXfzcE6oOllO1VOykDGoVIF3Q12QIIiSz/Sm5+yd9Y1zsbOmDSTK1kOXqR?=
 =?us-ascii?Q?ljn1AMq+aEezGqGoFGRaI7+cpFbQB1bYex1dGQ6malA4iavkyPtowtS2gjIL?=
 =?us-ascii?Q?T7dMWE1iAd7f0c9oh7QCoAXi6+BmR+tFOcjertLNkHJZhja9ABE7+J8GkZxH?=
 =?us-ascii?Q?lQr7TVg+LDB0lHCoO6zIPSWeu9VG+clsl9Div6yjvS8oX2sKMjJs0r2P3+14?=
 =?us-ascii?Q?JFLiSdHxxaH+fEss3J1dGRKIP6KItDqRph5G4HQ/vdYyyAxp/a1oLUzx7eg/?=
 =?us-ascii?Q?iMyQ5TMtKcI0XwHnNcuFd64mpjSpQIJy1ypNZdflc8SBkwOdwtmhuZU6W2QH?=
 =?us-ascii?Q?S3v6YuViciulJGgbv1w+AUFKhIQUMTOMxeNKrCPsPdrCIeDdL8Mo6owZBAmx?=
 =?us-ascii?Q?gwLwrPkCzGG0PlUKTQsQFIapoMIUK9TPBp1S4JRdg4+Eg/tQ2Svd+qSigMwA?=
 =?us-ascii?Q?s5OTVgMarcpv36ulcbTtsmRYuWpwo14JGFlwfjlY0/LpE9xzHuBXsmdvRaEQ?=
 =?us-ascii?Q?UPcFrSzxkuxmcRgIgh3rCMka13KQbgcIBLBMLJ3XUIgHlXbBUej6/cZid23e?=
 =?us-ascii?Q?qvNlo3hXgSj0jvuUzvtXZi+M0k2smtJ/lls9csjtYKw40NszpJW6LSjqLrxe?=
 =?us-ascii?Q?3cgb+3ini5/GqMGOWzUGc74MUSxvBjAASX4zXomWf/zfcw1IfKOLBRs3LlmF?=
 =?us-ascii?Q?5gVwaNDnlV13jvmdt3aQ+U1rXQW2jWq6YVS85Vs3rr3jObUg+DVNLXn0DdG8?=
 =?us-ascii?Q?c/XGdQ82dFtv3lVhC0+dxn1GL0La8NKlflItsRLQ02ParrF2yDy1X1pYR3n4?=
 =?us-ascii?Q?BmAkQSTLET2hPttEI0jzLBQVI5Vfs6STC71MEZM49U4Yxl+GdiS5HII16kwP?=
 =?us-ascii?Q?F0SBhy3zDen9DEGW3keeiKPLTF6KGiRe1BSi/Prw0iDpCRoWhZBcHeqvnQ8R?=
 =?us-ascii?Q?osxFyuzJ8p3ZMvS2GT3hjdx1jpkA0yiRfx9yb+KNLvbvzJ2Ub5ON37SIgH8M?=
 =?us-ascii?Q?hhJ0OxUwTZBzZ423vCfQ/+7GOgRyRg2J2SGjhXQX7s44xv4NwptxFtKE5bZL?=
 =?us-ascii?Q?mXp79qNJFqHcAyat8/0hXhDqDnjd+ZlnwKfpGZgUgw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3ce870-544e-4205-87e1-08dba7428c4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:14:06.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
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
 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 4470c985dc5d..2cdbcbd8a97b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -238,11 +238,11 @@ enum cvmx_pow_wait {
 	CVMX_POW_NO_WAIT = 0,
 };
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
 typedef enum {
 	CVMX_PKO_SUCCESS,
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

