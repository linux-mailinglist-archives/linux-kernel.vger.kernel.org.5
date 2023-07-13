Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3A751A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGMHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:38:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C381FD6;
        Thu, 13 Jul 2023 00:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsCxRNc+WUaIGAsUvGhpUufy9SaNr1RcvFaiKqayD/1RDJ24vjbZmr4V0bCw8MqwsQszFfpLXjk81yZBQC5jqAG3VlUhnWrJhtFwYi9sqA/HDg3EKi1Cwqx70uAYHLBtVykiq7qFnlYC+zDtWzHgRT7rX4CI0JFj0kEhLIVYi6YSPqGpaJcr0x10xmcDY8PLqoMQ9v9WbM6QFyNPf7AonnJEyyugI8HbWrBj5xY6nSj8JzkvjiDWXqw4ndJk5Fx8X77pT8F5ZoQ85KP0oHyXbOZxuhBcc9ZyVj94mopIiTffzCm/4SZkPxrdBfu5JAyJqMG9fz2ov6HvMpefExFfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh1tmoXRPgIMffQWfaPIO22C5hABG3Us/YCN27iiSZk=;
 b=jP2TfGpedwebNLfE1burZ4XR5Gt52cT3Ujk0IG1XNiXzi6WWPYUtIY4/BSrCE4LG7sxRYQ8zp7GA7wtpGdychDMt0PYM5jz+wUKCttGbbpS+uItYAScFufdaX5P+S72DETkJMHzANXjrffXHrzuMqEB7gUdZBskvNKovypDZ5LhVGGlFWH4KhAT22bBtRF4NfYE7OZ98K8NoQ5JGtM7o5+oWn3ote0JP/8UOPiMvCbq+GPktafqdr5rOKUu4bP+sho1PH+XfqFO1YkwzjoFBP5x91Q1FarX9zajMkE4Fo96SAjGhN4/pKXb6t+J80Wd3OJqccdy/QfZyT7/RnLWJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh1tmoXRPgIMffQWfaPIO22C5hABG3Us/YCN27iiSZk=;
 b=hiuP5Lt44YVddYAb6LOGofApsjzrU/Px9WE5p6zUBp9RUfhvkoaCNs7Towkt2s2KN8RY96LC0ilrtV1l2CHgRGr8AcS7z/4Rk4Wxi0AxeN1bHSIcg+GvBqaJz1EU6I91Ycw2woK2XC9Dg0fnanki0ZTgL1UT1L+ewH10UgWQ/zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7831.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:38:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 07:38:31 +0000
Message-ID: <a49fb8e9-7b86-b027-16ea-8877b8433d12@oss.nxp.com>
Date:   Thu, 13 Jul 2023 15:38:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 3/3] clk: imx: imx8: add audio clock mux driver
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1689039286-9706-1-git-send-email-shengjiu.wang@nxp.com>
 <1689039286-9706-4-git-send-email-shengjiu.wang@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <1689039286-9706-4-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 137fa4f0-b267-4211-2df6-08db837427ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWE4Pf37ogdr4QpBzRZre6yourfJfO/WKKrQ2nc7yZFxbzRbl1//OHdrj/jXg+EDW8v67HShGp3Wwqp8xYOWaOgTuIwd7+xcrSEebCiywHAMOmN2HtqeEJP0Tw+EKwjO6RYCEnebaj3ILu84Zp9NYZ84UWahBXTipk+7uuNdURMvRGGb2/OVKq+8ErWwN8jfK0kx/IM+mjaRRZkTPK8xd3SBkwT/EsTCW5NNDF9+mws5uIrzhS+DCuObXUKVQ03CDBAiu8XCib9hSMcYL7UTf+yE1/2CUZ3Hg7D0kcrfLZBPVuKp41MpfdecSth4egtkSVedQR4LdiMhXrqSoBRg1KPpm5u3EwHBnVxcIuORhSWEMo13vty4DYf0Ko5aOWoriNDsnb1HQ0YYZzdvM6y5G3qvJM9ZYnqPDeBp9Z6tLIHMyYeFAex4khxsAfSsRab3lBo1aC0x5JN8k1x0s4tRhTUpHtbX/3P3v4BuyY5FFyzQ75lqwbOOZ7yHEZLE0XdEIjeb3vUZp7LE7Vj+4hfid5vVPBz0dYPdE+wt7+eradAW9q2GIyy3hiB7c8V+S5hXdeXoAxxisHImDxxsQxQVcKdQb4NAFpxbGZqOUtXkoUPID3xMRQNJq3xneu3wpcCjyY8gF7mt21CcDbwG2PnZsV8IrFfHsO/DH3YOiK2xuzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(478600001)(31686004)(66946007)(44832011)(4326008)(2906002)(5660300002)(316002)(41300700001)(8676002)(6666004)(8936002)(7416002)(66556008)(30864003)(66476007)(6512007)(6486002)(26005)(6506007)(53546011)(38100700002)(921005)(186003)(83380400001)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9LMzBtVTZkaXdLdFhvdWZBTEdFVytLRXpKcDBubkJqU045TVZBRSt0S0h0?=
 =?utf-8?B?WEpZSXZBWmdNdHhSUzlXbndQVGdLQlpWR2tURHFMdkJCc1p2OUl3RGwwTVhk?=
 =?utf-8?B?SElWUjFWdXFGQ2p0L2IrNG5OKzZSZnIzNW55K2VWcHFVVC9pa3JlMVBScXNP?=
 =?utf-8?B?VXJ5KzlETFJmT0FaLzNFQWltRHNEVVprUzhpTWd0cStwSDRjMCtZcUQzWE1Y?=
 =?utf-8?B?M3ZBd2dYVkxrZ254bElibXp2VEhEeTFUVTdMWUptZ2FRODNTMEpsTk1wR3ho?=
 =?utf-8?B?SFovU2VMQWpnVjZkcGtsakZCUTU4Y3htaERmVHlnUXhoNVpScWJub3JreHhn?=
 =?utf-8?B?d0hwR0RJOEttZG5rSm03UWpHcTQyNSs5QWI1NzdoTFAwSDcveTVuYy9FN3Bs?=
 =?utf-8?B?QUFMOENQemEvaEh0c1RWUUNldDRMOFhoY3Z6dWxWbloxYm8zWkEvc0E4djRU?=
 =?utf-8?B?bzk3cDVSNWU2MWM3VDhnWGZnSzVYZU5ab0JURllXN01ZdCtaeGV3Lzk1SG1F?=
 =?utf-8?B?aHJMby9rQnpNQUoxait3SVhONTNaNDA4LzRGWVIxTXNYeVlZajQ4bk5TRVlz?=
 =?utf-8?B?NFdIck5qN0FYV3dsTm8zK3laZjR0NzFNNUJ4VFVRS2ZwZXQ1YkZsTkFxNHQv?=
 =?utf-8?B?d0lKTkxQOGVhWlQxMU54Z2J5eHNtNHN0TVB5SHVEcy93dnI3VVBXeVRmenVX?=
 =?utf-8?B?RHcxL3ozWCtGYzJaWDEraWo4cHJZeFYwS21STCtBY1VYY1RxN2FHWDZoVWFJ?=
 =?utf-8?B?blliejA2Ni9xLzFOZWlwMmREVFN1ZzJ1ZlV1KzF1aWRTZ0hyMmh1N1BXcnI0?=
 =?utf-8?B?VERSNCtIbWJkaTA0MHRDQURXc0lsTXprVGFWdGNRQzBXdXVMY1NoVCt0Nk5s?=
 =?utf-8?B?QWVESFl4Rjhtc0w0SXBEaHBnS0FhbDFuKy9VM3VxeWZsRkM3QitJZ2pURnNY?=
 =?utf-8?B?Z1p5Q0NWU1U0eWwwTWdBeFA1QXZVbU9pcno4NFNkWFJoUEkxeHNJWnNZbDhq?=
 =?utf-8?B?T25mWUI1NzBEU1Rsczd3eDdLd0V0cTR3VU53eGYwWXhmUW9DUlFVcjJmampq?=
 =?utf-8?B?dkl2ZE5NNklnb1FmSStKUlJpSm5KT3l2OGcxd0srUHU4OGNvVjVNV1ZENWlK?=
 =?utf-8?B?YjJsak5sS091OEYzcUlXQytrVVB0aHM2dkJ3TmY1b0NDbUFCUDVXWUdnSVhI?=
 =?utf-8?B?L1BsaDJJelJqZitER2hSREw0aVRkSWg4VTI4QktYUzFIN1BoYWh2cUJWdG1y?=
 =?utf-8?B?V2ZlWjIwTVFpM2tiQUhWTnR3TzV5Vk80em9uU1RHb1Q5OXRuWnhnQjN3aXRT?=
 =?utf-8?B?UXhITkI3R0E4blQxdGVvQ1EzUXh1WG1HWGI3QnB5aUZzK0g1eU52SkJtcUdx?=
 =?utf-8?B?Z0xYa00yY25ibzFZTm9xQnlZZEhXcVlqcEN2K3I5dTBOZ2ZMS0szVVFjR2lt?=
 =?utf-8?B?YnFkL1FSNmUwc2ZETHVWdXp2WkhsVWc0L2NVckRhcXk0QXpBalN0VVc2dVZP?=
 =?utf-8?B?NHhLT08rL09EVm91TGV5OUVpdFhmalliQzkxMThFQ3JQUnZXQ3AzSi83NHBP?=
 =?utf-8?B?bkV3dHVLcC9Ua3hJcnF5cGxxVEF3NG0zTWhrL3AwcHpwNlhsNHNaK2UwVnR6?=
 =?utf-8?B?WVVsV3lvcUdrNk1NSDdvcW1ISUZiVndqUnZmM1M5T3RJYk5pcU9WRnlqc2xm?=
 =?utf-8?B?aGdyaDRRVkpwdHVpWGNldE5mQ0VWUlR2dXNXN04vUDhvemFrU1pqV1p2Rk94?=
 =?utf-8?B?ZjRTR3NTNzhRVXAxVnVkUngxdFZFanE5SlFNYmlKT1lDNitOQ1VHbXdVSzRj?=
 =?utf-8?B?ZThOYzR4MW5PcHZsa3lWRUpoTDFyVWY2dmI1TTJ4UW84UjZWbmVReFBRYlFC?=
 =?utf-8?B?elNUakh5WVU1Q0V4T1YvNDdlWW9tOVNwdTdRNUVQWE9RRWs1VGExVU8zU1lH?=
 =?utf-8?B?U2xqbFdFcy9xK0ZUeGg4eUZqbW1pbjBRSlozRW9FZTlOanRlQy9oNGFPRGU3?=
 =?utf-8?B?cEFiR0pJbHNQUjVqVkhrVFROMEVxemNtUVNrcUR5bjRxaEkwcy9Gak5CN1lE?=
 =?utf-8?B?V1A3NDBoeGxpUUROOGYyckg3Mi9nWXpWTkxhbEZISXJtcmEwTVFmeXBuQ1RJ?=
 =?utf-8?Q?Addpz7a0zOTs+ebmPbsN01J9U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137fa4f0-b267-4211-2df6-08db837427ae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:38:31.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab7cvatw+yx0mbHN0dSElWGCn9QMptQuVbCWm6yGkhFyTs6UTSke9QGbJas4RgHufK/r4qPVdiyHai9XtMquAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7831
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 9:34 AM, Shengjiu Wang wrote:
> 
> 
> The Audio Clock Mux (ACM) is a collection of control registers
> and multiplexers that are used to route the audio source clocks
> to the audio peripherals.
> 
> Each audio peripheral has its dedicated audio clock mux
> (which differ based on usage) and control register.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v4:
> - fix the error for module build reported by kernel test robot
> 
> changes in v3:
> - change compatible string from nxp to fsl
> 
> changes in v2:
> - none
> 
>   drivers/clk/imx/Makefile       |   3 +-
>   drivers/clk/imx/clk-imx8-acm.c | 477 +++++++++++++++++++++++++++++++++
>   2 files changed, 479 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/imx/clk-imx8-acm.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index ae9d84ef046b..d4b8e10b1970 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -32,11 +32,12 @@ obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> 
>   obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
> 
> -obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
> +obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
>   clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
>                                       clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o \
>                                       clk-imx8dxl-rsrc.o
>   clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
> +clk-imx-acm-$(CONFIG_CLK_IMX8QXP) = clk-imx8-acm.o
> 
>   obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
> 
> diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
> new file mode 100644
> index 000000000000..eb4eacba267a
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8-acm.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2018-2023 NXP

The year should be 2023?

> +//
> +
> +#include <dt-bindings/clock/imx8-clock.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +/**
> + * struct clk_imx_acm_pm_domains: structure for multi power domain
> + * @pd_dev: power domain device
> + * @pd_dev_link: power domain device link
> + * @num_domains: power domain nummber
> + */
> +struct clk_imx_acm_pm_domains {
> +       struct device **pd_dev;
> +       struct device_link **pd_dev_link;
> +       int    num_domains;
> +};
> +
> +/**
> + * struct clk_imx8_acm_sel: for clock mux
> + * @name: clock name
> + * @clkid: clock id
> + * @parents: clock parents
> + * @num_parents: clock parents number
> + * @reg: register offset
> + * @shift: bit shift in register
> + * @width: bits width
> + */
> +struct clk_imx8_acm_sel {
> +       const char                      *name;
> +       int                             clkid;
> +       const struct clk_parent_data    *parents;       /* For mux */
> +       int                             num_parents;
> +       u32                             reg;
> +       u8                              shift;
> +       u8                              width;
> +};
> +
> +/**
> + * struct imx8_acm_soc_data: soc specific data
> + * @sels: pointer to struct clk_imx8_acm_sel
> + * @num_sels: numbers of items
> + */
> +struct imx8_acm_soc_data {
> +       struct clk_imx8_acm_sel *sels;
> +       unsigned int num_sels;
> +};
> +
> +/**
> + * struct imx8_acm_priv: private structure
> + * @dev_pm: multi power domain
> + * @soc_data: pointer to soc data
> + * @reg: base address of registers
> + * @regs: save registers for suspend
> + */
> +struct imx8_acm_priv {
> +       struct clk_imx_acm_pm_domains dev_pm;
> +       const struct imx8_acm_soc_data *soc_data;
> +       void __iomem *reg;
> +       u32 regs[IMX_ADMA_ACM_CLK_END];
> +};
> +
> +static const struct clk_parent_data imx8qm_aud_clk_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.fw_name = "mlb_clk", .name = "mlb_clk" },
> +       {.fw_name = "hdmi_rx_mclk", .name = "hdmi_rx_mclk" },
> +       {.fw_name = "ext_aud_mclk0", .name = "ext_aud_mclk0" },
> +       {.fw_name = "ext_aud_mclk1", .name = "ext_aud_mclk1" },
> +       {.fw_name = "esai0_rx_clk", .name = "esai0_rx_clk" },
> +       {.fw_name = "esai0_rx_hf_clk", .name = "esai0_rx_hf_clk" },
> +       {.fw_name = "esai0_tx_clk", .name = "esai0_tx_clk" },
> +       {.fw_name = "esai0_tx_hf_clk", .name = "esai0_tx_hf_clk" },
> +       {.fw_name = "esai1_rx_clk", .name = "esai1_rx_clk" },
> +       {.fw_name = "esai1_rx_hf_clk", .name = "esai1_rx_hf_clk" },
> +       {.fw_name = "esai1_tx_clk", .name = "esai1_tx_clk" },
> +       {.fw_name = "esai1_tx_hf_clk", .name = "esai1_tx_hf_clk" },
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.fw_name = "spdif1_rx", .name = "spdif1_rx" },
> +       {.fw_name = "sai0_rx_bclk", .name = "sai0_rx_bclk" },
> +       {.fw_name = "sai0_tx_bclk", .name = "sai0_tx_bclk" },
> +       {.fw_name = "sai1_rx_bclk", .name = "sai1_rx_bclk" },
> +       {.fw_name = "sai1_tx_bclk", .name = "sai1_tx_bclk" },
> +       {.fw_name = "sai2_rx_bclk", .name = "sai2_rx_bclk" },
> +       {.fw_name = "sai3_rx_bclk", .name = "sai3_rx_bclk" },
> +       {.fw_name = "sai4_rx_bclk", .name = "sai4_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qm_mclk_out_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.fw_name = "mlb_clk", .name = "mlb_clk" },
> +       {.fw_name = "hdmi_rx_mclk", .name = "hdmi_rx_mclk" },
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.fw_name = "spdif1_rx", .name = "spdif1_rx" },
> +       {.fw_name = "sai4_rx_bclk", .name = "sai4_rx_bclk" },
> +       {.fw_name = "sai6_rx_bclk", .name = "sai6_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qm_mclk_sels[] = {
> +       {.fw_name = "aud_pll_div_clk0_lpcg_clk", .name = "aud_pll_div_clk0_lpcg_clk" },
> +       {.fw_name = "aud_pll_div_clk1_lpcg_clk", .name = "aud_pll_div_clk1_lpcg_clk" },
> +       {.fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
> +       {.fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
> +};
> +
> +static const struct clk_parent_data imx8qm_asrc_mux_clk_sels[] = {
> +       {.fw_name = "sai4_rx_bclk", .name = "sai4_rx_bclk" },
> +       {.fw_name = "sai5_tx_bclk", .name = "sai5_tx_bclk" },
> +       {.name = "dummy" },
> +       {.fw_name = "mlb_clk", .name = "mlb_clk" },
> +
> +};
> +
> +static struct clk_imx8_acm_sel imx8qm_sels[] = {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8qm_aud_clk_sels, ARRAY_SIZE(imx8qm_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8qm_aud_clk_sels, ARRAY_SIZE(imx8qm_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8qm_mclk_out_sels, ARRAY_SIZE(imx8qm_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8qm_mclk_out_sels, ARRAY_SIZE(imx8qm_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_asrc0_mclk_sel", IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL, imx8qm_asrc_mux_clk_sels, ARRAY_SIZE(imx8qm_asrc_mux_clk_sels), 0x040000, 0, 2},
> +       {"acm_esai0_mclk_sel", IMX_ADMA_ACM_ESAI0_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x060000, 0, 2},
> +       {"acm_esai1_mclk_sel", IMX_ADMA_ACM_ESAI1_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x070000, 0, 2},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x110000, 0, 2},
> +       {"acm_sai4_mclk_sel", IMX_ADMA_ACM_SAI4_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x120000, 0, 2},
> +       {"acm_sai5_mclk_sel", IMX_ADMA_ACM_SAI5_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x130000, 0, 2},
> +       {"acm_sai6_mclk_sel", IMX_ADMA_ACM_SAI6_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x140000, 0, 2},
> +       {"acm_sai7_mclk_sel", IMX_ADMA_ACM_SAI7_MCLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x150000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_spdif1_mclk_sel", IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x1B0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8qm_mclk_sels, ARRAY_SIZE(imx8qm_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +static const struct clk_parent_data imx8qxp_aud_clk_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.fw_name = "ext_aud_mclk0", .name = "ext_aud_mclk0" },
> +       {.fw_name = "ext_aud_mclk1", .name = "ext_aud_mclk1" },
> +       {.fw_name = "esai0_rx_clk", .name = "esai0_rx_clk" },
> +       {.fw_name = "esai0_rx_hf_clk", .name = "esai0_rx_hf_clk" },
> +       {.fw_name = "esai0_tx_clk", .name = "esai0_tx_clk" },
> +       {.fw_name = "esai0_tx_hf_clk", .name = "esai0_tx_hf_clk" },
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.fw_name = "sai0_rx_bclk", .name = "sai0_rx_bclk" },
> +       {.fw_name = "sai0_tx_bclk", .name = "sai0_tx_bclk" },
> +       {.fw_name = "sai1_rx_bclk", .name = "sai1_rx_bclk" },
> +       {.fw_name = "sai1_tx_bclk", .name = "sai1_tx_bclk" },
> +       {.fw_name = "sai2_rx_bclk", .name = "sai2_rx_bclk" },
> +       {.fw_name = "sai3_rx_bclk", .name = "sai3_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qxp_mclk_out_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.fw_name = "sai4_rx_bclk", .name = "sai4_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8qxp_mclk_sels[] = {
> +       {.fw_name = "aud_pll_div_clk0_lpcg_clk", .name = "aud_pll_div_clk0_lpcg_clk" },
> +       {.fw_name = "aud_pll_div_clk1_lpcg_clk", .name = "aud_pll_div_clk1_lpcg_clk" },
> +       {.fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
> +       {.fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
> +};
> +
> +static struct clk_imx8_acm_sel imx8qxp_sels[] = {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8qxp_aud_clk_sels, ARRAY_SIZE(imx8qxp_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8qxp_aud_clk_sels, ARRAY_SIZE(imx8qxp_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8qxp_mclk_out_sels, ARRAY_SIZE(imx8qxp_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8qxp_mclk_out_sels, ARRAY_SIZE(imx8qxp_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_esai0_mclk_sel", IMX_ADMA_ACM_ESAI0_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x060000, 0, 2},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x110000, 0, 2},
> +       {"acm_sai4_mclk_sel", IMX_ADMA_ACM_SAI4_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x140000, 0, 2},
> +       {"acm_sai5_mclk_sel", IMX_ADMA_ACM_SAI5_MCLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x150000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8qxp_mclk_sels, ARRAY_SIZE(imx8qxp_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +static const struct clk_parent_data imx8dxl_aud_clk_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.fw_name = "ext_aud_mclk0", .name = "ext_aud_mclk0" },
> +       {.fw_name = "ext_aud_mclk1", .name = "ext_aud_mclk1" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.fw_name = "sai0_rx_bclk", .name = "sai0_rx_bclk" },
> +       {.fw_name = "sai0_tx_bclk", .name = "sai0_tx_bclk" },
> +       {.fw_name = "sai1_rx_bclk", .name = "sai1_rx_bclk" },
> +       {.fw_name = "sai1_tx_bclk", .name = "sai1_tx_bclk" },
> +       {.fw_name = "sai2_rx_bclk", .name = "sai2_rx_bclk" },
> +       {.fw_name = "sai3_rx_bclk", .name = "sai3_rx_bclk" },
> +};
> +
> +static const struct clk_parent_data imx8dxl_mclk_out_sels[] = {
> +       {.fw_name = "aud_rec_clk0_lpcg_clk", .name = "aud_rec_clk0_lpcg_clk" },
> +       {.fw_name = "aud_rec_clk1_lpcg_clk", .name = "aud_rec_clk1_lpcg_clk" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.fw_name = "spdif0_rx", .name = "spdif0_rx" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +       {.name = "dummy" },
> +};
> +
> +static const struct clk_parent_data imx8dxl_mclk_sels[] = {
> +       {.fw_name = "aud_pll_div_clk0_lpcg_clk", .name = "aud_pll_div_clk0_lpcg_clk" },
> +       {.fw_name = "aud_pll_div_clk1_lpcg_clk", .name = "aud_pll_div_clk1_lpcg_clk" },
> +       {.fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
> +       {.fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
> +};
> +
> +static struct clk_imx8_acm_sel imx8dxl_sels[] = {
> +       {"acm_aud_clk0_sel", IMX_ADMA_ACM_AUD_CLK0_SEL, imx8dxl_aud_clk_sels, ARRAY_SIZE(imx8dxl_aud_clk_sels), 0x000000, 0, 5},
> +       {"acm_aud_clk1_sel", IMX_ADMA_ACM_AUD_CLK1_SEL, imx8dxl_aud_clk_sels, ARRAY_SIZE(imx8dxl_aud_clk_sels), 0x010000, 0, 5},
> +       {"acm_mclkout0_sel", IMX_ADMA_ACM_MCLKOUT0_SEL, imx8dxl_mclk_out_sels, ARRAY_SIZE(imx8dxl_mclk_out_sels), 0x020000, 0, 3},
> +       {"acm_mclkout1_sel", IMX_ADMA_ACM_MCLKOUT1_SEL, imx8dxl_mclk_out_sels, ARRAY_SIZE(imx8dxl_mclk_out_sels), 0x030000, 0, 3},
> +       {"acm_sai0_mclk_sel", IMX_ADMA_ACM_SAI0_MCLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x0E0000, 0, 2},
> +       {"acm_sai1_mclk_sel", IMX_ADMA_ACM_SAI1_MCLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x0F0000, 0, 2},
> +       {"acm_sai2_mclk_sel", IMX_ADMA_ACM_SAI2_MCLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x100000, 0, 2},
> +       {"acm_sai3_mclk_sel", IMX_ADMA_ACM_SAI3_MCLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x110000, 0, 2},
> +       {"acm_spdif0_mclk_sel", IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x1A0000, 0, 2},
> +       {"acm_mqs_mclk_sel", IMX_ADMA_ACM_MQS_TX_CLK_SEL, imx8dxl_mclk_sels, ARRAY_SIZE(imx8dxl_mclk_sels), 0x1C0000, 0, 2},
> +};
> +
> +/**
> + * clk_imx_acm_attach_pm_domains: attach multi power domains
> + * @dev: device pointer
> + * @dev_pm: power domains for device
> + */
> +static int clk_imx_acm_attach_pm_domains(struct device *dev,
> +                                        struct clk_imx_acm_pm_domains *dev_pm)
> +{
> +       int ret;
> +       int i;
> +
> +       dev_pm->num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
> +                                                        "#power-domain-cells");
> +       if (dev_pm->num_domains <= 1)
> +               return 0;
> +
> +       dev_pm->pd_dev = devm_kmalloc_array(dev, dev_pm->num_domains,
> +                                           sizeof(*dev_pm->pd_dev),
> +                                           GFP_KERNEL);
> +       if (!dev_pm->pd_dev)
> +               return -ENOMEM;
> +
> +       dev_pm->pd_dev_link = devm_kmalloc_array(dev,
> +                                                dev_pm->num_domains,
> +                                                sizeof(*dev_pm->pd_dev_link),
> +                                                GFP_KERNEL);
> +       if (!dev_pm->pd_dev_link)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < dev_pm->num_domains; i++) {
> +               dev_pm->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> +               if (IS_ERR(dev_pm->pd_dev[i]))
> +                       return PTR_ERR(dev_pm->pd_dev[i]);
> +
> +               dev_pm->pd_dev_link[i] = device_link_add(dev,
> +                                                        dev_pm->pd_dev[i],
> +                                                        DL_FLAG_STATELESS |
> +                                                        DL_FLAG_PM_RUNTIME |
> +                                                        DL_FLAG_RPM_ACTIVE);
> +               if (IS_ERR(dev_pm->pd_dev_link[i])) {
> +                       dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +                       ret = PTR_ERR(dev_pm->pd_dev_link[i]);
> +                       goto detach_pm;
> +               }
> +       }
> +       return 0;
> +
> +detach_pm:
> +       while (--i >= 0) {
> +               device_link_del(dev_pm->pd_dev_link[i]);
> +               dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +       }
> +       return ret;
> +}
> +
> +/**
> + * clk_imx_acm_detach_pm_domains: detach multi power domains
> + * @dev: deivice pointer
> + * @dev_pm: multi power domain for device
> + */
> +static int clk_imx_acm_detach_pm_domains(struct device *dev,
> +                                        struct clk_imx_acm_pm_domains *dev_pm)
> +{
> +       int i;
> +
> +       if (dev_pm->num_domains <= 1)
> +               return 0;
> +
> +       for (i = 0; i < dev_pm->num_domains; i++) {
> +               device_link_del(dev_pm->pd_dev_link[i]);
> +               dev_pm_domain_detach(dev_pm->pd_dev[i], false);
> +       }
> +
> +       return 0;
> +}
> +
> +static int imx8_acm_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct device *dev = &pdev->dev;
> +       struct clk_imx8_acm_sel *sels;
> +       struct imx8_acm_priv *priv;
> +       struct resource *res;
> +       struct clk_hw **hws;
> +       void __iomem *base;
> +       int ret;
> +       int i;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap(dev, res->start, resource_size(res));
> +       if (!base)
> +               return -ENOMEM;

Could this be simplied with devm_of_iomap?

> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->reg = base;
> +       priv->soc_data = of_device_get_match_data(dev);
> +       platform_set_drvdata(pdev, priv);
> +
> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +                                         IMX_ADMA_ACM_CLK_END), GFP_KERNEL);

Use devm_kzalloc?

Regards,
Peng.

> +
> +       clk_hw_data->num = IMX_ADMA_ACM_CLK_END;
> +       hws = clk_hw_data->hws;
> +
> +       ret = clk_imx_acm_attach_pm_domains(&pdev->dev, &priv->dev_pm);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_get_sync(&pdev->dev);
> +
> +       sels = priv->soc_data->sels;
> +       for (i = 0; i < priv->soc_data->num_sels; i++) {
> +               hws[sels[i].clkid] = devm_clk_hw_register_mux_parent_data_table(dev,
> +                                                                               sels[i].name, sels[i].parents,
> +                                                                               sels[i].num_parents, 0,
> +                                                                               base + sels[i].reg,
> +                                                                               sels[i].shift, sels[i].width,
> +                                                                               0, NULL, NULL);
> +               if (IS_ERR(hws[sels[i].clkid])) {
> +                       pm_runtime_disable(&pdev->dev);
> +                       goto err_clk_register;
> +               }
> +       }
> +
> +       imx_check_clk_hws(hws, IMX_ADMA_ACM_CLK_END);
> +
> +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register hws for ACM\n");
> +               pm_runtime_disable(&pdev->dev);
> +       }
> +
> +err_clk_register:
> +
> +       pm_runtime_put_sync(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static int imx8_acm_clk_remove(struct platform_device *pdev)
> +{
> +       struct imx8_acm_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +       pm_runtime_disable(&pdev->dev);
> +
> +       clk_imx_acm_detach_pm_domains(&pdev->dev, &priv->dev_pm);
> +
> +       return 0;
> +}
> +
> +static const struct imx8_acm_soc_data imx8qm_acm_data = {
> +       .sels = imx8qm_sels,
> +       .num_sels = ARRAY_SIZE(imx8qm_sels),
> +};
> +
> +static const struct imx8_acm_soc_data imx8qxp_acm_data = {
> +       .sels = imx8qxp_sels,
> +       .num_sels = ARRAY_SIZE(imx8qxp_sels),
> +};
> +
> +static const struct imx8_acm_soc_data imx8dxl_acm_data = {
> +       .sels = imx8dxl_sels,
> +       .num_sels = ARRAY_SIZE(imx8dxl_sels),
> +};
> +
> +static const struct of_device_id imx8_acm_match[] = {
> +       { .compatible = "fsl,imx8qm-acm", .data = &imx8qm_acm_data },
> +       { .compatible = "fsl,imx8qxp-acm", .data = &imx8qxp_acm_data },
> +       { .compatible = "fsl,imx8dxl-acm", .data = &imx8dxl_acm_data },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx8_acm_match);
> +
> +static int __maybe_unused imx8_acm_runtime_suspend(struct device *dev)
> +{
> +       struct imx8_acm_priv *priv = dev_get_drvdata(dev);
> +       struct clk_imx8_acm_sel *sels;
> +       int i;
> +
> +       sels = priv->soc_data->sels;
> +
> +       for (i = 0; i < priv->soc_data->num_sels; i++)
> +               priv->regs[i] = readl_relaxed(priv->reg + sels[i].reg);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused imx8_acm_runtime_resume(struct device *dev)
> +{
> +       struct imx8_acm_priv *priv = dev_get_drvdata(dev);
> +       struct clk_imx8_acm_sel *sels;
> +       int i;
> +
> +       sels = priv->soc_data->sels;
> +
> +       for (i = 0; i < priv->soc_data->num_sels; i++)
> +               writel_relaxed(priv->regs[i], priv->reg + sels[i].reg);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops imx8_acm_pm_ops = {
> +       SET_RUNTIME_PM_OPS(imx8_acm_runtime_suspend,
> +                          imx8_acm_runtime_resume, NULL)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                     pm_runtime_force_resume)
> +};
> +
> +static struct platform_driver imx8_acm_clk_driver = {
> +       .driver = {
> +               .name = "imx8-acm",
> +               .of_match_table = imx8_acm_match,
> +               .pm = &imx8_acm_pm_ops,
> +       },
> +       .probe = imx8_acm_clk_probe,
> +       .remove = imx8_acm_clk_remove,
> +};
> +module_platform_driver(imx8_acm_clk_driver);
> +
> +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX8 Audio Clock Mux driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
> 
