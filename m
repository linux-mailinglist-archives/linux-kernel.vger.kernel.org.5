Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DF7CEBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjJRXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjJRXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:19:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2020.outbound.protection.outlook.com [40.92.18.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE963AA3;
        Wed, 18 Oct 2023 16:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEkE1xTQ42Y43wPqp57oDUHbpT148Ti3jwYoQKt66aZJmDOzeIPhy2HrGiu5x/f52ZrZUVhk/zfvS7UWUDU+/K0XBV1mnUCoa97eQ6lUPW//TLtPDiiglHTZOSpGFALUGtUbcjqai9NmlfzU/psQOqBN54uW+Vp/R+r+qBaaUENhukYKxrCso6dKWDezrpHSzeuU31XjLMyZWuRRyyhMrmZvvFlx0jY4CShp9R4zron08EZZfrGklL8LE0nOWFNguPo4LLU427yCq8iCOBQqYE2EQcTu4eghMPBePNmc95ngcekectWsCEKIAeY7Ei/PW2UcZKc89GcKxCCgMZaMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr0hI5c4xS01/detVeEoI7bR3LBYOiSyRaJQUEvqjM4=;
 b=KHvW+m9i7Q5+41rr+NjNdr4QgoA3+oWDPeX8itRAOjWEhV29jN4O0RnhpYRpmBfdK32NdPMbrNPQEdTjLrEL2dSkfzZVRQW+cnuHTPZq/3VVE0tcBAJTNgXIPBdpWLzdKaa8uCXNgDRGRIE+6aZyBjyidD3/WqYwD3QmavycT/LK14BgwSmL+qhBbpcfeGKsYP70vhQlQeBXfMxcCjxfVCV5XR062bvgDCPt5Vlo1BFcMUGh3URim/Yi7xXo7uSeXhpPrSb7YQPsBGd8vHQDAoVP1UT5iVGM8xM4Dq4HPZAiTsnE801y7TegSW6K15iHrODTppu1UHrRkiw5Qo0Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr0hI5c4xS01/detVeEoI7bR3LBYOiSyRaJQUEvqjM4=;
 b=nB5PutnZbSsZ6XT04ej+Lh3LhYzqAzQxWk0gJJFqoGm0LSQIeQFXT6mx8D4Sj9iicQrz4h6RVHdzyPljdwAK54hKaKkeOAln/843B3AOlVY5fFAH5xnY7d1lnbdL9KdoSgdO6+j7an/ZzqmioX2xq9/vAmm2Nbuygg126ivw9qfjGWzhw9KjuepZblCJCkUtm+A857icNYiG9/4u3N4HGDX7JphEzsWRBjs0GV6x+ojrk9bipkE1yC8t0cYa7nZNkk2XEuYHIBE+h4JjDZSo7imqGPxRdwokecxPTv00eH+4CFoGogANqhWzCSa1OST0HY6CQ4Dh1yRDLIWqwDkCrg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CO6PR20MB3649.namprd20.prod.outlook.com (2603:10b6:5:345::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 23:18:38 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 23:18:38 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
Date:   Thu, 19 Oct 2023 07:18:48 +0800
Message-ID: <IA1PR20MB49532E5DFE666661C6DC9338BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dYAo/k0Q2Zlmv4hot8Ht4F8+gOYqs66qe1zQW+tpqUU=]
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018231855.28472-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CO6PR20MB3649:EE_
X-MS-Office365-Filtering-Correlation-Id: 90edb99c-e0e3-4c3f-2bfc-08dbd0308f49
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqSZjcddhuefeC10uSWhWWwJGjuJ3jAPGx4q9dBgN8fYuHzPg3XhrgvmXKubjA7EExK74LMoZWPH9cLNkJut5r1ijrlnD+JvVO+gSnWEMY8dqNRFewnG8+siHlZtxnXkEDh57jVA7WGwz0fyLrhsRkAQK7YBsVxXaHQHmIoNpxfxFlfgqQP7jnwXnaIcN9skURjsUsP70ILjafvRwAG3+8iZaNDYtAG3fiKjxoP4RgiP58ASaKI+daH0GlvVxH4uCp0UWb5uEik0fKEA+SyQEO4nPnUArhhZRtz3hs3Yr6m2VD4Zoo6bvgTBrKyGo+8RfUpv8/5CJg0haOrNZoV79Z2DDConD12/mq9TNPXgq9NsQQpg6RQyVTtJz8NDp7mQffexsSD1XYrux4PqyQXFJl/cXcTHNZlwY3H63ayI9u939WpRtYJKV9d+ipZEwuL6dTSMaCykvUgLWolSY7vM5BWpQbUv0x6Sdd2aDy65mi3tJBM8ulnHgGOrMy2bSLKt2bLe3ytX2ncy7WU3GSnalZThpSxZZyNrEQ+QTZ2LNLRuxiRAAJJoVci9VFaLv8nbOWT6+JF6llrDf4rGmNjjBT3Lvxz8x8IU6Pv5EbB4dpQ1+9bk68rDSitVsBgOpxaY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mcSz7bcnFe+GFdJckcy63MOtvkmwy/rJztPiDpkxF3ywL37k+cy/zWnPF7hr?=
 =?us-ascii?Q?Bv6Kr/xKReINTfzxYg2qzydkRNgjx1j2griAiVNPy8DXbh8/m0DPTczqBQ2a?=
 =?us-ascii?Q?B6OaG7R5U2SEEcvJIJoQcAahgkQwQpWw8mvSb6AAMz51bQcGJ/FHJMx8bDzV?=
 =?us-ascii?Q?j3b8GDSfnphH9zNKFo52XOLb4F31Yrroa447XbLP70u7p3Q31dDvQsVY6l0c?=
 =?us-ascii?Q?eMoUE+4EXM+AIw7sZTm3XL+hVlJFCicc/oe+iHnGxMuiOSudM38lNgOCeX8R?=
 =?us-ascii?Q?oY/G+PsKCdPfjpJa6jL5AoLkvUPzl0echxzPN/vPwEQ2JOS73l0DhjWh5htH?=
 =?us-ascii?Q?0mZOky3StMECe9LdF/IQxIPGF+b8eZMvBzmwjrfLPXfxXWAm4hn1X9rZ0+kI?=
 =?us-ascii?Q?ygHc5J4ip5EzcWh43up7ZdD4pJepo2qCw+w1eIOkiMThZS+daCRkAnahVVPT?=
 =?us-ascii?Q?Zdsy2Utfu4nF1Ey0S09uorvDkClCc7ngjMXcxX/iskyR9Kc8fUVwT+Lnfhrg?=
 =?us-ascii?Q?7DVPiMN+92+1lFbVNcjBOreoC8srFFefcsXqK5WUN71aW4uUvbt5o/tDiG6e?=
 =?us-ascii?Q?bCp90KfHgzfIwehsh5A4bd4eqLn4m/zX1URnPe5KiyOgLTWI7NtSiDm/gxWp?=
 =?us-ascii?Q?Qy/wf9w/S8iIb4HnLtGNOo6Sv6wOGWqFAoJjXzFMdbkzwNj/hcQ4JE29gnFG?=
 =?us-ascii?Q?nwx1j1ZFmZgxk2R7ua7TNSLN4KKdCPKJdL6tqtkXEB26gpc7Jsw70HQfWWyJ?=
 =?us-ascii?Q?9Sge3P+w65TrhAMe26Nhe2jOFo0tE2aw4pSOnyv8YBc0/TDAINzJTt4E3sFt?=
 =?us-ascii?Q?TSfr2uJMlvR042Qj92Nz+SXSUUU/TwRNq0Zg6ftqZ/3sHo+QTetqxZfifZKf?=
 =?us-ascii?Q?VCFIEZVJyeIFrfGZBnAYDosdfjtUaDcfpyTdXsxM7In53Uq1mEz+VY+vTZXI?=
 =?us-ascii?Q?aUGDTbh86G8EhLYJSYvSDkbfcuvI6fFy4chiQSqXcDdhloopj4WaalsxXIj2?=
 =?us-ascii?Q?8ILoHaBKC8+jjGHsNCwm2DiDbVSCiZUb1KtX1WAwmedFSdsBo/VgxLWwAqkb?=
 =?us-ascii?Q?PR1xkv3iqq9WRYboaBvcC0enl/XRT2oDtiXAjhQc0+dkmSo4VTF/ef1Rh87z?=
 =?us-ascii?Q?fj0MMRAkJQX4lZNpDHvvs8zHm+9CUbRLIxPV2GvuHAQs4v98iTCeH4bIRww3?=
 =?us-ascii?Q?PNH1doz5HAx8Mo9TFsy9gt9EW7PUCnTwuft3K6GfjUx8LdwkKchKP7aftCg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90edb99c-e0e3-4c3f-2bfc-08dbd0308f49
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:18:38.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR20MB3649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for SOPHGO CV1812H plic.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 0c07e8dda445..709b2211276b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -66,6 +66,7 @@ properties:
           - enum:
               - allwinner,sun20i-d1-plic
               - sophgo,cv1800b-plic
+              - sophgo,cv1812h-plic
               - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic
--
2.42.0

