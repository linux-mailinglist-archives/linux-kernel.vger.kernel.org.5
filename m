Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9386D7FF3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbjK3PqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjK3Pp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:45:59 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2099.outbound.protection.outlook.com [40.107.8.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75700D4A;
        Thu, 30 Nov 2023 07:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2Cc8GshqSEEgBxBYKeMYcbxC0OsIK2g0XIqvoqAVA2mnL7vsuILZYrkuwi3IXjt2GpXqwv3Qai8cZZYLt0JtfXhxqR0OnDGb8BpN85EW60OSKlHG4nITB8jCBjcn0hV9Ov5ZyQ3treSz7xKyq0Ygm2AGM0jEQIvc/qUiVekr0D1oxm4tbEHDjhKaQ0iymZoIbaF3qFqIjLS1n1zSWhKvB90rZu6CxlxCr9vUjtdgQGJzpZRF3GjSo5D6j7BC4nqBm73kYZiCvnFSqa/xzPtYe6czlLtQbidx4S6sahNn0fvnjPSiW9vnVlcb0W6//VkLID1JSmKWfApvuB5e/Vtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bejoF+odiz5kaCavdANsMLxA2wn4/sTlyvDEWFpAt1E=;
 b=Egyw+S5ItdiBzEA4cTe6uWEv7Vi980aOVQAveHvwM5ZLyP6XZVxjzbstuQCLGbPqY7jVdSG62/bYkWKmCGpyr1b84yldnBFtr/URIYCWho0jqmrr0Ae3ua6EGKUv0+ywe491XWQV8SBVWdUEcW2sss2VrOWcqFTpoejKJPKOvORUr9PEhSR/E4/eA/DZZ6xIy0vwwiaHucuGyVwB5fuVIDNnLRTnIKVOKF0aMMB7NMmNjKIDjzuWy7Hf+LbWF8bodnmsn2CwMpo5v6PktO5MgbncLrQ2zP0/7Ra/xPIQckoVTmntgKeQyeHKLzvlkIUHZKVX6GRp/O1auhJrvjNiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bejoF+odiz5kaCavdANsMLxA2wn4/sTlyvDEWFpAt1E=;
 b=Q7fC0okX84cXnH7wI2YdBmQePo8dyOVk8iMDYpiYjzvKqWXM7JMhkmw6VFoDu269ZlFS5cT6eNd/vhVZ5fZV4elbXgbdlpiqvKPoyjJgsSZYYVybbR6JPvpWa9v5xSRHujVvqJqy0dMMZrSXUCEyCiJ8A+G8wuE7u8oi0vifoXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 15:46:02 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 15:46:02 +0000
Message-ID: <30a76402-894a-4fe3-82ae-491b0890aa8c@kontron.de>
Date:   Thu, 30 Nov 2023 16:46:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Remove video_pll1 clock rate from
 clk node
Content-Language: en-US, de-DE
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembeded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128045415.210682-1-aford173@gmail.com>
 <20231128045415.210682-2-aford173@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231128045415.210682-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM9PR10MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: fc47ad48-5898-4155-a06f-08dbf1bb74f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VnFwuZUohs+wko7g4+Nk9Dk0I3bsdPR1zt9uurFr/Vn482ik9rL1qsY8u3Sz15t98i5aepJHnqtbcON3eD8diAX0mM6tiMqM9I6e3CdZ9BwRMvusCc7kvuFcfJOxDt69FTDhZRX1QgvW/y39KjwX4GPUtWTVgfUVfGMz8pDML4aOhndARuX2YMsehtXRa2aW5rozMkEM7ysYbXEUIi5IgiP7UeGzqThvGIvBhw6TxF+5BQS92OlopnO8C3UbGttlPFG2w7xyjAVWflICxvDBLQnvSoXVthOUqDAP5+qfNYo/SKE+nEpelMo/EEOqsedW97Aqa0YANoPBD77dsvTRRi81tp2s14T0jblmTEnJ1v5OG+MAkOsdkLPBHUGaCBHqwsoEwch8d9LrRNDlGQi6u4VBKeBFLOmksYhckVJEMy+nay7WfHyfX9/+fflPJFja+thQZFW0mVIorpV8WZhGZqEiwti2WWutj7Y+bj4S+ngYnsMjqJ8DvavwATo3HRhmJBdXLCGn2K8ThmSiupiw5JuUrEMwqvL6WUngaqyao0N7O7lh3+l9ZiuvP/Uhxx0p2U6c64+pteysaIlPbzkShonMOga2N7mDZs72ZVHShNbdjM9yfxUQPPr/hwuFcYL+sBThiSl3VxI1vI1NLCOmOLUbg8jpm3ydPwWMhsvWQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(86362001)(66946007)(54906003)(66476007)(38100700002)(36756003)(31696002)(26005)(6506007)(83380400001)(2616005)(6512007)(53546011)(2906002)(316002)(66556008)(6486002)(8676002)(5660300002)(44832011)(478600001)(41300700001)(4326008)(7416002)(8936002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RqSDZrUUIwRExBaFdVNmxXOVZmcVNDb09CakdKVlNzMkVVR3dOVldyUXd4?=
 =?utf-8?B?U3VlL29aYnFPdS9mbElybzVQSnVjcEFCQnJ4S3UvM2lvUTlRTmNmRjBNT3dG?=
 =?utf-8?B?VnFmVnNCZ2NWQWJJVlR1eXhGOGR0ckQvR2IzRW1IWGFaS3d5V3RUc25BZSt5?=
 =?utf-8?B?aVF2N0p4RDhqZURiMWtFSFRYdS9jL1d2NWVKRzVlbVBYMFlvK1ZXK204OFpE?=
 =?utf-8?B?cjE2M2xhRVZBTnBtSDY3TWRuSW9lUWpUWENqSnNEaFB0bFJCc0FWS1BEa1Y2?=
 =?utf-8?B?ZEthT2wycE51a2l1YWFsWE05N21sOXlTdEZ6NlZacTMraWR4QlZ3U1FSM1dS?=
 =?utf-8?B?bG8yekhyK0xsd3N3ZTk4NENTWThhb0RSNDJxUDdVM3BBK0kzL25pY0xWNzRi?=
 =?utf-8?B?U0R4WnZyd0tFYkRWYUo3b2s1QXoyclZXbHkrSm9VS0Z1NXFVcVBEM2tyVVJO?=
 =?utf-8?B?cDBLdUtIVWxFMkRqN1Y4R1liemk3NkhpZ2ZhQ2FQUHBCZEorT0JJdXE5R1dM?=
 =?utf-8?B?V3VGRTZ2Q0N4c0l0V0xvckNPUDMzU3hxeE9ZUW8xZHBnS1Zhcm13V3BrL0tN?=
 =?utf-8?B?ZDV5L3kvWndVQjI2Y0s1SC9PWmpKK2UxVmQ3cElzWEFuNjJRcmhldzh2QWk4?=
 =?utf-8?B?MlZxTUtYVTI4TEllWHNpZGRENU5PbDJwdTFCcVBxOWJpVXpXZXkycFFOV1ow?=
 =?utf-8?B?WVZqbENMaFJnWkxKNDlzazBNcXBFT1RGSXZmV0NmTEZ3ODdQS0w0RDF5WlR6?=
 =?utf-8?B?dStISzJvZ2RTdThZb0g0ZDNmZ2JOOG1XTFQ0aGpwWm9ILzdreDM5ZFIyV0FZ?=
 =?utf-8?B?V1hGcm5FSkIva1JieHdwelY5Myt0VndLZS84OGszRm5hYm14WVN6a0dXYmFh?=
 =?utf-8?B?cGdOWTgyc0dXbHBYYjljekZqSGRkNFI4RnMyZ1NsY1N4N0h2TGxPN0NQRm9x?=
 =?utf-8?B?dytRS2Z2OGFEbEJpcGRDckp0dUN5RFl1aUsycDJ4QXQwNW1SRVpZdGc2ZWtt?=
 =?utf-8?B?STZzOEQ2OHNtUThwWENiRkdoeEJtYWZvTXZOZmExN21CZms1VUxTdDBHU3R4?=
 =?utf-8?B?c3kxOXRTZ2hZbkpPTEhGZHFvdUZTdHV4Q2RYcFplMy9OYTdQaHBQZ1lrL2tI?=
 =?utf-8?B?aWRlWWltUHBMQXIzVnBmL2kvMEJqVFFxT3RKM0dUOExaSlJOTUczeTV1OGNw?=
 =?utf-8?B?ZVVmU1VUcjdpWE5DMXVudmlOZU11NlFkY3hEdkFMZjRyVmRvZWViL2FpTEw1?=
 =?utf-8?B?Q3ZDY0pobjhMNnRVNldGcFZTSU5ENzlGb2ozMlJGdnFNUWZza1NZek04aytk?=
 =?utf-8?B?QzRVVGpVUDhkaWlzQUM0Tjl5dzBHdnZtajdDM1RXMHladDk3UDJFMVRsRTlh?=
 =?utf-8?B?T3pEdDM1dlpnN0w2bWk3SzUvcGk4Mk13OWYwTmNoNUJtWkUxcGRGbzd5Yml3?=
 =?utf-8?B?MldSSEtrWnRPYlROeUJVK1p0WVhmVmVmUlB6eEYrb052M3M0SlJBUHg0M0Z5?=
 =?utf-8?B?d01EZnpVMkF6N3Y2dEp6TEUwNi9SOFp4S09uSTdEb0hkLzVVajl5V0ZOdTVP?=
 =?utf-8?B?RHcxNitxcERzbDJnTDUwdW5PcUtRK1hmRkpwZUNheTdVK3NiZ3ZtWWM3cXMr?=
 =?utf-8?B?REVSMnh4OWVkalVpdnY1WHlNY3B6ODY3VWlMY2lMeE5oY1BnQWpTTmliK0J2?=
 =?utf-8?B?ZW1aV1dJV09XdFhXZ1JTRlQyVUwyUEk3NmdCSnpvT1gzY0h2SlBSTnlhZlNQ?=
 =?utf-8?B?NlJINENaa3FzTkdBL2ZQc1d6S29GSEJqSGVVajJST0dHczRuODZZR2lTVDVo?=
 =?utf-8?B?aVRuNjZZazA5UmpRNGp0dVBINHQwai9nTVRoYTN4SGkxUWJGL29PVEZoQ1dz?=
 =?utf-8?B?cG4xeTIzczg4VGlhNUVUY0hsRjVmRFdma0NWRGlGUHRKckRyM0g2WFNwWXdF?=
 =?utf-8?B?YVA5UHNZdUQ4Q2hiOXlPa0JxWHEzNXhMaUZ1aGdzNWhVTzJUeVBJSW9vRmJ0?=
 =?utf-8?B?dlpKU2JzaEVzc1hPb2NkR3p0V0ZQZDdQNkVKSnRIbXVQQld3dlRTWlA5bVJZ?=
 =?utf-8?B?WHpWOXdGS09KM1daallhbFBGRDU2WDl0NUNWQ2xmQktUQmNaUVhTcVE4TGhE?=
 =?utf-8?B?cCtoaGFmTUNCbVBXekl6WmJvWnlCSTNPMWF5WWZkdHNicExEQ1FTZWY2T2Y1?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fc47ad48-5898-4155-a06f-08dbf1bb74f7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 15:46:02.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWprLXhMuB3BZ9r2h2pAyJv55I9vUpeAhFEMG8JJpbgbFCX99h5QdB5WPqSnPoI6oi3bvn2Bn2z7sRQvTGI5nUs7voY8p1N2ZDXe6GFT0wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 05:54, Adam Ford wrote:
> There are two clock-rate assignments for video_pll1, and the
> only one it should really have belongs inside the lcdif node,
> since it's the only consumer of this clock.  Remove it from
> the clk node.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 8d872568231d..a3dae114c20e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -647,7 +647,6 @@ clk: clock-controller@30380000 {
>  						<&clk IMX8MM_CLK_AUDIO_AHB>,
>  						<&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
>  						<&clk IMX8MM_SYS_PLL3>,
> -						<&clk IMX8MM_VIDEO_PLL1>,
>  						<&clk IMX8MM_AUDIO_PLL1>;
>  				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
>  							 <&clk IMX8MM_ARM_PLL_OUT>,
> @@ -657,7 +656,6 @@ clk: clock-controller@30380000 {
>  							<400000000>,
>  							<400000000>,
>  							<750000000>,
> -							<594000000>,
>  							<393216000>;
>  			};
>  

Thanks for the cleanup!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
i.MX8MM
