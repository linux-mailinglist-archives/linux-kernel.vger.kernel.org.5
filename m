Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA580ED0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376607AbjLLNQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376601AbjLLNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:15:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBD106;
        Tue, 12 Dec 2023 05:16:00 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50c02628291so5951822e87.0;
        Tue, 12 Dec 2023 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386959; x=1702991759; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=5SExUZ1QCBZQ3tm36o/3GyTyzDGvf+wP6hTem1Psbdw=;
        b=BUZ3zaUuVmM07v1oTE3ic1bmo9k62PPO4GygWUJ/HfM9oDhdL2uhldlR6soEpnzJHi
         uJWj5FWfBbENLUxuR4hvk7t3dsmwHSF2RL69iClVXgMCeS49M5sj0FZYc0rrNQsN3AQa
         SOMRtfIVs1KmeMsASsnjbkFGg/t2LAGmcTInZfgs+OYNY4AXyOQKUciz1X8xkR0P58S+
         TI3mAOoDk8LzOmZjlQDh5CpBKazQlM07sNCkw29wFckjqsqs5A8eueq6tsM9680SKGaZ
         8nJ7MClveVo7AUL95/jfH30r/QqX+xBb/jlgZf6qD1eIbDbr7iXPyB+1gmAUIp5y4oly
         kUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386959; x=1702991759;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SExUZ1QCBZQ3tm36o/3GyTyzDGvf+wP6hTem1Psbdw=;
        b=Wxp+/8rejg8Jkbcwfv/Xq2JWCU2hSq2/+6ZYbErVRLqgdiGCUww+adOhUmZJ1cHOT1
         XPX4ss65Y5GGLeQQIRSf7U3EIRtvtJJiTKOzqA10w/jpuomdM02evId5K/pcOdmFCdUa
         C4YSbxAbiBGYU2gOfOgqeU0Tm6B4zNQAO3TeyCCLwOANTKPxYRrH8SAGT88HVQdJtdMB
         yB24AY0uKZiv2Sw6sn7TZns5WpT4uyJiBSS1MMSXFZv0MSincRJ97MvCXLxwuOH223K9
         Z9+dEJYYwSn4UITcfknWE4tN+UqldlIb74A3i/59q4JX6t8wDkfE2WknKkojjHfSGb6D
         8SkA==
X-Gm-Message-State: AOJu0YwUOKvDrZoiRipPCyW5mp6ZV/KRnWk8MJejo2bghA1xHjesSnOT
        GDQCOyk91qaUHNT3PGhjfM0=
X-Google-Smtp-Source: AGHT+IGMyD687rbSN0pzHb6uoCK2EOmuOzvytHxPJHGVIzfQzHroPWZ3HHvzYGwqn1esZxRZ4Sc7VQ==
X-Received: by 2002:a05:6512:523:b0:50b:fd8e:28f7 with SMTP id o3-20020a056512052300b0050bfd8e28f7mr2777732lfc.94.1702386958775;
        Tue, 12 Dec 2023 05:15:58 -0800 (PST)
Received: from razdolb (95-24-145-153.broadband.corbina.ru. [95.24.145.153])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b0050be6252444sm1340577lfg.133.2023.12.12.05.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:15:58 -0800 (PST)
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
Date:   Tue, 12 Dec 2023 15:52:48 +0300
In-reply-to: <20231211221533.GK27535@pendragon.ideasonboard.com>
Message-ID: <875y13pnn6.fsf@gmail.com>
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

Ah, missed it somehow. Is this convention kernel-wide or media specific?
I think checkpatch could have detetected this..

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

The datasheet does not explicitly say how register values are mapped to
the actual gain. 0x8 comes from the original register tables, and can
also be found in a few other drivers for this sensor, although they do
not implement digital gain control.

OTOH, the power-on value of this register, and default value as found in
the datasheet, is 0x4. This was the motivation behind that "(2x)"
annotation.

So, I'm afraid that we cannot interpret the absolute scale of the
digital gain in any case, unless we have more documentation. I tend to
keep the default value of 0x8 for the reasons of not (possibly) breaking
userspace.

> Out of curiosity, can you tell what SoC(s) you're using this sensor with
> ?

It's Rockchip 3399. I run most of my tests with AGC and AWB off, to be
sure they do not hide some important details.

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
