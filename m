Return-Path: <linux-kernel+bounces-16954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8B824678
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8DCB23ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A828DAD;
	Thu,  4 Jan 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="a4XCW/gJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21C28DA9;
	Thu,  4 Jan 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy4zYZxZnwCgMjMxRmeMQTMDOG5Z09Z3XJ8O71WPRGTqD17zuDZznZbjFOgcs+shNa+IyXmrYUGnjrifQsmJOIz+3NOAQBhDZ/Tg4BWWOnTc56ZJRtxZMhvhGJwRGMC9AWRXAnuLYyaX4ck3btiEvJbGKFBG+Xnj95Tk7yNouRBmUZYBPCu4t8ko+HjgZb/3vUjz+d9jl55tU2t+Lqy2Pb6tTw199SHMbPTqfWupiflEuTD3688DS/Jsh2v/HdgopU+2pUtpTmyWsPHitHO20mRBCwKcOd+wd0Q5J77Toj2MMswxQ32jKp6RQiMh614QECk43ipsOxsUkJudegVMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfE8zpKU30wCA8ikY8tv404UH7pPpHZVhM4Hq2yW4vQ=;
 b=DSyo/03zoFCFnijqY+12fUlRUdroQuztDUR/MHLORKDiJofZlKyLHgmsHnjA1oLG+GSXSR4Eq71Wrwj0Jw2o4hGQelJ8AzE5WjNwAUHt/Zu0jsGspE4j0Qb1fDVlarsgjjkBVAQx7K73pcNH41zVSa3a+vqIDiJ3ubaRUWNTtRN+TWXKrkoC5/PZHKuSylHG+TRMEhhBbIAnVxoOPGdSwKG0SF66Whg+PpNkQ8cpVgUBfIV8fAMx6CTy9DWKTDYYOvFWMJ2/6UKfDGRaX7dR1cze2HYmhZJLAUdXnaL+2xiNX2LfCuM9je0yEi4jF9GR4/NVM2RRFtCO7xToe76+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfE8zpKU30wCA8ikY8tv404UH7pPpHZVhM4Hq2yW4vQ=;
 b=a4XCW/gJ3AwRTRuMdD96d6d9lgb5JX+39HF5BBlu0WAXmEdBhCo+zYoP5l9yft94ufWbjiKOTeBqm+e4puter/JDE1vfQpUIwPv6Tn8wczJukytbZ7zEcyIk+pT9sVcXEQ3E/okRRnd2SsqSAw/Bf8NwAkuLW8mEcmb/cCVdUrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5578.eurprd08.prod.outlook.com (2603:10a6:102:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:40:02 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:40:02 +0000
Message-ID: <7a47a61f-4356-4913-8e04-5b815c8382b2@wolfvision.net>
Date: Thu, 4 Jan 2024 17:39:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] usb: typec: tipd: add init and reset functions to
 tipd_data
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>
 <2a001d00-32c8-4ec3-9635-08473df6a069@kernel.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <2a001d00-32c8-4ec3-9635-08473df6a069@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d7f1d1-051d-469a-aa12-08dc0d43cc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Zcl85DcMGyqSsDa42D96nSe1Po/1ZifDcRgexA7ubaOB6+X9vEZueRgHZZr+whKzJryy4NyRk9gDBc7htk2AfTNRBiXgOfy7p9lMQRsvQ5+GAkMzw7gVgoDj0dQJhcKliu9t1fdBLxZHLXO3hWstmq/zScXF2occqorIxT8gmL+0nR/y8LyrbhMhEd8ZNUiIsqa/PM8nvx2fCQtqrYUvQZDvvuzBjWyHOa0rYvOlIypqVKzgE4SW87eOAFcxDChOEwxu20AoQ29wwqQpjnZIMtWD5NczE/OkothwEU7val0cpnpFjs4Oay4164pn0bb3M78+b3swcD3RVFEhW+gDVtpAVQ5aHexsT130u4UpTY69qZTnsolDCXrD8miAA0/tSoY3orfme340c6q/34zqQDwKG06XbQR8vbWLbPu+pgxOanUASSFSCvrZta8CJTDUg7kXoUAMK55B5BEUI8RhvPRuakSG3SiCvBEbZUPg/eDwYwuMATThE9xWSIABChq9XzSMx7j+FvWHT0BkmkBwYj2dLeLagg/h4wo/vKU9S1VQ0QjSXUOqHB05qqMF5289KN8/2zrV4+ANN1gpB+Y3lwrO7RHp5uwEGyLTFOukDm3UYyCrifU3DMYZCdR/oCq4vFaIUvm8/0ND6GHrUv8kA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(6506007)(31686004)(6512007)(478600001)(53546011)(2616005)(6486002)(44832011)(36756003)(8676002)(8936002)(66476007)(66556008)(66946007)(110136005)(316002)(6666004)(4326008)(5660300002)(38100700002)(4744005)(41300700001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDl5ZXhpVnE0dWJyRHJXVXFqVzV5aDRFWWUwRElyRCsybnFkaE5xcDNnY3pv?=
 =?utf-8?B?eEEwd0x1cmJhV2ZIMEVyRHZnMVJoLy9nMFNieGJwV2NZai9KekdleFRYR21M?=
 =?utf-8?B?NGFhZC9PVEdpNlNoWEt3SGsrVzF2MnBhZDEzM3cwcmxWQS90US9ZMFloRloz?=
 =?utf-8?B?b3hWZDJWcHFhTWlhaWZpRXAxT1lOaVNyblF5Z21PUkk5LzdPZEN6cE1pSXdY?=
 =?utf-8?B?TVloWmNIQStrWGNKcXJ3OXcvSkJud3RaOXpvRmU3cDBRaXd4VXlJSDdNRVl6?=
 =?utf-8?B?QW5RSW1CTnR1emY1SHlUamY0b0QvYmVNbHVPZVVmL3dsSmk1R2Y3YURvYWNa?=
 =?utf-8?B?OUhucDByTlVFRnE5Y3pQOXpKbHdtUzd4WEpuNkZtSGJ3Mm1qd0xYaDhNeHl6?=
 =?utf-8?B?em5LM25uQ2E0ejM5dDc4a0RoOTVsR2tPeDczSjI5cldwQnQ4blIxVUN2RnBw?=
 =?utf-8?B?UWpWWlhONk1wTnBFUks2SzJOYk1ETGI3Q2oySG9QYVM0N2g0VUxLNjdTTW4v?=
 =?utf-8?B?WkpDQ0NFWExPYW5HUjZEbzgyS2NFT09yampXM3Q4d0pBUXFVTW44bnhDWHpl?=
 =?utf-8?B?L1ZTdjUwekltd21CMS8xdGl6cTFONHVWbGVnd0gyYTdIWFF1R0FqUWFobldC?=
 =?utf-8?B?VUdqWmF4Yi84OHlybzlGOXRaVloyRG5pU3RCTzJuR2JGM0lSbmkzbWxoNS83?=
 =?utf-8?B?Z3l4UU93MERjWFhWcjIwbHQyVnVuVUx2Z3JnN1NlK0k2c1JJVFdSV29IMnVK?=
 =?utf-8?B?MnpxUDdtRW93TmJnaEVqeUNhem5FV0lZeVNPZUJwNjlTbWF0TW16VWluc1o3?=
 =?utf-8?B?dXpkOVJPazE3bldMMUNSMnpGR0ZJWG5EODZ6YlQyMSt2V3RXenE2YUVpbjhs?=
 =?utf-8?B?by8wWlE4NjVrRkZDdFQwSDdBaWZacjZZZE41Y3d3Nm5MOHp1bzR0ZHZsdit5?=
 =?utf-8?B?VFJjT2tFY1Yrb3FieTJDUWUrVGRtQ1QwOHIyRVFwL2VQdE1LNnE2YUlLR0Qw?=
 =?utf-8?B?K2ZuUlFtTmsyZE56R1RZZDRoNWZXbGNQUnFsc0xydjhPNHZ6L3BWRmQyVDdT?=
 =?utf-8?B?UGNGZmxYQi9BNXZaTmE5UWhDWm8rZ3kycWtHOVBBdUNkVHNrbzVQOXp4R2RC?=
 =?utf-8?B?ajltWmNSeHBUWGorSG9hR2ludEx2MEpubTVZWmt2bE9hZUJpV1BxVWE0T2h4?=
 =?utf-8?B?N0t5WGgxRTA3d05hWCtzM1dLSStrZ05RSGFmZFA1Zm5uUUNDaE5aSmZzT3BB?=
 =?utf-8?B?MG9qemtWYWFaRWlLZmhmNmpJVFpLWHBoVXdRN1ZEZEpVcWQycHArNEJrRHoz?=
 =?utf-8?B?ZGlrNEJad3VCNFpRQWN5NnF3UXZTclloYmFHNDF3YVN2SnpYUmJNb0xRU0tv?=
 =?utf-8?B?dHJ1VkE3Ujd1WEpPdktkSUdvbUNoRGhEMW9RTmI5eUZIZk5GTlVPUHppYllG?=
 =?utf-8?B?V0ZocjZjT2VmdDI2MCtORENoeEs3eGpPV2JNQWs0QVVYWFB6NVQ1YUg1ZTBT?=
 =?utf-8?B?ZkJtenZaamxqb21kTmd3dDJJK2s3U25rUVl0a0NObjNSV3YxU2N5bVBPbkUz?=
 =?utf-8?B?dkZwTEI3S1RhZXZiTXNQUHdpM2JtRGJNbEhPK09RSnlPRjlwckhGR1VUZTly?=
 =?utf-8?B?L2E1OVRGS3RLVXBhYjJReGNneGtKZVgybGttbEtmdWtVa1hPQUg5c2wrR0VB?=
 =?utf-8?B?dlcwYmZRUnRHTU4vWFM2R2VTNEQ2bTVFK05UK2dBeEdZVUZPaUY2bUpBMXFZ?=
 =?utf-8?B?WHUyQjhPWE0wOEsrQ3BSaU5TaUYzNWY0d2RlYlp5a3BQTFgvZlpVTU5ZN0p1?=
 =?utf-8?B?VElzMC96bncrbjRrMlNBMHlkbGFRQU1xQWFWb1VMS2s2Q1hhYjBETEtXbDZi?=
 =?utf-8?B?TzFkS3pwcSt0Mm5pM2YvZDZuNU9pNk1XTGRvZCsxbmkyZ09vT2VyT1lxLzdS?=
 =?utf-8?B?VzU5UkwySmVnMkIzN0FFeHpKb3JReTdkUnJGYlhWM2R1TTdBbHdUQmNmUGR5?=
 =?utf-8?B?UjFCRm9SQWlHSEtRT0Y1Njg0emFINTlDZlVoUWpXR1lmMHlyUXBSV2Q5REow?=
 =?utf-8?B?dEQyNExjdkRVUExLL1k3YXNPWWFsTWNxQnV1dWVlakhEY3kvc0sySkNxbzJx?=
 =?utf-8?B?MFZNcW8reVJWcnVSNGFHQmJ4K2xKdVVWMjlDa2lQYkt1VDhBcDJoczU3UWlG?=
 =?utf-8?B?dUNTcFVMM3lPMVBlUm9VMWF3a21QU1dUQmV5MVNoTVlnY0ZFY1J1UHZDRHhB?=
 =?utf-8?Q?pgYf9NWMJeCYXuL/8pAiOpmeKUZoJrcHDHS0gPgx7Y=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d7f1d1-051d-469a-aa12-08dc0d43cc2f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:40:02.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1xQrjBZPH8hzefM8nlHlzxeNuFjvshcysfyefrVxL1tOJHUpzydoPoNTxlaeQVXPa7cVckSIZ1BzlfrMRATV8zPesf0tbdKNiTn+hNkDDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5578

On 04.01.24 17:14, Roger Quadros wrote:
>> @@ -1393,7 +1412,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
>> +	if (ret == TPS_MODE_PTCH) {
> 
> Won't this function will be invoked for all variants?
> If so, why are we calling a tsp25750 specific function here?
> 
>>  		ret = tps25750_init(tps);
>>  		if (ret)
>>  			return ret;

Hi Roger,

good catch. The device-specific init function should be called instead,
as it is already done in the probe function:

  	ret =  tps->data->init(tps);
  	if (ret)
  		return ret;

I will send the fix asap.

Thanks a lot for your feedback and best regards,
Javier Carrasco

