Return-Path: <linux-kernel+bounces-161520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0F8B4D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4FA1C209D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E573194;
	Sun, 28 Apr 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOzduPMJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFC71B27;
	Sun, 28 Apr 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324851; cv=none; b=GMZX7CUWyPyvnzLogTUjLJgdlhiUFnR87nSxDPb5UBExvY48mA23RO1E854YgFbc7HqHC4v5nDI+Xa6dsg5rcVLn+RyzSWlzDRAETJwhINHqZZWE6pEKugnfaKgMNjRgFBH7E6l9wIy4YNX6/3NxAdkkPSm7KbrJ9I73puAptxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324851; c=relaxed/simple;
	bh=yqDz5DhrHQniAugwobla9PQINqUZrk3cVpGcXK+g5TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgFk5bgikuW8dOyYp4P6dxjHDa3wF6K5aKKaVbJP+Vxhm43uxuBJu/bq6qb4as1buJ/3l0GUn5OvNQ5ngwPsXFQJSKWhXAhoT+5ZzVnUVrp0fkspatCF0pkPRymcQJqSZYdzjKAH3lyu22vDor2bDTtozr0RsyfEc+yLsDntauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOzduPMJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee12766586so2777981b3a.0;
        Sun, 28 Apr 2024 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714324849; x=1714929649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XRdk8SS04aWW9LvQNo/ZYeC3yA7v+WMTcu1mRyzBFU=;
        b=IOzduPMJbefb28MlVxYpaGCUBi2wFPwACCbvPimFQZwFIH8mwbeCqdTwY+zfxMeBL3
         6IFGexh2b9CjzrW/+Trb2XuTcRep+IOyxhN9rnBCT0YChb9tpw09xQgM+fmB36Z5LLod
         5glb4k4zGuLqyiizoTmOpmvgOewnsf+MWFgVqv964H8Yy22uRPTk/EPDu5c7HqGNu2Z3
         i7UWkl3/R42EA9ExcO9Xo4iufgvJE9HZv7EYd23xgDvMQhMWG806TPNyMW4OcTDwqI2s
         uuogJFRL6TVlKRBEzg72btw13WI4rTBOcsaZ7VYOTCG/YwdGcuOv5PgzaxBVjrwMiJwj
         eDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714324849; x=1714929649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XRdk8SS04aWW9LvQNo/ZYeC3yA7v+WMTcu1mRyzBFU=;
        b=hBA6fOMGOgveye+t+sMdoBFbHbTbYWWdm1BIWX3I1umMyEBdM+S0jXpDIqW64+4zSo
         mNtOdqVhcSy7KqDdDQo7l2T9lRD7gjCPnx+4Xae73DMBMrCx/tt0IpEbo+eiixM9OLDq
         3DvVxO4Vli1znmCQ7ixqWVzxDiIpnFOQSimS3HlwTQbrYAfmaleNaTHphQN/1TMQutYr
         5TORcXLxk178J3+sspr6eqRaGMudcoNHuGh4bRoqdH9M9g8GJzcD+X3SyRYWvHdpYmQ+
         oH9H/s184aGvQn5QoIYIpHbMfIKhg3E9cObKr0nF5c6uPkuKaiBKJauIGCBA0jAhekV+
         iBng==
X-Forwarded-Encrypted: i=1; AJvYcCX5BQC0TliWB9rbQs3Cf3ZKMSbOEqqPG9mqpkw58+oqGscpScLyo4A/0VUODWsjW6A+4WSLcOak6QW1wtDBw+Yj1nU+uXXDdBWG3afYmCCebpVuenskFO6Pg9RaDvczT0bUCp7gIr9z
X-Gm-Message-State: AOJu0YxLFnsfH4h4D8a5hP/VXIXE5THgTX/Fw96lEmhb2Ear+89Dufwx
	M3XCGaFvjM3QTdqGueniFEmGrFBtnNlVajRK1qGg4vkvUPDt01U9
X-Google-Smtp-Source: AGHT+IErmVcCqOU+7O8G/19hd1CYPYz1Q97XwAFVIeWigIf6R+T5V8flkfJU9aXfLqHqgSaXO8xo0w==
X-Received: by 2002:a05:6a20:3ca8:b0:1ae:4292:5cc0 with SMTP id b40-20020a056a203ca800b001ae42925cc0mr7444864pzj.26.1714324849055;
        Sun, 28 Apr 2024 10:20:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n7-20020a635907000000b0061236221eeesm1667968pgb.21.2024.04.28.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:20:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 10:20:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	David Flemstrom <david.flemstrom@gmail.com>,
	Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (aquacomputer_d5next) Add support for Octo
 flow sensor
Message-ID: <2d02ea01-2d9b-43e7-b795-7311fc1c6b86@roeck-us.net>
References: <20240417175037.32499-1-savicaleksa83@gmail.com>
 <20240417175037.32499-2-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417175037.32499-2-savicaleksa83@gmail.com>

On Wed, Apr 17, 2024 at 07:50:35PM +0200, Aleksa Savic wrote:
> Add support for reading the flow sensor value on
> the Aquacomputer Octo. Implemented by David Flemstrom [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/95
> 
> Originally-from: David Flemstrom <david.flemstrom@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  8 ++---
>  drivers/hwmon/aquacomputer_d5next.c         | 34 +++++++++++++--------
>  2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index cb073c79479c..f84b6a5e4373 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -45,9 +45,9 @@ seems to require sending it a complete configuration. That includes addressable
>  RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
>  better suited for userspace tools.
>  
> -The Octo exposes four physical and sixteen virtual temperature sensors, as well as
> -eight PWM controllable fans, along with their speed (in RPM), power, voltage and
> -current.
> +The Octo exposes four physical and sixteen virtual temperature sensors, a flow sensor
> +as well as eight PWM controllable fans, along with their speed (in RPM), power, voltage
> +and current.
>  
>  The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
>  sensor and four PWM controllable fans, along with their speed (in RPM), power,
> @@ -95,7 +95,7 @@ Sysfs entries
>  ================ ==============================================================
>  temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
>  temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
> -fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
> +fan[1-9]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
>  fan1_min         Minimal fan speed (in RPM)
>  fan1_max         Maximal fan speed (in RPM)
>  fan1_target      Target fan speed (in RPM)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 2efe97f8d003..166044e01921 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -202,12 +202,14 @@ static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
>  #define OCTO_NUM_FANS			8
>  #define OCTO_NUM_SENSORS		4
>  #define OCTO_NUM_VIRTUAL_SENSORS	16
> +#define OCTO_NUM_FLOW_SENSORS		1
>  #define OCTO_CTRL_REPORT_SIZE		0x65F
>  
>  /* Sensor report offsets for the Octo */
>  #define OCTO_POWER_CYCLES		0x18
>  #define OCTO_SENSOR_START		0x3D
>  #define OCTO_VIRTUAL_SENSORS_START	0x45
> +#define OCTO_FLOW_SENSOR_OFFSET		0x7B
>  static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
>  
>  /* Control report offsets for the Octo */
> @@ -363,18 +365,6 @@ static const char *const label_aquaero_calc_temp_sensors[] = {
>  	"Calc. virtual sensor 4"
>  };
>  
> -/* Labels for Octo and Quadro (except speed) */
> -static const char *const label_fan_speed[] = {
> -	"Fan 1 speed",
> -	"Fan 2 speed",
> -	"Fan 3 speed",
> -	"Fan 4 speed",
> -	"Fan 5 speed",
> -	"Fan 6 speed",
> -	"Fan 7 speed",
> -	"Fan 8 speed"
> -};
> -
>  static const char *const label_fan_power[] = {
>  	"Fan 1 power",
>  	"Fan 2 power",
> @@ -408,6 +398,19 @@ static const char *const label_fan_current[] = {
>  	"Fan 8 current"
>  };
>  
> +/* Labels for Octo fan speeds */
> +static const char *const label_octo_speeds[] = {
> +	"Fan 1 speed",
> +	"Fan 2 speed",
> +	"Fan 3 speed",
> +	"Fan 4 speed",
> +	"Fan 5 speed",
> +	"Fan 6 speed",
> +	"Fan 7 speed",
> +	"Fan 8 speed",
> +	"Flow speed [dL/h]",
> +};
> +
>  /* Labels for Quadro fan speeds */
>  static const char *const label_quadro_speeds[] = {
>  	"Fan 1 speed",
> @@ -844,6 +847,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  					return 0444;
>  				break;
>  			case aquaero:
> +			case octo:
>  			case quadro:
>  			case highflow:
>  				/* Special case to support flow sensors */
> @@ -1289,6 +1293,7 @@ static const struct hwmon_channel_info * const aqc_info[] = {
>  			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL),
>  	HWMON_CHANNEL_INFO(power,
>  			   HWMON_P_INPUT | HWMON_P_LABEL,
> @@ -1658,6 +1663,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->temp_sensor_start_offset = OCTO_SENSOR_START;
>  		priv->num_virtual_temp_sensors = OCTO_NUM_VIRTUAL_SENSORS;
>  		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
> +		priv->num_flow_sensors = OCTO_NUM_FLOW_SENSORS;
> +		priv->flow_sensors_start_offset = OCTO_FLOW_SENSOR_OFFSET;
> +
>  		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
>  
>  		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
> @@ -1667,7 +1675,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
> -		priv->speed_label = label_fan_speed;
> +		priv->speed_label = label_octo_speeds;
>  		priv->power_label = label_fan_power;
>  		priv->voltage_label = label_fan_voltage;
>  		priv->current_label = label_fan_current;

