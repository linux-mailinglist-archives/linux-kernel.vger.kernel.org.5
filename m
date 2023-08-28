Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9357B78B222
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjH1Nkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjH1NkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2015.outbound.protection.outlook.com [40.92.19.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767689C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjZc8PjnoYMWoP7GtYe6TohHtmaxeQBYWM7utOHobE8OTaUSSzW1S/35TdDfTnitoQWmDucAN/WveAYbEkYP71a1Kkg+I4hrVc5ywZ0jvpgHN+bUobpk6fGig2z0JctK3Bn3UTwm6WhpB6vMj90FMxg9r6dk5jeTt4eKZaAGorV7Ltdxz1gHzZ+Zm2jF3tznVaJFFyaIQuXv12Bn7zH8fu59XP91d8z7J1eRr+OINK8g0Ivt/HrQiuwLMHRpIKCfpBT16JJDfzyIIdlEZ46LdXd6qMBQesK+B+5RGILj5hjkEiEnKIHalW102xkB6Ep+wqhBy05jwRCpTanPiBRf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzzDD9PJs9CWPFC2sJBj2WmWVoIJHGou8OOE6qLhRJs=;
 b=PN+cwwZQMcEGXkk38LBTA8SpSqZeOiiyxWMW/mVfRN2WICBDpMvzLDYSxZOWv0m0h+MEn1TWem/DBafrErLF+jeAwC6P+xHkYREDRFfAJl4eCKxHQu/X5a/CqxuGRTDnMX2yMACHGBrJdWgSULu+x70OXNA++nzgA3HKvrgFytlieDMNaM870yi/R+/2I9zhiiVxvDD3E4WsCrxHtHUAU0CDy5yqVs5gpcHfuMkKi1Sm4+rB5ZDLnXXS8AiN/2oa4BFZVhp+gGt6Mp8BDw5Vk+RkA+jFdwi8s0lXPtywI5q0zbwRboHDOtJz8u+nZ8w5GRtDlVIGbPqUl+63yuly+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzzDD9PJs9CWPFC2sJBj2WmWVoIJHGou8OOE6qLhRJs=;
 b=OVRbJ6uSa/jL9Bud7OrtdvtorVcam1LFYqBqsiEAgR3uePborJt4RM9X5p4MQzvGbYXCTSweWWIeO+daDy7P0Q6zsUBtcIPODbfoIQkhAivuNkHteyoleDuAXqkoeV7dXvhjUzmsD0p3Jj29uPn+pW1cUOvsRy6SanryP96TN2nkUMbaKncBIcCD5oUvczL/wLcv4BNj6qXYxWnjn2VFK6hqfQaRUARARA/GVw16ziTYqVMgTxJ9pN/hzuITRL+JxjN0OXNiSvFCBbfeiiYspBFJjx5b/7i2+/Gm/u8ruEg5gutS8w+MGc8oWW/iZEvQPKOyjosAr+wNtbPZNtVw4Q==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 13:40:11 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:10 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 3/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:16 -0400
Message-ID: <PH7PR11MB76431FC8E929BD06880DD283BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GeU9u5AMhtXk/NnMM9K/Mlko/DXw0zXAvaaXEzo0P2jK5Fb4/eROyWr29/9OfS11]
X-ClientProxiedBy: BL0PR0102CA0012.prod.exchangelabs.com
 (2603:10b6:207:18::25) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <83f0e6973905abb9a96ad2b104f2cca5df4e6966.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaefd48-76a3-4aff-f6b8-08dba7cc4c8d
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrrErctzovFMCtbzamN+7O1XMMgwu1We5M2W9DewkOa9rAru4bUlqeye/pu1s7Nibp8rfGa2kYvEn2BMURIkDsY6rtyxxcvYR7cJGKOhadCOc9TiMOO5RQYTrKpE8MMwJZmtywoWn2XNN0W77SghvW4al4GNDiBZRqK33h54ja0WSF1pNaTouqdDedz2FVSKBRrsQpOeCgQxUNcIgfJO4oNGNPWVwjB0sEnjdFNaEb2l5xzqG9smtH+FXccFAgGXHJi8TUfX1iJDw5yLojFA6qgF6e2YBc5Xoh9v8MJp0sje8eTgtnCYfBwPwud565v6vhtVaxDVQKWopQULG67UMvq9RE49uSf5HLDMXS5n7OQPbgdGAnYjX+lORXGIsZeinC/buunAkE7kYyCUO3QHn3v9wtkaAv+vLPKX5eK9sPzTxJrIT6dQwbyK3Luf0NrYirhlYLmwqXiY+7VyD4nI7E+YQ0Ozv6cvBd72Ho+8u2chByl/EuvbkqrOkSdsXi+DcrzE0E/5sr29M5GpA4QQF7MWj7FIMiurI3SK0KuTeVUyRH4PFoALp8VdJLyqW7QjRCP9Z/wtby34R1Ma95KivcpnSI7pzFHg8Vzx4bnBv5Jxz+VKnx/qyI23AOtBv28a3RmzjphbhJGBxJnmAPi2vUzQoNE+lqtiXJk9ovd4o9BC9w3QUNlcQu7uvZNIPkpujuMO8n9IPGiPOzokF9x/53cHVy4qE0r/FckrKFeQe1GLs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNk7OedpzsMrPIATmzAlV8RfnPTWjU78SMdP0B/eQvQ86GJSbYzpkVR1T4yRKm3hDtsuN8x5k3WYxp8COqHUoKRa6vEd1ryRFxPXWPK7WCxDPh7+ftZ4n7ySxuncxOrjzMs7agc/MTZ90mj8kWfDPuTd2J+9ZNSjmiWWUcEordSE6YxlMHbsFpiNd9BcxzHgTKe9gOI/gC7uL05GRsvop0PQGWhYtjV4B0qyntmUfSBprv3ebI0asZI/sua64qiyFZ13Qc9pbHxD1/qVhVPuAnrkTKCk+lbFbiQGtBTnc+I7prDlcm8EExM2oCOJZeu5tdzD+hkSW6x8mZ79vljhWPtcbxcD6GeHcpo9zWsghTqpG9gzJR5QPFB64GYclECMZZMiatK7EvNNIcKYXyVscszbEPYAB5IF7Eauzh+YzqrplJdTmKVps/oZwmF/SsF1Jdub5QyZ5I5Py/kJfBvGxXyTtn9nohU8hdqbt4EjaYG2v7U+OrlTS+1FmQfbZrWwijkQ7PulSfYJ/1C78b0zqkyfqbrj01ldvvG1V4Bdz47KD+ht2wec/BsMxvB2E8Nnkv7fP80CpWJiZZN9de+BxPpE81AOoSvKvZ7krCED24ouWe+oelQ89yqvhsns3D+H
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZPoncLRvE/hNDR/X14eW51qOnxesjI5X0DqfogQcn/kLLo8f8Ul7hxldgZZ?=
 =?us-ascii?Q?DNblRo8DmFQd8PZC0tE8RxihrQjp6jnFR+NacWGmg3zYBLXIWOiC/rDewuQg?=
 =?us-ascii?Q?LLTmBmJKg9SC2K3UBIU2alGTDUqUDKr1cASAZodZHxJYGPFWf58DWEkzN5Vl?=
 =?us-ascii?Q?zw3932l/KqSxofIT3y7C3tyW90njfxrSgOZhhJHNPdzh/TZb3+blqu2+KcL7?=
 =?us-ascii?Q?0AIAOO1oMihuKG2wAR+Llw0MZ5Ub8OP/QO/B7CVtxdd3Sxo0wZHVmTu3udMs?=
 =?us-ascii?Q?611s5zcC3YIxA23EKTP7j0ZcqK1/HC0Q+h+kYfELZVrjM0Drx8F9nl/XH9JT?=
 =?us-ascii?Q?OEBIsleTfbN3Ik7Xkx+q8S6zBAFf0/DTRWj8IQYRx02GGQjDMCsTB2SxMWW5?=
 =?us-ascii?Q?699mpH/9MolF+IslIFY8/+Mzg2bxaCK9sWs9vw8F3LIvyYvwsW1aw3j5/bWR?=
 =?us-ascii?Q?fO8P5H0ao8c6CRnMS3HA2LrSKE3yG8uYK2hoN1Lq/qNuaGCIk0suQAMmcBR7?=
 =?us-ascii?Q?qx8NOrniCJVXWCT85R6mGC0Tge7t5LSkSSwlhEh1VCSW47NDIli30epjhtRH?=
 =?us-ascii?Q?8+SYpzBqK0o/QUTFG/qkxOgCZyLJt+LSSDISIL6HDoz832xvP8p8G8Crxg4k?=
 =?us-ascii?Q?JdnrSP0tpBxPUnZ4622uL0KeWLaCUIFPoIEDWnnlK0yfNcW3VM5pCimhsmpr?=
 =?us-ascii?Q?IgzPeIDTaUFp59QVic2vmT/+JQz/6+Y7SgSf40ka1h+Qal22LvmpVlqJGa5Z?=
 =?us-ascii?Q?CgNgwjEleNQnhYVQSJcrEj+VaIKAyNbGGRc9/ZjSf/mfIUEKBx29CcPIclVD?=
 =?us-ascii?Q?znsvFm/THM8dl/a9tJnMErfh3iKdwqwp0+9dGhYqblFELOny/4EZidgisShU?=
 =?us-ascii?Q?REBGRYsDE8sbdfTPtwznVK2121QLf7g3/0Vl/4O1ipkj5LI5l9HzZ8sB5+7e?=
 =?us-ascii?Q?cFxtH8l+jiKHtD2VD/Y0wYahkvKhd01uXxOHnpc4sfEHCO9DjJYfnzYAb2wv?=
 =?us-ascii?Q?xe62GXKCVQKW5vLF/iugfnt5E29ehLt0mB01/3QtbuqFrcmbigCgCFEP4F3Y?=
 =?us-ascii?Q?1F8kB1CzBP1AEADnyaWOUI0BEp4as9n3N82nrSwtE+93+My6oZ50WGoKBs5b?=
 =?us-ascii?Q?byXP1LO/hTKqVf8b+/h4sJl9VHdWFyEOgq2JKLjUI+N2sFPMqgjJ967B+wQE?=
 =?us-ascii?Q?3AfDOZ6axd95xz6lgXyiZ3R++cq5N3FE9ILdyewHOZVWUtBKxCynNT3l3+aO?=
 =?us-ascii?Q?6ALptiCnv3sO54s9s3MRxQtd/wxHFLC02AXyWJVDkA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaefd48-76a3-4aff-f6b8-08dba7cc4c8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:10.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
v3: Fixed a bug where I forgot to change all instances of a struct
v4: Actually fix that bug (this is my first patch, give me a break)

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

