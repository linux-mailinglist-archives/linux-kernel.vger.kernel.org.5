Return-Path: <linux-kernel+bounces-3921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CA817524
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4441C20B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BD498BF;
	Mon, 18 Dec 2023 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Lp7gmxsE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EED42385;
	Mon, 18 Dec 2023 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTG67uu1PZlPFsBrPEWfCDPrYh8PzUCRLkFmJ9HE6GVhsYtaGWp0HtxoU2JJp3svTfGDa5cZ/j1D0+gIhsEgHt4HwH/yPM2FZcoc9YiQ3ve7uzODV5BGrHwwi0cyQFdc6coP9WWWiDiIwtJQOOG7OiDF7A0kX87WuW/bEzW0JZT4YscvlPsuXPbUjyfQHRcKLu9dYNY0Sg1Fng5R2qy8a8Vox1aI13Vc3EBGxLWpntjBL+jzuZGwYzNhU5p71uUchKPm9/op2K0Ouj7LCLsSJcwfvRPVP8q6zbcp/Fc7MA3YqTeBsu6/4mmCnDqewhEnkm7d33X1V1IEpZQ41Ubyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlxwZZlJ+QDnZbxD7tSKZfSZw3p5CPt1Pm0y9FXpjLY=;
 b=kU/NNp34cuk5O7oGDRYiFL8pdbJMA+jvLNwJ94MPyPevwnNrwVHfjO7BH85woOvSoxAwtFMJrH3ngsPUZZGfJtBKPkIVU9cPZlEh0iiDl44MrznBBYiSsAsjo0m5K59hqvpH45OMrYCilZ3KHLZkj2kA42jxVOlMWYy4q8NJVTJirDgOJy9QXsCEovhaoh9cEI1RI630s+sxjwnIDVRiZAvV31FITvcP4gYZRtTjEo0yFUdc+ZIjqtzYeEYy22Ajn1lnx6U00TfzK5U/maTmDbnABouQCriXJfNHwWI+NQpyF1ZxP4164MmMmgpVgjCKLeDbXsoGomMQ9xhedg7GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlxwZZlJ+QDnZbxD7tSKZfSZw3p5CPt1Pm0y9FXpjLY=;
 b=Lp7gmxsECp28qqjMHjk5TMCpjXDHasRNgnlvJwCzPDR2cSiBRUTomFBwSf1zkv97kGz1yeRKbaUox1JbwH1OnD96oTx+OgL/y7iscJD6yo5MyKEem2wyghCZcyEPzHHjfh40z1jk2HQVt6wXjzgMq3ksJZKbx3aSrS9UtjCB0L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by DB3PR0202MB9250.eurprd02.prod.outlook.com (2603:10a6:10:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 15:19:20 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:19:20 +0000
Message-ID: <45bb38c9-63f9-101e-60e5-36037699f11e@axis.com>
Date: Mon, 18 Dec 2023 16:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add ps high definition for
 vcnl4040
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
 <20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
 <20231217141554.04c8863d@jic23-huawei>
From: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20231217141554.04c8863d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::31) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DB3PR0202MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ba9ce4-b493-4215-0cc8-08dbffdcb557
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DSoFWw3s+KO7btS+cNIBxDEo3YbZLNjKefPX+1+dCSamC+Ee0jbFyHyq7YlayBMVuZPSlQu6Tw6uiPcdG0WWG4QPRMeSiaPyo7RTfM543fGYF1BldLElZFHNu4aLi4bF9fG5WJM0FqTIVpoVX1X40jm2Q9WvPrwfc4hVFpqhDQCp/ffen9E2e+4IhoAKCHPBXMkG/K1AZr9zfMMNdlglq1AK0F3spTtDnHidlxH1Xnx65AuDoy0Vld4T4RiO9+ZtLYZnJ309lm3/xNFEHc21HQo1n0NE+hE2hmNo/pKHG3FYSgv5rVEgJz1GDg5IunAS0bYfNuRQkqCu0pMbR1nRDl9AK5gecAS65UHglqxpzoROr1SrHBttoN15ZBrZbFGZCHA77oiWFcmLTH3EaHWHaE4iG8RzSl15LN1cyzGPB6BWHb5/zKgsHPS+v9yDFWS/nrBh/xlloqiCD0HXOhjHLEF5UZvAMAaHZDFTaOQD3HFHluxv+ve7GodSvmy1p/0KsgO13fD+3QzHggSsPQQkWmSpNohits/F0ylK0aPowviomSIxZ82j5f1HC0epxYGRPWd43aqwOzjvX60CaEeO+Mw/OwPu4J4Ox7WLeebLIHdg7o8qzTj8hLwd7o7SKUaauc2KS86s1wdSD6OMtl/l9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39850400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(6916009)(66556008)(66946007)(4326008)(8676002)(8936002)(66476007)(31686004)(66574015)(2616005)(83380400001)(107886003)(26005)(38100700002)(5660300002)(41300700001)(31696002)(36756003)(53546011)(6506007)(6512007)(2906002)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGw3YVQ3UnB3TUdRRlJTS1NzT21wZjZ5dXhaOXdFYzVzejR5b1FnS0RDNFVy?=
 =?utf-8?B?MHdxMzNnMHNxQ0hiQjZCRUtxQ2x4K2t0ZkQ1bU02KzdZUytHcHdGRENsNHVH?=
 =?utf-8?B?VTQ1YTh5Wm9jeUFGR3VScmFUZ29tdXVtYktvK3BlT1Q3TkN3L2I2a1VjVWc4?=
 =?utf-8?B?a3JMUW0vOHM2c2FVL0R0VEJlb3F5eUlUSUE3SXk2elNqdG9EcThmZytickJm?=
 =?utf-8?B?cWVTdXBmTXpuQ05xQnBjcVpubFJ6NzNjMFd3UiticWNtcGVGcVhxVi83TDJC?=
 =?utf-8?B?S3dJWmVJbXNYL0N0cW0yNlF0bnM2VTNEM2JkWlQ3bUZQRzlwSmFzWUdCRTJi?=
 =?utf-8?B?ZkpaUnZ5dzRwY3QwUlZQN0p2MFV3YndhZ1F5WlJVTDJBTFE0UlB3K2IxNEVZ?=
 =?utf-8?B?TUpESkJTY2I3VHc5b25UNytoQ1lIdlJXNE9heEVHN2hGeGFqNkQraDJBL2I1?=
 =?utf-8?B?a0RxR2xwTVZCcHZNNWNzYUdVaWZLclNVSWF3QUZXNVc0bHJMMXBzUmd4WCtw?=
 =?utf-8?B?aURiQmxvUjZJOFZzVFE5UDcxOVZxREpaenFRMU5xMnBjK1dXSmdPZmtGRDdx?=
 =?utf-8?B?T0pJeW01TkJ2Y0JvdCtPVWt4TGVncDljS296V096M1p1TmhwUXA2MTVoU2Z4?=
 =?utf-8?B?bjFtajFrZWFQcWFKYTNWVlBBOEVpaXkvRDdIQlN5NmVQQ0JwUll0TTY0T0Fz?=
 =?utf-8?B?QVBISll3eGdjMzB0anVUWUN6cHNOSzhiZnJBWDhNQjZZWUhKTThvNFFteVov?=
 =?utf-8?B?ZHRQblZWRHlZU0xGRmdtNWtiTlpSTzBQSzFXUStHTXNabDQ1eGxmdWp3aW10?=
 =?utf-8?B?WDNweTdIdFV5MjN6K0NIK0lXYXVUWDVuOHZaSUtEZWtlYm1iOWdoSWg2Zmcr?=
 =?utf-8?B?c2hJd1NFQkJId3A4cXJsK2tvVjVIWGNoWFFBVWZzWXNmUjFvV2NuYU56K2lP?=
 =?utf-8?B?ZCt1Rzd0c3FSTTI3TFJtZEthWUY4L1h6T2ZpK1k5M1VJZHA5SSt6Yjg0RHo0?=
 =?utf-8?B?b1dPRk8yUHlOL3ltaWswYkFsNWRYdGUyYTF6YnNQdk5lQjI5VzZSUHo5bUtm?=
 =?utf-8?B?NWVKQlBjVWpZa3YyMXJ3d2REK01Ed3puRVdQTGFPRUJiT1J0MnlKOVJJU2Y0?=
 =?utf-8?B?Z1JVUEtKZERvWGlucVFKQ09XZHZyVmpQelNnbHNYT1pWUXNNSHYzRlJ2eTVz?=
 =?utf-8?B?bkkrYzlXUFNFU2tSSU92czJJcy9Wd3A5QVNRRGFuTS9MUFhYVGk5UEx0ZDhI?=
 =?utf-8?B?a2JTTTdlS1dWNFhCcWVURXNmajlQMW1LbDVKZktLcTI5YmFneEorL2J3WkRP?=
 =?utf-8?B?S2Y4aEEzaFYzMk1RcXc1bHVEb3dZd2pDY3JRaGJleml2ajdXMGJRTkwzY2Qy?=
 =?utf-8?B?TVVuWmVaeGhYY3ZlNVJDemQzL3o3T2MxekdSVTIzeW5IZFhZYnliOEM2WTZR?=
 =?utf-8?B?WGN4cmMzSS9QamxKQ0MyYVU1Q0NRUThQQ2RUMmJkVmRsNjlPSURqanJOMzdL?=
 =?utf-8?B?NGxnZjhuMW9NZlc1eW5ZRzk3T1NGbXJDZHRrOHhMY1QzMVBpa3VmOHFPRENU?=
 =?utf-8?B?MHpqVFhsZTgzVUFUNVdVS0tpMWdMTWoxY2x3Wkc5L1pxT1c3TERNcTJxNDNC?=
 =?utf-8?B?WlNjdGZ2N3RSNVB4c2FHRmN0YW9QZVhDaUk5TWNvZnZ5N2VxUjJSbWVLQ1VI?=
 =?utf-8?B?Q0V1SHVWRnhpS1dNc1NTbVJMVlRFc0RjMlFkQVVqcno0VFhzU29QQ0hyK3ZR?=
 =?utf-8?B?U0ZIUlRrM2pBL1RCUmhTdGFidVFGZnZlakVIUlV1SElTcGZIRXRyYUx2V3Ju?=
 =?utf-8?B?Y0Z1S1RNd1R5SEJxUkE4aWlVbUlNODRiQW9KWTJQcjhpcjFkanJGNlNXOHRT?=
 =?utf-8?B?b1Vna3lQSHpSYUNva3NjMysrd2k3Vjg3QklnVXFsdVlxdUUyOGZaQ1hlL2dB?=
 =?utf-8?B?RjVPMUxPMWNJb0ZkOGdZb0lnR2tyL1lOMDRIS2JGRWhDc2VkM3FEQUVONWdj?=
 =?utf-8?B?eE5lYTBBVzltQjIrdFFpTElvakYyVEtTNTFLQUxrbTRacEN6eVJJVDRvb2lP?=
 =?utf-8?B?UkxHQ21SdlRnOGNneTJlaXZONi9sTW9rRHNwS3lUOU9YbThXV3d2MVZPQjBn?=
 =?utf-8?Q?S33qRKBYgBS4YbPUd5Env5HtH?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba9ce4-b493-4215-0cc8-08dbffdcb557
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 15:19:20.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWoV8FnSNaj2KB96wroCnRxkzhLNgn7EX/c1/qCqXRiiQRam1FjetO0/VlmbREGVNdCTBObWjsAkPfEY8AEmow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9250

On 12/17/23 15:15, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 13:43:05 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
>> The vcnl4040 proximity sensor defaults to 12 bit data resolution, but
>> the chip also supports 16 bit data resolution, which is called proximity
>> high definition (PS_HD).
>>
>> Add read/write attribute for proximity resolution, and read attribute
>> for available proximity resolution values for the vcnl4040 chip.
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Hi Jonathan!
> I'll review this on basis the usecase is clear (see reply to cover letter)

I'll skip this patch (see reply to cover letter comment)

Your are right about the paired register manipulation. Better to 
read/write byte instead of word.

Kind regards

Mårten

>
> The manipulation of the CONF1 and CONF2 registers in a pair is rather odd given you
> only want to change one bit here.
>
> Why is that done?
>> ---
>>   drivers/iio/light/vcnl4000.c | 87 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 85 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index fdf763a04b0b..2addff635b79 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -90,6 +90,7 @@
>>   #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
>>   #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
>>   #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>> +#define VCNL4040_PS_CONF2_PS_HD		BIT(11)	/* Proximity high definition */
>>   #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
>>   #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
>>   #define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
>> @@ -170,6 +171,11 @@ static const int vcnl4040_ps_calibbias_ua[][2] = {
>>   	{0, 200000},
>>   };
>>   
>> +static const int vcnl4040_ps_resolutions[2] = {
>> +	12,
>> +	16
>> +};
>> +
>>   static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
>>   static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
>>   static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>> @@ -880,6 +886,54 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
>>   	return ret;
>>   }
>>   
>> +static ssize_t vcnl4040_read_ps_resolution(struct vcnl4000_data *data, int *val, int *val2)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> The field seems to be in PS_CONF2.  So you are reading a word and I guess that
> gets you two registers.  Can we not do a byte read to get just CONF2?
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_HD, ret);
>> +	if (ret >= ARRAY_SIZE(vcnl4040_ps_resolutions))
>> +		return -EINVAL;
>> +
>> +	*val = vcnl4040_ps_resolutions[ret];
>> +	*val2 = 0;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t vcnl4040_write_ps_resolution(struct vcnl4000_data *data, int val)
>> +{
>> +	unsigned int i;
>> +	int ret;
>> +	u16 regval;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_resolutions); i++) {
>> +		if (val == vcnl4040_ps_resolutions[i])
>> +			break;
>> +	}
>> +
>> +	if (i >= ARRAY_SIZE(vcnl4040_ps_resolutions))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->vcnl4000_lock);
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret < 0)
>> +		goto out_unlock;
>> +
>> +	regval = (ret & ~VCNL4040_PS_CONF2_PS_HD);
>> +	regval |= FIELD_PREP(VCNL4040_PS_CONF2_PS_HD, i);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>> +					regval);
>> +
>> +out_unlock:
>> +	mutex_unlock(&data->vcnl4000_lock);
>> +	return ret;
>> +}
> c),

