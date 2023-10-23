Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932D37D380A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjJWN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJWN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:28:47 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B37F9;
        Mon, 23 Oct 2023 06:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4Su9Cnt9Md72Na+ujtHT1nSXIT7DREYicK3+Z5g5uwa/cMzjyoEL1rD0wgcmu2eL0n7eI4YlaiIygDKb5fhWDadFgxB3tGvKRAMvvb97C7GCYssM+GCy/KF5+40E8aHgb7LoprIa2XzH7aI0y6EZdmqpsc+SxgaryHp/Dw3hd0MHNYZy9Plnngd8NgHCeIkTZ6ym1EIE4JhnlOFY36mBeArfS5LXJh947FpaLcAQGvY17kvjLrh84sOFS5jOTeFcRt/vTIPI6hLOjyFnE0ru+td1xYULO9ETLOrSZUNJaS8l9Im81p5WjIBKqADzxz37OqTAMTHzuoHiS5HjQ+uFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJaCxwwh+roQjYl602o8k+9pslodONkqCleR2OziZ5o=;
 b=mqs5o3c/BTkrCven7ZZBEeG0jeF6/L023bhbn+MBR+xmb2EqGa77d/Wu44OLTrhUIEYbaaOx6vu7xrBH4mqw7J/+nc+bjir2/oWEl7/Xbuw4+v4MYemNp3PHL/0ME148O4OKJqmKJN9V4DPNTXtoueZ8tIalhgBD3gf3Wg7/2jZW2GNglFZpVkn/wQNZ8TvWvcbf2XN1qjOe1I5BYZ4fFB1OAGA0z1PyYaeD3ZuBztAb+ESFM+fPECRqXwNkVoq4kYCF/K1CJddRGutFoouVkjJekC3rWMzCrPnBEPtfr4vPPV7u8vosIyJiT8hyD5L3ratlzRdCuU9myFbDAyIeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJaCxwwh+roQjYl602o8k+9pslodONkqCleR2OziZ5o=;
 b=KmrzeQpKNV4I5YGQn/CcvCO6BhRUVBsN+ebTYoB7AIqcOL1mY+VzSnrj4/HOPQMfaqRMB1GQJNpsw5mHZxHiujEAPF+p/QgDcN8vX1ad8FpRCSIbCmDCm8PF6rptFJo2wd0yqq/hPUh8kvuDidtDu3IQWoW8NCQIMUEOK4xEl+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB5PR08MB10163.eurprd08.prod.outlook.com (2603:10a6:10:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 13:28:42 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::1d06:cca0:f1ef:ff62]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::1d06:cca0:f1ef:ff62%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 13:28:41 +0000
Message-ID: <ee4034b9-85f6-42cc-abca-d61004aa0a6c@wolfvision.net>
Date:   Mon, 23 Oct 2023 15:28:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's camera
 interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB5PR08MB10163:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf5b571-d505-4a02-9ee7-08dbd3cbf954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBN393mllWijMsMHnS+x75IsG0j4EkDMCtpPEHtDXw3A5bcdG672XMOzU3lynnuQ2Ego+JikvszbC2Kg4eLCWN0aJOV1bNEtcten7EEzHN3DujGteDCykALufAmriqYHl2z1zs9uVPz3HDex01RMCw/enUVhMGid9+elGRVI8AizIVX/axPrkCRensRsyE1PtzT9X6m3HdAtiyQRrsp9WmWTPbGcERdba8dXdWg07ZD9unbMmZl6ZuHEJ5TJpDMTMXVxStJGnIppAMLhjq0Bn7DlGCoV81FSMmzfErDZj6dNnbJsJBa1kV/Q9e6yVFTANqX7zps4noI0K9C6wBcRN+rutTgpfJdYfduEz2la4cXaKvPE04q0UF2gngdUf7CQg19jWijR4EWq+3c+vcJVxCwcs3ApoD0CmPGkWq+TQ5F6hlWlBsC7Dj7Z5wtg9K/bZnPl/1qNO6JbdTvyUJaTMyk4Tcydl1BL8rJmSAuWxmmGboSrtT8wkvgp5IT37anMcjsXyhkPqItBYFZhrhkiraIc3LV7nqvBQzqax/TiKqaVcdXYVIbcd85+fB/kNTcD68eJYDadRoMd1uPWxs0hsFFGOT+zpldjSO08ZO3HUqHySRK7Hm3kE8OuNEXlvl4OluhlmEfWiKHIDV3omTiaMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39830400003)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(53546011)(44832011)(66946007)(66556008)(66476007)(316002)(478600001)(5660300002)(8676002)(6486002)(8936002)(4326008)(31686004)(6512007)(6506007)(41300700001)(7416002)(2906002)(38100700002)(83380400001)(2616005)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNZTzFjcUpucmZPTXpBcWxCQnd5c251dDFjcE1jK3pxZXUvNzFVazJEcjVk?=
 =?utf-8?B?UTFrd2crTWlKY3h2cGI3NE5aTEVkL2dyR3VFY1NYNURGWCtMQVNJUEt3Uk04?=
 =?utf-8?B?Nm1qcmxMZEVtSDBiVlhBNlM4MGxBVXNLMTFpOCtMZHFoeHU1MlUzZGx2b01J?=
 =?utf-8?B?YVJYaVJhYUd1ODNvbUY4NDFXdG4zeWZMVnk4c08zVm9lN3VYMXNRS1FtWndF?=
 =?utf-8?B?MHNGQnNRSUw1N1pCMk51ZGhncGd2TGo3UnRyNGxBYW5TM0RxRVVWeENrVFpj?=
 =?utf-8?B?U1A1R2tnSmVKNEpraDFJQ2NSYnkvRWlCK2hUaVRmTVRkMzBjOTFINHVLRW1N?=
 =?utf-8?B?eTFwS0tLR09tdi9kMGpHclZjODZSUFNkYUdPT0pYNExiM2NtR2tnSDFiMklP?=
 =?utf-8?B?dzRSL1RkY3BzZ1UyT2tlVEVudWhHVEt4c0NyQU9ZQmN5aWVDMlVYd3h0TktG?=
 =?utf-8?B?ekgxSGRIbWJKK2NyYkZoTnpFTGxRVnR4WlZvRGZMWmtoQjI5cHk2aWFtbkZm?=
 =?utf-8?B?VmZiZTZIK1NwSm8wOFJObnNDc3RiQWtyZHcrSDBWY2YxbjF6eG1yTWFuSGUr?=
 =?utf-8?B?STdleU1YcmNFODltUTliVzJ1UjZNSVJQQXNZSWk5dk9QTVZEaGMvYllRNnJ3?=
 =?utf-8?B?Vnp6U2todno1TXM3eHBCQTZiRTNkTTIvbHkxeVh3VGYyZ2dEWHlqaG1rNVZE?=
 =?utf-8?B?ZGJWdHVKVE9QRG9uZ1p3Snhxa3A0K0lsdGE3VFJZYWFJZVV1VHJGMS8yc0k5?=
 =?utf-8?B?ZXBscUxxUzRUWnpRaEcvWTRvNjRGd0lzQ2JjVjVsR3lUZVZXajVkVHNFUnNs?=
 =?utf-8?B?d0I0ZTA2YVNmU1UxNzduc3V1cFBKb2ltR1ZYQ1d3VkJ2ZWpHZE9OUVhSekVJ?=
 =?utf-8?B?SzdzNzQ1elkxcCs4cWo5MVdoM0txMHpIaE5ZbjQwcmZPUEFBQ0crS3ZpWGhJ?=
 =?utf-8?B?SUNaZXliTmRvd0ZXcnBiemdaMzNjaHJIVU1lRUhsWjNiTWFnSDNYMEd6eGpa?=
 =?utf-8?B?UWxXSWh4KzFjRzBhYVB1UmdkQkM4YTRYajBoS3V0dkJFUUFmSWJLNEFkWDFI?=
 =?utf-8?B?cVd4WFNiSVRRcGw1WG85djZPKytNSVNYQUwwaTZvUWhTamhiczBPWTZmOW9w?=
 =?utf-8?B?MjFtZUZRSnFlUlFyMGZreTBhNWt3ZHBkU2p2S1FYaVlIYlZJb2lyNWtUR3Jq?=
 =?utf-8?B?OXZyRmVyZDl5djd1UmFWTGhNWkU4SDJld2tySnRZVWNCSm1hN3RSK29PcTRE?=
 =?utf-8?B?Z29FZHRsY3RLZG1SOVpEendvdlBvZDY1cTRTTjJDN1gyam1EcnVJY2hic05E?=
 =?utf-8?B?UkNDZnJYc1pYL2dDM3htRGNvVU4yQk56dTNDdmU4S1lSYThDTlJBQy9BN3pp?=
 =?utf-8?B?TUdiVTNmREVOaEdvRWFJM0VUZFlnUStrMzF6VzFKVTdvb2Nsc2o2azlwMTA1?=
 =?utf-8?B?MEtCOEpXNHFISXcxdFF6WmNHcitESGlmbW1Ua0M0K3kyZW80ZGVrVjR1dnZk?=
 =?utf-8?B?ZWU5QldQZE1FRnkvM0s5VUlMUStvY0JsUThaZVJBd3JXUy81TW92czFpZ0VF?=
 =?utf-8?B?OEJZSmJrRk5vaC9jbFRjcXNqdTcrdkwyQzlQWWVRcGlRTGtRcGZ2UnFiWEx4?=
 =?utf-8?B?cVArYUJBS3B5MGU0blk3WTJUdXBXR3RLaS9hYjNPVWtlc2dTUXFpcERnbk16?=
 =?utf-8?B?SXBXOG9jV3VBVXZNZEx3bVhWdmxMTEZWMnlNZkJKTldRdDdiZDBibisrcDhi?=
 =?utf-8?B?UVYyNVF4a1BXL0xXK21QTHh1dHg5cXRFZy9KNDJsVmRDT2x5anZuVHYzUHdP?=
 =?utf-8?B?Y25aYm82TDByT1Y0TytnNlcwVWl5eng4Nno1djdDVE5NNzBHTitxUGZvRFVU?=
 =?utf-8?B?QXNwTWVFQXM3V3VjQlQ3ZXM3b2VScG80bHBGR1V5Umc5OTRxTkxFdzFjWDJY?=
 =?utf-8?B?MGwrR0dBcUlBNUR5dnJCbmkzZjB5Szk1TGZWa1N0cktGcXhGbk9Gbkl0SXd1?=
 =?utf-8?B?V0VQZ3kxVUdwZjN2L1NBOTZEQWZpK3B0RmNvK1RjQ1pmYWUwY1dOT1l0Zlpx?=
 =?utf-8?B?TlFUTlJZRzc3VStUWk42UERDcVZhRk9YSUJDeE9xYWZCYXJDaFprNDVNWDgy?=
 =?utf-8?B?OEE3cXh3ZFBiRWRieFA1TG00Z3pDRGsyUE5hYStBS1JRM3czRnNvSm14OWxK?=
 =?utf-8?B?SFVnT29TUG5DdW4wTUVRckxzUm1wN24vdm56NjBkZ1F0cVFscUhuSDFSdDR0?=
 =?utf-8?B?SklkMS9nWjh3TjhmZjh3MlN3NG9nPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf5b571-d505-4a02-9ee7-08dbd3cbf954
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:28:41.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1s3PcuzCP05MpPXmSiyiIIWQ5WhiJyDOTKO/Dn4CKgr/G/LlPvU0DQOdTwX2oVkW1shlKD0h6+SGqjE7qygEmgw7Fg955KPfO4hm6otAYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Typo in the subject: "Rockhip's" -> "Rockchip's"
I think this typo has been in there for a while now ;-)

On 10/16/23 11:00, Mehdi Djait wrote:
> Introduce a driver for the camera interface on some Rockchip platforms.
> 
> This controller supports CSI2 and BT656 interfaces, but for
> now only the BT656 interface could be tested, hence it's the only one
> that's supported in the first version of this driver.

"CSI2" -> "MIPI CSI-2" ?
"BT656" -> "BT.656" ?
Also, additional interfaces are supported by some units, e.g., the
RK3568 VICAP also supports BT.1120.

But most likely it becomes too complex to list everything, and it would
be better if you simply described the unit in the PX30. I think this
would clarify the commit message a lot.

> This controller can be fond on PX30, RK1808, RK3128 and RK3288,
> but for now it's only been tested on PX30.
> 
> Most of this driver was written following the BSP driver from rockchip,

"rockchip" -> "Rockchip"

> removing the parts that either didn't fit correctly the guidelines, or
> that couldn't be tested.
> 
> In the BSP, this driver is known as the "cif" driver, but this was
> renamed to "vip" to better fit the controller denomination in the
> datasheet.
> 
> This basic version doesn't support cropping nor scaling, and is only
> designed with one SDTV video decoder being attached to it a any time.
> 
> This version uses the "pingpong" mode of the controller, which is a
> double-buffering mechanism.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Two things below:

>[...]
> diff --git a/drivers/media/platform/rockchip/vip/dev.h b/drivers/media/platform/rockchip/vip/dev.h
> new file mode 100644
> index 000000000000..eb9cd8f20ffc
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/dev.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip VIP Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _RK_VIP_DEV_H
> +#define _RK_VIP_DEV_H
> +
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define VIP_DRIVER_NAME		"rk_vip"
> +#define VIP_VIDEODEVICE_NAME	"stream_vip"
> +
> +#define RK_VIP_MAX_BUS_CLK	8
> +#define RK_VIP_MAX_SENSOR	2
> +#define RK_VIP_MAX_RESET	5
> +#define RK_VIP_MAX_CSI_CHANNEL	4
> +
> +#define RK_VIP_DEFAULT_WIDTH	640
> +#define RK_VIP_DEFAULT_HEIGHT	480
> +
> +#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
> +#define read_vip_reg(base, addr) readl((addr) + (base))

Please provide those helpers as proper inline functions. As to the
naming, the "_reg" suffix seems unnecessary.

Alternatively, you could consider converting the driver to use regmap.

> +
> +enum rk_vip_state {
> +	RK_VIP_STATE_DISABLED,
> +	RK_VIP_STATE_READY,
> +	RK_VIP_STATE_STREAMING
> +};
> +
> +enum rk_vip_chip_id {
> +	CHIP_PX30_VIP,
> +	CHIP_RK1808_VIP,
> +	CHIP_RK3128_VIP,
> +	CHIP_RK3288_VIP
> +};
> +
> +enum host_type_t {
> +	RK_CSI_RXHOST,
> +	RK_DSI_RXHOST
> +};
> +
> +struct rk_vip_buffer {
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head queue;
> +	union {
> +		u32 buff_addr[VIDEO_MAX_PLANES];
> +		void *vaddr[VIDEO_MAX_PLANES];
> +	};
> +};
> +
> +struct rk_vip_scratch_buffer {
> +	void *vaddr;
> +	dma_addr_t dma_addr;
> +	u32 size;
> +};
> +
> +static inline struct rk_vip_buffer *to_rk_vip_buffer(struct vb2_v4l2_buffer *vb)
> +{
> +	return container_of(vb, struct rk_vip_buffer, vb);
> +}
> +
> +struct rk_vip_sensor_info {
> +	struct v4l2_subdev *sd;
> +	int pad;
> +	struct v4l2_mbus_config mbus;
> +	int lanes;
> +	v4l2_std_id std;
> +};
> +
> +struct vip_output_fmt {
> +	u32 fourcc;
> +	u32 mbus;
> +	u32 fmt_val;
> +	u8 cplanes;
> +};
> +
> +enum vip_fmt_type {
> +	VIP_FMT_TYPE_YUV = 0,
> +	VIP_FMT_TYPE_RAW,
> +};
> +
> +struct vip_input_fmt {
> +	u32 mbus_code;
> +	u32 dvp_fmt_val;
> +	u32 csi_fmt_val;
> +	enum vip_fmt_type fmt_type;
> +	enum v4l2_field field;
> +};
> +
> +struct rk_vip_stream {
> +	struct rk_vip_device		*vipdev;
> +	enum rk_vip_state		state;
> +	bool				stopping;
> +	wait_queue_head_t		wq_stopped;
> +	int				frame_idx;
> +	int				frame_phase;
> +
> +	/* lock between irq and buf_queue */
> +	spinlock_t			vbq_lock;
> +	struct vb2_queue		buf_queue;
> +	struct list_head		buf_head;
> +	struct rk_vip_scratch_buffer	scratch_buf;
> +	struct rk_vip_buffer		*buffs[2];
> +
> +	/* vfd lock */
> +	struct mutex			vlock;
> +	struct video_device		vdev;
> +	struct media_pad		pad;
> +
> +	struct vip_output_fmt		*vip_fmt_out;
> +	const struct vip_input_fmt	*vip_fmt_in;
> +	struct v4l2_pix_format_mplane	pixm;
> +};
> +
> +static inline struct rk_vip_stream *to_rk_vip_stream(struct video_device *vdev)
> +{
> +	return container_of(vdev, struct rk_vip_stream, vdev);
> +}
> +
> +struct rk_vip_device {
> +	struct list_head		list;
> +	struct device			*dev;
> +	int				irq;
> +	void __iomem			*base_addr;
> +	void __iomem			*csi_base;
> +	struct clk_bulk_data		clks[RK_VIP_MAX_BUS_CLK];
> +	int				num_clk;
> +	struct vb2_alloc_ctx		*alloc_ctx;
> +	bool				iommu_en;
> +	struct iommu_domain		*domain;
> +	struct reset_control		*vip_rst;
> +
> +	struct v4l2_device		v4l2_dev;
> +	struct media_device		media_dev;
> +	struct v4l2_ctrl_handler	ctrl_handler;
> +	struct v4l2_async_notifier	notifier;
> +	struct v4l2_async_connection	asd;
> +	struct rk_vip_sensor_info	sensor;

Using "sensor" as name does not seem correct. As pointed out above it
could be a video decoder just as well. Something with "subdevice" maybe?

Thanks and best regards,
Michael

> [...]
