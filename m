Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2F75FBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGXQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:22:03 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2188.outbound.protection.outlook.com [40.92.63.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEED10E2;
        Mon, 24 Jul 2023 09:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYpY6ZeEl7n9CLZDK0275ZqcI9GQGH+f9ub94b7sV6hfobWQFikwOh257o7genFAUHt5JtZWwqKlUV2EWbVcbwKGNI/Yl82zOpWoGht50wvLiM0W+HHeSY4QcfMGEkQ6E99HScuSF2Gi+vC4hUhELJzQJocdLhKo42OZSrKGoeKROA+rNtbtu2JoTFQhiPK+tDZsET6OFmqTSM/lL9IUgZZYpvupFtNCATiSrqWaY4/nPLEu7eCzybQ+Y3QAE5a7OwsrphE5KcQUqPr604DmpD3euvthHnXFqG2YkNWiEd/E8m9rn8/0aaQzi8u6d1uUrBSR8I8XoI4BJ8h6zJp6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGjnrMBq87VnA0nCG5IzPuQYePthRqwMrIyIxrdQpeA=;
 b=jEprsDj6yLZ7L5jilVwuLdy/ivwPK/65UGfGeQjY74/GX8gJaJpF2vazGEABacQ7+d4w8Qz0FggCsh6LCbgk55y2kakkxvPSWYAZZUa0mbacevl4erv3O6JmaBNSDZ+kX0u+YmW/Ie/BpqVxNVC4sUrZPA3BA5fSXxP6Q4Wb962DKhYFE7OlCHSdn7Kj2lpSC9JlJ2XwrZTo8hJGJh4skgUEh9TGIJYzlq1uYuIn7/aV2g1eS/WY8jya+y9PfQO+dxIzHfE8brbRRN+Y2IiAg4mXvXMkA0J4xK3LaIUE3iA7XroD1E5SQDHJRgArha952GI0MZsaOVEKUvg85DVhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGjnrMBq87VnA0nCG5IzPuQYePthRqwMrIyIxrdQpeA=;
 b=jYGnHFM4Epx254/bEpsQfRHT6D0I7gfSTTG9lQyWELSg+0SPMrgYS27zxEjElLd2SBVXmiil0OVkp9zn4hnO2f3aIY0Le2wfEZpLnDMF223e+2eIxXnRDOzalsC7Xl9JWczu5TttBd0lMhXelsaYiue4yUih0hlI+cEg5P+HZ8JfXL2PcH6wQ3246kRSc7Lf8xZY+y2luCUpdZebXNIWIUI/NK9it18x0RTi4SeJf3rr99tfGP7FdCZsok7am3Ur32CJ3j2GeMguD1Xs3chE6d1D4mwaVGHKdLyMEznRawtYOrIOe0qdJm93z+Rfy+sTkhWrv004vo47/jjdByB1OQ==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 MEYP282MB1992.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 16:21:56 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:21:56 +0000
From:   qaz6750 <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qaz6750 <qaz6750@outlook.com>
Subject: [PATCH] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Tue, 25 Jul 2023 00:21:44 +0800
Message-ID: <SY7P282MB3787F073ED6E860E820C6CDDB202A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+WJZ+ggnaeuncikAxH4HGqyMSEifdRCc]
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230724162144.6723-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|MEYP282MB1992:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f20672-b269-4c66-b228-08db8c621947
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TV/513dIBdqwXNPzcfoboCEUq8fbrnIhg3aeaRWLx1W9j7/Cn3iui0RYhLlbqe6tPwfwaoiqUQ1DIkqOm7Xfu+W4R/slioVhC9bbqO+lUQTX9WRB06oxVeGOEhiMnUZ7553ixMHX0+VLQuKGgXPRi1f0H9mR7XOwRckvqUoaPQVMTJ6y81pWO5VcrDNzODqOWBj582NclIFz7Jv7cXajyggOMzGeEZOyZ7v+QanyRJQ4uls6KguQ1qE/ZI8xdB9fqCTi1VF4zrOTk5QecIF9Tt29ONBWJHDlskI3NVgUMKtCUtmIQDue6Zh6Z9d7ZVeLO/kD6S7Kerv6v3s4GsQcMR0voetGxSutbry5Vv09PC9Sq/bZroUpPp7hr45hG61zIsr5I0wN/qE564WZ2wzQNYO0rvKYEWXHAfjTV3yY8pazql09Wqae7cYLUXVcJYTKBIo7a4b5v/YY+GBolh/XliBjbYrfJ7qyw9ePkGKxRXjgHjcIzwF2I7qGKkD+zYhY0jFD/IEvIlfcFiKcZZVvmu4Tvd+0rXqGx2nVlt7Bxl0DEfjtKvrpbt5PpBdS3tKtgfCkRBaO1wcnV6sKxWOvCGZ3C0SNrQ05jWEljKyF6yXXIxSAyCfmE/a7eeL98pW3TinJIWyFiU9lH5ZGgwrX5IoHKQhom6miHopBi/5ub548bDT6bt2GhaKG1/Q2L7s3LlCh0T1WhpZ9gVbD3ZqKKRewKK3tm5bRzVTDch5iHCSMA4wqC9PcvWelFZxW7asLpQFEDmpOKFHYxb9TnBMvkia1LFfRcKqq08=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaK1bsaqlGmEK2fa4tFhfhytFJJ+XEs021ehgU7G8aoefIpQqBwLhlhc08fcdez71Ux3mI/F8DEwLhvlK0ezrSGcw+fv8x7nPFTJBh9VkpSfl63iBxeFpW51JFpiihkX4YflmnqG1pPQW77R7CDQW84rR0YR8l/t7X/3BuvJHk3L6zVuKQ+XtfMOiwEkF6jXseD97iywK5OkfdS3foLufNX8hsREONDIP6p5WI3yhhxCKIj1m6p3fRwrhDiPkyOgnOdP9TeC+RqpXeR2CKdRDFfxlZ4SVvHgEAYgFGh4G9iXXNfKnKbVpxEjo6z4UP6cSh7eNYA+5J85TkX8bGyQ8pNcgvQwla7rYyd5wJtGrc2SPRKxSDHq5VZNzugyycsqeLZG9JmYwfh6bUdl8gfwr+CyyOfFzlsy+o+ZuIQx4c5Hj9jsxUV/6TCjmXp1NgM9vFgfayvDFr/WdcWt1w7kXBoTg5C+xBkm9LYoM3+9oWv8yKkyvzvdmlgeEl2CX0F9TSl+n7C2C5v8xkBLtO0SJPIbZl7QiKzP0GhUEbdaEvGeDhW294TBlW6b9MqzwgcbKCa555RKNsJTdT6kAJ3WqVrimHJSqMCwg7cRp9JeInTIEmSEL9jOd5pr2oqX5gkK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDKMexMzO+miMROtNiawjwVwDTa7ER5Hy9M4zjSsdx0qTIksGsuJP4REG67o?=
 =?us-ascii?Q?/AqxuMSjl9P8xsTIzs5tveOFS5f+9iY/qNoMukpPF/qEgFWzpP3nDaUCvyJt?=
 =?us-ascii?Q?Ei0hopfgoFUcWGAE0Akw4Xf/8aL2HExoGhhal36yX/y/GStmj2RBC7WeUw3N?=
 =?us-ascii?Q?pSuLN4uxRM36MLikTM5L/96PdtoH9PkIYbdocWFaQN9bihFi3UbIRv1kCANC?=
 =?us-ascii?Q?kDafLWqoqgHqE+W4aDNZlHXPf9KXSKRgzjGS3OTAfizwB/IMTDsbK3LJ5XtL?=
 =?us-ascii?Q?Gb5uDVG5sUYqgd7LFYNoohl/Gonxj/WfAb/THidadeylMK+7bLZPYU77XW7t?=
 =?us-ascii?Q?Q4n3MUgVBRwDMcMCkw7viKJp9IEnv+H8PX0sHRcCRwht69G1yFIJNP+v5yBT?=
 =?us-ascii?Q?0HiJ8HRsayZXUmk6Xl7gz/TUVOiA22w9mxfkuXfnbEQa0pB6xDniDROTSTQG?=
 =?us-ascii?Q?bDM5uaJwakybDtyuKQOfX/hMAdGwgdyvF1oSBCuRKJwIiD3XZuktqHo/bV82?=
 =?us-ascii?Q?c3hUZfeiQe3jJUNeWoOkY9WFjswq8vYo+5+Q2/K6soevP6jk39HYGGbhferh?=
 =?us-ascii?Q?4wgRpkNaZPkkAwR4ZGjWTyAosUUP65y5RfBNo3XR2QC4Lj1qohetknH9xSQK?=
 =?us-ascii?Q?moeeQ/CXa1BygmYDEJ/VfyqWrpP5jlw2JCAwx1Ptm+iDSnPoPSGCXMKHkdPf?=
 =?us-ascii?Q?G3zCZCGYo3n6ksN9+1Oiq3khUdBtB0UEINBghUu8gximu4MyiE1tFntR3il/?=
 =?us-ascii?Q?tg55AJmd04cse1cXAcsnUTH+19loYCjLlJa4PnK3n3UigZEqtA1KPG9Vc0qT?=
 =?us-ascii?Q?nxAonwYpxcZdGM7hT7x3GzFQUfY6I7If3AY39sY/si6F4MCz0fgwHW2PEy13?=
 =?us-ascii?Q?SxZrSKTuAb4b0Gvx6sP8rLlfPleYF3I1aw7aIli3aIRLM8Bz1KhpXKX9bY4o?=
 =?us-ascii?Q?qjFRhB0VXuh+wOJ7v1pRD383K3/FJJ+m9BSy69EE5lpM/l5CU4UJbmdBfpdX?=
 =?us-ascii?Q?TlRtzShEu6Ec9TkaeLd9oAohye0Lyd7rAa0ufarQnAZI4ice02c6DP7iP+Ii?=
 =?us-ascii?Q?HG844WctO1hFV7/SG/kvdFUVkFAtZPwbeFATmB2DiY038PEzAmkeh1cANdv5?=
 =?us-ascii?Q?Gwwu/Kca5gN/t3QEedM3RNLXxvAv02YwDyqqely2kxOcBruSl302yvQf8FfI?=
 =?us-ascii?Q?jmT3lcnqoYxwdh40jI/hkhJjpOSwbnZTJXEKIw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f20672-b269-4c66-b228-08db8c621947
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 16:21:56.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1992
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

Signed-off-by: qaz6750 <qaz6750@outlook.com>
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

