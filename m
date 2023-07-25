Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA29760D69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGYIoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjGYIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:29 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2144.outbound.protection.outlook.com [40.92.62.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF1212B;
        Tue, 25 Jul 2023 01:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar6g+MGm4RF4OwPIndoQuDooOOcz52PiY8DFJbGdCws1HBLO9qGUPPvGxkPcGVM0SNlXJ0hs8mNEh7SUae6V803DrBxW9OviElORNn5U/gwyGYia92sz4ibWItzILx7PwSID52w/mn2EpIVA0n+4gATNydbvNT33GZlenCe/Gi/L0MtgowYwkW+L9XCdtWqqgnpBp9zP24WSStZ+FrFsnq1FKRXsuigt4KKbBuaL2SqjZjaohf6/FhHnElhTxts/i6oRZygDWNmM3Iq7buCTnyir1gm9WtXEitzfi2Vcqphq1d5AQaqFa3/+SwBZ+LsbHm0Ww+oY0aj44kLAR+1+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/dApoG4wxjN+GmCz5K5Pfvm2B2FhAGa7a66D/EvpHg=;
 b=a42TMBKoyIgV4G0ovYJGToWjokI6oHE+NdahfLiOc4kSsy2L9KvMWFT9TSB/h36qcYFepnFKvwVbOFZQH312y/1C/5HrX9SWkWgL42uNvjPkeDHp+7qiEkqm4rlK9LSG5yE8qBQsHLf1FZyCcMXfUYscj06miJ01+BpkjOpj2+77JE6d67odU8MMiyxJsOuLL36hM6SOA6W4icZ++9HELloCSgWyScf1EdVin/4zgQHhXmTa4g4oRyYpPukbI5PGMv1dqn+7XX0zMaHmONXaqT+mPpKUJotIoxo2V8hW8cn/Z0n974gNvRDKaKKW9rt7UixS63lvgYjcbUzpe1SxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/dApoG4wxjN+GmCz5K5Pfvm2B2FhAGa7a66D/EvpHg=;
 b=IaKPRb2eReZSBrp++MBmmeOUJmn7SEoqYWBvU0cICK5W1HiCNgBP7Ijnu3uHbwNCiuFR4NX+BJI7A42fFBBvOQCOpdkYFXrAGaVzr7IjlE6JXAHJSg+KYL0AY1l0BkzU5LSBjY+yU4gq6h3eM0TIXQ7cOXJtXH2oqhZu2SwqoBc6dI8Bj9Yhw25kNbEKAlNjeFaRz6kp94rB/+DYRB7WxcMmmSuxGSN9tb5xCbl3vEyI8g7g9dXhgxdiwQyIc/Zy6KoQ5UnFf3/N9ThwPJG6eDFd00jAOvnSQoi0vxUwvX9W1U/ahuC+PWZRLSslUYkjreOMSKfDjb9CXrjT+52gaQ==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 SYBP282MB0634.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:19::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Tue, 25 Jul 2023 08:42:21 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:42:21 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qaz6750 lzy <qaz6750@outlook.com>
Subject: [PATCH V2] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Tue, 25 Jul 2023 16:42:07 +0800
Message-ID: <SY7P282MB378740C6070900BEBF5D0D7CB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gdxIVWp+TGE076DYqADzFU5GBzoJ4IHO]
X-ClientProxiedBy: TYCPR01CA0103.jpnprd01.prod.outlook.com
 (2603:1096:405:4::19) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230725084207.14241-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|SYBP282MB0634:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2eed19-2f35-4243-53c1-08db8ceb0fca
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWbjtb71ZXpDr6mXuErGSY3k3IhA0xAW7zo6Z8Gn6R0SBEdAVjtdq/zVrrkOu98fceRkBUwwwCgxeiYWKP+qtg79YWmZ/qCOzh1msww0nqk81XbXk96ZwHu+xOEtU/2vbrnk+4IDXeCcfxazCYIaTp9HDl7VSkCwi3XT1nOUDO0IkieX0dbtzwgGxMF8o5PE4nRb9VtfDlR6AjXEt2bWOTsMU9rcZcS9UQH3RydQldPE7enuBdKf/e/vK86yLixfqbKl0COeJNwJ8c0FxHTehCMlcjehY3dKKst8NYKbJsQfx7EUN0wGEi3vdLKZ+jn/chuzyo6xzw6vzUcemGH/twA9IV1/ofzWO3TcaDLPDSnSKzH0wkY4fztSRx7V9Bjvxdj+tGGtiJ4BHzjl2JZ/gT1zyyjsTzz8f4smItFTdzobtshTL+/pVY6ImiDAFeZfNw+l6mC6kaaGIUH0XLTJi1M43qVdy7VvhxIjkd7taDoEuOUTx/XOoPle4gHc3x8umBia+ml8fYOhD8YQXkKAmY9ZsoGtGgEF3p4QwjDJ15oBgAa2JdED6t9Ja73ig7dxgx2NXzcLRcwNg9PyquiaqJn2dEraCnHovxlAvKDdXuUNiuu6dQfQUxYwhMcTkahN1mUkzvpjresLYoDBkUxXb/jge4cyddvchHFamKttBse3TLi/B646IjdHiwnO6SYY+qfh6BOqpWbXoXu0Gdzn2CvyrOEnYEqqj0R/Az2fgxuKyAgnLrCXA407jd7tbBtzBzKemNQLUHWWxrNNePBe99asHQaUQVZELs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlIUHXEcw0C0qUgR6P5KNJ0rGt6p6I1sTi2F1BdiqhtXisNVd6IG+9dM8TrU8pCoWGb++D8opqEV0pMPpkhHOFptWa0I/2nOb7a0oOO48GGK6/OkX9X/09Ivj8NyrPIEfNXNmvLN3RSsOguBoz1ZPc30bVW7WiAMSFQFvPNeQs9uM0xMEx5PP0kGAMWbq3dzY3TnsWlFufhNeWdlzJxNNEw1AQSX22bRNngFocRnwa3SsJ1jAR7Ogs70Y2JRZTeakJY+yysaaiJQHvNqYdIDEL6/0de9bpj20Szw3bxVdbV7FUVSoCKW+K6F1ppq9TlOueJEH/p3zW2Ep9EBbMld4Oe6YIpdFz5VIowCN5lX6YPgDYG679rnDDwVNkqIRQDxorcqJBGJG1GPAUERUp7eAOA+19k4wgTq1bqnbX233K5dLP+dIZXH9WvydI3CUssWOjBn15Oc8wPxjCURFIkssqOl3lALtSdfEPohZL+4R37xX4v8kERSsg0HiIIETGOvlMYmy/8EpN4lT6hmpdtWf8KGDCqKUyNSBeqS2NtQ98hGm2WHYSo4ixUJu2EFqBjV0i5Ea+Irj7puhUE9r2FkY4rfiiZvLUsWXadjsStW3c41MqLOz7Mmj7G70ZNLyk7X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AC7WcqaFWs/Ltx8tGpXxLO0kuX+rWOALRnkifCPOX4BJ3k3lXpPPAa/3MhxQ?=
 =?us-ascii?Q?j4NqxTXuhMHvSw/U4H1ZG6XR6Sr/ac61CTlQUiYm7+6iJOySPfDp+giB+NfA?=
 =?us-ascii?Q?bMfbeIGE9O3JU2Dr0G5r4tVzGqRt69R1UUFiG/7KEqzyRzcF101pPSVr3ZGk?=
 =?us-ascii?Q?quiyugCWLaAFaiWP+WHoTteiXSNH/onhsdeWiP319BbHKu6YKaiVqgpNFKNE?=
 =?us-ascii?Q?HplIdxXONEn91GwH627QFJxsPUKeN+fW16fdX6bq008eCCq8BWo7KoWwHIST?=
 =?us-ascii?Q?PkBXYVnSyC8LCQgDvXfCOi0sQdegJMK7qdpM8w4fi8zdsPCsbD4EtKplQAdj?=
 =?us-ascii?Q?vz74VXtxnzAAePgCIU5JSbYcOf+UfO8rh6e8dc/ulU4KF034NWFzOGy7TbX5?=
 =?us-ascii?Q?+M/EDbdBFc9oSz3QaEIG0LSq+731Gu+jppbzytRDMqf6ZdTosgVgsAJXRPpu?=
 =?us-ascii?Q?4cJ8BPGeg4kc8t9CgBAAXW80fV+VAficaGlMDYQG1vAu/5tRPgLkNfVtYUYL?=
 =?us-ascii?Q?G9rZy0nEDEPZPbEDEOHG6zPFvRyEEjqivvrMf4J7UeYy0uvODrTKUfGgWCif?=
 =?us-ascii?Q?mE5S3FZCQNCf0+x32/PproYiTLd1fawwsizjIDPhkvgICoXR7iJRVKfiqqAD?=
 =?us-ascii?Q?mnZznoPYutKRhiUlVAjqaJIDrKH220z/ev38s6cTaha3nKyht90DXfaUXAa9?=
 =?us-ascii?Q?9G8joP6WEUKqAtUJYV1l3OhIVdKSdFjrzTniS4fNgBJuN7BZI9NUxypKMdQJ?=
 =?us-ascii?Q?MNva44hKslizpNWSs/dOiCteDMAn/1qiPlBlGCYgzoAnn60EjBdYs1B25GCf?=
 =?us-ascii?Q?YStZUZthEUPTBu680x0d++B+LNd9NgEOdEusgNMsZe+D9nrZW8mA+Hn3FfSq?=
 =?us-ascii?Q?SBIugr/KJAZjy9g9fIW68gZlT0YrsigFH+NC7+bhI3VnKeg9DwwTTInLtmpC?=
 =?us-ascii?Q?NR+qTnK60uAhKRpqLcgAGR3MCPDyYrnO54NPW4xDqf67cGU5Vlq4eF1F+iWD?=
 =?us-ascii?Q?S/nHNSHN30hUE5StWh0JqBsQytDoSykAgVyFNARRq4u0Ti6PM1q/HZc4/erW?=
 =?us-ascii?Q?a8mr2i2Q2j+Kejharg7LEpw01dGoGEGnoi1OLpblFXd/4TsTTD6k/MBgQ5Wj?=
 =?us-ascii?Q?REpJn55YitBng622eGqb6d04I6BHv3WK2KLYy91ZJo86afuNbHy5JGkAr/Nv?=
 =?us-ascii?Q?NInM6Q6HSDgbJC39vy7ykBBi1X5c85JB+eax9w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2eed19-2f35-4243-53c1-08db8ceb0fca
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:42:21.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB0634
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

Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>
---
 [v2] Fixed issue of not using full name

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 837bdb574743..560b758b0a06 100644
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

