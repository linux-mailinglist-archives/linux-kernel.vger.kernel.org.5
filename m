Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19780EC88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376297AbjLLMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376457AbjLLMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:50:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7F94;
        Tue, 12 Dec 2023 04:50:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf32c0140so6386871e87.1;
        Tue, 12 Dec 2023 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702385452; x=1702990252; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=9O9+yTVA6hQq2rcJvcn4x64WB1ElORifLYtvzXGaqVY=;
        b=AwYil9U7r6cxuMRDqfUqwRpH8IeDv0jJjxZni/xewgljBZHJzTbqp559JtI/+Qy2uZ
         5IGDgrd+oSIWyCWAmZp7cNUKf/jL7jzxYFo05CyFba++gSlL+9p7X2G6uwPtNeHieVRl
         eB/b8RQIWfKw7JzDLDysrLzjos45OkTuOy9Pz+jPa6mUuftXgPC0zRqYFUiOZqFkXzj9
         965lmXlRVZDtKNK8sE5Cztn2bFttZ2hlha8xf+Rsm4GggcP6FeGlQMM+rWyI8t5w3exj
         AA19xSzAezcJ9FCX8aD9Pz9nlAWrmZJ26laKdyzxTTYKvGrv3ZrTjuMWDczqp+qtOFLe
         wTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385452; x=1702990252;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O9+yTVA6hQq2rcJvcn4x64WB1ElORifLYtvzXGaqVY=;
        b=jttaU4mnXXRNrkJIbZt4bp0p9XkwU2vUyH+iR0Leajbl1k4UMlPwsKuN3i256t3xdH
         3RiKo8bTmVDpXUJgFJdk/Oh4Bu+5HC8oHs5yypjg7XUJLuqRpQ4/1F6xWNjtOimYgaPm
         C8JG66i9I8bo0gUhqbeO+yoMk4PudsQgtqvbLNz5DTrwiJFycW+KXUMavb92LxJ3oLRC
         fVJtwu4LKR136WCBsy38d4HYsdDmvYqC78rAK0cnKgWi4YjIlWiX0R44j0xXfl1z9M/K
         AqZX7OvAru1Mf1P6oL2EzyU5Qp1zxxzdrKTTtu5jIt1BgfT8wJytOl0gS/GjLghNgh3w
         ImiA==
X-Gm-Message-State: AOJu0YzfnmA3QYZqFy+WL/k84Z+RSdFnyT0f+itUaAilwVilbQ6HCCYK
        QvseCHGyQ0TjFSxWIXIRkPhZQ4m5CYr0767/
X-Google-Smtp-Source: AGHT+IEKDaiT/w0B+X05kJ/kfLYSSO2LmO5DZBcfBONpe7d5tkawfjqXIRWmQd5KfM74VwlPiRCCmQ==
X-Received: by 2002:ac2:597a:0:b0:50c:125:c6c3 with SMTP id h26-20020ac2597a000000b0050c0125c6c3mr2692290lfp.128.1702385452084;
        Tue, 12 Dec 2023 04:50:52 -0800 (PST)
Received: from razdolb (95-24-145-153.broadband.corbina.ru. [95.24.145.153])
        by smtp.gmail.com with ESMTPSA id b25-20020a0565120b9900b0050d1a13366esm1058584lfv.298.2023.12.12.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:50:51 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-12-mike.rudenko@gmail.com>
 <20231211221059.GJ27535@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 11/19] media: i2c: ov4689: Implement vflip/hflip controls
Date:   Tue, 12 Dec 2023 15:42:13 +0300
In-reply-to: <20231211221059.GJ27535@pendragon.ideasonboard.com>
Message-ID: <87h6knpot0.fsf@gmail.com>
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


On 2023-12-12 at 00:10 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 11, 2023 at 08:50:14PM +0300, Mikhail Rudenko wrote:
>> The OV4689 sensor supports horizontal and vertical flipping. Add
>> appropriate controls to the driver. Toggling both array flip and
>> digital flip bits allows to achieve flipping while maintaining output
>> Bayer order. Note that the default value of hflip control corresponds
>> to both bits set, as it was before this patch.
>
> What happens if only hlip or vflip is set, does the bayer pattern change
> ?

If one changes both digital and analog flip bits (and this is what this
driver does), bayer pattern stay the same for all possible vflip/hflip
combinations. Unfortunately, the datasheet does not say much about these
bits, but I have a hypothesis that the on-sensor ISP can somehow reorder
pixels to keep the same bayer battern when asked.


> Sakari, I think this patch could use your attention.
>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 67d4004bdcfb..62aeae43d749 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -46,6 +46,14 @@
>>  #define OV4689_HTS_DIVIDER		4
>>  #define OV4689_HTS_MAX			0x7fff
>>
>> +#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
>> +#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
>> +#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
>> +#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
>> +#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
>> +#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>> +					 OV4689_TIMING_FLIP_DIGITAL)
>> +
>>  #define OV4689_LANES			4
>>  #define OV4689_XVCLK_FREQ		24000000
>>
>> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>  	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>>  	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>> -	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
>>
>>  	/* OTP control */
>>  	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
>> @@ -605,6 +612,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  			  (val + ov4689->cur_mode->width) /
>>  			  OV4689_HTS_DIVIDER, &ret);
>>  		break;
>> +	case V4L2_CID_VFLIP:
>> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
>> +				OV4689_TIMING_FLIP_MASK,
>> +				val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
>> +		break;
>> +	case V4L2_CID_HFLIP:
>> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
>> +				OV4689_TIMING_FLIP_MASK,
>> +				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>> +		break;
>>  	default:
>>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>>  			 __func__, ctrl->id, val);
>> @@ -633,7 +650,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>
>>  	handler = &ov4689->ctrl_handler;
>>  	mode = ov4689->cur_mode;
>> -	ret = v4l2_ctrl_handler_init(handler, 11);
>> +	ret = v4l2_ctrl_handler_init(handler, 13);
>
> This should be 12 if my comment on 10/19 is correct. Further patches in
> the series may need to be adjusted too.

Ack, will fix in v2.

>>  	if (ret)
>>  		return ret;
>>
>> @@ -673,6 +690,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>  				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
>>  				     0, 0, ov4689_test_pattern_menu);
>>
>> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>> +
>>  	if (handler->error) {
>>  		ret = handler->error;
>>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);


--
Best regards,
Mikhail Rudenko
