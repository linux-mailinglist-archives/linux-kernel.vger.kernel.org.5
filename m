Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D97AE064
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjIYUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:49:49 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E44BE;
        Mon, 25 Sep 2023 13:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9rnXok4NNQonISrTwWXSZpYRQn5w2qQqXPMsF5LjLjc+csZn0IuLnczYMqwmDwx4vOEPd3upD7zeDvCZIWsPQHtvzR5UQcw+sq/hr52t8U9wwGS5dhaICres62HdMiaes32yn0MdyYTKxIhuk/iP4a8fglx7ukYwPbvIRLcbIhXUoxbkCOjafBWM7oe8K0BPdvbnFBh/crXIIqhzDHI0YZFfb6mbkq41fUCTkDFrGmTqBsmALeTCDE9aYtsaCFEO3Oo/kjGH1/+52fEt3ROwum8RRqPNP9dVDCeeVfrbQLuVutwiEhf7PqB+Q0yQI61ktFBHYgfAKR2hnxzdQMTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEiHoOxd3s1ItQo86YhOqGN8L/gZE8OuRU66c4vMiK8=;
 b=CS54Hc4joCwagF+6aGYEW0m0GcnhepNPoc4BP71ETlREGpLxAc+dUZEXPWYp5QP+MCQb1L8ljw/roCz5mWiruk/9ZSQKoB82jrz8SpTCkqNwir1zjIPwL6BfmepURMnNM2KHT8t3x/ybxMQeAzBcec4CvoStHurBU+HyeCEmlQfU7ZRb4+WKTUwfXM9fHsdRVkmTzgeESlKGgVFbrZnUu1KPqTnrKuCIpQrTpyIEH5PX+Io52Ht69SvBeM9VlyZHGz1jZ5MxKBszI7xW/GYXpxBqUQZYWUnsS6vlgToMRZXpNFeDHiGmtJQx0XnFMULrzB8Scp6w7caVcSfGXnLSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEiHoOxd3s1ItQo86YhOqGN8L/gZE8OuRU66c4vMiK8=;
 b=auYBaADUm2jXpB2S4Kfquiu5e3OYeoNiS8NUuJVPpHfFyJV5K/qV1NSzDP/B2YE1qyCep74R3B5dUo6kjd8m7pjN/WDKVw1+wXpfA7ZXvtzieMM/MKrT4jRaWTl3DVmw4FNiWAz0aE/Wo6Sck8NScM38IFNcx/DcOKtdpEoSru4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 1/7] genpd: imx: scu-pd: fixed dma2-ch domain defination
Date:   Mon, 25 Sep 2023 16:49:07 -0400
Message-Id: <20230925204913.3776656-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c72d723-2577-4819-be65-08dbbe08ef8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgrRkb0Zk1a+94CQbQwQUmE4NQQu+fMmdZLWdfqt0yAxVqHM71Pxda/K4ia/s9wm6yG4D7Gvj67vpa9L4Eh6ERKTGdwEbhRw8IfH5LTDTjRm96UIzI39/jTXRHl2cFlSHJRAQSc1zKtk/LUz/0ZsxM69Sh04UZljR4kcz3nE2wRLyzQ2l/PY0wZnsOQJtUvVAQbZrvEnEXPm5vwvJiuQUeFVd/CJGHo35CNJF54z3QKcYqiwp/fShxkWQMIXvgScIKHkyPnOeSpLVtmBn9Sm8EjRjGDC+RgZJCuSUq+KSXpw1OPC0INOe5w0vuvMekA5c7fBb3tlmPFB6g0kK+dbNUo0fPck+jGIPFle0kVibhsLl83t/oVSu16M/+ouq7tkrgmj3+g/U+oH7KPs/Tn6ZBxrNmJsQIoLQDQ+KAyjysI3jL9TFGOqVib97/eeMI87grYmLjvv/OR2uQ3icnHSpH8nz53fq7KejGLkvwMbfwUnxZ2/94uSk33bzH26dvFpIFCQgEF10QbEHRKzgHjlZuVB2ol8niBcBMmMsOTH6MfeFGojiKL0gQGPgV1vrW75GgYo6R5ifSz0CNEvInTgDmydEM3hwOp2z7Z/UTEcaEfSvsiRITCz0wFjbJwPxq8t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(83380400001)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wQ4O0wV40qALGbn5hNKd9o/l9WhLZ+kecj7GGTyYhu3QiEh0vhacdKJdJJ+?=
 =?us-ascii?Q?2sZrBZ8Vefh8d7UbdjxeMRKG5Uulo4JV7tu0YYyQrOQLJTtltWW0m/Nf5G8t?=
 =?us-ascii?Q?BI1Oro0K5qZJ+uX7ratyrSNrmyf9Hcheezuplm1OcdaAm5Nit/9q6GVyikOs?=
 =?us-ascii?Q?n9HKH+K7k59cCXHCFqJGrX3bJCXpgRh8yQfY2kpm9zmVdUK+djxPVvdUn53j?=
 =?us-ascii?Q?RG0zxXVnwfQlVPbKHiFe5ow0xfmta6RKr89rhYGjEZSwrtzJypvuAQ84nHY9?=
 =?us-ascii?Q?vBHzeJPFfgqRmpZvcqz/JuT7soujXE81oq1QbYeqL3DnuYxTUozUVCNXfXyK?=
 =?us-ascii?Q?CJ8FB2X1f1RJS4m/ezMsznXWrJKZkjzS3APTsfiA3Xx8Qo+8FJ294pbpEL3G?=
 =?us-ascii?Q?vkWxBRjqIn3Rn4Csnt5Un1aGvHK4r+9Vnm8Ay4b3TRyXH/dd68QsODf3CQy3?=
 =?us-ascii?Q?12X3ZmJZyQCLbNxfNcQMQuPNxRWTzKiu+7MUiHVSZJFXgmso2MIQPoPoTr5m?=
 =?us-ascii?Q?cqpk0zCN01Xc2tgpG5v44NagSoPIIsv90Tx3lCj9oN9oHhjzr2P3sAXfEmDR?=
 =?us-ascii?Q?cQttOCUhU1n7Rczxc1mcaDDYzAr33qrdR94qrcFBz2Od1jMD7kSoMxzM7Pxs?=
 =?us-ascii?Q?BNRuI11mrwHl2yzzeSQw50urVMRDZty1JVO749boipDkzmVqTvBJ8yLBynNF?=
 =?us-ascii?Q?f9BvG2n5Q0zezSv20T5E533OG0oGlAk2h+A8LTwIwHhfB0tJqc0VbW2DD0XC?=
 =?us-ascii?Q?OgJ702nVhXYtXRLDxKdWwqOCBb0Cn49lhf8+o4+yCx5n3M0oyFvF0Txx4duv?=
 =?us-ascii?Q?dTTK73CflrH+S2JKeTSyrHQffPAGQpqNJNrQSGDI/qaMErhQ9TlkR7VaL9bu?=
 =?us-ascii?Q?2//bixnwcQbisHyWgv2VzVFIBbKqxxAmSCvzhsY7jch24XXRiA6y3ibZta2k?=
 =?us-ascii?Q?pN61PklmPWeyYA9IizDtG7vWOD5HQ9ngRbDkrO8N+Hmn1DPhL9gwP1NvzlLP?=
 =?us-ascii?Q?L5+OAKwG83qzVL4ivqi+K1ZqAEyXt1P4LLiJ7/PCyxoPpOdB9tZEBwlS6AgI?=
 =?us-ascii?Q?A2iEfZjMxc+fReIPjQFdaIAZ4NAuxpgeOuij+cbWRLb2/dCrDCH3jS2mqHI6?=
 =?us-ascii?Q?5/4tj/tltGDYaAIYX8t5dvnTsmoIKZtMxBe3m27//R0SGn0bW/TMJ+H70CEa?=
 =?us-ascii?Q?vXtUOvv7CdfYy+5b7H85k9krVvFquSlqwkuZlBUCGK6Pn4zba82flTA7KzQm?=
 =?us-ascii?Q?V04s/11DNhmxUdvmKuetCzAbv9kgzrAXYnY+gbThHCLWHAD5vRnpeYIUT0z0?=
 =?us-ascii?Q?xOW17ozd32eQttk7Txhcp6L2ksEL7Ma7nkJsGsbXHILTj/DZeHFZlSGJImRq?=
 =?us-ascii?Q?Xxdvzv0zgoVQa2cLVf+viVv4/ZYk3i7KcJGxGxY1QUyKPjaIRDsLgt6NyY01?=
 =?us-ascii?Q?weQbdSB33kv6qBvozIX9aE5iKYsUMuaYPmjFSbYYgbAfZOMg2G2LzsXYNDKX?=
 =?us-ascii?Q?7DewUQfh3hPKn6P+q/uukq92VzBCv0N8+lnAgeg6d3VDUzhUkTbMXL3zPMMX?=
 =?us-ascii?Q?ziDh677INOZUNLLST90=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c72d723-2577-4819-be65-08dbbe08ef8d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:39.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8UtdZ1KxINf/PR5S04Q3UrggiUdoAq4WNAKOE8iuoEsqJ6c+ET8tGOmsfD6N9YM7SZgOWEFX0cZ3ste5q50wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 'dma2-ch' resource into two parts due to a gap between
IMX_SC_R_DMA_2_CH4(258) and IMX_SC_R_DMA_2_CH5(427).

Fixes: d4ea45e8a603 ("dt-bindings: imx: add scu resource id headfile")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 2f693b67ddb4..891c1d925a9d 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -150,7 +150,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
 	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
+	{ "dma2-ch-0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch-1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
 	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
-- 
2.34.1

