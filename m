Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13397B8227
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJDOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjJDOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:22:06 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2055.outbound.protection.outlook.com [40.92.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B8BD;
        Wed,  4 Oct 2023 07:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hejjvzSmc+gOkYdFjZ4S+nMWZFZe6KQp2q+uWcpQxHt23JtZimEERRy9VEn709NDn+aYJl3O1+y4giRjdcX+popL8QNlNCZcg84WF+lkaH7WEsn4ZHxBlrqh7wGTyjTQT4NuFW1t3amsMz9QhEcPaLpdG4dYCCYbDyMasBr1qCjr4ygh5D4amtLFKcLdVX95ObqEkJoGSrcbfWjSJusXduzJNuPMUPRFhJw2YKMET9FEQuWUGhjqNKzlvm4J+UXVoXG+LQ+clw1RL+qI+U9r66eOjqcVfPFAQeFEeRTRZJrb4CSwWShE3nNupbCMZLjyvrtUn+jmgLKJYMEHSjEODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51lZ8+wdAdamj1Gs9vfOVkwU/Gl9NJnPOnLBug9Fr+k=;
 b=MRfiiTtbXD6hqRC6/60MjGw0xs7F0qxHnfgyL+jUT0jd1N0u++xEHdvPFHsjBdNNFyUmpArXUZNErrLPjvyO+EeuIkZ4x66T+BsK31RJDbxroitAzzkP+4o6ARzuxXs1iq/gcsyKopWZoHSJ9G9u7pcLTkuvZV7WaI/8o4sHPTtLJwDBCRILOvNP+tmLZMGJf/kQ/N4AgtK4DgecJQIlDJZNi2EEImGE0uEC6ZPgRbRqL1ZVhjdkTzA38946eqM8Ya62mwC8MjPj5BwzAy597VHb7xMhz5PB8fVVAeIQ746kSw6Bmnajm0lNMBnSxsIONG4LbUf/Vg9X252dVLIQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51lZ8+wdAdamj1Gs9vfOVkwU/Gl9NJnPOnLBug9Fr+k=;
 b=eEfxGaDaquL/E2PCfZtAigAJPA00VmAGthMpDnVqWrNfpZFTDO1PY/l45YTQgUPloT2NZ3E6isXxj+qGXYn1gwLtxGmbVQ9AGIejFzsBcbbREq7gQO6p6PYo98uhAUutkHuv/8SPgiTyeQvwTuG0hTF2IN+X/cDYoeYLcZiNeaLYLsj+4Lmu/OXoQv0hY3fZk3Qug0ggajKWjZsMrzv7Vr624zz/i26isSpyi8xTS8mcLlJ9Dl9faZRx1lwQoXRRswFgpTqFODpUJ2X4yZ53zbuYX5FtrFT/iWYP0jjNoH7I3dexUrILn+t2MbNJeT4rU/5NyJpezCvMT2Wtlq2VnQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0855.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:133::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 14:21:52 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 14:21:52 +0000
From:   Chen Wang <unicorn_wang@outlook.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 01/10] riscv: Add SOPHGO SOC family Kconfig support
Date:   Wed,  4 Oct 2023 22:20:56 +0800
Message-ID: <MA0P287MB0332F61F4FF161D1BCC2E659FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1696426805.git.unicorn_wang@outlook.com>
References: <cover.1696426805.git.unicorn_wang@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EUs64PPvm5aEjA8WpgU2H2Xs+65f4R7R]
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <46e7460668bcd88f35fbcc3cc55a96d1fd2a1fea.1696426805.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0855:EE_
X-MS-Office365-Filtering-Correlation-Id: e10a4a16-a6a1-47e9-3a84-08dbc4e540c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFmhnDj8nF//e7fRACYsMciLh64zPdhO2MhsU6ugBOGGSTK5Sj/MjycrSLu+Hcz8QSfgJM7L95olwUxznC6QbmA9Vf/CRSiL+NemN+hdAoHahHb91h9OzLF+2l6QH1hzK4dVXeNpdmqCVkk/e9ehlHCfaWIkKJbLn4jO/v3JKcoEAnWSJJGm0vx2V8ok1+L4o3mw4Cb9YhQON8/hYS2rNrfny0lL832PHMa+ALXPeNroXTTmDs0jx8OXRDpOQa1cf+bu3toRr1X1r2uHEIb0+lTMp5QKKjEQsYQvgh70yKT0B4y7Isg6HGnY2hRoYz/CLNVF10IBjAp9+WoM1mCU07sdUQghtTmkQ+3FSZUYLVdnGnPlUF5CbQsp9h5VQx3ivjZ13eraxcCDuXSRl3PNevlwmtARwG3F5rhQDxuH7joNidlR90nDPmlUiqrUkD29fz48It9HMv17qGluQ7klqCGXMsrjC14dl2tGhaxle6M+3NffFHEsqBMpMBj6Xg9oUohczhHn7KGxFJCyJFqSH3xrggifShJ0M2SCqhR1ebMznKUw/0B1xQIqhhwXM8sqjDQnWddrhsBGQY+Uqli5cDL15LvhgzBbWxhWFY5BaPTQM3k9sRaaMNP6lKWmOC98
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t262BJV3JDNVu1jBMXz1FJlQzhr4YT9xTbpcySqorEz1vr7ZhZmpN3sS0B7X?=
 =?us-ascii?Q?KgBFMbkZQhhjLKtHDiWQjSMt3eRutyPeTnDM76C44AvFFq03qcIGXXzhePwV?=
 =?us-ascii?Q?EjXr/DVht0vGxh86TFhnzwNGJ1RpyMqCr/UeB5x4snB9rPKnpxcVS72ZbLbt?=
 =?us-ascii?Q?11DiPet8pVmPCkItJ3zjZd7QprHGTM22x89QW7GDwHfLXmiNBJYaABPAwnLS?=
 =?us-ascii?Q?2AjvtJj2gVgp8beyONAh5ue30xAjU/UaNOq7eq3P4+EGtFjlM1PqF/d82/Zb?=
 =?us-ascii?Q?SSjgotTh2md4YTjGb2i9l/Es8MCp6RKYu4mWicRUOubLtvndh4q5q5eVnG9j?=
 =?us-ascii?Q?iB0R6evLiyMktxyNJYnDSkuSOcjTXd7hRlp3lO6r3qRG8Pi9FKKIcUJk1sxm?=
 =?us-ascii?Q?deHWwF3s5EMw3yjeISokfizW6zxelHj3FRUPzpPXRz+RGPvEUYgV2lu9lRKL?=
 =?us-ascii?Q?wlRfyBKH3nlNNHHllO0PlFtpFErIGSwrrKi0qTTi+ri6sYNpMbOKhEjtdfnc?=
 =?us-ascii?Q?DnlzRjO06lfdubXfIqPE9NOB3G6pzminz/d1LF5w62rxXEoFp+vjmai9YwRf?=
 =?us-ascii?Q?3usqqZ+NlwAXltPJkLbch3IXKDgj4XLypZ84z5DBXMPd80mG17mIRqqd3clL?=
 =?us-ascii?Q?RZALsbpqCmZo2X9q0yEL2DaWREBSF7xv5oI1pPA0UQ/nS65BpB/Ely5BbQrM?=
 =?us-ascii?Q?nzYX3gOZDhptuT21doh59D0jQBJObXGp5SdXSTgO57xLMfIz/w8demSFg0Ag?=
 =?us-ascii?Q?GMuG/Vtb9u4lmShCqqgkGayWIUBsGCdtzUhF5we3IRNLxhxOU5vpmN3CZSLH?=
 =?us-ascii?Q?nrznVA41+fgW80+kupNLb0mTFix2eUaBUNgiwcCI8K9ZCpkmCM56pM3M7toj?=
 =?us-ascii?Q?9VRZYVKqPvs5gn3mz+0cMd0G6FZhEyYHHz1xK/zJk7IL1P/u7tp8ugdm4jrf?=
 =?us-ascii?Q?0DNamLMLchkxkBXTXevFa12qeIHtNEBb6QI8INhLQpqO6bXowihoXN9VAuTM?=
 =?us-ascii?Q?Rdx75bOzuc4eBxHKGf0kUrhMJl+gglWzPBdEf2hxnpdRxFOlkZhoBPlVfbBo?=
 =?us-ascii?Q?8vdJtLKb91MYMXOwOVXxotxYVZ+dS/uNbIHh/16rEW88NdeocaxRHbva9m3C?=
 =?us-ascii?Q?l+rBe+TDL25OGjCWKtBadEN+m/rI3BfrtzZOJ4RcJSPjw/2q7X0JkD7Ce8Rg?=
 =?us-ascii?Q?uLJSJLlSpbKOANZhW97BkrgOgGJ131p29Y+Xw1hWISBgm8JN08VRNcE2vLI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10a4a16-a6a1-47e9-3a84-08dbc4e540c1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:21:52.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6833d01e2e70..d4df7b5d0f16 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,11 @@ config SOC_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	help
+	  This enables support for Sophgo SoC platform hardware.
+
 config ARCH_STARFIVE
 	def_bool SOC_STARFIVE
 
-- 
2.25.1

