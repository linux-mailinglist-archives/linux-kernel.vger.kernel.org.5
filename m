Return-Path: <linux-kernel+bounces-21256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE6828C93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AA289B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D93C46A;
	Tue,  9 Jan 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="B4AOKaWx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DED3C068;
	Tue,  9 Jan 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4R+scxPyHoKjvpPxLrIWCm1gBGEZ05i/bBb/WnyhiupDCSSGFJ9xUZRdPtaS3Qul3kCczl0DfYfGFwDzTJamBwgrsNskKWzphSfvLtRUYYKihCC0KqjoNEn3iH3QFuDQi6kBqdzKA3QPlYDSn7NudnWTaUlP6td8euPCIsuTiteqPyVdPHoQkJ/C1uSQKcSWX1fkyjbtfyZOH7sh04LcwwmKeTHy7TfEqPKs27IzkXI7XbpDo8sWh/f2KmgfEwvJFORzm+aFlavZ5ncD+81/I8ee1GD5F+orhQqnGect4v4BarbBcbPBNQ1UPzBnGJf/I6kHqRGtkhHY7TRIUTChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9xKq7ZoAI7ECU/Wu5J/t/YX/C2/BznlG1zFuTFfNc8=;
 b=Sevz+h4mfzJtiuw+mJU+KxW0Ix85k4uUuv6tSGk65A5gfAjjivAcclTBFeu964C/VqpjPmrx2CdiJMZj2OEYV6XmHr5dtaqZJkyyCZAtdrKGEGDZJWiX1QIbzyKFNeBxwKYe6R8EX12mUK0EvuhwJfNPu7d+Z/dOk4jYWMMqZx/bXdK1Er8mhy08H+6o7ZFkHoxELPMwS73bOcsY9ZMhW+oxk3wgxSQ9tJzhIyYBnMR7RcHFBri3hkFjL5r+7qGYkox9jNDGoawI+QHeMxP7ILk/oDgyUJ11cEixNtv48qKLTbvw7m7Hnk9rhmds2c3R5ftpPNmMrq+iW6TPQS1J2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9xKq7ZoAI7ECU/Wu5J/t/YX/C2/BznlG1zFuTFfNc8=;
 b=B4AOKaWxncAk4JcaLEtKFrK10XyH9cJ9qXjKQfVCuix6K7+iFdCBmfYv21369ZImLEXQCd2Mia7Xkef8XUOOLnNUQP8SEflPtu+mZ9lpkhj18XD7/Iv1/dEzmDCvGUFtOeQk5MUJycS3ilj90r8ZRyy2IwcR0KoAgC+VC8TsLUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by PAXPR02MB7277.eurprd02.prod.outlook.com (2603:10a6:102:1cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 18:25:54 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 18:25:54 +0000
Message-ID: <58319706-dbc5-4ee9-b894-cecbbd23fc1b@axis.com>
Date: Tue, 9 Jan 2024 19:25:25 +0100
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Set ps high definition for
 4040/4200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com>
 <20231226161934.52c8d801@jic23-huawei>
Content-Language: en-US
In-Reply-To: <20231226161934.52c8d801@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF000013DF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::b) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|PAXPR02MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: b826214c-5340-4c1b-7e4d-08dc11406a86
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kuf7ouPojrcCAqsU7Wqvs6djAlres+lrXgc7KJbMCuLq0QUcKqde+3fLYaBemZPuCnctdKO3CUuPVMHDAxiEYDhjiFenucEhcadHxGWK/dAsWKOne60FuLNpPKJUdFxeQtcsY/UTmwo/D3F1oJSAgNdmYQCCGnAbwfQ6R/gtDp+CRYdhczXLRGcDxVpu5xn8lYRuS1jg5vxDUdtmZ7sNDzoiJYzmA0uUqtGjWEGRX9YpumgcxGMFwzhP/qqcF90UpdRxgFyOdxgtcvAGub5fPdOqKZmrjig9QD8PXTXcXGx9g8uzsII/9LHnGapyG6RMLbWMmAcGqAWJOfdof4BkefgZaGvSqHT2TVXpFPZY5dwb3WaiAow96eCnf1dAiD4B8QeMtrJgeVAxr2AO+6t2y1hqDJNjC7loCxM9NuWRasoiIPWeLeAX1lFZgDUQo0+r7+XVa6O+V40GQEhCDM9a9SytHFmAS0ePi7+yYZiB3V5cquGlaCOtpYcwwysRI9yp+NT9Ud36/0T53UmDUItGkveZQ14UblqWLOPFgto0qqnJrcdTtrOqCwsfrEnkNV8GnXdW0bXiNrpawlU4bLPdx7vuuQkLYg8nnIh8buQUJk2Z4YFcBv99VOWXJxaPL9qszQQyIulZzSVilhXgHf8O5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(83380400001)(66946007)(41300700001)(36756003)(31696002)(38100700002)(66574015)(107886003)(2616005)(6506007)(53546011)(6512007)(6916009)(6486002)(2906002)(478600001)(66556008)(66476007)(316002)(6666004)(8676002)(8936002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2pJbGoyVTVpeitsNjZFNWxQWmNsenlYUlArbjkrdmtBYTVpNWtNeHVzeXRO?=
 =?utf-8?B?UkF1Q21Tc3RkeGFUWEZoSHhFcXNiUlZFazlIdVpsdkVsQi8rTWxaaXVQeWxh?=
 =?utf-8?B?a0gvUWEwTU9WcEYvbzBNUE40VFJFU2Q0bEMrVld4Q0lpRjBMdkZQcXJlODY5?=
 =?utf-8?B?NGJGVGhhT2dpVkhWNkQ0STdwbVdSTTdqK1dIZlBtYnYrUksrYlBSam1OYm1n?=
 =?utf-8?B?UFV4NTJDV2wrMEFtRXdPVmtPVTAxT0dVU2lpQTZWc0xrcHFNYWxPNDZsMDJU?=
 =?utf-8?B?WU5XM1liMzdYand4Y0VkVjNrMkw3emtRM1k3Qi9LK1B1RkYzQXNiZWFmT1M5?=
 =?utf-8?B?eFNPN2d4VnJiZU1VaW9yMUpxZWhyUGFoR05JM3pqcWthV0ZBZkJUWkwvdXNB?=
 =?utf-8?B?VGQvL210cU1uNlN0TDY5clNJcm1NeUkrNXQzT1FUamNuT2gwOVRVbW1XNldD?=
 =?utf-8?B?dDQyVEFVUVJmR3IrTzRtS04zUmRCSmVZSmU0MWw0QnVESGNiak80eXJKbzNT?=
 =?utf-8?B?RGpvVVdZMEE2SHFpaEtZUjdlSHgwRERld1dETDkzUEx4UzA3YVBJVkVXcitL?=
 =?utf-8?B?M25SWWtGeWp3Ujd1azNYaEhoTHNKQ1RJb25TV1lrRURIaXM0dWtqczVQM3Bz?=
 =?utf-8?B?NFBibFZLb21hUkRLakp0WUphSFg5ZVQvZUw3MDgyRG9RODVBcDFmQkd2am5C?=
 =?utf-8?B?ZDc5Yy9wRWQrdDNOb1pjQ1NDWjArZHNlem13U0RFS2hQQUpZSEFFQk9Odlhp?=
 =?utf-8?B?QTdoQ25MT2wvOGJiQW1MS2x6TFRLZ2xrY2ltNU1aQVp4dk5NUGp3dXI5ZHps?=
 =?utf-8?B?SDQxR1ZlNUxKd0RkNHVuOFVrT25OeHJOWmlhYThlTldDbXFkSVBEVXZ6TEQ1?=
 =?utf-8?B?TjBPODk1MDlnWUhsOExWZE9kb1ZGblcwZzF0UFdQSUFQL3hqaEJrb2F3MkFn?=
 =?utf-8?B?RmwrbUpId1djUktMVThYMVN0UWRVd3Q0cUsyS2dnVFhVOG0xUUxuamFTUk0w?=
 =?utf-8?B?ektiK2t6cWxuUExETm1PanZHSGpXK2FyNkhSNEc3VjdBcDl2NUxlb3MzbWht?=
 =?utf-8?B?VGZ4SDVGQ1VGaXJndTM3a2Q0TjJlRndGRHpxSFliNWszbVphcEM1am5WWlhX?=
 =?utf-8?B?VGdFZ2w2dTloNDR4M05pSVdadGhVcHFUTW9CVWoxaEpYMDFGVHBEOGpydk9j?=
 =?utf-8?B?NEoyY3hzMW5udHI1RTd2Ym1FaVVpdC9oNmpKbVg0TzRSbjc0WlBaZk9QN1hC?=
 =?utf-8?B?NzRVTEdYeWxNYXlHZS9lN09Oa20zdU1lS1phQnVaOTBLSGMxV2ZMRFN6Q2ox?=
 =?utf-8?B?SkRrUjBIb1JiNE5nVWZFOUZpWU5wNkhwK3NMME1ibDNGUFpCSUNrN1NhSm00?=
 =?utf-8?B?YzE0cTI2bVVhQ09yL3R2NGlsUFF2ZHp5RHJhTGZxa3dhYVVkMERBTE9NWTNM?=
 =?utf-8?B?dHF3b0J0R3FpMWpHTnpQelp3NTRRZDB6SE8rcWFLbHkvM0FscEhpLzVMcVBy?=
 =?utf-8?B?aFplYWVaelcrc1lwV2NGQnpwUTIxd2duTEhDN3JCd1ZyemFxT3BmM0dJalM0?=
 =?utf-8?B?Y0FjTVcrdExnTnBpMW5JL3BRV1JQY1dCMEJxWW5FMUFvZDExK3Q0UndOUStR?=
 =?utf-8?B?SmFSNTdIcXpqcXJKLzRTTjdhS0UwRFdvV1lGUHp5WGlYc0c4K0pDSjJteXAw?=
 =?utf-8?B?ekhZNVF3TG1qdUlXbE5CVXdyUThwbE1PanFBMEE1amhXNGlkN0lYL3ZURXJI?=
 =?utf-8?B?SG1nUVZrWEhoSzY2ZGJvRFVsRzVrN3MvaDI1Yi83cVB3VUZORFlOTTVpS0d5?=
 =?utf-8?B?Q0tIVVBrYkxKUDhScFN3NGlyODJyMHJ3cGZvM0Rab3hicGt3VkkrbzRUMHhM?=
 =?utf-8?B?VktlZ3BMYytad0ROTk9FWUc3WnZZWVdUU2x4STkrbTRoZ1F3TGpoeWpRMVpJ?=
 =?utf-8?B?M3Nua2ZYN21FdWhYSXR6UkFuRnFjUCtOTWNTcmNKUDU1NVd5RlZyZU9XNGdW?=
 =?utf-8?B?SCtwQzVWU2hsN01ObUU4QkxJamRhbTdzQU9ML3FGem1uSVVDZjQvNGdteTVL?=
 =?utf-8?B?clhvb0tXT1dxM1ZLRmc5UnV2c0M0WlZ0dDEzUUhxZE9TdDlwQlFtdmhNV1FL?=
 =?utf-8?B?RVZJaFk1ZEFwYTBtNklzeUJJVGhOUVo5bkpyOTVzM2pzVmpEZlZCcTAvMEZJ?=
 =?utf-8?Q?aiMw87nnVAmBZ3uojO48/2GuRLoJMq0SdYZhNUMF+L3g?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b826214c-5340-4c1b-7e4d-08dc11406a86
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 18:25:54.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfyL+sMHKt2QJBVSMl1tEdI83OUVm3+XUawPLnU04H/doN3/bpHhJ2PZ8ltTG6dYRbfqQmHRQKwRQ9OWUe7P/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7277

On 12/26/23 17:19, Jonathan Cameron wrote:
> On Thu, 21 Dec 2023 17:33:09 +0100
> Mårten Lindahl<marten.lindahl@axis.com>  wrote:
>
>> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
>> resolution, but the chip also supports 16 bit data resolution, which is
>> called proximity high definition (PS_HD).
>>
>> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
>> all data readings.
>>
>> Signed-off-by: Mårten Lindahl<marten.lindahl@axis.com>
Hi Jonathan!
> Hmm. Was about to apply this and had a nasty thought.  Whilst proximity isn't
> 'scaled' as such because there is no absolute scale applied, I assume this change
> divides the effective scale (so what someone may be applying in userspace) by 16?
>
> So this might cause someone a visible userspace regression?
>
> If so we may have to report it IIO_VAL_FRACTIONAL with the bottom set to 16
> so we end up with a suitable fixed point value from sysfs.
>
> Jonathan

Yes, your assumption is correct. And I found that this can easily pass 
unnoticed, at least on our HW. To get full 16 bit data width the sensor 
needs higher proximity integration time, current, and sample rate, or 
else it will give a raw output very close to the 12 bit steps with a 
maximum around 4150 compared to 12 bit max 4095. With our HW only few 
would notice the difference.

Increasing integration time/current/sample rate is already supported 
from sysfs, and to get the proper scaling I can use the 
IIO_VAL_FRACTIONAL as you suggest, but then I also need to set these 
higher values from the beginning (where PS_HD is set) or else sysfs 
in_proximity_raw will give output "259.375000000" for 4150, instead of 
"4095.937500000" for 65535. If not, userspace will have to change the 
values manually before first read can be done.

Regarding the changed output format, is it ok to change it from "4095" 
to "4095.937500000", without making users upset?

Kind regards

Mårten

>> ---
>>   drivers/iio/light/vcnl4000.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index fdf763a04b0b..4846f3b698b5 100644
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
>> @@ -345,6 +346,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
>>   static int vcnl4200_init(struct vcnl4000_data *data)
>>   {
>>   	int ret, id;
>> +	u16 regval;
>>   
>>   	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
>>   	if (ret < 0)
>> @@ -389,6 +391,17 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>>   	mutex_init(&data->vcnl4200_al.lock);
>>   	mutex_init(&data->vcnl4200_ps.lock);
>>   
>> +	/* Use 16 bits proximity sensor readings */
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret >= 0) {
>> +		regval = (ret | VCNL4040_PS_CONF2_PS_HD);
>> +		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>> +						regval);
>> +	}
>> +
>> +	if (ret < 0)
>> +		dev_info(&data->client->dev, "Default to 12 bits sensor data");
>> +
>>   	ret = data->chip_spec->set_power_state(data, true);
>>   	if (ret < 0)
>>   		return ret;
>>
>> ---
>> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
>> change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7
>>
>> Best regards,

