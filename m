Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE57BF2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbjJJGGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376502AbjJJGGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:06:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436929D;
        Mon,  9 Oct 2023 23:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irxaYiFjEeo0CfMnKLkmDLX9yol37hGKcWirUi+5OpTPGy3eVCaZPy9qrp9fjegbQcskI7ONqZLYiYaq+im2AwIo5StJxGB4muEocWNda31o/ECPm2So66ZQ/2Wbk+MOxj2/5PsOz6i92g62NvYkRB+M67wnyZXNFyU/pcbw5UOpFQUpOg6xVN8XqoVLDfcfIBzdJ0HypB+nxAa4PwdE1hO76cmoUXbQM9K5VS2+eEpGCNWjCQw7Fyqxm9AnWoh+FCgTcuw0l/IMzx/2CrnOS6RWXBmcJ4G/4OzDtP5kz75jZs4Q91ESXVfPdlcWtax7iwYQ8WFvRanJ8rUHU0lW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx5PYtlWQuVM66BlbEcHA6I6YCIiocQHWAKO3gBEJyY=;
 b=Vn/rnEDRoMnCzSdEvTplNBO7hOqVEcEYJ+meNg6h/jUu1IMJ0LpMDBQrUyYvfabXD2WYs2T9SNKValEVXYmQOE0ejPg9kCNyiFv0JXUXtXzj4omYsrKSF+UowKyPm04zdiMRynO+ANKnkt/eM94jCFKHOBGMA1ZCJ9yb6tcuQDojOyjrqdhM3pOSu4p4oe12UzM2bUgVcVREGK/+fOQd8dbUDwTOJEfgW8WuINzVsCxynf3Tss2I2kd2c9h8C/urfDw/B1rr+3tgI24XS+vpM+LbPPKbRHEkvSPonl8yHxGhrUWEOM4ggRfzPANgosJxOIffEFLE2CEWBUcKk3beWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5PYtlWQuVM66BlbEcHA6I6YCIiocQHWAKO3gBEJyY=;
 b=IfD2NTqcrU9u3Tu4dAXuUUji7f1P8tJXrmZ3xoDAzblMKKHmI8xGXOxjbN6BJsqicn4/3hUo6CbLP4qJRYyTnorkzp9xT7sxZls6gXrJbYoubT1E1IqRPmrDtTyQgyhLcGnQNE9RiJbvSUnNHztF3yZiuMRpgMUP1G/qE9FM43TkSFspaZK0w3P/JInzUmkB1noV31pD44wkEynKVJAEG+Zenul196sZp8LYJa7hzuEMC6p72Nl8G4+YFnm92kn5t7Bmn2DUjm+9xlzIJpgaQmajH/aPYA2YR6yyEGGN+2TmNg9fjj46LpPpiULHq0UV0lU/Sx5coI+Sz+NLAhoLJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB5616.apcprd03.prod.outlook.com (2603:1096:400:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:06:12 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%6]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 06:06:12 +0000
Message-ID: <eaf1d6f2-8a2d-d919-1f5c-57025c6e9235@amlogic.com>
Date:   Tue, 10 Oct 2023 14:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] clk: meson: C3: add support for the C3 SoC PLL clock
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
 <20230928063448.3544464-4-xianwei.zhao@amlogic.com>
 <1jwmw3yi03.fsf@starbuckisacylon.baylibre.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jwmw3yi03.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d3833f-0261-40da-5755-08dbc957012e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wysnSqUE2C3ZhG5eQN/867Lm9tD5Jw9N+mjQntlWgqBajk/v1oFvNu+mSOHMlrOsu+bYBtAFowp1AN19ri8zYPLfqhgwP9g4uyFMapo9GKK4L0CFrsZ35QCL8SPrJ/gGuA8SUidVR6wEmvL+OV5b7xKvPo3wl4JckqDx5s3oCedd5QSHcsMbbbKTfteOj5p8pp9yD1/NIHvQ+OdstCWXVvGmPU73ZW+oh07z2j40i7LHqfEJ7nYFxfaFynL+Fqlq3iCvhAw9/AFQI7aeYiQnyPbVuIKQ8pEbwzOlv+EH2cLRoQ05+E1ZPU9IubWuxyt1MsApR/3wVhxQLFW6HjtgcXtAIoldSL+7/e7327M32X46jXFMzP9nBmhrEBd7TNWsvQ1ysgHha1gsbWUaoPNMhTlFAYHTIxFGTs85qTBPotLjHPIpokkom7Daw5qL3WW1yyDD3ehzIGrrkZpfTbO4dOL0MS3SdkKoIFgGbMVyqPE9H2IVF9IOASwGtRUm/G0u7L799GRrDUscG/Kp8u3RS6PF87Q97z7Azyikpb+NYOhy0QcT84u4XfMTlS01FJZSJww/Pp41W0uf0/K7rB5QlxKRWAyLJOA9OFQ2z6TP3MJ4Q8SU5hC+615oDN1VrWMa/BBOeT1aFtzy6GNpiztgK6dKrFBQqqfARZGMOp5A8afcAnYsUfTaOnk51N8yMyrTe2OUZ9J+/IP7eysat2vpZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39850400004)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(7416002)(478600001)(6486002)(53546011)(83380400001)(6506007)(86362001)(31696002)(26005)(36756003)(6512007)(30864003)(2616005)(6666004)(2906002)(54906003)(316002)(66946007)(66556008)(66476007)(8936002)(31686004)(8676002)(4326008)(44832011)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVZcnBDMTFoUUN6eWN3dkxyZ2JycW5RQ2xna1liR1A1Zm1EeFdsQTE0R3B1?=
 =?utf-8?B?a1hOZkFzdTRmRWpCMmlJWVVKUUx3WHhpNTY2R2hTNllrc1dlenhCQTI2L2s3?=
 =?utf-8?B?cGY3cUVBeDRuNXlDSkg2bjlmSlJweVlJRFcxWGZibTNML1dZTDZMcmM3eWcv?=
 =?utf-8?B?N0M2V0NHYW5YeVluSk9QMmUwU24yZVJoQWpQSFlyOTBRVzhQNHB4Y3dDYlZ3?=
 =?utf-8?B?YVNVZnc5bUQyKzdVMGhFdWFRVldQSmNkeDdJTDdqdy8rODc5MlZBZXZMNTB1?=
 =?utf-8?B?bGwzQnpNTExMSWZDUzc0OGovN21Oc1hVclNFZlQ0MDFiWjU0VytzeEI3Y3d1?=
 =?utf-8?B?N2tlbGRCdEFObEhSeE5qOTJ4enplTXowZzlKNy9oaXRsSlFxaGZ2c2UzeEZ0?=
 =?utf-8?B?TGsyakRENW4zRU1pdzB3SkFjdUY3ZTZGVUtmc25IWDRQVVg0dzF6SFh4Ky9H?=
 =?utf-8?B?STNDaitVWGZPY3pVUzF2bGN2QkRvNzl2YWt4cUluc0lTT3FOdW5HUk8vZExT?=
 =?utf-8?B?VzVacnJqVlZKbzFpUEpnN1hoUlh4U2JheU5IRkU3aGtUOVJacmZzTWRLR251?=
 =?utf-8?B?amp0bTJnNWtHdUVlR2hlaVZmaU0rTnZ1VFRSdjZDYm1MUFJDdTNGTUJmUnNp?=
 =?utf-8?B?NE1tVjNHVGY3Zjh3SmhlODJJR3B2NU5rbkpEaTlYWUl6SzZUQmtheVhHSlR0?=
 =?utf-8?B?NmlHWkxuY2J3MTRYdzBMdklCcEIvTkVxcEdWdjIrYXFxOU10NU51MG95UEtR?=
 =?utf-8?B?c1ZMdzhzdGxYNmtsQ3ZJK3UxNndCTDRDZzRpQ0xNbzRRbU5hZHhTbkFIT3Fw?=
 =?utf-8?B?SmdjMm9tcU5FaVdIcmV0bXJ0Z1V2bjlQTmlUeVVVaFY3dmtUdU4yVVpGdTVy?=
 =?utf-8?B?L3M4K0QrZ3c1Z0dNaGd3ck5yUlQwYnpJRWxCazkxMTRNSFV6K2FpMVl3Y1BJ?=
 =?utf-8?B?SGJVMnd4UXRhdFo4U0pMZXdQUzdQNDEwVmwvOGpQbHJXdjNvVVNZaHNOblp2?=
 =?utf-8?B?d3hJNmpVaEswbzVERU1yZzIrejZIcHJEWUZLMDdYZTZ1NG0yT2Z3QUhmL21n?=
 =?utf-8?B?WXRoR2JmMXpsbm0vM3F2K25LUXIyY1BLZ0Y5aDhFS2FyZlpTelB1TjlYMWJV?=
 =?utf-8?B?VCtyWGIrRXp0ME5JeWtUN01yeUFkY1pSQ3JEemFaTUs5QU5mR05XQXczcXBY?=
 =?utf-8?B?eDhRNnVabVdORlpXamhLb1o0bnk1NnRJcDZUSEd4N0pTWUJUSitlWS9PeXY5?=
 =?utf-8?B?aGxKK2NBMHlqUHZiZHVJMG1EZmNRUHpGc0ZHSE9zdEhKMHhyb3EwdDYvdkNk?=
 =?utf-8?B?YnVOelNiRGk2K01HaXZQUDlhOHR1MGlXVndoMzVkbDlWTG1uWU1mRGdTRWdK?=
 =?utf-8?B?SXJDUGNEdE1PTXlBQ1dDazhzZlhkRHcwN2IrbzRZQnRoSjZENDNLb1BGYUNa?=
 =?utf-8?B?K094blRrd1JrRnpQbXNKbmlJeTVXS1lnZitKb01MK081U3JaalNEeEsvTWRG?=
 =?utf-8?B?OFFmYzNIZTM3Y3VMbmRJeWlhSmFnSWliQmdURkJ2MEplQnVCTlhCN0s2c1JD?=
 =?utf-8?B?YTNFQnNtTys0ZXZTV1dmRlpkNmtNallXQWcwRWdCMGxZQi96RC95OWdYWEtU?=
 =?utf-8?B?cG8wVlFtN1ZZS3lKK09tUHk5ODJzUjFtK1loY3p6V0pVaHRRMjBIYzFuOUFp?=
 =?utf-8?B?WHBVMjdDQm9mVGNYQ040L2hSMTIvRlZCaVhZRGxCNjJoL0ljRWgvRW1YZ0g1?=
 =?utf-8?B?NkE4VUUrYUk2K3ZDTDcrMVFwUnJRNEs2bCtLUFVZcDRFaElXL285c1NaVG9p?=
 =?utf-8?B?SENvR1NCaVVmaWNlU0Fna2M5SXBNYW5odVBQbE1KQnEzdTNWZFRvWFZiWHU3?=
 =?utf-8?B?NHRZYmdiR0xwWlVEMzFFaG5GS0dpUWp4emZKYUxXQzU5TDY2bXduTWd2S0lk?=
 =?utf-8?B?a2xoRFE1OG5WSldOc2RNMGZQTWZqb1k5cHZTSUxhOFErU2I4UGVmbFQ4V2xz?=
 =?utf-8?B?akFnRWU1NHhqZHV6aURYcDN5V0RBblB4OStxNnlxMmxYZDhnTHl1OGRUeDZw?=
 =?utf-8?B?VDVRT2orTUw2VWpzdjVIeU9TeWFLMDRJY2t0WXpjVEVGZUJWRTByZjZlTUU2?=
 =?utf-8?B?OTQzcXo4aXlOQUlnYnp6SnhqOWJuZVpPVGVaNDVCL0xXT1AxRG84bjV2U081?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d3833f-0261-40da-5755-08dbc957012e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:06:12.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m18F2kf6MRgCO+1oiUwxK8rXjpC1brXGBAghDO6VOpnP6Fo46l0ANudCUA9+p0URluGZaBnk82eatJ3OB0O1Bc2ye2Y7Qb3sDVKGkqPnIb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5616
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
      Thanks for your advise, I will delete marco definition in next 
version.

On 2023/10/3 20:55, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu 28 Sep 2023 at 14:34, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  12 +
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/c3-pll.c | 510 +++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/c3-pll.h |  35 +++
>>   4 files changed, 558 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-pll.c
>>   create mode 100644 drivers/clk/meson/c3-pll.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index c5303e4c1604..76be4bbd2afb 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,6 +128,18 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_C3_PLL
>> +     tristate "Amlogic C3 PLL clock controller"
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>> +       AKA c3. Amlogic C302X and C308L devices include AW402, AW409 and AW419.
>> +       Say Y if you want the board to work, because PLLs are the parent of most
>> +       peripherals.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 9ee4b954c896..4420af628b31 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>> new file mode 100644
>> index 000000000000..5244dc19ab6e
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.c
>> @@ -0,0 +1,510 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 PLL Controller Driver
>> + *
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> 
> If Chuan is Author, shouldn't get his Signed-off-by ?
> Maybe Co-developed-by as well ?
> 
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "c3-pll.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>> +
>> +#define MEMBER_REG_PARM(_member_name, _reg, _shift, _width)          \
>> +     ._member_name = {                                               \
>> +             .reg_off = _reg,                                        \
>> +             .shift   = _shift,                                      \
>> +             .width   = _width,                                      \
>> +}
>> +
>> +#define __AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,          \
>> +                     _m_reg, _m_shift, _m_width,                     \
>> +                     _f_reg, _f_shift, _f_width,                     \
>> +                     _n_reg, _n_shift, _n_width,                     \
>> +                     _l_reg, _l_shift, _l_width,                     \
>> +                     _r_reg, _r_shift, _r_width,                     \
>> +                     _init_reg, _init_reg_cnt, _range, _table,       \
>> +                     _dflags, _ops, _pname, _pdata, _phw, _iflags)   \
>> +static struct clk_regmap _name = {                                   \
>> +     .data = &(struct meson_clk_pll_data){                           \
>> +             MEMBER_REG_PARM(en,                                     \
>> +                     _en_reg, _en_shift, _en_width),                 \
>> +             MEMBER_REG_PARM(m,                                      \
>> +                     _m_reg, _m_shift, _m_width),                    \
>> +             MEMBER_REG_PARM(frac,                                   \
>> +                     _f_reg, _f_shift, _f_width),                    \
>> +             MEMBER_REG_PARM(n,                                      \
>> +                     _n_reg, _n_shift, _n_width),                    \
>> +             MEMBER_REG_PARM(l,                                      \
>> +                     _l_reg, _l_shift, _l_width),                    \
>> +             MEMBER_REG_PARM(rst,                                    \
>> +                     _r_reg, _r_shift, _r_width),                    \
>> +             .range = _range,                                        \
>> +             .table = _table,                                        \
>> +             .init_regs = _init_reg,                                 \
>> +             .init_count = _init_reg_cnt,                            \
>> +             .flags = _dflags,                                       \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data){                             \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_names = _pname,                                 \
>> +             .parent_data = _pdata,                                  \
>> +             .parent_hws = (const struct clk_hw *[]) {_phw},         \
>> +             .num_parents = 1,                                       \
>> +             .flags = _iflags,                                       \
>> +     },                                                              \
>> +}
>> +
>> +#define __AML_CLK_MUX(_name, _reg, _mask, _shift, _table, _dflags,   \
>> +                     _ops, _pname, _pdata, _phw, _pnub, _iflags)     \
>> +static struct clk_regmap _name = {                                   \
>> +     .data = &(struct clk_regmap_mux_data){                          \
>> +             .offset = _reg,                                         \
>> +             .mask = _mask,                                          \
>> +             .shift = _shift,                                        \
>> +             .table = _table,                                        \
>> +             .flags = _dflags,                                       \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data){                             \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_names = _pname,                                 \
>> +             .parent_data = _pdata,                                  \
>> +             .parent_hws = (const struct clk_hw *[]) { _phw },       \
>> +             .num_parents = _pnub,                                   \
>> +             .flags = _iflags,                                       \
>> +     },                                                              \
>> +}
>> +
>> +#define __AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,  \
>> +                     _ops, _pname, _pdata, _phw, _iflags)            \
>> +static struct clk_regmap _name = {                                   \
>> +     .data = &(struct clk_regmap_div_data){                          \
>> +             .offset = _reg,                                         \
>> +             .shift = _shift,                                        \
>> +             .width = _width,                                        \
>> +             .table = _table,                                        \
>> +             .flags = _dflags,                                       \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data){                             \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_names = _pname,                                 \
>> +             .parent_data = _pdata,                                  \
>> +             .parent_hws = (const struct clk_hw *[]) { _phw },       \
>> +             .num_parents = 1,                                       \
>> +             .flags = _iflags,                                       \
>> +     },                                                              \
>> +}
>> +
>> +#define __AML_CLK_GATE(_name, _reg, _bit, _gflags,                   \
>> +                      _ops, _pname, _pdata, _phw, _iflags)           \
>> +static struct clk_regmap _name = {                                   \
>> +     .data = &(struct clk_regmap_gate_data){                         \
>> +             .offset = _reg,                                         \
>> +             .bit_idx = _bit,                                        \
>> +             .flags = _gflags,                                       \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data) {                            \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_names = _pname,                                 \
>> +             .parent_data = _pdata,                                  \
>> +             .parent_hws = (const struct clk_hw *[]) { _phw },       \
>> +             .num_parents = 1,                                       \
>> +             .flags = _iflags,                                       \
>> +     },                                                              \
>> +}
>> +
>> +#define __AML_CLK_FIXED_FACTOR(_name, _mult, _div, _ops,             \
>> +                              _pname, _pdata, _phw, _iflags)         \
>> +     static struct clk_fixed_factor _name = {                        \
>> +             .mult = _mult,                                          \
>> +             .div = _div,                                            \
>> +             .hw.init = &(struct clk_init_data){                     \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_names = _pname,                                 \
>> +             .parent_data = _pdata,                                  \
>> +             .parent_hws = (const struct clk_hw *[]) { _phw },       \
>> +             .num_parents = 1,                                       \
>> +             .flags = _iflags,                                       \
>> +     },                                                              \
>> +}
>> +
>> +#define AML_CLK_PLL_RW(_name, _en_reg, _en_shift, _en_width,         \
>> +                   _m_reg, _m_shift, _m_width,                       \
>> +                   _f_reg, _f_shift, _f_width,                       \
>> +                   _n_reg, _n_shift, _n_width,                       \
>> +                   _l_reg, _l_shift, _l_width,                       \
>> +                   _r_reg, _r_shift, _r_width,                       \
>> +                   _init_reg, _init_reg_cnt, _range, _table, _dflags,\
>> +                   _pdata, _iflags)                                  \
>> +     __AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,             \
>> +                     _m_reg, _m_shift, _m_width,                     \
>> +                     _f_reg, _f_shift, _f_width,                     \
>> +                     _n_reg, _n_shift, _n_width,                     \
>> +                     _l_reg, _l_shift, _l_width,                     \
>> +                     _r_reg, _r_shift, _r_width,                     \
>> +                     _init_reg, _init_reg_cnt, _range, _table,       \
>> +                     _dflags, &meson_clk_pll_ops,                    \
>> +                     NULL, _pdata, NULL, _iflags)
>> +
>> +#define AML_CLK_PLL_RO(_name, _en_reg, _en_shift, _en_width,         \
>> +                      _m_reg, _m_shift, _m_width,                    \
>> +                      _f_reg, _f_shift, _f_width,                    \
>> +                      _n_reg, _n_shift, _n_width,                    \
>> +                      _l_reg, _l_shift, _l_width,                    \
>> +                      _r_reg, _r_shift, _r_width,                    \
>> +                      _init_reg, _init_reg_cnt, _range, _table,      \
>> +                      _dflags, _pdata, _iflags)                      \
>> +     __AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,             \
>> +                     _m_reg, _m_shift, _m_width,                     \
>> +                     _f_reg, _f_shift, _f_width,                     \
>> +                     _n_reg, _n_shift, _n_width,                     \
>> +                     _l_reg, _l_shift, _l_width,                     \
>> +                     _r_reg, _r_shift, _r_width,                     \
>> +                     _init_reg, _init_reg_cnt, _range, _table,       \
>> +                     _dflags, &meson_clk_pll_ro_ops,                 \
>> +                     NULL, _pdata, NULL, _iflags)
>> +
>> +#define AML_CLK_MUX_RW(_name, _reg, _mask, _shift, _table, _dflags,  \
>> +                      _pdata, _iflags)                               \
>> +     __AML_CLK_MUX(_name, _reg, _mask, _shift, _table, _dflags,      \
>> +                     &clk_regmap_mux_ops, NULL, _pdata, NULL,        \
>> +                     ARRAY_SIZE(_pdata), _iflags)
>> +
>> +#define AML_CLK_DIV_RW(_name, _reg, _shift, _width, _table, _dflags, \
>> +                      _phw, _iflags)                                 \
>> +     __AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,     \
>> +                     &clk_regmap_divider_ops, NULL, NULL,            \
>> +                            _phw, _iflags)
>> +
>> +#define AML_CLK_DIV_RO(_name, _reg, _shift, _width, _table, _dflags, \
>> +                      _phw, _iflags)                                 \
>> +     __AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,     \
>> +                     &clk_regmap_divider_ro_ops, NULL, NULL,         \
>> +                     _phw, _iflags)
>> +
>> +#define AML_CLK_GATE_RW(_name, _reg, _bit, _dflags, _phw, _iflags)   \
>> +     __AML_CLK_GATE(_name, _reg, _bit, _dflags,                      \
>> +                      &clk_regmap_gate_ops, NULL, NULL, _phw,        \
>> +                      _iflags)
>> +
>> +#define AML_CLK_GATE_RO(_name, _reg, _bit, _dflags, _phw, _iflags)   \
>> +     __AML_CLK_GATE(_name, _reg, _bit, _dflags,                      \
>> +                      &clk_regmap_gate_ro_ops, NULL, NULL, _phw,     \
>> +                      _iflags)
>> +
>> +#define AML_CLK_FIXED_FACTOR(_name, _mult, _div, _phw, _iflags)      \
>> +     __AML_CLK_FIXED_FACTOR(_name, _mult, _div,                      \
>> +                              &clk_fixed_factor_ops, NULL, NULL,     \
>> +                              _phw, _iflags)
>> +
> 
> I don't get why all these macro are needed ? I don't see a 10 instances
> of the very same clock that would justify this.
> 
> It makes this driver borderline un-reviewable.
> 
> Unless you can provide a very reason why it is better like this, please
> have a look a the a1 and s4 controllers and re-submit.
> 
> Same goes for patch #4
> 
> 
>> +static const struct clk_parent_data pll_dco_parent = {
>> +     .fw_name = "pll_in",
>> +};
>> +
>> +static const struct clk_parent_data mclk_pll_dco_parent = {
>> +     .fw_name = "mclk_pll_in",
>> +};
>> +
>> +AML_CLK_PLL_RO(fixed_pll_dco, ANACTRL_FIXPLL_CTRL0, 28, 1,  /* en */
>> +             ANACTRL_FIXPLL_CTRL0, 0,  8,  /* m */
>> +             0, 0,  0,  /* frac */
>> +             ANACTRL_FIXPLL_CTRL0, 16, 5,  /* n */
>> +             ANACTRL_FIXPLL_CTRL0, 31, 1,  /* lock */
>> +             ANACTRL_FIXPLL_CTRL0, 29, 1,  /* rst */
>> +             NULL, 0, NULL, NULL, 0, &pll_dco_parent, 0);
>> +AML_CLK_DIV_RO(fixed_pll, ANACTRL_FIXPLL_CTRL0, 12, 3, NULL,
>> +              CLK_DIVIDER_POWER_OF_TWO, &fixed_pll_dco.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div40_div, 1, 40, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div40, ANACTRL_FIXPLL_CTRL4, 0, 0, &fclk_div40_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div2_div, 1, 2, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div2, ANACTRL_FIXPLL_CTRL4, 24, 0, &fclk_div2_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div2p5_div, 2, 5, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div2p5, ANACTRL_FIXPLL_CTRL4, 4, 0, &fclk_div2p5_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div3_div, 1, 3, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div3, ANACTRL_FIXPLL_CTRL4, 20, 0, &fclk_div3_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div4_div, 1, 4, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div4, ANACTRL_FIXPLL_CTRL4, 21, 0, &fclk_div4_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div5_div, 1, 5, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div5, ANACTRL_FIXPLL_CTRL4, 22, 0, &fclk_div5_div.hw, 0);
>> +AML_CLK_FIXED_FACTOR(fclk_div7_div, 1, 7, &fixed_pll.hw, 0);
>> +AML_CLK_GATE_RO(fclk_div7, ANACTRL_FIXPLL_CTRL4, 23, 0, &fclk_div7_div.hw, 0);
>> +
>> +static const struct reg_sequence c3_gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x0 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000, .delay_us = 10 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x080304fa },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x380304fa, .delay_us = 10 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0X180304fa }
>> +};
>> +
>> +static const struct pll_params_table c3_gp0_pll_params_table[] = {
>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>> +     { /* sentinel */  }
>> +};
>> +
>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { 5, 32 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +AML_CLK_PLL_RW(gp0_pll_dco, ANACTRL_GP0PLL_CTRL0, 28, 1,  /* en */
>> +             ANACTRL_GP0PLL_CTRL0, 0,  9,  /* m */
>> +             ANACTRL_GP0PLL_CTRL1, 0, 19,  /* frac */
>> +             ANACTRL_GP0PLL_CTRL0, 10, 5,  /* n */
>> +             ANACTRL_GP0PLL_CTRL0, 31, 1,  /* lock */
>> +             ANACTRL_GP0PLL_CTRL0, 29, 1,  /* rst */
>> +             c3_gp0_init_regs, ARRAY_SIZE(c3_gp0_init_regs),
>> +             NULL, c3_gp0_pll_params_table, 0,
>> +             &pll_dco_parent, 0);
>> +AML_CLK_DIV_RW(gp0_pll, ANACTRL_GP0PLL_CTRL0, 16, 3,
>> +             c3_gp0_pll_od_table, 0,
>> +             &gp0_pll_dco.hw, CLK_SET_RATE_PARENT);
>> +
>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x08010496 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x38010496 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x0000ce40 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000, .delay_us = 50 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x18010496, .delay_us = 20 },
>> +};
>> +
>> +static const struct pll_params_table c3_hifi_pll_params_table[] = {
>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>> +     { /* sentinel */  }
>> +};
>> +
>> +AML_CLK_PLL_RW(hifi_pll_dco, ANACTRL_HIFIPLL_CTRL0, 28, 1,  /* en */
>> +             ANACTRL_HIFIPLL_CTRL0, 0,  8,  /* m */
>> +             ANACTRL_HIFIPLL_CTRL1, 0, 19,  /* frac */
>> +             ANACTRL_HIFIPLL_CTRL0, 10, 5,  /* n */
>> +             ANACTRL_HIFIPLL_CTRL0, 31, 1,  /* lock */
>> +             ANACTRL_HIFIPLL_CTRL0, 29, 1,  /* rst */
>> +             c3_hifi_init_regs, ARRAY_SIZE(c3_hifi_init_regs),
>> +             NULL, c3_hifi_pll_params_table, 0,
>> +             &pll_dco_parent, 0);
>> +AML_CLK_DIV_RW(hifi_pll, ANACTRL_HIFIPLL_CTRL0, 16, 2,
>> +             NULL, CLK_DIVIDER_POWER_OF_TWO,
>> +             &hifi_pll_dco.hw, CLK_SET_RATE_PARENT);
>> +
>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x20011063 },
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x30011063 },
>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x10011063 },
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>> +};
>> +
>> +static const struct pll_params_table c3_mclk_pll_params_table[] = {
>> +     PLL_PARAMS(99, 1), /* VCO = 2376M */
>> +     { /* sentinel */  }
>> +};
>> +
>> +static const struct clk_div_table c3_mpll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +AML_CLK_PLL_RW(mclk_pll_dco, ANACTRL_MPLL_CTRL0, 28, 1,  /* en */
>> +             ANACTRL_MPLL_CTRL0, 0,  8,  /* m */
>> +             0, 0, 0,  /* frac */
>> +             ANACTRL_MPLL_CTRL0, 16, 5,  /* n */
>> +             ANACTRL_MPLL_CTRL0, 31, 1,  /* lock */
>> +             ANACTRL_MPLL_CTRL0, 29, 1,  /* rst */
>> +             c3_mclk_init_regs, ARRAY_SIZE(c3_mclk_init_regs),
>> +             NULL, c3_mclk_pll_params_table, 0,
>> +             &mclk_pll_dco_parent, 0);
>> +AML_CLK_DIV_RW(mclk_pll, ANACTRL_MPLL_CTRL0, 12, 3,
>> +             c3_mpll_od_table, 0,
>> +             &mclk_pll_dco.hw, CLK_SET_RATE_PARENT);
>> +AML_CLK_DIV_RW(mclk_pll_clk, ANACTRL_MPLL_CTRL4, 16, 5, NULL,
>> +             CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>> +             &mclk_pll.hw, CLK_SET_RATE_PARENT);
>> +
>> +static const struct clk_parent_data mclk_parent[] = {
>> +     { .hw = &mclk_pll_clk.hw },
>> +     { .fw_name = "mclk_pll_in" },
>> +     { .hw = &fclk_div40.hw }
>> +};
>> +
>> +AML_CLK_MUX_RW(mclk0_sel, ANACTRL_MPLL_CTRL4, 0x3, 4, NULL, 0,
>> +             mclk_parent, 0);
>> +AML_CLK_GATE_RW(mclk0_sel_out, ANACTRL_MPLL_CTRL4, 1, 0,
>> +             &mclk0_sel.hw, CLK_SET_RATE_PARENT);
>> +AML_CLK_DIV_RW(mclk0_div, ANACTRL_MPLL_CTRL4, 2, 1, NULL, 0,
>> +             &mclk0_sel_out.hw, CLK_SET_RATE_PARENT);
>> +AML_CLK_GATE_RW(mclk0, ANACTRL_MPLL_CTRL4, 0, 0,
>> +             &mclk0_div.hw, CLK_SET_RATE_PARENT);
>> +
>> +AML_CLK_MUX_RW(mclk1_sel, ANACTRL_MPLL_CTRL4, 0x3, 12, NULL, 0,
>> +             mclk_parent, 0);
>> +AML_CLK_GATE_RW(mclk1_sel_out, ANACTRL_MPLL_CTRL4, 9, 0,
>> +             &mclk1_sel.hw, CLK_SET_RATE_PARENT);
>> +AML_CLK_DIV_RW(mclk1_div, ANACTRL_MPLL_CTRL4, 10, 1, NULL, 0,
>> +             &mclk1_sel_out.hw, CLK_SET_RATE_PARENT);
>> +AML_CLK_GATE_RW(mclk1, ANACTRL_MPLL_CTRL4, 8, 0,
>> +             &mclk1_div.hw, CLK_SET_RATE_PARENT);
>> +
>> +static struct clk_hw *c3_pll_hw_clks[] = {
>> +     [CLKID_FIXED_PLL_DCO]   = &fixed_pll_dco.hw,
>> +     [CLKID_FIXED_PLL]       = &fixed_pll.hw,
>> +     [CLKID_FCLK_DIV40_DIV]  = &fclk_div40_div.hw,
>> +     [CLKID_FCLK_DIV40]      = &fclk_div40.hw,
>> +     [CLKID_FCLK_DIV2_DIV]   = &fclk_div2_div.hw,
>> +     [CLKID_FCLK_DIV2]       = &fclk_div2.hw,
>> +     [CLKID_FCLK_DIV2P5_DIV] = &fclk_div2p5_div.hw,
>> +     [CLKID_FCLK_DIV2P5]     = &fclk_div2p5.hw,
>> +     [CLKID_FCLK_DIV3_DIV]   = &fclk_div3_div.hw,
>> +     [CLKID_FCLK_DIV3]       = &fclk_div3.hw,
>> +     [CLKID_FCLK_DIV4_DIV]   = &fclk_div4_div.hw,
>> +     [CLKID_FCLK_DIV4]       = &fclk_div4.hw,
>> +     [CLKID_FCLK_DIV5_DIV]   = &fclk_div5_div.hw,
>> +     [CLKID_FCLK_DIV5]       = &fclk_div5.hw,
>> +     [CLKID_FCLK_DIV7_DIV]   = &fclk_div7_div.hw,
>> +     [CLKID_FCLK_DIV7]       = &fclk_div7.hw,
>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>> +     [CLKID_MCLK_PLL_CLK]    = &mclk_pll_clk.hw,
>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>> +     [CLKID_MCLK0_SEL_OUT]   = &mclk0_sel_out.hw,
>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>> +     [CLKID_MCLK0]           = &mclk0.hw,
>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>> +     [CLKID_MCLK1_SEL_OUT]   = &mclk1_sel_out.hw,
>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>> +     [CLKID_MCLK1]           = &mclk1.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>> +     &fixed_pll_dco,
>> +     &fixed_pll,
>> +     &fclk_div40,
>> +     &fclk_div2,
>> +     &fclk_div2p5,
>> +     &fclk_div3,
>> +     &fclk_div4,
>> +     &fclk_div5,
>> +     &fclk_div7,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll,
>> +     &mclk_pll_dco,
>> +     &mclk_pll,
>> +     &mclk_pll_clk,
>> +     &mclk0_sel,
>> +     &mclk0_sel_out,
>> +     &mclk0_div,
>> +     &mclk0,
>> +     &mclk1_sel,
>> +     &mclk1_sel_out,
>> +     &mclk1_div,
>> +     &mclk1,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +};
>> +
>> +static struct meson_clk_hw_data c3_pll_clks = {
>> +     .hws = c3_pll_hw_clks,
>> +     .num = ARRAY_SIZE(c3_pll_hw_clks),
>> +};
>> +
>> +static int aml_c3_pll_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int clkid, ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
>> +             c3_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!c3_pll_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &c3_pll_clks);
>> +}
>> +
>> +static const struct of_device_id c3_pll_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,c3-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
>> +
>> +static struct platform_driver c3_pll_driver = {
>> +     .probe          = aml_c3_pll_probe,
>> +     .driver         = {
>> +             .name   = "c3-pll-clkc",
>> +             .of_match_table = c3_pll_clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(c3_pll_driver);
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/c3-pll.h b/drivers/clk/meson/c3-pll.h
>> new file mode 100644
>> index 000000000000..92a08196a46f
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-pll.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#ifndef __AML_C3_PLL_H__
>> +#define __AML_C3_PLL_H__
>> +
>> +#define ANACTRL_FIXPLL_CTRL0                 0x0040
>> +#define ANACTRL_FIXPLL_CTRL4                 0x0050
>> +#define ANACTRL_GP0PLL_CTRL0                 0x0080
>> +#define ANACTRL_GP0PLL_CTRL1                 0x0084
>> +#define ANACTRL_GP0PLL_CTRL2                 0x0088
>> +#define ANACTRL_GP0PLL_CTRL3                 0x008c
>> +#define ANACTRL_GP0PLL_CTRL4                 0x0090
>> +#define ANACTRL_GP0PLL_CTRL5                 0x0094
>> +#define ANACTRL_GP0PLL_CTRL6                 0x0098
>> +#define ANACTRL_GP0PLL_STS                   0x009c
>> +#define ANACTRL_HIFIPLL_CTRL0                        0x0100
>> +#define ANACTRL_HIFIPLL_CTRL1                        0x0104
>> +#define ANACTRL_HIFIPLL_CTRL2                        0x0108
>> +#define ANACTRL_HIFIPLL_CTRL3                        0x010c
>> +#define ANACTRL_HIFIPLL_CTRL4                        0x0110
>> +#define ANACTRL_HIFIPLL_CTRL5                        0x0114
>> +#define ANACTRL_HIFIPLL_CTRL6                        0x0118
>> +#define ANACTRL_HIFIPLL_STS                  0x011c
>> +#define ANACTRL_MPLL_CTRL0                   0x0180
>> +#define ANACTRL_MPLL_CTRL1                   0x0184
>> +#define ANACTRL_MPLL_CTRL2                   0x0188
>> +#define ANACTRL_MPLL_CTRL3                   0x018c
>> +#define ANACTRL_MPLL_CTRL4                   0x0190
>> +#define ANACTRL_MPLL_STS                     0x01a4
>> +
>> +#endif  /* __AML_C3_PLL_H__ */
> 
