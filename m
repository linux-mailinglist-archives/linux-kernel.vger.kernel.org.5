Return-Path: <linux-kernel+bounces-157966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A68B1979
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B337F1F23101
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55521379;
	Thu, 25 Apr 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="Y+jLAUpP"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682031CFBC;
	Thu, 25 Apr 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015572; cv=none; b=D90XAff/2NnREsi/pwSdc/ExRjGIJBRr2R+nST3rvjzer4KNuA6YmzI+sSTTuzo9mwHiIH6n1E+HYneSHd15nLPeq6zfRd2UHXLGR5sT47RNljaDSyvhLkiONhRhQIkx74fORGUJ61BS16DD1HIqR1cBwimiOYElEg8a3/dhtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015572; c=relaxed/simple;
	bh=wK5vyYcwPVAWU7hn2RU6otvN8hIlPdrQoWg66De1424=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OwEM4hpPMGyf47ntXGdtosft1GcS3sycFFyQDiBEoFQ3cs7bLSwpfRL2d1S44xfJnwRDNVwhcuACDUJBx7/cg5hKmVbFIcaMRdqB34IpwAVVEHyHDot8iCyMfNOgbkLYcKC3DRVhuymReXkw4e9CFnggxLN1fC1TqiupwfHJV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=Y+jLAUpP; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 511D5C005F;
	Wed, 24 Apr 2024 23:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714015654; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wKQqhvjCnwePtvQuR8aaJD84f/wV5y4ev28hOd21474=;
	b=Y+jLAUpP9rCQVlobVGwI+p2IoQe2g4z9xbgr1HoOwoU9MH936nMo2kcwBrvwNt2i5PNr27
	XNY7V7w1NHVCX9luL2MzblAFN2HQ37uQ44/IEFYOq7UrBtgT60o4vGL2f0PBDjRonGsDr2
	wOyDeuTaG4pW/ytfgeFdM6H2dPQRZ4o=
Message-ID: <d51409a2-d336-4b93-9506-a2bb0c9a7ef4@kaechele.ca>
Date: Wed, 24 Apr 2024 23:26:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] HID: Add Himax HX83102J touchscreen driver
To: Allen_Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417074115.1137885-1-allencl_lin@hotmail.com>
 <TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hey there,

I've recently been working on adding HX83100A support to the already 
existing himax_hx83112b driver. So I thought I'd take a look at this, too.

First of all, thank you for providing documented code. The vendor 
released code is much harder to parse and understand, especially given 
that there is almost no commentary.
With the chip family having strong similarities between chips this is 
helpful for my HX83100A additions to the himax_hx83112b driver.

As far as I understand (and given that I have no access to data sheets 
and register maps) HX83112B and HX83100A are I2C, not SPI, and also 
don't emit HID packets internally, but a custom event data structure.
So there are certainly some differences with that.
But registers and sequences are identical, even with the different 
busses involved.

I'm sure there could be some value in combining efforts for both 
drivers. At the same time I see that this is supposed to go in as a hid 
driver, not into input/touchscreen. So I don't know how practical 
combining things would be. So  my comments below may possibly be 
irrelevant if the HX83102J is the only HID over SPI chip in the family.

My comments inline are based on what I learned from studying the vendor 
driver at https://github.com/HimaxSoftware/HX83112_Android_Driver and 
https://github.com/HimaxSoftware/HX83100_Android_Driver

On 2024-04-17 03:41, Allen_Lin wrote:
> Add a new driver for Himax HX83102J touchscreen controllers.
> This driver supports Himax IC using the SPI interface to
> acquire HID packets.
> 
> After confirmed the IC's exsitence the driver loads the firmware
> image from flash to get the HID report descriptor, VID and PID.
> And use those information to register HID device.
> 
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> ---
>   MAINTAINERS             |    1 +
>   drivers/hid/Kconfig     |    7 +
>   drivers/hid/Makefile    |    2 +
>   drivers/hid/hid-himax.c | 1768 +++++++++++++++++++++++++++++++++++++++
>   drivers/hid/hid-himax.h |  288 +++++++
>   5 files changed, 2066 insertions(+)
>   create mode 100644 drivers/hid/hid-himax.c
>   create mode 100644 drivers/hid/hid-himax.h
> 

..

> diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
> new file mode 100644
> index 000000000000..f8a417e07f0c
> --- /dev/null
> +++ b/drivers/hid/hid-himax.c
> @@ -0,0 +1,1768 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Himax hx83102j SPI Driver Code for HID.
> + *
> + * Copyright (C) 2024 Himax Corporation.
> + */

..

> +/**
> + * hx83102j_sense_off() - Stop MCU and enter safe mode
> + * @ts: Himax touch screen data
> + * @check_en: Check if need to ensure FW is stopped by its owne process
> + *
> + * Sense off is a process to make sure the MCU inside the touch chip is stopped.
> + * The process has two stage, first stage is to request FW to stop. Write
> + * HIMAX_REG_DATA_FW_GO_SAFEMODE to HIMAX_REG_ADDR_CTRL_FW tells the FW to stop by its own.
> + * Then read back the FW status to confirm the FW is stopped. When check_en is true,
> + * the function will resend the stop FW command until the retry limit reached.
> + * There maybe a chance that the FW is not stopped by its own, in this case, the
> + * safe mode in next stage still stop the MCU, but FW internal flag may not be
> + * configured correctly. The second stage is to enter safe mode and reset TCON.
> + * Safe mode is a mode that the IC circuit ensure the internal MCU is stopped.
> + * Since this IC is TDDI, the TCON need to be reset to make sure the IC is ready
> + * for next operation.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int hx83102j_sense_off(struct himax_ts_data *ts, bool check_en)
> +{
> +	int ret;
> +	u32 retry_cnt;
> +	const u32 stop_fw_retry_limit = 35;
> +	const u32 enter_safe_mode_retry_limit = 5;
> +	const union himax_dword_data safe_mode = {
> +		.dword = cpu_to_le32(HIMAX_REG_DATA_FW_GO_SAFEMODE)
> +	};
> +	union himax_dword_data data;
> +
> +	dev_info(ts->dev, "%s: check %s\n", __func__, check_en ? "True" : "False");
> +	if (!check_en)
> +		goto without_check;
> +
> +	for (retry_cnt = 0; retry_cnt < stop_fw_retry_limit; retry_cnt++) {
> +		if (retry_cnt == 0 ||
> +		    (data.byte[0] != HIMAX_REG_DATA_FW_GO_SAFEMODE &&
> +		    data.byte[0] != HIMAX_REG_DATA_FW_RE_INIT &&
> +		    data.byte[0] != HIMAX_REG_DATA_FW_IN_SAFEMODE)) {
> +			ret = himax_mcu_register_write(ts, HIMAX_REG_ADDR_CTRL_FW,
> +						       safe_mode.byte, 4);
> +			if (ret < 0) {
> +				dev_err(ts->dev, "%s: stop FW failed\n", __func__);
> +				return ret;
> +			}
> +		}
> +		usleep_range(10000, 11000);
> +
> +		ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_FW_STATUS, data.byte, 4);
> +		if (ret < 0) {
> +			dev_err(ts->dev, "%s: read central state failed\n", __func__);
> +			return ret;
> +		}
> +		if (data.byte[0] != HIMAX_REG_DATA_FW_STATE_RUNNING) {
> +			dev_info(ts->dev, "%s: Do not need wait FW, Status = 0x%02X!\n", __func__,
> +			  data.byte[0]);
> +			break;
> +		}
> +
> +		ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_CTRL_FW, data.byte, 4);
> +		if (ret < 0) {
> +			dev_err(ts->dev, "%s: read ctrl FW failed\n", __func__);
> +			return ret;
> +		}
> +		if (data.byte[0] == HIMAX_REG_DATA_FW_IN_SAFEMODE)
> +			break;
> +	}
> +
> +	if (data.byte[0] != HIMAX_REG_DATA_FW_IN_SAFEMODE)
> +		dev_warn(ts->dev, "%s: Failed to stop FW!\n", __func__);
> +
> +without_check:
> +	for (retry_cnt = 0; retry_cnt < enter_safe_mode_retry_limit; retry_cnt++) {
> +		/* set Enter safe mode : 0x31 ==> 0x9527 */
> +		data.word[0] = cpu_to_le16(HIMAX_HX83102J_SAFE_MODE_PASSWORD);
> +		ret = himax_write(ts, HIMAX_AHB_ADDR_PSW_LB, NULL, data.byte, 2);
> +		if (ret < 0) {
> +			dev_err(ts->dev, "%s: enter safe mode failed\n", __func__);
> +			return ret;
> +		}
> +
> +		/* Check enter_save_mode */
> +		ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_FW_STATUS, data.byte, 4);
> +		if (ret < 0) {
> +			dev_err(ts->dev, "%s: read central state failed\n", __func__);
> +			return ret;
> +		}
> +
> +		if (data.byte[0] == HIMAX_REG_DATA_FW_STATE_SAFE_MODE) {
> +			dev_info(ts->dev, "%s: Safe mode entered\n", __func__);
> +			/* Reset TCON */
> +			data.dword = cpu_to_le32(HIMAX_REG_DATA_TCON_RST);
> +			ret = himax_mcu_register_write(ts, HIMAX_HX83102J_REG_ADDR_TCON_RST,
> +						       data.byte, 4);
> +			if (ret < 0) {
> +				dev_err(ts->dev, "%s: reset TCON failed\n", __func__);
> +				return ret;
> +			}
> +			usleep_range(1000, 1100);
> +			return 0;
> +		}
> +		usleep_range(5000, 5100);
> +		hx83102j_pin_reset(ts);
> +	}
> +	dev_err(ts->dev, "%s: failed!\n", __func__);
> +
> +	return -EIO;
> +}
> +

Used generically across HX831xx family (except HX83100A): 
https://github.com/HimaxSoftware/HX83112_Android_Driver/blob/939400d4d4bf614bbeff51e1986760b47dde9eab/hxchipset/himax_ic_incell_core.c#L404

Also, HIMAX_HX83102J_SAFE_MODE_PASSWORD doesn't seem specific to the 
HX83102J.
This actually apply to a number of the HIMAX_HX83102J_* defines 
throughout the code.

> +/**
> + * hx83102j_chip_detect() - Check if the touch chip is HX83102J
> + * @ts: Himax touch screen data
> + *
> + * This function is used to check if the touch chip is HX83102J. The process
> + * start with a hardware reset to the touch chip, then knock the IC bus interface
> + * to wakeup the IC bus interface. Then sense off the MCU to prevent bus conflict
> + * when reading the IC ID. The IC ID is read from the IC register, and compare
> + * with the expected ID. If the ID is matched, the chip is HX83102J. Due to display
> + * IC initial code may not ready before the IC ID is read, the function will retry
> + * to read the IC ID for several times to make sure the IC ID is read correctly.
> + * In any case, the SPI bus shouldn't have error when reading the IC ID, so the
> + * function will return error if the SPI bus has error. When the IC is not HX83102J,
> + * the function will return -ENODEV.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int hx83102j_chip_detect(struct himax_ts_data *ts)
> +{
> +	int ret;
> +	u32 retry_cnt;
> +	const u32 read_icid_retry_limit = 5;
> +	const u32 ic_id_mask = GENMASK(31, 8);
> +	union himax_dword_data data;
> +
> +	hx83102j_pin_reset(ts);
> +	ret = himax_mcu_interface_on(ts);
> +	if (ret)
> +		return ret;
> +
> +	ret = hx83102j_sense_off(ts, false);
> +	if (ret)
> +		return ret;
> +
> +	for (retry_cnt = 0; retry_cnt < read_icid_retry_limit; retry_cnt++) {
> +		ret = himax_mcu_register_read(ts, HIMAX_REG_ADDR_ICID, data.byte, 4);
> +		if (ret) {
> +			dev_err(ts->dev, "%s: Read IC ID Fail\n", __func__);
> +			return ret;
> +		}
> +
> +		data.dword = le32_to_cpu(data.dword);
> +		if ((data.dword & ic_id_mask) == HIMAX_REG_DATA_ICID) {
> +			ts->ic_data.icid = data.dword;
> +			dev_info(ts->dev, "%s: Detect IC HX83102J successfully\n", __func__);
> +			return 0;
> +		}
> +	}
> +	dev_err(ts->dev, "%s: Read driver ID register Fail! IC ID = %X,%X,%X\n", __func__,
> +	  data.byte[3], data.byte[2], data.byte[1]);
> +
> +	return -ENODEV;
> +}
> +

Same here, this is also used generically across all chips in the family 
(except HX83100A).

..

> +/**
> + * hx83102j_read_event_stack() - Read event stack from touch chip
> + * @ts: Himax touch screen data
> + * @buf: Buffer to store the data
> + * @length: Length of data to read
> + *
> + * This function is used to read the event stack from the touch chip. The event stack
> + * is an AHB output buffer, which store the touch report data.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int hx83102j_read_event_stack(struct himax_ts_data *ts, u8 *buf, u32 length)
> +{
> +	u32 i;
> +	int ret;
> +	const u32 max_trunk_sz = ts->spi_xfer_max_sz - HIMAX_BUS_R_HLEN;
> +
> +	for (i = 0; i < length; i += max_trunk_sz) {
> +		ret = himax_read(ts, HIMAX_AHB_ADDR_EVENT_STACK, buf + i,
> +				 min(length - i, max_trunk_sz));
> +		if (ret) {
> +			dev_err(ts->dev, "%s: read event stack error!\n", __func__);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

Again, generic across HX831xx (except HX83100A).

Regards,
Felix

