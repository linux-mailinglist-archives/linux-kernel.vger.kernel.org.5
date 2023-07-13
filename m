Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31617516E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjGMDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjGMDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:47:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF9199E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYlD1RM9xMPNhh++MIu/z0aLXcVCt00qlou2ep/wgKAGgR4PwsSwLgfw8bHmcppQC0GmSpCnVTVweWL5iGjWD8s7cYFgYeIvjmGn+Nfwdco3Cx6MQTwpSk/REj3cd4+URAwa2lOI3usJpNXw4fTyizi7QgQUuHtGig5UWzgmoUP7Xb+J+LKviYXd2bFmas9QRI3YUivIOYILbXGwC6wJ5ijUfTRHzAAI877y9f4veA4uCNL6NKD+aq4Ces6RCFfOT88vXPmWIeMn/CsKNVmhKkIYTb4P610NwQ4R+WXIqinYlW/b0QG+2T158wwlYv52jTrXw2UlJNf7xD8MUueCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/JW1zu886Vh1eVs/jekSXLSJFl47Myn7QWOsZl8+ZM=;
 b=UF4mpGbHMQoRvSFr+vPF7+JeHI1aWJBlwgO5ur1wWE4shVLQ+RgO5EE6KEmVdpB3BStx4Rvd2ac+v31u8ZffrWLY+pgsGQMCjjGnWiF9M02YR3HseT59IKc5wSLm7ovJ2pGTcAULa3skK2EHjdxlXKEaUeOWiUK6eupt3w6/F5cFRdIJCF4IvzubvFS1i8iKqsl9xjoOquMsbwrW0GMyPpCAMBfv8JhdLQ1eIqksXg3jhdO0H8RQR/Q5mqlyGXQQYcU6q3GU8NyohSOZpLUMgquJsTmjOtBc4RADBVZTiRCofnB2HQ82w1u4m52ps1cThYlENh1em6SfXnTovz2v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/JW1zu886Vh1eVs/jekSXLSJFl47Myn7QWOsZl8+ZM=;
 b=EfVw4gOWm1ETk326iW9qWrJghyNyQgAPWexaJeM4t/PFx7QkCNCzDC+KyrUCSD6/c6S313o/UhZ3ftpRiLQsfF/LwJrMYqDc9cflaI50b3U5WIxZNbBRl/b3SIS3nXoHAgrx7L3Rx71Eht3+t38fOlwekhTlFztYX0crfP7y4ruhB598X7gN5e3iLpTqdgdHcYTLL5SvJhZDLQFuvTRobXo2uKsNWK9Q9G/YMiL8Q5DLwgiRphEs2hBTsu5UYTaXgx1lQDvGhCb+S+efhSjNh168hnypBiFYn0DwLeE8HT80bFKyImlrMgUJ2m848myu/VGfwIdyO/1WygH0XXEGVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5236.apcprd06.prod.outlook.com (2603:1096:400:205::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Thu, 13 Jul 2023 03:47:37 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 03:47:37 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] dtivers: ntb: fix parameter check in perf_setup_dbgfs()
Date:   Thu, 13 Jul 2023 11:47:27 +0800
Message-Id: <20230713034728.2157-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c4fd29-04bc-4fb9-cd0c-08db8353e5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsED/IO3UqQ4lOO0YCCCqlJb7ERBd4Cz/MVG152pEnCn+JAMU0ZO8OHTVnriCO9LU6gmGTMYGZhUIR3smS38/oleiEggHHQTEEbb4Ze4WrEPa97edFT43Ad/W5rmDUcyEtfHBMy19xyrHQycNNFX9JjOou7ahzEFXuptuft/hxOV+kyIJx34QugrQDbFM2Mi7GzzJnhXyi9OTVo3aj47Mc+lXuU1ANCecSxlbgGnUCGbXBl8klhOVjwf+VPI/ZFfhoh4SIZhrCx88cc1AmfOPiHuryk5Gp0VeJh4uwr0245Jw/UIh78PRViEF+OGwcl/dNbmA1iIdwVEyrIjnY5JY8jn12LRY0dkCeoP2IoP7kQvzV/JNaYYtBBBQQIjSXMNZ/Al1BBpEtTg2SbCSp0CSsxysBq/fpsQmHyIi8aln+cdA4BztaZtywrMFcl1f/IKEM2moAxPg7NEPCQLyBrNnENlEPKuRx40iRkxCJV3NmfBMuoson5CgmdMGSlOqUO/k1auTNxrLeUKUzy/o5MD2q5xjpCAQLIGf3o5VHD+aF+i4Y23wPcWIx4pqd7CeTXFSJIPyidzWLX+KK8z8HXAiCzBJRBkBsNNhmNWXR8Us22sukfRSS0Lfq5BCO4/uivp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(110136005)(478600001)(6486002)(52116002)(6666004)(36756003)(83380400001)(2616005)(86362001)(4744005)(2906002)(66946007)(186003)(1076003)(107886003)(6506007)(6512007)(38350700002)(8676002)(26005)(38100700002)(316002)(66476007)(4326008)(5660300002)(41300700001)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMghlaHCWSTYRRYUdMVFYG99P07RP4j7goJedz/nXYf7ptVQabdzEx7gmRXU?=
 =?us-ascii?Q?viJ99QPq40JbGlfl2UYUQkPNB5p4KCKLlE/zw2aV/z0LIc+rxS8ClDooZSnk?=
 =?us-ascii?Q?kTG44ZF7TMdGuZmi3Aje6ltBg8ZbOrxM4oJ5CnQPfOs15gpUOc+Rwo5oEDyP?=
 =?us-ascii?Q?pU0XLqkX3bNjqyQmT4fVkAtg6bF6g+O65YWwhtefSB6EFZT2xedaM2lVulAj?=
 =?us-ascii?Q?WmVpP8R8E9s4EZDtCNVoFsOatFYE+16uLQ4z7stQkYb6ASqC1IahwF7yqFDX?=
 =?us-ascii?Q?M8vfC24LI1yxaL6BxCznm+AD/DGq1UvePMKavyd7tLRxUzLpmAf2MuQ/ANNQ?=
 =?us-ascii?Q?199n55pPxSH2w2lUDzYtHRVtUTNCBx0+MSZaphKqlAvbJbudIX2uZMYZV2st?=
 =?us-ascii?Q?U3nKHF7METaXV0Qf4nM9TM7dh2frri5+lXw9uwccOpEL2Q3hW9YG+EWYowRp?=
 =?us-ascii?Q?kd3vuO0D+4AW3iglY4vCSbJONmRUfsZJKbcw2X2Jxq5UaDpmV2KyL+hT8uLx?=
 =?us-ascii?Q?VSQ1CMu0X/GsNl95mJ89wjb7E6PGZRkCX5KSGoULZARYZI99BswXvIE0uRm6?=
 =?us-ascii?Q?U3jXWr22JQ0ECk/pkMRGTHu8Qf2zh5vj+ZZq+zJxhWQNZTYtETQiY+Wm6YGV?=
 =?us-ascii?Q?KTOcYhOn9/0vtQsOeu93q96U947iFLCKnI8xW/qOfpZy/G2yis6b1PEwsK5O?=
 =?us-ascii?Q?vAulyoKQLe227idETKDa/IcytKcUE6rs93e58Wpq4JWG1EN9vIN343snPXS/?=
 =?us-ascii?Q?bE68kCEh32LERmh2/p1/7bLWB4RA5qXmADfE6qWkTBs/xd65pY3jt69wGP9h?=
 =?us-ascii?Q?xqwHmIBCk6tc/5kX4vzbXHaJQHAbmtAToYp9sg2j13E/djkJ/w4bdJ+QWooK?=
 =?us-ascii?Q?GEDqPDzeQETG/kWIkAMMrCSqqth7qOgVlRCpG7F009GcBqhJ0f/0/Z8algnW?=
 =?us-ascii?Q?/kZIVfabj49dI0rrY/j6rGH3p6/8M+tF6AeXqWQZczZfu3mIyTwoe5rI9MCo?=
 =?us-ascii?Q?Y4PyPo2QacVojMkz2W1T+web/L+PKy2V5LFbim55Tmjn7Ub0f0fNUmqKGQGf?=
 =?us-ascii?Q?uY5dhmdubx4Xct0FXMmBhG8l3LwySIyO2kQdW1XqVrj1c3HxT9GZCH2ULQYZ?=
 =?us-ascii?Q?eHajxp8xt/rgM7/U+M+zKop0hoE2YKY66jIE6cQGji7f12D3NcpMif1ixz0S?=
 =?us-ascii?Q?ZS6xoorW7TIfsTPJwMIBj/7afrYCBfuAZVtCTWjV9qeA6LI4AJ9061MTZWFf?=
 =?us-ascii?Q?7EELRCxMyBZ5xc/EZg13BqPCwL0xm+w7JJJnzZ0UsDEcRC6We0ewqyDDiwUi?=
 =?us-ascii?Q?LZyoSvTFMmDHwNAzY7DhEISG36EEFtP3Dc4fgcsVX8VdvJWHZDvSrGO561xH?=
 =?us-ascii?Q?voWKp0lUtERLiXcKokQKGpWJNGOlnAX1NvOnO6yRCi4vFEO/DP7r0rV80YsT?=
 =?us-ascii?Q?6tuAGUbVYqoGkwGIwYKoTt7VJEkEj/n4lgQ1/6LacKMqHvC1X91e6EQqTn51?=
 =?us-ascii?Q?Vpl0Meej4nT5Ctc1wM/jzWa6HvTh1GCYh9TzDtF2+4cwQImbET9AmoAWoGuO?=
 =?us-ascii?Q?thvP8Trjf4Xl/GsLYA8RPTQwxPl11OQrxOCdSxDn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c4fd29-04bc-4fb9-cd0c-08db8353e5e1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 03:47:36.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2zUcf3wLEZGquqrR6Zcj1DYKrq/+WwgPSQD8x78m1LTdsZguq5/s0dg7Z3ncO95RV4f7Ub4tDgMMOMGEoAnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in perf_setup_dbgfs().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 65e1e5cf1..553f1f46b 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1355,7 +1355,7 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	struct pci_dev *pdev = perf->ntb->pdev;
 
 	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
-	if (!perf->dbgfs_dir) {
+	if (IS_ERR(perf->dbgfs_dir)) {
 		dev_warn(&perf->ntb->dev, "DebugFS unsupported\n");
 		return;
 	}
-- 
2.39.0

