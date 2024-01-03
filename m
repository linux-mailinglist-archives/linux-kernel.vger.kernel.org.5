Return-Path: <linux-kernel+bounces-15370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF53822AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC21F2405B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD618659;
	Wed,  3 Jan 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DyNZZVEM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B118631;
	Wed,  3 Jan 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE+/ypk4NovM6n8PmvSzLtsMDKc+U47K+J9il+xQ9fl6tQ7q4HGwTWVMptLfo0VEzV3up8vT7yo5lmfPH724vnxEGXR+gD0rswo7i9opy1JIviLG0G5TJpm4FN4Fv5Kq4TysKPhzrs4HJIAyqNyQY6Oxp2lo/mLieFrxDAKclruJAxp0k4Zr7HDm63eiasj1UMrM3Gx9tuQnbdiFCEurnonKp8N0VA76PI9z8mBDqyBosUdOiwfZ8W9OlUWCeqdBc4g1Q8MfSlAtLm6Jm892taDK3pRb34mQNVzrpcpXFtIa4l/eT3oct8NQADMBQMEUi3YjsrQne2K6VIlb4d++/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtZ44OFYAY+wo0o8JM4/oCGBMB3PzAwTO6OgWDVIbmU=;
 b=J3hB84+BN/DaNffDTI/uuCz2a5nlSg0QNIjkazKSARrwI77ztehxO85t5vwL1IqYU+Z6buN7pmJ1x9ltXZ63Z7OI+I5Bh0cmwBYWVH7rz/1D3zLCjk269sz+xWpKuWBZj/tMdHAxhzG9EXT72SHJYegmpvn3Xoug2Glh4Otig90MCpsuMkO3pbaCrw5FbkAg10LRRGtKX+kxw27+Bt2fy3wG4hZKdHBjcciKzdWhnwd2rHZai0IAHeUxriqJ3pXkyTgFnU1EkF2nresgR8o8vYR9XEwwHmxUfmhnsz7plNzG7dSnVq0RorwvL+9UtGB4PQOVtNHeE35EV3eBtVm2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtZ44OFYAY+wo0o8JM4/oCGBMB3PzAwTO6OgWDVIbmU=;
 b=DyNZZVEMBYlKD9lD735qISedNdjk/lUQ5KtjZBa/qOYTfc6oHj5sy1FMJzwL0YNHYJFfumzktZ+dHyXfXVk5XLleO8wNRmh2JukkvirZ3UggNYMjH2cMf73rBcMn7z3HmDUiwZiF9QWK7BvyerlMD4kdLc/wRKwFAGm7IxpZP6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Wed, 3 Jan
 2024 10:03:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 10:03:13 +0000
Message-ID: <19ad5595-93fd-4344-8c90-d5903eb6e279@amd.com>
Date: Wed, 3 Jan 2024 11:03:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Content-Language: en-US
To: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 robh@kernel.org, krzysztof.kozlowski@linaro.org,
 angelogioacchino.delregno@collabora.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0245.eurprd07.prod.outlook.com
 (2603:10a6:802:58::48) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 87127d7f-3be8-4005-fb66-08dc0c433271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gV1fS2WCSj1vX3g2PaPtilB0WkZrzxxmGAWrmKblNS03Gk2krGCrbk+CaPGu477/wXxZWasa2xQCta4FwDFdG/4AU4O4B+rbgFLQXTfStpXeTpCbGFEczbFkOlD02wnPFta5IACrvPuqL6dic+Z5XNtB6bATWOJL9ek8n3x/mPsI1YNimFyO+xk+zJDOo6HJCVGEPRdatswT7X+9VEFcg4Yqmq5qAKdewalayDxHTvUheYb+o6W7SFemgQjsQeuhixNjqAOdbk85fc7oJT3hIe/GdDY5lR/sDj59xKDkBifJ9dwu6HREgrXcnbD968ZDnsfyYSywF4XgLXXSJ2YsauGDQ4fT9jXtUUrufNBhCnJ7ELgw+14gEtB8+Sedl8HYUBhuBwJ7OR/U6Zrd8iT2bHmJ1Q9ph80YZiIpI87wFygbl4tKUXovY/NeMENGXFeDiFIkKmoHQLrQqpQSAdAlQD17mzW60lT2tZ+1sN4LjjE06xbFXUvN6GumJo5fJZHT62jPAunmIN+FrOT8HJaBjXnWkiSxa2I8MpFk9apu3vK65S419A1Jih73RCbVkv3MCmlxG85kMBpMREJ/KedFau49wbBrgt7jUkGnZUDWCa2NpvV0fClNnjNO1Z/1S2cCDqCMnMyGjIlklkIeTy3WiY+6MtxejzZFcEfTyAux/TtheAONFmjHH6ry0JIn5MY3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2906002)(8676002)(8936002)(4326008)(44832011)(36756003)(66556008)(316002)(66476007)(31696002)(5660300002)(86362001)(478600001)(6486002)(6666004)(41300700001)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFJlbTJ6YjRGSThXQUVXWDZnU1JHUkN2aWxQMjMwUDFZeUFPUlE4RkQ0NWlX?=
 =?utf-8?B?cVVPZGdFOUtnZlE3aEowUWgyU1VRREkwb3o3ZTJvaWp2M0xUWDh4UHFaajdG?=
 =?utf-8?B?UjVnaFU3aG4wcldjSGVoOEZEUTJBNGdmNDd0N0FHZnFzUmpQWTF6ZVoydWhq?=
 =?utf-8?B?d0lheGpaYWVXdTN6clBCVU5zdmZhUk95L1F1OC9ST1BFSHFud05zT0NDNzBZ?=
 =?utf-8?B?c3UyOWc1RGJ5VkFGRVpHVGVINGNjUHcwc2VJYmY0ZmxGUWkwLzN5ajRJYXBh?=
 =?utf-8?B?MmtTQ0dXV2JNZk15T0swNXlTYW5PbEdqYjlpMmdJMjM4NVBQcUd5S255dkFi?=
 =?utf-8?B?c2kwTVRwdjJaQ29FL213eW5xRzJaTkNRYkhFbnVnYWVURDFJcUQxK3RkcU9I?=
 =?utf-8?B?MzN3YzNWbUk0RGZUNjhTaUlaaWNSbXErZ2tJR3hVTU9leG5XR0VVU3o2b3A1?=
 =?utf-8?B?amQwYVpna0VBWCt3RzREN0hPeVhYU0IrS1NXTDhqdVBtOGlCbHlZc013UVBs?=
 =?utf-8?B?R29HNG5sdmY5ZlcxZm5KVnZWQXFCcXVESmxZMThPSlFCb2tud3gzZjFBUnVu?=
 =?utf-8?B?NUtRZzFGbE1jWUQwQWdwWk9pKzk3NXlQNTZBKzhYMnVrQ3lnQXgvc3VKMkkr?=
 =?utf-8?B?b2dUVTZ1Z2lENE80dW1XQVg1U1k3Rk5ISzZNZU1LY2o5VHdHUVhZclpEQmZs?=
 =?utf-8?B?U2hOdEk2azZBcWtpUVlPZ0VWQW1aa2Ewc2Q0UFRjR2JrS0JpVWs2WTBOQmsr?=
 =?utf-8?B?MU0yeWZaSnpCUlFBa1BNU0REMnBaUGdwWDdYWTlaUzV6R1gwaGlZQTVQUnRU?=
 =?utf-8?B?MHNLNUtuZ0VsVnJHQ2lHSE1vK0RUaHhSWWZuSlQrMUFpbDZNdkEyclJqZjlU?=
 =?utf-8?B?Y3A5WWhyYnMvdlJxRUJkblZkMWtYWDczV1orYmNoRTR0VkFDV01IRFBHQVBu?=
 =?utf-8?B?dElTUmRzczMwKzROZTV3Vk1uQjFWbVROaEJFRjhjajNITFd5aXhxZXlybGQw?=
 =?utf-8?B?M2h6bFBQWlJYRDA0Z2d1a3NURHdjYXpaYUZXdU1tT3RtOWJsc3V5Y3hDZG81?=
 =?utf-8?B?MkYwZis0a1BkRkJqMTBjbWp4VzUzM3FBUkZGNklIVHQ0b1lDa2s1dzFHdVg0?=
 =?utf-8?B?TWw2KzMwR3l5OENDQzdZalk1aHFsa1FoQ0k1aXM1MXF6ME9BUEREczFaUU1z?=
 =?utf-8?B?bEkyaFZXem9TUXFZR0hQZHpVbmhaREN2ZzNTd0xPOXFrY2l3ZjJpWHIvTlhp?=
 =?utf-8?B?Z2Iyd0ViekZlZVBhV3dsSHFuR0ZqSG5jMVdNdXNjVGdHL1NvNkpTSGxOcElt?=
 =?utf-8?B?UUgxaElsUlA5Z1VNdTcwdUdrQmY5SElkWDYwMFVodVI3UTFyVmVpL0lWY0ZU?=
 =?utf-8?B?NmRXbkVtSEtTa3RqMHp2VktCKzZtR1BhOE4vVzhZcDlhR2lKVk03MU9VUVZ3?=
 =?utf-8?B?M2p3MkRrWEZ6RlJXSkgzcjBtK0I0eXAzZXY4R3FOeXplejZGejgxWGlTNm4r?=
 =?utf-8?B?amVwRUlJZVJEOVl6eFB6dU9qYytvNjIrOWxzK2x1Tm40OHFtMnhqck4xWUJu?=
 =?utf-8?B?QnYrZzhJamZ2d2FmWm8rWnh0VkFteFg1NHZFa2xhWE0vWVE4b0Z0Yzd2ek9R?=
 =?utf-8?B?dkwvbitGN1FpdmR2STZ2R2hCYVhvTUhBWEVlZEV6cDF3ZVpJaUxtL0lWWjhm?=
 =?utf-8?B?bGlQcm1qSDhVRzYxaDVGdUFTZm9obmNkTlNyYm5VdmMzeGQwQ1lDWitkMm5a?=
 =?utf-8?B?ZFNUeFlMMW96RVRDcHBTa1NCSFBYVUpCaXA0ZzFsaFVxZ2pmcGtjbnpSTWc0?=
 =?utf-8?B?bHAwUHQyRUsxODR6Ujdwbk9LYklUVmZDZ0tpcEVrNEpMM2d1ZVpRbW1nb24v?=
 =?utf-8?B?WkVoUVN6WklSZWNGUStxanFuUnZjdUlWTVRkZzI0NXVuYWM0SHNyTmRKbGdU?=
 =?utf-8?B?TGYzc2hySEg4Ky8ybWtTS1FmUXV3RnUvdkp5WlFnRG5oK2hJK2VtSDQ3eFlL?=
 =?utf-8?B?T0NSdkhVbWhhVDA1REtXb1NoZklodndXOFdVU0w1QldBOXYyR2NzckgzUDc5?=
 =?utf-8?B?T1h4TnVvQ3BVb1dWZCtMUWlWQ05hamhlbjF4cGJKTlAyYlB3enZ5U01pT0ht?=
 =?utf-8?Q?z4vCfxgIAiQS+JF/vv+NwZdnl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87127d7f-3be8-4005-fb66-08dc0c433271
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:03:13.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPfqsPoXAPIpqxqANFyM3C9ln5EHKUtdr89bDKSanT7MKaRuFAg2nG/Foafq7Pe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225



On 1/3/24 08:20, Naman Trivedi Manojbhai wrote:
> Currently, from zynqmp_get_parent_list() function the clock driver
> references the clock by name instead of its reference from device tree.
> This causes problem when the clock name in the device tree is changed.
> 
> Remove hard dependency of clock name and update the logic to use clock
> reference from device tree instead of clock name.
> 
> Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
> ---
>   drivers/clk/zynqmp/clkc.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index a91d98e238c2..87915de083d9 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -549,18 +549,46 @@ static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
>   	u32 total_parents = clock[clk_id].num_parents;
>   	struct clock_topology *clk_nodes;
>   	struct clock_parent *parents;
> +	struct clk *clk_parent;
> +	char *clk_name;
>   
>   	clk_nodes = clock[clk_id].node;
>   	parents = clock[clk_id].parent;
>   
>   	for (i = 0; i < total_parents; i++) {
>   		if (!parents[i].flag) {
> +			ret = of_property_match_string(np, "clock-names",
> +						       parents[i].name);
> +			if (ret >= 0) {
> +				clk_parent = of_clk_get(np, ret);
> +				if (clk_parent) {
> +					clk_name = __clk_get_name(clk_parent);
> +					if (clk_name)
> +						strcpy(parents[i].name, clk_name);
> +					else
> +						return 1;
> +				} else {
> +					return 1;
> +				}
> +			}
>   			parent_list[i] = parents[i].name;
>   		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
>   			ret = of_property_match_string(np, "clock-names",
>   						       parents[i].name);
> -			if (ret < 0)
> +			if (ret < 0) {
>   				strcpy(parents[i].name, "dummy_name");
> +			} else {
> +				clk_parent = of_clk_get(np, ret);
> +				if (clk_parent) {
> +					clk_name = __clk_get_name(clk_parent);
> +					if (clk_name)
> +						strcpy(parents[i].name, clk_name);
> +					else
> +						return 1;
> +				} else {
> +					return 1;
> +				}
> +			}
>   			parent_list[i] = parents[i].name;
>   		} else {
>   			strcat(parents[i].name,

Not sure if this is the best way how to do it but it works as expected.

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

