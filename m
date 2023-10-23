Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C47D38D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjJWOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjJWOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:04:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F362110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:04:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso581571f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698069877; x=1698674677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feOKUCgu/NwWDJRdl5k00+5MbUdrzhLpwZuuii6+kaw=;
        b=C/q7geUvj5BPCfDAEpc5fH2qGpQKXMydwwdEGvsD5fdW8oLGOfdx7lAxNs26aW1Lqd
         TVSfW289P4rIgRuhKkHjDw7yy6O5y6pZgj/huAlF1nFivxiIdKJOkza3E9Yk4LBY0Ae+
         uhrIjcm7lm+4fJ0TsrNSocVG6zLcBBd3bpjPkEkj9RY7BUV8m4IGwDx9pe60BgbdAL1i
         Cs/o7U3pdeN6/4ckc04PRYWSBOCqokgHd8ZmTYpaPjUXRuoTVQDSEEXc0n6K5X361r8l
         yDMtU643KAgXZgpsbUj445xh2yzjy8OBgJKltrMgXY/iiCjSlHWYa0OhflBLQ2b5FXSs
         LdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069877; x=1698674677;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=feOKUCgu/NwWDJRdl5k00+5MbUdrzhLpwZuuii6+kaw=;
        b=pGImwAOFmksPhLxcHlbtocwL7U6SQ3TLjTCq4GH7OaHvYqqoi5ImL00SdLlDzATHo2
         De17YWb2xu+N344xBTdFPKUzvKhKuz9k27rMmEeG0dwJwIE6U7W+co8y4I/T31mzjUgr
         zLCDM1S2H0ESckavVqKnYRuEeGClewTfTSU0RWChGPpEluppPAzj+QiD6yzyEWA1UnQL
         qs03GzLddp92royyt5zuTjofelRROcs+ZkQ3hHOKVUBzPPmIWclybo/eMeeK9tvKV6um
         F2ZkqtMgRicU2bTK7B6dkXFUjH/5PWUTfBUHdS0xt6CH0zdgx77u8BXiNquBR/G0NC0n
         rSoA==
X-Gm-Message-State: AOJu0Yxo46+6ad5yuylpXjEdWE/HGZEiB0jaec50ZDCvfBbyu10g5ulb
        z4OqYDk2Ul0e++mUrRubzZmKtw==
X-Google-Smtp-Source: AGHT+IHy+5g34JuyY2T0tSV2kR1cQY5CepkcDP3rqVrwZ20pyk2L/CnPgo0cBTG/n9ky2O9UJlK/xw==
X-Received: by 2002:adf:e808:0:b0:32d:9a36:b518 with SMTP id o8-20020adfe808000000b0032d9a36b518mr6259762wrm.69.1698069877341;
        Mon, 23 Oct 2023 07:04:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b003140f47224csm7796062wrx.15.2023.10.23.07.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:04:36 -0700 (PDT)
Message-ID: <925cc416-e8e0-4a68-addb-8a7d11d3895c@linaro.org>
Date:   Mon, 23 Oct 2023 16:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v9 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Content-Language: en-US, fr
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org>
 <20231021-topic-goodix-berlin-upstream-initial-v9-2-13fb4e887156@linaro.org>
 <ZTX4dPa3CxZacDph@google.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <ZTX4dPa3CxZacDph@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 23/10/2023 06:37, Dmitry Torokhov wrote:
> Hi Neil,
> 
> On Sat, Oct 21, 2023 at 01:09:24PM +0200, Neil Armstrong wrote:
>> +static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
>> +{
>> +	u8 afe_data[GOODIX_BERLIN_IC_INFO_MAX_LEN];
> 
> You probably already saw the kernel test robot message, I think we
> should allocate this buffer in the heap (and free it once its no longer
> needed).

Indeed I haven't received it on 9 patch submitting, anyway moved it to head.

> 
>> +	__le16 length_raw;
>> +	u16 length;
>> +	int error;
>> +
>> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
>> +				&length_raw, sizeof(length_raw));
>> +	if (error) {
>> +		dev_info(cd->dev, "failed get ic info length, %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	length = le16_to_cpu(length_raw);
>> +	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
>> +		dev_info(cd->dev, "invalid ic info length %d\n", length);
>> +		return -EINVAL;
>> +	}
>> +
>> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
>> +				afe_data, length);
>> +	if (error) {
>> +		dev_info(cd->dev, "failed get ic info data, %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	/* check whether the data is valid (ex. bus default values) */
>> +	if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {
> 
> This cast is not needed.
> 
>> +		dev_err(cd->dev, "fw info data invalid\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!goodix_berlin_checksum_valid((const uint8_t *)afe_data, length)) {
> 
> This cast is not needed either.
> 
>> +		dev_info(cd->dev, "fw info checksum error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
>> +	if (error)
>> +		return error;
>> +
>> +	/* check some key info */
>> +	if (!cd->touch_data_addr) {
>> +		dev_err(cd->dev, "touch_data_addr is null\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
>> +				       const void *buf, int touch_num)
>> +{
>> +	const struct goodix_berlin_touch_data *touch_data = buf;
>> +	int i;
>> +
>> +	/* Check for data validity */
>> +	for (i = 0; i < touch_num; i++) {
>> +		unsigned int id;
>> +
>> +		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, touch_data[i].id);
>> +
>> +		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
>> +			dev_warn(cd->dev, "invalid finger id %d\n", id);
>> +			return;
> 
> Is it important to abort entire packet if one if the slots has incorrect
> data? Can we simply skip over these contacts?

Indeed, merged the for loops and simply skip the invalid finger id.

> 
>> +		}
>> +	}
>> +
>> +	/* Report finger touches */
>> +	for (i = 0; i < touch_num; i++) {
>> +		input_mt_slot(cd->input_dev,
>> +			      FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
>> +					touch_data[i].id));
>> +		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
>> +
>> +		touchscreen_report_pos(cd->input_dev, &cd->props,
>> +				       __le16_to_cpu(touch_data[i].x),
>> +				       __le16_to_cpu(touch_data[i].y),
>> +				       true);
>> +		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
>> +				 __le16_to_cpu(touch_data[i].w));
>> +	}
>> +
>> +	input_mt_sync_frame(cd->input_dev);
>> +	input_sync(cd->input_dev);
>> +}
>> +
>> +static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
>> +					const void *pre_buf, u32 pre_buf_len)
>> +{
>> +	static u8 buffer[GOODIX_BERLIN_IRQ_READ_LEN(GOODIX_BERLIN_MAX_TOUCH)];
> 
> No, please no static data. The drivers should be ready to handle more
> than one device on a system. If the buffer is large-ish put it into
> goodix_berlin_core.

This is a typo from vendor kernel, I didn't want a static buffer here...

The buffer is only 26 bytes, it's small enough to stay here in non-static.

> 
> 
>> +	u8 point_type, touch_num;
>> +	int error;
>> +
>> +	/* copy pre-data to buffer */
>> +	memcpy(buffer, pre_buf, pre_buf_len);
>> +
>> +	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
>> +			      buffer[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
>> +
>> +	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
>> +		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
>> +		return;
>> +	}
>> +
>> +	if (touch_num) {
>> +		/* read more data if more than 2 touch events */
>> +		if (unlikely(touch_num > 2)) {
>> +			error = regmap_raw_read(cd->regmap,
>> +						cd->touch_data_addr + pre_buf_len,
>> +						&buffer[pre_buf_len],
>> +						(touch_num - 2) * GOODIX_BERLIN_BYTES_PER_POINT);
>> +			if (error) {
>> +				dev_err_ratelimited(cd->dev, "failed to get touch data, %d\n",
>> +						    error);
>> +				return;
>> +			}
>> +		}
>> +
>> +		point_type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK,
>> +				       buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
>> +
>> +		if (point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
>> +		    point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
>> +			dev_warn_once(cd->dev, "Stylus event type not handled\n");
>> +			return;
>> +		}
>> +
>> +		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
>> +						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
>> +			dev_err(cd->dev, "touch data checksum error, data: %*ph\n",
>> +				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
>> +				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
>> +			return;
>> +		}
>> +	}
>> +
>> +	goodix_berlin_parse_finger(cd, &buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
>> +				   touch_num);
>> +}
>> +
>> +static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
>> +{
>> +	gpiod_set_value(cd->reset_gpio, 1);
>> +	usleep_range(2000, 2100);
>> +	gpiod_set_value(cd->reset_gpio, 0);
>> +
>> +	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
> 
> The reset line handling is optional, we should skip waits if there is
> no GPIO defined for the board.

Ack, instead I only call this if gpio is valid.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
>> +{
>> +	struct goodix_berlin_core *cd = data;
>> +	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
>> +	u8 event_status;
>> +	int error;
>> +
>> +	/* First, read buffer with space for 2 touch events */
>> +	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
>> +				GOODIX_BERLIN_IRQ_READ_LEN(2));
>> +	if (error) {
>> +		dev_err_ratelimited(cd->dev, "failed get event head data, %d\n", error);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (buf[GOODIX_BERLIN_STATUS_OFFSET] == 0)
>> +		return IRQ_HANDLED;
>> +
>> +	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
>> +		dev_warn_ratelimited(cd->dev, "touch head checksum err : %*ph\n",
>> +				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
>> +
>> +	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
>> +		goodix_berlin_touch_handler(cd, buf, GOODIX_BERLIN_IRQ_READ_LEN(2));
>> +
>> +	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
>> +		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
>> +		case GOODIX_BERLIN_REQUEST_CODE_RESET:
>> +			goodix_berlin_request_handle_reset(cd);
>> +			break;
>> +
>> +		default:
>> +			dev_warn(cd->dev, "unsupported request code 0x%x\n",
>> +				 buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
>> +		}
>> +	}
>> +
>> +	/* Clear up status field */
>> +	regmap_write(cd->regmap, cd->touch_data_addr, 0);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
>> +					  const struct input_id *id)
>> +{
>> +	struct input_dev *input_dev;
>> +	int error;
>> +
>> +	input_dev = devm_input_allocate_device(cd->dev);
>> +	if (!input_dev)
>> +		return -ENOMEM;
>> +
>> +	cd->input_dev = input_dev;
>> +	input_set_drvdata(input_dev, cd);
>> +
>> +	input_dev->name = "Goodix Berlin Capacitive TouchScreen";
>> +	input_dev->phys = "input/ts";
>> +
>> +	input_dev->id = *id;
>> +
>> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
>> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
>> +	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>> +
>> +	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
>> +
>> +	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
>> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>> +	if (error)
>> +		return error;
>> +
>> +	return input_register_device(cd->input_dev);
> 
> Please in functions with multiple possible failure paths use format
> 
> 	error = op(...);
> 	if (error)
> 		return error;
> 
> 	return 0;

Ack, will check for this in the whole patchset.

Thanks for review,
Neil

> 
> Thanks.
> 

