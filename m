Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9979C2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbjILCZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjILCY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:24:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EC603D1;
        Mon, 11 Sep 2023 15:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAGjlfjphjqD30XV2PsdAsJSxd8xFJml8Qyxd9H0A4YawAzgxMphFpMOtVZpRXE7/OWD3SIg2oDPLlM3NVxpExTEewObtGmB4b0wweiMYpVajZcTMqzxb2OgHHHC7yXFFQsv+biq5wphuR33ABxCQ7ut5WRWy14a04p//o20HbAtcY0a0bv8AQvSKxZWmz8pSCodsjW/DA9y37eCcaoKAMOs72/PkJoescbOmejAFFmTtXmpVKD9Lvy7SDd5d/BSO6zVlHDv2ZCvg0YDoXWRniuBJLcrufRh82MHarreNEwIBghzKjsctb2CM3Ib6Pt9ypBoeKP8W8urK2CU/S/N7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUkzAjPmq4Wxvb/0eA/wSsOPCzy6x6cLQIqV/BZQeDg=;
 b=OWLsSYvbTKi50SS1c97m2ThL3lb/Jr03YCs8nQ+KdGfBHDYw/5MT3UNjA1pt+nFFVbLEiy4/E4iujWz+5BxzttJ8bPSRihQ2GXh4wfVqEqYbhQHRnXzmykJw4pNH5vyfcWjxG9GvtLsbm7kS7wInx/PcGMoBP0kqdK3I+GvaYxZ7RjWVlKYBpPcaIJInRmADngl6+SUkOQTx7zyVWE02ROnIsZ/4dXIqS9s9uFvy2hPFKKNEhgNTUxfuQq05SOCn78nFQM1jR6F+62aXWKHavDqk89WA9Ysv5aGYoLMnccfI9vCypeazy9vxjnknS8Tnf52olMCZ63iTawGcFjH19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUkzAjPmq4Wxvb/0eA/wSsOPCzy6x6cLQIqV/BZQeDg=;
 b=Zwl3YsPdHXm+9HIjSkOy1CXRYYg4wc0C4H+8eN+xc3a72qh8yGv5yMDAU15JdQdzm21cjLO84mvUdGL6cq2DTMUwHcAFDeGLwKL+Faqy3nauY2ehoVb7sIrmXA7z9zCfPN26p/edoCvaTS3I8cZAEqlR0fqZVSBz773G8e7Om88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 22:45:17 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:45:17 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH 0/2] Rpmsg support for i.MX DSP with resource table
Date:   Tue, 12 Sep 2023 01:44:50 +0300
Message-Id: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VE1PR04MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a4f9d9-2ce4-47d3-a761-08dbb318c528
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbwt1Bu1DhDvdC29Fc8Y1SPBK0HYt9qFKUQIuO44NDzThzA0lHOQmYO8iZcoMCEmwndA52TWtghHQV4bHMaTXvwVmSYfIG3DBjAaBcnCGMBTPlx8oWs1xzOdP/PyHLydJVW+6El4/zOCRDqQT4wHGtMWjadXxjmbLfl2oZt4RlRGUAP+U47/aZpEDPQ5qyvDjWRTGLTFwegdTDLkgR3mJbfbfyqqVPXyt6h5Q+9VHaVGN6TPw0hJrqwMmsVICcEk8BiwoUk5rprZpN154OaSyxt2fEAqI6occVkwj84iWGk3SfInpB2l1yQgi+VNOm6nO4+p9jQeOpcdr0K3wgQnFIcPqdHafryzrB4Cgwm6B8U04jnO0NFsBBsJeqaXSIGZdPPwk+9KW2GHfqioFE86A64w8ASf0tbLN4EiVJZbV1+/oRz323XhQuQeXsXX+jPX3XvINIr0NvJAFE3wAoloLfsoLUo1P/4rVuqYKrpi8gJpLcteDxm37AZl7ZOY5XVVU0wATZfVhDfpPUvSPX5dAnBxyCEQsyGLQMXBNkv4/pcw4IGqiuIYJ7b/K9FpQw8wA1gu2Xb4D2BXllHhDWPFUxkfYRzAx0BtRKq88GRFWQO6yC7PgrQhyIbpd37S1c45C1U4Wn664hHB3Bhrat/Y0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(6506007)(6486002)(52116002)(6512007)(6666004)(83380400001)(921005)(86362001)(38100700002)(38350700002)(2616005)(1076003)(26005)(316002)(7416002)(41300700001)(66556008)(4744005)(66946007)(66476007)(54906003)(4326008)(8936002)(8676002)(110136005)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a20j0G5ILke0sK2ui6ij19h1WRGi/A0EB8bj6j8WIfI4h2FFoZ3rRT2l7Gzw?=
 =?us-ascii?Q?wdBhq28Ne5YL//146Fs2XnVJA36zJjN8N4XJ6VBJV0cGJzLChD0zGQsk4Waz?=
 =?us-ascii?Q?zRYkwAvCnZ8Wh39B0a3afKsCLx0rqM/iy1RnBuBtF2vMVjB2OR9aU+bv9KWI?=
 =?us-ascii?Q?iY6P8t3EGbrNRC6eUcIeIbajacyzHafe9rqi7fzqlD57VdXIUFoJgEU9g/Lm?=
 =?us-ascii?Q?i4UT8v5FmXctKWsGSo7q2a3iCcEBgu6/jIFuqszX7T+AVnJTfjUCbLOSheRw?=
 =?us-ascii?Q?S9N2Q5xPV6P1GvwPeCM7hjGe/UR8pB1OI+nRDja5gpJVNzbp9Sg3j3p5G4ca?=
 =?us-ascii?Q?Hns+ye3jxcK8N9dsrbLRQr5dcCHfzKjSnJTQPZpBMcXj14Uo4pPIe0G3wiXb?=
 =?us-ascii?Q?AexxN4AkDd/ezr4DYDS/nVoV+XKFBfX2oPgPEfZ0c4rGpzImWrL617SnZJul?=
 =?us-ascii?Q?REN7G6+UDAVI/RNBV8PTDMhtQlIzYWXWMcNYaL5u3h+wifyqTvl1PTX7sFTh?=
 =?us-ascii?Q?Oz5KunLy+BHSozmnC89RMWXI9SkfMO02JAWIg4ePBQZiW0ySpfc2hAm7/h8p?=
 =?us-ascii?Q?ZHcNXC+VKfgpK4xgQBi45XNE0qpKQTv13zRD08RsS5iD2M3FS4Z6x/vvqI0q?=
 =?us-ascii?Q?XtDsN2klpv3hiE6CY4B/OKcSF6X5i4mF6CPH6Y55hmVuPL8jBqQ37NRJu8jh?=
 =?us-ascii?Q?nzRTSikAEXzdGfP6B2StC+Xrw+0qNgcjwLqZrwb06PfzerIgZPJxTd/bGn5l?=
 =?us-ascii?Q?zQ0a/sDQ0Lm1JuRDv/CYcfdhZ08h5pr6EwCMA8yyhKJPyGm9Z82ZZqIsO3/8?=
 =?us-ascii?Q?vxFdeUla2HHy5QxULoRpDFCUjzckkP+u/qiHNfiQcc9+tZattxlucftDBOdm?=
 =?us-ascii?Q?ljnGW8wz+0kH4xKhEly0BZkhhGRfqedKM/ikGPYG6n/p9g0XAhRiWnAEV5K1?=
 =?us-ascii?Q?FaFcX8C9AJcg7G7Hl5Gog/ttHnfKoa/KMsV67MwX0sG+0KpwQQGVHoFqcrYg?=
 =?us-ascii?Q?jgu4vQyXTnGc2rf+VBEeRAbCd7TJsK+aPkYXjR6CEInqAVvv6xeE2V43L8pp?=
 =?us-ascii?Q?yitBvEz2SgXgLnvcgR7a6errfu/dY1Q8CRGHBlAxq/aEyb0rrD/IlOyfHXT4?=
 =?us-ascii?Q?Sauk5X2xVbbz0vn70vl61KFfxvNO+QEn1NB2/urWHhCB5+kc9q13jVTi3Kj7?=
 =?us-ascii?Q?0hYbYUwEHX7EbBOF59oZTJu0OEA93/u6tiIHofmMfkuTAd0dwgVDDYhcBPOu?=
 =?us-ascii?Q?lJb9kQMC4bTAH4GSH9nEmbLmpa4MCTl7a5inQ/en+gvsa7zIefdyn0HAo8YX?=
 =?us-ascii?Q?bCR7H7/SAW1OcausGrX8RFliF/JKO/2Q0cQq3Ah4bj2BnMT34xYJF2B4HWCL?=
 =?us-ascii?Q?EPOSUFORzS2LxtXsiUN9lKzLOfbCYHieAoBvnZC1Di0K3CKicLA1qvijaVxD?=
 =?us-ascii?Q?EJtaPeWu+PN2WME8aHnPYU3+5B1tgN7WCcEIPLpO2UP6h20jpFwwbUPHx7dn?=
 =?us-ascii?Q?q2g/n47ESStVJqoHSlEwlgn45E/Wt9uObEyc+HSo61CvaJneLY5mGdzgoSii?=
 =?us-ascii?Q?oIpAvYBgj0RDfnBTA39j7Ugt0/TvR5hJDCCIYuooxHgYAK0M2ZevzPKl2Sg7?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a4f9d9-2ce4-47d3-a761-08dbb318c528
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:45:17.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33WG0Pd/l0UUxgRS2zlgxjqJopkFGiixvZSzM7XRlp0lEYpexC3iYwYZ9qDYJjkyfdlIx3YDznVR2zck2UziHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

These patches are needed in order to support rpmsg on DSP when a
resource table is available.

Iuliana Prodan (2):
  remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
  arm64: dts: imx8mp: add reserve-memory nodes for DSP

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
 drivers/remoteproc/imx_dsp_rproc.c        |  1 +
 2 files changed, 13 insertions(+)

-- 
2.17.1

