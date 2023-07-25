Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF976053A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGYCex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGYCep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:34:45 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2147.outbound.protection.outlook.com [40.92.63.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022319A0;
        Mon, 24 Jul 2023 19:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBiu4Jtlt4cadHQBjU4AGF4t/na7lcSpqLRH6o/CfmQuwIXVdfOuCgy1bG5nMqq5U7ChzUvnSVuiXPGzy1toExHtEHEo74c27hCJ5KRR2zoZl+TA+uigCe+wXXxv7n2le/IxCF4DqBKvLWsTHGgCkwKrxihneNarT0OKCPML9F1tOdu0/TelQaIAW5Z6Oh73CIr8VppGVkNqcjGe8lSnHzMFwF88XDUYKEwnR8oihcfLgcJA3NIWF0K9ZXNfyYV2uR9dEQ58/EqInUsGDb5zoKCuF8A1pwvsSICJ+u09JgPEtp0aMSPv3TRg+zf6gmugnbr6bikKJxXWRGaAAIbOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPYBkDA5gmPQvCzhGN+ImDhQ2CCq8JHGiJzn1xhc3+0=;
 b=kIVP+4HtaLYU0aPOFKBPAGotbKbYT5fdB5DMdPRDCwBKR0D7JxxxSGpAJqFPD2meAF/nNJd0ROeW+bxAJ0Yn8XKOznp+czEbQRBeDSY46cxmbnBTQ1Y/p/eT1Pmy34bm/sA+Q7ky7o6iAx7did1HfUzkrVoxiIKbO2uixzKpa2gKogUafFbYShSZ7PQRKFGsM82cUu7XsIoyv0rBPHYWAL2yCS6BMavgilCZqtLOMrRF6ESjqKDb4C0lh+eJ63QZ3SI4KOmpyQabu8/bCU2DIUX/UVdPxjr5X2wjrCVGKij94wVUb4dFGOfGd19j3trOHiDFyDzsx6NOiuB3jo+6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPYBkDA5gmPQvCzhGN+ImDhQ2CCq8JHGiJzn1xhc3+0=;
 b=Rob5dLdAvs/p0n5cVyzPbXGNL5RRRVw0XnjwmFB4VTUqSoRZ94/5hA737TANpLOT0OLRp14fszHdSEpo3SBHvpZt53ZezswQ8tp5NlMiS+4bsNoc4OCc3pR51iHBw9APb9u4I/VTyv22yFXkRvRrL1ouFpn8uDkPJq9tZ8PB9+dpr2hhPp/FT82SgPMs98DHwvMGKdvn6MLLaDirOhBipsadINjW5bJcuKpLZfh8kaiAu7Bl8H5hxyQsq0wN0PT26IKBvd2IjBTXnvGuG2h8t3csMLNr8UDU8rXyLIQpiuuEytuBdFia2vz0to7oyvUOXClSlPocR05URf/Qy8bA0w==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 MEYP282MB2118.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 02:34:20 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 02:34:20 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     konrad.dybcio@linaro.org, agross@kernel.org, andersson@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, qaz6750 lzy <qaz6750@outlook.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Tue, 25 Jul 2023 10:33:49 +0800
Message-ID: <SY7P282MB378789DB6E1F86190DA3068CB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SY7P282MB37872A5CB962A92934C83125B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
References: <SY7P282MB37872A5CB962A92934C83125B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [uGXmNvLHlsoUox/lPN9kMj2pIo4ytGXd]
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230725023349.1877-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|MEYP282MB2118:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f65d30-0b5d-423b-9fba-08db8cb7a63b
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TV/513dIBdqwQkLcByTPpqYh+MZr3ZOmc+T6wb3v+2fGwbPhUdGHMHql/QT9ochF5KgCUGDlFuZCPQKnY1IgUD2A3Ms4c9uhw18Cba7XbdPKKtbQ8oAKKA0tmSWqa/frst9tSRRQCbpXOGnHv9BMeMLG4DNdqZZ3SsUJt07bfiBt2qNC34J8C5p7HandgtYYiPtPlgXWV4ywUHYPMmmZ/0ujI5Ry+whIM8c+zSq+0d+sJYuj5rdrioNHdopUR4uWNcGuzsnJi3vymHgf+pojfE8cUZQpVsMn6Je9lmww2eOGaIPDVod6/Z07YWuRZNLPGpxMEx3Bv0+JwaETKbmP8I69UwbUXzJFO3j3FbYfqnA2q9oS7lHGqawjRvhpiTXEBgH/41X8s91pK6pJ3sfbav3i1yoj4izx1qX5JzSnoormJ1VRlmeq/oVXQsadFYYV+bsU3kuNpxnJvzdrPfvOSFT2AMDkCNgARJbbBjxyLpKcSf9atf4W2K0OjXSAvOYz5BJkh0rwWYo11v9WeV8AckdjNQJTehAPGyjAjrjXwu5WsHCchGO+XRnXniuuq3asdFYj8HoWE6wRJy9GfC2seO7GVE+x2tjjkryEebpPz4elf/42gj7H74sxUd8snK9PMhSl8W8DuZCB2NGOeGV1e0wvkV/EeePxbu8barSSz4N6mMJC+vj55xkOrRQzT0ej51hmVr/1Jdvf20d5ZcSboeVj1xON4NAqrf4FWhf9kIHjovBIvEZ5+oWWDwp1YBqUCvLPzjK396w/IX7xWpZy2FOZxcYDGiGg/I=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/OleHpfCe0UykOQO/8wpWIlyUx0vcBG6/X5WguS0tCD1XHWtk8PWDVdZ1k6UiXvDhFJb0+0mabu8U9Uh+SzVIWDCb7K5wx6jGYhR0MUw5SBdnbj74vWm3At9hYRSJNdbDrruRBPftt0RBFVpa7WhMWWNse47h84OXoEsWYJnrjfXmiXnY9t4olWCoMIJpnd6b6QVySLrNQE3+xzE4ZZKP4RCBayV38aIahykmm0WhBHRIYZUPSbZ73ZhywvkK86yOO89N3Z55h++RK+bXxk2yuOEP1cAAXwPTyvbTOlvc8FywRL4+HrNyec2YJWM10z1Z2c5xZ+sRKykubxdF/5y5+YMBVcrYnAW2I7XQbWx9e/Yn1e2TcfkczTcbyTl2Qv3XiiwT6FQH6qxUAcBWttnM8zl6CNr6DWz6+MJ20b2Iy3suKLZFiRUv2CZJ+r0ywJ9HLixvEigoYinHm5LoaGb/N7yCKoNBwL1NnMQpkpEStz52qSpMuyPTOeUae4tvv4a7pjXcquwPWDenqq4DeqH4/YHyDwyqXpNj8lsLdU+PHsuLENySEpcP1vW2WgZFDIGVSM63ZvDoJMVVFMm6ttq978q7ZX3tlTAdaYFKXC4pbV3YLWpHFKjNRVtZQIwKA1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkj8eZjsNWAjF/jqWcjrSAUsAtbL3T/qc9I6AFv/8vAyPcweCpTvQEpI9ZSA?=
 =?us-ascii?Q?LvaZlgtxkokdVV+kh1AVOYB9IvdhW7INqdZhIwJhWzuz5vw9M++qWtl/cpqT?=
 =?us-ascii?Q?OtWtkium/cgluyM03IL2JR3ZRD5nSI11NYpn9zHO8yQn/kAJZTAzFNp3TdCY?=
 =?us-ascii?Q?6SILcH/S0Fpzejfnhj/xXR+kNkYz5VuEDN0JrOILoCaojfcTbbOjHecxf6Ne?=
 =?us-ascii?Q?i8qpfeaqkWbwL6B1lOCy9AMX2KpgtjPPlDsdjZUNN9ptc3/qv+zKDtm6rbIt?=
 =?us-ascii?Q?6KkYNxrpi4WSwU1JLp8uX6TeB3TAiCBqmZ1Ln8iMBaAS97PSeWkD4X8Jjkvf?=
 =?us-ascii?Q?BYIoXdiZd+dNPLu0KA81QUCQdSrWSRzEInjcPoBtZk7IxxoY2g52jC3OOAtG?=
 =?us-ascii?Q?3yU3uujRssjWkVgCEaemBmHKkT3KGw4sP0xou1HOSjLF/PPE4VUdCP6kIcS2?=
 =?us-ascii?Q?4xW17eGwF76bjG0F8eOKXelSVU5Cw+WPwxj3uvDqAyZ+UhkbkkOXEnBUrpQ2?=
 =?us-ascii?Q?PliUoypbpex2OZ99c8u0GPLa0VQ5Ly8CSvRhtGSK8SYxXHFFiJd2zqAIWCWM?=
 =?us-ascii?Q?iSEsfTaoNlh+WpJBZSNwh03bQhC8P9Fg+RAMHWtVZVi0fBfl9Wm+gjC691vk?=
 =?us-ascii?Q?XNfrcDwg0uFDvypcs44ViEa9EriaGU6Px6K2pvX7yFAZZ9kA/kDjtyzBFZ2P?=
 =?us-ascii?Q?WnLgYgJwFsnMaJO1SUmJB0ombK4dnsFs9gAsGzbTfr9fVud+1yCYNCyr1mOq?=
 =?us-ascii?Q?Znc0mgyoY6c3MLC1JLlKnvkN7v5fUjKutv38TvTEoGTeKfkTroIvzf2E31Hp?=
 =?us-ascii?Q?JKCqGvhS2aPAZXl/8KaS3syOWzes7EEzoQ4Op3DIIuaZLefADuOOFx+S9Y0L?=
 =?us-ascii?Q?Xms16EjOx2WiPdl7s7uwTBRV8XNwS6wKQQteSmeeNWCizcQRKnzNwoFS56lu?=
 =?us-ascii?Q?7yaNiRvTdo5jPnwm6PFTkb15T7YqQfw853i/6uiEIwwK3S2ToIQZmpNKhU7V?=
 =?us-ascii?Q?H5fJAvgX9sAcWxDULGaYp7TmcEkvQNCCnhcZGMahO3yfsGuaBJaiXJjSqy1I?=
 =?us-ascii?Q?E7XwBeJ281OPHcrJWYZq9NOc/ZTUMurc63zHdMa67dXrpvdWXwGmlPk6YF1L?=
 =?us-ascii?Q?woR1aGZBT4bK5NwvcNaKjnMtZ35NZ5kq2Z7IbXgEzVtJJDtGgq4pSXGgQA1c?=
 =?us-ascii?Q?kDJ7Cp8IcBt/Crr5WoRO75Iraz/LfYU68e3yOQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f65d30-0b5d-423b-9fba-08db8cb7a63b
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 02:34:20.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB2118
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C6 and I2C7 use the same interrupts, which is incorrect.
In the downstream kernel, I2C7 has interrupts of 608 instead of 607.

Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18c822abd..214f6e028 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1231,7 +1231,7 @@ i2c7: i2c@89c000 {
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c7_default>;
-				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.34.1

