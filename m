Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E67D294E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJWEhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWEhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:37:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465CFC;
        Sun, 22 Oct 2023 21:37:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9e072472bso17039185ad.2;
        Sun, 22 Oct 2023 21:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698035832; x=1698640632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbBRX2jJlyHvVSg6fxWudjXJuNB/hXK9P8KU1NFtc+8=;
        b=EqgrGjZD94+rtwv9HELrsMIKAfiy9CUsZAVaJlXEC6dwq8lamZYuClFVRbhV+gQn/o
         32SeXJA+XtEWePFjMumiNYS5cSs2OVwpGKXnZ7RUS0Ec1xxZRIp3YocVWtt2y/FMtc9B
         7i2/a/mfMKxET8qUlt/Ge/5frcLbbz8qEzPwSgzCf8U+/B7OiJ8FrDNU+jyAlEDtPe2d
         7/MveoTY5CW9fPf2/3P0l3bK3XcrJ9GBRlcvKPUDnMHoqv2onoh2N38ClVM0riMqEozS
         b5AMlVtD92Vxa0c5s728yStYeRov35gxv4kbCbWCD63p4MFepOzPRKqQtbPiUTAFqxhS
         6BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698035832; x=1698640632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbBRX2jJlyHvVSg6fxWudjXJuNB/hXK9P8KU1NFtc+8=;
        b=PxDrlCSbAgFLmp21cYMPAD8AaLjESQXBiuCrXEBYwTwjOLJ20HFU++2uSyl7e3xFZT
         6BSsYDJeCw73R8TJRITGyd834UbVMkCdIua4k9qD5SV1TxMB7kmThXyAFqvF7TkeAHzc
         azdCJr7qtBWQyI0dKnWPmp3wCNVksUN36/OyOrbtuyUDfOXmhjrmCS/3ed92CUcdweHZ
         fmog4Khkpb45P5ZIvZDlkZ5IAmIn8W4I1DYZe6i7JVa2Tqp3K6E8dY9ZZjR221kmy/eW
         pO51ZW0V2EAJOj6mr8rJHpcHc62LLC+WVLU/1ZFZygK7e3a3ZEH2MVqh36SFQgod8RoZ
         6OsA==
X-Gm-Message-State: AOJu0Ywc+WsiNuH7hRuRgTfzykeGTRO+bcMo6YHYlylRpORCA00dpbhZ
        Q0Xwxd19tmxFZ0mAePU5lN3MduFn16k=
X-Google-Smtp-Source: AGHT+IG3Cv1PrEpfwdKo9dnDJh83E0rbwK+l6VxU2v/xHO0SRF8V3dClgsiiJ0IsXHwuiM7cS71bQg==
X-Received: by 2002:a17:902:7407:b0:1ca:86db:1d31 with SMTP id g7-20020a170902740700b001ca86db1d31mr6216447pll.7.1698035831964;
        Sun, 22 Oct 2023 21:37:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:40e3:3912:b22a:135e])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001b8a2edab6asm5097264plh.244.2023.10.22.21.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 21:37:11 -0700 (PDT)
Date:   Sun, 22 Oct 2023 21:37:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Message-ID: <ZTX4dPa3CxZacDph@google.com>
References: <20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org>
 <20231021-topic-goodix-berlin-upstream-initial-v9-2-13fb4e887156@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021-topic-goodix-berlin-upstream-initial-v9-2-13fb4e887156@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Sat, Oct 21, 2023 at 01:09:24PM +0200, Neil Armstrong wrote:
> +static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
> +{
> +	u8 afe_data[GOODIX_BERLIN_IC_INFO_MAX_LEN];

You probably already saw the kernel test robot message, I think we
should allocate this buffer in the heap (and free it once its no longer
needed).

> +	__le16 length_raw;
> +	u16 length;
> +	int error;
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				&length_raw, sizeof(length_raw));
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info length, %d\n", error);
> +		return error;
> +	}
> +
> +	length = le16_to_cpu(length_raw);
> +	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
> +		dev_info(cd->dev, "invalid ic info length %d\n", length);
> +		return -EINVAL;
> +	}
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				afe_data, length);
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info data, %d\n", error);
> +		return error;
> +	}
> +
> +	/* check whether the data is valid (ex. bus default values) */
> +	if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {

This cast is not needed.

> +		dev_err(cd->dev, "fw info data invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!goodix_berlin_checksum_valid((const uint8_t *)afe_data, length)) {

This cast is not needed either.

> +		dev_info(cd->dev, "fw info checksum error\n");
> +		return -EINVAL;
> +	}
> +
> +	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
> +	if (error)
> +		return error;
> +
> +	/* check some key info */
> +	if (!cd->touch_data_addr) {
> +		dev_err(cd->dev, "touch_data_addr is null\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
> +				       const void *buf, int touch_num)
> +{
> +	const struct goodix_berlin_touch_data *touch_data = buf;
> +	int i;
> +
> +	/* Check for data validity */
> +	for (i = 0; i < touch_num; i++) {
> +		unsigned int id;
> +
> +		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, touch_data[i].id);
> +
> +		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
> +			dev_warn(cd->dev, "invalid finger id %d\n", id);
> +			return;

Is it important to abort entire packet if one if the slots has incorrect
data? Can we simply skip over these contacts?

> +		}
> +	}
> +
> +	/* Report finger touches */
> +	for (i = 0; i < touch_num; i++) {
> +		input_mt_slot(cd->input_dev,
> +			      FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
> +					touch_data[i].id));
> +		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
> +
> +		touchscreen_report_pos(cd->input_dev, &cd->props,
> +				       __le16_to_cpu(touch_data[i].x),
> +				       __le16_to_cpu(touch_data[i].y),
> +				       true);
> +		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
> +				 __le16_to_cpu(touch_data[i].w));
> +	}
> +
> +	input_mt_sync_frame(cd->input_dev);
> +	input_sync(cd->input_dev);
> +}
> +
> +static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
> +					const void *pre_buf, u32 pre_buf_len)
> +{
> +	static u8 buffer[GOODIX_BERLIN_IRQ_READ_LEN(GOODIX_BERLIN_MAX_TOUCH)];

No, please no static data. The drivers should be ready to handle more
than one device on a system. If the buffer is large-ish put it into
goodix_berlin_core.


> +	u8 point_type, touch_num;
> +	int error;
> +
> +	/* copy pre-data to buffer */
> +	memcpy(buffer, pre_buf, pre_buf_len);
> +
> +	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
> +			      buffer[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
> +
> +	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
> +		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
> +		return;
> +	}
> +
> +	if (touch_num) {
> +		/* read more data if more than 2 touch events */
> +		if (unlikely(touch_num > 2)) {
> +			error = regmap_raw_read(cd->regmap,
> +						cd->touch_data_addr + pre_buf_len,
> +						&buffer[pre_buf_len],
> +						(touch_num - 2) * GOODIX_BERLIN_BYTES_PER_POINT);
> +			if (error) {
> +				dev_err_ratelimited(cd->dev, "failed to get touch data, %d\n",
> +						    error);
> +				return;
> +			}
> +		}
> +
> +		point_type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK,
> +				       buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
> +
> +		if (point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
> +		    point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
> +			dev_warn_once(cd->dev, "Stylus event type not handled\n");
> +			return;
> +		}
> +
> +		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
> +						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
> +			dev_err(cd->dev, "touch data checksum error, data: %*ph\n",
> +				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
> +				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
> +			return;
> +		}
> +	}
> +
> +	goodix_berlin_parse_finger(cd, &buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
> +				   touch_num);
> +}
> +
> +static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
> +{
> +	gpiod_set_value(cd->reset_gpio, 1);
> +	usleep_range(2000, 2100);
> +	gpiod_set_value(cd->reset_gpio, 0);
> +
> +	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);

The reset line handling is optional, we should skip waits if there is
no GPIO defined for the board. 

> +
> +	return 0;
> +}
> +
> +static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
> +{
> +	struct goodix_berlin_core *cd = data;
> +	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
> +	u8 event_status;
> +	int error;
> +
> +	/* First, read buffer with space for 2 touch events */
> +	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
> +				GOODIX_BERLIN_IRQ_READ_LEN(2));
> +	if (error) {
> +		dev_err_ratelimited(cd->dev, "failed get event head data, %d\n", error);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (buf[GOODIX_BERLIN_STATUS_OFFSET] == 0)
> +		return IRQ_HANDLED;
> +
> +	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
> +		dev_warn_ratelimited(cd->dev, "touch head checksum err : %*ph\n",
> +				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
> +		return IRQ_HANDLED;
> +	}
> +
> +	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
> +
> +	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
> +		goodix_berlin_touch_handler(cd, buf, GOODIX_BERLIN_IRQ_READ_LEN(2));
> +
> +	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
> +		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
> +		case GOODIX_BERLIN_REQUEST_CODE_RESET:
> +			goodix_berlin_request_handle_reset(cd);
> +			break;
> +
> +		default:
> +			dev_warn(cd->dev, "unsupported request code 0x%x\n",
> +				 buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
> +		}
> +	}
> +
> +	/* Clear up status field */
> +	regmap_write(cd->regmap, cd->touch_data_addr, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
> +					  const struct input_id *id)
> +{
> +	struct input_dev *input_dev;
> +	int error;
> +
> +	input_dev = devm_input_allocate_device(cd->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	cd->input_dev = input_dev;
> +	input_set_drvdata(input_dev, cd);
> +
> +	input_dev->name = "Goodix Berlin Capacitive TouchScreen";
> +	input_dev->phys = "input/ts";
> +
> +	input_dev->id = *id;
> +
> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
> +	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
> +
> +	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return error;
> +
> +	return input_register_device(cd->input_dev);

Please in functions with multiple possible failure paths use format

	error = op(...);
	if (error)
		return error;

	return 0;

Thanks.

-- 
Dmitry
