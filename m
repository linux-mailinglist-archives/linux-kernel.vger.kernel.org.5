Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FE7CDA63
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjJRLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:32:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2102.outbound.protection.outlook.com [40.92.19.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA42116;
        Wed, 18 Oct 2023 04:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COiCSvxZlV6au2LoTZqkzxY+WP9/rua6LEzcRzZ6/+15reDVEs23FA6RRK3CYl8AQ2qbqWb5x5Vq68LVd7OZuhM7he76tpGfZmrcV0lVaBzyQ2lXP45gK6LAKp/qN6RK8fXLs+Sqd7sfYy9QRwL3MfMs9HfGfTcelJhgPDS2Uu1U4DXk9XNyH5/WzNT3XXqKEINM88CTRFSBCR36oAvN3Yv3Ml7gON5zfyPYKkma5mu5BqNe97Y1XN6J/7hIe0/7VrCT66y6Cp5SQ/0hEwHUIIr6YRM25/7zASr/kP+PHWK7wxwudOIoRmQrJ/JtM30KSbuPywo74oxoDTSHrkFmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRHRodl38TgXozx4mNNUVZhGvvZTDSwVmIIt8xnJlBc=;
 b=mWTnJdyqKt7L9v1bbblAsI1G1/vv3p5+kWGmG6lO7K+mcyPSPb1uBA8Br2F55ygLXUjZFA/l6fGbdtDoyWr9UCzk01CnLkQ7mTcPHWOHlohS+RumFheL/KhwycwsCffwOgoKeYXXafUKmeia7tdSEvWAlYu1nu5x8elRa5Ga/dfH4KTXJoZy7+1JH55dCV/+NOlnuz+e9fGtlTSQfOyK27Gi/YWXQ0d1dNOC958HJJNSq9R+84+xax86dPUu7ei1jh/0HPzJoU1luD6vPiP5Ds3sJAeb8D235mgzUgnHN3g7hkmGbLvwKLdncQ+OBpT7rQWCG1BxyAmquN2X+GyP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRHRodl38TgXozx4mNNUVZhGvvZTDSwVmIIt8xnJlBc=;
 b=Fznut0ODefxGUKOjimoAkE70+oA2AIdyf2f9xYzj1778nIqd0AqEsHE9vXRn1QqlD31L5gjqqdpbL6FgsSE1p9Wm67mYX/RFD6xEbc0VizS1/T0YBgm1R9Og+wuCQl1rOv24Z8FW20ZWTakQKQywa+6y/1zCkbHlhJQacWhvZsnzyzrTgv4sZ5pW0ffjFxf/otvRNjitKG5i7sJlvmWhl6T78dskVoHGDgCHYEgUx9Cn4mBN2pX1EwDTEIrZHmYIg37ELuk3t+JBrbeIC9Xh6JiO5g+Js8N6Q3QQ2eHySBbyFCfWPaVihJ0ViESuneaSuH2TxbsiBe0frziBvcAPBg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB4059.namprd20.prod.outlook.com (2603:10b6:610:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 11:31:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 11:31:59 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: timer: Add SOPHGO CV1812H clint
Date:   Wed, 18 Oct 2023 19:31:47 +0800
Message-ID: <IA1PR20MB495319B9063BCA1044D4B6F8BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [upgV07RXmhgVKPbyZYLfOst2g95H8TWPjJdFa9Wj/UA=]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018113155.1605537-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb7de44-5a6e-4fe8-2538-08dbcfcdd79f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W4aDNMy4xevN/TYmfLgRDArE1z9wDgk3tMSem1EvKdUMTQtUoMj5PbUBxZcwH58HJvKjmwrHZIdqRvdcxABMhV+qPcP/8AHdt5ZMDyqMVnEkynsaZHnMDhYI1lZA5h6dmC6MZir9Yq3JUq9+ZBzP63yNv0dvR+hR/rrjCfVnbDCTAFvfnS6LCRFUWFIHUc6rr0ce9xvmETKbywDNsoFo0hOVJ1JnVhcFoZTWcIN+B3zLLxlbqpsDTvIoKDpUl3xDudzYYpoRJlgW0TAd8QgpyhtjLEQQd0s+UY+YwuPDD1YEe8WJ/0EZSi6qM1GtKLG8YkCTP/CBINg3kMsjGGn95XeFCEbx++hVaQy5i/UZu+baH5Kou99vOiGGzSQlie5Ec2yMNyB0F7VOWfvCbs1hjDIfe0GXRDF/7DwfOeVcz1BTMRkl2Zlv4cp32hGa1upiqoTQiFtwemQKVpM793oQocz/th45POF6HgeSifagFhPL6aG6G5Fghu4Gf72z9iXXEd7LBgXnkS9q5SASkuYw5NhP92jAor1xdFBe9seXmWV4gTBNQH0GNa34F5F8rLQx4UGaifI9R1XcShjnmMA9BiKXmvUf94zL40AbAfmiHDpE4fRIv9EzoiDNgjmjGrs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7PXqJjN5bqzK+tAGU/0u4JQq7fVDRMEOnAXdZku6BjXyiPoXNAxKnkMtK8Ur?=
 =?us-ascii?Q?cd8bjc4VkpMfmJnPXRuGlL9mv79Vd53fCZyR/7TzB/QMqQDQvTpnO63XN3s6?=
 =?us-ascii?Q?IQHuaNMu92Mq9JCkhNYsnUl+h8V0BNBi9GQOxcya/l1IgcKQ5+fkRowIErdU?=
 =?us-ascii?Q?Jy4DBIGOoegkXxeKNcJkGuVB0tuhI+lTVSpP12vQ/9ADkK5KEiJIQFUVncAE?=
 =?us-ascii?Q?C4Wfvr488GutM18LVTqRFuXeS/DE1FAZCXoq2zD9X7Un/FV0nPoLLMUz+v2C?=
 =?us-ascii?Q?FmFzVrDTAjlE/GHT4btV3kCurz7Jb8ZMDx0IJS1XzAzmBBUTv6Weo9Q1wV8c?=
 =?us-ascii?Q?ayNIVBJ7F2YoYLmeacrDuo/agpDneRyYUw7+fYGhXoOiCEqk8WTsEbgHsMmM?=
 =?us-ascii?Q?L9aICKbGvEhKh0mXcd7ykrvGcQaZec27i7ZBVoFsDFgjSI8Gc4gXE/LTBXiI?=
 =?us-ascii?Q?qk78Zh26RubhqpdFlvGgqaQjXgAVxag43DcGo/aeX7SK165fFJOogeD3EpLt?=
 =?us-ascii?Q?Fcv/WxjUV2NVBjbo1VjgdKuYGUR9rXFRBEdoSzbQPRPCFMdO8k/7IdxLZo49?=
 =?us-ascii?Q?8bSLvCKoozfzHfISPwJ9x3dHZ73FphX+jcHccZ0dUrKhFKh0gyUkxVSEHb2K?=
 =?us-ascii?Q?ZBa5TB70d7yzI8d6gvffBHLwx2/E6q+NA3O4K0CHvwrA58feLQlsoylON81f?=
 =?us-ascii?Q?hwKHtnf3MWwYiLOuFDriKbcyDPpuhE8rC+ibZO0itPuBFd9X8UqVet5ff7sZ?=
 =?us-ascii?Q?Y4ugNMFU8M5zLZxNn9+K0gpLjrSy0Pfv9MfLshiBLaTEUPNfdezTnyjd07cU?=
 =?us-ascii?Q?Whwjbv0qnO7e2wrcM5i8nFvq5+mmO/z+Lc32u13rjrlux/daXkuEKuHEBKyg?=
 =?us-ascii?Q?Ast715ugZ9J7qxFSCkDxS7rZqBOONfD3R2CUcDzekT91uLSJUt1El5ho9jik?=
 =?us-ascii?Q?F+b42ZZ2aGhTofi7wqLvR/+MelkCtUwkKsYamlcxnlbr+O9mCnB3mVh8UH6q?=
 =?us-ascii?Q?NJXT/gnB0ysqq7AQzws8t2CJc/kwlggYImMwbBT7jU6ZynYN5/3UJBldWGzN?=
 =?us-ascii?Q?tGZJ0tZuXc048rmiOjemInnj1aDWNjwG+P/yCdgtjEI+CNehHT/V8pZv325f?=
 =?us-ascii?Q?LhX93Zo3FS7YDWjHR76bEAs2bWJQbD6x2YmVU66xKISl7py8ItL2kc4lj377?=
 =?us-ascii?Q?umeu5GbO5KL5Lc8JioJDg6+1nVNJL9/NgKFVGq8iBYbft0ObWBYR1XiYTwI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb7de44-5a6e-4fe8-2538-08dbcfcdd79f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:31:59.7890
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

Add compatible string for the SOPHGO CV1812H clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
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

