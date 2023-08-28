Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363DB78B4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjH1Pkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjH1Pkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2046.outbound.protection.outlook.com [40.92.19.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CC113
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgsZCzCE97SXdoW47cp4K9BWb3XOAHHvqRkJRT+OhT3juLf5rsRfroP8URv8KFwfECQoF0eDp4HoenD2zsHsl9/OsXrcZxCTvASKN/t2yNrM3hrSzRjwHiMW1ToQssZDlO2rUHSCB1k7t5qybWjCGsPEFaopO50NeqfkXaarPrZIN3GqBjCu8y3AHRKcOXasdbrrfF8QqwdJCeXJWjPu5sW0QUVjLFRSFXNuBopWCSehJOuR1smfClBW36UQfq/vxb1LAngvpG5zOmjyuj2EaGUe7YcFfocAzCcfqZk07LhNgCQ+WnydhAsSB/VgJNIYNxYK8TwSMlkboIdyZ6n8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ogdqHP0RCTCA7U4zVBFwem9rizLfH3vH3VMF8KmgkU=;
 b=LFoDqhZ/1O8Uuff0X82b3bNjm+VkENunV3qgs+P+SMadi/yXkUQimw50FfJzES7x8KSFCkhf6lru4zmbciDOms6x2A+/HDSpI/wWmIDeaSnOBZSQT6evEi98wJUjPdZUAPn3nbcX03ApmuJogyFoJy6Q0CHJ6XswV52O+uEN84L2IWjrOn785sgOwve2UI6eBs/u1fWkyLRKbRA29fFI9guqnwidDL3JFmsiNIawc99W508o4ZJPdke3Jx7/MNLeq+zosGE+jY+ZFDqRR3jvPYzr8FS53nk5DLRY/k8XLff//AJxkxgDNMYBIUVo/Ova9qk6R3u/tBU2/dedSUJ0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ogdqHP0RCTCA7U4zVBFwem9rizLfH3vH3VMF8KmgkU=;
 b=oUXhj9+rT/Bi8iY3kngYaPtZA8P1adjFevyzs50v6HS/7MMVJWwAATA5lNotGldBJoWnl0X8nPVCG9FxtXLahXNRUjNDS5IKq2hQSJG2Pa6r19GpREMuKLcFjBQao0vMLiiu/uFNAjuoSEAswaAl3A6dzxga00Kl3RgaK2tCu2qtRIRi1Z2QskHiItFAtyvsQp41uZHgoV5UL4dBnC1Qhy3T4WjiWCjnGoXP9diV+TR1G01Cq3LJzihoxlOdzLnMJrNtBvA3IO/xD1rYT3R+AC8jyPAWE9+tMD1quOc6Wwg5LnyiylNg4WIiKO1IsQQHkM8c1cK2QqNZqIsnCGhRmQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:36 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:36 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 4/6] staging: octeon: remove typedef in struct cvmx_pko_lock_t
Date:   Mon, 28 Aug 2023 11:39:09 -0400
Message-ID: <PH7PR11MB764333C6FB367FBF1C676B43BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9Cdp1bm9Bs+rC3iGRYXD0BougBNk0+IJB29kFVQf6ZI7i3h8jqeEIIT3Dg11s2v9]
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <c305a91a1e7eb7d151e63752b56d363676a0613d.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5673a187-07d6-4a16-8044-08dba7dd1f3a
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrCV98kiscFCTYeWrQMndpe4R1jtHMQ5zoezWnsO1LCs53Oe0oWvzG6C9i8oTgoxBhCE4O2DqL+qwHRcleXJOiv8Sc47IA1ffqekmvXb4vkBsCWIu9LAg5Spm+1SNpjvBiNk1MMHSGjP2RhHWuN3VJgMWoeaOk31bzbThazBKixoLnMpY1266PnAHQqCSwoU12KTIklcAUGyOJAa9E0yF3J0kk0p7IEadioQF0wh6nbVxruaqijKNl8LtKcFIkSQCu81PTdHKdoMJXINVtfLJ9G4bgGtPxPqC3xqjJN0lfHBRwPicJDzntMqPwSIZEXdJxs4QfeZezi/YbhJxi3RmwtsphWSRfEqa9jcfXYlj6qYMw8EjJJhNdq3C0Vj37nRx+wQsQdH2jLYoaiSAtRzwo6oLnRbi91qGZaWUnHxF5LSPpbT3e2NNIHoN1l29t60WjPafmpn8PeLCUIQtwtHa08DMO76cOZ/+74kN+S6ETMn8gr5HuvDRP4li4YROVZeYeanVFuQoFCGuD51BvpTziVPsv30tiFuB9wpDuZSXvQM6EV61dzAKEAjmKbV4HidBU7ViIdUWYXiGW1S9NLPzCe+07VALBsIgsJjdrg7jpbffvKsyWBoHHOunPUQyoDzKWpVhbNV7zmRCWVqWBvHMSmw+EaRuX0JRgn0fG4Me6fdnzBXOJK5jnimG1Tpm9PIjzYMtQLUusHF1vx4QxD5pspRK+vxchnxdIHXw/kcXFej8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wKzpm7IGZ1DzVOKZ0nGbBnSsqdYIjPvIQuD1YuQ9/hYg9G2SPd9uU6OWauQiCaISGv8/uZ3rAcPDxXbTmVxL4CtMdlzr2uUVuds9HChEZ/jXQQHwC1gvwJ4pnRoCN/G6HDm+46Cr4dmYuvLTou1nhPczhHv7OMribmNV4Z+uTWVgRnXsS0DSNjy0VeCmZWNY5dxPgZ2uqfx3flJaeHp6hkBBeB4snDr3BR8ISKqAmhvyPonOSQ7Jfz8lVqK1lMwZQjTY2Ytl2pxTlYxZyEg7+4L73HFxcjNvrjgoCvAx7dWKgLZgpmMgJHD19VK1vDQIssZWrMB3f2CSyc2pBS67Ge0KEmkzKJKQkF/8DTzsjIE1qnWS4D62uZvoQOyQc81J2KHuO95exAUOj+ekTic1KOxtKDbRL7ytt2asXT+04O7SPaKD895y7khrft1K8Tom7IRcoZW5mrlSQfhLhNMzOXkD8RPK0kOdLbSGVguFmOqCbePqKSpxAOb/3Mlwy5iXtZHl9udZyqkN5kmoRHuEMpTryRBh9UjqHsw4Fw65DE4XAFP/FwSLyJf1Is+xKjh5uPXMySNp66cUtUkHCkFZnrit1ElUIvpgIcaPhde1nR+4cDqWRVJIvERiApuB5c2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdnN58QHGASzYIcB5Enn+axoZ3We763BoVe4/QVaw/wxMK4m7qKv0IIV8qc6?=
 =?us-ascii?Q?GFiadq+91mhlTrd00ckVYCuqBUkkm/cCWsx0VoVR+Y6c4u2wymGY08JF2sn/?=
 =?us-ascii?Q?ySSM7WvddOuScu1RYwrrWVKf10vVY9adL6gWxwT1f6kDVa6k371hREo1QkIC?=
 =?us-ascii?Q?ETutgL8dPU67EA3Aeykpz/Wjztu0omCyzW/EFNA1oce5jubIF8s4+nrfIzUH?=
 =?us-ascii?Q?rm4xCeyRyR+05mEqJpYbwL2xpbKc16fD3bmJHTBS4l5g2oJ8ReMn+JtFDsOx?=
 =?us-ascii?Q?LF84K62KHqy9cIUmuRPwSAI9eSKo6RVYbZu0uqtfy7q3HSUJWNRWpWSAr1zo?=
 =?us-ascii?Q?CHkKpRlSUFNHW0x8gI6yNobwm2W11LJ5NwDpSlrbqhyz1P8Rz8KaadzMHsgK?=
 =?us-ascii?Q?1g7b5j7DGlNaDXoM2X6rtljJoZnbIRD9B7NMF3tXW2L3HprWtZFh8pfLUTiG?=
 =?us-ascii?Q?XsTWEeYYguna5LEjYI2H997/p7M+AH0bmJg0mmxXK03E1MUXdtiadXO4Dmx2?=
 =?us-ascii?Q?b6JTZvXXaNmK1fvfodQ5WvVGDvO+e5CGoJMJ2wZbDURwAlORy1/IYL8XzsGb?=
 =?us-ascii?Q?woE2qS2Z8l0W8uR3T683yjSsytIKdl+vmmEwpmUw8gXnbgMKNEGerESFH0cf?=
 =?us-ascii?Q?0l0ukV7bfvHKwgyrkgOEeg+zVbZkzCBgGSUkCt16gqjBjSCiZRgljQqFv6B9?=
 =?us-ascii?Q?VxrNUbRK91+GlPyqDwCGZt3RfIiY2zOR+oGXK4AopQmD5pPzBROGTsgDZFCo?=
 =?us-ascii?Q?KDvHEqnc1KtyKumpUq/ef5Hk7cqJ8LELpARe67YQbDpBp01r9WruJOJe76Dv?=
 =?us-ascii?Q?RIDuGxwDW7/NvmcPr8GcU0i+Cs/nOMcuSdNs5FCTNlntYdDXOLKMq9b9UmY3?=
 =?us-ascii?Q?As1wAABUJy8J64+ZUG3US6JiwvE1RCPUVwsJyr1aOSO5+/cc/2ELLZtrcOr3?=
 =?us-ascii?Q?lzxDinewwxfSbDBHdTNVlYtUlSZjorqDgfpG5DGsHYl12RCoehPuLcDYbIl1?=
 =?us-ascii?Q?E/BY9gSAnYDZJ0SlBoAZzgBu6yO+SjQ5uEFpV7HgzXvmu3iYw3jTccmU5Su4?=
 =?us-ascii?Q?4O+dzkPXMz5Sb51hdLnkPx6Xd45aNoWreAmC4Kymbmo3kKdtcGxOdfvNKRAr?=
 =?us-ascii?Q?lOQvE6ENEUB29gAMHnFFexHBrk2lMGSuRfONZY8axMyO6kbXHlI7AXTKX+OP?=
 =?us-ascii?Q?4k6uQHni2N5qnx33TSjxHnO+H3b8hlZ1BJ7+q+KaRPzAiWMTg6SDBeTjTBCt?=
 =?us-ascii?Q?7qFPBlHnlhzMrA7t2s8Q5YeerkMzbVpFXm5Bj8ZlJw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5673a187-07d6-4a16-8044-08dba7dd1f3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:36.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in struct cvmx_pko_lock_t, and rename all instances to
cvmx_pko_lock

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: No change in this file
v3: No change in this file
v2: Send the patch set properly, with messages in a single thread
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

