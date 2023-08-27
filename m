Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20E778A368
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjH0X1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjH0X02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2046.outbound.protection.outlook.com [40.92.40.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521BFBC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtjx19bdAbSW1N2VaxBtenCadBZTlL11fNgd9kL8rEibZfPfIeStqi7eqpjXkY6r2xAEXuIIi6ft/ItgJ77uZHoapDCyRhu06JnS+vPH7X6D8QLrlRz8ScOfsAuYhHL5NW6C27mOO9oCapTVx+3O7KcAvcGjRjwHQq2e9s5N2/lNZrqOeYVF0cMjQACLCRzpK0BRpWjDnRYdRiwsiUDGri9tdyCjlrOepR37U+QnSdWw2k4C+WAu0GXJEjZua9++JXiFJn5Up+z5epZQkZN0y4K4lgLflbVq9RUtuBBVL5JbNEJxVKFes/wTuXcb9FNxv7cU/nzbHLMKc+YvBqKO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32pPLHM4z4zMokNGDFXUDuuy926iYl4i5rgXzOafs4k=;
 b=MKoibVxfYU6ezNBxZqzMP3N6Xcth4cqMUZRXVLF2kb2As1Q/br92Asw918agyrcmQ/tfNQruh6fHqA6BlhFaTfZWPlZNVQgjCgDByqKxEpKlymk6zp/fViIl8bsM0sHYwz+9uePBjQup1uDO2lBUQXzpCzMeXFxzLeFgezvXvCKu+/kU5Iz1QXPEuWqjlxrXylTy9A29x2qeY7sMjkbGnjSSD9VWsh2UGK06Pa8utBXyHKZgwrHg4QODFKTvWpgIq/NZVg4+5/s3KjjWP/enx9/lSG4GLWvLArmcrzWAVswFRpT3MXuMMcOY1dHaKjpRLvi7NNDFBcyFYqYmNOaAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32pPLHM4z4zMokNGDFXUDuuy926iYl4i5rgXzOafs4k=;
 b=IfsHPVNcbipcdsn2iivzDvy4PU+4xcr3bBBLF2Yo8rNrtEwBN/rPtDqT40sU1j2UyH2VIE4sjAUbM3Bhi6F58pwsVNiLX+mk69f3ssfZu5wose2hJbgRVOiXwMngevhsBow1NN5Hc53lv7H5xRT99v85BUAzL1paEHh/55J2HQEBPmPLZ78qcQ2oK3dDahpAs1GjqumidzU6W7o8s3eKmChl2N7v81EsjEr2PrNJ6w3sjWbVBeFPLDxL5m5SlxXTPV5LCSs+ZTWLElWCld2jSZ3vl3J4qszEr1XOdCnpS7XOXsdAbKlj8Rg0r11sWHCGAZiXIi3cpuG0YhXZINIogg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:24 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:24 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 3/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:53 -0400
Message-ID: <PH7PR11MB7643475899346433A2440FCDBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Lz6CHHWuYQphE4z9yEla928gtQ1f8HjDd0gmXPjVfRRRMuOQf0vx6uDEq7FtNFbO]
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <83f0e6973905abb9a96ad2b104f2cca5df4e6966.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 737dc3bd-500d-4426-ebfb-08dba75504fa
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVIBm7zJV9IEhyuacNCa8+1n6OJh+U3HhO8SO2TzY8iFY3pPYftqo9MppJyqnROHQEOiEv11pviporp76+PQV/jWetL5ClpelEOJu/AGLebeTctxeYpjpjtbEjetZFt25Oa6+YHTK2Is5I0/2cYpkpaNyYqE+JSrrgjnOPk5jwWu7f/OnQSytjF7/+7+QFsZoa3WyHrhOB+brkmsUPSJzmVZbuRoCia69vPvIhD99KRSr9P4gqKKYeVSebyUBPEnM9b1Y8H/AB3t2ifcPMsu2RbV2e74tWVxcJ3QCvvOELTiFHCBlzSOhABopnTA/D0J7ktn8gDWmw8w7fnXWwVGlboBeQPXzVPmd6me4khR/QvE7VV56FuZBzERwnFHhprxvsrVxK2oi2KGxEMPvs8FELQIT6WhRsYkr6NYRERXldJlCRYyDAQbi3EFlW54JzipkKL+cymTR9ipblCFE+np/j8oHm0voOV8++Bb8TrKQ2wOhbh5mkuJFT6/6Iaz//1TzDkvMAXGZgnfM15e70chE5H2p9UAleg4Ahb9IAtDlC2iei7E1L1pnWUCfUAS9prQ7CsqONmR4RUcL6vibxnxUx/JwfC6gNifMx4zm6kcxeyzo+MqdA4CwZ8w0yo3UDeUnrqc0QkDUa2KJ6cMnPi56wH5Gei9Km9NjrpvQFKd19RFO6Wpi6aLznHWy48qk0agFcvgbtWlOVf3kiBsEHEgnQXl1lUGSIzqxxs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwYXHJ//ronFZuxEHCck+IvJYQ+rEiy7GhkupXETHcdHUfNdLZf8w6MrtvM8Phbx3kSWd1VWmIXIJBcTlCXD/lIw/XXiWV73Cm1NLCq501pVSJWfLomyvtkMCFmL9C0Xqa2kr+Qzb/XOCJ4LCYtt3ZwS4vRkgTwstb32QhifZ/cmM3vF2GZLbxWHylFZ8e4z+l7aUySu3doK5IO9Jm0ywKBvZy7A+RlJ33pL7I3nGbucQ9Kdna4J4DOxu7y6Q1c9KdRUt3O1tJOD1BYDMxoDdoxM1z8ErYsZ/ywn+vQhD9Vjl6SXI7GNG24ltS36t5eAqRQMIYs076RcmwSOiL5V0tKgDhNrTHKjdmJ9fLa+ih/YSFego1wUd+8Gdk6qcJkK0qm+F1HF2/TD/tCzyErAmo8+t3tJmhjBR8bIe1bXi3ovu/bJOvGwNhqxVglmuHeCPFxzkeslUjVAtYf9a7FymqRxS78gsrR4rXuQAyUaQ46O6ipH8MP7DPOonqX4OdLrfO4lGlMCcjScG9qilFaab21whcmv3yxDitElrTDA11PT/mp5oQVs81+wFVrRjgsE0k80V+Pe8AXMs82lHb9QU+lfrSjuvwHZNqHDckreiT5UEhNi+jwekcwiu1vSa52R
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoHAfPvQroeSM9PncqduDCIBuh1xjCLXTS3Tau3Qv1QDuoGNwAwFreUHDA+W?=
 =?us-ascii?Q?7As5+tm0KkEVC7l7m23qQ1lb4isAaTq+pNg1HNAY2XWn11l+iLFm/7JhBeQz?=
 =?us-ascii?Q?wmx/MhMtu4uYAL7pkjVEFJl/ZDbBxxecuA2AtzWtmAvd6eMwiU9RBFZj1VCx?=
 =?us-ascii?Q?DT+ndErm11dl5TTXtyskmPANLouCG2h9ZDhfDRnwNAhDLh8eH+/uBxq/qqIv?=
 =?us-ascii?Q?4driMiR4tl5IXKNOdAGHcEaC4egZrcOyGAjhY+PikxlHUi1RiIhdrUJc4hc8?=
 =?us-ascii?Q?QtEll62NTsPNw6hLGt6R1Am5isq4kQixTxLoFWKkVVN86c10jsEOvUbY39op?=
 =?us-ascii?Q?rZgv2bShT5oldWP9F+F9JSbKNFVB2S7+R5tDL0oZVi51gj7nr4Z9QsiQYxzw?=
 =?us-ascii?Q?R5KNGD2zGITTWsfTzTTFxlR0jWQRnA1rEsXpOKK+vGrXK7Gvdc4hAO8RmtQT?=
 =?us-ascii?Q?rOSXo/CCRS+R7+rvmZBfeYbFntRjjSa54WPI6XQVXWVE1ABziOVHSQh77XXc?=
 =?us-ascii?Q?buhsJ8hbV35MKbPUJya8JtzGxpR8rhTzOcM/OKjvHlGQKNyREBWqiHgq75PU?=
 =?us-ascii?Q?z09T/1Rv3gSU7IQVQJX48A9Dfgd6oKXFwo1fvz+2tcXYr+WAXo8V6gMbzoCU?=
 =?us-ascii?Q?Y/zYtKPnCDTD+fYx9FD5/UuCWee9vW7/UOV7Y2ckEZQodznmX6dJ223bwvbg?=
 =?us-ascii?Q?nKSag/R2bm/Ij9KB8bM6RObP60WlKIeVYgCvM/xes1p0wGXDebhWQCPjzTIW?=
 =?us-ascii?Q?uNXQ2JG3zJnposbCBRzBurDo4BVvpy7bWifUQZTQrOSVfsjaO/h/oCzksgPb?=
 =?us-ascii?Q?WwNuDG+wM2zg3i5Db/Xjw+gjo6JtgIGd9VjX5BsQMyOApqiVmjAoXq3jkcyV?=
 =?us-ascii?Q?O/FOnTrkjPCXnQtVgY5qL7CurEg9+izPPwCz/sFe7cjvmrST6j29ogQ86qDp?=
 =?us-ascii?Q?J5Ce+9NbPp0SdlmDgicxEXovxwPg3MwpSXfwe8kERtInchTCVPYe5tcgAQ54?=
 =?us-ascii?Q?OiSK2Bf5GQu8a/gAqd4whVJjxMblbRDP/psTu+Cu8iRXD7Q2WaloF9rGb2j4?=
 =?us-ascii?Q?8jS6bVeDZG1IwOof+fX1MTLejWFf+BRIiEL1bSUpXRvck7slkTklhyTkfbwk?=
 =?us-ascii?Q?ue3cQp+YNXfxj6P7oADUl4L9D7ToUpW5a1WrV/YpZUZpB1aQRKSR/I/bp0LJ?=
 =?us-ascii?Q?5pQgtMNa4s88gLgWAiRXQxzC295Gd541pO/QFas/Oe0F0BrbMi22jBcArddw?=
 =?us-ascii?Q?irzqgvNRtiKBzbqvhbf6qSM8JEi/ZlF4rW3t8q7Ttg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 737dc3bd-500d-4426-ebfb-08dba75504fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:20.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
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

 drivers/staging/octeon/octeon-stubs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 0b0c609a771c..4470c985dc5d 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -233,10 +233,10 @@ enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 };
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
 typedef enum {
 	CVMX_PKO_LOCK_NONE = 0,
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,7 +1356,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
-- 
2.39.3

