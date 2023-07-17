Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10C7558E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGQAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGQAkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:40:21 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2020.outbound.protection.outlook.com [40.92.50.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693BEE5D;
        Sun, 16 Jul 2023 17:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGg6mqyib2jc4j6k4lwMQZTz0yl417vhIHwE6TenBLWFROUN1q+oMSs7O/UmvGFF3ZMvHe7ueeurCVQ71DVhQNOegIDBc5Dqi3x5leSfJx3NkMQq5DSFztdPxEN5t7LjQt3JLPc0MVOS+Aglk0abbeeIEkghbAMDkVWt77hdiNUF82bsjrLy5P4R3bhkw2IzwYiurTrgpUtJoOzdKVhB9KSj/WJZ3/H/fG0gojmOsLxS0iY50tsPAslhYbEDlRah4XBWXHsnOHxrDbfp3xbZnbf4jBq45Rf7WiqlEpofsbdf+fL/h0ettojdaUsXuw3pdkpFR5d18/7oyJrovgle+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jZC8hejjNgpZODYtxZyhDHvZypgskUfVN9I2ujjQ6g=;
 b=bt6ExoqcrwPcyn+79gloyV6fgst1s+w/Cd2VlxNR1r4BZ04/7k8Hzu3x0QzGfui+QapcnF+CiBpb93JmWN028EWOVLM4TVWOt9idGJ6LMtvJmATdqKkh2Pw3+7nvQVpQqiTMNUkWNdQf1Pr1mLRxhBiCZkBRsV3n5ZWd+6wLGUbAw2vtfR9OvrkhFPgJdakI9/fd+Q5c2r5T0ERqwO+FpOhGoDEGe1UHVjwEtMUcehx4M1CwinkXzYcry1ODZsyozN+JuFQgBwcnqm/Gr/iF8/lfiP1uOMiOkhmn1T4xuUaNl4Ng2YOb/JXVcQz5WtqXAmISBtZr6w9aq/9JZ3tB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jZC8hejjNgpZODYtxZyhDHvZypgskUfVN9I2ujjQ6g=;
 b=WiNK8iD/eVL9f5+sE5Qhp68fDI12Z0n/HmG2OH6I0AJNdwQT44S6Yyxi1Fb5V6VGYiH5KDUcLE++R/dh9pVohqeJ9lezBhCF5FHl5/cx54TnV9k+RyavXTu7pk4oWzvx+xxqB5sffTz9FpfUWcdsbn4fqnPn19RtfewWhdX3Jd7F1Jhu5q7OdurmqXrWge7rQlSJRAg0qwzZRkisjQJMsWjvGRwDnSyMaPbt+J1W8sAeu4n9XMdYbz2fHtLXKrXLAoOgjSm4eiO1C34Lxbonaud6m5SDbEnm77BwpcwLL3j2kG2KYb/lPl5CPD9LFg4t8gfSemUvs4UoXFcJXdHQmw==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by PR3PR10MB3915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 00:40:15 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6588.017; Mon, 17 Jul 2023
 00:40:14 +0000
Message-ID: <DB4PR10MB626128364C9D170DFFAD0A48923BA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Mon, 17 Jul 2023 08:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] staging: iio: ad7816: add iio interface
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <DB4PR10MB6261ADF6C8845AF66AB292989232A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <20230716144024.30ded663@jic23-huawei>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
In-Reply-To: <20230716144024.30ded663@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [xVndfjYOWO6+m8n55QCEIy5egnUjcVPb]
X-ClientProxiedBy: TY2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:404:42::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <c7c8d62c-326f-9c72-f205-7efc6ce2ad13@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|PR3PR10MB3915:EE_
X-MS-Office365-Filtering-Correlation-Id: ae347ce2-35f0-420f-9f3b-08db865e6291
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/+Jivz/2BFnS7xPkaTiPTlVoZa2rDTIok2YXf/bminAtdHgqW1mUjxpmsdR+dtIdir9fZ0SGye1Hq12r5tuGQf5W3njHUZUgbyHULU6PJSe5hfBGGYBkS2pIYpiB1JKNXiuMdTNKnFDZka0hWdHdK/cRYGEJ2r7d3UUIX5tdhRR5TcsYl6guB1/I9JmkjuI1X3Jeg4qbenPGOWeAW/VlV5LAcdznYGTkgeIInNWCvrCJex8Pv/++I342jgAHTEXHHfJ8qLkt/AwHgQk8SE7dM+F/qwsaXHsfTacWIbIarJE/XxI2AchSWuYAKV2e8SXAkESZYdfX6fNGdLGBUiHVVlHFZLIllEGa6IaW/0nSP+HPaSF1yRayNuWlK48lLpZ26GEldBTC993WFGgMQRLABwD9JbQORXsdhqTS9BjkugSluBzQTjFo3TDLjxqSSWG+b3HySNgNaYLlsM2hVec6QmYsvvEs/1gSURgBeV6RbVjB9fRGND+1f8r9iOuk0hsAxyPsNAupML9X2n9PvV/LFLg4pLqkAdotJop/jKvcFLk+Ix2fnsJicuASxhXCaVF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0J1b254TnhReHRXakw0QmZkSm53MXdzUklpRGwrVEVhdnJMeTl6WUlSVS8r?=
 =?utf-8?B?YU1oNHFLUzBIS1VVcnhMZzFhenBuSzVtNkJpSGZ6ZXdaT1RQdGU0bFl2MXdY?=
 =?utf-8?B?WThHRTZKeCtJczFOSC9HbGRDUE9IVzJOUkpCQlVuR1NzZjBMY2I0NGhNYjNy?=
 =?utf-8?B?akovVFExb3VKdFlWcFc4VnB4THArbkdYUnc2b2ZCVjB1WGo5RXJKbm50aWlv?=
 =?utf-8?B?NUR6RTZZcXZzZDF5VWxSd3M5Yjc0ejFZdG9qRVlmUFF4bTNCOXBLUjVWZWNo?=
 =?utf-8?B?U3F0d2k2TndRR0tHaE1uUTV3ZjVROWswUnNaaWJ6RnQ0TUFhSnBhSWY2ZDJT?=
 =?utf-8?B?Mk13c2xrcmNRZGR3QTduWGN2UmluTzBSWnViai9YQzhGaHhiRWNsWVd5YWR6?=
 =?utf-8?B?Wnd5cWlXd0Jkd0t3eHdTRXdSd3ZaUFpOWjRWVnl0ek1xN3JIVW43OGZhbUs0?=
 =?utf-8?B?b3p0SWdSRXVIcmV3eFBDRzF5a1JRNnQ4YmtpWksvZzFYUzI1SEVnckw2c1h5?=
 =?utf-8?B?VE1vUU0zSWYzWUdCcHdpTzlYZVhleXBzcG42V3d2ZWlhNmNPQ0xGTzBhQ2xL?=
 =?utf-8?B?dElhdTdMdFhwVklwMXRoY05YeHZXUUZsZzVvS2V2MmJ4RzBFdmtYNUptVFpr?=
 =?utf-8?B?U3VLOENyMHRHdjEvRmUvSTRJNkx3OHMrU2VJOXNlM281ZDA3ejFvTXc4eFJ0?=
 =?utf-8?B?T1RqemtZcHVtMm1uWkxJSjhwRmdMZEpMdE1XdzI4bFE2R2plaldPdUJVeGx4?=
 =?utf-8?B?ZGFkK1BVQXVpTzZGYTB2WFh4dmNDOVkwQURkdmIvOU94YWhwUXRIdnd5VDNL?=
 =?utf-8?B?YXBRbmV2WVdwbnh4RlI5SDdaWEFURndTTHZ4UjIyOW1ITXhQK3ZGZUZ3aVBQ?=
 =?utf-8?B?K3BKTHBtUC9JOU5iWnVKMldiSTFoNlJMbDE5MWVVWXpRbXU5QmV1QVM5cEx2?=
 =?utf-8?B?ekRNbXdGM1hJVkRjME14UnpFSXdSVUlRNEdHYXpieUFjS1piemRtT21XWVZk?=
 =?utf-8?B?WXloVHBsU3MvQTk3R3dYZ2w1QzkxblBHWTVsQXpqb29QS0cxa2tGT2J0L00w?=
 =?utf-8?B?cWFXRUl6cHhzV0w0RVVoRGJiSHp0SUhEdFBMb09HQkdyL2d1VlI1YUFzN3B2?=
 =?utf-8?B?RmRiRGpKeGxMV0k4TXpDZC9ybk56MUxhTEVvNXVYdHIrbnJ0d2o3Nm5YdENM?=
 =?utf-8?B?NDlXMVZ0T1BVNG9Lc0s2bGlEK0kvQ3BiV1YzU3JXQ2V5UDE1VHdMVmV0T2Yy?=
 =?utf-8?B?TGx5bTY4dGw4V0MyUXNBRU1JMlIrZ2NyeWFrUkZFTFAzYzNTWlRNYjFDTGR5?=
 =?utf-8?B?M0xSYTBaRHArUUhCTmN5cnFEVFY3VGVvSVRRelhnbUIwU2tyWDhMZGlJblpn?=
 =?utf-8?B?WUw0L0NRcjRrNUFyY2hmRVpTaHBvZ2VSY2FtbVZWbXZaSUF2RmlRaWJjUllK?=
 =?utf-8?B?eWtPdlVCZHZkVk44c1ByeVgwbmhlZ0NCa0liZEgyakdvUkxaYWFVOWEvVFY2?=
 =?utf-8?B?Y29tdUxldUFJTEFCQ2lBSWpXcE1MVlpVQjUvT283em05cTl0S2FLWnNsc0ta?=
 =?utf-8?B?MjhCWWlZZFBuNGhKdE9wVHdGeGttSW9pOFdwMVVUUFJTM2lBMy9QLzRrS1dw?=
 =?utf-8?Q?GWN3Fnr0yZjDUejfWFjOcBYafNDs+SssY8zSLtk3CmxY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae347ce2-35f0-420f-9f3b-08db865e6291
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 00:40:14.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3915
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/16 21:40, Jonathan Cameron 写道:
> On Sun,  9 Jul 2023 00:29:58 +0800
> JuenKit Yip <JuenKit_Yip@hotmail.com> wrote:
>
>> add iio interface for 4 channels, replacing the previous sysfs
>> interface
>>
>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> Hi JuenKit,
>
> Great to see some work on this driver.
>
> A few comments inline.  Mostly they are about the fact we can't unwind
> this part of the interface without dealing with the other use of the existing 'channel'
> attribute.
>
> This is a great start, but need to jump forwards a few more steps so that
> we don't accidentally reduce or confuse the existing functionality.
>
>
>> ---
>>   drivers/staging/iio/adc/ad7816.c | 122 +++++++++++++++----------------
>>   1 file changed, 59 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
>> index 6c14d7bcdd67..8af117b6ae11 100644
>> --- a/drivers/staging/iio/adc/ad7816.c
>> +++ b/drivers/staging/iio/adc/ad7816.c
>> @@ -162,64 +162,17 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
>>   static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
>>   			NULL, 0);
>>   
>> -static ssize_t ad7816_show_channel(struct device *dev,
>> -				   struct device_attribute *attr,
>> -				   char *buf)
>> +static int ad7816_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val,
>> +			   int *val2,
>> +			   long m)
> Probably better to rewrap this to get closer to the 80 char line length.
ack
>
>>   {
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>> -
>> -	return sprintf(buf, "%d\n", chip->channel_id);
>> -}
>> -
>> -static ssize_t ad7816_store_channel(struct device *dev,
>> -				    struct device_attribute *attr,
>> -				    const char *buf,
>> -				    size_t len)
>> -{
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>> -	unsigned long data;
>> -	int ret;
>> -
>> -	ret = kstrtoul(buf, 10, &data);
>> -	if (ret)
>> -		return ret;
>> -
>> -	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
>> -		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
>> -			data, indio_dev->name);
>> -		return -EINVAL;
>> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
>> -		dev_err(&chip->spi_dev->dev,
>> -			"Invalid channel id %lu for ad7818.\n", data);
>> -		return -EINVAL;
>> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
>> -		dev_err(&chip->spi_dev->dev,
>> -			"Invalid channel id %lu for ad7816.\n", data);
>> -		return -EINVAL;
>> -	}
>> -
>> -	chip->channel_id = data;
>> -
>> -	return len;
>> -}
>> -
>> -static IIO_DEVICE_ATTR(channel, 0644,
>> -		ad7816_show_channel,
>> -		ad7816_store_channel,
>> -		0);
>> -
>> -static ssize_t ad7816_show_value(struct device *dev,
>> -				 struct device_attribute *attr,
>> -				 char *buf)
>> -{
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>   	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>>   	u16 data;
>> -	s8 value;
>>   	int ret;
>>   
>> +	chip->channel_id = (u8)chan->channel;
> Can we keep the channel_id local?
> It is used for over temperature detection (OTI) but that needs separating out.

ack, maybe need a another commit.

channel_id may be removed from ad7816_chip_info

>
> Given you'll be breaking that connection I think you need to deal with
> both the main attributes and the event ones in a single go.  Thus removing
> any hidden usage of the last channel touched like you have here.
>
>
>>   	ret = ad7816_spi_read(chip, &data);
>>   	if (ret)
>>   		return -EIO;
>> @@ -227,22 +180,21 @@ static ssize_t ad7816_show_value(struct device *dev,
>>   	data >>= AD7816_VALUE_OFFSET;
>>   
>>   	if (chip->channel_id == 0) {
>> -		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
>> -		data &= AD7816_TEMP_FLOAT_MASK;
>> -		if (value < 0)
>> -			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
>> -		return sprintf(buf, "%d.%.2d\n", value, data * 25);
>> +		*val = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
> Use masks and FIELD_GET() though that change perhaps belongs in a separate patch set.
ack
>> +		*val2 = (data & AD7816_TEMP_FLOAT_MASK) * 25;
>> +		if (*val < 0)
>> +			*val2 = BIT(AD7816_TEMP_FLOAT_OFFSET) - *val2;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>>   	}
>> -	return sprintf(buf, "%u\n", data);
>> -}
>>   
>> -static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
>> +	*val = data;
>> +
>> +	return IIO_VAL_INT;
>> +}
>>   
>>   static struct attribute *ad7816_attributes[] = {
>>   	&iio_dev_attr_available_modes.dev_attr.attr,
>>   	&iio_dev_attr_mode.dev_attr.attr,
>> -	&iio_dev_attr_channel.dev_attr.attr,
>> -	&iio_dev_attr_value.dev_attr.attr,
>>   	NULL,
>>   };
>>   
>> @@ -341,10 +293,47 @@ static const struct attribute_group ad7816_event_attribute_group = {
>>   };
>>   
>>   static const struct iio_info ad7816_info = {
>> +	.read_raw = ad7816_read_raw,
>>   	.attrs = &ad7816_attribute_group,
>>   	.event_attrs = &ad7816_event_attribute_group,
>>   };
>>   
>> +static const struct iio_chan_spec ad7816_channels[] = {
>> +	{
>> +		.type = IIO_TEMP,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +	},
>> +};
>> +
>> +static const struct iio_chan_spec ad7817_channels[] = {
>> +	{
>> +		.type = IIO_TEMP,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> This would require the reading presented to be in the units defined by
> the ABI (Documentation/ABI/testing/sysfs-bus-iio)
> Can you confirm that these are all correct?
I will upload test report
>
> Note it is very unusual for an IIO driver to present all processed channels.
> Superficially it looks like there might be some appropriate conversions done
> for the temperature channels for them to be in the right units, but nothing
> at all is done to the voltage channels...

In fact, I hope to set voltage channel to RAW, and leave conversion to 
users.

Is it a good idea?

>
>> +	},
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
>> +		.channel = 1,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +	},
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
>> +		.channel = 2,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +	},
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
>> +		.channel = 3,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +	},
>> +};
>> +
>>   /*
>>    * device probe and remove
>>    */
>> @@ -367,6 +356,13 @@ static int ad7816_probe(struct spi_device *spi_dev)
>>   		chip->oti_data[i] = 203;
>>   
>>   	chip->id = spi_get_device_id(spi_dev)->driver_data;
>> +	if (chip->id == ID_AD7816) {
>> +		indio_dev->channels = ad7816_channels;
>> +		indio_dev->num_channels = ARRAY_SIZE(ad7816_channels);
>> +	} else {
>> +		indio_dev->channels = ad7817_channels;
>> +		indio_dev->num_channels = ARRAY_SIZE(ad7817_channels);
>> +	}
>>   	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(chip->rdwr_pin)) {
>>   		ret = PTR_ERR(chip->rdwr_pin);
> 	
