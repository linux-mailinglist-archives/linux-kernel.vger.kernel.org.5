Return-Path: <linux-kernel+bounces-16941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92F82464F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D630B2290B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478725108;
	Thu,  4 Jan 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="WmeikTlx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115E250E8;
	Thu,  4 Jan 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5U2OdZBJ98s97QmHLq+mrNi7ddXBB92LZjMjcffVmK5uJ6j1o7pexut9kb8Q10xgAfRVOhEJT7ahwa38dB8E1RzUSPz9fM7b95kWGpw7jvdhW5ljoltwy6tgkuCWXb/3T5X2iF/7TUAgfh8WKKKgDJiyd+0KjuQRaVGctO9MfzVssq3L4c4J7lx1zM6xrQzcvlcA5m7iCH06byLJWmjSrpIL6sSlyElysNtBQZS0CHgvNAh/j1ELkVONTyXCOH3IcK7r90bLHGki0AhUDIMUAczPTqWT6sF2WMG8w0hcdMjnxIOZiNjpE6DmQ0mJZWnbrTn14G4hzlftLo7e2dE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI1jt/DhYVbdodIv43BTAebpPA5F1xSfH6gx+f0SdMA=;
 b=S9bvSVhYMtCv0qJ/02XLcdkCYPsmVSoHFS3TbcaMvAnXbiV39J7MG6AmSEl3FOS7nfiwXVKDtLjdM00bcIjGm44P9+y++Equ1kElAMmXEpebzz9O1ExHteW2f9+QAnsV/yJgPD6ZpoMNksKEZYMZweD0733L57X1grwBuzyuc0m+WLlwA1my8ZxQcQ7PNMUEP4TeQJfo06GDM/9HjTs/OsQsetl4eRcrJr3HPBstJvu1aD+EzrETvAFRW/s+HoQCyR/j8wqlogCmr7K7K1vNU/nvtK51ncZdPlQ6eF2TXCItU5S+0645TMIGuh78h/pV5IC3h1rnSPQozNVqqH2a8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI1jt/DhYVbdodIv43BTAebpPA5F1xSfH6gx+f0SdMA=;
 b=WmeikTlx9Ied3P0jBRfM4/FI9+Vpzz0UH2SU0ADc5sOd+TLTqc+HwFgWabXTip+XKPlE5mGuWYUpcGTmKALsYnIob3FWqe0FW9Y/ZFzf4bNPsWfyL3kzE//Luelf7nFxx9vZk+55hXT0n9Dv2YBxGc6V1jfGqkMh7AArY3S/DUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5578.eurprd08.prod.outlook.com (2603:10a6:102:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:36:38 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:36:38 +0000
Message-ID: <b0963302-b498-4a81-b635-0b4faf02e83b@wolfvision.net>
Date: Thu, 4 Jan 2024 17:36:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Jai Luthra <j-luthra@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f278c62-827f-4a7c-ed3c-08dc0d4352c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oYy9fvZvRDO8xmvNXq2fiwQ2sinigQEfwL/9u0CuIAJ0MJRssGNcJpEjV1jYJGXQMH87CJorSVEiehLjT+XBuwStb/uZ/Sn6KBdRIIVF5+N3ydGj4OCmBrBwAFCM6k/b0Pa56+t2Q6zCpBLB8f4cjG1Mrwk/1FEHi0MslfdH/V4lLzdEXEc1OUovaI5VY6xzzMkyL85XlGIxvAvW9btJ7z3inkAZ2IspDGouUOOuI2pEJjtJ8Vr27vxUQhS388P+Qkef4L1ksQKyL7H5uehFfGaaNpeWJJLqTbVVAMFF8b95cF2s5+TRi3iiefaBl9A1CYlmfsUPiQFLknStJIf0782fjd5CW6+oZTB+GGQGF1Nh+gstL0PGWB4yfodQhwui075vUV6pMG85ifNUDmoEl27TJEfqU1zoo2fwF5MhsBzpu44v5ZNRcIGwTsOllgrpSLmZ4DyObNY/X9PB7uBmHwcvVHbDf0G53oZ5CLdjSIqMEpPrrK0b/zkk+Pfaf0pa9xE5OhoXhTBClB92WrX8oSaDEeU69JXHyDASU1r6bN45PDNLTIvzFwclW7Pv34BvF32gG/mXiULul+LbgVGF3BXKvywbMcjh19tre0kF5iW8Hq5+9eNYlw4Yz6PAz1FAi9CwXfpQf3ntJC7WrSwNrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(6506007)(31686004)(6512007)(478600001)(53546011)(2616005)(6486002)(44832011)(36756003)(8676002)(8936002)(66476007)(66556008)(66946007)(110136005)(316002)(6666004)(4326008)(5660300002)(38100700002)(41300700001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEFHYnM3R2djVXRSWGVNNXhydUVLWEVKU2JGeUU1VmEvc1pKZEJkbzdzWTd5?=
 =?utf-8?B?MHJDcHNLRithbDM0alExVCtBV2E5L3NmMnBnRzJBbTdsZnFKSWpIT2lCbUly?=
 =?utf-8?B?aHhmUzlCSXhLbXlQZjB0ZHBYUFZNTXJCU3RjMnkwSlFHWU1LeklLVUZMWE1K?=
 =?utf-8?B?ZURpWFZHcW52dldBREYxaDUvajBldTBkS05SbzQzSlB6UHB0ZFBLVUpUbzdu?=
 =?utf-8?B?RTlVQW4zVjF3bm5hazhkSTZqeFVrSktOanRHQTV1bDJMaE5Od1lzbjFOaXdL?=
 =?utf-8?B?QS9tcHJiL2hqRG0vNWVVQk5lUjF5elIvdWVuSzgvQmFEU1Z6Ukxqa2NjWkJ4?=
 =?utf-8?B?KzQrUldRRXRxNktlS1d6RlNjcGNNc2g0WnptNmU2VE44NFZFK3hsSmRGYlE5?=
 =?utf-8?B?RGp2Q0M3NlpyMCsvMnhQZG1ETDYrUm1iWjQwdnRGbnZNV1QwVStNakFvak9E?=
 =?utf-8?B?dnFEUGdFeFRXN1hJaW4yVnArck05ODFXamQ1T0RsNWZ3Q1lUZ0xiTE1zT0py?=
 =?utf-8?B?eUdxcFdLQ1NrRnVxOXpaN0hnYkhFMnlSMGdEekJHeUtJRC8yVUNDTmc3enha?=
 =?utf-8?B?aWJsVlA2UmZ1NkhjOGd1WWo4SVdiN1Y1dlhHMnN5WGVaRXJHZEYvQkNJTWQx?=
 =?utf-8?B?TCt2NXZneGNMVU52dk9SdjBOMXlMVzJwNjEyeGx1SFdPQWhrM2t4bnc3TFhP?=
 =?utf-8?B?UTRqejRCekRZVnAxcDFsTXE0a21RWHhqSUJKOU5PRmV0cFFsZjB2U1o0dXFs?=
 =?utf-8?B?T1p1NEVjNFovOGlzcEFLaW92c210azhaajEzNWpTSzVPNDdlTWVQN2NVcWlV?=
 =?utf-8?B?MmVYcWZrcHBCMmNpMEJGS0lRK2ZQak90TUpacWNyKy9QM2lyRlA5RWdaMElW?=
 =?utf-8?B?UmV5WE56aDBCZW5EOWNQM1pwekFHNVdnSXFrVHh1dnNxTHRiRnB4SGgvM1Yv?=
 =?utf-8?B?Kzc0OGptbkF1OFAxRTN4Wk1qWnJuekR4alpWbk15ZXltblE5TWtqMXNNTTkv?=
 =?utf-8?B?ZVRkQkVUZFM1OWFuTXhVcFQ3ME5Fc1lKYWlHN0lVeHJNR0N1OTBXM1M3elAx?=
 =?utf-8?B?L29jQ0pxTnJLU3dxc20xUis5dFVJZzQ0L3Z5SnYrVk5KWGZzZm9kMytoU1Ay?=
 =?utf-8?B?RlRhRitvSTZvcnJPRXpSUFRDNE5zN05GakxqTG9rSkhvaUhtUDJYUnJpcXdC?=
 =?utf-8?B?TzVXUlQ5OExDVmU3UVlRR1ZvWFlPNDQ4WFFqQVBOcG01K3g4ZlY5S29yNEht?=
 =?utf-8?B?L0FXTlF5WXUzY2kydzUwYzRNUzJtdExXQzFYYkErdzBTVFVJekxuVzF0d2I0?=
 =?utf-8?B?MDVZRUJRSlBKZzdiR3lPMCtaaWh2N3ZtT2xyM3RqblJaSVdlQkt1bGtkZ2xS?=
 =?utf-8?B?bHlEald2dk9tSktZZitIdjRWcW5LMWxJVWlJU3J6bEd6eEhCUEhzdkJtR1Zl?=
 =?utf-8?B?UGhGeWc5ejVVVWdCaTMzREFHdTUwcG9NZ3FadGRVdU4rWDV5Mnp0SUhFYmJK?=
 =?utf-8?B?SmNPak56Z0gzK2lCRXVNSVpiOFI3L2hTN1l1Q0ZQUjFWVGpxMkZiZklQUmVh?=
 =?utf-8?B?M0lmaEJOMjFXTkhsSm00cWd2Q21sU1pFdlJVdkxvckJlU05jZUw4Z2NZelVp?=
 =?utf-8?B?dVhKUlV0bEpCbCs3eldJS0c1RmJ1ekZlaUs0MjZBbVl1WW91NzlwTFpMZytJ?=
 =?utf-8?B?c21WVThyR0hzc09jQUMxa3Q5V1ZuN0JsTitHbVkyb3c0NW8wUXRRSVpLa0hW?=
 =?utf-8?B?TjAyYytBSGxwTnY2Y3dGaytuOG44aXNjdXFpcmVSTzVtcE9VUnFkSlNDWlVS?=
 =?utf-8?B?dlQyYVBMTlhrZ2F4TzNNYzAzbnp2QjhzRWFJMDRsVFc5dGVvdGYzN1B5aWx3?=
 =?utf-8?B?SmRNZmRvTEZaRmlJT0o5SGpiYnhLcEZkL3hEY0VQVUUvWUhHUzczQVpSSHhh?=
 =?utf-8?B?RU9WN3RJSy8wMkNjOXV5V3hEVmdWcnFiRG84T1ZiWEUvRVVEQWo4TmZkekR1?=
 =?utf-8?B?dVBUYUFoRmpoMTlEYU0yS1Bsc3FsOW9LQXlxMWZhb0ljUXVIVzg2RFZGMCtu?=
 =?utf-8?B?c3czY3dMc2oxdE9XSmEvUHZkeTJpS3pHV3J1bHdnSzVlMWVDMnlVSjhGeFZO?=
 =?utf-8?B?Y3h3TVgvT1hQNHNIend0dDZ5ZHhtSS84bHZwYy9KbDBsTjlpak9vQUZnQ1hE?=
 =?utf-8?B?dUlqUHlua3REQ21TWHh1Q1l4cExUaFhQWDZaYlBzS01aa0ZCZmlMaTZVVUE5?=
 =?utf-8?Q?Z6uiTy7UzJRfWlHiYQzOB/lZsO3ureLZzE5XZU+Ubc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f278c62-827f-4a7c-ed3c-08dc0d4352c2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:36:38.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9OVL6VnsBif2H/AqSqk7qHWpkYhOQwZxFfBzOsGjcUlK9vaGGkudtARb9h0hTWPK814l8liLOQhqLXeMXNDAeBnJ8HB/Acn43AMFPyszSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5578

On 04.01.24 17:15, Roger Quadros wrote:
> 
> 
> On 04/01/2024 17:47, Jai Luthra wrote:
>> Hi Javier,
>> The following change seems to fix boot on SK-AM62A without reverting 
>> this whole series:
>>
>> ------------------
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index a956eb976906a5..8ba2aa05db519b 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
>>  	return 0;
>>  }
>>  
>> -static int tps6598x_reset(struct tps6598x *tps)
>> +static int tps25750_reset(struct tps6598x *tps)
>>  {
>>  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>>  }
>>  
>> +static int tps6598x_reset(struct tps6598x *tps)
>> +{
>> +	return 0;
>> +}
>> +
>>  static int
>>  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>>  {
>> @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
>>  	.trace_status = trace_tps25750_status,
>>  	.apply_patch = tps25750_apply_patch,
>>  	.init = tps25750_init,
>> -	.reset = tps6598x_reset,
>> +	.reset = tps25750_reset,
>>  };
>>  
>>  static const struct of_device_id tps6598x_of_match[] = {
>>
>> ------------------
>>
>> I am not an expert on this, will let you/others decide on what should be 
>> the correct way to reset TPS6598x for patching without breaking this SK.
>>
>>
> 
> This looks like a correct fix to me.
> Could you please send a proper PATCH with Fixes tag? Thanks!
> 
Hi Roger,

that fix only removes the reset function and does nothing instead, but
the reset call is identical for both devices (hence why there was a
single function for both devices). As I mentioned in my reply to Jai
Luthra, I would like to know why the reset is triggered and why that
should not happen.

Thanks and best regards,
Javier Carrasco

