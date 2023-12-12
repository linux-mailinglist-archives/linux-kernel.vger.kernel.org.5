Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA580EC90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376345AbjLLMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376316AbjLLMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:52:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95C94;
        Tue, 12 Dec 2023 04:52:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bffb64178so6647586e87.2;
        Tue, 12 Dec 2023 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702385550; x=1702990350; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=EZImJ5NJjRfBoNfU+X+bVEpeupm2kDE/0IXPJJmjz3c=;
        b=N9mw2gbxXxWjuCRnGGUsgkNLZB/0jnnAPNwRSsq1NXPD8MrDnof1Vcqbll0CxTQJA8
         XMqqMVnazbvwkdlymNgK23ZckTAGl50IqdCrLtZOJ/NcA9aCzhyjL+VOfEdWeWEbjzHL
         Ou8Zm6C5brl0IkMcOW77mDLvI6L2BmA3ZeiKoPwDXIPTXLzlHtihK/ODG6RrUvyBFT8M
         yOt2O4Qww6MpxPTyIRKmQgwldCiwhMI9qogOi3+wHt9uHQl4IJfCmXpLo3WgXij2cYqO
         GtrnhwcsRv3h3TxZR8fTjF7ADXvVLhS6Jj3UUVDsIHHPuUHd6XPo5O87BhftbWhovzgM
         rgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385550; x=1702990350;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZImJ5NJjRfBoNfU+X+bVEpeupm2kDE/0IXPJJmjz3c=;
        b=CUq8Iwbp7dydFUO7iv5KM4HcPiXEnxjnLZg+DRLdyIM2V2wloqwwWqtQ2MnJB2fZWM
         8fTPLAjeRfHGURv9IdbvVI0FVGjhtxZa+cegSPzRm/rLrOVNPKFwaKJti4uN7wlbJ941
         Ucg7smR8HuptGMJn8q+dPHyOb4uZ1ouuaSmq56A/JcjuzNIjEk3giC0B1/FjE1VbT1Uv
         8Kv6Z91JD49tE4zZkuN+RS6/Kd5zpTrAUU33MU9GIZn4NfNa3Gcm4PzxW/pzONPj+FUn
         4clp2WV4oOwZdqq+c1DL7vYmWojGJ1TNKf4Hy2k3x3+CSpUV4N/Vm5xmKrb6WiXG6aKa
         1LMQ==
X-Gm-Message-State: AOJu0YwvLguQkqHDtVwIxawi6d0nYXY0LVZmlVu27F8gs9MdMT7qitI3
        qnARL1wj3nd1YVHZMHezL04=
X-Google-Smtp-Source: AGHT+IFCcR6UrSYRiNaX3Ndo3RD/i0D1UnymgBq7Oh+uDdut1aKCcOfzD5joe1ohLEtN8k7sqNWDvQ==
X-Received: by 2002:a05:6512:1089:b0:50d:1a0e:b0e4 with SMTP id j9-20020a056512108900b0050d1a0eb0e4mr3515376lfg.28.1702385549759;
        Tue, 12 Dec 2023 04:52:29 -0800 (PST)
Received: from razdolb (95-24-145-153.broadband.corbina.ru. [95.24.145.153])
        by smtp.gmail.com with ESMTPSA id a4-20020a194f44000000b0050bef1c5a50sm1385233lfk.267.2023.12.12.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:52:29 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-13-mike.rudenko@gmail.com>
 <20231211221533.GK27535@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 12/19] media: i2c: ov4689: Implement digital gain control
Date:   Tue, 12 Dec 2023 15:52:19 +0300
In-reply-to: <20231211221533.GK27535@pendragon.ideasonboard.com>
Message-ID: <87cyvbpoqb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-12-12 at 00:15 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 11, 2023 at 08:50:15PM +0300, Mikhail Rudenko wrote:
>> The OV4689 sensor supports digital gain up to 16x. Implement
>> corresponding control in the driver. Default digital gain value is not
>> modified by this patch.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 62aeae43d749..ed0ce1b9e55b 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -35,6 +35,12 @@
>>  #define OV4689_GAIN_STEP		1
>>  #define OV4689_GAIN_DEFAULT		0x80
>>
>> +#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352A)
>
> Lowercase for hex constatns please.
>
>> +#define OV4689_DIG_GAIN_MIN		1
>> +#define OV4689_DIG_GAIN_MAX		0x7fff
>> +#define OV4689_DIG_GAIN_STEP		1
>> +#define OV4689_DIG_GAIN_DEFAULT		0x800
>> +
>>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
>>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>>  #define OV4689_TEST_PATTERN_DISABLE	0x0
>> @@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>
>>  	/* AEC PK */
>>  	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
>> -	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
>
> Is the default value really x2 ? That's not very nice :-S
>
> It would be much nicer if the default value of the control mapped to x1,
> otherwise it's impossible for userspace to interpret the scale of the
> digital gain value in a generic way. I suppose that could break existing
> applications though, which isn't great.
>
> Out of curiosity, can you tell what SoC(s) you're using this sensor with
> ?
>
>>
>>  	/* ADC and analog control*/
>>  	{CCI_REG8(0x3603), 0x40},
>> @@ -622,6 +627,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  				OV4689_TIMING_FLIP_MASK,
>>  				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>>  		break;
>> +	case V4L2_CID_DIGITAL_GAIN:
>> +		cci_write(regmap, OV4689_REG_DIG_GAIN, val, &ret);
>> +		break;
>>  	default:
>>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>>  			 __func__, ctrl->id, val);
>> @@ -650,7 +658,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>
>>  	handler = &ov4689->ctrl_handler;
>>  	mode = ov4689->cur_mode;
>> -	ret = v4l2_ctrl_handler_init(handler, 13);
>> +	ret = v4l2_ctrl_handler_init(handler, 14);
>>  	if (ret)
>>  		return ret;
>>
>> @@ -693,6 +701,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>>
>> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
>> +			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
>> +			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
>> +
>>  	if (handler->error) {
>>  		ret = handler->error;
>>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);


--
Best regards,
Mikhail Rudenko
