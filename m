Return-Path: <linux-kernel+bounces-14221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B9821957
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3771C21B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9BCA7D;
	Tue,  2 Jan 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3nxs/4e2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16CCA68
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH5anPS0VN+da2FLukEEYx0NnimJHGNWOJpwHBLBJXFe/PQwCoW6odmJzPSsIAaG0/b7JSdEawiHXtHmmJpC6Il68w9bO8DqXJPQSToXWzSRL9hVNJY4Rby7dMFLSPK96gfSJRFFqhyRPo7tIpTeIpDaxk/wFgM63DP0n5MjELUYnTDd0BwdJrjpySOcz8WgXNBrEXACAXITA5476BWVFyyTkH1v+9UjbCShxG0eSPOzeqwjWgCanSbLcdJosmk4iL2tNxeZfR6nNo531DW9I0JPlQWJmqnMF/ZQNfWmDDDK5uf6Nq/u4xkIDTPF21ekWEfhPaBngs/yLPbDZA+bSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJaJ+UKOP1RNFLo7IuBTL3eBeulTrCYxR6Jr7+irfkM=;
 b=OGf8cQsRIidFyAMkceU99GAp2BVMJwzByVIJKTvl0L7HCZqrHtJBOrhrbRDMbojjVU4I42YKtTNWpIriXZlvtwW7xwvGEJPKt7o8fyiwopWzbpXN8Jk7w+QkCFlY1ua6q6CJmM7ELfigVsNZlW9ilwHwj/f1FREGe9y5+9Tyb0eQ2MYbfJHObMeTOfh1Sb95t2eyfXyCy774wrfDPmGUGw3qZyzO/Swk7fdcsC9zWptJHxzKkoJySxThQGyc+oR0eR28Wc+zrcviDUC2y38szIYTr6gflsYlLlcSd+O5OTGv01r8zLPmSvvC2JyISJUyANcK8brYJGVpqEr+V83VoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJaJ+UKOP1RNFLo7IuBTL3eBeulTrCYxR6Jr7+irfkM=;
 b=3nxs/4e2QCankXJ9Xmlbq/RIJEzpPInRMKW8K67If4Blvj9wUxKgfiHmkUwB0qIKjZR0hawAxjhSxUAZhcK89vjlxvIXoRHeiIv0ecj9PscKV3ngf0JVrgyVuq2iiL5nbasF+q0kinC2qUQ0IEiwFgzf4Eag5tbyapQjUIMH/zI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 10:01:09 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 10:01:09 +0000
Message-ID: <ac766276-d71f-45fd-ac29-a6f6bb34674c@amd.com>
Date: Tue, 2 Jan 2024 11:00:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] firmware: zynqmp: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nava kishore Manne <nava.kishore.manne@amd.com>,
 Rajan Vaja <rajan.vaja@xilinx.com>, Rob Herring <robh@kernel.org>,
 Dhaval Shah <dhaval.r.shah@amd.com>, Marek Vasut <marex@denx.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <b5a82472a6d61608c2cd7728ca364f6c88a821c3.1703693980.git.u.kleine-koenig@pengutronix.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b5a82472a6d61608c2cd7728ca364f6c88a821c3.1703693980.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:803:50::39) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: be59b704-ee44-4812-661f-08dc0b79be9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KZraZ6D7nQr7yoyMqiQ+OXnUt174vedmU1+CyIL3/Ojrix+CPXO1vawCo0cQxiW0Q5bwuPlS6YaVRJoCwO4ufvx+Qgghgy4Y6j4717YBOL02g9StG75Uq9z28EL340KV7eeFqpzmiYVhsJIMPGOrf3wbiSld70HqeYsmoWSWlsfCDSdf7KvvC1KbeIW4jjoCxB+9Bd0yTR1zvriPsYjb7R1VIYT86O4i4t86jcuq4Ku0LOWLqAaotJp8sE56FwRhuP6Dzc91u+YoZOXrghgGlUb7wG8yBdgbPBd0jgONIHGcCrGCXmdn4f7bHg5PjmXX0GeKhoSRTX3el/ttt+P9dkckJn5qxqsgVF0LdETzqqzWLUqZ+UTHJhLttc8uMVxvuKFWCOiEKzHh97bhnbV1htNRyGmAHy7eh1BUZ3vH9Baj1m1V3bLIXtL4ZBdULYTj6WTEMyAjdhR0mS3URw/JFtd3lcdHnU5LqDrnyzVwUrP2635QE7959SGJaIo/7kqeFoe7AsEHbHoUjfj3FxtzNQnsTyFY0fU9cSXWKycr434uHskgmlkt6lnkRsEYJxRgQHwP/yvcfGkLfjZguXIlKUDYNDamh9pHhemRHQQzYHmlZphjeS1+m7KDqP5hBMgEOtU9/bziUxPWLa16k0mctm1riHIzyrZbM0fLL2REA2eCuN+md1LyrI26zE2aYxWVGY5LloD6GskaLS3O/lGXAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(478600001)(6512007)(6666004)(38100700002)(5660300002)(2906002)(83380400001)(6486002)(41300700001)(6506007)(2616005)(26005)(53546011)(66574015)(921011)(316002)(110136005)(86362001)(66476007)(4326008)(36756003)(31696002)(66946007)(66556008)(44832011)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekpvd25HTjZPQVB5Q2EvZEp6ZWxSckRJMHpSeW9maFo1eFo1dmpESkI3UHh4?=
 =?utf-8?B?SlhuY2J2a0QweG1naHlXWENxTWhEUXBnTHY5RWoxTm42WkVsdlBlTmw5SlRl?=
 =?utf-8?B?RkFwUmE4TlNPSC8zWVlvS3I3WURGQlliM0R0ZVhPN3E0TFpqbzBoVlljK3pv?=
 =?utf-8?B?a2JQZ0s3S0VKOEN2TEZQTG95Q2d6d2FlcGNFMGNnUTYvWldRQjlxek9ZWkdt?=
 =?utf-8?B?UDdJQTd0TWliWlNBTlF0RDFsaEh3SEpGOThBT3RyaU9EblVNZ09CRllTSVJk?=
 =?utf-8?B?bHE3OUpic0xrWnk0b0xKdnZTUjIycy9JOWQza2gxakVKc1JWaTQzU0EzVlFk?=
 =?utf-8?B?MVIvTEt2cEczVVc3YUovdTRrOUVYSDhVVmVma1ZXemRjb0xERDFEVksxKzZt?=
 =?utf-8?B?cGx5UTYxU1ZIWjdqY3l0STVpd1V0UUJyNXJvWWsvdU00MzgrNEVqVmJnMzY0?=
 =?utf-8?B?bDdkNWZKck1FSXRLNGhJUms0b0hPMFBJYVFhakZtN05jWVRDQ21VbDEzcjZx?=
 =?utf-8?B?TGJlLzFUMXFhLzFYaG5MUEUxVXBEV0t4eFVZNk55K04xbEdYNG5qZWc5Vm8z?=
 =?utf-8?B?d0YxUXV4bllQRVJwQkgrVkZKY3lxRU4zdzBjVWxGT1UxeEFLdzhkTHlycVg5?=
 =?utf-8?B?WkliQkxZN1Vyby9ucUljZHIxVHRIaHIrOE15Nm5LZnBYVkV4OEJRQU90cngz?=
 =?utf-8?B?WktLL2xYdlBIWmFvS3lHWndKVWJKUEFhYmt6QWh5MUw3dXNSdzI3TklWWGZ5?=
 =?utf-8?B?N09pbWk5d1Y4SkxFTnVVa1FySHdIYTlmTlhHQTRnRStKK2NaazlROHA4VHpr?=
 =?utf-8?B?YmJsN3c3blNWSnhvdm9SVTI1a0tscHY0MmhGRUdYK3BkRGhxdFcxbm0wT2pa?=
 =?utf-8?B?OWYzTzRBNVdiRU5Bc29nYnFvRUcyN3hLZ290Y2xMTjBnMWprUnZEempXK3dv?=
 =?utf-8?B?RHRXdmlBNDRFSnFxQytZQ2ZPejlTdjZWVnVWUk5OVGI1ZHZlUlZyMThyTks1?=
 =?utf-8?B?ZzZ4SjBDb294cHBJVHhjaVhLL3grNUE3dmVxSUtjb2tHaTBobjZ0VkJsdlh2?=
 =?utf-8?B?dGk0UjlQOFFKa1BrV2NaTlRnYS90ZGdpU2xlQzRWbFJLdERRcDlMVUV3bW1Z?=
 =?utf-8?B?QWNPRzExT3FVVE1yN3lsckZKc000cEtxdDBrVFVmQmZkNkVTa2hoKzZwVC8z?=
 =?utf-8?B?WEcvU0c2cC9vOFkvYkdKRS9vQXFnTkhkNWZRNCtwY0FWZ2c4ell6b0xpMjBC?=
 =?utf-8?B?SDA4b2VWVllELzcycmtEbkJrOGFvK21BYmg0WGxrdHdkTldHclhBZjRpOVNS?=
 =?utf-8?B?ZGJnckVKd3kzTzNjQTQ2NW9uOXhJazhvUUZWa3lUSjRSd3FIRHd2Y1lUSkFh?=
 =?utf-8?B?ak5JRTBrVzEyQ0djU3lUTUlPWDc3cWdhR1hJUllWdVdMbWhGRWFIejNLVjJj?=
 =?utf-8?B?K1BPOTh1YlhHVDdYS0JyeWl3dGpWYVpkQ2dkcEwzaThFeHZYSDB4UnIyak92?=
 =?utf-8?B?bmNxQ3JsbVlKeEdDRE1XRklHWmVndnVjRitVcGNXWGhKek41U3F2ZFo0MFhR?=
 =?utf-8?B?TTNDSkRLaEZhdEhMRFNBQ3dLS3pnSkloVnJZdUd3NFdib0tJeFB4Q1duSkZI?=
 =?utf-8?B?Qzd1MUxEemgydmd4SGp0TENKeTZyWTVQb0loMzJ4R1Y4N0paT0tVQ0NGNHRN?=
 =?utf-8?B?c085aFZITzd5bElRK1l2YXhRRHFMUE05ZFpXYW02cWJnS1ZPRVUwN0JhVDg2?=
 =?utf-8?B?a3Qxb2NXYm5sRllnb0VjUXJiNGIyQmx6dms3cnNqcEFrL3V4MnBIQWZqK3Vi?=
 =?utf-8?B?b0pXZW5ub0g5OVZwQVIyNGFycTdIRmNtZWFvVG5FNDZIUkJVRElMSDdjTGZT?=
 =?utf-8?B?UloyNGdQN3phK3hCWlAvL3dvajROK2RwR3hUV0RWUnNrMVBVWFRXdDFLdVF2?=
 =?utf-8?B?N3hYNWtkQnA0MmpwSzYxaVkySzNRUHhRdVpWZ0pNOVlVajFsYjFPSjNHYVRM?=
 =?utf-8?B?QWtMUTlmUUpScm8zWmFVTmJpQ3ZwYjd3eUR0NEp0cGxmd2dFSC8vdlNNT2lp?=
 =?utf-8?B?OUZ1ME5lazh4dEcrRzVUM3NVc0hRemhLcG9zUlJ4V2llOHNxakNWNVhUVEhN?=
 =?utf-8?Q?GbKdJk6imayXOhL3qJT1Bi7tr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be59b704-ee44-4812-661f-08dc0b79be9c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 10:01:09.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1Zhy5Nm9+epz4qRPpBYpPAZicDV8UFQvKvZUaSzpYvqdYPza3swjW7xSRJjgl2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106



On 12/27/23 17:26, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a55dfd9bae6b..73cae6ef83ec 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1929,7 +1929,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>   }
>   
> -static int zynqmp_firmware_remove(struct platform_device *pdev)
> +static void zynqmp_firmware_remove(struct platform_device *pdev)
>   {
>   	struct pm_api_feature_data *feature_data;
>   	struct hlist_node *tmp;
> @@ -1944,8 +1944,6 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
>   	}
>   
>   	platform_device_unregister(em_dev);
> -
> -	return 0;
>   }
>   
>   static const struct of_device_id zynqmp_firmware_of_match[] = {
> @@ -1962,6 +1960,6 @@ static struct platform_driver zynqmp_firmware_driver = {
>   		.dev_groups = zynqmp_firmware_groups,
>   	},
>   	.probe = zynqmp_firmware_probe,
> -	.remove = zynqmp_firmware_remove,
> +	.remove_new = zynqmp_firmware_remove,
>   };
>   module_platform_driver(zynqmp_firmware_driver);

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

