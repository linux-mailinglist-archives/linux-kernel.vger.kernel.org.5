Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D6804A26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbjLEGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjLEGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:34:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2058.outbound.protection.outlook.com [40.92.23.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B684BCE;
        Mon,  4 Dec 2023 22:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO0CLC7/fRAPFeMp4Offj7WFClzzxoKcihXVc26y8sz7DCVIRjqo2DOwhBNkcduAzSc2o8NEccWz2W1HnhcPTs2kM9Gq8IyBUP16xyvF1wTBrjhmSlFKzhKrJ8P7ZmI5kLfL0vjTX2UcyRKjB3AXdh3wHpJ6J4fNRDIdFEkPQV4rUY0cPR7aRvoZRlxHErEc30WTaIfqlGFyGULD9Zx4SQya8W1eC912mLDaF/h875AFJ7RA1coZai8T2V3WnLt6LbqvPu1ANv1Bwh0UuvtkyEaSIfRAkvLP5FdrBIMAx4XVIGXersWVpG7z0dUtYwhKL0SzHInfmWzBgwSKW8xZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsA36/WzLy5Bh1MeIsei6q76Rk/kMPrcoxhBlyVrIww=;
 b=dAStvUuwcZa0wpkJ0UjLiGMMTt/1+Y90rhHA4yPqR3cNVNG4NKr63DEppLM5T8ejPfcZWsMUA87WCMEJewYbm9hhUlo1cNOCJYQ6vnLKHofYjuzwAQ9UcmrH5ezVatgWNI/liyZSo4BjieNQof3JTKExmTl4RFYnyNMWIj5LhVeyGELZlw4mSgXJLKOecl5cRlCPgpv3xBvQjgUl90FAMZfk8u7gIjSsUTfZU2JyyfMRJHQVSZyirYFJP7zz8lurjLEYvw16aaP4V3C/EwkUJkyIr5rpQkPNY6Ow3gOJ+w5xnxsSW5sjgQnknT5CNoBWbMXUS8yZHImGvnlSBWCYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsA36/WzLy5Bh1MeIsei6q76Rk/kMPrcoxhBlyVrIww=;
 b=gVXI29ZWJH4daZartyMiNXvuaYPSU6qNGHx5AFi7L/kAIxFyY7h+3zpxKHbvGPiCJ8HWt5+ZWedSTpgpAzbC0tSpg08S3Dx8DatvW+F1JxPxnGAOGqVY4JRlZ1cEnY8QbXqPbf1IJLKEqEXi8jRgy0XIm1UEU1XwC0Fq7nbaL/FM3sNnY2kSAmByypp9nl/lsgNv2YzVsq/c3soZyJLZrhU6Wwjwm/9ZAmpn40gT21Ij3bYUgg+H6FKncDdmw1HgYIGa4VqoCpRTm6MnXwrQjJ0XMHDnO38+MalPLGtQE8f4SLzDlWeEo0LGeMT/oPABOOl1H6/h9TLcWWQAQq5NVA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB5698.namprd20.prod.outlook.com (2603:10b6:610:14a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:34:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 06:34:40 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, samuel.holland@sifive.com
Subject: Re: [PATCH v4 3/4] clk: sophgo: Add SG2042 clock generator driver
Date:   Tue,  5 Dec 2023 14:34:30 +0800
Message-ID: <IA1PR20MB4953B7BBA12262E0ECAC2B04BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MA0P287MB033276574107F5031C153DDDFE85A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB033276574107F5031C153DDDFE85A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6NRc+sQnH3Gt+wuJo5vGZLJAB5G2YDi4Huk0BjiIYOY=]
X-ClientProxiedBy: TYAPR01CA0184.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::28) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205063431.815824-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 245e8579-1866-4af2-8199-08dbf55c41ea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ez7JSzYL1QPUzDiwnz7Rp1nOV/aJilVCVOtuVdPM6GuFOms6yCl5+aNg5taCOfUFOF32OsCQWdm9JoFstJdwV6+2Z/duzg65Tkvdec1ZJiiIEr51QRhmPPxCcUCQ2nm2FJnmw34KjOzP7IG5kW9j69xCKk3RXhhMaTPq8Iq2vNehDSgx2lTDCRlz29rLEnhn7prGoiYiOfOGx2AxgzGdITtgZyilNmU3OrH705ImbmbXEy+seWAHoXgp4RkGx3p4MYN8zIwMGWM1n3Wd6sY1mGiLOXLwBPsj3y2uUmRtPqBVM+JWbs9QFgzrimLOyeNuGEbBN9hoWmzNmIETOQyr63DVNnyDA3eGOa00yLKpdtytwzhWtZEKTbD72zZkSYjfU0dL8dD5tFBuZSfE0xcpSKu39iYWYW32QkuEP1I1W/j2zQyVB1QZLnHg5DWgfheDxs6w4ORjXvgBI8vayLV5zmuUsoUHnu9lPCHgFX3O9yM+PjH0fHxygTT1ooeyq8X/FqeO0ZmTfG5JpBrPW025uECyhFJuRniL504zHSzA9MXbRh2KXWIJ2twNs+vUEhik5gHYacubgfJEHHbtc9kyMS0+LgibamHb7OGoiKuShK3gwd6umncroP+UunJTETB+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0aX8bHmtri44fLLCbCzR+pGrQ9EbgVXEvlbLfuv8ywm34ve4UbCOsbEuNipr?=
 =?us-ascii?Q?WndggJSkD8zL4DaPy9xbr1sY9zvuOxdUDsIJe3C6l5zsc6a9vsovYmL40mzh?=
 =?us-ascii?Q?BqvDtFGOxpBosi07pq+pNIQ5d9vuvo+kDfAuM7l5bo7jL0PNk8wK4k6QQddX?=
 =?us-ascii?Q?z9sGj3XKS7YzNK3+otS00sY74WEvErxCeV3EIqt0fxloT4HOQ0irBZUhVikW?=
 =?us-ascii?Q?CzxXNTltibGk3vLYqZKh9gps2vG3+tg2nB4lmsSXM3IEo4VoRsBhhwbNPTqu?=
 =?us-ascii?Q?6ssmnznnac/pg1DcZBH/HiAsTgEqHDVn9qxyPbIOlvMwP6KgnCdovi8ZDLMT?=
 =?us-ascii?Q?FePvKR0Ut6r/1ph3ShH4g6ptAKxETc06Squr9P5KKJLIwmoKzU8IOyNlyJbr?=
 =?us-ascii?Q?BiDZmXPx3W9E2ziE5QkfS6z2k0yUxek7aYmaaiGPxJxQvx80mvbdNOTIREVN?=
 =?us-ascii?Q?ObTYhlsrTn/RBQkdk+2ekdLTmYWWMuE8ARY7FIFUC/3e2HHuETBAIBgrEK0W?=
 =?us-ascii?Q?YJ5LMLC2SLHW6uiaErGdmm+NzF1k7DoHevOYgdAPhfl10epHZTCGSXY2Ysv2?=
 =?us-ascii?Q?yOFofoMvZ+bwWaJp1QHij9SG02utAksyNzSiZ4GwtPrF7g4yUvanuqzCadJE?=
 =?us-ascii?Q?TTQFpqVTvCZMEG4uTM8O6l2REnT1oZJTZRqbZ3KcNHAVEXLCGR88HYrD4ea+?=
 =?us-ascii?Q?BAL//dsSzyRysP294hN3xgLJXIMHR4TEbbXtB58GLn36fpj2iI1+o3PlfqJk?=
 =?us-ascii?Q?RsRY+OmMjzHVTLxIuTh/bFhhlGBXHtQsrHy3JhouA5wt3SyVQzYGvmgLcEBi?=
 =?us-ascii?Q?q6+Wxa/c/x43y8dsze8nEA4c/Md/E0eysSnoMPvKWElhPB5NZWew9SBgXrd+?=
 =?us-ascii?Q?bhJaUBU+nSlyYNwvfgqSzjLAJHMPMhjIXIb3b6VZiOXz780y8zgIwrSvpEhL?=
 =?us-ascii?Q?CgBVGAi29HmJqLUQXwymcVu+zQKLekA6Fa7lAwWQtXdP7ZEHhVlAv3rA970D?=
 =?us-ascii?Q?1rH3K1zw+ovaxRZdbkq36v5qHUbSKIZo0roAof4OfU3Z0iO4IP5FfFjyFg8S?=
 =?us-ascii?Q?n7aeTbFN/wgpZrdWe+RdCbgV+oWigZQ2XXItTcnHpRShiWxZM2I29J1mBdhI?=
 =?us-ascii?Q?AGxy8Z9ChO7WMpKpoBikUIMWmdapuoOVfDVRqOEmr9y4TEItutqlWuV/Bw5e?=
 =?us-ascii?Q?GN+TeRhPnb26c13EayAgnt3uvangbLrpXbelazuUGReIajLReA/ishFU3mg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e8579-1866-4af2-8199-08dbf55c41ea
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:34:39.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2023/12/5 9:13, Inochi Amaoto wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add a driver for the SOPHGO SG2042 clock generator.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>> MAINTAINERS                            |    7 +
>>> drivers/clk/Kconfig                    |    1 +
>>> drivers/clk/Makefile                   |    1 +
>>> drivers/clk/sophgo/Kconfig             |    8 +
>>> drivers/clk/sophgo/Makefile            |    2 +
>>> drivers/clk/sophgo/clk-sophgo-sg2042.c | 1371 ++++++++++++++++++++++++
>>> drivers/clk/sophgo/clk-sophgo-sg2042.h |  226 ++++
>>> 7 files changed, 1616 insertions(+)
>>> create mode 100644 drivers/clk/sophgo/Kconfig
>>> create mode 100644 drivers/clk/sophgo/Makefile
>>> create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>>> create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 97f51d5ec1cf..c9c75468f2cb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -20269,6 +20269,13 @@ S:    Maintained
>>> F:    arch/riscv/boot/dts/sophgo/
>>> F:    Documentation/devicetree/bindings/riscv/sophgo.yaml
>>>
>>> +SOPHGO CLOCK DRIVER
>>> +M:    Chen Wang <unicorn_wang@outlook.com>
>>> +S:    Maintained
>>> +F:    Documentation/devicetree/bindings/clock/sophgo/
>>> +F:    drivers/clk/sophgo/
>>> +F:    include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>>> +
>>> SOUND
>>> M:    Jaroslav Kysela <perex@perex.cz>
>>> M:    Takashi Iwai <tiwai@suse.com>
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index c30d0d396f7a..514343934fda 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -499,6 +499,7 @@ source "drivers/clk/rockchip/Kconfig"
>>> source "drivers/clk/samsung/Kconfig"
>>> source "drivers/clk/sifive/Kconfig"
>>> source "drivers/clk/socfpga/Kconfig"
>>> +source "drivers/clk/sophgo/Kconfig"
>>> source "drivers/clk/sprd/Kconfig"
>>> source "drivers/clk/starfive/Kconfig"
>>> source "drivers/clk/sunxi/Kconfig"
>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>> index ed71f2e0ee36..aa5d2cf0b6a6 100644
>>> --- a/drivers/clk/Makefile
>>> +++ b/drivers/clk/Makefile
>>> @@ -119,6 +119,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)        += rockchip/
>>> obj-$(CONFIG_COMMON_CLK_SAMSUNG)    += samsung/
>>> obj-$(CONFIG_CLK_SIFIVE)        += sifive/
>>> obj-y                    += socfpga/
>>> +obj-$(CONFIG_ARCH_SOPHGO)        += sophgo/
>>> obj-$(CONFIG_PLAT_SPEAR)        += spear/
>>> obj-y                    += sprd/
>>> obj-$(CONFIG_ARCH_STI)            += st/
>>> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
>>> new file mode 100644
>>> index 000000000000..b0fbe4499870
>>> --- /dev/null
>>> +++ b/drivers/clk/sophgo/Kconfig
>>> @@ -0,0 +1,8 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +config CLK_SOPHGO_SG2042
>>> +    bool "Sophgo SG2042 clock support"
>>> +    depends on ARCH_SOPHGO || COMPILE_TEST
>>> +    default ARCH_SOPHGO
>>> +    help
>>> +      Say yes here to support the clock controller on the Sophgo SG2042 SoC.
>> Please add RISCV to its depends. Not all the sophgo SoCs are in the RISC-V
>> platform, Some are arm chips. It is not good to build this driver
>> in that arch.
>ARCH_SOPHGO is only defined in RISC-V arch, so I think RISCV should not be needed as depends.

It needs for the SG200X. which has a arm core. Maybe we should left it now
and add this in the future.

>>
>> Also, the condition ARCH_SOPHGO is duplicate in the Makefile. Please
>> remove one of them.
>
>Don't undestand your question "the condition ARCH_SOPHGO is duplicate in the Makefile ",  I think you are talking about Kconifg, what Makefile are you talking about?
>

I mean your change in drivers/clk/Makefile.

>>> diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
>>> new file mode 100644
>>> index 000000000000..13834cce260c
>>> --- /dev/null
>>> +++ b/drivers/clk/sophgo/Makefile
>>> @@ -0,0 +1,2 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +obj-$(CONFIG_CLK_SOPHGO_SG2042)    += clk-sophgo-sg2042.o
>>> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/clk-sophgo-sg2042.c
>>> new file mode 100644
>>> index 000000000000..421ebcc7192b
>>> ......
>>> +        }
>>> +
>>> +#if defined(DEBUG)
>>> +        pr_info("registered [%d : %s]\n", gate->id, gate->name);
>>> +#endif
>> Drop, no need for this.
>
>OK, this log should not be needed, I will remove it in next version.
>
>
