Return-Path: <linux-kernel+bounces-8027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C284781B0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BAE285100
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31949219EC;
	Thu, 21 Dec 2023 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YdywSpZf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2065.outbound.protection.outlook.com [40.92.15.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF525219F1;
	Thu, 21 Dec 2023 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWFFy6VxfEbCCIToYsTXXEa2iRNaoEeHwElFT+oIe+MSlUhG7VZuZ0kPjR2j4/ayS33ax5tIYX82TZnZcYXw1jyAjHjq+pclNQSaEJnhso8LjSR50EcTM6q4Nm6TAcXgFSey1Q1K21gRVh+4DtJtPK1XRSrvuYidC5DqWbNmeG+L4lDc4tNM4tKHWL/1nrqMt/nf383FQ+P/jc61+fJLvYaXhE4eQxpe9wMSYmGoi2XcG6M9lZYfSvP0/6eqdLnuSEjSh4Q0VXsRYNWT1nt7Nxf4GpeRlok9qOiI+8WftIbf93wN+MB76MPdLZAgaemPDOa8UZkejPpUu2giUwd0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/wCGLDpudizRP0pmTdvtKiO6q2fWPrHcORFpd9K7bI=;
 b=BynPpyPOoqsXFj6zMErwsMIEBc7Ouel1LaOfjCtVHGUE2mCdKJdL1yRB1k1zFQjHwEPtbdTHfi7Ls0jvL/NcNnZRDfRX7jBQQ5h1YCwU+Kkyw79s8MvbvAeZRXjhFAWgjmUqjhCxsRD2rdlBYkVNnbcXV/bKrsqnEfVY7Lp4f0R8nYAW5yUkm4gO6TpI9+zCSyB9V5NGXxnVNd6YeJcQtjwKFOToOEOwera7WITKxN/omXFIEeLTXa2C6AlTSQv8vap8El9K3Wx9b4iG6kh4M5NB97GBBemSP6JYFDSXDozEBLfuE3G9HxDEyeF/K4gWsxcUtslTxlLIOOzBlH14ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/wCGLDpudizRP0pmTdvtKiO6q2fWPrHcORFpd9K7bI=;
 b=YdywSpZfYjjfLkphE/KzfE6ImuIv0+tpkxzwkbaMRyB+ldK/ZzO8dxRGHEKi8eNi1BJ9dLmLBvwU3w4TsuoA1G+quT4eFuNPE9Z3neK4T280KbPfvx8c1XGuJ05R+EgushAMxEmYWO5ivlQaVY0BSqbjLZO+Qp4elBjWjuzNaLwuo9m/QK0yHy+2vpXU4Rol1ASTZy2Hv1VB41JvXQEXGD2Dyu1hr11pVI9qKR/TKYAsb8vlwTn4NcrjkbEFQcwj+C7zSjPqmlOIkdkWsUIci8939Qz47BRXAusb3+tpHC29YqRR1hxVr3IZPswcl+kvz5KChyy1Kwt69nOlpQZ5Jw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB6767.namprd20.prod.outlook.com (2603:10b6:8:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 08:55:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 08:55:18 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/4] clk: sophgo: Add CV1800 series clock controller driver
Date: Thu, 21 Dec 2023 16:55:12 +0800
Message-ID:
 <IA1PR20MB495337B02574B23063B9A854BB95A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f33fed32babade4e0ae8ec7e3f840bcc.sboyd@kernel.org>
References: <f33fed32babade4e0ae8ec7e3f840bcc.sboyd@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5JmoGvbRUuv4yP7ezeO5abJvE0WzUDCCP3AnRU51jZM=]
X-ClientProxiedBy: TYAPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231221085512.658450-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c50ae-2eaa-4bc4-4432-08dc02028e2c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H/ShO74haxiCZTnB/sOTjb2oqyc3kyKY1DQUVG61IMPB7wAMsV/UZ8A/f9AVeSyMpiLprRI628gLWJwKj8UMzbMsemXXznEDbXnMz1e/OVZ1HJYJMGeqe1ZNEXXR3R7lgS6BoMagRu41aX568IU5VhXtc2aat7wFtf+E7WGiXT2gHNIaVG/dUrzy/XpT4Otvg6X6fMR17spq29Ai5JNVCbT5xDeCnec5I+duUurBeTX2nQYoWv1w1QUe5YjGU6aKE0AqVeJsBgnT7D10w9QnFJWm/NWzHnwNqGCoSL7NUgz2PBXpvPBvpVgdKxbeqJ0ec2KlQ0qxBO4omsp6JBdETv4zpycMtJrU+ZL9IhaFST5RuY4Y9Hi2X9yKEwALsPO+5wI6fVtQsFyWpy74U3iSP8dODiSDt1E/vAXifHm+NPS3jPZqmqWCybvQK8iXkw62CcnKRyY7T4DDfsDTXCgixwd/F9znG8ur5SmxA4SMXzff+dyFCZAPjOdcf3XWA/5Eki5ZFmqThCq2ngdjJXBVoqVfEj0CWWIMXndfwhAvNKP+attB9QV8Cc87plcQNU67DbYLgmFmH7BAvYQGDTeutFkaWa8U8L2arsATNGiardg94NcROoOpLyUYrm4VW9eA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDSOMJQi7b2DOiHOBZHALAosn5wsQ9dVhYMBvjJnGvu9cASVelpmI8CcnTK9?=
 =?us-ascii?Q?Kc4NaoxxIrX7zipruM6bXAj7XQrzTegaLBKOsB05O0v8uTczCkTLq1YPNwgb?=
 =?us-ascii?Q?6VYkiUY2mQVwLCcOCPksCxtmiK/bRy095mwWF8f3R0pK35tSzk5ZipM3Xz+H?=
 =?us-ascii?Q?wYjHM0fqYtMtb/KbjhYbHMrDGeMtspE2qZ1sj4pOP6Es0XEAaexEuhXLtXGY?=
 =?us-ascii?Q?kWEHPdZAyX/JGv/YdeecAVbfjqYreGsfSkDwyoMt+Gy/QiPTfUzqLtVqiQpP?=
 =?us-ascii?Q?RfK4kW2MgRmoDC94M1aJ9CMZwNiPs4Hh58u3Ysqa9yKuJ8g7XArsI/bjCKJu?=
 =?us-ascii?Q?5WcNjKM8IpdmdGT+x8lfJ5uqUR50DlGUqCzSEeWw+sh00RBL3S5UUShf9g/W?=
 =?us-ascii?Q?3ucDcCqkkGFbGEgk+Ep9Br6WvKA3RYEJMx8AhjwmTgnebZ2shtZtDt8Vzs1n?=
 =?us-ascii?Q?qYvjB6KdJEVVj2FIDhzYjZkApPX6wtK0/0WJLioSKkT0wUk5LhFRNxf8IcUR?=
 =?us-ascii?Q?K1M1VDCn8znyNUDJTHVvtNXAw1LPTnCl8swhx4aseEgizeP1acBZ5SdlRtZp?=
 =?us-ascii?Q?6ObVgchNbHlYWsA+czLNgN+MPN24I8/CEW7KPf35fDVdr6NJ+yCU8e50Jo5M?=
 =?us-ascii?Q?OVdm6ekaxLTK3hjamO80TJjTz0KbhW+dJN8HwoctWDeYPO/bc4lUbGK6s+xO?=
 =?us-ascii?Q?Z4R/VcgY8pI6453kl/3QXqJoCHMkSdXwZSkRuWsefUhxYkjtE+vQw8Fl34U7?=
 =?us-ascii?Q?PI3eaKPxD1vc49l7MsAoMxJ4fs25agcVK6LyGwZdabro80bnd+9gPu4htwAH?=
 =?us-ascii?Q?U9YET/FK2/zTlYXCEl+LNMW7dLWac8xn+fxjuOU7jWuftQ6S78k3pXJIGpw7?=
 =?us-ascii?Q?pY6Zxw1eBVnKxCozCjHPp5EkwhDMoMIAC+cYaohvF0xTvimuNZgXu3I16g+l?=
 =?us-ascii?Q?WzzifZi/BS0cg59oJu2lvN8/osc+HJNa5Y/Yt5tmAiL+VcvjPVh7vTbuC5lu?=
 =?us-ascii?Q?xfYmtF0QZ50fVxHBqDiOjqt1rS5othGbcZgiM8RWHQOoVp6IkkTanyj5RTIL?=
 =?us-ascii?Q?TWVhmQ2+OHDdZPAWK86jSiQPn56csqnCFPaRQM0fwg8JgQzUjsU8ZLqm/hLF?=
 =?us-ascii?Q?GenRfYJi8ApHly+B75MXAhL/2nsGWAFYh4wiKr8pDaM1lkSLNyeGJBFZYsV2?=
 =?us-ascii?Q?66M634WVtvEetKcLwBRi5myIAwAWxxwTPOgNmkYQBuvKN/Jddbn5UoM/iJc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c50ae-2eaa-4bc4-4432-08dc02028e2c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 08:55:18.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB6767

Hi Stephen,
>Quoting Inochi Amaoto (2023-12-17 20:04:04)
>> diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
>> new file mode 100644
>> index 000000000000..e51ffbd35ef2
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-cv1800.c
>> @@ -0,0 +1,1565 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>
>Need to include linux/clk-provider.h
>
>> +
>> +#include "clk-cv1800.h"
>> +
>> +#include "clk-cv18xx-common.h"
>> +#include "clk-cv18xx-ip.h"
>> +#include "clk-cv18xx-pll.h"
>> +
>> +struct cv1800_clk_ctrl;
>> +
>> +struct cv1800_clk_desc {
>> +       struct clk_hw_onecell_data      *clks_data;
>> +
>> +       int (*pre_init)(struct device *dev, void __iomem *base,
>> +                       struct cv1800_clk_ctrl *ctrl,
>> +                       const struct cv1800_clk_desc *desc);
>> +};
>> +
>> +struct cv1800_clk_ctrl {
>> +       const struct cv1800_clk_desc    *desc;
>> +       spinlock_t                      lock;
>> +};
>> +
>> +#define CV1800_DIV_FLAG        \
>> +       (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST)
>> +static const struct clk_parent_data osc_parents[] = {
>> +       { .index = 0 },
>> +};
>[...]
>> +// UART
>> +static CV1800_GATE(clk_uart0, clk_uart_parents,
>> +                  REG_CLK_EN_1, 14,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_apb_uart0, clk_axi4_bus_parents,
>> +                  REG_CLK_EN_1, 15,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_uart1, clk_uart_parents,
>> +                  REG_CLK_EN_1, 16,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_apb_uart1, clk_axi4_bus_parents,
>> +                  REG_CLK_EN_1, 17,
>> +                  CLK_IS_CRITICAL);
>
>It seems that everything is critical? Why?

I only got this configuration from the vendor sdk. It told me it is
critical.

>I suspect you want clk_ignore_unused to be the default?

If it can be, I will. I will test these clocks and see there is
any clock is not critical and can be clk_ignore_unused.

>
>> +static CV1800_GATE(clk_uart2, clk_uart_parents,
>> +                  REG_CLK_EN_1, 18,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_apb_uart2, clk_axi4_bus_parents,
>> +                  REG_CLK_EN_1, 19,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_uart3, clk_uart_parents,
>> +                  REG_CLK_EN_1, 20,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_apb_uart3, clk_axi4_bus_parents,
>> +                  REG_CLK_EN_1, 21,
>> +                  CLK_IS_CRITICAL);
>> +static CV1800_GATE(clk_uart4, clk_uart_parents,
>> +                  REG_CLK_EN_1, 22,
>> +                  CLK_IS_CRITICAL);
>[...]
>> +
>> +static CV1800_MMUX(clk_a53, clk_a53_parents,
>> +                  REG_CLK_EN_0, 0,
>> +                  REG_DIV_CLK_A53_0, 16, 4, 1, CV1800_DIV_FLAG,
>> +                  REG_DIV_CLK_A53_1, 16, 4, 2, CV1800_DIV_FLAG,
>> +                  REG_DIV_CLK_A53_0, 8, 2,
>> +                  REG_DIV_CLK_A53_1, 8, 2,
>> +                  REG_CLK_BYP_0, 0,
>> +                  REG_CLK_SEL_0, 0,
>> +                  clk_a53_parent2sel,
>> +                  clk_a53_sel2parent[0], clk_a53_sel2parent[1],
>> +                  CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>
>Please add a comment why it is critical. I guess this is clocking the
>CPU?
>

Yes, this is for the A53 cpu of the SoC. But only SG200X series
enables it. For CV180X and CV181X, this clock is useless but can
not be disabled. If disabled, the SoC will hang (I think this may
be a bug). As a workaround, I set them as the bypass mode in the
pre_init callback, see cv18xx_clk_disable_a53.

>> +
>[...]
>> +}
>> +
>> +static int cv1800_pre_init(struct device *dev, void __iomem *base,
>> +                          struct cv1800_clk_ctrl *ctrl,
>> +                          const struct cv1800_clk_desc *desc)
>> +{
>> +       u32 val = readl(base + REG_CLK_EN_2);
>> +
>> +       // disable unsupported clk_disp_src_vip
>
>/* No C++ style comments please */
>
>> +       val &= ~BIT(7);
>> +
>> +       writel(val, base + REG_CLK_EN_2);
>> +
>> +       cv18xx_clk_disable_a53(base);
>> +       cv18xx_clk_disable_auto_pd(base);
>> +
>[...]
>> +                                    desc->clks_data);
>> +       if (ret)
>> +               goto fail_hw_provider;
>> +
>> +       return 0;
>> +
>> +fail_hw_provider:
>> +       of_clk_del_provider(node);
>> +fail_hw:
>> +       while (--i >= 0) {
>> +               struct clk_hw *hw = desc->clks_data->hws[i];
>> +
>> +               if (!hw)
>> +                       continue;
>> +               clk_hw_unregister(hw);
>
>Use devm_clk_hw_register?
>
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int cv1800_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *reg;
>> +       int ret;
>> +       const struct cv1800_clk_desc *desc;
>> +       struct cv1800_clk_ctrl *ctrl;
>> +
>> +       reg = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(reg))
>> +               return PTR_ERR(reg);
>> +
>> +       desc = of_device_get_match_data(dev);
>
>Use device_get_match_data()
>
>> +       if (!desc) {
>> +               pr_err("no match data for platform\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ctrl = devres_alloc(devm_cv1800_clk_ctrl_release,
>
>Preferably you use devm clk registration and provider registration
>instead of making your own wrapper.
>
>> +                           sizeof(*ctrl), GFP_KERNEL);
>> +       if (!ctrl)
>> +               return -ENOMEM;
>> +
>> +       if (desc->pre_init) {
>> +               ret = desc->pre_init(dev, reg, ctrl, desc);
>> +               if (ret)
>> +                       goto failed;
>> +       }
>> diff --git a/drivers/clk/sophgo/clk-cv18xx-common.c b/drivers/clk/sophgo/clk-cv18xx-common.c
>> new file mode 100644
>> index 000000000000..2ff4c20bb5ba
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-cv18xx-common.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>
>spinlock include?
>include for WARN_ON? Please have explicit includes for what you use.
>
>> +
>> +#include "clk-cv18xx-common.h"
>> +
>> +int cv1800_clk_setbit(struct cv1800_clk_common *common,
>> +                     struct cv1800_clk_regbit *field)
>> +{
>> +       u32 mask = BIT(field->shift);
>> +       u32 value;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(common->lock, flags);
>> +
>> +       value = readl(common->base + field->reg);
>> +       writel(value | mask, common->base + field->reg);
>> +
>> +       spin_unlock_irqrestore(common->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +int cv1800_clk_clearbit(struct cv1800_clk_common *common,
>> +                       struct cv1800_clk_regbit *field)
>> +{
>> +       u32 mask = BIT(field->shift);
>> +       u32 value;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(common->lock, flags);
>> +
>> +       value = readl(common->base + field->reg);
>> +       writel(value & ~mask, common->base + field->reg);
>> +
>> +       spin_unlock_irqrestore(common->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +int cv1800_clk_checkbit(struct cv1800_clk_common *common,
>> +                       struct cv1800_clk_regbit *field)
>> +{
>> +       return readl(common->base + field->reg) & BIT(field->shift);
>> +}
>> +
>> +#define PLL_LOCK_TIMEOUT_US    (200 * 1000)
>> +
>> +void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
>> +                             u32 reg, u32 lock)
>> +{
>> +       void __iomem *addr = common->base + reg;
>> +       u32 regval;
>> +
>> +       if (!lock)
>> +               return;
>> +
>> +       WARN_ON(readl_relaxed_poll_timeout(addr, regval, regval & lock,
>> +                                          100, PLL_LOCK_TIMEOUT_US));
>> +}
>> +
>> +bool cv1800_clk_is_better_rate(struct cv1800_clk_common *common,
>> +                              unsigned long target, unsigned long now,
>> +                              unsigned long best)
>> +{
>> +       if (common->features & CLK_DIVIDER_ROUND_CLOSEST)
>> +               return abs(target - now) < abs(target - best);
>
>Use abs_diff()
>
>> +
>> +       return now <= target && now > best;
>> +}
>> +
>> diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
>> new file mode 100644
>> index 000000000000..148ce0ee2a96
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
>> @@ -0,0 +1,893 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/gcd.h>
>
>Need to include clk-provider.h
>
>> +
>> +#include "clk-cv18xx-ip.h"
>> +
>> +/* GATE */
>> +static inline struct cv1800_clk_gate *hw_to_cv1800_clk_gate(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
>> +
>> +       return container_of(common, struct cv1800_clk_gate, common);
>> +}
>> +
>> +static int gate_enable(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
>> +
>> +       return cv1800_clk_setbit(&gate->common, &gate->gate);
>> +}
>> +
>> +static void gate_disable(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
>> +
>> +       cv1800_clk_clearbit(&gate->common, &gate->gate);
>> +}
>> +
>> +static int gate_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
>> +
>> +       return cv1800_clk_checkbit(&gate->common, &gate->gate);
>> +}
>> +
>> +static unsigned long gate_recalc_rate(struct clk_hw *hw,
>> +                                     unsigned long parent_rate)
>> +{
>> +       return parent_rate;
>> +}
>> +
>> +static long gate_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                           unsigned long *parent_rate)
>> +{
>> +       return *parent_rate;
>> +}
>> +
>> +static int gate_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                        unsigned long parent_rate)
>> +{
>> +       return 0;
>> +}
>> +
>> +const struct clk_ops cv1800_clk_gate_ops = {
>> +       .disable = gate_disable,
>> +       .enable = gate_enable,
>> +       .is_enabled = gate_is_enabled,
>> +
>> +       .recalc_rate = gate_recalc_rate,
>> +       .round_rate = gate_round_rate,
>> +       .set_rate = gate_set_rate,
>> +};
>> +
>> +/* DIV */
>> +#define _DIV_EN_CLK_DIV_FACTOR_FIELD           BIT(3)
>> +
>> +#define DIV_GET_EN_CLK_DIV_FACTOR(_reg) \
>> +       FIELD_GET(_DIV_EN_CLK_DIV_FACTOR_FIELD, _reg)
>> +
>> +#define DIV_SET_EN_DIV_FACTOR(_reg) \
>> +       _CV1800_SET_FIELD(_reg, 1, _DIV_EN_CLK_DIV_FACTOR_FIELD)
>> +
>> +static inline struct cv1800_clk_div *hw_to_cv1800_clk_div(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
>> +
>> +       return container_of(common, struct cv1800_clk_div, common);
>> +}
>> +
>> +static int div_enable(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
>> +
>> +       return cv1800_clk_setbit(&div->common, &div->gate);
>> +}
>> +
>> +static void div_disable(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
>> +
>> +       cv1800_clk_clearbit(&div->common, &div->gate);
>> +}
>> +
>> +static int div_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
>> +
>> +       return cv1800_clk_checkbit(&div->common, &div->gate);
>> +}
>> +
>> +static int div_helper_set_rate(struct cv1800_clk_common *common,
>> +                              struct cv1800_clk_regfield *div,
>> +                              unsigned long val)
>> +{
>> +       unsigned long flags;
>> +       u32 reg;
>> +
>> +       if (div->width == 0)
>> +               return 0;
>> +
>> +       spin_lock_irqsave(common->lock, flags);
>> +
>> +       reg = readl(common->base + div->reg);
>> +       reg = cv1800_clk_regfield_set(reg, val, div);
>> +       if (div->initval > 0)
>> +               reg = DIV_SET_EN_DIV_FACTOR(reg);
>> +
>> +       writel(reg, common->base + div->reg);
>> +
>> +       spin_unlock_irqrestore(common->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static u32 div_helper_get_clockdiv(struct cv1800_clk_common *common,
>> +                                  struct cv1800_clk_regfield *div)
>> +{
>> +       u32 clockdiv = 1;
>> +       u32 reg;
>> +
>> +       if (!div || div->initval < 0 || (div->width == 0 && div->initval <= 0))
>> +               return 1;
>> +
>> +       if (div->width == 0 && div->initval > 0)
>> +               return div->initval;
>> +
>> +       reg = readl(common->base + div->reg);
>> +
>> +       if (div->initval == 0 || DIV_GET_EN_CLK_DIV_FACTOR(reg))
>> +               clockdiv = cv1800_clk_regfield_get(reg, div);
>> +       else if (div->initval > 0)
>> +               clockdiv = div->initval;
>> +
>> +       return clockdiv;
>> +}
>> +
>> +static u32 div_helper_round_rate(struct cv1800_clk_regfield *div,
>> +                                struct clk_hw *hw, struct clk_hw *parent,
>> +                                unsigned long rate, unsigned long *prate)
>> +{
>> +       if (div->width == 0) {
>> +               if (div->initval <= 0)
>> +                       return DIV_ROUND_UP_ULL(*prate, 1);
>> +               else
>> +                       return DIV_ROUND_UP_ULL(*prate, div->initval);
>> +       }
>> +
>> +       return divider_round_rate_parent(hw, parent, rate, prate, NULL,
>> +                                        div->width, div->flags);
>> +}
>> +
>> +static long div_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
>> +                          unsigned long rate, int id, void *data)
>> +{
>> +       struct cv1800_clk_div *div = data;
>> +
>> +       return div_helper_round_rate(&div->div, &div->common.hw, parent,
>> +                                    rate, parent_rate);
>> +}
>> +
>> +static int div_helper_determine_rate(struct cv1800_clk_common *common,
>> +                                    struct clk_rate_request *req,
>> +                                    long (*round)(struct clk_hw *,
>> +                                                  unsigned long *,
>> +                                                  unsigned long,
>> +                                                  int,
>> +                                                  void *),
>> +                                    void *data)
>> +{
>> +       unsigned long best_parent_rate = 0, best_rate = 0;
>> +       struct clk_hw *best_parent, *hw = &common->hw;
>> +       unsigned int i;
>> +
>> +       if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
>> +               unsigned long adj_parent_rate;
>> +
>> +               best_parent = clk_hw_get_parent(hw);
>> +               best_parent_rate = clk_hw_get_rate(best_parent);
>> +
>> +               best_rate = round(best_parent, &adj_parent_rate,
>> +                                 req->rate, -1, data);
>> +
>> +               goto find;
>> +       }
>> +
>> +       for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
>> +               unsigned long tmp_rate, parent_rate;
>> +               struct clk_hw *parent;
>> +
>> +               parent = clk_hw_get_parent_by_index(hw, i);
>> +               if (!parent)
>> +                       continue;
>> +
>> +               parent_rate = clk_hw_get_rate(parent);
>> +
>> +               tmp_rate = round(parent, &parent_rate, req->rate, i, data);
>> +
>> +               if (tmp_rate == req->rate) {
>> +                       best_parent = parent;
>> +                       best_parent_rate = parent_rate;
>> +                       best_rate = tmp_rate;
>> +                       goto find;
>> +               }
>> +
>> +               if (cv1800_clk_is_better_rate(common, req->rate,
>> +                                          tmp_rate, best_rate)) {
>> +                       best_parent = parent;
>> +                       best_parent_rate = parent_rate;
>> +                       best_rate = tmp_rate;
>> +               }
>> +       }
>> +
>> +       if (best_rate == 0)
>> +               return -EINVAL;
>> +
>> +find:
>> +       req->best_parent_hw = best_parent;
>> +       req->best_parent_rate = best_parent_rate;
>> +       req->rate = best_rate;
>> +       return 0;
>> +}
>> +
>> +static int div_determine_rate(struct clk_hw *hw,
>> +                             struct clk_rate_request *req)
>> +{
>> +       struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
>> +
>> +       return div_helper_determine_rate(&div->common, req,
>> +                                        div_round_rate, div);
>> +}
>
>It's unfortunate that all this code needs to be written vs. using the
>divider helpers. Why can't those be used?
>

The div of CV180X have a special meaning, value 0 means 0 Hz freqency.
and some div are fixed.
Maybe the name of div_helper_determine_rate is misleading. In fact, it
handles the mux function. and the callback `round` use divider helpers.
I will change the name to mux_helper_determine_rate. This may have
more accuracy meaning.

>> +
>> +static unsigned long div_recalc_rate(struct clk_hw *hw,
>> +                                    unsigned long parent_rate)
>> +{
>> +       struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
>> +       unsigned long val;
>> +
>> +       val = div_helper_get_clockdiv(&div->common, &div->div);
>> +       if (val == 0)
>> +               return 0;
>> +
>> +       return divider_recalc_rate(hw, parent_rate, val, NULL,
>> +                                  div->div.flags, div->div.width);
>> +}
>> +
>> +static int div_set_rate(struct clk_hw *hw, unsigned long rate,
>[..]
>> +}
>> +
>> +static int aclk_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
>> +
>> +       return cv1800_clk_checkbit(&aclk->common, &aclk->output_en);
>> +}
>> +
>> +static int aclk_determine_rate(struct clk_hw *hw,
>> +                              struct clk_rate_request *req)
>> +{
>> +       struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
>> +
>> +       req->rate = aclk->target_rate;
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned long aclk_recalc_rate(struct clk_hw *hw,
>> +                                     unsigned long parent_rate)
>> +{
>> +       struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
>> +       u64 rate = parent_rate;
>> +       u64 factor = 2;
>> +       u32 regval;
>> +
>> +       if (!cv1800_clk_checkbit(&aclk->common, &aclk->div_en))
>> +               return 0;
>> +
>> +       regval = readl(aclk->common.base + aclk->m.reg);
>> +       factor *= cv1800_clk_regfield_get(regval, &aclk->m);
>> +
>> +       regval = readl(aclk->common.base + aclk->n.reg);
>> +       rate *= cv1800_clk_regfield_get(regval, &aclk->n);
>> +
>> +       return DIV_ROUND_UP(rate, factor);
>
>DIV64_U64_ROUND_UP
>
>> +}
>> +
>> +static void aclk_determine_mn(unsigned long parent_rate, unsigned long rate,
>> +                             u32 *m, u32 *n)
>> +{
>> +       u32 tm = parent_rate / 2;
>> +       u32 tn = rate;
>> +       u32 tcommon = gcd(tm, tn);
>> +       *m = tm / tcommon;
>> +       *n = tn / tcommon;
>> +}
>> +
>> +
>> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
>> new file mode 100644
>> index 000000000000..8bf936f1312d
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
>> @@ -0,0 +1,464 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/limits.h>
>> +
>> +#include "clk-cv18xx-pll.h"
>> +
>> +#define _PLL_PRE_DIV_SEL_FIELD         GENMASK(6, 0)
>> +#define _PLL_POST_DIV_SEL_FIELD                GENMASK(14, 8)
>> +#define _PLL_SEL_MODE_FIELD            GENMASK(16, 15)
>> +#define _PLL_DIV_SEL_FIELD             GENMASK(23, 17)
>> +#define _PLL_ICTRL_FIELD               GENMASK(26, 24)
>> +
>> +#define _PLL_ALL_FIELD_MASK \
>> +       (_PLL_PRE_DIV_SEL_FIELD | \
>> +        _PLL_POST_DIV_SEL_FIELD | \
>> +        _PLL_SEL_MODE_FIELD | \
>> +        _PLL_DIV_SEL_FIELD | \
>> +        _PLL_ICTRL_FIELD)
>> +
>> +#define PLL_COPY_REG(_dest, _src) \
>> +       (((_dest) & (~_PLL_ALL_FIELD_MASK)) | ((_src) & _PLL_ALL_FIELD_MASK))
>> +
>> +#define PLL_GET_PRE_DIV_SEL(_reg) \
>> +       FIELD_GET(_PLL_PRE_DIV_SEL_FIELD, (_reg))
>> +#define PLL_GET_POST_DIV_SEL(_reg) \
>> +       FIELD_GET(_PLL_POST_DIV_SEL_FIELD, (_reg))
>> +#define PLL_GET_SEL_MODE(_reg) \
>> +       FIELD_GET(_PLL_SEL_MODE_FIELD, (_reg))
>> +#define PLL_GET_DIV_SEL(_reg) \
>> +       FIELD_GET(_PLL_DIV_SEL_FIELD, (_reg))
>> +#define PLL_GET_ICTRL(_reg) \
>> +       FIELD_GET(_PLL_ICTRL_FIELD, (_reg))
>> +
>> +#define PLL_SET_PRE_DIV_SEL(_reg, _val) \
>> +       _CV1800_SET_FIELD((_reg), (_val), _PLL_PRE_DIV_SEL_FIELD)
>> +#define PLL_SET_POST_DIV_SEL(_reg, _val) \
>> +       _CV1800_SET_FIELD((_reg), (_val), _PLL_POST_DIV_SEL_FIELD)
>> +#define PLL_SET_SEL_MODE(_reg, _val) \
>> +       _CV1800_SET_FIELD((_reg), (_val), _PLL_SEL_MODE_FIELD)
>> +#define PLL_SET_DIV_SEL(_reg, _val) \
>> +       _CV1800_SET_FIELD((_reg), (_val), _PLL_DIV_SEL_FIELD)
>> +#define PLL_SET_ICTRL(_reg, _val) \
>> +       _CV1800_SET_FIELD((_reg), (_val), _PLL_ICTRL_FIELD)
>> +
>> +#define for_each_pll_limit_range(_var, _restrict) \
>> +       for (_var = (_restrict)->min; _var <= (_restrict)->max; _var++)
>
>Can you put this macro near the struct that it's supposed to operate on?
>
>> +
>> +static inline struct cv1800_clk_pll *hw_to_cv1800_clk_pll(struct clk_hw *hw)
>> +{
>> +       struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
>> +
>> +       return container_of(common, struct cv1800_clk_pll, common);
>> +}
>> +
>> +static unsigned long ipll_calc_rate(unsigned long parent_rate,
>> +                                   unsigned long pre_div_sel,
>> +                                   unsigned long div_sel,
>> +                                   unsigned long post_div_sel)
>> +{
>> +       unsigned long rate = parent_rate;
>> +
>> +       rate *= div_sel;
>> +       do_div(rate, pre_div_sel * post_div_sel);
>> +
>> +       return rate;
>> +}
>> +
>> +static unsigned long ipll_recalc_rate(struct clk_hw *hw,
>> +                                     unsigned long parent_rate)
>> +{
>> +       struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>> +       u32 value;
>> +
>> +       value = readl(pll->common.base + pll->pll_reg);
>> +
>> +       return ipll_calc_rate(parent_rate,
>> +                             PLL_GET_PRE_DIV_SEL(value),
>> +                             PLL_GET_DIV_SEL(value),
>[...]
>> +
>> +static bool fpll_is_factional_mode(struct cv1800_clk_pll *pll)
>> +{
>> +       return cv1800_clk_checkbit(&pll->common, &pll->pll_syn->en);
>> +}
>> +
>> +static unsigned long fpll_calc_rate(unsigned long parent_rate,
>> +                                   unsigned long pre_div_sel,
>> +                                   unsigned long div_sel,
>> +                                   unsigned long post_div_sel,
>> +                                   unsigned long ssc_syn_set,
>> +                                   bool is_full_parent)
>> +{
>> +       u64 dividend = parent_rate * div_sel;
>> +       u64 factor = ssc_syn_set * pre_div_sel * post_div_sel;
>> +       unsigned long rate;
>> +
>> +       dividend <<= PLL_SYN_FACTOR_DOT_POS - 1;
>> +       rate = dividend / factor;
>> +       dividend %= factor;
>> +
>> +       if (is_full_parent) {
>> +               dividend <<= 1;
>> +               rate <<= 1;
>> +       }
>> +
>> +       rate += DIV_ROUND_CLOSEST(dividend, factor);
>
>DIV64_U64_ROUND_CLOSEST
>

Thanks for your comments on improving this. I will do these change.

Regards,
inochi

