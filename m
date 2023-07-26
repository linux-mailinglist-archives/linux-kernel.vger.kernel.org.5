Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D976355C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjGZLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjGZLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716230D6;
        Wed, 26 Jul 2023 04:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyDKlGEUgMS6IJOFvOl905EZ02aj0f+gCVMFPTPPQyrtF2jPLltdXhIGn0pKzjIJzb+f7piFe3dCN5fVvd08Z9hXiVaXR6CUjmuEvwpu3jpdOy/tgFLipmQpILNBYSzYrL8J1yZ8T8cek7cZjLNWxV/7l2eS5XIquY3T0ed9kMgvFCfPTjaU7qtPL2gdGF+8iOl8qZpN3ByVKomhSwnd7NKseVFWIiHzNn6F2+Uy/fN+n3UzmMTTM7fZ0mcQun+eEnw4itkwEyMnxDFLnfA8qyuf1yfQXv+XvR6xmSmyVAdL7lwwiPds4MC0+9kMaB8ZB7umHYvrgeQcMv+TTjZ9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UmBg57MQIr5hyrMZJTzcboQ9sMxMX2/pgWvrf948Kk=;
 b=OeJqVSC1/iL6TjXAX2k9yP9AniILhKeh/cVNkFhJGhz4GxUhCB5p3uvuFJwqy0yy8t5nyMcKQQ9J73C+V6TGHn+sn65mXBE/ABD6DvpzQW86Vm0Ajs17fJ/dk9q7goVHO1d+qehx+dRbvh7HFmXSJ31d0NO0xYloCN2OaOqE2OKs1gknfga/7Rgd6Vl5n2vDxY9A1pN5FnkbhP77arPgtdndVIWDJuiY82lqbUVYAklo4Ll49SnCdUtHc4Tn4ZAvwwLLDgGdsclym+Yy8XXktKpmhBnCp7DLu2Q1CYB987qjpK4RkGsAidvYFgq3+ahiElBuFP+cLIOmkF7hpYpDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UmBg57MQIr5hyrMZJTzcboQ9sMxMX2/pgWvrf948Kk=;
 b=QuFXx5XcT1FWStqUMqhzOuSSgPvBwRFNfC48x+HNaFDeFYv603bowC0cWNzPXSVostrKlCOV85DOyIMPmETpn33NPmE9arzKC6fHRSvduo5jBBOcHUhOKbHbgFPMxdY/kkLjBLhEE3P03osGqN8KedL0rGbcsUCUu7Se8oA/JRsIqs6SpE+w5ADpMs63nDrNGO9qvk0nysRN9f8dgaBTOQODF1ucmwBqZaAS/lYf3wrzonRYlFF5ocEZMEeoTbUmM2x0LM6S0ZT1oiaYB0VnQYhFnk1DFwp82t3MQFQ0xf2gVci7q9NBMtOVlqMy0ygASYwWSiRQDsy6Zo/kq3iZug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] usb: ehci-fsl: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:07 +0800
Message-Id: <20230726113816.888-21-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f04a105-e1b3-4940-abd0-08db8dcce6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCoSpqbUDo+3gB9dcoI1xSLJ/j2yq8wdXSHEqSrxyKalYvgkcsik/MfQGBmWlrimZ+P+9F9uV6IVAoLqB+MkYJrqF/AiLuU09QavT4BeDGDvyIXS/fmec92C3IyIVXjEvM0mlmAXJPCvEVa1mio3Y3/NAGC6SynijjrbtM6cU+vwOPGeDrU8kGfehsXP9Mc82sAG/EehJOtUG/aSoYSRatPxG6iT/zSrkW/ugDmVMzREqGfW2LsykasOLJGNYJTujhB+7Ef3QEbgOFSFq43M5IAMiZScR/fanDyE6z8rbc0mNfuDKgfDxgngMHPTG8luT3XY96Uoyqi6HFPLRLaIk2QD0uQbt8aTozPH+KnMavkSMnK3LsW7gHPEq8b/NHarzjutT+wwG+lqWlrCl4IQZjsP0soSsQgEYuiEv0hLGZzoyiDlPj6vqCuTvQl+pgUrOoB/nBD7CiBCwq9bMcRcu794EL+DT+hVqR+Ar8sgavR6oNBsFSoIwTPAo4vmexGEkgq5vaBBSnMGEuPeuFpnt5QxVwR8gCNcpC4wqOmsmhnusCxrzYt52mPOeLw2xOt2yp5yrf6Fbo5LAWRa0jRnkV7j6nKevkjFvIl4g6RBOAjhBxorFL5wQa9gYzP3qkFt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ch3agO31shaC4c5UrxPq1NdTfoFj34jAREQaKj9S7/P2iw9SapLTxzut2vV0?=
 =?us-ascii?Q?BD2w2dKzvAQ+Isn31VA6d+05WB3dY8x/heIrMyNv4UG1uhPWeTownqFIrRST?=
 =?us-ascii?Q?hMzpmW+PeKgVKxlbVWKb/4ulrlvFHboj0yju1a+vNVta+TLn3nureS7CT9IS?=
 =?us-ascii?Q?bZ34rtsmoaV9R/qCoJzWfiI+QWGuQiPjxxLdQP+WwbwJnXftBLQOqUbTtq7N?=
 =?us-ascii?Q?boMC4sSecocLP/pZaYzea1LlwVTJ8piHR2+mgLQnjI15N38dnGnk5HUMok+J?=
 =?us-ascii?Q?burHSoXaMwTt5Xj6iyQdUhv0rYZweje3g6CFGwCzfuU6IYqrsuIsM76kLaC0?=
 =?us-ascii?Q?rCrUmGCLDH3+d4pAkKg/ADZYboBgjCpHIIZ1pJlXzZz0nheimQKooipZ2/Ui?=
 =?us-ascii?Q?2t+NncENyXaljI6hqSG53mOzHL+vwkPC/gT26rPlj8KVnwWSwiF3aX7TpNYe?=
 =?us-ascii?Q?5Svx1I8yY10wUt86T8i/aBgkPnSo1bSTi34pYrcaFr3Bhtmfi7okJAD+YpSj?=
 =?us-ascii?Q?ercNLgRg+iCoTs8mEBSlbcrP+H9o5MIdJGZYhdMOZOsRhUwOo9RiRc0wBUUn?=
 =?us-ascii?Q?/FEsaGGRwb1BYWWG/zXxgt6vFmMSih2wddZrEr4WDgciT28swnlbgnBl3Gng?=
 =?us-ascii?Q?4zfF7FgSXyEL58DLUCCclf8cW3Qx1NOaSLGaHR34JJK9lD1+dKcwkGlnvagY?=
 =?us-ascii?Q?g2QQGT7lCxSZHZR15UALTkuw8GpNsjPNi3lGjMp8ducKL7Mn9SOYwPuLLolC?=
 =?us-ascii?Q?l1Cu322wCX1AhAAeuwjYszk20NeXi2wH34HKrdzun7qkOFphKrCCWxfwuVl2?=
 =?us-ascii?Q?NnZTbj/x0S1dKexKwh2AiWOuynYQx6XRH5tLRZ7iWtjKiw6SD3izDJKPCJeX?=
 =?us-ascii?Q?XOtndaIct1Y8tIrC5PETtq0rPUoljROB/daMpZZRMUXpYv4P9vDV/XkzxB0R?=
 =?us-ascii?Q?T6ImYBe2fpQ3Hxcwa++M94gPx5weNBpdAPzrz9f208iETlCly/nrUpsMampn?=
 =?us-ascii?Q?RfA5O+Tate1VkTDPp1kOI0ZPqOPBH5yILpewxjLSYZMQuUO+Z9no1j4wd8nA?=
 =?us-ascii?Q?wKm7B2iTlWCZ09OC0SFB0D4bQTRiJeekv4GhxmvtkCrEbD/rZVCjC/3Mnj6v?=
 =?us-ascii?Q?DGzi+3bNGTqTIfb6Sk+HomKylQj6E07xQwNhRzOmzho42n79Vofgjc9C3XSt?=
 =?us-ascii?Q?S9KRULvq82x2vxZEauH6FZ9sxs7SJn/+pS136RlxfDKJvMWIAe/F8DsdX8tW?=
 =?us-ascii?Q?lB7QFulb5bkyia2csryC32CJbVDo8ixkNeIM1tuixE4+cMMAyqaBPsceRt3f?=
 =?us-ascii?Q?FpUrPoBVpnEKMdJnYGPsoW+ziMfVzLq58AxsYOvEJgZFDjcyU/v2imToHg2n?=
 =?us-ascii?Q?215MQe22P7tGGm1ZW55F+77GT9B77Y+fEm2o92fgJqqn5ZE0omzoMWcp9PCm?=
 =?us-ascii?Q?WM59QQ7h6GVVxNZYoqV3/1ceXR6KUzHeRiaLl13EPD9C7iyCn0rP0tpYFYY9?=
 =?us-ascii?Q?4JmgobbpKoX+XB1f8O1ttSir6mJUutq91niuIeerwiwpCX//+7JxB3Xs7m5C?=
 =?us-ascii?Q?tu7BjId9oEq/u+hHQrnZ/NLcsIeDNsw3/Ohv4MTG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f04a105-e1b3-4940-abd0-08db8dcce6cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:59.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUR3Xs7skPpt57Mf5PsyWECsZ0b8/B+Am2deYY4brhpXLjoq+h9MyCcZexjB/X7Vu6dpBI0fu1M4R7HKrZxHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ehci-fsl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 81d60a695510..0ed715af54ae 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -87,8 +87,7 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto err2;
-- 
2.39.0

