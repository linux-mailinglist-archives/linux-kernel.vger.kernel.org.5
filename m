Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2027EA7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKNAox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjKNAow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:44:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2036.outbound.protection.outlook.com [40.92.41.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905CD4E;
        Mon, 13 Nov 2023 16:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU1H6IbdAz4wbpfkM53NXwtnKqpi+T3rSPCGicxXJMzhM6NjRVV38sECf22q2mV6+ECCAp5e9oo8beiXdq/PJ1Xk66diK8heHFcLNjdfanPSiYT9tuvjdxKLlWxu+qU6DGoZ6xi4l6ez+zDAxdupYNNupIDRn/IAkaXBzXQZvAloeOqSDWwCtFHLULPr8amq1Ru+WqVtmaybkD5vFs8hV/2NSzZLvZAMaWUVaJy2yihXBcZTmYOvHWhg1F6WV8Cel27LSqdek7JvCjtUeBxpXuhqJlpIngsHSSCwadAbFxy8/D0KXo7Iu7BRqTbNB3szW0EA4hY+xKlEBh8cxLfmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLCJF43U9rhk3x0h56agQamxmuJvrnREIg0aplc0gC8=;
 b=O90JVZXUDOZoVNYxco6zyITkPaixy06Ls53HcM4v7xCpGmMh/kkWMI+54QeXzrvwE8/jSdjZmhcLi9sm0+1jY2rZ6ujYt6wSE9yY1bYj7sVLGlKtj6+7U+Vj71FhUWw/p0ELfgMS2dK15iGIJF8w3/rGaiWORxxPMN8udnIQwe+pNXY9VS/CRil5TGloUF7Q8950I2kb8lwR6JpxMs4aahaIM4vvSrbsoHacAJjycLsB5VP0OnU/orY3lh8BtBjJbqQxneB+ywiDdRyi2pC6YYxWYNrjCeI+5WZ8D6qj/p1/FBU7Wvu1hQR0J/yBNB9DAa7LAMK0lWgcREVWsH7SEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLCJF43U9rhk3x0h56agQamxmuJvrnREIg0aplc0gC8=;
 b=GzTcDCi8lXPjjztxFkYL1sgJmeikZ2Z77FSOCa9motgEzaB2PR/AYyGWFJELwNL8B1Pyy1LfHiDTrlaXZUUubadsNBkbjuFjb5VipgyO0xykPJUdRBUYeDFvykNAXYKlqlMbTNFFg35Ob0N0uRprMZK3UesWUv9x8zOYbjxV+AtgZ76aqD1qpGBwvJcbLV1t1MqSCUTDGTaFPY/Gh1M5qKy+hACAOaZ896T59rAx1yUZFSSTNG2sSbrYf+cC2xIb4biXvcXUFxOC7R46n7vQEmP15vFqo0GXOkplrYT9VuKmpE2+xFlCHHAmutWE3/JT6bMez/OuhfI2e97PD9CgfQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM6PR20MB3492.namprd20.prod.outlook.com (2603:10b6:5:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 00:44:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:44:46 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Tue, 14 Nov 2023 08:45:31 +0800
Message-ID: <IA1PR20MB49533EEEB2F7E8D93762DC1ABBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0mrh/P47aZM+VvyH6RMX0C3C2ZQ6F5hcch1gvP+7At8=]
X-ClientProxiedBy: TYBP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114004534.43833-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM6PR20MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: d37af353-6b31-418e-dc2d-08dbe4aae65e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsVK7yxfefAXQky8hhDaeRH5qvyMCN4Ubz1aCR/ZgRTgW/A9iLqbRor1PZzX2LEJlpLgJvOXaLh8aIVn5OvCjSa3fJLv4oAdTWdYzEZJXH0ILcA4vIGcJ+tTKs2XmFSb2QCLN9yS0GfRIWWZ1e5qTBYWwH4TQLbZD5cOhPhav/Id1et8NV+aZduGhbYVqqdpPUfPUnKjnMvBYVNvXDrNjRGfS1PNk/p+IhRVDpJTopGatq5iisDbWFHs3eBL6icl7uEXvd64m+btjZm0bMyeXZJ7W1UAVqQngGpnHGkJu6pTqJzZZPSsrvZkCnoZPwK0mKnz+mfve88/GHVIqG0hC5A3DQLXRzYkkvDVpMz5JKj7KBShFyfjW7es7X4wpT7LjDTPPQLXdH+sp9WzoZzG4/XdktfK0JNW0q8xVeADOeIC7cQWqH+xE4pTzKzd60pWcmulIQO07LTE4Ya3RFhalVFVBNHxU1A2Xni15+A2K3MD44NX/pQnpbG9O1BJSC3jAmrZNVk+qWHk8XbueQTxUonuwtyWQw8dmP5As+sFF/nz+uIYOyrlTHj+H5IcihLliiw5CRo2QdEy1GoJWBdAFULSigijj05U1ablU/Nal3Ugs4LfOmEjlq7FmWhhc5Kv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/fqNw2VU77obNr2BI+jZVwv6ILMOxy91JiovbVY+aBhWdMu2rCQGZXyloKZ?=
 =?us-ascii?Q?BUNufGAy9A8YmWG0NFA6tP3/UQxldlrCVX8RUX7wW07igh/S4ZgqYaeOe8rm?=
 =?us-ascii?Q?JiPXpNGk+eTzZQ2R0wT4Sw8gECYWBzf3BEiObIyThAAvCKJq3OGTurJLtr7S?=
 =?us-ascii?Q?6lq1r8UjCcYeldDNwufULGHhzHXdFKJfkAyUzr0tXGUIgsbC+cQjp2ef0kPf?=
 =?us-ascii?Q?QvrCYjkGcOJ6ba8HfbxAlaPD5ZyayndJxS8nUTpqnp8IBNVxCHWGXe75t9po?=
 =?us-ascii?Q?vADaaHaORHajj6zhJNvnT3APyrIfbC4QoaoqHU+jv3IdxE50WlsKTB+RUvbf?=
 =?us-ascii?Q?Q5GstS1cOpm1CbiRSjijVSa0hENForaS7ntrIWgVp+JPb5fTWiLNwQUuR1x3?=
 =?us-ascii?Q?ZsC88JyXCJ9dFjOgVaXXphKFgtUztWF9baNxStoJAJzSz7AiPAOkGdia63PF?=
 =?us-ascii?Q?YPXnGF07ynifWdN3+Oux4ALVyYXIZ5k+OZ3uoyD4o3cUrPcqgVm+SnUcd+uc?=
 =?us-ascii?Q?FlmgI3hyK4U7Eo5eQiE+Mh7sCXyCQVrXjog0Mop01bK8T1oEYNir2h48sFAv?=
 =?us-ascii?Q?TcXf7ojU2HMMdmAlZ/Vt/+a21Q8Q4ljeivW+VDNxMVAvKoWxFm1ZivUgZagP?=
 =?us-ascii?Q?+BZG06l5g27IFSn94XTgFLHT62lcyuSZo3WKL2v3H+yZChNhqrmIHhO/rw+a?=
 =?us-ascii?Q?3DS3Ny1q/U7NYcKkVC4kZpx+hy7fomvVrKENbjgNP18oR8V5PwL7hBZMBdaf?=
 =?us-ascii?Q?1oAHgd3MMh0BN4Wz7SaMv8Ms5iHP+MLTWljx/fjL3G5DULcDIPcZPegRfh1X?=
 =?us-ascii?Q?nWrBnizeR6E+T0G9pV6VN5jockmkAty4WOb6GTdQPmFZkxTIlS/HGoD+ykWY?=
 =?us-ascii?Q?Kt5rTrw+OcKGI5lbEVKFu/1wCKpv9axx/2WKmpo8JXZynxvN2xfwyDP05S5I?=
 =?us-ascii?Q?eCmsxceHSmJnSvXnWhOwwjMIYXAekwEiF/oonvOHgtkE3xNl0rW/EQVAG8qi?=
 =?us-ascii?Q?RggwbR0KtwrvKaxCep8hcg0xWlaWPuOTdeLKkVh1CeZZMUFDdMwS08n9gZVK?=
 =?us-ascii?Q?RXFL4ZXYBJ6Hpg7U9Sm9jK9RatUJj6xMEP8AbkpRHniy/TGe+2S/7OKlEm87?=
 =?us-ascii?Q?tDKQqDwG4pKSdXOZwm5DtBR+iUWpLIHv6CtWEe56L8DGFOYyHZZRXrUI9aAr?=
 =?us-ascii?Q?EndHsmM6X/1ZbY3K50igMEAHrPPQRqCxfZZJ15zY67Evs6rxGQYyraUb5Yw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37af353-6b31-418e-dc2d-08dbe4aae65e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:44:46.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer registers of aclint don't follow the clint layout and can
be mapped on any different offset. As sg2042 uses separated timer
and mswi for its clint, it should follow the aclint spec and have
separated registers.

The previous patch introduces a new type of T-HEAD aclint timer which
has clint timer layout. Although the timer has the clint layout, it
should follow the aclint spec and uses the separated mtime and mtimecmp
regs. So a ABI change is needed to make the timer fit the aclint spec.

To make T-HEAD aclint timer more closer to the aclint spec, use two regs
to represent the mtime and mtimecmp.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
---
 .../devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index fbd235650e52..c3080962d902 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -17,7 +17,7 @@ properties:
       - const: thead,c900-aclint-mtimer

   reg:
-    maxItems: 1
+    maxItems: 2

   interrupts-extended:
     minItems: 1
@@ -38,6 +38,7 @@ examples:
                             <&cpu2intc 7>,
                             <&cpu3intc 7>,
                             <&cpu4intc 7>;
-      reg = <0xac000000 0x00010000>;
+      reg = <0xac000000 0x00000000>,
+            <0xac000000 0x0000c000>;
     };
 ...
--
2.42.1

