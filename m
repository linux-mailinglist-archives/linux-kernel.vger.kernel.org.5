Return-Path: <linux-kernel+bounces-146893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E268A6C95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF39282A43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A312CD9A;
	Tue, 16 Apr 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoyExHp+"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777312C801;
	Tue, 16 Apr 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274266; cv=none; b=M6vy9MbacpAg5gfAHluGOlR3eK0mtcmeh/4GqKck5EedXZQ/Hd4roibBADGX55vtwC6RLMQ+Ez8pWNyNUHqRazxeQ8P9rwW0wVbiLCKXH+ddoOS4yYVUw0rj+EJySi9j5Att2zisE/5AqRWmiogcZEmrHFPMJH841ZjEUEDw5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274266; c=relaxed/simple;
	bh=/eoRald5RQA5tlSO2Q1GOUyfGVlyA/xfmspKPYiGf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0/GguWnPf//6ygB9n4Zw37g7Liqmg3azn6Nv34UfJ6R8qarJf8tp+CXlDIYDIiBZIYEwSS25HCGlYf6rc3BzCu/o9+IcJ/kox4iu2LPNy48lPjIPNnFvGaMRwyGs6jaZrf2/BYXvNrofwvPvDNurELR4+SKa2Qpu4essb9p1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoyExHp+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3030768a12.1;
        Tue, 16 Apr 2024 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713274261; x=1713879061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJewvZ8b6e5v5IGKG7h4PM7qbBAo1UXL6Icq9IfphZs=;
        b=hoyExHp+YXVsTQWM+cGHhM0aNrZ0Y74/4WaExasIap2/YOsgoAZGmFuCYLdZa0UgeA
         RCBwtekbDZC0TqGDbdoUYlxVICtv+LRgbcVqwbihRn1LctlPFD83M4UUQxsPzyK6PrYG
         sf09464BfWtT67nNsIrjnmiWu5CHgyosOuYaAdjw2uQmTHymcHtsen5dsG8xkGsb9iv7
         Gp+1NVDR4rkOv2mfw9THfD+Ahhovc+ENvotgo52BZgBNK7bZi1AS1On4EYMTnTip/938
         fL8ObUSsylFxZSPsGgEU1VK7T2FBqZNNYtD3wrOMgoMdGz0X+RxR7Sd8t0qdhvVct2f9
         prXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274261; x=1713879061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJewvZ8b6e5v5IGKG7h4PM7qbBAo1UXL6Icq9IfphZs=;
        b=qEfcchivL2FMIyUtUHBgJI5g2AFn4LQ/2LEo25Nrdg0J2MI2VWDDEjvur4bNbDNZVy
         D3bE5uqkSrzHr0qglsoO/AI8MFOOxLiPr0rcMSDzQwHE5KZ6mpq+Z23xzQteN8ibyoSp
         WTl13+CJ2tnRwJYQeCvMl2BVnvlETdPC7OHYQ8WMO/qvvdNgkDTvUjd6vyGvWEtEFZ+2
         QkYNnPEM8mTCbPHxXVOy1yfSXyF5mtUh1sMseavEpZ20ZEokvkcfDAo6xwsmYyvxanL4
         0WttLhHjpvKWQmkwuLvzrSSBB6m0+Gi2auQS3SdVHy1BL5/tYwk9F8K7q8YtjQsAY9v1
         Cpyg==
X-Forwarded-Encrypted: i=1; AJvYcCW8kwxY4xcKN/jNBz9KCE08SSuZAfxTYAvg5eN7ZfoRlwmlqd02BkZKFpXrgGnw5g3CN5kHKOh9Ht4x6GuvWaiVmhK7ymqwcD0i2eq2Bq8asnLKNxpLKmvlqfnCP8W0IjY7aY5R+8mOjbhsrSTKJm021GgCGNHRQjn9NnXlCahksHb/Jfkscrt1WcquGa7K
X-Gm-Message-State: AOJu0YyLyhOMkwz3UA2J3qxjcBC+uALnrto7rG2se8kQurj2tA0SIDk5
	61oNLFmrGO+Gl8SytSzsdRgicGsKi8TDBxms3k1RGYPM6+b0oET75XFAOg==
X-Google-Smtp-Source: AGHT+IEbwazAFR0wRkcKMFLBCnJrUE2p2zGUNubAcMoJVt/6w4BroKVdX4UglbroDqWaFd20Z0khjA==
X-Received: by 2002:a17:90a:5ac4:b0:2a2:dd53:828b with SMTP id n62-20020a17090a5ac400b002a2dd53828bmr10638846pji.43.1713274261155;
        Tue, 16 Apr 2024 06:31:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm9168377pjs.6.2024.04.16.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:31:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 06:30:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
Message-ID: <43908511-198f-42ee-af21-dad79bdf799a@roeck-us.net>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-3-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330112409.3402943-3-luzmaximilian@gmail.com>

On Sat, Mar 30, 2024 at 12:24:01PM +0100, Maximilian Luz wrote:
> From: Ivor Wanders <ivor@iwanders.net>
> 
> The thermal subsystem of the Surface Aggregator Module allows us to
> query the names of the respective thermal sensors. Forward those to
> userspace.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/surface_temp.c | 112 +++++++++++++++++++++++++++++------
>  1 file changed, 95 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
> index 48c3e826713f6..7a2e1f638336c 100644
> --- a/drivers/hwmon/surface_temp.c
> +++ b/drivers/hwmon/surface_temp.c
> @@ -17,6 +17,27 @@
>  
>  /* -- SAM interface. -------------------------------------------------------- */
>  
> +/*
> + * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
> + * presence of a sensor. So we have at most 16 possible sensors/channels.
> + */
> +#define SSAM_TMP_SENSOR_MAX_COUNT 16

#define<space>DEFINITION<tab>value

> +
> +/*
> + * All names observed so far are 6 characters long, but there's only
> + * zeros after the name, so perhaps they can be longer. This number reflects
> + * the maximum zero-padded space observed in the returned buffer.
> + */
> +#define SSAM_TMP_SENSOR_NAME_LENGTH 18
> +
> +struct ssam_tmp_get_name_rsp {
> +	__le16 unknown1;
> +	char unknown2;
> +	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
> +} __packed;
> +
> +static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
> +
>  SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
>  	.target_category = SSAM_SSH_TC_TMP,
>  	.command_id      = 0x04,
> @@ -27,6 +48,11 @@ SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
>  	.command_id      = 0x01,
>  });
>  
> +SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x0e,
> +});
> +
>  static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
>  {
>  	__le16 sensors_le;
> @@ -54,12 +80,37 @@ static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temp
>  	return 0;
>  }
>  
> +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
> +{
> +	struct ssam_tmp_get_name_rsp name_rsp;
> +	int status;
> +
> +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
> +	if (status)
> +		return status;
> +
> +	/*
> +	 * This should not fail unless the name in the returned struct is not
> +	 * null-terminated or someone changed something in the struct
> +	 * definitions above, since our buffer and struct have the same
> +	 * capacity by design. So if this fails blow this up with a warning.
> +	 * Since the more likely cause is that the returned string isn't
> +	 * null-terminated, we might have received garbage (as opposed to just
> +	 * an incomplete string), so also fail the function.
> +	 */
> +	status = strscpy(buf, name_rsp.name, buf_len);
> +	WARN_ON(status < 0);

Not acceptable. From include/asm-generic/bug.h:

 * Do not use these macros when checking for invalid external inputs
 * (e.g. invalid system call arguments, or invalid data coming from
 * network/devices), and on transient conditions like ENOMEM or EAGAIN.
 * These macros should be used for recoverable kernel issues only.

> +
> +	return status < 0 ? status : 0;
> +}
> +
>  
>  /* -- Driver.---------------------------------------------------------------- */
>  
>  struct ssam_temp {
>  	struct ssam_device *sdev;
>  	s16 sensors;
> +	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
>  };
>  
>  static umode_t ssam_temp_hwmon_is_visible(const void *data,
> @@ -83,33 +134,47 @@ static int ssam_temp_hwmon_read(struct device *dev,
>  	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
>  }
>  
> +static int ssam_temp_hwmon_read_string(struct device *dev,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel, const char **str)
> +{
> +	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
> +
> +	*str = ssam_temp->names[channel];
> +	return 0;
> +}
> +
>  static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_REGISTER_TZ),
> -	/* We have at most 16 thermal sensor channels. */
> +	/*
> +	 * We have at most SSAM_TMP_SENSOR_MAX_COUNT = 16 thermal sensor
> +	 * channels.
> +	 */

Pointless comment. Already explained above, and perfect example showing
why it has no value separating this and the previous patch.

>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT),
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),

Another example. Why have me review the previous patch
just to change the code here ?

[ ... ]

> +	/* Retrieve the name for each available sensor. */
> +	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
> +		if (!(sensors & BIT(channel)))
> +			continue;
> +
> +		status = ssam_tmp_get_name(sdev, channel + 1,
> +					   ssam_temp->names[channel],
> +					   SSAM_TMP_SENSOR_NAME_LENGTH);
> +		if (status)
> +			return status;

Your call to fail probe in this case just because it can not find
a sensor name. I personally find that quite aggressive.

Guenter

