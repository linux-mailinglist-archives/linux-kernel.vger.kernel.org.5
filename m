Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33629760BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGYH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGYH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:26:26 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2151.outbound.protection.outlook.com [40.92.62.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44210CB;
        Tue, 25 Jul 2023 00:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8m9csm/a+23A92XjBHQ5UpX3IPKH4WtIUCkftO23ZNZr9z2AO4tq60QfQvUnkCZlSs4RoEeiXy6JnTkARSJiwHizQ5YoAJ7MxWo8J4chWGL12S7aU02XuqFgdIf85umn/fwtHb40g1FAwyDdmvI9uSZm0WHmCw8XFvh8Nf70jKsTNGFewhBuUiWJZCXKh7tIouC3jS2+S1dBz0w5Eccr7rReNgAk+4d54olId/aZXeZvjg7tkrKgmVM+qGrEBoyeBIi3RXNn2bo63uf6kRUY/rQoIslm4zXbcDsf3ojGacE8xTPmqnSBbAq4vuonwF5wplIqR5trrXxRZntY36CUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eSwU0s1MvbskSdycpdTdr5lE+qQnSwjgbXSFTr/zI=;
 b=GQemOrGSAEy2yXbKuy+av6uwebJvhlhIXT2QUN/NC22ZNsVZ9XXR1DGAqpn6zItRrXuxm450zxgvSKsfhkqWsycq6x4iaSWfbULMN5zrY2AxMVJpj8eCrnXLjuQDoHkZKilor4nDQjiOpzdswNYLteOjx09e7Ba0GE8xX5zRwk5y1kY4XOgBQgt0k5ojeY4JfeNyeJQT0pdVbnJm9zeeFlBO8q4KSl2B8Z/aLpIG4xxk8YkBcei+Z55dH2loBLSaYynYNPF0Rmzz/ebqZzGELWnWtLvaR+TGHt5a0nHl5JYOyhkBoeddOh6oDJAjj6Bhwy6uZlMYFqO+072c9pMRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eSwU0s1MvbskSdycpdTdr5lE+qQnSwjgbXSFTr/zI=;
 b=dgUqJSfDfARpZFLvVTIncNvsOUsgaQKOKjnsY+Qw95AuONu0U/UZ8L7ZjNgsxPiO51QW6qxkhlMDZIQZvoVTlVzs5lkrop2HXeymphkizHI/kIZL+06bXeS1CA5kFpkk/1ygo/3fBZOPxzhJ0hwD/Lklhp1FL9rnycD/+6Ouy0oNHmAh3ngatgVXIUOV80f4+Ef+ATbb1KebDrxs7G57fJvcS3VUVqSweP2f+TxbJNjqGH9Xy9Fi9PccHouvlcpEPU26+dm5/GSee3PDniGhcWhM61kRebywPrsCopXc4IPKun43M91d6ppe9rb1LdQgPw9YZSoiu3JqTzf14WqrBQ==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 ME4P282MB0759.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 07:22:56 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:22:56 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qaz6750 lzy <qaz6750@outlook.com>
Subject: [PATCH] arm64: dts: qcom: sm8150: add uart13 node
Date:   Tue, 25 Jul 2023 15:22:38 +0800
Message-ID: <SY7P282MB37870BD990E8EB855A735E15B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EmhWbDPMsVFyhxB++J8EK++m83QNE7uA]
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230725072238.12617-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|ME4P282MB0759:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea88121-f766-4ae6-19da-08db8cdff741
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrX4WI3FElZyhJE0Ba/ALXgLFrv1RGwLPbmMl0+7rjtp0HDfGqE+4htgs6uol4c0icCmDdi9QzfU51iJBLxKoy45DcOZc1OI9DldNeuFfAMuDYnbqSvwdv/YvbAycS0iBr/0nuVpjP+g8UvE/xiiqnksVSBcsuNB5RJc1Er8GrbVQq7NjgR797kwpERhRdCbKKtwWE/SqqJ5sRYjo8KrrjjbKMND2Xl0kiE+bY/giMacF/h3vovlOJtt9KmkU28GLmzgC2m9YcjjCqc91TT4x2R9ca0xcCs4RRCbYNgA+dfyBk8KnTXvfM4tK+684ZbtEAzDkM/BMuYWsPulscucH19BeUYpQtN9ZPgXUqhzEAEdeMqjBnCFluZRJYznP07UafiGcFaNBkn7py2DsF+H8BXt0ll0g2bOkXR2B16J2cvoHXUsoC9E64fxPTpNMHib81gFLkLjROQa7UMLVAxhfHRODwimu7ZCOsKL98lFq+I1S1xOj4kpYtM2oSALrnlklI3Fn+Ad2oCAvqt7qRq3ubkHQqJ6yHLnX9lYzLKDZRgzs3mU1fHyf/ZZ8LXuVoXJGg+fykS+ahsvwhgSgwAvTmtCMXcN7UKsWZa9Sm5T21Pwzsx719J6gxVAYuQbr1HL2XklSCVe9aRemhwrKtACyya3hWBMMzM6OzIiW7edLXH+qF3VsXioGhIkszDRuzcrcVHVDtOfy0PwN+ljmpJ4sZhZ+AYaapMIhXcDt55xXQQ5Fz6cCSOFbdeBhSazlyiAVA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qt8wFRawtMKZgWWJf2/9L0MKEn6umzqJlcpA34T0zD9H61s4R3EkEPq+T5RsfS3PlyzkzkpaAISZSt1kSvkxraX2k2YYRNMLL5TXbNQ1soLZ6Y6O53zblv1di456ub9zgINK7pBqCPCxpuQK/BCDskKl0ErrolazeZrEu18NHvXlmQg7cLxieuKK6iJFt0U6E/XNqs4SrXEO4p/IZRgdWuwG7vzeP6wKKL5mwGypXLxvXJT6FCWs2hbEhCUaFvsCCNLy9EPrGCFR21ggJOxk0R2EgvagO5NREyq+dnG9dSJ6As0XMNJxwpaMyS4tYhGBhqRB8ZZbx1q1dQdVBirOCd2CZM0j5gU5gE2mZuWa/UHVXATqWdMNJwY9WB+fSsoUPlLhaTowx9oYzkYQ+MvK+AsFys/fTBzFANs3tttboLFBcCLJEOqoFYw4ly4j3Iq4yS5nnJp9qTnIRjaGhhXZeBpK0ru8fMnw4APuVtZ5UMNIUasvtB0NeAl/vrzj3WKeVW7Oj6wm+YvUBJuJKIrrSJVGI1VLKPJt7Ay01lq93Gr1Uog82NFCASiZ8OuyBIscklhFJ297RqF7z+yBRHv7KtoI1XpNn5DaiPSKb5d2VA9Ydeq0s3pnVewietvr3WC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNEC/MnG1L8ajRyj3VXsiNCkFJGviu5AAU066E+Ji1WAVo9vDgToxW3+hzfK?=
 =?us-ascii?Q?shW/hkATd6GZ2/qzIkocuwq4MMF5SFIV5X66fKlhHkjAnb0g9qcNfJw+C4FI?=
 =?us-ascii?Q?1xgD2dG9V17S7DhPbfYb4JPX/AGWHaf//OHcJ616IdJfmJL0RdlAuGEThgof?=
 =?us-ascii?Q?WRrfraztR1/14N7Z3fEopGUmQhBoq/1KoxANas7KhC4Le4RndNoE4y8L7p1/?=
 =?us-ascii?Q?9ZhlVa4wLn77DgYJtd7za0NwHDNV4SodDzdDBti+hWQe60vwOH9Iu02QfSCv?=
 =?us-ascii?Q?/LDc82/oIDoDFvU2eji/HC4b6Lq0U2Jq76GdRLsX7XBEsXDiD9ZSa+5JVGlm?=
 =?us-ascii?Q?v5rhtz57R1UUgz5U/pKfSozJLvM4VdGFX+vB4USItLNtLGhx/B1MDXsgXopg?=
 =?us-ascii?Q?52uI3YLfIZjT9FNChcRD24aSevbfJmoB3+2PW7yJVEJvl15hvE74Ql9Jc7T7?=
 =?us-ascii?Q?w7g8zH0TbiDrP3H+x7wqVr1dVv+X/JL8Scdw7Gp7C42J7D+7v6mQIiVtOzbt?=
 =?us-ascii?Q?rCXx7CCgXgEs8A1zjk92kKBVIkRmtL++QA6djfjwRWI64ikfcvxmIgzSr6IO?=
 =?us-ascii?Q?01R8DTYcce4StMo8h6VVLq0t3R8WqTsep/YJdi6hqPkGc8goNdk+Yn6ic6LV?=
 =?us-ascii?Q?aDhexMy2xKFDhxYrkwiNGA3Q5MWlxm3vq1+S0wV+6GmAMpj1D8YAEJRu8Vw8?=
 =?us-ascii?Q?45MfmgUS+i0QNwpOy8iEgAmuyJ4el0uTBHjx35Fja1Ke/bIzjgVkOnkG3UZ0?=
 =?us-ascii?Q?Eht7kUsxgOBAwwdvCw4Wh7/TQSQd4X/V/NPgUbOoB0HFRjkItg9cvjB0N6FJ?=
 =?us-ascii?Q?hpXPKGCo5i/CyJ8xsbLGKQSUSTRqt9IoGdyprOir5YuMCxyGySzCPqjEEmO3?=
 =?us-ascii?Q?m/gcDD/fgLub/xMMG5G2iqPBEJ3yfIYxT+VEEu6z1UCMSc6d/lut7fj9rTF7?=
 =?us-ascii?Q?jny3qB5kIIDRHJC0yMULVnMcLx1t2hURqVEIw7bdoABx1mEw1zAWFnCrnwHc?=
 =?us-ascii?Q?RMauPPatqaVXgc1GHkodEyVnn/Mkp6x3Dw4MQ03CoH1ontOeneqjLGt3M/BO?=
 =?us-ascii?Q?SXWBl0VKyCIN202T0XTHkr5NNlb1DAPiPou+gk+tAGl7lKIgTJ/XkBzB2dTz?=
 =?us-ascii?Q?Joa9IlQ2fq1spSZ1sg9MGODc4uaQcHnIiAHBKCo1BMNxmcijxdGa4BDerxuu?=
 =?us-ascii?Q?Fsb8djxlEyDK9AGkg0O6+lBETthl1hZUxZ1DCw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea88121-f766-4ae6-19da-08db8cdff741
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:22:56.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bluetooth on SM8150 requires uart13

Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18c822abd..837bdb574 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1688,6 +1688,17 @@ spi13: spi@c8c000 {
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000  {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x00c8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				pinctrl-0 = <&qup_uart13_default>;
+				pinctrl-names = "default";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;
@@ -2556,6 +2567,13 @@ qup_spi13_default: qup-spi13-default-state {
 				bias-disable;
 			};
 
+			qup_uart13_default: qup-uart13-default-state {
+				pins = "gpio43", "gpio44", "gpio45", "gpio46";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_i2c14_default: qup-i2c14-default-state {
 				pins = "gpio47", "gpio48";
 				function = "qup14";
-- 
2.34.1

