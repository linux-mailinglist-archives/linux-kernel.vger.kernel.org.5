Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECE7D9CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346260AbjJ0PYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbjJ0PYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:24:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5CAC;
        Fri, 27 Oct 2023 08:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi3Hy5MlnrhE9FKkTVVTj2qVAlvkeLy1y6uExt5JLThYlV0NeuNB/t2fS2E1LbxaFKnBwEpCwNrqxCzSH+iht/DhFGEuuAP6Mrwwd1G/9J1Cz//lHpA5rRIBWdk4MvFfB6wL38S2vVL1IkdS78fM/+XNP/xd9rsg4RMzJ9ugstvp0UzwLCVpY4U84NsbGeKK2LGod24NdMfCWTEdeVspCu98XW5JG8yZhoUQ2tEIMavbbT42x2VEmoTf6hFDtMiyxOYPwwPUGjVyaDBHVRqMVI+vM9+ZwptUfMXaT+ydWDjvJszfhuL7A4zGuN1mJCpX6NfdqeJS8BrFedo8NAnnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mhCY7chC5wkWRnB2GHs7EIiIl5MFD53U1F+IKlw4UU=;
 b=m+vZ1xalui+TIQ/l8dqyLHzCesvx6060u0MLVN5isTv9wvPI9hSAVFBViWg2ugTetrvryhRDQbmU0ChchLWFtjQTcK5yM8hIampndQa5nW7crOausWQGFCiHiWZKnUfeqbkg1NemoevCA0UqKO9Jk7HIKsOQJvSkiWZJYA7xUPtmm+q4ZBw2NXy5JXoGhG9WcY2cITLcX5og+BWrh0c8cKE3UWuEh3lOz2YCd5fKPWreohI3eGd0CPhX+2YM5vuzZXw4O0ckHHCFv4EI6FGSCDZXqD14Wp3HJWpX5Y0Is/4y0TwMzssPaMNX5dNOYlROv64fVPKJBi3FbELClObVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mhCY7chC5wkWRnB2GHs7EIiIl5MFD53U1F+IKlw4UU=;
 b=M6bKPXopCuUyqztwnwRc3R8SerGjboPXXaGa9+ugzdu4p5jpNZv+5ooTAShkgkud/S8dRgLnFEF0X5WitpMQbbH8jH6WiOd4XFHbOk48tksqUjY1xVPhOubux00n9JhcVyH0gX2lijWKd9mpINIZ0JV191+svKn8zLAc+N8LwJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DBBPR08MB10772.eurprd08.prod.outlook.com (2603:10a6:10:53c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 15:24:27 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 15:24:27 +0000
Message-ID: <26b07823-a560-4bb1-b37b-70752ceff469@wolfvision.net>
Date:   Fri, 27 Oct 2023 17:24:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: tmag5273: fix temperature offset
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net>
 <20231027151507.2eac395c@jic23-huawei>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20231027151507.2eac395c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:803:1::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DBBPR08MB10772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cde2d55-2979-4fef-839d-08dbd700ce5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBJ3IEGLl64KcU4msvkRZYmTmObeG6qsIxzhJ04SE6nb2or1FjbHxpJ0EcxD3Xb/1rPBSGc6YaQoxq8EkpLEBrRhRl+kd8ogXf4eEui4VzkCGZPaELz/LtGR4ST3bgXIccP44f+h21aMbyUrO0p8kbgYwJ66xHRxDpzKGou1xFHgzt0tnf1Fcrg459TCvrf+93CAJK1NkiGW4qxBw/vo+RIdMxQEoY7KVwjuJsQIWzNekiNKJU7IIjruSWjLNqw1Q3kWdTu354OxpVLKlSyhG/eNj3dPCTJ1FZSmLV0xeKglucq1n0zoz4XeiOyTYmSGBGsvNwdvoP3NeOrGPcmYR0Bb7/JvDjDt80Re3aDNMDYfZDVLaYBRsVM3vjRXdYilPAL2Az8s6tj4MAr/rcJuJxod+2k1w2WFzUCkFGiZP2rRYfwME6G+wUHlBq1ZFsojbPnEgdxiU5X1GTwR8zcYaGSSk/lx1tOYgeNEkGYZ3hNyEKvgK8/pGqM+msCBiTv2yiWCK26ZaJHZHFK/FRrVPuhMqR1/l03q6J1jrPIETFIU/qhuLJZTKjbLzL/elwpni7UVj7SrGMmYRcuJYOUp4sNJyU260HbVKN7UgkZZxygInemhjXNrYPoZt+H7vb3fay3GYNWOl9NLFDF6YjFTJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(8936002)(6486002)(8676002)(31686004)(54906003)(66476007)(66946007)(66556008)(86362001)(2906002)(478600001)(5660300002)(41300700001)(6916009)(44832011)(316002)(6666004)(4326008)(6506007)(53546011)(36756003)(2616005)(38100700002)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRkU1J0NXg4Q21wOWRaQmV2OGhBQUc3REhtN0g1RzV4aWhuVXArVHFjaWM3?=
 =?utf-8?B?ODdjSDNmenZhRUJ0L3haaTNKa1dXczlieXQrOERadWk2WWhPZlFkTUpybkdo?=
 =?utf-8?B?Zm5FanpEN3N0cHptZStzTGhjYVpma1pjdTBsNFJvYjV0b0YveHl6REVxdWFq?=
 =?utf-8?B?b0pHeTRzUUluNGFITmRSemEvRStaTmJVd04zN2x3bzVoZE0wTnVhRG9PTjJs?=
 =?utf-8?B?citSeVF4bGRzZmU5ZUxhVDd5Y21XckNGNTVOSmpGc3g2Ly9BOTZhSFBzbmJS?=
 =?utf-8?B?Qm9OTWRHZzBwVWt5VXk5OVJIcjJGcG13NnNQcGE1NEpqT01EaWRYNTZmL1pz?=
 =?utf-8?B?N1liM0VHQXBJR200eFdqcGgxbVcwT0pwVmZoakNBc0ZKbjRaU09FNkFzYTNS?=
 =?utf-8?B?SGZTbTBkdm1QQmljRnRJc3NvV3hHdUFqcnJWYzRnRXRtTCtQY1lzeGpURDYw?=
 =?utf-8?B?THJVaGpjRHc1TlZocDNsS1Q1cmVIV1pqRngwcC9HTEpNWVJXRXpML08zWngr?=
 =?utf-8?B?TVFsbTk4VEVpeGZreWZUb2Y0NXRYU0pBOSsrOWVVVFRYM0hxN0h4VE9WZ29C?=
 =?utf-8?B?WUZlUmVNdWtFdXdHelhjRHpTc1AxTEwrclBscmt5QjlodDdKR2dNRDc3bkYz?=
 =?utf-8?B?VVVZeDV2bW01M01LaSt2WndNbjNmNlczVzh5YnE1Sm5NUFkxekg1SFRvb1Zw?=
 =?utf-8?B?eDdyVm1rZnFXK2R3eVNPK1poeVJtUTAydG1PNFc1VWoxTW9hajR1b21RazMv?=
 =?utf-8?B?OWtkRzlXQzYxY251Wm90Qzh4Vk4zMVg3OGVjNk4vUjQrOGxoVWVZKy9qbUh0?=
 =?utf-8?B?SVV0UkMwckhzZkVNOEdBeFJUUmppSllDQkxMZ0ZTQzhVUWo0RmxQdjdESWV2?=
 =?utf-8?B?dW1nTGprNjEvZ3Ntcy9pYUdWb3FOdERMOHJoU2gxRW1BTDlnSzhta3lBSTcy?=
 =?utf-8?B?QlFVTUNlSWpWNUpTYitiRk5laWc0YUFBSGxGS2VqZFBRVlBhSlJjVzF0cVdT?=
 =?utf-8?B?d1p5cC95RGhUSjNUOHVYRndaQlV6MmZPSmxKTFNnRGQwSkVya2VyT2txTjdV?=
 =?utf-8?B?Q3cwUTNTVlgyUEZYZDZkU3dRdjNjK1FTRlhERldvTVNINkFnZ3BKbmYvUmFF?=
 =?utf-8?B?anRUbzBiZlN5YlNsOW9qZElzSk04aEpBRzNmNlV1RlZjeGdkZTVScDlCUTNo?=
 =?utf-8?B?RktJR0xHcWMwQjk4NlI4YnlrRUVJM05vUzZXbjMzQitZaWM3WUwyazBBWmFr?=
 =?utf-8?B?TWV6Y3VwYkdMaStZZkMvNzdLZ0xiY1lDQ2JRdWdaVDZnVVZZa3BYeFRianVw?=
 =?utf-8?B?V0xNOFlqb3JtOFJiSVAxUVYyRFV0ZXM5dkJxY2FRQ2VaUnpjTjhuajY5U2Iw?=
 =?utf-8?B?ZENWK1FiRFR5VzVlS2NjWVcxUFZhNU54a3hxZzdIaWJDbHZJQ3V3eTRoMWdr?=
 =?utf-8?B?RFYvTmJYWEVad0tRQlgydVJ1NTZFOXVoV0krWVJabm9BVzN2R0V0RG1vTkNt?=
 =?utf-8?B?TEhoZ1ZZQXdvKzFFdGl0Q1BOS3RuWDg3bzAwSm01TnlkV3pCRllJL1BuV3RY?=
 =?utf-8?B?NytMSVN4bmhkNHV2dUxYUlBTNFM0V1FMdk94L2gvM2VGeHZOSkU3M3Y5OUM0?=
 =?utf-8?B?ellzVmRZYlg4UERGSkllRzhnZHkyV1l1aXp4SCsrV0NVZzlrY2pvZ3FYcUlJ?=
 =?utf-8?B?SnhZMGR1dzFlMkhMN0RHL0xHcTF1bFJjSkNWZElobno4azQ5SFFyY09aeFFD?=
 =?utf-8?B?M3RpODFkZjhudVNteUFRNldaTUlsclArUE1PbHdVcVVuU1RjWHNPL3hqUzU1?=
 =?utf-8?B?dHRNbStQU0tsSkE0eDMrS08yYzJDZ0g3b3Q0aXdUQXFiWGNHbnZja3lzVkUv?=
 =?utf-8?B?d2duTkFMNjFjZ1NObnJNaExsZ0hkVDhzV0h1aXhGOHN2L0hwcEJjTTBNSWE0?=
 =?utf-8?B?QzFjclRtYUZGTmdFMFRPRXdhVEJkUy9ROWhSZDhyUUtUZjdqbURLbkRpdVRF?=
 =?utf-8?B?OVU5NXVVSERid045RUw2SnBxWm9FQitoOGNaTnFDeEZSOHlZZzlMeGNkY0Np?=
 =?utf-8?B?YjRMRGJKNzNqWTl6cG9GdE1DMWRFQ25IdlFLakxxL21HWEVZRno4Z1JpZkxK?=
 =?utf-8?B?dS82NTR1dTYzZllBVkxNS1M3MzAxdXkwTlpFeVN5c3FnZ0ZNTUNRVUh3c0gv?=
 =?utf-8?B?TERUVXFOc0Vsd2lqUTk2VTcyQk9jTTNvZjlpeFAzTEFnOUNXS1JwUkdIbHdr?=
 =?utf-8?Q?TLqaPZWpzv1nvxHfHIL4rPHC1m5BTU8W5/F16r5y2o=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cde2d55-2979-4fef-839d-08dbd700ce5e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:24:27.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a4levzTqCbCxmtZgzBcnAg36Bck/V6/AxoU089cMqOnZkDGgWMMAyQFohZGA/NLAv8zbou6ypyizFk/uf6sPTv+ikwW8m3w1iT6ugxwb0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.23 16:15, Jonathan Cameron wrote:
> On Mon, 23 Oct 2023 11:50:02 +0200
> Javier Carrasco <javier.carrasco@wolfvision.net> wrote:
> 
>> The current offset has the scale already applied to it. The ABI
>> documentation defines the offset parameter as "offset to be added
>> to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
>> obtain value in the <type> units as specified in <type>[Y]_raw
>> documentation"
>>
>> The right value is obtained at 0 degrees Celsius by the formula provided
>> in the datasheet:
>>
>> T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res
> 
> So base units for temperature are milli degrees celsius. 
> T = 1000 * (25 + (adc - 17508) / 60.1)
> 
> T =  1000/60.1 * (25 * 60.1 + adc - 17508)
> T = 10000/601 * (-16005.5 + adc)  
> So I think the maths is a little off..
>>
>> where:
>> T = 0 degrees Celsius
>> Tsens_t0 (reference temperature) = 25 degrees Celsius
>> Tadc_t0 (16-bit format for Tsens_t0) = 17508
>> Tadc_res = 60.1 LSB/degree Celsius
>>
>> The resulting offset is 16605.5, which has been truncated to 16005 to
> Interesting - the truncated value you have looks good to be but that's
> not matching with the resulting offset or the value below...
> 
You are right, there is a typo in the resulting offset and value below.

The right value is the truncated one I mentioned, which is the one
obtained with the formula.
In the case of milli degrees Celsius for T = 0 (milli or not does not
matter then):

0 = 1000 * (25 + (adc - 17508) / 60.1) =>
=> adc = -25*60.1 + 17508 = 16005.5

I will fix the value to use the one I actually obtained (16005)

Thank you.
>> provide an integer value with a precision loss smaller than the 1-LSB
>> measurement precision.
>>
>> Fix the offset to apply its value prior to scaling.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  drivers/iio/magnetometer/tmag5273.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
>> index c5e5c4ad681e..d22ca39007b6 100644
>> --- a/drivers/iio/magnetometer/tmag5273.c
>> +++ b/drivers/iio/magnetometer/tmag5273.c
>> @@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
>>  	case IIO_CHAN_INFO_OFFSET:
>>  		switch (chan->type) {
>>  		case IIO_TEMP:
>> -			*val = -266314;
>> +			*val = -16605;
>>  			return IIO_VAL_INT;
>>  		default:
>>  			return -EINVAL;
>>
>> ---
>> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
>> change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961
>>
>> Best regards,
> 
