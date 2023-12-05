Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649F805334
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjLELlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346933AbjLELkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:40:40 -0500
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C07685;
        Tue,  5 Dec 2023 03:40:45 -0800 (PST)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B58vQZv020794;
        Tue, 5 Dec 2023 11:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        dk201812; bh=k1y9XQXwlBdoL10lit51KlmkCKTEpfAX6wcJ0rlqqbU=; b=qJB
        aWoK50CWDmiONiUDXtSoZYWRO5Cw/18pNQhK2Z9eAF30Wm/XMvEkHt9n85UmW4bX
        PDa6q/WZSkohXyGyHu7pnjU/Gh6IsV2m+tjQ80BDlAizrVx+po5isfH6htLGMZtB
        kSyJEgMbMCgj0soG07weL7k1A4yREwN/wehmGI2/80/gBmVbhv2vMM6m7vK7aTLp
        t+DZmA9wTCU0W6lmu3DDjkCkiU9Q2w9cXgSc1qdXXwV/Zj4J5jareJim+2zxz2QX
        RWDHLIVklC+rPQK/DSzu2nZcA5Lx7VKlgNCwH6HxOc5yJP2hL07eN2v8c0UmllxZ
        PaW8scYP3zmZ38vPxHA==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3uqwhwa7mc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Dec 2023 11:40:19 +0000 (GMT)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:40:17 +0000
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (104.47.85.104)
 by email.imgtec.com (10.100.10.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 11:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe4M/jkPcZ+spuOxKKhYrlRHdqyuScpig3wPWQB374nMNDeAekiTSISGuIoZQmXPEBD0O2zocnlUeuglLsghoDMZlf53Nf+owLHfWbaI9vTfGyY2nih+zAbLpmeixpsfiVL6pF9//AHZ+ukuaXK/IjAZm8s4WZYeKwwq+r52Wn0AKG0YqpqhXMNZ0ClLUcU+oiSYQ1YylLcJis//GzxcJIY9Zw4Scr/kGkFReCbto4q6VLWgKvD4pweGjvseNik43fUs8fN+RZIe5FPrzZb1Pw9JUTWVTBc/fOMQyu0L6cRNK4nWe4IFtGWf0SzcXOn82x40Pfsjkzq9Flfz9BZIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1y9XQXwlBdoL10lit51KlmkCKTEpfAX6wcJ0rlqqbU=;
 b=e/3Ln2f4y+D0cpPbkXLTvfaA71q68bpIFamwVDXRuCnAYxpnsT8AvW3lBF1dLCj86a2GTipES4OiGVKjGFnk7DZ69oBvCA5alapIBjT/mVavT+iejO7TRsYJqVohFytgshi70RWN/3tlvFDZ5pFLQTGRjYwbSH3r7noR4cglV80ikrOwPRW7KjAlHVq5qk75quWW3qFcCOza1m5q5YZmzhJGvgjugv6ne3gkxPvWGKzHAVX5pwRFcKYWUujurGWCERARV2BZsNdHxKE3KyKbJ7v+m0xTrT9pT2Saun0N4B9Nf5Oiad/E5Pfha8a89+EdBtMLrf3aWu+YGe4i02/WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1y9XQXwlBdoL10lit51KlmkCKTEpfAX6wcJ0rlqqbU=;
 b=Vt5MUAhIfwYr12nzuimVcVrk4Y2cj61o/+tmDginK0y46c/sCd2yXnTWwAO/C6UZkAh252k235yIB922j1g6ZrliA8EPaQxRT6LKfRa8L9kN/Nlqcjn9ooVfd26GozT/4rOqhYtEU/oM4II/kgfxEQc7ACIzTlwYDWceI6PfEH8=
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a0::8)
 by CWLP265MB1842.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:40:16 +0000
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34]) by CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:40:16 +0000
From:   Donald Robson <donald.robson@imgtec.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
        <donald.robson@imgtec.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62-main: Add GPU device node
Date:   Tue,  5 Dec 2023 11:39:33 +0000
Message-Id: <7088cc032374ae517191b1dadf5bb5f0440eac81.1701773390.git.donald.robson@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1701773390.git.donald.robson@imgtec.com>
References: <cover.1701773390.git.donald.robson@imgtec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5770:EE_|CWLP265MB1842:EE_
X-MS-Office365-Filtering-Correlation-Id: 12879696-a3b7-4d31-6252-08dbf586f35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCXrUnBpw9szc6ltpCX3+jqmWp8V2bxNdVKYpk/5jbprBEdDXtcBQ8S+vmMhdC8zsCCILZCpZZyV1BShSyZCTDxBjI3KatCTuSSlWDFNbi6jNaxZOGDxS0wscfdIIjG4IMPX/Ff1q3cvH3hP5QMEhn//q7IHsAaYft3kq/T6Gqj0JGP3YqW3UzvCFZdUAiIS8vT76xlVgzGxfEmsIL/9oyuCJszcADlA6rLwT/eF0raryHsahoikfH2AFH/lf+TYwwbAFdmvYxWMhuP9HrtGzeVK41X81NQ77qRCJgOfGD/WLELl7LdmcRfzxVvgMCWijYabyD7Z2OB531XmcicCLOkWYhHukXZb9nTKs7vo8LVLi8necpRnoDG3/2DLXyj1aezfRkeSduqJjElA/BvFDWGhpwyWrr2nV2rzI+JqbnPk6DPrFe557Vbzxkw2zFJokPPwYNut2zJOH+ddeyYSdAd1EIKYWAYH2hlc4kd7HZ6pJ3q4K8lu0bDDBS/Ad545S5e2gSGnth5h57xeowiWDq0k12GNz96uRZC8TmmRXq7HvwnqzwjkrFdbmt7axggsixZ5ZrnRxSn3fuPAQ6PF9s82BMmF+d/6m7tKSgHJy5lVZun9PNW7Pmhp9dvSTJ60
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(52116002)(38350700005)(6512007)(478600001)(6506007)(6486002)(2616005)(6666004)(26005)(4326008)(8676002)(8936002)(54906003)(66476007)(66556008)(66946007)(83380400001)(316002)(38100700002)(5660300002)(7416002)(36756003)(41300700001)(2906002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvlvcFNAxa/5t/5LnyzOCfFKykkejVTVGJw7Dj77OJIo4b8JWaLlWS2mtgiC?=
 =?us-ascii?Q?B5cuQpUXVnetHpJvDOUrmlv0jNt486roD0FcvkvP9UBEXwucCkTSzGJ8IWR/?=
 =?us-ascii?Q?hWj7/mv9kAxxKBC+bjDAxZo/esMIrDMRw+dkA7rFoKhhVp73GEDGfb9Ak4Qk?=
 =?us-ascii?Q?zldaxkkrPkP2TlFSIVHiSs+9/gIyGNTnN6DAnRvrv6LCx6U7onTwrQmJ/l6X?=
 =?us-ascii?Q?DwnozFBhXZKSF6DTRsZxKsOkNIDFi8qN1j80LXeNJO4FdU2LLJohn7XXmWGq?=
 =?us-ascii?Q?9PwAy2uhqBt2avGsDhY0TUtHkgsLJ+iZD+AalhCSTVi2do15omBodWH8EPN6?=
 =?us-ascii?Q?1UmF2wm1gZd5odAV6OlQHMWnUrdit4BI76yo2mQLuelSjuQy6UQOcf4i6+4S?=
 =?us-ascii?Q?skBqxPsFp6TUGf6mloR852xbXaQs4Xu5kaJ2W+WA+NpNykxKOR5E46idWlG5?=
 =?us-ascii?Q?t5uckygQU7EFqbJlim3l9ovjUyhChrnzvwSdJHU1u72DMrHi/S1ZeFXmeSod?=
 =?us-ascii?Q?5fhppG/VsjcGRRONwq/1kzBOIkz/IVSYCTxc0/cOOal+irRMgGlRwmbZJUbI?=
 =?us-ascii?Q?goC8nWuzBDX/sCWbNGYXSXBQDkRWnuMWU0TPeuzKjjsNOnGd4/oNjSK89t5c?=
 =?us-ascii?Q?IKYvOvKgqqIB9iCi2LMp4wRwr3xaywMiONZnrHfsuUBBymwu8R/5RUGX9okd?=
 =?us-ascii?Q?8IbGZeGYV4eWpC0/MHQkl8e17Tp1SYBJDMWDHX7/p6rhDTPHqB4ofQsWHjtu?=
 =?us-ascii?Q?Tjo6QSjG1IS/w6tYDUElowOseRQBr1xUepPcru2rWcsoUPsNdWPSQ3UPkUiO?=
 =?us-ascii?Q?esRVEKc4UIpEA/87hcPE4KI1+g3jqHkrwCDR07TtlsoM8G+j2chDyMPB5LS0?=
 =?us-ascii?Q?0I8t3mF1iMJ2sPDJk/AFdvxTZrrAVO8zW+rRQLxziSL/tgfzTrNGZzNrlTto?=
 =?us-ascii?Q?Oe4lF9bfsc2Bl/Ri08K94uCN3GM9FXSzwjMuFu/vwpRkNxpd5flZHv8CvqS3?=
 =?us-ascii?Q?41uEgSxYmNdmOUjbNWatGX7BS7QgrwlSrKXuBhlFSvrvYAO1uCq0BBdL2ctA?=
 =?us-ascii?Q?KAK2OiWVByzBVM7/vPbML56gcLgecY4xtlvtQsCJpefi01bW9Ak3UHdhlxGf?=
 =?us-ascii?Q?mp3iVVFpWfMy3LlzsWlV3EE0sc4+dM834GcuRZtReRnbnnA3khB0fB80jFbJ?=
 =?us-ascii?Q?JfwIDjDRse7u793ZLWY7sYUxs/ECY8z1sdkJtXRKbNd9UggclpZ8mrOqdVQu?=
 =?us-ascii?Q?AQUFBy6UEaBLaLYUoCSvQAz6oZ4WCLWxc28376wevwit2FaOWLmPO+dugxIQ?=
 =?us-ascii?Q?4i4zgpsL2drsRhSfGxX7FITdBJ3f2dTSkWW/pI097kG5B1veK3A+wfC8w6gs?=
 =?us-ascii?Q?kvG68uKceUb5nSnBmK7ORdHGYmeV4+T5ecPTPFSAwl59YppM2kQG7zNGIfMT?=
 =?us-ascii?Q?pNkhQpkXbpm/E/UVRc08Oo38DsqAlquEGRYMKh04AllPOcnXrhIBSEThXr+w?=
 =?us-ascii?Q?9PROaXxujSWt0/n+PVuD23nRFNPLH3hMfjHWlTaNs671cYaUqmst06WSvWZs?=
 =?us-ascii?Q?GSd7nvzQxb1bhatyOLZH1u6cmWFbGouYN+ker99A1uyeBtcw/j3G6f2rQWHE?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12879696-a3b7-4d31-6252-08dbf586f35f
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:40:16.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB37W10WE6MFOGMqWuC7sfMcT+47scyWafG9ruzdaMoyzNDS+vatrZ+YRNnrHsQk0ObrN+9GHQE2TDCxxpdoWv0uCl6peCUipIk8buyFlKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1842
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 5HYDh0ojk5MiB5E8rncjqM3jFVLifgiU
X-Proofpoint-ORIG-GUID: 5HYDh0ojk5MiB5E8rncjqM3jFVLifgiU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarah Walker <sarah.walker@imgtec.com>

Add the Series AXE GPU node to the AM62 device tree.

Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Donald Robson <donald.robson@imgtec.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e5c64c86d1d5..4338fd8ab2d7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -965,4 +965,13 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	gpu: gpu@fd00000 {
+		compatible = "ti,am62-gpu", "img,img-axe";
+		reg = <0x00 0x0fd00000 0x00 0x20000>;
+		clocks = <&k3_clks 187 0>;
+		clock-names = "core";
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.25.1

