Return-Path: <linux-kernel+bounces-147435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79368A7407
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2191C20C04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE349137C23;
	Tue, 16 Apr 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iari86po"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C52137753;
	Tue, 16 Apr 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294012; cv=none; b=lVXDM6DrW3SJyr7/SanjBa/c1XaYmDl9+RYo7lJCrrnEAwg1lP1ceTO6OaguCrM1fQuU/C/S7txrRknbKJZVBUP1DquFjfPvgrRoBa/JINl+H4v8SpUo6PKnfvFo2pcDzQDs8dUnVMaOZO4LazNszOtGRK86AuTgwclFDSaje9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294012; c=relaxed/simple;
	bh=daCa0PJyCtO6OpxujUpgj/hiPPCNOkXna5kNFlTHBGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT44LvT6MDujXu8pw99OkDtk07JDO0FRdJ21dWuQLrJKamRPIzS2768hsH7XMRZVvV9bqnTxp+H2tcuBAdlLECVvDYGFsuCo1GFfz360/vpSsjlk4jFiypCk2d3JxYeoW9MZdmu7L27TJXJ3IJOlEFaf59Ba+KIVFO3xJ6dtiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iari86po; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso5569261e87.2;
        Tue, 16 Apr 2024 12:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294009; x=1713898809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivM//Z6XMzCj1R+l3MkcdtO0zz8Nry3WAZHrFBc/SX0=;
        b=Iari86poMINYH22/S8QaKhXr4tJPu7NZu91K/RX+yetKfdfXqXJPdXXkG8pOU0s7jd
         OuLFSy1uATSzPogZ+4Sc2aY2vx34LYKEzYscd5KSd/P5kzxWKkVB80VmpaklqpoC5qOB
         Y8O8VgY6vaUOrpxBaWSyNeEstNwU/mWb6LK5ll5tle00FbabjUnnk9dsitID0fNdDitr
         YmIy4Z+iTxdqNWPR12sGAn78SsBkGry4PLkMaa6zRxZbYUXIZVjS7M44nJWrkvofB9Zo
         ohAj1DMzlZTXYL3t9AR0AxXuqx7968fKZQK1TBfCOwbad8YplP7yeN+hp2YpliFY6il2
         1SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294009; x=1713898809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivM//Z6XMzCj1R+l3MkcdtO0zz8Nry3WAZHrFBc/SX0=;
        b=EvuYQ1qyXXPRObOfgfWeYvghAN4S5O8suR+mUUnxyOGJurnV8xbFvI8aoS6pxYjiKG
         qWHJuvAO/19MeJQW0wjqY8/hoX4N6HpLRcxHr0NACGvyCY6b+8dxh1EJnycQfazYYlJk
         R/gdDFpDokutM7Oc4puMUaNrb18IyoqosB4QrTgDhVk8V1iG6Scq2qyPUMSNxgPff9wn
         A6A2+74a3PcC9VCmAKOA2r6RpjdshWLhHphbY/lHd8CZItc1cEJ8Y9/EEymiTZgW4ls9
         LFoDpQLGWuf+R6wvm3sYwWUs+9Dz1DkdZLhxUwQdnlo9438P16/Ts3dbu0vgDS7UgVNr
         p5wg==
X-Forwarded-Encrypted: i=1; AJvYcCXf+x+FGVIFoeGx7DnSTJtoF38PLfUZg4d10+t2ibK9SCyw0GbxJIG2MlZLWd0brS5qElfElHo0LudwwsPvyuz40med9lFS+dg8D1/42tleNAwRSyyNPGHMWWJY6lgLBTJeoBaDpC+b1/8sO2WzINpIFM+s5+uIYhnKlOXXHv/Eao2XfFttZf3kMajzS034
X-Gm-Message-State: AOJu0YyY/3DX7DWKhO4dBtgwzrydZLEmUFkvvFT5f0bkAseWO/GqFOCY
	49LeH3w+LXLHDSND5pI7XbF75rNPtICMAVwVsGUlnAGCqBKDry6QV1oceA==
X-Google-Smtp-Source: AGHT+IFlieztXDmTvRNjIAxUGa/Uy5bcOmk0sr1UEIFH0OpPH5TWSFwVNdVw5foiiWZWdUMYEMuHFQ==
X-Received: by 2002:a19:5f1e:0:b0:516:a686:8ae1 with SMTP id t30-20020a195f1e000000b00516a6868ae1mr10754069lfb.62.1713294008825;
        Tue, 16 Apr 2024 12:00:08 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a5227c8f0e4sm6742784ejc.89.2024.04.16.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 12:00:07 -0700 (PDT)
Message-ID: <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
Date: Tue, 16 Apr 2024 21:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Ivor Wanders <ivor@iwanders.net>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-3-luzmaximilian@gmail.com>
 <43908511-198f-42ee-af21-dad79bdf799a@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <43908511-198f-42ee-af21-dad79bdf799a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 3:30 PM, Guenter Roeck wrote:
> On Sat, Mar 30, 2024 at 12:24:01PM +0100, Maximilian Luz wrote:

[...]

>> +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
>> +{
>> +	struct ssam_tmp_get_name_rsp name_rsp;
>> +	int status;
>> +
>> +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
>> +	if (status)
>> +		return status;
>> +
>> +	/*
>> +	 * This should not fail unless the name in the returned struct is not
>> +	 * null-terminated or someone changed something in the struct
>> +	 * definitions above, since our buffer and struct have the same
>> +	 * capacity by design. So if this fails blow this up with a warning.
>> +	 * Since the more likely cause is that the returned string isn't
>> +	 * null-terminated, we might have received garbage (as opposed to just
>> +	 * an incomplete string), so also fail the function.
>> +	 */
>> +	status = strscpy(buf, name_rsp.name, buf_len);
>> +	WARN_ON(status < 0);
> 
> Not acceptable. From include/asm-generic/bug.h:
> 
>   * Do not use these macros when checking for invalid external inputs
>   * (e.g. invalid system call arguments, or invalid data coming from
>   * network/devices), and on transient conditions like ENOMEM or EAGAIN.
>   * These macros should be used for recoverable kernel issues only.
>

Hmm, I always interpreted that as "do not use for checking user-defined
input", which this is not.

The reason I added/requested it here was to check for "bugs" in how we
think the interface behaves (and our definitions related to it) as the
interface was reverse-engineered. Generally, when this fails I expect
that we made some mistake in our code (or the things we assume about the
interface), which likely causes us to interpret the received data as
"garbage" (and not the EC sending corrupted data, which it is generally
not due to CRC checking and validation in the SAM driver). Hence, I
personally would prefer if this blows up in a big warning with a trace
attached to it, so that an end-user can easily report this to us and
that we can appropriately deal with it. As opposed to some one-line
error message that will likely get overlooked or not taken as seriously.

If you still insist, I could change that to a dev_err() message. Or
maybe make the comment a bit clearer.

>> +
>> +	return status < 0 ? status : 0;
>> +}
>> +
>>   
>>   /* -- Driver.---------------------------------------------------------------- */
>>   
>>   struct ssam_temp {
>>   	struct ssam_device *sdev;
>>   	s16 sensors;
>> +	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
>>   };
>>   
>>   static umode_t ssam_temp_hwmon_is_visible(const void *data,
>> @@ -83,33 +134,47 @@ static int ssam_temp_hwmon_read(struct device *dev,
>>   	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
>>   }
>>   
>> +static int ssam_temp_hwmon_read_string(struct device *dev,
>> +				       enum hwmon_sensor_types type,
>> +				       u32 attr, int channel, const char **str)
>> +{
>> +	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
>> +
>> +	*str = ssam_temp->names[channel];
>> +	return 0;
>> +}
>> +
>>   static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
>>   	HWMON_CHANNEL_INFO(chip,
>>   			   HWMON_C_REGISTER_TZ),
>> -	/* We have at most 16 thermal sensor channels. */
>> +	/*
>> +	 * We have at most SSAM_TMP_SENSOR_MAX_COUNT = 16 thermal sensor
>> +	 * channels.
>> +	 */
> 
> Pointless comment. Already explained above, and perfect example showing
> why it has no value separating this and the previous patch.

I can remove the comment.

The reason for it being two separate patches is to retain proper
attribution. I am sorry that this has created more work for you.

In short, Ivor reverse-engineered the interface calls to get the sensor
names and wrote the vast majority of this patch (I only changed some
smaller things and gave advice, hence the co-developed-by). Therefore I
wanted to give proper attribution to Ivor for his work and not squash it
into a single patch.

>>   	HWMON_CHANNEL_INFO(temp,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT,
>> -			   HWMON_T_INPUT),
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> 
> Another example. Why have me review the previous patch
> just to change the code here ?

See above.

> 
> [ ... ]
> 
>> +	/* Retrieve the name for each available sensor. */
>> +	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
>> +		if (!(sensors & BIT(channel)))
>> +			continue;
>> +
>> +		status = ssam_tmp_get_name(sdev, channel + 1,
>> +					   ssam_temp->names[channel],
>> +					   SSAM_TMP_SENSOR_NAME_LENGTH);
>> +		if (status)
>> +			return status;
> 
> Your call to fail probe in this case just because it can not find
> a sensor name. I personally find that quite aggressive.

We generally do not expect this to fail. And I think if this fails, it
should either be something wrong with the EC communication (in a way
that breaks other things like reading temperature values as well) or in
our assumptions of how the interface works. So similar to above, I
personally would prefer this to fail in a more noisy way, so that people
are more likely to tell us about the failure.

As an example: We expect sensor names and the interface for it to be
present. However, maybe some device (either one we couldn't test or some
future one) does not implement the interface call. Usually, an
unsupported call results in a timeout error. So if we would just ignore
that, the driver would load slow (as for each name it would wait for the
timeout), but users might not notice as the temperature sensors can
still be accessed normally after that. I do see that as an easily
detectable bug. Letting it continue to load IMHO just creates a more
subtle bug.

As above, if you prefer I can change that. Just let me know.

Thank you for your review.

Best regards,
Max

