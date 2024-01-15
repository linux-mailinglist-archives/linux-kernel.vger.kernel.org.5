Return-Path: <linux-kernel+bounces-25865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB882D6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083A01F21FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA490F9D1;
	Mon, 15 Jan 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CqxB/eUX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333CF9F5;
	Mon, 15 Jan 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTU3n83ePgNo7eM8+zwzsjTZ2lBjrSiBcnUHjXjhHfpWpCjvCZKplcREOFSLR4cpn2APHOTmy8DHO0UErAhgC8pmLR8Our+xUuQN7ybhN1VloX+aDCdgnYC+Y0DMWB/Bc+ZfU//usVwM1pZ8F91s0/V6+LnNm+zkwfVp/nNU4NULBMBb3gYTOTkmtIyWFqIJNnqGp06bYXfce6UZGzJOr5/tXJMkT7v+eOSyLspwjgf25ioE/STojIzr1jkzI8JG2mTuwZ3rvf10usbguYHpKWiKXMTDEF5LLeEOzHY3Q5BRz6wJVttpMXSIrcSmwa4jtLYEAJoTFdKhgi428uGKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYM4I+QZRJz4iiQXato67OXo+KITOKVVazRHTR7K+VA=;
 b=GXB6CrtnfAzHk6zgNHfAyTmnth7SMD/hvytPvSWTMlom0nbMUcl2OFEOcycstufhYKVfsv6B5vSG5XExedl9W9/cSvmo1KHOkA11FG0qjAcbFFvPKt5pMFGVQJGrSPNXSlTDEraztCCfskic81/i5zL1q7tni1wh2G/KUptUvue5ytVuLEuZR5XGTofXTUAiYnz9bFPbk2Acz6zWkf/bVlTgLlpwc1/qtWzudBFHigKEMbPh1ngLHy1JiaqbYz5JKytclSfy2Oi/IaSX4KNHM2WDL31ghHSojDFQJ3XjtvnqT7woatmM39gIb51CunQjiQ1KY/6G29Vml0+5E30Wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYM4I+QZRJz4iiQXato67OXo+KITOKVVazRHTR7K+VA=;
 b=CqxB/eUXnlso4pN0mZrS0Wb50+8ZP69Gu2oUPmEiGAOnvxH9eTCtqphonQABj4OZEDwWFE3pjGNLqDGfiIm71r1n3krHn87Lo1pr6KfaPlyGadpJJgrqswqmDsjqjNplXgsU/PVkXchyC1bYcxiyYRny8Ewjv/YzKEgulAAqG9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by AS8PR02MB8415.eurprd02.prod.outlook.com (2603:10a6:20b:529::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 10:12:19 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::9f75:d067:b196:7c34]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::9f75:d067:b196:7c34%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 10:12:19 +0000
Message-ID: <94987a74-0ae2-8da5-735c-92c4da1fed09@axis.com>
Date: Mon, 15 Jan 2024 11:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231221-vcnl4000-ps-hd-v2-1-1b6790d30ae6@axis.com>
 <20240113150738.0de92b7f@jic23-huawei>
From: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20240113150738.0de92b7f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::17) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AS8PR02MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c927c0-8b2d-422d-9dd9-08dc15b274e0
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4svpQHKzJ0CfaH4eaectwmE4FXNe0cbqTPri1EFJ4Rc8/4oq+PsmJ4jWo949vMIa3+3ftpt4ZBHQfjxDoFSelBZ1AvnMrvxMzGbLh8x1FK+2wCMRvVD4UqKkKKVpA8dM+B1C+NRTrK0Y5+vrKGIIJQaF8aV8X0NZrBzFwH4/VROrE5ekc273ba+Miju+NvN3oUtglnORVY2bgtQ8qfFqY0SR7puvrFP/gTK6wlVK6PLLCuIMPQP5yKdO9QU/ZK3PPbxEtEACksR/ZqXu5wvH5Gw64Af6Ru7SSG/IUJfTn1IBJgQoLAafgTIs6IhH6u7lO5lQXWnUZf5WuZd/qSIPAVEHx+hO8AGysQMF5bnuN7cpYqeXYkdFUbfvCSEr3/ozu2q6TbmOb4IIrWUw5VzgMffbokUpbUdcHJtPifq/5qjiLzbqGTY3ziCZnvnz9yDU75r9ArpwAaVL3MN4fyRI9tbphZ7a5YNYipjZuVdxq/FRR9teDg3mW8JLoEqrn15grvV/7QOECocS3iPb6SpVI7Z0cEQ7ZrgOfaXztOOFrwKKbDNt+/koczaisRksjFJWWsU9nz650f3hPOVFj4ZRbL+mnTr7LjiLR94u5odG6f3T4yebtx4yUtVE3PXjOZHg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66946007)(66556008)(38100700002)(66476007)(110136005)(31686004)(6636002)(53546011)(478600001)(6512007)(316002)(966005)(8676002)(31696002)(41300700001)(6506007)(66574015)(2616005)(4326008)(6486002)(26005)(107886003)(83380400001)(8936002)(5660300002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hRLzNIMGJzcjJ4NnJZYmQ0eFcwQWJrSnRDcWZHOC92aFlJdzFFbDVHakxQ?=
 =?utf-8?B?VXYrajdDcWRvaGo4ZjhMYzBHRzdkT0pUQWJyckxTNmVHTGF6NzUxQzEzMFJk?=
 =?utf-8?B?bWp2T1I1VTR6djlNSkJoaXlIeWFvSzhtc0tZdEFaamlGQWFzbkJUL25jakk3?=
 =?utf-8?B?bVc1dUp3dmFsVzlraUlSQnhlc25nYlRkbFppcHluT1VoOWRUZUJ3b0xvL1Vr?=
 =?utf-8?B?V2U2Yks0L2ZJYXJkckJDR2cwMEpkcHdCV041KzZMdGJLQmxoRkhFZFZzdmhx?=
 =?utf-8?B?TjlaOUp0U21La25uVDErVmRaSkM5VkFqQjJ3NS9uZTJNZDFVdXJwT3RDWGJN?=
 =?utf-8?B?K0Z4NE5HVFdLaGhNSXlBWEpzYmJsK0k3SzJKaEJxbm1TN2N0WUg5M3N2RnRM?=
 =?utf-8?B?SXB2cDl3dmdhOTgwamgvbXhXbmNjNENZYkFNdVdJb3dHTmxwdGlYdnh6eW5Z?=
 =?utf-8?B?NlNmVURFcUYrajMxTWYwb0NsM1JJallMTGd1QXora2dQNXZlN2tIb0g5L210?=
 =?utf-8?B?aU8wUFlFSVRRUVRFV1ZTa1NHQ01HYnpRUC95K1RJOTl2ZFdqd2tJSE9TbFlQ?=
 =?utf-8?B?SGRnYlEvTTJQVzY3bnJRSVhEUG85VUt2ZkdMaXRSN0c2LzZEZmFOam56Qy9p?=
 =?utf-8?B?UnIzK1ZDM3ZrR1NJdENiWGtuRHlBVEpKdkdxQm50YVZianREWnRzdXlwZkxR?=
 =?utf-8?B?ODdHcVpyUkkxNkdaKys0QXA2ZUdJSm5XYUFIVzVFcW53QWd6NVZhK2RydTFo?=
 =?utf-8?B?UVlJQ2M5QllNRnpIbER5VnB3WEVlRzVjTTF5bHl5OEJGR3RRaFF5NjhRTVBQ?=
 =?utf-8?B?cDZCajkxM2VzNm9uOHRNaFBYbkg3cUltTzhVNFMyc0pFNkNta3dYeHlMenVh?=
 =?utf-8?B?Y1U1MFBna25aNmZ3Rm4vNW5DNDQ1RndHUG5UWTcrNGRqd1RGYVYydkIveHdB?=
 =?utf-8?B?eTdzSUpES25wbi9Zc244R1hHMUQyTjZGV0h2TU82WGlKbHUyeC9oUFAyendL?=
 =?utf-8?B?cWRmeDdYc2J3SThjczA5QkFEb0FQTlBXcjU1OFllcHViclQ4NFBVM3RPUzVQ?=
 =?utf-8?B?TlBZblF4Uzd3YVdWL0FwWXREZVpkYUZnenlKZHdYT0p5eDlCYkpZVi9LV1pP?=
 =?utf-8?B?cCtCNFMrQnRIYkNDWWx3OUpwWXp0Y04yVDNnaUMzdVNjVm4yZ2ttVUVvWFlV?=
 =?utf-8?B?a0xJMS9XTnVaOG9ZaEFpbFUydzRUWkt0N2lyUHdUckpyUFgyTnRKTG5NRUN3?=
 =?utf-8?B?VmFzbHhlL205TDNSZ3ZMV1QyZWhKdXZhdXJFNS9HdTYvRUFZa1VaNVV1SFpa?=
 =?utf-8?B?R2l0d01KVUlOUytZMUxZWnlCT3JTL08yZUlFNHFEaTdmSEZyKzNnMkdKMGlG?=
 =?utf-8?B?RlY5VVRITGx3NStyL1k0SGhHTXZjaXpvV05BU0RpalhnUUNYZWE1Y3Z6aE85?=
 =?utf-8?B?SlVFYUdqWHRSZGJpcnEwc0xOZnFPa3NVT1ZBSittaW5ueWtEZEdLWlhQT0M4?=
 =?utf-8?B?ZnpSeFNsRVcyZENIUUtWN1gxby92S1ZKbi9ueE5CUnIzS1A0VXR2ZHRmcTlj?=
 =?utf-8?B?SkVJNVNBU3NNWVpsOWg5UUZrcjZaNm5jcDVYKyszcWlwT1ljdFF3RWgzeW9Y?=
 =?utf-8?B?eVNSbExBd0owa0tHQnVrdWhsZzUxNmNrbkNQYnR4V2JkNC9wWVRqWC9wUlIx?=
 =?utf-8?B?UGZ1dVNsK0lBVnd4eklPLys3WWRERXdkUlBMLzhjSmsxUE5SaUVQckRZWk9M?=
 =?utf-8?B?bDlYVnNyVFR1VExtd01jaFc3cm9HWDRQRzRLSXFhNWNEam9SWmxJWTRnQnRo?=
 =?utf-8?B?MGtnUE1xQkNpdHNTVVpoTG1nTnRoUGkremNaMHpxUERqTE5TNm5lL2FDaElX?=
 =?utf-8?B?NjJrZzhkelhkdmk4Vm52R25NWHpWVWxLY0N2RElNVXByL0FHTnZXQ0Q5My9L?=
 =?utf-8?B?Y2ozdzJCU2QrZVVqS0k3SkpORm41KzdIeUE5eG5BWDlaaWpURlA2Y0pEUGV2?=
 =?utf-8?B?Q3lRQ0gweHhlWDhDRTJzdkhOR3Y4Rmd3TlNESXMyL1hCWGZPaUN2QUVraWZL?=
 =?utf-8?B?VFVML0JQeEZhcE9UN2dTdVFSSnY1clVDRFJySmhpdW5NWVJiL29GT0N6dDg4?=
 =?utf-8?Q?5p+Itcjz55y95xgsy3fpTqmgT?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c927c0-8b2d-422d-9dd9-08dc15b274e0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:12:19.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEuUvSbsTuFxodziinqLCWYw5cdtmYl/HR1UlVyZhLofQbO9jE6YV90wpABXlKWSKfIWZfS4rCD2CJwzMv0YjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8415

On 1/13/24 16:07, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 13:58:07 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
>> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
>> resolution, but the chip also supports 16 bit data resolution, which is
>> called proximity high definition (PS_HD).
>>
>> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
>> all data readings. Please note that in order to preserve the 12 bit
>> integer part of the in_proximity_raw output, the format is changed from
>> integer to fixed point.
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Hi Mårten,
>
> I don't understand why we'd try to carry on with using the device if
> the additional register accesses fail.  Just fail the probe, the hardware
> is broken.
>
> Jonathan

Hi Jonathan!

Fair point. I'll fail the probe if the register accesses fail. It's 
unlikely that the device would work if these fail.

Kind regards

Mårten

>
>> ---
>> Changes in v2:
>> - Update registers for sample rate to align it with 16 bit sensor readings.
>> - Change sysfs output from IIO_VAL_INT to IIO_VAL_FRACTIONAL and scale by 16.
>> - Link to v1: https://lore.kernel.org/r/20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com
>> ---
>>   drivers/iio/light/vcnl4000.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index fdf763a04b0b..a078c573131e 100644
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
>> @@ -114,6 +115,13 @@
>>   #define VCNL4010_INT_DRDY \
>>   	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
>>   
>> +#define VCNL4040_CONF3_PS_MPS_16BITS	3	/* 8 multi pulses */
>> +#define VCNL4040_CONF3_PS_LED_I_16BITS	3	/* 120 mA */
>> +
>> +#define VCNL4040_CONF3_PS_SAMPLE_16BITS \
>> +	(FIELD_PREP(VCNL4040_PS_CONF3_MPS, VCNL4040_CONF3_PS_MPS_16BITS) | \
>> +	 FIELD_PREP(VCNL4040_PS_MS_LED_I, VCNL4040_CONF3_PS_LED_I_16BITS))
>> +
>>   static const int vcnl4010_prox_sampling_frequency[][2] = {
>>   	{1, 950000},
>>   	{3, 906250},
>> @@ -195,6 +203,7 @@ struct vcnl4000_data {
>>   	enum vcnl4000_device_ids id;
>>   	int rev;
>>   	int al_scale;
>> +	int ps_scale;
>>   	u8 ps_int;		/* proximity interrupt mode */
>>   	u8 als_int;		/* ambient light interrupt mode*/
>>   	const struct vcnl4000_chip_spec *chip_spec;
>> @@ -345,6 +354,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
>>   static int vcnl4200_init(struct vcnl4000_data *data)
>>   {
>>   	int ret, id;
>> +	u16 regval;
>>   
>>   	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
>>   	if (ret < 0)
>> @@ -386,9 +396,36 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>>   		break;
>>   	}
>>   	data->al_scale = data->chip_spec->ulux_step;
>> +	data->ps_scale = 16;
>>   	mutex_init(&data->vcnl4200_al.lock);
>>   	mutex_init(&data->vcnl4200_ps.lock);
>>   
>> +	/* Use 16 bits proximity sensor readings */
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret >= 0) {
>> +		regval = (ret | VCNL4040_PS_CONF2_PS_HD);
> Trivial but those brackets are unnecessary.
>
>> +		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>> +						regval);
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_info(&data->client->dev, "Default to 12 bits sensor data");
> Silly question - how can we get here?  If it's a case of a read or a write failing
> then that's a critical failure and we have very little idea what the state is.
> If that happens I'd just fail to probe the driver rather than carrying on with
> 12 bit assumed.
>
>> +		data->ps_scale = 1;
>> +		goto out;
>> +	}
>> +
>> +	/* Align proximity sensor sample rate to 16 bits data width */
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
>> +	if (ret >= 0) {
> If the read fails, something is very wrong. Fail the probe.
>
>> +		regval = (ret | VCNL4040_CONF3_PS_SAMPLE_16BITS);
>> +		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
>> +						regval);
>> +	}
>> +
>> +	if (ret < 0)
>> +		dev_warn(&data->client->dev, "Sample rate may not be accurate");
> If this fails, fail the probe.  Don't try to carry on anyway.
>
>
>> +
>> +out:
>>   	ret = data->chip_spec->set_power_state(data, true);
>>   	if (ret < 0)
>>   		return ret;
>> @@ -901,8 +938,9 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>>   			break;
>>   		case IIO_PROXIMITY:
>>   			ret = data->chip_spec->measure_proximity(data, val);
>> +			*val2 = data->ps_scale;
>>   			if (!ret)
>> -				ret = IIO_VAL_INT;
>> +				ret = IIO_VAL_FRACTIONAL;
>>   			break;
>>   		default:
>>   			ret = -EINVAL;
>>
>> ---
>> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
>> change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7
>>
>> Best regards,

