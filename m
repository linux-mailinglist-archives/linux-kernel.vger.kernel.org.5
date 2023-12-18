Return-Path: <linux-kernel+bounces-4007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC8817694
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0991C222C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF049884;
	Mon, 18 Dec 2023 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oLFP6SY7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA23D54B;
	Mon, 18 Dec 2023 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpjdVAtFCzxfgKm4RtiyxXSKNSiGbyYOYu+ooH4ubvW5X3EBfzVEKhRS5lKMivoIPD8If8aAQBENuFYqt4VfHVSyMPtMB795G9B143oMz+nIupWpyY5+lWBvxUn3Tqy27YCcZcufVii8jZQmb6+7FtIORcGQF5ZUrdsg//g0Vhm45ItYS01G1marDrhAomFi2MsqBrAgj3oJaMkwJlHDZumjBjR4NhcXwTYwH8Hm5BfMEbIenTJoCnEiOiFhIGmTQK5yTN7XMqL9GqWkLWgSxHcTEZ/2Va/701Br5OrbGjp01HKFYrDgn75OFtd0baKckuORS7WGUcBOxXMHxef9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=407lErbnT4lFo3kzubD8JAffM6i1ShPDVJjyLfmECYQ=;
 b=bEk8Fn2BlpNPAEbO/EFIjIhd4ET0c19+AgeX8ll5uOD66BvG/3tvhA0FDKLU4ViDh492s3ZDGZvmk03rsYbzoNLpE6C0JU8YGQIyvNFkls0gT0uB1yoIlcOw0RjT19nr0aXl8P8m45h9rH2zZPla0e7NlP7uRO8H3uAWG3HHiXP5FWjZZL/jp9eSYudFb5zJgBYt0o1raux1QnheyRiMgOKwLBxqfgHZiZwND3BuvEzQh5O/JAMkhu5DkFkfugal/aBGT0zcepMvzTJdWNi9piCBk9elnzuziZBEKQfHMC64oWMioMp5/367hRKPUP/x5t43ylOwCVYYCQRn43RRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=407lErbnT4lFo3kzubD8JAffM6i1ShPDVJjyLfmECYQ=;
 b=oLFP6SY7y0eXKjwZeocTAW89MHTF9Gag9N7FpnRNOHfBZHwedh8SXixLC3RqRlsKLF5kMmqM1cZTdKkzkNBjsXmnUbts3dwimw3LG8r+6ASj8Fy96MZwASoJIPmBPWCpnnhzS6ahVu9VX/kndgY8897zQBnt7cphBQGDsuBw/7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by DB9PR02MB6569.eurprd02.prod.outlook.com (2603:10a6:10:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:00:12 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:00:12 +0000
Message-ID: <9469ccaa-d05a-1c9d-4350-841de7c03ae0@axis.com>
Date: Mon, 18 Dec 2023 17:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add ps high definition for
 vcnl4040
Content-Language: en-US
From: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 kernel@axis.com, linux-kernel@vger.kernel.org
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
 <20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
 <20231217141554.04c8863d@jic23-huawei>
 <45bb38c9-63f9-101e-60e5-36037699f11e@axis.com>
In-Reply-To: <45bb38c9-63f9-101e-60e5-36037699f11e@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DB9PR02MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: c3229f64-b992-467e-5be6-08dbffe26ac8
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+bKI1V9IU/MWm+VBJ5pxysQV6zQyADqOaENoE7s6Xatil8DbooUm31N9p2qDmCgzUV1PZ4GHT2GpVO6KfELaeBvIWhlHc9y3Ize72W4cyDLf/GXPiSvDQrfozP2z2l2GJseOsfY3FxpcYgOFrEXxo+AR19XWWUbdW/fjuDar/G5gx+xiuCMTMcKLD5LrbOfbYxjB4DQviFYEqo19r2S8iLYCY8zKPl5ye0EUDxqdNQsCcmahpbqNHB1uFh47PHLrnoKOGqvudnuQckMcdJrMZXrjy4hoXUdOb2S2jWEzc5KBYLW3GHCTYOTEOc0U8Pq8Xcn3Z9XlDVF5ToxJ8aai1CruVl09FolX2ycWHti6aiHYHpsHy0NoSaO4E3tkoWbIsDck8KYr9J4IhmXt99u56pfSxK9q18gtdh8DsLJ7jBnCMZT+JS7KmLmK9TLMilUpi6FHOW/049NyruncH7JtryHg9Qekga5DVB+NcCF6i4N3Bg0Zut/0FZ6sOh8DUSbS/zZxoMoqfzlgxZeCxVr6aN7LHCqdF+2tPLy0Q0dK6Tu55qE14ALy4+H+YCS/iMdevx3WLx20uQi1SELy+Xgy8AZnVB29TBBmA7vCZ/KibF1/rkpa7jUGXu95abNDK3awsTG1Z2wm7ZXk8duN+a/gA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(36756003)(66556008)(316002)(6916009)(83380400001)(66574015)(66946007)(66476007)(2906002)(8936002)(4326008)(8676002)(5660300002)(53546011)(6512007)(38100700002)(26005)(31686004)(478600001)(6486002)(2616005)(31696002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1sZURWczNxdk4yYVJZa09Xd3kyancxK0twd0l3Z25QeGVra2pORTY3WUVL?=
 =?utf-8?B?NkZlV1VvaDlKOXJEUTFiLzZTNTdsMFJGNUNHL1dRb2xESmY3dStzdys2T29s?=
 =?utf-8?B?bWhrRzZGUHZKUXlJcFpTNlUvaDNNSU9vZFFXTWJDMTVqMnpZcnA0WkRZNllo?=
 =?utf-8?B?dHAyZFRiaTlkOUJBUjYyNzk4dnp5aTkxRU9iV1AwdThPRFErMDNTM1Z6WUZO?=
 =?utf-8?B?Q0RjcnFzK1hnbDl4RitzMUpyaXpadzdmZ2xsem9GdFprR1htNUVHQUNldll6?=
 =?utf-8?B?YTcxZEJubmlCelZsNDROYWN0YlFFZVJpSk9zZThXWENQK3o1aTRpWWtodWFV?=
 =?utf-8?B?d1gzeWdaY250VWR6eUlXakxCTit6elBsSkFwK2tkZCsvQzd1V2MrSHpoTEtm?=
 =?utf-8?B?K1p1bGZ0TXB5T3ZZZ2ZCeUZ1elEvaUIrOWE0a21LVUgyZFd4VUx3Z092MThV?=
 =?utf-8?B?K09Kamg1alVEUkY1NFdTRFphUnJ1Z3JXYXpZTWJ0NFhjblFBU2c0VjZERmZq?=
 =?utf-8?B?d0tHTzRsdXRBYVdEandrKzJxdnIvSHZJOTRQRFFNNEJwZWd2VGlQeHBRdEdQ?=
 =?utf-8?B?eForVHh5R3B6YjVSdFJmTU1EeG1BYUtaZ3ZKeEZuNE5jdmlITElYZENMenRG?=
 =?utf-8?B?US9zVlo3OXpWRDBscFB2WGg3L2lISUFtWHRIMXd4ZUVVN243UWhBU3RnbjRR?=
 =?utf-8?B?aEtzYTh0MlFUVVprd1pFZU5jMnh4QkxnNzdXcmU3OUcrL3BIVkdUMFdQOTRU?=
 =?utf-8?B?bk9mN2FaMG5kMnJKbWJiN2xyR0FtSXRRSDM1NFBoR1U4dmJEdFZVQ21ML0pI?=
 =?utf-8?B?NWprdGJ6UDRPYVladzdDZlcyZ2lCTVhkOHM3VHhOT0JlMnUvS0tkdUltcjhL?=
 =?utf-8?B?SVpWaFlBS24wVERqKzdPYWY4ckkyVlBtazNhWUVzT3NQdjYyOGVwdi82cm9h?=
 =?utf-8?B?cnU0Mk9Fd3dla2Zvd0RxUjVhb1d3d2ZDUkVsYjdwclZ3RVVmWk43TWxkbkxq?=
 =?utf-8?B?cGcvb3BhbmZ4Z1duRkhVb1BaV3FXMVpkSFJnUExJNjBXUUx0UHNrZlVDdnY1?=
 =?utf-8?B?VlIrS0R4WDY0ckVVMUprNjEvVlV4NHpVOUhzZldBZENGbjVkMVcxUXZ4TG5w?=
 =?utf-8?B?cmU0MHVnOFVEaTltRHFJSXNUSFBSOGtZSUxvTlZoOHBXbFVrUU5jZjd0TUgw?=
 =?utf-8?B?QllkTnVHelhPV3h2SFJzY2NLajBVckQzd2cwakQrV2k5WlFhYU5QdXF5WDdZ?=
 =?utf-8?B?R0JCRlJrSFJ2Z05zZDVheUdvbVE4OWZTSlVjL3Y5ZG8rRC9FVnBkNlhaU0hY?=
 =?utf-8?B?Y3hKd01nK0tVMUozNERqcmJCbExveEppWll2MWY2dmZJUWs3cVNnd2xKWlNN?=
 =?utf-8?B?Znd3c2FVZnM3NnVBZjlUeW9Lczg3R08zamJranJuSkJPVlVyaG1RdW9aR3Nq?=
 =?utf-8?B?M0VoSlZRZVpjRFgwVXBvbzRvdDZjMUdlZ0RieDBHSEVvMCtwWi9tNGVKZ3N6?=
 =?utf-8?B?b3VneGpITjBwbjgxOGs4bGorLzE1dUlyTDBSYkxJc0tSUGs1dDgvMlNmdmgy?=
 =?utf-8?B?YlhCWmxSYjNITm9GSzhCQmNzMUo5T2lOWVEvd29BTnhudm1QVnB0QmJablVC?=
 =?utf-8?B?ZlppaHBrRTVxSkZrSjc3ZzdLeHcxU3NkNG5pOHRjSjJWMDBKRFhDUnlMVEF2?=
 =?utf-8?B?ZVN1YzhLdisyVUgyaUpqejRWUWtNVlVUeUMxV21zZE1TbUg5cEZudWtGc1FS?=
 =?utf-8?B?R3BLdjBTS3NkVWpxMTh1MktaaEdqa1pNZzE2OTI5MUdjTHk4QzVIdTA4OXBQ?=
 =?utf-8?B?OU54UFpLYUwvWGExRW8rSVVKVk1yMUpaYi9TdGxJbWlMYUgrVTRsN2l5MmVp?=
 =?utf-8?B?Z1EyTGFXaUsyanpaQVF3aTFyRUFCa1QvV1hLS2dwdDVncVRGNjE2SkZIc0hY?=
 =?utf-8?B?dW9DZlRzcmFQbnQ5Sk80ZG1kdlhFei9PaWs4b0loY0I0aFBBaG5kS0RMNUpo?=
 =?utf-8?B?cmNMMExqdXpaZm5lbitJZm9xNXZkcjRsaUpmNlBtejVMaU1hTFFuVnRlMXpr?=
 =?utf-8?B?ZHUxdzlqVzZnbjFraHFsVGpBY0ZjSmw4bjJuRi9SOUNKVVdhalpIUW5waEI0?=
 =?utf-8?Q?pP8GL01G0nxw0dxRSztPgVwt4?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3229f64-b992-467e-5be6-08dbffe26ac8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:00:12.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiLV7DYGh0MahoimCQShYDQawIdkRJtGjMWzVRpYSvzovhyla1ryj9g9jO2sRsarFGYmXL9Q8zalR32hgg/tKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6569

On 12/18/23 16:19, Mårten Lindahl wrote:
> On 12/17/23 15:15, Jonathan Cameron wrote:
>> On Fri, 15 Dec 2023 13:43:05 +0100
>> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>>
>>> The vcnl4040 proximity sensor defaults to 12 bit data resolution, but
>>> the chip also supports 16 bit data resolution, which is called 
>>> proximity
>>> high definition (PS_HD).
>>>
>>> Add read/write attribute for proximity resolution, and read attribute
>>> for available proximity resolution values for the vcnl4040 chip.
>>>
>>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Hi Jonathan!
>> I'll review this on basis the usecase is clear (see reply to cover 
>> letter)
>
> I'll skip this patch (see reply to cover letter comment)
>
> Your are right about the paired register manipulation. Better to 
> read/write byte instead of word.

Hi Jonathan!

I now remember why the register is read as a word (CONF1/CONF2). It is 
addressed as one 16 bit register where CONF1 is the low 8 bit field and 
CONF2 is the high bit field. It is the same address/code for both:

Register PS_CONF1 - COMMAND CODE: 0x03_L (0x03 DATA BYTE LOW)

Register PS_CONF2 - COMMAND CODE: 0x03_H (0x03 DATA BYTE HIGH)

Where in my case (PS_CONF2->PS_HD[3] is the same as PS_CONF1[11])

Kind regards

Mårten

>
> Kind regards
>
> Mårten
>
>>
>> The manipulation of the CONF1 and CONF2 registers in a pair is rather 
>> odd given you
>> only want to change one bit here.
>>
>> Why is that done?
>>> ---
>>>   drivers/iio/light/vcnl4000.c | 87 
>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 85 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/vcnl4000.c 
>>> b/drivers/iio/light/vcnl4000.c
>>> index fdf763a04b0b..2addff635b79 100644
>>> --- a/drivers/iio/light/vcnl4000.c
>>> +++ b/drivers/iio/light/vcnl4000.c
>>> @@ -90,6 +90,7 @@
>>>   #define VCNL4040_PS_CONF1_PS_SHUTDOWN    BIT(0)
>>>   #define VCNL4040_PS_CONF2_PS_IT    GENMASK(3, 1) /* Proximity 
>>> integration time */
>>>   #define VCNL4040_CONF1_PS_PERS    GENMASK(5, 4) /* Proximity 
>>> interrupt persistence setting */
>>> +#define VCNL4040_PS_CONF2_PS_HD        BIT(11)    /* Proximity high 
>>> definition */
>>>   #define VCNL4040_PS_CONF2_PS_INT    GENMASK(9, 8) /* Proximity 
>>> interrupt mode */
>>>   #define VCNL4040_PS_CONF3_MPS        GENMASK(6, 5) /* Proximity 
>>> multi pulse number */
>>>   #define VCNL4040_PS_MS_LED_I        GENMASK(10, 8) /* Proximity 
>>> current */
>>> @@ -170,6 +171,11 @@ static const int vcnl4040_ps_calibbias_ua[][2] = {
>>>       {0, 200000},
>>>   };
>>>   +static const int vcnl4040_ps_resolutions[2] = {
>>> +    12,
>>> +    16
>>> +};
>>> +
>>>   static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
>>>   static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
>>>   static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>>> @@ -880,6 +886,54 @@ static ssize_t 
>>> vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
>>>       return ret;
>>>   }
>>>   +static ssize_t vcnl4040_read_ps_resolution(struct vcnl4000_data 
>>> *data, int *val, int *val2)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> The field seems to be in PS_CONF2.  So you are reading a word and I 
>> guess that
>> gets you two registers.  Can we not do a byte read to get just CONF2?
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    ret = FIELD_GET(VCNL4040_PS_CONF2_PS_HD, ret);
>>> +    if (ret >= ARRAY_SIZE(vcnl4040_ps_resolutions))
>>> +        return -EINVAL;
>>> +
>>> +    *val = vcnl4040_ps_resolutions[ret];
>>> +    *val2 = 0;
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static ssize_t vcnl4040_write_ps_resolution(struct vcnl4000_data 
>>> *data, int val)
>>> +{
>>> +    unsigned int i;
>>> +    int ret;
>>> +    u16 regval;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_resolutions); i++) {
>>> +        if (val == vcnl4040_ps_resolutions[i])
>>> +            break;
>>> +    }
>>> +
>>> +    if (i >= ARRAY_SIZE(vcnl4040_ps_resolutions))
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&data->vcnl4000_lock);
>>> +
>>> +    ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>>> +    if (ret < 0)
>>> +        goto out_unlock;
>>> +
>>> +    regval = (ret & ~VCNL4040_PS_CONF2_PS_HD);
>>> +    regval |= FIELD_PREP(VCNL4040_PS_CONF2_PS_HD, i);
>>> +    ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>>> +                    regval);
>>> +
>>> +out_unlock:
>>> +    mutex_unlock(&data->vcnl4000_lock);
>>> +    return ret;
>>> +}
>> c),

