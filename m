Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8627DA80C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJ1QYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1QYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:24:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46FE5;
        Sat, 28 Oct 2023 09:24:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so3060703b3a.3;
        Sat, 28 Oct 2023 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698510280; x=1699115080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG7svNEPZUjdTioSC7hIIvNSd42KMflBgmUOxepCIPY=;
        b=m8Ib7Z6WgMlXZ4iqeCkpxusaQfwhCcfouaudLrnHxyQFCDnvfI6WH6CvjLKq/5NzXb
         qm9ubcX9mHkEVW9BdkbovedMBB2gOZptxDus7GqMga9rXLl3d4Ag2p17+uRSog3WnVc/
         wU/p9k1MA47nllHKpPKpIWvFqErC5EyW3LfAIDl/Mbfss7ZgyUTMNtY333PgH1iEjfhW
         01FFH4HfbeWQ6MDfJhmVM14xx/zQBSK9CCvWNH4gkbUZ0dUsH27MKpyv+if6aQL/9n1L
         xDwshUnbmTpny+BKUNsrwHx5vN6Rm8/v9gwLB3aEUtzQtISdmKMVAywHDUr724QEVPkV
         hShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698510280; x=1699115080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG7svNEPZUjdTioSC7hIIvNSd42KMflBgmUOxepCIPY=;
        b=GZgNDOAfLnQ0s8px40DqGvu99DE7xz8eL1ule9j32XlT9HSl/En3LYWj07zOLEz5+n
         oMRAtlYW0hph9mXNUNxG43G1kHXZT+fg/cHvvnbm42TfDQspqCZsuiHzfuBto92BM2S0
         oOHS635KH62t13fnO7db5zSAeRANtbaDUFVqx4Bj14bg8yo/J+WT4ic15RuOmwNgZRPG
         m1Q1RjbmbrOR/TgMq3cQKRHSf0SvQNXFDAbTYEDdRTWbQkfr4R0QbOsr3UwstALjV/FU
         t3r4U3MSvy1D0kfNL1Mzrhew0J06+yQ8P8AX2X3Ma5WHxNcZ3jd+onXdz0Y6BO64bwvA
         hZjw==
X-Gm-Message-State: AOJu0YyoFhiQXeH7hbNLqLiSM+jQNEfO88TWub7B3+MoImlUKsqw5Byv
        FOVKexdkLq9/6Z9Wn88c1fQ=
X-Google-Smtp-Source: AGHT+IGPBDr65Vzmi0XxyrH78oio2jatu/T50BTVUoOGiXxAvlXJkYL7Lmb+YmZfIfquZr443MtnQg==
X-Received: by 2002:a05:6a00:1a4e:b0:690:1c1b:aefd with SMTP id h14-20020a056a001a4e00b006901c1baefdmr7006887pfv.5.1698510279583;
        Sat, 28 Oct 2023 09:24:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b006be055ab117sm3229770pfh.92.2023.10.28.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 09:24:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Oct 2023 09:24:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow USB and MPS Flow
Message-ID: <c08d04b4-8e6d-4221-93f1-cf5fff8c54c4@roeck-us.net>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
 <20231016083559.139341-3-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016083559.139341-3-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:35:58AM +0200, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose various hardware sensors of the
> Aquacomputer High Flow USB flow sensor, which communicates through a
> proprietary USB HID protocol. This commit also adds support for the sensors
> of the MPS Flow devices, as they have the same USB product ID and sensor
> layouts. Implemented by Leonard Anderweit [1].
> 
> Internal and external temp sensor readings are available, along with
> the flow sensor.
> 
> Additionally, serial number and firmware version are exposed through
> debugfs.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/90
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  7 +++
>  drivers/hwmon/aquacomputer_d5next.c         | 67 +++++++++++++++++++--
>  2 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 94dc2d93d180..cb073c79479c 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -16,6 +16,8 @@ Supported devices:
>  * Aquacomputer Aquastream XT watercooling pump
>  * Aquacomputer Aquastream Ultimate watercooling pump
>  * Aquacomputer Poweradjust 3 fan controller
> +* Aquacomputer High Flow USB flow meter
> +* Aquacomputer MPS Flow devices
>  
>  Author: Aleksa Savic
>  
> @@ -73,6 +75,11 @@ It also exposes pressure and flow speed readings.
>  
>  The Poweradjust 3 controller exposes a single external temperature sensor.
>  
> +The High Flow USB exposes an internal and external temperature sensor, and a flow meter.
> +
> +The MPS Flow devices expose the same entries as the High Flow USB because they have
> +the same USB product ID and report sensors equivalently.
> +
>  Depending on the device, not all sysfs and debugfs entries will be available.
>  Writing to virtual temperature sensors is not currently supported.
>  
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 46ff4fd4f87d..4fdd2e12427b 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,11 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
> - * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield)
> + * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield,
> + * High Flow USB/MPS Flow family)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values, except for devices that communicate through the
> - * legacy way (currently, Poweradjust 3).
> + * legacy way (currently, Poweradjust 3 and High Flow USB/MPS Flow family).
>   *
>   * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
>   * Copyright 2022 Jack Doan <me@jackdoan.com>
> @@ -35,11 +36,12 @@
>  #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
>  #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
>  #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
> +#define USB_PRODUCT_ID_HIGHFLOW		0xf003
>  
>  enum kinds {
>  	d5next, farbwerk, farbwerk360, octo, quadro,
>  	highflownext, aquaero, poweradjust3, aquastreamult,
> -	aquastreamxt, leakshield
> +	aquastreamxt, leakshield, highflow
>  };
>  
>  static const char *const aqc_device_names[] = {
> @@ -53,7 +55,8 @@ static const char *const aqc_device_names[] = {
>  	[aquastreamxt] = "aquastreamxt",
>  	[aquaero] = "aquaero",
>  	[aquastreamult] = "aquastreamultimate",
> -	[poweradjust3] = "poweradjust3"
> +	[poweradjust3] = "poweradjust3",
> +	[highflow] = "highflow" /* Covers MPS Flow devices */
>  };
>  
>  #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -90,6 +93,8 @@ static u8 aquaero_secondary_ctrl_report[] = {
>  
>  #define POWERADJUST3_STATUS_REPORT_ID	0x03
>  
> +#define HIGHFLOW_STATUS_REPORT_ID	0x02
> +
>  /* Data types for reading and writing control reports */
>  #define AQC_8		0
>  #define AQC_BE16	1
> @@ -282,6 +287,17 @@ static u16 aquastreamxt_sensor_fan_offsets[] = { 0x13, 0x1b };
>  /* Sensor report offsets for the Poweradjust 3 */
>  #define POWERADJUST3_SENSOR_START	0x03
>  
> +/* Specs of the High Flow USB */
> +#define HIGHFLOW_NUM_SENSORS		2
> +#define HIGHFLOW_NUM_FLOW_SENSORS	1
> +#define HIGHFLOW_SENSOR_REPORT_SIZE	0x76
> +
> +/* Sensor report offsets for the High Flow USB */
> +#define HIGHFLOW_FIRMWARE_VERSION	0x3
> +#define HIGHFLOW_SERIAL_START		0x9
> +#define HIGHFLOW_FLOW_SENSOR_OFFSET	0x23
> +#define HIGHFLOW_SENSOR_START		0x2b
> +
>  /* Labels for D5 Next */
>  static const char *const label_d5next_temp[] = {
>  	"Coolant temp"
> @@ -486,6 +502,16 @@ static const char *const label_poweradjust3_temp_sensors[] = {
>  	"External sensor"
>  };
>  
> +/* Labels for Highflow */
> +static const char *const label_highflow_temp[] = {
> +	"External temp",
> +	"Internal temp"
> +};
> +
> +static const char *const label_highflow_speeds[] = {
> +	"Flow speed [dL/h]"
> +};
> +
>  struct aqc_fan_structure_offsets {
>  	u8 voltage;
>  	u8 curr;
> @@ -819,6 +845,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  				break;
>  			case aquaero:
>  			case quadro:
> +			case highflow:
>  				/* Special case to support flow sensors */
>  				if (channel < priv->num_fans + priv->num_flow_sensors)
>  					return 0444;
> @@ -965,6 +992,17 @@ static int aqc_legacy_read(struct aqc_data *priv)
>  		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_FAN_VOLTAGE_OFFSET);
>  		priv->voltage_input[1] = DIV_ROUND_CLOSEST(sensor_value * 1000, 63);
>  		break;
> +	case highflow:
> +		/* Info provided with every report */
> +		priv->serial_number[0] = get_unaligned_le16(priv->buffer +
> +							    priv->serial_number_start_offset);
> +		priv->firmware_version =
> +		    get_unaligned_le16(priv->buffer + priv->firmware_version_offset);
> +
> +		/* Read flow speed */
> +		priv->speed_input[0] = get_unaligned_le16(priv->buffer +
> +							  priv->flow_sensors_start_offset);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1750,6 +1788,20 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		priv->temp_label = label_poweradjust3_temp_sensors;
>  		break;
> +	case USB_PRODUCT_ID_HIGHFLOW:
> +		priv->kind = highflow;
> +
> +		priv->num_fans = 0;
> +
> +		priv->num_temp_sensors = HIGHFLOW_NUM_SENSORS;
> +		priv->temp_sensor_start_offset = HIGHFLOW_SENSOR_START;
> +		priv->num_flow_sensors = HIGHFLOW_NUM_FLOW_SENSORS;
> +		priv->flow_sensors_start_offset = HIGHFLOW_FLOW_SENSOR_OFFSET;
> +		priv->buffer_size = HIGHFLOW_SENSOR_REPORT_SIZE;
> +
> +		priv->temp_label = label_highflow_temp;
> +		priv->speed_label = label_highflow_speeds;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1775,6 +1827,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		priv->status_report_id = AQUASTREAMXT_STATUS_REPORT_ID;
>  		break;
> +	case highflow:
> +		priv->serial_number_start_offset = HIGHFLOW_SERIAL_START;
> +		priv->firmware_version_offset = HIGHFLOW_FIRMWARE_VERSION;
> +
> +		priv->status_report_id = HIGHFLOW_STATUS_REPORT_ID;
> +		break;
>  	default:
>  		priv->serial_number_start_offset = AQC_SERIAL_START;
>  		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
> @@ -1849,6 +1907,7 @@ static const struct hid_device_id aqc_table[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOW) },
>  	{ }
>  };
>  
