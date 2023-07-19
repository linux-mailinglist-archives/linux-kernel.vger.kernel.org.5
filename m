Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02A975A0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGSVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:50:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00761FD9;
        Wed, 19 Jul 2023 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FowGGohfPWbCa9S2igGeYiMrg0gJ3N3SMouMvKIMPmC244w1/TZs8etAYgvqGHX8cue+8vlVZGzJ/gCLnn5FZoKH6MPfnohRpTX3Y61wCqZDqp2xTL7QTcav7yU21wQLavlAQDiH4hPrmJ6engxrFfEShO0Y0Dcoiaw6+eheUmUbOIwE1NqHqbl9jckqoNxDHOdhr9vV3ePNkWCLlEJbaJJQF7nQ9unHJ9ZPCn8Gde4bHRRfOsWrefG1C5SuanHpAISXGCn3zKdQqH4E2ds3UbIyV0HEUjOhJE0NaMdbAtHP5T+IAZYKKkmDn6m/P+BfvcmBvMiW0nMxA3FQjtowMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upa0Du2sGkaBf5tT9SH900G4z5jgSD3puX1mmcDLlfE=;
 b=NNvNffxWLH5F6iWnwXDcZ94uHD9iyQvWVf/rpetbjxbIqLxAa9udiV/wzzSAX7UkXCHo7RJyoCkiD+7DJCgsWIhsylTZFWk0YYDaiflawzXPJ6ElsHuUgXjW9n2oLFTRNX7mzIt68aLu4AIOENt56ERDpWpI5Dor+BfJeLXH7yN/oFALC3Bm28aUnvFOUeODMmBkRJ4B8nxv0WYvqiCOSxbxmQHOXk5OmlgbC140FHLMvqGmgMa7LkV0b+G9clFLUTeE82cmg3fwj8ovgsyptGPLo6e7J8ibUJ87ocUYGbQXO00ioyzgU/CKTQDCY1hwu/osSC/poORp2Q19iDDwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sightlineapplications.com; dmarc=pass action=none
 header.from=sightlineapplications.com; dkim=pass
 header.d=sightlineapplications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sightlineapplications.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upa0Du2sGkaBf5tT9SH900G4z5jgSD3puX1mmcDLlfE=;
 b=XcTnZSSHck8gRZdbTsGf3iOcaqKJemrrZX5TyhuLLEK1yHnjcgMFvDA9x/D+qkIsbixGQWdHxtsAfma9ysAZ5fuM8gvMIyH9guUDaiYNfKttLn7qIrlbuwYaSwgiVAad4SpxF/0lpEBq1sIpIR/UalrKR5OSu/Nd9gA1jY1em6GMUrA3flgtI2M/pn6FFBGRmCCsPo3w89hALpQ6gpMnM28A9cV5wgszMn052tRYWnEVE8HCtOBdLcQTXaA2KvIL97unJTT/A+7y8ai3mnbK5Na0IAtpu4kdrYWUpemlUbcZMhJVxJbEnNZiydYRklf3BTvIj/jW8l2rlHXGxNGz3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sightlineapplications.com;
Received: from SN4PR18MB4918.namprd18.prod.outlook.com (2603:10b6:806:215::8)
 by SJ0PR18MB5015.namprd18.prod.outlook.com (2603:10b6:a03:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 21:49:55 +0000
Received: from SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b]) by SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 21:49:55 +0000
From:   Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: venus: Fix firmware path for resources
Date:   Wed, 19 Jul 2023 14:49:42 -0700
Message-Id: <20230719214943.22641-1-patrick.whewell@sightlineapplications.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6afa314b-ca5e-a924-de2f-f1db90770623@linaro.org>
References: <6afa314b-ca5e-a924-de2f-f1db90770623@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:806:27::35) To SN4PR18MB4918.namprd18.prod.outlook.com
 (2603:10b6:806:215::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR18MB4918:EE_|SJ0PR18MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 338f072e-e1f2-4521-f18f-08db88a216b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kn1IlPUbH+qyYV1j43hmLd6XNzOFOOpGx8Az9Nmu5XsZjewXFn/RLF8BN2sYHz0edO5/3XgxpXLAdO4Wk9Kec5JYATa+Gqli8cDl2sd95QtW24jQfBCsfxq2R+qRPnUz5zbGNTmC8BEG6fUDpJjhsJYJawB92F346LR46zoWS/ootozacURCoN4aECYS+p0wxtWgIArbtNFakpj2QkKpsMl3WBWrN9LF/JyF1JlDWKn0DmBkQDUiCP0fJiTQOxCelulLFH0xY82Czjgtg9TC5xVJhUCm8lbL77Sueu1pfXpf2FnO6veSMwA2kqlm3FrZbHMKt27wAQwzGEdnr+6MjLt2fLb3yI2/XddnCHf+P4XLEjOPXnQZuNTjEHm5dktfq8VT7KaaxT5vnp+g2RYlJxn2evIoZOmLtJ6U+0iSx0eBocbex5OEfA/cwN9Obkb4rPd6DRbvdysavBGFQqflqbDAAM4ba6JnB9O1yF2oEVoKbjIzAQL0b4ipy62kag2/gPdwOaHsZPto2p6TTwnaTl5ktvarSWRNNFY2SKZUPbdkGiUbsPr/cNSywq+Uyqke6u7hiYN4bEEnCDwLZI0QWoV/vanzhJRf+tvQPe1c7g6+LoLqB1T228IBIuQ/UETrNdLfHuRnsioNojt0uTq98A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR18MB4918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39840400004)(396003)(366004)(451199021)(109986019)(8936002)(8676002)(66476007)(66556008)(41300700001)(52116002)(6512007)(6486002)(66946007)(44832011)(316002)(7416002)(5660300002)(4326008)(54906003)(6666004)(36756003)(478600001)(2906002)(83380400001)(1076003)(26005)(6506007)(2616005)(38350700002)(38100700002)(86362001)(186003)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZFtIkG/r8qU7NIl6Wi7tMUHZgxkW70MBixUszSUv9/iMaefgbHnfggnnUrS?=
 =?us-ascii?Q?p8tXtJHsPi0HH5jI8sH/ap2drTpNbJ0iNQHzgueHDILZMON3+xM8//8loAVc?=
 =?us-ascii?Q?hSxv8MjFzdNuYcWAg5xFJlVSbXF1IV7mAjgRLMs29fRnIsqYlBxNK2d32YIp?=
 =?us-ascii?Q?8MXx1dG65S9WaZr30IblFGnb2nw3fNZCctjiJ73TvC81Eh9uU/5DGk7kosVR?=
 =?us-ascii?Q?vOFaZYQ2vVEW+JoR03jvdergqGozwje8/XOJKvkXpHmbkPQc8uGPYwE9VvYv?=
 =?us-ascii?Q?36MHkAiWBZR0gTTN9lIZSYLaTGqi97/IQUNZRKzvKJcrnN+JnI6zIirPeSbK?=
 =?us-ascii?Q?MDAYzBSnjMQwl80smyIYExzMmuPgiS2aEEpUdSwOkW6pz/t0C1XljfepAn+0?=
 =?us-ascii?Q?S+kxiyzztpZCQp6tF4weRa7PGOFjWLMRRuWCWtqRPFW24z4ElfHTbYeAHGZ5?=
 =?us-ascii?Q?AQl+GRwa63WcCTNUJOxDBkA8QPmagHnHm2O88+ynkFGIzbYL2nT3KCpzk5zf?=
 =?us-ascii?Q?kGHu6sa9PyLQY/YW1BfUmOxB+Mvmmokq0rxk5PLFo21ybRSQnMbkPYbrkDuQ?=
 =?us-ascii?Q?8WtOqS8snd7HCa2kFIRrlKW1yGcco4WZ44nmkxJyv1Xux6Jl/ujMQmxG2qtv?=
 =?us-ascii?Q?lr8WTDtqwhdpzGYlpv/aW0dALbZbmW6pvtp32tUts9Y2JUEhuuKUbvo6qIgg?=
 =?us-ascii?Q?GHEP5A6haDe2JEZmJ31AGBV6HAMbPJIoC2VRr7hFZvVGGVTK7H7Chl7DcDwn?=
 =?us-ascii?Q?xf3VlDdvisPgBKiSabL9vtctkbDGgJ3ntk7rYnZxqUTX506B4t6FJeBXT4LI?=
 =?us-ascii?Q?dOtyftlLFQDLprnY+0fYyAzNZ8Yq3iNcI8owr/8ufsH6f+n8tx9wctySVsMu?=
 =?us-ascii?Q?2REJCC6+VGMmCXX+QDkzlAbg28Z3F34mKyCVGpeRgEebXfN7K2sdS7/gp2vm?=
 =?us-ascii?Q?3oj4yDEq6/mGXb0jql5pDcjz2aCbPchqPRDOUh9kpan7SyA5FMWSgq49WbZ5?=
 =?us-ascii?Q?hvSpvtzsbhFnC+H5ewIg9ldEslQVcOdUgChEqk9NZ1ECN5quv8QLtvV/AUyF?=
 =?us-ascii?Q?6hfUw6chFSW2UpHNk7oPjNbTiUYv2msSMa0Lrsa3ilM2nDm7ltGPz6k9Lxmw?=
 =?us-ascii?Q?p9kLh+NLAou+0y4Hywk9W8QRM3HRPh4wBBBGVpOGxu+IUUGR64OAXsVl3qK9?=
 =?us-ascii?Q?ZW7ZNZSR3q1d1Rv78wv9T0FJbKuoFj9TIxP7YusjzUufOrGSsep6BG5jWUNK?=
 =?us-ascii?Q?97ecVQzA/KHmndIhJAiOA7BRvwK6B+eE1E+GlzEoB1MxAAaJmdiIbsjOEZda?=
 =?us-ascii?Q?r5kVojblMZkmvc8+N1erhZF9+UvIknModRgvdhljf8Z7PmGwbXAkWaN6/Fsc?=
 =?us-ascii?Q?NzrEl2b+ME053ZgBoN6inlyQl/rAYrv63XKoLX4UFzsur/PJ8AWJntk5Un7d?=
 =?us-ascii?Q?3qeAzfLTrXKPeFocib0jkIbPq+c7/YbpF748ejzocMvc5kwJLxjqbBR7wUOD?=
 =?us-ascii?Q?xVvQRBd0paUyeblZ5/0AZQct6Q/zJ1TOhepqGU1o7JV2cY0UYFdXVd+8lSHt?=
 =?us-ascii?Q?GNKA03GABMA8YwFLt9i23tabtoEyJuns67s1CGNTfVWsQl0iv/FhElO9Rs24?=
 =?us-ascii?Q?Ty+UQtMiRFQgRNR2aRAnRyoSIj1RRkfSIUkcTos26sd6?=
X-OriginatorOrg: sightlineapplications.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f072e-e1f2-4521-f18f-08db88a216b1
X-MS-Exchange-CrossTenant-AuthSource: SN4PR18MB4918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 21:49:55.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6f56283c-2197-4913-9761-239c8b420cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33bUTNxZkhpPF8ydX6GdarHVdD86MZUPqZqq6dVTwVqPu5Qn20wk7bx/Ozd/3raN/AGlAEts7l0onUKZfViXy7csSJDsW8xuLewiz8CQHx/MANz+pG6jbwKvm8lyDQtPVEcq1jpJErsm6DTiLn+jOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware path for some of the resources is still the old format. This
fixes the path to address the firmware correctly using the new .mbn
format.

Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
---
I've updated all .fwname to match the .mbn format. There is a
qcom/venus-4.4/venus.mdt for the sdm660 that still remains but the linux-firmware
package does not contain that firmware file anymore, so i left as is.

 drivers/media/platform/qcom/venus/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 2ae867cb4c48..2d62669d99e1 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -548,7 +548,7 @@ static const struct venus_resources msm8916_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
-	.fwname = "qcom/venus-1.8/venus.mdt",
+	.fwname = "qcom/venus-1.8/venus.mbn",
 };
 
 static const struct freq_tbl msm8996_freq_table[] = {
@@ -581,7 +581,7 @@ static const struct venus_resources msm8996_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
-	.fwname = "qcom/venus-4.2/venus.mdt",
+	.fwname = "qcom/venus-4.2/venus.mbn",
 };
 
 static const struct freq_tbl sdm660_freq_table[] = {
@@ -688,7 +688,7 @@ static const struct venus_resources sdm845_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
-	.fwname = "qcom/venus-5.2/venus.mdt",
+	.fwname = "qcom/venus-5.2/venus.mbn",
 };
 
 static const struct venus_resources sdm845_res_v2 = {
@@ -717,7 +717,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
-	.fwname = "qcom/venus-5.2/venus.mdt",
+	.fwname = "qcom/venus-5.2/venus.mbn",
 };
 
 static const struct freq_tbl sc7180_freq_table[] = {
@@ -760,7 +760,7 @@ static const struct venus_resources sc7180_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
-	.fwname = "qcom/venus-5.4/venus.mdt",
+	.fwname = "qcom/venus-5.4/venus.mbn",
 };
 
 static const struct freq_tbl sm8250_freq_table[] = {
@@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
-	.fwname = "qcom/vpu-1.0/venus.mdt",
+	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
 
 static const struct freq_tbl sc7280_freq_table[] = {
-- 
2.25.1

