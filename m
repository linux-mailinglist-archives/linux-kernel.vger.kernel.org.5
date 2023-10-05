Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4917BA2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjJEPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJEPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:03 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2158.outbound.protection.outlook.com [40.92.63.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE783F1;
        Thu,  5 Oct 2023 07:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB6++UUm0CwtUEr3EuRzPHnXx42aaTZ+qRlEpl7UQfSBBy/C+pyOMsrKjNiikW4VPlBZP8t57L6EzaRONxDEp3UeiN1gu3YuouMEo+UKeXFueRnXylnSc/lCJxqTbnDdzORi2bnJ8V4Ikl8m1aDnXQseJ4krlA/7/FklxOBheQi4dY3fvOvvOq6uRZF82k10sb0sRBnCWni7iXWrE/LaWf37P1b+mBdXAEMWtPhC1dNP1dTu+nffudmluXW8miobYKlWc5TvcmMGVFU53t6jEUMeeoPxFO2SbUcgZNyh5/KTsQYvAz5nENYtpWvu7qgjzFbaIyKcwy1OLxcrxHJjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVaKr4FmmxFpG3auDFkvM/yhzzgqt+4Z+CfST04pzzE=;
 b=cn9oDyte6eL6v0lnRFRc6AQHb6Gf+dtDwZaV0OogPVoCRN6W1Sf9hje9nmT0SnTLKT15GHZ9VMpP3+dIM60RsN0DHZyU2CGbWL0bNIiQ/hi6eWdBtfaiDV6WS7EuvCQVOgy+egfpQH/5w11zmf7/SCNW0ggJg2oy3nOHkQSCte2Pb18OyKDjS+bXPGw7htiZQKXUoTJ3Pl1sv++XO3grhFHyRUKHI9HaZgiW23MG7c1AzCUdLlC+aryyJaaL/z+itO8cv3kekpJUJ4nJfTxJExpIcKYuM0A6nofPensNL6iUnmcbSqq+3H0HRH1phRw8b3aLDNagHgG4mJNQkVWtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVaKr4FmmxFpG3auDFkvM/yhzzgqt+4Z+CfST04pzzE=;
 b=skJegABzCLuMC92narmWHMECv/WD1BlqNwIJghYG2eRIwownXJPdM/7TQDqreLzwf8a193XYP9C81yhDV8IpwjEiu7QnyDWCULwFMQqibW/vdC7Wm3sHlGXNVI1mYdrPF9m8fyEmW+2OMIAL1qh0K5aXcvG3C9eYbyWuNuGxkb5NAa2c4FVWBTn+XJ5uPgTtmMeXZdm8rYTYJGfzCjIR/FgE1Hy+QJ6DeelnR+/bLCD4yrhGxL/0GPF3XzRVUxuFfdcHllqo0qy8Zwdph6uaY3gMqkHwz2F0XkzSocO+0HjKkQp/XGDrBdLeBq3nwlzT5K7dL5njg0RWWDpDL7iQRw==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 ME4P282MB1366.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:97::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 5 Oct 2023 14:31:20 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::448c:c25:de75:905a]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::448c:c25:de75:905a%7]) with mapi id 15.20.6792.020; Thu, 5 Oct 2023
 14:31:20 +0000
From:   ZeYan Li <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ZeYan Li <qaz6750@outlook.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi 9
Date:   Thu,  5 Oct 2023 22:31:02 +0800
Message-ID: <SY7P282MB37876D9914F4E7016DB84723B2CAA@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Us+AZd9HahJSKmCSQ0RPRQSRev6fqguL]
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20231005143102.8933-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|ME4P282MB1366:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d62d5a-83da-46dc-9ced-08dbc5afbdde
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDs7iJMrcbBYpvgFm2EnumEUBuR23uuDoI146Et3aTi5/IEiZJzcK7HvMrhIrk3SvAzYzFkVthGxaPF76+ZXGQX2F19SR8kLlpjDFb9+QZva86aXM1I64Cm8ug/tZ6nLWblO09du51MFzi+V6Sw3AAl5n2A2qTuv7vgxflsmAwBeIZDDFhEmjKxcRmuW0qn/jUHyTU8iaKy5Ad/I78LeDLl8tNGNg+yBXA0RXrdmteGrjwf2kDdQPcCx6yDXdWrFCy2n7BQdKX17gbO5qa44ZLF3+Yum28hTlZfWiPqOxKlfgDpkv5NwCI1VUI22FizYrtfMCCYs6HdIOdJl0jMcKmBZQNiiR9WnlAc4a7H8K9it8dbt8XFZxWf4DDTyyjmR2ZwK73vjmA0aGocqnAufgKb0oKTosqzKJMy03RwEAbeRfuSJkSLxIFst4qLRTU1md8/ZUqyPWbhm/Onj2DkPNNYsvaG05y12QeTAtPVGFn8xQNJORdXD2AcTN9OWUiN+ldC2BYZFG9IOPa62qu/rqkvb4FCj2v8K1JsBdPDHrF2GgaclRyimxnB9rihnXWsETSN7oqiX5buuHQ4rjax/G72ULKKVtnjgnT8AIbQmA/4ybeSsQiDaMu1Dlg2JZzFf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5ziYopmL0iAXzeHmu9AKkT07N/VBmcnlMhXrhamw5d3RGglL0l+5Q2ZmV9E?=
 =?us-ascii?Q?/nESCMUC4o1xEnzCgTq9HNvNDd2cKP6rf7Btx7whZdj3OQWZPL7hDNd1A6BB?=
 =?us-ascii?Q?twjxHhKE92xZTUm9yVXwXpD/I6UjVCahK4qM9d6pJIcbVn9LNA9iGZw2NKXN?=
 =?us-ascii?Q?Q3g7O6VdPG1scmaaulDqgu3JBPqYUo6dJehqiFGHrk2UoY6PFou+Iw9gj+KI?=
 =?us-ascii?Q?MBQozXoNEd60tWTzNaCEcutehGKBd9YU/k4phIGCZ1gv7W+SkJjzNiCS4IJ4?=
 =?us-ascii?Q?M2DtcfRXMWwjJT8FZp/Xf+uheWTzekAyk5jhzOiyqgg19d26oBCQISPIKhKs?=
 =?us-ascii?Q?gVCm8KcezYqjytPp+zo3+f4kq6bdVOAZODzrpdEABrhwBX02wBfkyhKjIYSS?=
 =?us-ascii?Q?cLzPqEI8aTnKQ87wy9bmgtWUj3yMsHKhWRQT6X08ZBexrp4ZuC91cBgWfxsc?=
 =?us-ascii?Q?4IkR+Wdni4sKmfzcBdc3mVzFkma5P7KRrWRrzB9vQr5hvs6GchpihLdh/gOR?=
 =?us-ascii?Q?rYPkF/U1SHefMA/t9W4mCminzqsNWjvCVcn+dzdGp9YmRUVsNPpimrzjpkd/?=
 =?us-ascii?Q?k/pqN59ZFHy3S3cZDs26ErwePqcrGnfyg1tIIDuPmnhkYOAJ9/GrVr1cAoD4?=
 =?us-ascii?Q?jR+DOXOR5Bam5Un0I1Q1G3Y6evZJ9z+bUsLDxZNSsjQhoeuBjU2YfneuZyQq?=
 =?us-ascii?Q?0fC7M8IGzzgmlBCKQG40wPlFqZ4p35hYChmRFJFzZLL4cZ0d5LrwnLnxAFGp?=
 =?us-ascii?Q?Bg+GIhWQ0Ys+79hhpMP2tK+YZHcx/Y4msW01XvfxvkmO/gJZtNU1u6lapgdY?=
 =?us-ascii?Q?9wQPA9w3D7Vl6J+0SnunrlWxXaOE28eE6GVOaaT8Li7aSY1URyB+YgBNWCRf?=
 =?us-ascii?Q?pD9MuG/YmUr0L+FeH7QnGUzexSgQsZm1oSQI5STCSkmj5GBC9DrWVb8BqFSv?=
 =?us-ascii?Q?H00b7DSc47P+KM3tjczAROTN+g7ywJPZuOd4OfFMwhjM6/ZzSzhtIzxqNF1O?=
 =?us-ascii?Q?wCGnaCqqhNRdHpxX4FhDpQG0fJebOeVOTrI/2nlXc3QS1A2JPJAbhd1kibsf?=
 =?us-ascii?Q?CbfG0pBqU7d9jjuEs4QvrNZFOwi0hk8GvRsKxnCzxq10xtOb6juF3NbfIOX1?=
 =?us-ascii?Q?ebYx2n95kybgQuZpr8olBNddE400T9Knll+ccGGPJY45FqLP0dl2lgB2JRUw?=
 =?us-ascii?Q?sVLO8DUU3p7nsECQx4F8qoPO7HFo0YHLAppX4w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d62d5a-83da-46dc-9ced-08dbc5afbdde
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:31:20.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1366
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Mi 9.

Signed-off-by: ZeYan Li <qaz6750@outlook.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48a0954..ba2ef5e14fa6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -999,6 +999,7 @@ properties:
               - qcom,sm8150-mtp
               - sony,bahamut-generic
               - sony,griffin-generic
+              - xiaomi,cepheus
           - const: qcom,sm8150
 
       - items:
-- 
2.34.1

