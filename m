Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCEA76762E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjG1TRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjG1TRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:17:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A61BC3;
        Fri, 28 Jul 2023 12:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihGapfX9wcye6KVO4cbK3Hk/L0KjzirDK8KDOVDs51aURrvF3k5wo+dPthqcaiE3FjCuvV+1o0nJDU6RxSjV/U8f3utLhOxTR1OOJk6PmhkfHvGpB8Vm982WUkLuOMMBanniOo2bay1eQsHZDGPGQoKNL3nXgqGqlJFNj5ZI/7Sc36UKyYR4qCL5+ILZuZFPGYcQlsCD97ibp1gaKxiEFqaM4y/HoNhx1eClC/trOEB7lTpmL+CfPEgbXY0vbtXy+PUhL/5rwHVk0/gNuIWlLmkp0rzQlzhGybAS1v9Vd+sDJce+vxy1V9cXLOyEMtfsMMuXbXUhExtGiSqM5k85yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF8cH7h0zxTCn9f4tWndfwbztSyDBosF6HtbX1tUZ8w=;
 b=goXiWkfMRxjhf0u1MQilzn8nAodZxLTDyWRb9A6YSFIB4szMlUmNiWXEJlQurHzpSeO1OMquD/DIzdTzmcxnjFRbJ3B5IOspdubYucbe8nhluvVswOl/NfCmDtS4RetqtfGDS6uaE7K+TbUmTkZSNFdRgGCqd2TIxU2xakwuLrSNEUgtwQgpY4I2QWvM+aVutWcvqF3L1pzEUeo+MJLduX6WQl0kVG8DDdCspxYC/3Cj+PGYLgL1W4+weUs6sFTwImtZYLlofaKu/A2fai1g6FMFU6lvHOdZoXBTf7q36RptPUhdoPFR+JUqw83nmJ16hLEzdQlL/WIJjPsN9w+NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sightlineapplications.com; dmarc=pass action=none
 header.from=sightlineapplications.com; dkim=pass
 header.d=sightlineapplications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sightlineapplications.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF8cH7h0zxTCn9f4tWndfwbztSyDBosF6HtbX1tUZ8w=;
 b=D4uyLP84HQaKRcVeFeaybaihJvPdm7PRGZPNj0AmXACYDh2Rc6rbwXXL9GU123CUnkierMIzpa2HigBd+vTToiUIoHjm3/JukAUgYpu+u8uMTDFdAX1xA0pIb3WmRMvxFZG8TtrirXcVfFKLMx83TkKfSfOJaGJwVLLyhUYFL3ne8KRhryWXHVlP6/2Oek4/MDRpX+tU57rbJESjAydxGa3p7jqEtLDaY+zAqW/n5SduLJGHTgFLsrpg7WZp9FPFkwjdh43nUNTPcahGZQRmLvsCkCJL4rDXHY61IEXzkxO7+iDcbPBAeU28Yedj4aPMsS8UdGqNEAUc9MVkWEWT3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sightlineapplications.com;
Received: from SN4PR18MB4918.namprd18.prod.outlook.com (2603:10b6:806:215::8)
 by SA0PR18MB5256.namprd18.prod.outlook.com (2603:10b6:806:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:17:37 +0000
Received: from SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b]) by SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:17:37 +0000
From:   Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Date:   Fri, 28 Jul 2023 12:14:23 -0700
Message-Id: <20230728191423.13837-1-patrick.whewell@sightlineapplications.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0109.namprd12.prod.outlook.com
 (2603:10b6:802:21::44) To SN4PR18MB4918.namprd18.prod.outlook.com
 (2603:10b6:806:215::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR18MB4918:EE_|SA0PR18MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae92ae8-c4fc-4aba-9c57-08db8f9f4dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWAFh2hpSMA2nu4V+ti1aM+mklKauG01Giu35E5HF3I6v00rXx9rxKy9YiqAyci239YKEnvVI2qWiW9EVczUgMQwB/1TOcdM/G9z1QM1OwEFQ9lpd1JbzYZW66SaqKZViiVaxkb30Zvj5ZFqcU+e9ope/XhoPF5uE2fchIqEdRr9Krw+EDDwNt8JoY445rG0eLZdPxblsA01fkt5bdlssYuDeAI/NuGasdwMI0cLztfFQ5jvH8buaJezkDq6YZQnzsHRO1HkWnji+0CvWKL96QBwqBez+hv/V9YIgmLIGdzocx4PCARgwu/R3QUmlD8WronJJdxD0C88bYXSr0xfpKKixuhQ26esDSWpjRNUWDP5QEFHJ3CZp/VO+AvqAGjj7T/FVWe9A1WxYfHWlPgj6nK8GA4vKrJxPuCKFWYK0CpVh0Yev6qMXFnSo2P8E7s18GFQuSReNcamaZYG8jJLlOTq2bNvWQQLxdxpJOKxTxRezARpxlOLx+F77JDVrK6cg1caUSbLMiRsGd3lDT6fOg1Xq3rE+sBCoJHUTKmBMuVCVATVEiSLZSmVspsoJ0ZWpXy7u3y0w9+mABEK9PorOjXbjwzPlwFsgX2tWRskZr5dw4dyKYRcftwUFfcjfLKxeK297Ad1+1s4y/F1S1IoCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR18MB4918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39840400004)(346002)(109986019)(451199021)(186003)(1076003)(2616005)(26005)(52116002)(41300700001)(6506007)(66476007)(66556008)(5660300002)(4326008)(83380400001)(7416002)(8936002)(8676002)(44832011)(316002)(66946007)(6512007)(6666004)(6486002)(478600001)(54906003)(38350700002)(4744005)(2906002)(38100700002)(36756003)(86362001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2enoQfdk7krpmuPo+NpIlLjVO271Wo9BSM3hF+8p2XKiomouv0bTz47OGzc?=
 =?us-ascii?Q?1S0C6fnbLCPGzDlMqzt33P/OvM0nQz29ZW2CYGvhQQNmSmvP4g5LLDFwM7H9?=
 =?us-ascii?Q?0vjaHh7UM93jzX2Cpj8khfM+RMqxVU+y0H9wU+jQTUWsE5miWVKIWAqDuVLO?=
 =?us-ascii?Q?TEbdbq9o45e18vHUwk1e3lCDlKoYBMBeH2vRm6rXbA9uy8wZDOG5B7ELDrdD?=
 =?us-ascii?Q?rsymEPCEXgiAaQqEZOlkny/OGbs4GY2LBv1juy3flOVZ+RQDpAdgwvRuzlZi?=
 =?us-ascii?Q?vGD6FPuMZiLxKhxNdAU6lm21wjznYn9xWdUP7w8+LbVRNJKxAl2Vlbut2kS9?=
 =?us-ascii?Q?1vtBWMWGNN79sGcZnCYTMyhE080YGQwmTsxWfSQj4V965NjSCjhbN8fkZ4mC?=
 =?us-ascii?Q?h6eGIsGbfLPQlA+nINzVcl7Y96q+eXNDAmjtNZMNN6upN68kh2grLolPKZgI?=
 =?us-ascii?Q?D/D3JuUWoxe7k/vrE6k4OkWTcgiW8ltipwFlEocTo+P2ghhYk4SsiGP+odpX?=
 =?us-ascii?Q?B4/dvLkWQuBEwo5C3J3XiXE2MXwtLFsusT+PqVGb6GTG1U08umSGUs+Ayu0u?=
 =?us-ascii?Q?e+6EMIT+Vp+1bCyYxw6UzygMjN6DiSwG1Wc4DKDSIgPGVr+bnDDFQKUf8TeZ?=
 =?us-ascii?Q?NdqMZ+MBhXQ1I15EGMxvYj8bNzZEKX7FYUj5Ivwveh0qFHyxFL27MzQQxe8I?=
 =?us-ascii?Q?4GUz3qM+UUADGiBXhJHLvxdHdnl2892oZHxP+sVDRyGnRPCXG+POQsdpSbK1?=
 =?us-ascii?Q?oymt5MYUuJZ24Z1uE7ZrmRRqW4xG6DgQfvzbJMFvKw/8rrsm8B9lnKVdLDNd?=
 =?us-ascii?Q?pjkJySjx+A0m5Vpi8at4WXJSmbqKm7UwoDaxgSCKMQcG00QZPphfh9bKZz5Z?=
 =?us-ascii?Q?U/hZ2k4l28tYfnzOw82RwngQVdiTdQd6kdU0f7A8xSoFhxxNrEgYFZIcMaHN?=
 =?us-ascii?Q?X5XJAHhxnU/lHQW8w81tXQdFIRD59/VegGSF0WR5mkg3clLIYnbP5xyirG0P?=
 =?us-ascii?Q?wQafmPECayAqWJ35VnR/ItS8Kn7KHMficXPIz53q0RhOZSuIp/WT6cEm77tr?=
 =?us-ascii?Q?i8jx27pu8imeNIFVrvIGhwV7iYv7+5kbtwXL+n9NNbdISbXqJ74XXpyxpLLj?=
 =?us-ascii?Q?HTEEpwtQo1tZeMr49gU+M1eBEFOVFM2IAB4aC+RJWmiXWcgJ/HUFZrFB8ty2?=
 =?us-ascii?Q?+r7TFIVAVNWL7EKrEpfBSn1chFF7y1wehWKi1kF+cBivzv8Z8g4+kPxKcMNx?=
 =?us-ascii?Q?8XC3Lhc396o0B2Wa/6AQ1U5pfUrOVKjM4Ez2vJpFYoafR1l+0xR99v/NRjrH?=
 =?us-ascii?Q?d4JsAmdcxMdVoHO9jnUeFWh2+TYZJbmRXjGaa1gJHpAHTOSf49UJ3BkO7UfN?=
 =?us-ascii?Q?SvEg3dlJkzphFMBP/97fMOwjvQg4oBpPvJAK4hnyUZe0+1hgfpwPIpHx3UxC?=
 =?us-ascii?Q?5Oe+Ge/+MdGUyOCJpnW44UnUC6ByejguiQudlEcKUMXXbdlpqc8jxQ9TAi/g?=
 =?us-ascii?Q?fWPHKVGiKBmqT8T7RArMAN0ocIx0sV+Iqg5yOw/+v0/Td6VXL3tbDRFTkrfC?=
 =?us-ascii?Q?GRNHkQH24YitT0CkFWvz55ec2ZcDxojk8nrKYogwP+nFHrC6RLItKZdVhPZF?=
 =?us-ascii?Q?aU1K1NND5R5Gexh88HwZleSk4kJD2fUXMXlApBpNdJFv?=
X-OriginatorOrg: sightlineapplications.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae92ae8-c4fc-4aba-9c57-08db8f9f4dfb
X-MS-Exchange-CrossTenant-AuthSource: SN4PR18MB4918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:17:37.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6f56283c-2197-4913-9761-239c8b420cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWqEnASq5vC102KEWikyw06PcRMXjkzqtRVuyXBz13XCxtB7jAdjeLy00Zh/74nMWg8I8wCd9U2TUBfFeKs1sXju2PvA+RkPnvADedVDunI2zPMyby1s1o4fYr89B6TPlfnBZ+enL8NWhy7A3VZzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB5256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
---
 drivers/clk/qcom/gcc-sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index b6cf4bc88d4d..d3c75bb55946 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -721,6 +721,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.25.1

