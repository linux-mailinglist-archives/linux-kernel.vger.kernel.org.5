Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC07BD9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbjJIL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbjJIL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:28:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2099.outbound.protection.outlook.com [40.92.15.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7C1994;
        Mon,  9 Oct 2023 04:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC885JCsV1RU7JSV1Hix51o2TOMOg1Ico1fHkqnz3jl190CUJ7VYejT7OxeFRwKZGhtRHiG9FsZPACIz5buJqAOSSq0zuBdideuGXjwuocT40o4dGinFcThAUPb4I3M5DXcQrgZcXjCyiCrIaAlGWv8BPC135Qv8LFap4ARRojQAacLd3KdITMZjDY+0CnftG+XWMqomArOJ3/JmqyY3XbZrb/ISPSHQpGmQy4JpULr7XvvZBulX44CmEHPo01RYe1pqi8ERXDVkCPDQSjhY3lnw2ufe24Misv4YKb6BU3qDmSdo9fXp5zJBQWuM08DaBGKcRULnNZxaEtw52fTenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mjT0GHZRjHAdTvckJslAsHSeKgrdYR/YRReQ5ZgSmw=;
 b=UJOiLkLWQ70Pz4cILrhKaS3vtAyKGdakKSjduIzD0cLVHSWG9CnYMt4chm8Ly6aLZf0DqQprKV+H3K9eJaTIBgdx3hk1OYWKB/HP6IJlzpyFzhKGr8R98q7aS57F53HfX7Dn0W9Cdi1Cbspn2ssH28SLM0CKgDhnPabBkhK9hkW0KGaUx0fv3//dNkjhFoywDbcoXWRnekmHk79LkatQIqaR/SB1L2on2sONrVz6tptNy4RDEbVMVzfxqEQQ+J74k1zW/71Jxw2WEmggM2SVNCFktI9pW4oOkIeY2RlTtwk2nY8vv+EwiWpZxo3V7ntpaK+eSMEh8qN2LBE9zOlwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mjT0GHZRjHAdTvckJslAsHSeKgrdYR/YRReQ5ZgSmw=;
 b=hb/kmY87p9ZMMVjlwMnixQxoKaXKGDzHkKwaDyuIc/lbsIk5+2KJA/M2IqCAHSHro+9wixgtuBUN4mLqpvO9TV8cNMS24ZyfS1nTjZ0sMcMzddEtcylufG2QJvi4vdNpJVXUBEzzFxKLgqViV38T5Jmw2p/OBtOjG/JH/oKr3J3tkg89naPtHT5Zd6NCAc5VO4H7fEROW8MsidI/GTzwLQHuWtFlDKRWBF2khsMvdRoFVLbz7iwU31l3kdpynNQUAXggreW78Olzhwsy26W4bLrgrac2A22z0lJvmTlpx0RKdMHcCADPd3ka0PiZ14ctS5jZkgmcuP6Sf6J3QYH83Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6129.namprd20.prod.outlook.com (2603:10b6:510:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 11:26:43 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:26:43 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
Date:   Mon,  9 Oct 2023 19:26:33 +0800
Message-ID: <IA1PR20MB4953572B3263F83C6F107783BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009112642.477337-1-inochiama@outlook.com>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [rw+85XFftVmATLGoJ8vqF7MItD6hvFfLy9kvXVKamXA=]
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231009112642.477337-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b12290-5fc3-4faa-5cf6-08dbc8ba9cdb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9VDTFmSXEDsLXi+j/LzPZkvMK6W250GhUPuNrRcW+xB2F3XAfyn4bPu2OYqST882Tln0HLtcU5Wt8XRKX4eeUatwNLlE41+5I6FMbzU2cen83nGtj5RcDtJzZ54BQqZnb4fq/ZMGwa+o6FJ92IZUZbEU5ku4pcx5jxbNblYo3gvS9RniGNr3zvbK4JK5fQBxKEgrhyr4scntO5kwCD96HeJ0k7AX5C+1+nd/bMQWDp3ppS/SLoAlXd6vj8Jnn9n+rgw/ZeQBH4s8/v8CJugLFBrOGSDorlgYhS6LzQVB8kPuRfmqocWLeT7zoG41r4m+hl0ouujxUf2i9dhHsUBCKV23oOp639IRAE2dUhwE0W6ricszoxVZCzr9cggbqj7lYjr/qYSevA1pK74pJvnN3ArLbV72WuWsnj8C9rq7bGekrm85gfXwEsx+5sWcm9ZhTsTQAU3vxR6M+bqOLz41K90UvYaOp+fJrx+QCMr+dH1WuRYK075sFAtshBo6Ur6rfr4hPLXH+f0jLENIckuur7YAJlPv9/cQmQjGLiFk3m4i4WOuuk7U6NQ6477Au0PeVlCxcbZGxriHNSiczV3e87SlNRTErEcp4kB0G7v+hsl5Olf8CCFlVhLdYAdV7Cx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V5D1sFTuCUGEOEs4OvLEvEc+gzyF6cXVG6fNvq95ysN8RCU5OGbtrISOw68?=
 =?us-ascii?Q?Rfhl+LrcexbFOcRvb1UcRFRHUf2pi4+UblmjPsP4KJ/IVq/UBYKJ1sPCzwmX?=
 =?us-ascii?Q?REn11IIloKtucPWOn31/oezwYCLNqfUV3Ea2d2De+UjG2uhrWUIPSndt3wO6?=
 =?us-ascii?Q?GXwNsVMvTGWpLDF3yjwl5hZyGjd4FIyQheuClj1/zjTMIfwm8AzhqgNOQrmY?=
 =?us-ascii?Q?sJvplPSfmmbuCNG1X8aH28tckbGJpEaooa74GDGCPyO7F/RWmzLJjLbSk4ih?=
 =?us-ascii?Q?e2o9z9zw+TY0cAWeXuJADAeX5PkBwTEP7oeMdjPAXG1ctgrBkKxqc6dTw+o6?=
 =?us-ascii?Q?GdQ0Pr6SEWWNxqyekrswR6IP/90ZLUo+YzvpAU6PyCebttlSMfjQveRPAkwu?=
 =?us-ascii?Q?0S7hD28RUgH6ZBlSqVAKAWl9idH39i7wKxaeurq+9t3wH47s/PgoDJlYRMn2?=
 =?us-ascii?Q?g39iTghkawWPHiE35IMZE9Du6u00VcHUAaVd5NOd9Ic5i1o2KQwQEM6VQ+nk?=
 =?us-ascii?Q?2wVdfMNudRswQmYxOU7jL0dlL/6L/KsQ7yM3Db0ukyqtbUhL01i6Rzncgv4s?=
 =?us-ascii?Q?zk/bCaXCoToIML2skgK2Xd1oy29HYFC3GBGcX/yAJPIN7OARhM1LQE0EFhd1?=
 =?us-ascii?Q?KCeEwGEFglzuxYtqq4SbtNBcy27EOaS0ILwGn+mxyisO2yC1p5bsgIVWyVbx?=
 =?us-ascii?Q?+589RkCpC+kNvtFV6MUQBEeme0Es3NbBhc/Fk97Yu8tBHRuu5tfhW8iZO3Su?=
 =?us-ascii?Q?fzCxoryPtx1I0jTftU0cwb0SBpcQSaubRTEO9VmcRxDfCDca9ePun8yFalh5?=
 =?us-ascii?Q?Z/vPE8mHL/KRs56i1Hqzo8sdPxYIsifqYxIYutJF6IQciajzCqiNtY2a/kGN?=
 =?us-ascii?Q?srljs8LQTRfi+lBMbx9c/0qwiOWujohzhk9eK1CqfPkwtuVoCmgv/tM39zSm?=
 =?us-ascii?Q?Z+qV1Qpa3p9Mz4Dorf2oepv+L+IiA7NG5TMwD6FTAt8UtQrAoCI3LHlVeB0n?=
 =?us-ascii?Q?tiA1npkvrQSFdcJxQs8Wqd9Jl1lDfjlaiMGEqS1TD3s07VfR9n+QEEsgoPpP?=
 =?us-ascii?Q?UCT53VpQHXl95s3cueI30W+j1K8ihFst4kUBOzUZc3T4wLHXZk4FtujdzJYo?=
 =?us-ascii?Q?9N/l6pTIs4JUThbQA2kSPGrHIo1PhBHs18Qn3p6TkwmDMidYYjknglTl9Kbl?=
 =?us-ascii?Q?FGR0XVkGCnk6jXjAJPJ1mrT7OxJM1+4RDDvb5bBV0ePaEW7xkIGZ6UTmI78?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b12290-5fc3-4faa-5cf6-08dbc8ba9cdb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:26:43.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the SOPHGO CV1812H clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index e8be6c470364..4b6c20fc8194 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -38,6 +38,7 @@ properties:
           - enum:
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
+              - sophgo,cv1812h-clint
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:
--
2.42.0

