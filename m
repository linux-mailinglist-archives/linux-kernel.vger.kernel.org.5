Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE576FA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjHDGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjHDGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:52:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BE4697;
        Thu,  3 Aug 2023 23:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbTbiokhRgZeoPLHLsopCaok3zGud+WsjgsPtB+FI4DIfqlWkfILiBpRBFYIvk0VwsW0wZfgqtFaCW2/5PWO2w6oiXZj82eK8+Jy2zkvVnb8j1LUhM6WV13j2uHB+021UmYR5ziAdxRElhW30YQXeMQrmWsN/JxuG2d62rHRit0dozEfO/Pc07cO+JgCwj+E3EqW6i4KV/E2g0F1sUFpDVOSS737VtdxIpNCDGxConmGSNNPjHVDCeHVPTXej6uJhmt1hQZP19VE7KUVhneK49hYg+UDpyu9EHRPBzEAXUwhquCXXzsCILBmlBXXWWn1rOhPZwu4aSdWcCaWN8BRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqbXpil4fNASqtH8rPpuL6Hr7+sS+zS1wJgsDe/6MvQ=;
 b=Le51XZ0ygCfJYaP0DZJ6RgCEc9x3vL9HFwlmYHS6Zx5lO0qZirn94O7V2dp2739SqnaByYVGKWN0hBXuWBMvfA9IVkQx5L1IZJTvBOui6o2bPA5PsYAJmGXu6lXgUu2zaSv2Cbq7e2ehOoa/tcUSUX48zN1UVVWMLPIUv9b9oZVJdZQjrW6pCGNqNXJ3IUT3gUd3+LRn65FUcoYfomqQwM/0rtDTwup8GBWb8YUYuRKDhDNrAt8wzTTh6h0T4NBU+2S9oexYngGJmkrEZtHfOJvyeYtU2G4UKkcFA3nCTLK/1LuWqfDuMyMtCmPqTRNIZ4O3R3h2P8AAkKqgTHP9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbXpil4fNASqtH8rPpuL6Hr7+sS+zS1wJgsDe/6MvQ=;
 b=PykSd8Kp1Z8H/yaYPpGciazZgbjKCzUe/bjymm0GGSZM6BPOBuV9bQe04SGpsO5i3PXooORVf5D/KsZrLeb4EMGbjVV7dIvCo8w6+uKBg84998yBL7Qd3X7BiIHnjurLZjID8qSOG9sb2QO2+NaMIT778zll0glKcKwGv9vCp14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 06:51:39 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::dc36:145a:99ff:f834]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::dc36:145a:99ff:f834%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 06:51:39 +0000
Message-ID: <2cd4f9e5-87b6-64f9-2d50-f146cae6c83a@amd.com>
Date:   Fri, 4 Aug 2023 08:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 22/23] soc: xilinx: Explicitly include correct DT
 includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Has him <shiraz.linux.kernel@gmail.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jay Fang <f.fangjian@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-pm@vger.kernel.org
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-22-d8de2cc88bff@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-22-d8de2cc88bff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d83a05-8869-4433-607b-08db94b74076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFBcV3KQx9Y5TA2iC6dRnwcsBAacMaWNl9XYhHc1uFTIbwMr6iLpGUOm89H1yJsx1REzBN7hwp4pQOhdFm1B/6MhgyKu94gX2+yvI5rocbCtLcD6LobWa0wuMEuuRSPgEptE9+pd+ZlAgHL/nnh+p2ffYfB+QxP5ccKkWkdpsUGtvPpac05ySQa0OxkvU2jTwMX2QeYgaG0p+GutAr4oHjGJF8vfWmDHCA7TguISi9G8+5InpQEg6k5K5wQtTzCuxy7BE4xF44ThRWiAEONv5dps8YRfLX/opsZRpr8pOLya4OvdiVlApVD9p7RalZ/BzOirFoyVYwGZlhxC5rw2n2briyaDc1r1oGZrIFX4y89/B7MNPwU7iT7NpbE5xL8zx5fIAvk+AiUuyNpDROHAaNNqHr4GzEpmb3vobiZl85KIjj78d2A5tbftkbmu7r8dPA3uY/Q+8Wtu9tL+V9mjWBZLV2sAOaJFRnlTbCj6+sDOKR40nNbrcaJHs+I94zPgdfHvSFXhrJ8NNfjohOMJqaxLEllNf5t4chhOTlgDUVGdrax1nGIvVpBfH8riiZr6fqmfP1kVnOb/UsApFhAYnfpxA4qOg6JXn6GwENv5wrtk6i9BBnR4nrNikI9q+UZ2O/bYN2pEc6dYXl6rCAWu1bODcPmv/DGAsb67tRNzHtPkLtkbyUCLT6eRLjbTMmBLPlJaNZGiIYAcZwqrMUKNQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(2616005)(53546011)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(4326008)(66946007)(5660300002)(66556008)(44832011)(8936002)(7416002)(41300700001)(6666004)(7406005)(6486002)(6512007)(110136005)(478600001)(921005)(38100700002)(31696002)(36756003)(86362001)(7366002)(31686004)(45980500001)(43740500002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RSt6OFZ4c0twL2FyV2xseHZDQWphdWVkb0JDV3hXdlVTVnFMVFNUWW1EaWtL?=
 =?utf-8?B?M3FWYmpYQ3dlU2c5eFEzSnAxRW5pRGxybUJtaHR6ekdLK1FwVldERWpvY0FG?=
 =?utf-8?B?RWlsc2t4OENSOGdoeDc0blBDUnJPZXRhb0QxcksvK2ZkSkpSUXVCNkYyUkpP?=
 =?utf-8?B?QkZUaERFZUhpaXdWbkl6YmtSTXRYUG1FK1A5LytjTGpQLzJaSGZuYnA0MEZt?=
 =?utf-8?B?T2s1R0pwZFN1M0pwR3orVFFrZ3NPbGd3OER4VnBOa0pPdHpZQUpGMm94STB3?=
 =?utf-8?B?Y0lNbHZtL3FHd1JhVStjZEMxVURLRGttaHZ1TEVLclVHaUZScVNsOXF3TUVL?=
 =?utf-8?B?Q1NwcFI5ZDdHbFRQTXZhNkVrUkdSOVViZzdvSXlYUXN1VHpMSytNRFBUUStj?=
 =?utf-8?B?alM5RE5IN1MrTmRWcWgzUkVLSnF4QnIwbUNUVDNQTkRKYjd1cmtDZkdERGJJ?=
 =?utf-8?B?b0lrUlhKdFhDUXMxWDlLZmkwM1IxQXhzWXRFK0sveGVkbXI2V09za1NPb3l3?=
 =?utf-8?B?Q3VnRWp5UjFQeTVxRjFobm1IQm9JV2ZYUHN5RzExQzJZS0J5SHU4VHZYOEtO?=
 =?utf-8?B?bEljZ0VadUV4VHBxamJnWWc4TllHMlFxbzRrdkVLRnIraTEvZW1SdWErbmF5?=
 =?utf-8?B?bDdIOC82TG9NTURiOGs3K0QvcVFRd3dvc0xGamFWSmh6MEhFR1lpdDFINmZX?=
 =?utf-8?B?SCtsakdhclFyUWRsOVltaC92N3kraWtNYVVHK2VjVjYyUTlLTXJSRDhwMUdE?=
 =?utf-8?B?VUlxYkZLajV1S3NpMkJsUWRxZ0ZGWWxMS0pyRjFud3dCSHhBL0pNTE9HRnZm?=
 =?utf-8?B?VEZRamVzejdtbDhjWE9WSkJSYUdKdys4ZnV4cFNFQjFCczl2aFlSV25NbGFJ?=
 =?utf-8?B?Yk43aUZTMkJrTSs0VzNHemVmeG1qRWFjQS9VN0VnYjFNbTZEMFhzK1hYWXZI?=
 =?utf-8?B?ems2R3M5TTNKSVBVM0grMzdvQ1I5NFRxMWNnV01oMllmSzdZdUNHNFlnaG9F?=
 =?utf-8?B?TU5WNTFQZnBZV3FCbld6SWJXazFjQWtpZFVNdTh6YkFDeEZlYmx0dkt3M0Vs?=
 =?utf-8?B?L21OSTl1b1MrYjBVRElqT0ZVS3lIcjBKNEUwaUl6YjJtMk5jL2pUZ3hiUFBK?=
 =?utf-8?B?ZUhoZG82ZWJnbTYydk9kN0NyK01wcmllUWIvRjVFYXJLOFg2RzdpaVVzaVow?=
 =?utf-8?B?a2JZRkpNN2MzWEpGaGdVU0F1V29YR2h0NDF4OWpxMkhTcnRiekFWSWpEcUUz?=
 =?utf-8?B?MXRYV2pnQzl5Tjc3MFA1NmxOVk56R3crRmFuT3R2OVRwZWdmc1FpdTVpcTBz?=
 =?utf-8?B?VWI3b0FlUjZzL2p3cDhkdkhYNGh4NzY4aTNQNFZWSGx5N21BV1BSY3BsSVQ5?=
 =?utf-8?B?NkZLa3FyMllmUmc1SzZ5MnA2QW1qWnZNelJjdzlsM1RGRFBoRlN1d01SN0Vz?=
 =?utf-8?B?RitTQ0NBVURsYmx2b3FFSTNxNEplczAydlNUdlhQTVg0WUUyemxQZ3ZSV1Uz?=
 =?utf-8?B?b2hESThUNm1vRnVPUXJSdXVOWGdJZmxUSTZVUFVqSElXY3BBeGJxbXpyUDBR?=
 =?utf-8?B?QnA1ekpTSThNMUZESXg0bmFodUVOUUttb3VWNVdaNXBoc0EzT1Vyc1g2ZWdi?=
 =?utf-8?B?M25vQ1ZBM2h1clhHM0RVNk56RXhIM01VSkRDQmcvcHFIZ1N3TUNNTzJVVzlS?=
 =?utf-8?B?ajI1aWh2YXNBS2N5cktxd2RYTFF6WSswSEVHc2NOZ1k1K0tRMEVmcyt6alJM?=
 =?utf-8?B?ZUxLeDQyQmYwNFl2QmxETjJsaWEyU0tVaVd0cDlVN25tSFQzWWhuTGZPSklh?=
 =?utf-8?B?VWpKOHhxZHAydkRGNHkxYWtlZmppWWNDTU01UzN4bk5yMWdyTFpadTB5b0ds?=
 =?utf-8?B?M3k5MHl4WktqZEEyekNZMnAraENDUXE4aWJvb1lEN3ZPZTdIYTFlQUFLQVRN?=
 =?utf-8?B?c2JGdi9FMHhKVzR0L0dVY1RJTWFxck5hWk9YbzhNa0FQa096ekdLeGVEc2ZV?=
 =?utf-8?B?NnkrVXR0RnBEbDJHYWtDNkM2bW92dkt3MmtTNWc1ZVM2WWJ2RUtpc0loWDNY?=
 =?utf-8?B?anJpRmI0V3pPSUtKTVQraVVtaWRLM2ZXcGRjNE8vd3JScEdScjdnTWRSNjZz?=
 =?utf-8?Q?GZxaHMJiyASqbAEJ6e8P4mlVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d83a05-8869-4433-607b-08db94b74076
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:51:38.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hlnFLevFMxgluYWUBm0/QRsRTrD9MYRvQUCjOpyWf0vTFSgC5PjKgZaQfCsyGr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/4/23 00:43, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/soc/xilinx/zynqmp_power.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 641dcc958911..913417506468 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/mailbox_client.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
>   #include <linux/suspend.h>
> 

I was checking and I was on CC on the v1 but I didn't get this to my inbox.
Anyway let me apply this to my queue.

Arnd: If you want to take it directly I am fine with it too.

Thanks,
Michal
