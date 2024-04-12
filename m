Return-Path: <linux-kernel+bounces-142606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB008A2DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FF81F23F51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA754FB5;
	Fri, 12 Apr 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfij5lah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF654918;
	Fri, 12 Apr 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922178; cv=none; b=rCnun79BUZsYoNwG9HOlpmkIxjcvPtQVWgZa60SMWzeUOcKuX/oVg2kW4/XxvtXUqblcTyrLcQRXtaM8HkRzJxMecnOf5LwIInsTAkyW6Dfc3TXQUVEy85zCo0Biep9iO/5qAGU9fHI/cmxK5WhfJ+b5daL1OG4qM/nkk8b3qLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922178; c=relaxed/simple;
	bh=ih8uomZg7McKoVqZGzQcKv14qaQUo7Jyubk8Rfk9c0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HxPx2A48Uae6zZRZZu4Fyw6PquvL9O5RF7n7JV61I9gL5KDXtvr+6cJIHRliO5OZb8V3VeS7DD3XjqeUW2ZAupFD2QwBHXzR8w1uj/+zDRLakkNbm88nq6dC0Y9VxZyZul9vjUqfQ4wQTcP5CkKLENg4PFAzT+soBLTuyaicUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfij5lah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A2C113CC;
	Fri, 12 Apr 2024 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712922178;
	bh=ih8uomZg7McKoVqZGzQcKv14qaQUo7Jyubk8Rfk9c0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lfij5lahFI/7YVvPgOmskuD5j4nUoAp/+Eo+brsvhzU7Y18De9KITQxsRhg0fFJcr
	 Ho9QhMbB6H3SDeooo/CtuNk+yBOJtet1isvaQFzdVbWvi6j17FYYEFon2VUc6kBt5s
	 ycbv4i/QvSkjweEProAhmYIqmctK2MTeOBsofm762tzGUXfgTEzHTjAxMegboyYRpa
	 18XplgpjThlNoERoyYSVKmZxWihCVmu0wWtg3KSTLdBNd/zA+0Y4Xou5LzKsH4nPnX
	 agXSO6zxoVmupGlOSiDXd8jPNCSwB/uK5Vjdhx1fLiiafN4YSZHKHWlZqpqIfYUqOs
	 dG24AOtwEHjNg==
Date: Fri, 12 Apr 2024 13:42:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Max Maisel <mmm-1@posteo.net>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, 
    Vicki Pfau <vi@endrift.com>
Subject: Re: [PATCH] HID: hid-steam: Add Deck IMU support
In-Reply-To: <20240407121930.6012-1-mmm-1@posteo.net>
Message-ID: <nycvar.YFH.7.76.2404121341570.5680@cbobk.fhfr.pm>
References: <20240407121930.6012-1-mmm-1@posteo.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Apr 2024, Max Maisel wrote:

> The Deck's controller features an accelerometer and gyroscope which
> send their measurement values by default in the main HID input report.
> Expose both sensors to userspace through a separate evdev node as it
> is done by the hid-nintendo and hid-playstation drivers.
> 
> Signed-off-by: Max Maisel <mmm-1@posteo.net>

CCing Rodrigo and Vicki ... could you please take a look and Ack the patch 
below from Max?

Thanks.

> ---
> 
> This patch was tested on a Steam Deck running Arch Linux. With it,
> applications using latest SDL2/3 git libraries will pick up the sensors
> without hidraw access. This was tested against the antimicrox gamepad mapper.
> 
> Measurement value scaling was tested by moving the deck and a dualsense
> controller simultaneously and comparing their reported values in
> userspace with SDL3's testcontroller tool.
> 
>  drivers/hid/hid-steam.c | 158 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 150 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index b08a5ab58528..af6e6c3b1356 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -66,6 +66,12 @@ static LIST_HEAD(steam_devices);
>  #define STEAM_DECK_TRIGGER_RESOLUTION 5461
>  /* Joystick runs are about 5 mm and 32768 units */
>  #define STEAM_DECK_JOYSTICK_RESOLUTION 6553
> +/* Accelerometer has 16 bit resolution and a range of +/- 2g */
> +#define STEAM_DECK_ACCEL_RES_PER_G 16384
> +#define STEAM_DECK_ACCEL_RANGE 32768
> +/* Gyroscope has 16 bit resolution and a range of +/- 2000 dps */
> +#define STEAM_DECK_GYRO_RES_PER_DPS 16
> +#define STEAM_DECK_GYRO_RANGE 32000
>  
>  #define STEAM_PAD_FUZZ 256
>  
> @@ -288,6 +294,7 @@ struct steam_device {
>  	struct mutex report_mutex;
>  	unsigned long client_opened;
>  	struct input_dev __rcu *input;
> +	struct input_dev __rcu *sensors;
>  	unsigned long quirks;
>  	struct work_struct work_connect;
>  	bool connected;
> @@ -302,6 +309,7 @@ struct steam_device {
>  	struct work_struct rumble_work;
>  	u16 rumble_left;
>  	u16 rumble_right;
> +	unsigned int sensor_timestamp_us;
>  };
>  
>  static int steam_recv_report(struct steam_device *steam,
> @@ -825,6 +833,74 @@ static int steam_input_register(struct steam_device *steam)
>  	return ret;
>  }
>  
> +static int steam_sensors_register(struct steam_device *steam)
> +{
> +	struct hid_device *hdev = steam->hdev;
> +	struct input_dev *sensors;
> +	int ret;
> +
> +	if (!(steam->quirks & STEAM_QUIRK_DECK))
> +		return 0;
> +
> +	rcu_read_lock();
> +	sensors = rcu_dereference(steam->sensors);
> +	rcu_read_unlock();
> +	if (sensors) {
> +		dbg_hid("%s: already connected\n", __func__);
> +		return 0;
> +	}
> +
> +	sensors = input_allocate_device();
> +	if (!sensors)
> +		return -ENOMEM;
> +
> +	input_set_drvdata(sensors, steam);
> +	sensors->dev.parent = &hdev->dev;
> +
> +	sensors->name = "Steam Deck Motion Sensors";
> +	sensors->phys = hdev->phys;
> +	sensors->uniq = steam->serial_no;
> +	sensors->id.bustype = hdev->bus;
> +	sensors->id.vendor = hdev->vendor;
> +	sensors->id.product = hdev->product;
> +	sensors->id.version = hdev->version;
> +
> +	__set_bit(INPUT_PROP_ACCELEROMETER, sensors->propbit);
> +	__set_bit(EV_MSC, sensors->evbit);
> +	__set_bit(MSC_TIMESTAMP, sensors->mscbit);
> +
> +	input_set_abs_params(sensors, ABS_X, -STEAM_DECK_ACCEL_RANGE,
> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
> +	input_set_abs_params(sensors, ABS_Y, -STEAM_DECK_ACCEL_RANGE,
> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
> +	input_set_abs_params(sensors, ABS_Z, -STEAM_DECK_ACCEL_RANGE,
> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
> +	input_abs_set_res(sensors, ABS_X, STEAM_DECK_ACCEL_RES_PER_G);
> +	input_abs_set_res(sensors, ABS_Y, STEAM_DECK_ACCEL_RES_PER_G);
> +	input_abs_set_res(sensors, ABS_Z, STEAM_DECK_ACCEL_RES_PER_G);
> +
> +	input_set_abs_params(sensors, ABS_RX, -STEAM_DECK_GYRO_RANGE,
> +			STEAM_DECK_GYRO_RANGE, 16, 0);
> +	input_set_abs_params(sensors, ABS_RY, -STEAM_DECK_GYRO_RANGE,
> +			STEAM_DECK_GYRO_RANGE, 16, 0);
> +	input_set_abs_params(sensors, ABS_RZ, -STEAM_DECK_GYRO_RANGE,
> +			STEAM_DECK_GYRO_RANGE, 16, 0);
> +	input_abs_set_res(sensors, ABS_RX, STEAM_DECK_GYRO_RES_PER_DPS);
> +	input_abs_set_res(sensors, ABS_RY, STEAM_DECK_GYRO_RES_PER_DPS);
> +	input_abs_set_res(sensors, ABS_RZ, STEAM_DECK_GYRO_RES_PER_DPS);
> +
> +	ret = input_register_device(sensors);
> +	if (ret)
> +		goto sensors_register_fail;
> +
> +	rcu_assign_pointer(steam->sensors, sensors);
> +	return 0;
> +
> +sensors_register_fail:
> +	input_free_device(sensors);
> +	return ret;
> +}
> +
>  static void steam_input_unregister(struct steam_device *steam)
>  {
>  	struct input_dev *input;
> @@ -838,6 +914,24 @@ static void steam_input_unregister(struct steam_device *steam)
>  	input_unregister_device(input);
>  }
>  
> +static void steam_sensors_unregister(struct steam_device *steam)
> +{
> +	struct input_dev *sensors;
> +
> +	if (!(steam->quirks & STEAM_QUIRK_DECK))
> +		return;
> +
> +	rcu_read_lock();
> +	sensors = rcu_dereference(steam->sensors);
> +	rcu_read_unlock();
> +
> +	if (!sensors)
> +		return;
> +	RCU_INIT_POINTER(steam->sensors, NULL);
> +	synchronize_rcu();
> +	input_unregister_device(sensors);
> +}
> +
>  static void steam_battery_unregister(struct steam_device *steam)
>  {
>  	struct power_supply *battery;
> @@ -890,18 +984,28 @@ static int steam_register(struct steam_device *steam)
>  	spin_lock_irqsave(&steam->lock, flags);
>  	client_opened = steam->client_opened;
>  	spin_unlock_irqrestore(&steam->lock, flags);
> +
>  	if (!client_opened) {
>  		steam_set_lizard_mode(steam, lizard_mode);
>  		ret = steam_input_register(steam);
> -	} else
> -		ret = 0;
> +		if (ret != 0)
> +			goto steam_register_input_fail;
> +		ret = steam_sensors_register(steam);
> +		if (ret != 0)
> +			goto steam_register_sensors_fail;
> +	}
> +	return 0;
>  
> +steam_register_sensors_fail:
> +	steam_input_unregister(steam);
> +steam_register_input_fail:
>  	return ret;
>  }
>  
>  static void steam_unregister(struct steam_device *steam)
>  {
>  	steam_battery_unregister(steam);
> +	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);
>  	if (steam->serial_no[0]) {
>  		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
> @@ -1010,6 +1114,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
>  	steam->client_opened++;
>  	spin_unlock_irqrestore(&steam->lock, flags);
>  
> +	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);
>  
>  	return 0;
> @@ -1030,6 +1135,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
>  	if (connected) {
>  		steam_set_lizard_mode(steam, lizard_mode);
>  		steam_input_register(steam);
> +		steam_sensors_register(steam);
>  	}
>  }
>  
> @@ -1121,6 +1227,7 @@ static int steam_probe(struct hid_device *hdev,
>  	INIT_DELAYED_WORK(&steam->mode_switch, steam_mode_switch_cb);
>  	INIT_LIST_HEAD(&steam->list);
>  	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
> +	steam->sensor_timestamp_us = 0;
>  
>  	/*
>  	 * With the real steam controller interface, do not connect hidraw.
> @@ -1380,12 +1487,12 @@ static void steam_do_input_event(struct steam_device *steam,
>   *  18-19 | s16   | ABS_HAT0Y | left-pad Y value
>   *  20-21 | s16   | ABS_HAT1X | right-pad X value
>   *  22-23 | s16   | ABS_HAT1Y | right-pad Y value
> - *  24-25 | s16   | --        | accelerometer X value
> - *  26-27 | s16   | --        | accelerometer Y value
> - *  28-29 | s16   | --        | accelerometer Z value
> - *  30-31 | s16   | --        | gyro X value
> - *  32-33 | s16   | --        | gyro Y value
> - *  34-35 | s16   | --        | gyro Z value
> + *  24-25 | s16   | IMU ABS_X | accelerometer X value
> + *  26-27 | s16   | IMU ABS_Z | accelerometer Y value
> + *  28-29 | s16   | IMU ABS_Y | accelerometer Z value
> + *  30-31 | s16   | IMU ABS_RX | gyro X value
> + *  32-33 | s16   | IMU ABS_RZ | gyro Y value
> + *  34-35 | s16   | IMU ABS_RY | gyro Z value
>   *  36-37 | s16   | --        | quaternion W value
>   *  38-39 | s16   | --        | quaternion X value
>   *  40-41 | s16   | --        | quaternion Y value
> @@ -1546,6 +1653,32 @@ static void steam_do_deck_input_event(struct steam_device *steam,
>  	input_sync(input);
>  }
>  
> +static void steam_do_deck_sensors_event(struct steam_device *steam,
> +		struct input_dev *sensors, u8 *data)
> +{
> +	/*
> +	 * The deck input report is received every 4 ms on average,
> +	 * with a jitter of +/- 4 ms even though the USB descriptor claims
> +	 * that it uses 1 kHz.
> +	 * Since the HID report does not include a sensor timestamp,
> +	 * use a fixed increment here.
> +	 *
> +	 * The reported sensors data is factory calibrated by default so
> +	 * no extra logic for handling calibratrion is necessary.
> +	 */
> +	steam->sensor_timestamp_us += 4000;
> +	input_event(sensors, EV_MSC, MSC_TIMESTAMP, steam->sensor_timestamp_us);
> +
> +	input_report_abs(sensors, ABS_X, steam_le16(data + 24));
> +	input_report_abs(sensors, ABS_Z, -steam_le16(data + 26));
> +	input_report_abs(sensors, ABS_Y, steam_le16(data + 28));
> +	input_report_abs(sensors, ABS_RX, steam_le16(data + 30));
> +	input_report_abs(sensors, ABS_RZ, -steam_le16(data + 32));
> +	input_report_abs(sensors, ABS_RY, steam_le16(data + 34));
> +
> +	input_sync(sensors);
> +}
> +
>  /*
>   * The size for this message payload is 11.
>   * The known values are:
> @@ -1583,6 +1716,7 @@ static int steam_raw_event(struct hid_device *hdev,
>  {
>  	struct steam_device *steam = hid_get_drvdata(hdev);
>  	struct input_dev *input;
> +	struct input_dev *sensors;
>  	struct power_supply *battery;
>  
>  	if (!steam)
> @@ -1629,6 +1763,14 @@ static int steam_raw_event(struct hid_device *hdev,
>  		if (likely(input))
>  			steam_do_deck_input_event(steam, input, data);
>  		rcu_read_unlock();
> +
> +		if (steam->quirks & STEAM_QUIRK_DECK) {
> +			rcu_read_lock();
> +			sensors = rcu_dereference(steam->sensors);
> +			if (likely(sensors))
> +				steam_do_deck_sensors_event(steam, sensors, data);
> +			rcu_read_unlock();
> +		}
>  		break;
>  	case ID_CONTROLLER_WIRELESS:
>  		/*
> 
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> -- 
> 2.44.0
> 

-- 
Jiri Kosina
SUSE Labs


