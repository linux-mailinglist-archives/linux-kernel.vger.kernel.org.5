Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE980831E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjLGIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjLGIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:36:16 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6FD57;
        Thu,  7 Dec 2023 00:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7MrzwtLVn4on7FcI6iGSkEjBl2JZQMd5+4sCaW9+ZSXIxRW2xMLkR/CK5T65/z4PVOG7/QO8IFgtIYLXs41ZBt3DwcSdz7GtUt2TlfWTJW7MdsKem1cl1UfLTUE0Gl9eV5uWEHVDcwlBa35jkt9LPEHX8fGLis8y8Ge8Xy63ucvOYM7T97GxeKKrrg2cn2WBaMfQjNENXEkm/gXst/hoE5Vhf61j0pkAp73CdT8hENaom0QD93Jtv0m7220yTYKtg8cGmp9BbmDSQSBnaAVYMFafg8viQ88f6UkxsYqtSMUcBn5nOon/thy81TnFdjdVxNdIkPPVCkqt5uIsST3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x0ZDtxEuyn90rNaHPhcEJIBSFAs/YdcfGt2+0IbFFs=;
 b=jfiqMYasSsyaE4YwnarR7aE7CYR8ymSVtNkMKOlg2ppNE79BGBOV/nrIhIqkZh7JsIMIs5zyVVVPfk1Lgs2vxrSg2rtse/XvPKcQO4Tob3iz7wL2Ddu7W+5pvd54AtYV2mTEGTV9pSK7SfGvpB5+Dm8+UJEKK6q3zH067IjQgews0AP/U6Disuip+OlGZ0krFdgMaEQ25w9KK+USeLHbFz6qtDN4hZBXNeQT1AO3DWxIjnEjdl6qfuTodqrJTmSJbvvWkzmw0VRyAAeJe2C6nkgTfej2F8PdDsf64PzBUkP+blredR23izaZOnv4U8N2Yxh0XBpbr41dpF4JdVwTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x0ZDtxEuyn90rNaHPhcEJIBSFAs/YdcfGt2+0IbFFs=;
 b=oyqGfObQ0C5jrHpPYLl9BihBvS9jvzO662CqHyHWrAGDx4AylSXOhGWkSZc4q0v03stN4qeMoRSXxrtLjH0fPDaKI6jD3D1vcz65WjzpxpzdJimoS7ac/QCJtHIqJHsFbbPQCfKuqMSTdCCtMYzTvuH53ui4QHBQeqKJ3uc2pB8DKR0OiyM2UO15j2x7rq1jeV/JVlWvBRtSEqxmGcs6nk61YaKoWcgmzh/yiz+UWogs9S3NCKXwVEwWXOmu5ltVTK7hz5yIqYC1VYHNruM9nIhbjJC6L2KC3KDZVABEjGalk70d98b1MrHDX06JJiJGQSGlGtUoXd616xzry4WpAQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV2PR20MB4582.namprd20.prod.outlook.com (2603:10b6:408:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:36:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 7 Dec 2023
 08:36:18 +0000
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
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date:   Thu,  7 Dec 2023 16:36:17 +0800
Message-ID: <IA1PR20MB495376DBED8EE897FE11A2B7BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [G/eCHKOyduTaY5FL1jADlOLE/LlZEEuEsS93U/nOd58=]
X-ClientProxiedBy: TYCP286CA0341.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231207083618.872121-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV2PR20MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e5ed8d-2ec1-4eef-d726-08dbf6ff9529
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvZfTEMmR8D94aJQvC7qjK1NDLzw9ldqj4rDQitxTKbk525HzCfp6+ymNZCkE/wqe9+JuhiV7RzLUuYpRDdXujDpZnEOYlbGJMqofGolB121kgvKEhDx24tF/s05phy5rcQ2FGyIun3yDgVEyK8r8UlQ5nSNDkjUC+oqldzmsCDvdLZIq5+W2ZU7yhKBfA2oSBkcIRSDjTOYtSd2+Pp8PwpoKxv66yceepJnBGrih544isZsZu7F8ZqgXNfL1sK5+sgiJSL6uV+HIjM0ZaQEMRgPt7PG0+BNJOcWOJmCF+PTfAqGcBukzbOmzFeIunt1yf3Jmk3TRJCLXPgo8/MLsHLU6Rp6dN0ycF/5YyWO5kQ2epq3k9JSU5XRepelQ7XRhV28Aw6HaPhjgy9nsrJ7unDAX6oIsaGsnwKqZUG3EJU1mllLZ0A2IkZSG5uDdeTPbY+YOTq3bJj5iq7HYN3nTxWPZAwk7SPlmgjO1EAtAbxzi5PawMemrjjvudX1NkpeZRp9xw7cWm66KlnR+Z1aLtyKZ/SAa9O3GQ1M3vWbUtDma7ak4BiSKhT44atQL0hN0ZD3zhcf5GqaQnzBfNYl4eV+C5fJWb7asYuu0Dh7sodwqHFq8I1+cSCfe4ugWLoe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LnJ5pJhr47HX5DPKwjejxSvIhvHetMvf6vppd13zR5c0E676tmlmdHX3PUu?=
 =?us-ascii?Q?oTkqW09C/ZVdWF/oNfABUn/QjYMB+My9rdRMUIcrLibmPbNZXhY/H3f2qnqi?=
 =?us-ascii?Q?HWieA1y6dbtm87RH7Ll0DpUzzy+4O5DxBfZv4VKRa6FNlzAB6bgTTAVE4D08?=
 =?us-ascii?Q?AlCkdLHx3UWlDhTty1mLHzFu+whshXarZA7aDBd9S22FNh2Sd9vCEGnhyOA8?=
 =?us-ascii?Q?trT7GnVocR51IOLv5vnKtiWMJpu0TN6MCoCUtA168wPUx2HbY/0V20zMdBBx?=
 =?us-ascii?Q?+E7f21FjLgNfCIWKC1YC8c4yjiRCV6Ce5KAZIJyvkeMZD3kJxNaxmTal8qs5?=
 =?us-ascii?Q?85lceUtcnKESR6thxT1BqdLx1IfEfdzvkCaNmOvOd5oXXJC2BhnBPsRZUqW4?=
 =?us-ascii?Q?SvYzQalMLiLUJkHgA/K5arS3AWTgyFoa2KwG+eKl7KrcsPBCSx+ihomCiy/t?=
 =?us-ascii?Q?CYLH1ngOrmia+/tgTFdJD+w7QwRy5YQepcvPo0szk/0QVY01fakPHDpDosnE?=
 =?us-ascii?Q?7e3fCOqBDItW3WMeHjixnyQK0sXYHr/AqpOeUd2k6BiJYXh8awXHby5VJ+Uh?=
 =?us-ascii?Q?5lG5n5hmaDv0ELAlrXXiRtJb9gWhWZgtRL3qnfiZK97+U89PKBzsXoFdHye9?=
 =?us-ascii?Q?9RzDqvQcc2ielvctDLtfdrr6c/B6LLt8Av8Dwj9oplu56bTDFYw2iUikiAxT?=
 =?us-ascii?Q?To+FMLZ/GzxDCONXLmF0d1uVJ+7ZU5R3mHNoOSsXENyYBBzysSVJA2hMpcbj?=
 =?us-ascii?Q?CRE6UhIy2HDA945C94GufdFoFhNjcTHOdvJ77tnMWtcjmb600x/3tnPwyFit?=
 =?us-ascii?Q?OFmZtvLD2R1BQ1O3OSyyFb48CPujc/37dt3P8+GvfU+wjqZ+O6IYwvW7FpeN?=
 =?us-ascii?Q?BJ8p1bokEgMtvIThbVhrfW/sC+0Z+59sg8AjkJrXB5Dd7wVLIY1dY/66sft/?=
 =?us-ascii?Q?WFpQlIMeTOt2bNc5+If1BHQ8OBO+GdmWMvHusFPmfcz9pjZ0RVapkz2hA3xv?=
 =?us-ascii?Q?qpFW94gKWjApW/JRMVhU2/9YE+rm/KCdnS8XVSTmU0BLd7XIkGDd6VO4LIK4?=
 =?us-ascii?Q?vTMa8K2xxTnDk8+bX9LNfqUKFwHjLZobNVYZEe+gKS9gAvVH80WH3pGDJPEp?=
 =?us-ascii?Q?YNxNJ6CrOD1DKUXC8S0TqH1XBthdWUg44VhHFwHQXrnR4l0eHaBseETvWpFN?=
 =?us-ascii?Q?32RxHvEGN7UUuNgI+9PelDhFuHrtikNkB7nfCUHcHOwDpcouLSNbuRk6kw4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e5ed8d-2ec1-4eef-d726-08dbf6ff9529
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:36:18.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4582
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

This patch follow this patch series:
https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v2:
1. remove clock-names from bindings.
2. remove clock-frequency node of DT from previous patch.
3. change some unused clock to bypass mode to avoid unlockable PLL.

Changed from v1:
1. fix license issues.

Inochi Amaoto (4):
  dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
  clk: sophgo: Add CV1800 series clock controller driver
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 .../bindings/clock/sophgo,cv1800-clk.yaml     |   46 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   22 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |   12 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1574 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   76 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   85 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  894 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  266 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  465 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |   79 +
 include/dt-bindings/clock/sophgo,cv1800.h     |  176 ++
 17 files changed, 3830 insertions(+), 5 deletions(-)
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

