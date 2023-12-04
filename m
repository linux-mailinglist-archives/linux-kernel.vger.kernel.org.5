Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6ED802F41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjLDJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjLDJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:51:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2098.outbound.protection.outlook.com [40.92.42.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF9D7;
        Mon,  4 Dec 2023 01:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CruJKY1iQhpeqGQ781MlC83aB11V2sNiYZeTlhK1xmBD0IDiyTUnZqi8L3n+GwmOlEMOOjFk2SZ8JtivqD3RiiCafQStrxeJWjeNZ56REzXYHpzxX8eWh1W26+V3d/GB/fxvOowPsq2iH5i7Is0VmNT85urmT3i5JVT3MFOMoXI+L4X74GhT2OOkJ3NUB7g765O2phoYaoB2/WGKQoX70kU85MJdVNBdrPa7LF1c7k/JQ9gnai3GIkPumj20u/qweAk7dyQ6gI1rNOoC+VAh6KqtcOll71UArMylZJywk1C2xrRV3iAYaZaXuNoc2xXkfGmN4Lay8bWp0P6WGEulOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7ZSTj6PSfr42FsNwLcQRtsKwCK3MOD80NKq6DnLGfg=;
 b=CaHyUrFwgCHqqs1dUdFaiX5moZG+ypaqB2hj/kSDtKQErcya7OEGnrWa0162YD6wWGgJfrQnherwU1L+cvtLzxTTdwqjU0EUDOMHOjEJMGl4z7Uj9YtV4CUELP5oUXe+eHpnAQ+svGoY0ORfacZDnfaDlLHstcpb56ATBc/ASHARawQEKCRomFhe1r70owdn1Ieun62DnICfjPVK7OkXZf1Ji+MzwApaXXy88lTzvpRhdxkQQ0iV6YeMd6drFb4/7Ia/AD08CF09/o/Qex7QErOBIR1/jsVsRZlWA8qqfZ7TfU/YshXWLP5zpQj3Rq4CqM+2iFQdXnk2Pt/SnbMlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7ZSTj6PSfr42FsNwLcQRtsKwCK3MOD80NKq6DnLGfg=;
 b=k6/chE+s3QDxrUoVI+S1Qr6OjUj/S0IDy/DFsgtYJGG2X7IeOpwpyNPWtBAfiI5D4bobqeYCm/fYuMcrkp9CxZAwWypWL+SSwhkQcgiDaYyetYPPIT1eiXxwqGkf8KIN3mM4WUi7PqM93qKQwx7QsqXZUY/GGvXYfLc+nuViXZeMZeHMewrtXSnFLauRaZ+Wm21bqsOnA7COl84bM69SnzIGwzzbh5pQFpjaEKe/wLcy808RnWsZ4+/JJcQedDz7JLiRdTv7iU1+ksEnaqIjQPJgEqtI+tkMdkj9Jrs5LZgg5GfAyZcnlr6n9aYK13PxYWrZH0Mf0NtfihKCp2MOBA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB3718.namprd20.prod.outlook.com (2603:10b6:510::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 09:51:06 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Mon, 4 Dec 2023
 09:51:06 +0000
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
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Mon,  4 Dec 2023 17:51:08 +0800
Message-ID: <IA1PR20MB49531ED1BCC00D6B265C2D10BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dWtdlKf4exY+P/c9dtvZfCnD7zv3LvMG8VMsWUiv+fo=]
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231204095110.667480-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: be9437fe-e0a3-4746-c64e-08dbf4ae88fd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbK34+jc73Vxuk7NS8pqn9Gh6s7dpbjtyjOtVtss1s2sUQVvGBTQS8H72mwHwFBz4CT+F2xbDEeRsYZ9ufekQqvvGWwLytqxOioc9Wsresl4Y6qO/7JkcP/5EL11Ljw9tWl0EEeCl5umEBXlOZ6HWNmfYvPO5Uzip7mfTEzR+4jG2RIeT3kvtxBdWB2bcS66Q3LWHFOH2kWDKEAIAex65F1pSTIO3w+wGAqnDkBJf8iM8fF3OyIyvJpYb1KPLz7XcGbnDeZyiJIGMQRLCN85+KO/9nBdG6VMZ+JbNAmi1V5hCzNIx70cawImKoNFfOeJATtcp7oOifrrlYb4rtZkhgb74P/rd6XMApS+iU7CNQxZtIf2GMCdAW89F1UKuhSVFrBvZTjYoWgnZK3eXFL7mIq6J4lLDK8orzk0YJUdUeHsW1OYIMI224JJnVVjaTuo6TFhYP1U2XMGE3NpFS8DzP6uYSPRM8WdVdzyFRxvYMVTL2+5K8Y4IpV7EZu0iJBWj3P7JOp7YUinpEwzzg1lOnzNYw53b67HgfzJRLfreDWmv13jdvibzuFHSHdDFCpZeT/xKp9v1qT2QVlh2YVgIl2WuLT7BueYN8HPOcRAoJhUvVXKSeNwvcA9H2uJmNzY7v5FE8mzu8vblaoHIX2j0vKepd4E6FG28jjQxws7qnE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOVGXE9SdQR8vkwQ8aBbI6kO8zoIVH/KR3BsYl+kxUYu3cSUa7WH8rb9UUF7?=
 =?us-ascii?Q?jJfclEowM/pMyU2qseH5x21jEwBBJsGJIKklePE8M0uSqdbaCguNR+YKNZ6n?=
 =?us-ascii?Q?R4LWCgJghL39ijMGh6uW8fdfyiIulUk4n+nYmJukZ8yYXkpE59J5IlrBjnf3?=
 =?us-ascii?Q?Mo9GYxLnHXJKkm61M9H9Kpe4vZESzVrxoVN29AdJ31rGvEdK2wDo1X8aRaKS?=
 =?us-ascii?Q?eyZtYwM5P2NVFa6Tme9FhdswXE8U9aGHDW/xoAwC9/4hx5QSlriGTejQllas?=
 =?us-ascii?Q?f2cG/9rCUcV0KywrD0bsr2QwUTXpNX7BU6jkG/o+83pTcMWhusEh5Vjk2GCG?=
 =?us-ascii?Q?ZhYCA/U5htcbYGqDtpR70EqJ3xdGHlf39xbAMmS6iQbItt/5nWlm1CDB1ko5?=
 =?us-ascii?Q?KpcLr/vMpzF4gOmVqNHk3Lzz8a29M+Te94glrSd4PueuqU5UuHqwB4DdmeGI?=
 =?us-ascii?Q?3AeJlp4ACW6mvVduJjp/TmM7cmWEQPeaOckdAinUu39I5yEzMcUbaVExUNlM?=
 =?us-ascii?Q?rSszzuCN+qch9gI3QEI5/gOQv5GCKO0bb3ARqav3YXC710hAsIX7bnGp8jj3?=
 =?us-ascii?Q?FtRWu8ZFsSmISat0pIAFHngquvKssVRPGBFsUpf0SnyYPUrQuE+Ng1+xP/+E?=
 =?us-ascii?Q?JiqnoPnV0eH37Pr3oPlgrKwKkUtkuEvTyIc8sfVkweh3qdm1SH8uKUeyZWZ6?=
 =?us-ascii?Q?1O6q1iufEEQ4HKOTV37tGLYbZPJ/wlt4sPsfBiC/vC89DAeJAbXdq1iLIfAJ?=
 =?us-ascii?Q?SOowqQCkS8iokQ5TmKXjEJisAc/7cjNrCbQvNMSvUIpgwlCsNDyI6z+hPbFb?=
 =?us-ascii?Q?vIdvkqoIQ0QWgRzLd4BkcU8Qw7oxwpskOTAUlKw3huROt7yxQf7ZXm8ZLApe?=
 =?us-ascii?Q?XWeHeEDuvo8VG7kn97NTBC7K6OIq2RPOvLgRlwZXKrIVS1dc2h5HIBtDblk0?=
 =?us-ascii?Q?43M1p90kd2w7aJ8JxmDxY2fIkv16dKnI7aFlbp3Nm5B7lrJG7fLwhUNC4NUc?=
 =?us-ascii?Q?4JzhMZduYgAEwWtyTr5CvMMia+VNGEoLG2KeVch2mmPZSWxPsccLtC9HQwrw?=
 =?us-ascii?Q?iapHpynsOmX+db2/CAnPTjjO4we+p7BNJVTQUB98idAEp1h1mPObRYD7qhJg?=
 =?us-ascii?Q?jyKi2tld18/GBcJMW0hll7VEpAWVjBX8KtVToo5sJRO8MVH9GK5KY9BO0Vod?=
 =?us-ascii?Q?YLDDLuBV9+GfBwCmql4IC9+AjGHeZpkZTqrWMjW74bL518AoJVGEobKpI9E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9437fe-e0a3-4746-c64e-08dbf4ae88fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:51:06.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB3718
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

The previous patch introduced a new type of T-HEAD aclint timer which
has clint timer layout. Although it has the clint timer layout, it
should follow the aclint spec and uses the separated mtime and mtimecmp
regs. So a ABI change is needed to make the timer fit the aclint spec.

To make T-HEAD aclint timer more closer to the aclint spec, use
regs-names to represent the mtimecmp register, which can avoid hack
for unsupport mtime register of T-HEAD aclint timer.

Also, as T-HEAD aclint only supports mtimecmp, it is unnecessary to
implement the whole aclint spec. To make this binding T-HEAD specific,
only add reg-name for existed register. For details, see the discussion
in the last link.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
Link: https://lore.kernel.org/all/IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com/
---
 .../bindings/timer/thead,c900-aclint-mtimer.yaml         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index fbd235650e52..2e92bcdeb423 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -17,7 +17,12 @@ properties:
       - const: thead,c900-aclint-mtimer

   reg:
-    maxItems: 1
+    items:
+      - description: MTIMECMP Registers
+
+  reg-names:
+    items:
+      - const: mtimecmp

   interrupts-extended:
     minItems: 1
@@ -28,6 +33,7 @@ additionalProperties: false
 required:
   - compatible
   - reg
+  - reg-names
   - interrupts-extended

 examples:
@@ -39,5 +45,6 @@ examples:
                             <&cpu3intc 7>,
                             <&cpu4intc 7>;
       reg = <0xac000000 0x00010000>;
+      reg-names = "mtimecmp";
     };
 ...
--
2.43.0

