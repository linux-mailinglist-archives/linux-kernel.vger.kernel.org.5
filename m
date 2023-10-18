Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDE7CDA65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjJRLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:32:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2071.outbound.protection.outlook.com [40.92.19.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14E123;
        Wed, 18 Oct 2023 04:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSM1ysTc2TMPpxfbBaTEQmvpti469YtI9s99AjYrgoO5UhFzVHC3AUV+qz7yeysh8NULS3lkjldlf5GDL2OSS48upF/Kp6s4fUzZJL75S0MqiYyqrqLuaBJkHgwwrdNNuE2Z2Lt9y45zj7sONR5EuXH+qtE3jP9JuiD3mqv9D+WSfHMXJZsYfxahs1tj7Ulw9L5u7hxWj4p1WIkgibTRfKZUUO/COuYzNSx20000KncpVvFbkCPUwGyPDX2QfxZYDpQlZjKXPvg6rnbTbDMXvhHxD3vEGZ2ZcOW789jmUJ7GYtVzI6VxNS1xel3/HafHqMMn+WOzZNcZQS1yo2mNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeYWlTYaJOGIiEWkZu5rFXcX7Q/TSa/S03ztRgroNyI=;
 b=M+UcoH+n+pYKeAMFBNMWWXZ/pIVXOrCb0PZjlGPmA1KnTqitAvPJl6xT/2r14soK5l5O/+C8udU2mm9cDYMEVo9Q62wV0h9KsIVJ0xPfig624JTNn5GYF2/asy6hU7sHiwXIe/l5ouH/T8ykHw5xKRq0qDi9KOjzmKFhbsUCiTcOkvZTPP7DX2PUzVuDFOn24fuNQc1vFr3N6G2BfK80b+LZENpgEtiwhw43AREGUjk8Zjp6ADGqK/+3yKT7G+p6JNfL9e3V1o/UtykdhH+VNFBKaKU3bwUpHUmjFX8mAJmsI49Rgw/gF7KQxCkIyuG22+VmqSgxOzoO8RpqWyl+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeYWlTYaJOGIiEWkZu5rFXcX7Q/TSa/S03ztRgroNyI=;
 b=YgIEV+/jHkNnpQWH5dOlOFRBtoZFg9M40PZh1q5+Cp9jlZ7YNlfPBHAPiDAxxlroxClP+vpmROB7FNx1xdLY1oEa3LFnS/mtDKaiaFCrrd590DLKsJSpIenzAU73QciEOtQ9IlthasTbIsLzlHmEBinSGm+vDp69wVdQiINidVqpoAd17lzxNH5hpdatHmOoEOsEMLez7ceWs3+aqhdQ3UUIDfHttu3k8OouXkX24sGh5VC7t8sk1BD90UeFreOZcOioXe6U6a75XXZnKSOdyOMDUttWXpvqOfyvqxfoP+rSmY38yYv2j1L5gLv2OaKrKHho+D+mdk5/H92qZJWQhA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB4059.namprd20.prod.outlook.com (2603:10b6:610:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 11:32:06 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 11:32:06 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v3 3/8] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
Date:   Wed, 18 Oct 2023 19:31:48 +0800
Message-ID: <IA1PR20MB4953B362B47B67C9E7C35547BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lDqTqQi9PnZXUi/IWVCqTkhKGDUL/+zuRp3DbKeS9lQ=]
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018113155.1605537-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab93e18-34af-4dfe-fe22-08dbcfcddb5f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADc8set9QXe/XbT88zExzdP5WEijJ7AYjKmUaY07coRgSxOH/Es6l4GiGI/UaY+Bagzcl+m4v3zPs3qLMJsDiCjLPuizG67JIa04vJgJqWe0cERKQLZoYYAiGzjM9qaQK3BNOtRgwESFgQgQSTbtHyeYhAtoCJNrpU8WZuVK0Ewj6VJ90g1o5+wZqG1IaQVOxPXp7M6TyeTGq1hnJtvvCWNjtaJ8HwRn7aqor5OQ22fZrmh3+Sd4dNu+UqLuyK53Yk8i7HJTv4s2PvL2qkWUjmkTZMTUBKrqpMLZrSDSXBXdsLNNW5LJ/jdRAizAmXrjkZ5B8uF5mBuXbAqZZMuDF46sCNelssHMBUApkiWu7p+OtXtXeJZvAAKxgKsDt81sYnJYtc8NIhjx8nZ4REIIvcFyhL9smAw0GI7WFi8YTmX8JNlKw5ygGGoYYr1JCGSiExPsY94v1YRVlppcYwPSWKl9Xh/yxlKu+mZ87CRtMS2T7O4W7o0BzEaPJvl0FqArlzXHXRP/4XmWojrdeWQkdnBYOpYTUtQV6G22b2AmpcC38hvhW50X1D5ZeL2Yrawr+wBj332AD3D8C8Gk3zS9g2jjjtdOwYPeSu8FN2RFwnw2T6erIG3d/1Hxcu8Uy1frD9+7e8ANWuxE8pQAy+sUydrf/LLNYVH7I5jndyhXhbA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8K8CKPgomXxWQJjvTRajfrpGM12EQSdflJ4mKYEA29rQfcHWmO+J29kXsei?=
 =?us-ascii?Q?Vw/TG9ZPUupK7ZtiIDj3NjVkd4b33vxrKQkbvy9K4bqrHz5dngvXBW1wFb74?=
 =?us-ascii?Q?TI9IEBCGl4FXyERvh/hg0IFUBGYFARU3lhwerMp9IZOg14SBOnySz9y7QMcJ?=
 =?us-ascii?Q?WLKTS45o8MyHFDYIXUBu9pLVmogaORI0+23hINrQW3w/iK1DteO5r+kX/dt0?=
 =?us-ascii?Q?Je3DEP1dNTyZkEcDVPdvDx73IFMnfAYOgD/Be6Uhs5kxbFHS/tVRIeURhyc6?=
 =?us-ascii?Q?h/498fE276P4AXP8MtE5xZBiIaXX+rg45mgMY03CqOMgYybhh4zdF0HNiwD0?=
 =?us-ascii?Q?CFJWbmMPY8lwEgDU38u3t7GLACmMRqDEs+77Yg1UHw7/VMhnswEwk5a0Ta0o?=
 =?us-ascii?Q?QzNFiBWjz7BOjFJASZQ8SkBFdwPXxfcv46JuV0epeDoHG1Gbz9U/zVBsg9SH?=
 =?us-ascii?Q?CitARVzGH/lRKC3BEgxSsgkLGboiYnN3iNevvVl5cgoT29OOsbiosPHIngtp?=
 =?us-ascii?Q?SKJUjsiu930QUjbmzBVsoNmCFSOizFR0ek9ySw3FekEeqK8y0XW64e9BTLV2?=
 =?us-ascii?Q?LfwXTkvi6PoLtkEMguoQIDVarhFpD1Ar20Z2KXy+sWpMCF8IG7WXR0S89Tsi?=
 =?us-ascii?Q?9KlYv4cOKPuHjlZU67gvUfSHXryfGIi0tjbYmg0JIonHEQUfitUktDDQa7XK?=
 =?us-ascii?Q?ng25h+G9QaugXONQ2Oa2KWTIkY0lZp1m3vqkYtFP1JA72dx1MxYCprhs2b10?=
 =?us-ascii?Q?9z0Lt5nF/XWxgfnQvgKKryTgDmx+HKpdSkLEM7uQbylfxgOD1bJlobYd4+rC?=
 =?us-ascii?Q?dPA8Ak1oC/O2tRBbMH9Y6r/n7iCVAow0wUddYBACY/HDRkLHWL9+0BkcvFbZ?=
 =?us-ascii?Q?jpSiNsK8hKjZc45HouAPIO+jrUsajJr6o1E1ftXvFwH4SBWubVKWVrk/5Yjy?=
 =?us-ascii?Q?0cIil5NaqcFSEEE4jHK2P9Y+r4SzTbHVK9bYi0h7HerzDix9Y07YuSzFEUmp?=
 =?us-ascii?Q?iJLVmuJPuZqFewZfUsiwkL+Wk+Iey9sKBWzj2jjMqc+TaD0lA9WsqOEKNZQY?=
 =?us-ascii?Q?juDH0cgc+/Tgl/f4jPWgZKtfGnpR+5XxxPIh18bDYciA4jtjn2iynnPVAcQM?=
 =?us-ascii?Q?afWc2Pn9dLHs9nu8SVifuMNAy7JrN5KPJIOK27A2ttuFk44hhVmLmSMqWT1A?=
 =?us-ascii?Q?A7LJ3fH6ZYcXa0hb1wu4qcPHLhHYUyahHDvIyKPrswNjGK6OyZoglr1TS+A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab93e18-34af-4dfe-fe22-08dbcfcddb5f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:32:06.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the SOPHGO Huashan Pi board which
uses the SOPHGO CV1812H SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://en.sophgo.com/product/introduce/huashan.html
Link: https://en.sophgo.com/product/introduce/cv181xH.html
Acked-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 86748c5390be..9bc813dad098 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -22,6 +22,10 @@ properties:
           - enum:
               - milkv,duo
           - const: sophgo,cv1800b
+      - items:
+          - enum:
+              - sophgo,huashan-pi
+          - const: sophgo,cv1812h
       - items:
           - enum:
               - milkv,pioneer
--
2.42.0

