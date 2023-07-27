Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CC7646D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjG0GbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjG0Gaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:30:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4961FC4;
        Wed, 26 Jul 2023 23:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju0zPEA+59HVP4b2XJuK2GLnQbPu9pbNho956jAj7w6CedHD/AqOjvW/Ha0DEEJwKpOQ89EnzljavH9zaYl57iyivJx5zqukhdVWKOekVunE8ElBRimzv6UV6jpEC6mEU+5ImXSKo1WG6dqLw87i0aviv/ELRbC4gGpbZT/AmUKlNfmh9B8S81cD9joCoL0KfkcmbBwoAK6P4xl0N8UI5Y5GTV3Wb6B0QvjdaCPvpEfHZxx5iRRtL6bKUDwpsBWdUpdmx57URIRy+WtUU3Yzo5bd4RzpXfP5kxiQtp7ezwJcup/yaQAUiChb6Rq/lfUk4e6EyKW+a/mR4P1MLr6TOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhgGO72xxw675K9mF4Js+gTMhjg2SyYLiPI3r+BnlBk=;
 b=I+nWyxxsUb8LQBdnEekb/FVmyOHzb6g2HYLxYKCvtyl5vwnwQK/yyuyNpYdSMzxZcc6GyaC3+OlJb2y/48qEjETXOw56kSrkRiAcZUb2tyNoYE9KZwH8K3llor3nrKyMO7SDMKAKQCho1lzm3rpNNdVARq6hdcY0rhJMjfYwTSUWYGCvFOmoIlQiqB3duxf5gmqMahWWj6nx9Z7Iax4ThbHnJv4UXYlVuWQsvWztlueYN1HoPU0+LygGKDgZF2neSjMOQCSCVxXKLA4mCPesYTjPlQsjfSzrn9/MqDIQaxJtUBvefEaPRW0NMc94preH70RojLpwVXK0B5lHbVxAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhgGO72xxw675K9mF4Js+gTMhjg2SyYLiPI3r+BnlBk=;
 b=XxrOyafYAw5pIUUQJN+HK0uv5BpcALnuy34JIPAItEYkR9lDjWrRQtfQs5KOSYreigNc8c4Afo95dJYfJiM3xn+NvujhPshbFtvroWfyYUOzO0t2ntPt2+Aq1ZQrkfhrEqOv4Q7HOzmxRTxLGtXPxdLBI0HVnL9ZQfIb9Kz43c4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Thu, 27 Jul
 2023 06:30:48 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db%5]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 06:30:48 +0000
Message-ID: <0426204f-c6cd-68aa-438f-12c047485299@amd.com>
Date:   Thu, 27 Jul 2023 08:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: zynqmp: Describe interrupts by using macros
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        laurent.pinchart@ideasonboard.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <9d5bd17f37772be186cab17b06cc21351d36ff62.1688986332.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <9d5bd17f37772be186cab17b06cc21351d36ff62.1688986332.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa694e4-9bac-4fc5-0527-08db8e6b038f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDVtqiYaB6I30zfCj/t99xiQ5p4qGBz2eP+Ry0hBzdysUikg3ocyH1tkO5qbhk+nhviwVizj8exL7YkhPsQkiBDXg1M0Fz6OX5nksIKFJikaL/IfFWP/9qU0F4d3jaUett4fT6uX0v5VdIu0YzpTO/0qOeBsjiBLwG0OmE28o416uv/hPogGWanHvILR7tdTxXl9/8J7faiprt8jVRI4xUzkLiV4yHAExT89EXM8v9LU7au+iEMFKDBDzzKhEXKKbCRK1mHfH0X3qys5jMwBaaHUYdlZmNSQHKWvsdsrOyRPGtt6NU9U8wdP93n4AURpH0zrOmREjyhxjFURMcY2LacG7IRcLLnLmKg+qCSFn+37WM8DxRMF+qvABV9Qe94t+P5Al3BjOGZ9VtCdgFSjBviQ2KUrUb+bXLXBbU440GG1Km3w0cZsef9GOK0Oc3Y1YaEJIHmKhFnsIk7URRretNGF0vmZ/TOmcIfJKZOdi9QghxP4exuMPxKdLOZBerMCkJWZ0/iSFhi7+llNggKuS3vuasEoHrvHC8n14BlOHVD6opeHJhfidcgxovOoqIzWbAh8ArTUucbfYhgzHo8gsFZ2i6oOF+avcCAy+p3o/FfHmuKcGBB7vx1bx1Hsy7pWqmcGqg1gPFfsuAHpDa+biw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(31686004)(86362001)(31696002)(38100700002)(66556008)(478600001)(316002)(4326008)(8936002)(44832011)(54906003)(8676002)(5660300002)(6512007)(7416002)(6486002)(6666004)(2906002)(186003)(966005)(26005)(30864003)(6506007)(83380400001)(66946007)(36756003)(66476007)(41300700001)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRxSHBJZm92QnJGNGNGaENMZlk3bkxNczU2Z1cyZ2NEdU5yQVhPQWZsZlFH?=
 =?utf-8?B?cVlxZmVGQjh1R29IUWtrdTJLVlFpdkhPYk1WeXZHMUpQQUI0NW1pR3l4YVc3?=
 =?utf-8?B?cm5KdSsvU3ZSbmlVa2Jub3ZWZTNqVnlVUEFXMWpjZVFiYlMxQ2R1WGJVdmxL?=
 =?utf-8?B?cDZPR0F2ckMrVXgrd3Vyb0xZSERhcGxkZTVvbTNTRitBd3BHcUhzQjlpQlRk?=
 =?utf-8?B?S3JTaXhhL25EMkhWa3N2YUJYMk5DSW9LRFNrbHFpbG1qR0lRSnFqZVhnZ1VY?=
 =?utf-8?B?d1c2bkZ1MWw2NXZ0VEhLNFFGK3pjY21BL0p5MGlwTTBPWU9ueGVlb2N5bGdh?=
 =?utf-8?B?SUltRjR3cTNpY2R6QVpGOG1TajliWnNpYkQxbFBYanVyYTk1L1ZpTHZJMi9p?=
 =?utf-8?B?a1lWMXhhLzJ0NklmTDZRSGpRMUIwQXhwcEp0MGdTcjZJM2xJU2w3MnpVSGRs?=
 =?utf-8?B?T1MyQ0w3SUpqOUtIaitDcGQ2VlVTanBBdDVieGVjM0xXQ01lZ0FTTFkrOWFp?=
 =?utf-8?B?VGMzM09xSGI2Nll0V3BmUXY5aUprbmNmb1NySFZKaDJ4ZFVZUmpnUlpyMVhC?=
 =?utf-8?B?ZTN4blg3UTNFVWVRK0lZTE9oSUwvZG91Z2xTb1lXWVRGTUN3dnM3Nk82TE5Z?=
 =?utf-8?B?NDN6MzNwcXg2REFxZTJRV2srTzhyYlZtcDJiWXI3MFNiMGJmRmlQSFBXZEo0?=
 =?utf-8?B?MWUrZTkyejEwc2duRVU5Ni9zVVVoODdndXhkREhXUEhPYVVmTkE2R2V3a0xa?=
 =?utf-8?B?MmwyazhJOEV1ZjJJWWVNcWNnUUhpL1d6TjRhWi9yUHhERDJHS1huYWRYVWV3?=
 =?utf-8?B?cEpwek93YnFNTTkyMnZhRjY4cElkTVlZOHR5RjA4RkJYYXpUTWRnUTQ2Z0pG?=
 =?utf-8?B?anJWRnFQdWVYSkhveFIyNTl2VmN3eXRvMmdkcHpUY0JsckV1TG9BYnhRWndY?=
 =?utf-8?B?VHY0SnAvdUtIZHRmRUswSDZIN3hYSHljV1JhNEhNRUtGMStFV3ZjOTRaV0hV?=
 =?utf-8?B?TEp6bis1VFEvQU5KVWs3RUpxUFNSUkVHS2hJTXRsaUQzbTh3VVpaKzFaV0lQ?=
 =?utf-8?B?UzlSUE1PWDErQ1U1aUZURE00dTVJTldCZllNWVpVUVYzSVBKSmNpNnh5OS9p?=
 =?utf-8?B?Y0JFdThtWjRQOFNlZVZWUWRhcFREZ1luM29MWXprQVJ5Qkwwc2wwQ0xkYk03?=
 =?utf-8?B?b24yazRiK3VRV0dRbk05anVvcWZTY3JoZ3lnclBoTmVPZ1d4NDR1c0cyZFBO?=
 =?utf-8?B?UWtsZlJKYXk1d1hkS3ZJbnNaSTc5NDZ0bVdKSDJXaDJjZTF3TVRROUpaSGZ2?=
 =?utf-8?B?N0VscnlCV3I4dW1DODNwNElsZmtWaUUrS0E0TUQ4K3UwSU9MejErNGh3K2pp?=
 =?utf-8?B?OWJuWFQrc2NCZ1VXcnlUeW1LZS80OGdpZ1o4RmJZbFVneVRTdzRnd1lXenhi?=
 =?utf-8?B?TmttWmFFaVZmZmtrOWZOZHgza2llTTRUeFlxb2hFTHBRK25URXlPOWNUNW9n?=
 =?utf-8?B?dXJhNXpwemdheG9tUm5tTHhwY0tDMVJaZTk0QkRLczFpR21HRHYrVDFDelIy?=
 =?utf-8?B?clcwVFE4RkJQTVNDaWMvbDBqWGJ6RWp1eVRjRjRJZjh5bCtHSUx6NlBJblEv?=
 =?utf-8?B?L3drQjF1MjVqNTQyK0pudDVJd1BVaDJnOHQ1WWljZkhjQnRsSWJYbFNHeGl1?=
 =?utf-8?B?cGJQcWx3djNjMWxKU2xCMVlKOTlxZVc3bkJDTEk2UDQvWmN4WlQ5T0FZOEdP?=
 =?utf-8?B?QmlZeWxLajFzSTZaTG5PaG1jNHZpSW9lOXBXQ0JpUlczamNaS2RETm5YR1Y1?=
 =?utf-8?B?SkM2TWVDSmlla3VocnFUd2lNY0FwWFRyQ3dnS3VVTzBEdzlzcjNyck9wTXhL?=
 =?utf-8?B?L1YrUi8yWlZoSEdZR2tpTXZ3QmlaMmxWNmtUbWVmdGsxWjh2UG4wVUJma09G?=
 =?utf-8?B?NkMyZE0rYUFJdDlndTJXZjdpUDlmTS9Yd3hqVUJnRlJzTkx3blBSdC8xbTZs?=
 =?utf-8?B?S3dTYzVadDY5Z3AyNkZveDEzZ3N3bW8rdzRvMk9xZlBHeW1uaDY2UDNuaWJi?=
 =?utf-8?B?RFF5SlFJTkZ4VTFTZUJBMTJtVm1WNVFxWUU4OFJQOGsrRjN3dml4RmJwaEEy?=
 =?utf-8?Q?eSEKyoYUgpGq0yHHvfTDfvQUn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa694e4-9bac-4fc5-0527-08db8e6b038f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 06:30:48.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT7t6ICN0uYyD8hXH8mnV7S2LiQlE6NmUb5jhdktNaJ3n+zzngkv0tKZ5Vr1J82a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 12:52, Michal Simek wrote:
> Use arm-gic.h and irq.h for interrupt description. It helps to improve
> readability of device tree file.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Discussed at https://lore.kernel.org/r/20230621141307.GC18703@pendragon.ideasonboard.com
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 185 +++++++++++++++----------
>   1 file changed, 110 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74898f3a3537..b61fc99cd911 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -14,6 +14,8 @@
>   
>   #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/power/xlnx-zynqmp-power.h>
>   #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>   
> @@ -131,7 +133,7 @@ zynqmp_ipi: zynqmp_ipi {
>   		bootph-all;
>   		compatible = "xlnx,zynqmp-ipi-mailbox";
>   		interrupt-parent = <&gic>;
> -		interrupts = <0 35 4>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>   		xlnx,ipi-id = <0>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> @@ -161,10 +163,10 @@ dcc: dcc {
>   	pmu {
>   		compatible = "arm,armv8-pmuv3";
>   		interrupt-parent = <&gic>;
> -		interrupts = <0 143 4>,
> -			     <0 144 4>,
> -			     <0 145 4>,
> -			     <0 146 4>;
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-affinity = <&cpu0>,
>   				     <&cpu1>,
>   				     <&cpu2>,
> @@ -187,7 +189,7 @@ zynqmp_power: zynqmp-power {
>   				bootph-all;
>   				compatible = "xlnx,zynqmp-power";
>   				interrupt-parent = <&gic>;
> -				interrupts = <0 35 4>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>   				mboxes = <&ipi_mailbox_pmu1 0>, <&ipi_mailbox_pmu1 1>;
>   				mbox-names = "tx", "rx";
>   			};
> @@ -231,10 +233,10 @@ modepin_gpio: gpio {
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupt-parent = <&gic>;
> -		interrupts = <1 13 0xf08>,
> -			     <1 14 0xf08>,
> -			     <1 11 0xf08>,
> -			     <1 10 0xf08>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>   
>   	fpga_full: fpga-full {
> @@ -274,7 +276,7 @@ can0: can@ff060000 {
>   			status = "disabled";
>   			clock-names = "can_clk", "pclk";
>   			reg = <0x0 0xff060000 0x0 0x1000>;
> -			interrupts = <0 23 4>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
>   			tx-fifo-depth = <0x40>;
>   			rx-fifo-depth = <0x40>;
> @@ -286,7 +288,7 @@ can1: can@ff070000 {
>   			status = "disabled";
>   			clock-names = "can_clk", "pclk";
>   			reg = <0x0 0xff070000 0x0 0x1000>;
> -			interrupts = <0 24 4>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
>   			tx-fifo-depth = <0x40>;
>   			rx-fifo-depth = <0x40>;
> @@ -305,11 +307,11 @@ pmu@9000 {
>   				compatible = "arm,cci-400-pmu,r1";
>   				reg = <0x9000 0x5000>;
>   				interrupt-parent = <&gic>;
> -				interrupts = <0 123 4>,
> -					     <0 123 4>,
> -					     <0 123 4>,
> -					     <0 123 4>,
> -					     <0 123 4>;
> +				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>   			};
>   		};
>   
> @@ -319,7 +321,7 @@ fpd_dma_chan1: dma-controller@fd500000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd500000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 124 4>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -332,7 +334,7 @@ fpd_dma_chan2: dma-controller@fd510000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd510000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 125 4>;
> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -345,7 +347,7 @@ fpd_dma_chan3: dma-controller@fd520000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd520000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 126 4>;
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -358,7 +360,7 @@ fpd_dma_chan4: dma-controller@fd530000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd530000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 127 4>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -371,7 +373,7 @@ fpd_dma_chan5: dma-controller@fd540000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd540000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 128 4>;
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -384,7 +386,7 @@ fpd_dma_chan6: dma-controller@fd550000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd550000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 129 4>;
> +			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -397,7 +399,7 @@ fpd_dma_chan7: dma-controller@fd560000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd560000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 130 4>;
> +			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -410,7 +412,7 @@ fpd_dma_chan8: dma-controller@fd570000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xfd570000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 131 4>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> @@ -427,7 +429,7 @@ gic: interrupt-controller@f9010000 {
>   			      <0x0 0xf9060000 0x0 0x20000>;
>   			interrupt-controller;
>   			interrupt-parent = <&gic>;
> -			interrupts = <1 9 0xf04>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   		};
>   
>   		gpu: gpu@fd4b0000 {
> @@ -435,8 +437,12 @@ gpu: gpu@fd4b0000 {
>   			compatible = "xlnx,zynqmp-mali", "arm,mali-400";
>   			reg = <0x0 0xfd4b0000 0x0 0x10000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 132 4>, <0 132 4>, <0 132 4>,
> -				     <0 132 4>, <0 132 4>, <0 132 4>;
> +			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1", "ppmmu1";
>   			clock-names = "bus", "core";
>   			power-domains = <&zynqmp_firmware PD_GPU>;
> @@ -451,7 +457,7 @@ lpd_dma_chan1: dma-controller@ffa80000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffa80000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 77 4>;
> +			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -464,7 +470,7 @@ lpd_dma_chan2: dma-controller@ffa90000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffa90000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 78 4>;
> +			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -477,7 +483,7 @@ lpd_dma_chan3: dma-controller@ffaa0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffaa0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 79 4>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -490,7 +496,7 @@ lpd_dma_chan4: dma-controller@ffab0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffab0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 80 4>;
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -503,7 +509,7 @@ lpd_dma_chan5: dma-controller@ffac0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffac0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 81 4>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -516,7 +522,7 @@ lpd_dma_chan6: dma-controller@ffad0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffad0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 82 4>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -529,7 +535,7 @@ lpd_dma_chan7: dma-controller@ffae0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffae0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 83 4>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -542,7 +548,7 @@ lpd_dma_chan8: dma-controller@ffaf0000 {
>   			compatible = "xlnx,zynqmp-dma-1.0";
>   			reg = <0x0 0xffaf0000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 84 4>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> @@ -554,7 +560,7 @@ mc: memory-controller@fd070000 {
>   			compatible = "xlnx,zynqmp-ddrc-2.40a";
>   			reg = <0x0 0xfd070000 0x0 0x30000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 112 4>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		nand0: nand-controller@ff100000 {
> @@ -563,7 +569,7 @@ nand0: nand-controller@ff100000 {
>   			reg = <0x0 0xff100000 0x0 0x1000>;
>   			clock-names = "controller", "bus";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 14 4>;
> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			iommus = <&smmu 0x872>;
> @@ -574,7 +580,8 @@ gem0: ethernet@ff0b0000 {
>   			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 57 4>, <0 57 4>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0b0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
> @@ -589,7 +596,8 @@ gem1: ethernet@ff0c0000 {
>   			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 59 4>, <0 59 4>;
> +			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0c0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
> @@ -604,7 +612,8 @@ gem2: ethernet@ff0d0000 {
>   			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 61 4>, <0 61 4>;
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0d0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
> @@ -619,7 +628,8 @@ gem3: ethernet@ff0e0000 {
>   			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 63 4>, <0 63 4>;
> +			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0e0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
> @@ -636,7 +646,7 @@ gpio: gpio@ff0a0000 {
>   			#gpio-cells = <0x2>;
>   			gpio-controller;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 16 4>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
>   			reg = <0x0 0xff0a0000 0x0 0x1000>;
> @@ -647,7 +657,7 @@ i2c0: i2c@ff020000 {
>   			compatible = "cdns,i2c-r1p14";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 17 4>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-frequency = <400000>;
>   			reg = <0x0 0xff020000 0x0 0x1000>;
>   			#address-cells = <1>;
> @@ -659,7 +669,7 @@ i2c1: i2c@ff030000 {
>   			compatible = "cdns,i2c-r1p14";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 18 4>;
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-frequency = <400000>;
>   			reg = <0x0 0xff030000 0x0 0x1000>;
>   			#address-cells = <1>;
> @@ -676,11 +686,11 @@ pcie: pcie@fd0e0000 {
>   			msi-controller;
>   			device_type = "pci";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 118 4>,
> -				     <0 117 4>,
> -				     <0 116 4>,
> -				     <0 115 4>,	/* MSI_1 [63...32] */
> -				     <0 114 4>;	/* MSI_0 [31...0] */
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,	/* MSI_1 [63...32] */
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;	/* MSI_0 [31...0] */
>   			interrupt-names = "misc", "dummy", "intx",
>   					  "msi1", "msi0";
>   			msi-parent = <&pcie>;
> @@ -710,7 +720,7 @@ qspi: spi@ff0f0000 {
>   			compatible = "xlnx,zynqmp-qspi-1.0";
>   			status = "disabled";
>   			clock-names = "ref_clk", "pclk";
> -			interrupts = <0 15 4>;
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
>   			num-cs = <1>;
>   			reg = <0x0 0xff0f0000 0x0 0x1000>,
> @@ -735,7 +745,8 @@ rtc: rtc@ffa60000 {
>   			status = "disabled";
>   			reg = <0x0 0xffa60000 0x0 0x100>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 26 4>, <0 27 4>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "alarm", "sec";
>   			calibration = <0x7FFF>;
>   		};
> @@ -745,7 +756,7 @@ sata: ahci@fd0c0000 {
>   			status = "disabled";
>   			reg = <0x0 0xfd0c0000 0x0 0x2000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 133 4>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>   			power-domains = <&zynqmp_firmware PD_SATA>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
>   			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
> @@ -757,7 +768,7 @@ sdhci0: mmc@ff160000 {
>   			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 48 4>;
> +			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff160000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
>   			iommus = <&smmu 0x870>;
> @@ -772,7 +783,7 @@ sdhci1: mmc@ff170000 {
>   			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 49 4>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff170000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
>   			iommus = <&smmu 0x871>;
> @@ -789,18 +800,30 @@ smmu: iommu@fd800000 {
>   			status = "disabled";
>   			#global-interrupts = <1>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 155 4>,
> -				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
> -				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
> -				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
> -				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		spi0: spi@ff040000 {
>   			compatible = "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 19 4>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff040000 0x0 0x1000>;
>   			clock-names = "ref_clk", "pclk";
>   			#address-cells = <1>;
> @@ -812,7 +835,7 @@ spi1: spi@ff050000 {
>   			compatible = "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 20 4>;
> +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff050000 0x0 0x1000>;
>   			clock-names = "ref_clk", "pclk";
>   			#address-cells = <1>;
> @@ -824,7 +847,9 @@ ttc0: timer@ff110000 {
>   			compatible = "cdns,ttc";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff110000 0x0 0x1000>;
>   			timer-width = <32>;
>   			power-domains = <&zynqmp_firmware PD_TTC_0>;
> @@ -834,7 +859,9 @@ ttc1: timer@ff120000 {
>   			compatible = "cdns,ttc";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 39 4>, <0 40 4>, <0 41 4>;
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff120000 0x0 0x1000>;
>   			timer-width = <32>;
>   			power-domains = <&zynqmp_firmware PD_TTC_1>;
> @@ -844,7 +871,9 @@ ttc2: timer@ff130000 {
>   			compatible = "cdns,ttc";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 42 4>, <0 43 4>, <0 44 4>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff130000 0x0 0x1000>;
>   			timer-width = <32>;
>   			power-domains = <&zynqmp_firmware PD_TTC_2>;
> @@ -854,7 +883,9 @@ ttc3: timer@ff140000 {
>   			compatible = "cdns,ttc";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 45 4>, <0 46 4>, <0 47 4>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff140000 0x0 0x1000>;
>   			timer-width = <32>;
>   			power-domains = <&zynqmp_firmware PD_TTC_3>;
> @@ -865,7 +896,7 @@ uart0: serial@ff000000 {
>   			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 21 4>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff000000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_0>;
> @@ -876,7 +907,7 @@ uart1: serial@ff010000 {
>   			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 22 4>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff010000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_1>;
> @@ -901,7 +932,9 @@ dwc3_0: usb@fe200000 {
>   				reg = <0x0 0xfe200000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "host", "peripheral", "otg";
> -				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;
> +				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>   				clock-names = "bus_early", "ref";
>   				iommus = <&smmu 0x860>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
> @@ -928,7 +961,9 @@ dwc3_1: usb@fe300000 {
>   				reg = <0x0 0xfe300000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "host", "peripheral", "otg";
> -				interrupts = <0 70 4>, <0 70 4>, <0 74 4>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>   				clock-names = "bus_early", "ref";
>   				iommus = <&smmu 0x861>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
> @@ -941,7 +976,7 @@ watchdog0: watchdog@fd4d0000 {
>   			compatible = "cdns,wdt-r1p2";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 113 1>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
>   			reg = <0x0 0xfd4d0000 0x0 0x1000>;
>   			timeout-sec = <60>;
>   			reset-on-timeout;
> @@ -951,7 +986,7 @@ lpd_watchdog: watchdog@ff150000 {
>   			compatible = "cdns,wdt-r1p2";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 52 1>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
>   			reg = <0x0 0xff150000 0x0 0x1000>;
>   			timeout-sec = <10>;
>   		};
> @@ -960,7 +995,7 @@ xilinx_ams: ams@ffa50000 {
>   			compatible = "xlnx,zynqmp-ams";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 56 4>;
> +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xffa50000 0x0 0x800>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> @@ -986,7 +1021,7 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
>   			compatible = "xlnx,zynqmp-dpdma";
>   			status = "disabled";
>   			reg = <0x0 0xfd4c0000 0x0 0x1000>;
> -			interrupts = <0 122 4>;
> +			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
>   			clock-names = "axi_clk";
>   			power-domains = <&zynqmp_firmware PD_DP>;
> @@ -1002,7 +1037,7 @@ zynqmp_dpsub: display@fd4a0000 {
>   			      <0x0 0xfd4ab000 0x0 0x1000>,
>   			      <0x0 0xfd4ac000 0x0 0x1000>;
>   			reg-names = "dp", "blend", "av_buf", "aud";
> -			interrupts = <0 119 4>;
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
>   			clock-names = "dp_apb_clk", "dp_aud_clk",
>   				      "dp_vtc_pixel_clk_in";

Applied.
M
