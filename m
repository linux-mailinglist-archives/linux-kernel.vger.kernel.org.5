Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F817BCE16
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbjJHLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbjJHLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:16:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2030.outbound.protection.outlook.com [40.92.19.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFCBA;
        Sun,  8 Oct 2023 04:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb9F/QQr7LbR/Mp5w5JQzVUh6dSjt2Xm8e0YcDvXY+0uB9GC2j4nF7CJraDCvKMokA4AaDofsbDl9Uwf0dRdfXuw8NwHihNAzqVxbFq0WjG7qSNZ+1XiI2v07G353odCf3Oj0iBHqxQmJFGVx1zQAPRStffCge3O1aRFE86EuJMpUmuhWUByqFwzqAApiiLYyU+KwNmMmnfM/NGVyNfkNikGnNgXIj2SeN/Wo6iO/NGU1we6ln7n77cO+fsuuOqlnZLeQmVHQVOA6JQunZqiV1ezWs3kNkkyED2mPrg5A1kl/9GKhZR8vsF8pp2q5trV8sUzGBeyZeDfvTXn3Xku/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtwkXgfjjAMMGmqZ4jdTF17vl4PA8wSYTG1h7/LKznI=;
 b=QM3Qh5Qad3s913HGMGqtMwPyA7+KLuQzyUog5Qw7/elu+4IRRGiBpCNPBAFjOskbcIhj9jxaAvP7hCEMi3hlase37CAAX3tKCCbUFAJ0s9Kg3mUilkvqy1NOFc2oxyMuAtkaADPHEyBFPUATg+TFTqPBJh8hJB3nXFTBJWCpsQwXihID1Ntd87jkxofPmnku/yb3FXlkJ0B6LQbSAmXMLmo8bVW2YxrYWjLsIfJyn2FrMbiC9qwqZgVNh5pnMOLzxU/EoAN3D30nSl6pEcjXlH7gscGD96ghgcYFWBNk/mYBj71dvpZrDH17cpRAVCVCzDnWe//9w5V6hRqBVXuRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtwkXgfjjAMMGmqZ4jdTF17vl4PA8wSYTG1h7/LKznI=;
 b=j5FuWg4eWGZcb6dylBu8SwAxarGJysqBmGnabsM3n0q7Yg4yPgsVkswhuQcQmDq1NUqILmMw87tvadZbROSYd0Mz+XgAIfpa26wEFihFyzuTEniruAzmImIRrU836WzhrxR19GhqKPS0sBSK4QbVTCudybT9mKjU5IfdoOJsibuXPbfR5ZnGLqgVmoJ1g+HWEIouUhZZL/OrWqMj+eqfRTAwJ2F8AMCvoOyFRE/PFRBo7j5hKl+1b4tc+LgIJD1X0Ka1Fw4l5rUmEnCLSC1D7rvWyR5sbawEIZMU/UTqv2aQSyBEom5W/kuXu3BgMqPGyvoDuU1LRnR//wnRJQc7fA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6969.namprd20.prod.outlook.com (2603:10b6:510:2fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 11:16:36 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 11:16:36 +0000
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
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
Date:   Sun,  8 Oct 2023 19:16:19 +0800
Message-ID: <IA1PR20MB495337FB2BFD636984F202E7BBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB495337659E69ADA1A8B1596BBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495337659E69ADA1A8B1596BBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YQSCsW/jVDMLrGIABn6FDGSJQo7eUQ9VtVxttBaPpxI=]
X-ClientProxiedBy: TYAPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231008111627.325468-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 36eaaa7e-5f00-4d0f-363e-08dbc7f008d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqLPEUjky7b8zkGsBgKsoXDDxJxghp2egCGcI28NPPAAAK2zmii7bukKg2lRYlSH4cmb/ytZk1jAZrgwYgcOhb2sL9MlZZd2iamFLRnIDH94+YzU0NC0DxPlznHsgfjVuA6RNkygYcA2wjGXI/atJP4NgNi4ZmsdhvI/fu4b0eorijHA4dlNxScD07w9VJpxHeLCuxw2ih7UxjqQISMUa4GEH+1sr6L4hjrxbyhlmLMNXm2I51OgcD1OqZhKwMCau1Ds+N1quW30YWHS4L5JCn4NTP5qPckFJsKHMpbZyZjFGuh24Pgqg5Hmhhw5k1ze0yeUgMGbK/JGJTIGEQq2n5PmE0fOnjSXZ6a+u+08nE9CKUifGkNeAo/nCFUcC4W2Qo/WWMUn7gCYIMK+NTfvlhiuGXlmrflUipchIrf7OOax6WfLrgHckFwTLvk3u3AcdGViQQNc8yEk4vSMVT0X0Rb5pinIXBS7h3d4EkliNDzW19VoIKu5JAsWkhP21E4+WOih4jvg0IbC/fhoaTJBRDLVIZK9hJcIeqBMBRwDJtGdoD5XNT936HLltI8DqsEsewGvvNKmAbs2nvLaMUI1RL3m6S7TtyvQ+DclUetcDIMP+NQh4MrDlQ0X3w5lgBpc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Bmz329b1j0sOXPFuaAPyaifVKwre6Yte63/fRUieqUwCOP9seJ7KgnB1bBw?=
 =?us-ascii?Q?y7HQk/gHN95EHckk0SOXv+BqbkitaqriersneRTI2+2iZMiGj4CNDXmMFXTU?=
 =?us-ascii?Q?K8VOd5ZL95plKwxuop2PUBeOWPoTDFC0LJdu3RGe96QBQxps3DOV6iueyzpN?=
 =?us-ascii?Q?I1BtIatJ/5Ir9Dzej6wUFGJWcZZRDGIfbJTIOAwfEBgkTminD88w/94qW1c/?=
 =?us-ascii?Q?3T5cZoChhRHk4fapOVv0Jjh2qH6cHq+CtW2T/lDHduTi8HYud45MOk1N+p1y?=
 =?us-ascii?Q?UyRdMP+XVsJthz97mcarO1vr4Y/4/qbQOUQCUu7A/eH0qyN87ZPAq3qm57Nq?=
 =?us-ascii?Q?GrM11ZnSA+7RmGbgJkbQz2efFjwmpIIijEidgPlIEE7XEftwdWKR/0vAOPME?=
 =?us-ascii?Q?mWitzQwi/RA9D1tr2QjmTSQ9M9fMO4Lu57/+fAl4Cskj1x2xUREKoEKiJT5e?=
 =?us-ascii?Q?zgcl151tadrtHTqjKHmmutehrKJqxzWj8orZHTaiexURiR3qItGq2iPAtlCW?=
 =?us-ascii?Q?y7INO/D7YPBMyPVFWEDEc4vy/vwvNZARNFbcWMXQ+g3S7UokhF68FgAz+IML?=
 =?us-ascii?Q?HOk38HUKQCX+DWLi8VNKUH2/LMghQCt4utADubaC+k8mJNYYhDAVpALE19bF?=
 =?us-ascii?Q?9/nH86KNR/woXboEreI8jZPE0da40AIP5U4aDWl29gfpX14H6NPgoRsRiPdE?=
 =?us-ascii?Q?eCw7NK0BwHKarzLk2vFUNa+ROxahWVFaO0WqDiIypkDbJNUMK6anBZVjy/uB?=
 =?us-ascii?Q?D2KNvqyPMRUevtU8ltpfWyEU5DJUTrs8HsTaQ1+QEyyKzzP+jEGrSCnfHpb3?=
 =?us-ascii?Q?OFtxx8/YT6Yh6MoXt5SF+lge0/HLEI7Yk591Ck1cGXONXhyIQFX0oZdGBY8N?=
 =?us-ascii?Q?aLIykhpG2QEs+qDR9DmGazWX1rhmESlSYnsleo5r1hsUp6tD1GwlixScWAzI?=
 =?us-ascii?Q?7+4c1UbTmJJGKV4b3OY2kAxk3qoxohgREPbWs4vGiRGlG8WfbyEQiVcSAEvV?=
 =?us-ascii?Q?tnqNFeWYi8oEQD0Lmk0CsAqacTR/EOU6EV3u8QSeVHdj2MfkmH3Krz/vNBJH?=
 =?us-ascii?Q?5OfHYgtEKI+/Ze4znzmAXVv8UNKzvRp5K4rMLu8OJZHbCvDfxNteIgur9MFp?=
 =?us-ascii?Q?WMrBgKaWjoWf8VOhvrTqtfHu9NK4JjsBF6V7XUhqCVNgH2/nlbobyX5NuI0r?=
 =?us-ascii?Q?GI5gPACc48eelS8fo2DqsGzE0PrZEkDzoLW3/dKkEZYUcyG0Vdok6FqUJqc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eaaa7e-5f00-4d0f-363e-08dbc7f008d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 11:16:36.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for SOPHGO CV1812H plic.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
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

