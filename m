Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADC804E29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjLEJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLEJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:42:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2058.outbound.protection.outlook.com [40.92.42.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D11A0;
        Tue,  5 Dec 2023 01:42:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPBWltaPx3T60jZYLcO2c0vi/eohD2BjlW0wAjslBhubhTxoh29tg2OGOQj0xQoD6LHhpqoeU2W8aWnG4O+NPNN4svoR1FSnrLnvRpuyLf5e7jTe409WMCaYVgWmY7xXs/EhwibEhyRo/s9DHLgOU0W8jCDhOcMG8/mIHtJGZpDN4XHNHujxmik5IavMKlfGUBkMrODtpzC7oUst5au6XedCzEDGV2dJ1vYY6Qn8Wg2ogKqvAi5vPx11p1LJ3W63kS6pumr1pwxhkBEM16UPqvlMyeUaeLcXLakJeqWpr6X8rb0IeK7HDwyMoWgdMtp5rD6PxCRSkEcN3Y3HIylyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyKTXoLRFa+pgkBFMuX0U/DX5U1Pvdkd0Moda5c8ve4=;
 b=YRiAWsRGHHYasz0ligew9nFeMpldsLO5DbomIk6f/Hv3t9+XuYZIyDS1vEqqAYK0feyYD9hqiR/TfOnBag98lAL+Q3HnrsaGybYKFqqCDNVLv7n3ZehdZ4j/nQuWhT2m9t+zfNqs5FSu3q3N4U0Z6c31RRy3fMeMaaKZregTuzo2ijxTZxchta3nJyNkGjXRhO0ptDhCyk9tY5dLxEhCmtdyWXybRl1Rp8kianTigr11yTmG8L4LAg3OS8ZNsoSxenwaCdqY21UUYkSLG51fEx2KBGCK09A82Mj6cvJrFwdXCKiLdOoB+drzkU/q1f0uQ+ca5qQk4x3FS1BW7cx8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyKTXoLRFa+pgkBFMuX0U/DX5U1Pvdkd0Moda5c8ve4=;
 b=JusN/DczOgOEJ4nUjfzL/e0FupwseuYELus7SUzsOdQhfz/ppVlWJKgkN3UyIDoLVORJmFpMXz2LCw2VHfveGfKowoWmMs/OwhLxUM1QQbX8gz+1pt8OaEMd3Xp83pv5LLASpzHM4os0Npy1JUjpllLgtekWwkhP5h3UJIPMLwH6L9/Cxyz+yNLBQyjKgFOLlKBf65jc2PpctOlVQRTWth8L5F0dzR6YM0NnXw+6n0MNg5bvnb0sZ1b7Z1YtnQeOmf5FQsOzHXtTE06Dw2Bw58ctfrEF9YnhXaKSHr99Xlt5/YTYPYG9QVAJxGgYT5tpRkwMNDKUpyl0hYQ/rohadQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5247.namprd20.prod.outlook.com (2603:10b6:806:25e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:42:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 09:42:41 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date:   Tue,  5 Dec 2023 17:42:30 +0800
Message-ID: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [g7mMLR4qKkk/op8//Y8z28e1pmKbnJxMfJoI9g8aZ1k=]
X-ClientProxiedBy: TYAPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:404:28::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205094231.943544-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a254ba0-b03f-4d6c-91d3-08dbf576862d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a78+eworjdu5xTkdasuOljIqp1BnPOpBbxF9LYxPMB+ZmvgANdW5cnV56h1hPle/PAXaQwcV0Q40oXvQ/wBZ2qZTSoVZsZsWehoTMFGv8Nnj68xcEqfHNYsynRdd0XDbQB2yvy6exX5hnrIk6AQwEmDXie47aQSW+RPbVCKejapR4OWAMys1EI4YGaUKX9NU1z+8NyaNllP82svdJAfr26VEZU7eq/EtVP0OtD8+nMPGVfY+LICsO9PW3Eos3iElwHcFVIphWe2QKsY6GfkWx0yZRywTrtn+YjYCX97mVviLCm384POsogV0w0XOXMXJpXYZR8Fxb7i6XyBsQgpuqX4jXf6HAAEzEs0HJd1dSY+I1SJciIp32ddJYfG3U0zC6EHq8sO3yelupq89nrQLxBz+pzOMPcybjBge5KNCtTronG+raNugN5ftF5+nGsJCkzQm5yPuHzoR0mc7piyUZHeFG0xCDcVe42sIKs11cp2+qFFxp/poYMiTNiLTXK8IuEFX7rjCIAVsphqOc0HWPqTKDplZ1dkXkWspXstwnbTI7UpqASdPAS6LDyt4e7Vv9bvKEc8Z7BZX+WoTYTw0SBvrtgWIOU+2UH/u+DgOd9IMPJ9tNf7EHv57AQpyhfqP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYSUAgliUxHamQhudkwWGjlaD2qB3WoXS7DZZ6xnDlfUqoXZ7nEtKI0lMRkX?=
 =?us-ascii?Q?LglhB6pVxIfGd2JkXsbrJdOMcxjS5UcPKk7NRZ1TVoTYtXs2vrB88WoN55ss?=
 =?us-ascii?Q?zjrpAL8mlVoc5+o81+JkHzAw9Gp0WEqrGBaIEXw3bqUKuBKguxmcr8bsD7yM?=
 =?us-ascii?Q?GzJdsn6heZnGDG8S1F4JksnMCOhbhxsiBGCbfc7DAa2+G2j12M/ozjTRqIoG?=
 =?us-ascii?Q?2+g3lvhSwrYBP0jqQYweVwG4SzOoXziW7DwC6Q3o8joCasfvKzOxprv/WTpo?=
 =?us-ascii?Q?Inen286JqIhwE61hE2V3ANUQEK7mPhoErx44CATgG+2CauLLIwZ6WxKVuGwK?=
 =?us-ascii?Q?FLXtHH8Cd7dDUnAfSDPk0bPTM3EXfWksRMBGjXeIGLoRg6/ElVpfrKNhWRmp?=
 =?us-ascii?Q?4WkzLjGbvFmZLEyZNF0quY0Wqrrj2jDCogESL2uT9R3pO3ddRpIGaxgKeqzI?=
 =?us-ascii?Q?OtG+Qv1A2vlZBHwAgBhNITZ19I/9pQtmEhBbEl2QY8gwin4vzTQIDbVji79C?=
 =?us-ascii?Q?5rzSTI3JnNcuCQav0VM8135A87L4A34Nelk+EsrMGDiOOzpqnXPCjSszjdvL?=
 =?us-ascii?Q?IU4XMeYSmZvLyCcmw178DokLRXcVfCjoaROCWIhwfzlZSFph+A8DuXy0MH95?=
 =?us-ascii?Q?yU37NmamdlLiLmUHVIzT/q9pkrZdZxy/NK+Y5QJQU8KThtu/qsKo1Gn7Yep/?=
 =?us-ascii?Q?43IciCwVz6Tj/SFGFY/KHW2/8nwnshJ++FrA6j21Oao5PVmat+f51/ayKsIc?=
 =?us-ascii?Q?xChKo5Va3CcnQijV7r7Xjcy3bN+pC6ztBNF6pz4S2HGeDVOe6Mho5xt0RNzw?=
 =?us-ascii?Q?SGgblqC7viuvaQt6aDtfCKzwrsqQCl1jTg6liHY6FDSAazDo266VoSFpmMrb?=
 =?us-ascii?Q?EYy68Bu2LhtSEo1SeTOFhrjItnIee1n7FQsIrWbFxnUkdxwTdCLTCcRyDPM7?=
 =?us-ascii?Q?OpeM0f39yUOv8TJI6bF8VXs8exjbjeBgRp9fpnGsH+zgzsVnywBo8Hj6eoDo?=
 =?us-ascii?Q?bFEcTWelwT/Ebo44ChiWZdSbKWfHzk0iSPAv22Fk/Q3ryDi+4sgy4ZgJIapy?=
 =?us-ascii?Q?/j/QdmPzDguSijXct6CrYOfwc+xw/6Gp3V3ig9WbJdclrc0bX+AjkYD0R1eV?=
 =?us-ascii?Q?TdPGFfdaOXx4atBJSWusNX10/oYOZojUaBOyIhG++ivGpaegwYXzdQzU5IP3?=
 =?us-ascii?Q?jEA6pEGseAFsEWOcabdwJbrNSBc/lsmo4vtpgPsZGULFyai2nTsEFMPuoko?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a254ba0-b03f-4d6c-91d3-08dbf576862d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:42:41.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller support for the Sophgo CV1800B and CV1812H.

Inochi Amaoto (4):
  dt-bindings: clock: sophgo: Add CV1800 bindings
  clk: sophgo: Add CV1800 series clock controller driver
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 .../bindings/clock/sophgo,cv1800-clk.yaml     |   53 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   28 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    7 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1548 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   76 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   85 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  898 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  266 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  465 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |   79 +
 include/dt-bindings/clock/sophgo,cv1800.h     |  174 ++
 17 files changed, 3814 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-cv1800.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

--
2.43.0

