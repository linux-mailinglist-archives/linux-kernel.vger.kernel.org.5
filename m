Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC7764405
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjG0Cxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG0Cxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:53:44 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2179.outbound.protection.outlook.com [40.92.63.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210711BC6;
        Wed, 26 Jul 2023 19:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcEOEcnAAeq251wl5L13lyFQSnAYrtRF8KM+MU8fS5vdq8PEujHH+hKoC++mdyFI0Lm556DJ8rjBxAaYosgyNeszPlYBsk8iEgBGsfvq79jAinD3F1sWen6z8SR8mXHaDQuMVI8fP8vQ+egeH7ikN1PgiK8vY1Avx1ypOKVHc8ZMIrjS4XtEHzh+o4Pu6LkNKPf04PCkLK0YWTUVPHn0aElKkWcWRfPnOGyWmfx/9lXPP1TSJGEWGFY6uKO5sWEkrqxiq9q0HGKsdR0+O1yBtsoBTlZGyd0S+eEQZslBrYYdd34hRhG3xYO2PTcrTJoneFW+kNJ1f493Q+KcVLoO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wGxkkEv/bqDo2FqsafpURzTserxWrJGFj8jW4N8vl4=;
 b=mhPQBFDs8EesN4P4yyIaaOclqnfpaaTMuCO7t38UX1UiJ5N7nt/PR0YeFYWTbswN/mxQjumSuP9y3AzI/a0g0J66JFmFeSpm+kx/XYN50cUZ+p1MtIpTcqTMbjmc9dJ8wSBap5UC025w/m4RhajAeQDP/OPp7tPeGXViEqaKB3DYkhtdtap0gv2G+fDN6gaGgIxtuIY1HIPDKu6bPx0uZbBC0/KjD4LVpX5CqAySrU+gcI4WX1d2rvbW04f25b/oj5VCbv9FX5aWTeYEGpaqOZ3+VtWiVZWGeo/rZU8v9mZgreFx1GYKKGVy6Qi/KX7dC0+bdMWPwxTj+7pnFQqkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wGxkkEv/bqDo2FqsafpURzTserxWrJGFj8jW4N8vl4=;
 b=N42wTqcHZRBfrFCUiwpruyRR03yAAARXNwCLh3URko7DHnkv/ExuQZjB+8fak31S19HfbtU4tarG5scYK2j3VJWraleyWd29fZUwqXNI4i3bSzRmLJcbuP3OQfgbQUISKFffaFf+e3J2iNVaqaYHPIQROf3Pmg/THn+RYFP8sG9JFp5LHSU8K44VcnDu6R2+mNuVW9j5oKnjDS3JOa3w2zKg4f0ygkTaYrqFTZK/V4yllhX85J1TuA7j8tuOABxqcCdG+VKm6s38Rv9azIfdT8TQ4Z/lxYJdjlZoZVz3ztqkeJH6frYL1ym4/tD3vdLSQT2Way/oQoPH0IAzuvug4w==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 MEAP282MB0165.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:70::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 02:53:36 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:53:36 +0000
From:   Zeyan Li <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeyan Li <qaz6750@outlook.com>
Subject: [PATCH V3] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Thu, 27 Jul 2023 10:53:21 +0800
Message-ID: <SY7P282MB378712225CBCEA95FE71554DB201A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [38AyjQir+pCzIUxx+yxku5O6OL2A/82c]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230727025321.8094-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|MEAP282MB0165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5234396c-83c0-4192-5f8c-08db8e4cac4d
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TX8qw5XTx6nNoIP9Rg/0Gg/5WvOI6S+E26z/K385q2EMUeShxWT/JJAqD8cbtSr/ipE81jL7fAEDY26bkxH5Mj8P/ESzAaEsMQ7qsLdx+gcRD5qPxLzUxukN3keKSxsbFepsIGLdr/781VbLl5fMrbWAVBHS44gzpMJEcjUCX42qIowoIv/P4Pp99np+vpYXTz3jPM18wpcHcsmSfw2Gx/kNO+hhiVPHVXZCtlvcN0ksgz4hHmjEzB56yx8nXuTzy8yFE1RQ/uKaF5ebYtNj7aggTtBlEKf2T6oxAkLj3ThyZe0Z7pNDlJy8wtQVm/dcsuzkxSZY9pFK9ZkH9aXB5y8xTrCmutFuQPz2lYsBwn+iOCpsJYxSqMQ3gsK1VVwxk4K9hsw2XDq72WfAzJBpnWhyRR+sDVIIgPyg95S/tF3qEV5McCLg0C4BlhkQdGW+dGMK+bYtExhi2ORBSNxzXGrhnV/axWKR2xU+1hdiFiVHzMRsN+jxtRDhKqUkyS9+g6kvczzMacNtlfxs0aREeRNMpO5m9zIdL4xbVfy0ZxukPZkRuM0SVtHYp5UF18TYOAw47fP3G4AtE+SS5rzUA9n57uvWVGwcT2LfOsqDHqqV+H07EJoJDBXVSsAOuUEePD0WOzTd6HjLFTQ67Qz8QgT6CvbB7BPw0FxBJ/mqNYPCLCgKQU03D9Ow0ys7/yuhGDO3PdPVWhlsGLe8Frq50T7nSelZRxwozzOjtjNlUw+7yqHiHHSmHAIN+Np0oltzE/Quvc1ra4ZUzbZwuyIKtjfhxARGEBXCtQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaDW204u0dCD0Xpx+wYH9/rfBMQC7SaOrGrFN2nXNxFzbuBUPWjZ93WEhaffV+QuTQBjjGatSAp+icR/dsEh/muBATQfSJ53RzJ8vGAfBqplz5ooANNRHnCCrY6GMWwT48thfBH8k6GiePwlunG4RC6wc7Pfzo1qkTMiArxLspO3W3TGOSmcINfUVkd5vVuWZ3Iylw/Ozy/zhYMyxRiOn8PHG60uZAnwhqKNDv3IKYj6ltaZbOqXsKjNrG28Kd+is10imn8wrVEvgggILjFAXpPtsqty5KD7w05Sg9W5Bo74stq35JgHFHcxDPkx0i065ZtazUPWAIaN1dXSKdjsP4RrwYMAdQF/ntC8ggW1rL/xiuTg60hfX1VcFMAsrQtepNN3QirrKb+G5nsiaoJ6cLB5XJXx8aFXTa5BSaeJ8BNg6Wa3vzWBCissWREgszcMkr95qXlOzkgVE8jET+n1wRhfP/d9Ihl5u3zud90BMnr51aEHEF/Sme3poee1X5lnyLT+KsSFmNrNhPCyqSh5FsKGARoHAs7TJB9D2Wd2fzZrks1KA0SB7xfsctmX11BahAaNTErGpjyTSKxNF6NSn4furhSBW1qER/4DIYn7QGevveQ5Igdi6V2OMny4Rn3X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miwmx92SK1if6OchxN8PjbxZ/HEiYGvAORnU8Gd1LD4wYQV/WercQ6IxXn9Z?=
 =?us-ascii?Q?ZRGdhbwd0wP9t9VeMH++lo0fvf81Kc3XAYxzbl6bjjmLskdMQYop3bKn3uag?=
 =?us-ascii?Q?P3/5yVkegTNm0POklytUgCu/H6wRvWjiXWIxIK6jl9VaIONuc6z/AhL4SybB?=
 =?us-ascii?Q?xYkx5CV0UMVQF9RdgNiBEeezVt0eJDXtiE3niY2vvc4LDUYp09o8/j5gA6iS?=
 =?us-ascii?Q?KrRDCatG3BhIge26LWY6ztu7V+x9E18y25vcZRMgYjdPUxnnS8miyo6CfFAQ?=
 =?us-ascii?Q?g7IDOGFi+fVE63yBsMrCpE5kwSKJ6NjS81OqfAEO+/6FbJK/iz70np+5P10u?=
 =?us-ascii?Q?SC0HV9V6QPEz/qAxweEb3QGkwEfs+u/ey5+YYZu+L74ClVtplEMWNBnw2p1j?=
 =?us-ascii?Q?ViDI27KtMyydbyOenFVB1IQgzVbFSiYA+Kj3nh0oOXvTtNENcaDS0ND/PutQ?=
 =?us-ascii?Q?w+yq9kxmtiagKhbWz6b5X5W916SwXJjs4lvsnylpGusQKyJ3ma7wxo1KpFVR?=
 =?us-ascii?Q?+BvqurzMURftiXmt0V6b9ueFqQFSD8gEEMtHzqxfeIkj+XE6bNixVytkHKec?=
 =?us-ascii?Q?a57hBO0DkRbKazWA9UJedHAol+7tp1PXPKSTCl/lD+0c1QpyXBs0Nxt3Dr8j?=
 =?us-ascii?Q?gWDqV+E7QFGbSLKuCCbtDkBUpgq3HLhYgdLk1iDvUM/xB8mCPTqhJzbw+JuI?=
 =?us-ascii?Q?eQpAd3tvHjXoKpQsgjYl/S2gaTBrZ+G9y/CB10lX7O2TW7Nr3ZCVxXFES5R9?=
 =?us-ascii?Q?sOlwoavDoGmOsmgBqdTXkLLpAbCkrG/ZBPlOVJfk5qQ51tW9Bt9va5cGETGF?=
 =?us-ascii?Q?aUMDtlQbxznWvx8xKkSQtWbUk3BgrcVbiXiA1cSBZ30ByUAw6Eszd0a3lsi+?=
 =?us-ascii?Q?3SbQh87Eb5U4r3cx3T4l/FaxA2P9vuAuQXZjgDiH/n6VMBeLXwWMQQqwm8ew?=
 =?us-ascii?Q?AnxOs68mS5yA3Sn8gyhshG6CgbalsJV3ME164GLryK2YKLXRbGxCZJ6v76CY?=
 =?us-ascii?Q?JLwm/mtjYQ1e29vWu7vXM3gaJJy0ZgQB+ZZX4kttM1CgxL1zAH3yA2cxvjB7?=
 =?us-ascii?Q?bgW/NObpqybkui18tqUDFk8QbNHfVag4eJEhkVKR1frnPJkwa5fCvRjDGPTu?=
 =?us-ascii?Q?15KtIqOqtCmP9rxW4LDYreJZZHUFCspwgZrwIAIk30Oxqn1m+KRahCB7KO0t?=
 =?us-ascii?Q?TekM3RcotYjAKfhQUSB3I+ZIQxhTck4qGeBJjg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5234396c-83c0-4192-5f8c-08db8e4cac4d
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:53:36.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C6 and I2C7 use the same interrupts, which is incorrect.
In the downstream kernel, I2C7 has interrupts of 608 instead of 607.

Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
Signed-off-by: Zeyan Li <qaz6750@outlook.com>
---
 [v3] Change to use my real name
 [v2] Fixed issue of not using full name

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18c822abdb88..214f6e028f3c 100644
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

