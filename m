Return-Path: <linux-kernel+bounces-146101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846898A60BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89861C20835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415AF513;
	Tue, 16 Apr 2024 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="RzI8+I4O"
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C4BA42;
	Tue, 16 Apr 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233505; cv=none; b=Ioce3+S9P2eWcIP7NkyoMHq7Wi7Cs99A5/5yn2t8EYNg7jJfl7y9bEwUvx+pabghEk1jNqPtrOjpq5YrAlEdeqIV7hOzVYIFx0x5U2ZsYuquQWhuYSzPPLZLI7IgCmcTQdtORLZvRYff/0Z6WoaurCtteVT/Nfk3LrxeKw5oeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233505; c=relaxed/simple;
	bh=Nhh7ILCL16OSiya9DrKbKTUMiyLGX8n8n/J0Kg6WpFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqn15KYxdkXzZyrRBxkF2IpthLOhjQRxPh7MAEC9hqatUWmVepEFqUh3CRGMZT2gWtlOtqDO/ee3In+ASamAwNRkVtOmbqC6DL261k7TNSDy7hhArM2VDROK+1vwn/14KGTwJEBftwSwDL7nJjKrcbQ6fSaSJ/WHrRCVQZsenBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=RzI8+I4O; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Received: from [192.168.0.22] (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id C4FEBA037;
	Mon, 15 Apr 2024 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1713233167; bh=Nhh7ILCL16OSiya9DrKbKTUMiyLGX8n8n/J0Kg6WpFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RzI8+I4OYKJJZZq5gJkbPQYtN/Ds+c4NMwCDETwvFtMP1Ltb6Cs0HhNTyE2GlGZiX
	 y2zgAh2g+FgUfae6SQ7gkJrVQtDGv4rdNLHDf+uIYBeVaDA+hCvjWfGv9Lgd5Ep26t
	 exg3tNrxaI1qnXMfk9A648mS9SXvdNARTyQ9NtxtTj24O2HpGRfEXjCAS/6oQnxeFo
	 sEu68SfHUCfjKAM+ha+UCKFXJraW++jz9Y7RT/CTXrDDE+wzy2Y6vEWPMI8pyDWe2v
	 riCBbXn0JGQGD/h4qq55NUNTprCi+ols7ClbtKLfCjtczocD99y7I3EFOKpM/ektkr
	 JKNRjr9RmotwA==
Message-ID: <0a92f4da-9517-4c12-a265-eb06f909f18b@endrift.com>
Date: Mon, 15 Apr 2024 19:06:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: hid-steam: Add Deck IMU support
To: Jiri Kosina <jikos@kernel.org>, Max Maisel <mmm-1@posteo.net>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
References: <20240407121930.6012-1-mmm-1@posteo.net>
 <nycvar.YFH.7.76.2404121341570.5680@cbobk.fhfr.pm>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <nycvar.YFH.7.76.2404121341570.5680@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/12/24 4:42 AM, Jiri Kosina wrote:
> On Sun, 7 Apr 2024, Max Maisel wrote:
> 
>> The Deck's controller features an accelerometer and gyroscope which
>> send their measurement values by default in the main HID input report.
>> Expose both sensors to userspace through a separate evdev node as it
>> is done by the hid-nintendo and hid-playstation drivers.
>>
>> Signed-off-by: Max Maisel <mmm-1@posteo.net>
> 
> CCing Rodrigo and Vicki ... could you please take a look and Ack the patch 
> below from Max?
> 
> Thanks.
> 
>> ---
>>
>> This patch was tested on a Steam Deck running Arch Linux. With it,
>> applications using latest SDL2/3 git libraries will pick up the sensors
>> without hidraw access. This was tested against the antimicrox gamepad mapper.
>>
>> Measurement value scaling was tested by moving the deck and a dualsense
>> controller simultaneously and comparing their reported values in
>> userspace with SDL3's testcontroller tool.
>>
>>  drivers/hid/hid-steam.c | 158 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 150 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
>> index b08a5ab58528..af6e6c3b1356 100644
>> --- a/drivers/hid/hid-steam.c
>> +++ b/drivers/hid/hid-steam.c
>> @@ -66,6 +66,12 @@ static LIST_HEAD(steam_devices);
>>  #define STEAM_DECK_TRIGGER_RESOLUTION 5461
>>  /* Joystick runs are about 5 mm and 32768 units */
>>  #define STEAM_DECK_JOYSTICK_RESOLUTION 6553
>> +/* Accelerometer has 16 bit resolution and a range of +/- 2g */
>> +#define STEAM_DECK_ACCEL_RES_PER_G 16384
>> +#define STEAM_DECK_ACCEL_RANGE 32768
>> +/* Gyroscope has 16 bit resolution and a range of +/- 2000 dps */
>> +#define STEAM_DECK_GYRO_RES_PER_DPS 16
>> +#define STEAM_DECK_GYRO_RANGE 32000

This value looks strange. How do you know it's not supposed to be 32768?

>>  
>>  #define STEAM_PAD_FUZZ 256
>>  
>> @@ -288,6 +294,7 @@ struct steam_device {
>>  	struct mutex report_mutex;
>>  	unsigned long client_opened;
>>  	struct input_dev __rcu *input;
>> +	struct input_dev __rcu *sensors;
>>  	unsigned long quirks;
>>  	struct work_struct work_connect;
>>  	bool connected;
>> @@ -302,6 +309,7 @@ struct steam_device {
>>  	struct work_struct rumble_work;
>>  	u16 rumble_left;
>>  	u16 rumble_right;
>> +	unsigned int sensor_timestamp_us;
>>  };
>>  
>>  static int steam_recv_report(struct steam_device *steam,
>> @@ -825,6 +833,74 @@ static int steam_input_register(struct steam_device *steam)
>>  	return ret;
>>  }
>>  
>> +static int steam_sensors_register(struct steam_device *steam)
>> +{
>> +	struct hid_device *hdev = steam->hdev;
>> +	struct input_dev *sensors;
>> +	int ret;
>> +
>> +	if (!(steam->quirks & STEAM_QUIRK_DECK))
>> +		return 0;
>> +
>> +	rcu_read_lock();
>> +	sensors = rcu_dereference(steam->sensors);
>> +	rcu_read_unlock();
>> +	if (sensors) {
>> +		dbg_hid("%s: already connected\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	sensors = input_allocate_device();
>> +	if (!sensors)
>> +		return -ENOMEM;
>> +
>> +	input_set_drvdata(sensors, steam);
>> +	sensors->dev.parent = &hdev->dev;
>> +
>> +	sensors->name = "Steam Deck Motion Sensors";
>> +	sensors->phys = hdev->phys;
>> +	sensors->uniq = steam->serial_no;
>> +	sensors->id.bustype = hdev->bus;
>> +	sensors->id.vendor = hdev->vendor;
>> +	sensors->id.product = hdev->product;
>> +	sensors->id.version = hdev->version;
>> +
>> +	__set_bit(INPUT_PROP_ACCELEROMETER, sensors->propbit);
>> +	__set_bit(EV_MSC, sensors->evbit);
>> +	__set_bit(MSC_TIMESTAMP, sensors->mscbit);
>> +
>> +	input_set_abs_params(sensors, ABS_X, -STEAM_DECK_ACCEL_RANGE,
>> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
>> +	input_set_abs_params(sensors, ABS_Y, -STEAM_DECK_ACCEL_RANGE,
>> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
>> +	input_set_abs_params(sensors, ABS_Z, -STEAM_DECK_ACCEL_RANGE,
>> +			STEAM_DECK_ACCEL_RANGE, 16, 0);
>> +	input_abs_set_res(sensors, ABS_X, STEAM_DECK_ACCEL_RES_PER_G);
>> +	input_abs_set_res(sensors, ABS_Y, STEAM_DECK_ACCEL_RES_PER_G);
>> +	input_abs_set_res(sensors, ABS_Z, STEAM_DECK_ACCEL_RES_PER_G);
>> +
>> +	input_set_abs_params(sensors, ABS_RX, -STEAM_DECK_GYRO_RANGE,
>> +			STEAM_DECK_GYRO_RANGE, 16, 0);
>> +	input_set_abs_params(sensors, ABS_RY, -STEAM_DECK_GYRO_RANGE,
>> +			STEAM_DECK_GYRO_RANGE, 16, 0);
>> +	input_set_abs_params(sensors, ABS_RZ, -STEAM_DECK_GYRO_RANGE,
>> +			STEAM_DECK_GYRO_RANGE, 16, 0);
>> +	input_abs_set_res(sensors, ABS_RX, STEAM_DECK_GYRO_RES_PER_DPS);
>> +	input_abs_set_res(sensors, ABS_RY, STEAM_DECK_GYRO_RES_PER_DPS);
>> +	input_abs_set_res(sensors, ABS_RZ, STEAM_DECK_GYRO_RES_PER_DPS);

I seem to recall hearing that this data is not calibrated coming off of the device, and the actual calibration data is in Steam somewhere, but I'm not sure which data this applies to. The gravitation acceleration looked fine when testing, but I didn't have a dualsense handy to test the gyro with. Have you tested this on more than one device?

>> +
>> +	ret = input_register_device(sensors);
>> +	if (ret)
>> +		goto sensors_register_fail;
>> +
>> +	rcu_assign_pointer(steam->sensors, sensors);
>> +	return 0;
>> +
>> +sensors_register_fail:
>> +	input_free_device(sensors);
>> +	return ret;
>> +}
>> +
>>  static void steam_input_unregister(struct steam_device *steam)
>>  {
>>  	struct input_dev *input;
>> @@ -838,6 +914,24 @@ static void steam_input_unregister(struct steam_device *steam)
>>  	input_unregister_device(input);
>>  }
>>  
>> +static void steam_sensors_unregister(struct steam_device *steam)
>> +{
>> +	struct input_dev *sensors;
>> +
>> +	if (!(steam->quirks & STEAM_QUIRK_DECK))
>> +		return;
>> +
>> +	rcu_read_lock();
>> +	sensors = rcu_dereference(steam->sensors);
>> +	rcu_read_unlock();
>> +
>> +	if (!sensors)
>> +		return;
>> +	RCU_INIT_POINTER(steam->sensors, NULL);
>> +	synchronize_rcu();
>> +	input_unregister_device(sensors);
>> +}
>> +
>>  static void steam_battery_unregister(struct steam_device *steam)
>>  {
>>  	struct power_supply *battery;
>> @@ -890,18 +984,28 @@ static int steam_register(struct steam_device *steam)
>>  	spin_lock_irqsave(&steam->lock, flags);
>>  	client_opened = steam->client_opened;
>>  	spin_unlock_irqrestore(&steam->lock, flags);
>> +
>>  	if (!client_opened) {
>>  		steam_set_lizard_mode(steam, lizard_mode);
>>  		ret = steam_input_register(steam);
>> -	} else
>> -		ret = 0;
>> +		if (ret != 0)
>> +			goto steam_register_input_fail;
>> +		ret = steam_sensors_register(steam);
>> +		if (ret != 0)
>> +			goto steam_register_sensors_fail;
>> +	}
>> +	return 0;
>>  
>> +steam_register_sensors_fail:
>> +	steam_input_unregister(steam);
>> +steam_register_input_fail:
>>  	return ret;
>>  }
>>  
>>  static void steam_unregister(struct steam_device *steam)
>>  {
>>  	steam_battery_unregister(steam);
>> +	steam_sensors_unregister(steam);
>>  	steam_input_unregister(steam);
>>  	if (steam->serial_no[0]) {
>>  		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>> @@ -1010,6 +1114,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
>>  	steam->client_opened++;
>>  	spin_unlock_irqrestore(&steam->lock, flags);
>>  
>> +	steam_sensors_unregister(steam);
>>  	steam_input_unregister(steam);
>>  
>>  	return 0;
>> @@ -1030,6 +1135,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
>>  	if (connected) {
>>  		steam_set_lizard_mode(steam, lizard_mode);
>>  		steam_input_register(steam);
>> +		steam_sensors_register(steam);
>>  	}
>>  }
>>  
>> @@ -1121,6 +1227,7 @@ static int steam_probe(struct hid_device *hdev,
>>  	INIT_DELAYED_WORK(&steam->mode_switch, steam_mode_switch_cb);
>>  	INIT_LIST_HEAD(&steam->list);
>>  	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
>> +	steam->sensor_timestamp_us = 0;
>>  
>>  	/*
>>  	 * With the real steam controller interface, do not connect hidraw.
>> @@ -1380,12 +1487,12 @@ static void steam_do_input_event(struct steam_device *steam,
>>   *  18-19 | s16   | ABS_HAT0Y | left-pad Y value
>>   *  20-21 | s16   | ABS_HAT1X | right-pad X value
>>   *  22-23 | s16   | ABS_HAT1Y | right-pad Y value
>> - *  24-25 | s16   | --        | accelerometer X value
>> - *  26-27 | s16   | --        | accelerometer Y value
>> - *  28-29 | s16   | --        | accelerometer Z value
>> - *  30-31 | s16   | --        | gyro X value
>> - *  32-33 | s16   | --        | gyro Y value
>> - *  34-35 | s16   | --        | gyro Z value
>> + *  24-25 | s16   | IMU ABS_X | accelerometer X value
>> + *  26-27 | s16   | IMU ABS_Z | accelerometer Y value
>> + *  28-29 | s16   | IMU ABS_Y | accelerometer Z value
>> + *  30-31 | s16   | IMU ABS_RX | gyro X value
>> + *  32-33 | s16   | IMU ABS_RZ | gyro Y value
>> + *  34-35 | s16   | IMU ABS_RY | gyro Z value
>>   *  36-37 | s16   | --        | quaternion W value
>>   *  38-39 | s16   | --        | quaternion X value
>>   *  40-41 | s16   | --        | quaternion Y value
>> @@ -1546,6 +1653,32 @@ static void steam_do_deck_input_event(struct steam_device *steam,
>>  	input_sync(input);
>>  }
>>  
>> +static void steam_do_deck_sensors_event(struct steam_device *steam,
>> +		struct input_dev *sensors, u8 *data)
>> +{
>> +	/*
>> +	 * The deck input report is received every 4 ms on average,
>> +	 * with a jitter of +/- 4 ms even though the USB descriptor claims
>> +	 * that it uses 1 kHz.
>> +	 * Since the HID report does not include a sensor timestamp,
>> +	 * use a fixed increment here.
>> +	 *
>> +	 * The reported sensors data is factory calibrated by default so
>> +	 * no extra logic for handling calibratrion is necessary.
>> +	 */
>> +	steam->sensor_timestamp_us += 4000;
>> +	input_event(sensors, EV_MSC, MSC_TIMESTAMP, steam->sensor_timestamp_us);
>> +
>> +	input_report_abs(sensors, ABS_X, steam_le16(data + 24));
>> +	input_report_abs(sensors, ABS_Z, -steam_le16(data + 26));
>> +	input_report_abs(sensors, ABS_Y, steam_le16(data + 28));
>> +	input_report_abs(sensors, ABS_RX, steam_le16(data + 30));
>> +	input_report_abs(sensors, ABS_RZ, -steam_le16(data + 32));
>> +	input_report_abs(sensors, ABS_RY, steam_le16(data + 34));
>> +
>> +	input_sync(sensors);
>> +}
>> +
>>  /*
>>   * The size for this message payload is 11.
>>   * The known values are:
>> @@ -1583,6 +1716,7 @@ static int steam_raw_event(struct hid_device *hdev,
>>  {
>>  	struct steam_device *steam = hid_get_drvdata(hdev);
>>  	struct input_dev *input;
>> +	struct input_dev *sensors;
>>  	struct power_supply *battery;
>>  
>>  	if (!steam)
>> @@ -1629,6 +1763,14 @@ static int steam_raw_event(struct hid_device *hdev,
>>  		if (likely(input))
>>  			steam_do_deck_input_event(steam, input, data);
>>  		rcu_read_unlock();
>> +
>> +		if (steam->quirks & STEAM_QUIRK_DECK) {

This report ID is only sent on the Steam Deck. Checking the quirk here is unnecessary, especially since it'll just be null and fail out if something weird happens and we get this report on a non-Deck device.

>> +			rcu_read_lock();
>> +			sensors = rcu_dereference(steam->sensors);
>> +			if (likely(sensors))
>> +				steam_do_deck_sensors_event(steam, sensors, data);
>> +			rcu_read_unlock();
>> +		}
>>  		break;
>>  	case ID_CONTROLLER_WIRELESS:
>>  		/*
>>
>> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
>> -- 
>> 2.44.0
>>
> 

Implementation looks mostly fine. However, I had some discussion with people at Valve about this who said they'd like the IMU to be silenced when gamepad mode is disabled the same way the gamepad data is.

Vicki

