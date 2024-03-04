Return-Path: <linux-kernel+bounces-91225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE563870B75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439891F20FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4F7AE56;
	Mon,  4 Mar 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7i2/hQX"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AA4AEF9;
	Mon,  4 Mar 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583745; cv=none; b=e/FNfirikuGl/F0UJvWzafgKjmQOIY6W/XFlAYE9SiDHoOoQgKEosrEYlX0sU73fOm9C0PFXiGrmwqcQ3zBUDgTI/nqG5kUxa+90UEUCxlGWnGfO9+duKcPSPNvbHtTIr9FtCeZeV6psgAmdQItz6bWH6++3GqO0bmHFypvUTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583745; c=relaxed/simple;
	bh=CCgENNhMF/8TvGn5GCj4PBL+aZdDyrq2Bayv8Qqsu84=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=V7F43fc2x2qjS5i/1d8Nu2GXEMVZTC7r/L9SWEOU2KtBrNIeLiV/anmxG2r5Sa2uwjW5+HUYpdX9lZvkqnjv/6wg316Pc8feex9Obpgx9tgspJ0YBNtIaNjEyzmGuobSueqtlet7UHT8xW1+UcZSqZZc6vPPn/PexLCg9zHq9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7i2/hQX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28387db09so58789441fa.0;
        Mon, 04 Mar 2024 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709583742; x=1710188542; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8fxFB8N57hfAiZrRByccOlSQfamUKiybD6QOVLL+RAg=;
        b=l7i2/hQXoP4Nj/PnpuJhbFXqkpG5aDh4xtlkGw+qu4dMI19rQfySZJgX7gsNGBw2cj
         IvhsZmElK9VVSyi3lGOIas30fELE3nYQCGK6YCuHl3EmHQ4O5N6PQI/O477czyFwKs7p
         21zVOqzIvdufnxsiXUWXEXpaPooE1PJkyTmOPT8gSoqugKef/Uk3lzOo+nJJ+CHm3JpT
         tjRrlwlcCPzOiPWzCRMNsd37qWj6XzsI5vUWqQ524yXz6HJXLfkgLgLktckYfOloazhh
         WEOq47tSpQZtp4i3HIfRlxhdqFKIjEq1629Rg2POkC/2MZZ+oLlo9nob66pCzAUidJkP
         1MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583742; x=1710188542;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fxFB8N57hfAiZrRByccOlSQfamUKiybD6QOVLL+RAg=;
        b=cZuL33hsFt1S/Nm70znMsNopR95DkjHiy+WR4FW30cOOhkzZVVbKbZ8BciT765f7IF
         A9HmlOSwBBfg2CqR2c8mwXvgoSIs4awv+3OPqiJv0Mb/1FWwi5AKqGyJCre+0A4OsMMh
         fNNMxxIjH9HSRswK/+moTK2XV3UI+wJ8gm+3Vsj2oTBJwfaBWTHfpgZ2DdyqSqxz9RGv
         MiDV1xLIY1OPeEBmceQFWnZBx+1ueYjert/GMts+gVmmiN7NjxluX4JORz+IrlOCdt4E
         cn01JdDmviKsPt4tOwyL3mKiEVeDqsaU+McDwkAqa+rawh/wTjrFHW8QhrFCGdQF9IXG
         woyg==
X-Forwarded-Encrypted: i=1; AJvYcCWZK84Ncna/VZWTmOdh40NQ0zGpXZZZxiEszhuYapMW/V7Bim4hnMdK4uv7AgYQ3GnN12BHPA1s6lbWhIrp/U58fBZteMib6irhat0=
X-Gm-Message-State: AOJu0YyE21jVWTORCvo0NNmaxYUdyZMJtAT13IkvsJCDViBOWsJc46mb
	yZs7dnoN2yIVHIfOHsPxh6t32SIUZajDCz5EZItl0UDReBLSr/Yg
X-Google-Smtp-Source: AGHT+IEeiz3Lwz5LXdMFw/NJ7/qtw+liFm+ZYMrdHXD8p9Rhf2MZkqYh6y0ihTR7OqPz/C9g56OosQ==
X-Received: by 2002:a2e:a316:0:b0:2d3:7c06:bb14 with SMTP id l22-20020a2ea316000000b002d37c06bb14mr3978819lje.47.1709583742057;
        Mon, 04 Mar 2024 12:22:22 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id k12-20020a2e240c000000b002d2904e959csm1855698ljk.5.2024.03.04.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:22:21 -0800 (PST)
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
 <20240229165333.227484-13-mike.rudenko@gmail.com>
 <170957124561.566498.576610873794356352@ping.linuxembedded.co.uk>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v3 12/20] media: i2c: ov4689: Implement vflip/hflip
 controls
Date: Mon, 04 Mar 2024 23:19:35 +0300
In-reply-to: <170957124561.566498.576610873794356352@ping.linuxembedded.co.uk>
Message-ID: <871q8phhmt.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Kieran,

and thanks for the review!

On 2024-03-04 at 16:54 GMT, Kieran Bingham <kieran.bingham@ideasonboard.com> wrote:

> Quoting Mikhail Rudenko (2024-02-29 16:53:25)
>> The OV4689 sensor supports horizontal and vertical flipping. Add
>> appropriate controls to the driver. Toggling both array flip and
>> digital flip bits allows to achieve flipping while maintaining output
>> Bayer order. Note that the default value of hflip control corresponds
>> to both bits set, as it was before this patch.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 8283a9ac86c9..01ee8cadb7c9 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -42,6 +42,14 @@
>>  #define OV4689_REG_VTS                 CCI_REG16(0x380e)
>>  #define OV4689_VTS_MAX                 0x7fff
>>
>> +#define OV4689_REG_TIMING_FORMAT1      CCI_REG8(0x3820)
>> +#define OV4689_REG_TIMING_FORMAT2      CCI_REG8(0x3821)
>
> I assume these registerse are called TIMING_FORMAT1 and TIMING_FORMAT2,
> and they don't have any named reference to H/V?

Exactly.

> It's a shame, but I might add /* Horizontal */ and /* Vertical */
> accordingly to these definitions, though not specifically required.

Thanks for the tip, will do it in v3.

> Looks like a good breakdown of the control though.
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
>> +#define OV4689_TIMING_FLIP_MASK                GENMASK(2, 1)
>> +#define OV4689_TIMING_FLIP_ARRAY       BIT(1)
>> +#define OV4689_TIMING_FLIP_DIGITAL     BIT(2)
>> +#define OV4689_TIMING_FLIP_BOTH                (OV4689_TIMING_FLIP_ARRAY |\
>> +                                        OV4689_TIMING_FLIP_DIGITAL)
>> +
>>  #define OV4689_REG_TEST_PATTERN                CCI_REG8(0x5040)
>>  #define OV4689_TEST_PATTERN_ENABLE     0x80
>>  #define OV4689_TEST_PATTERN_DISABLE    0x0
>> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>         {CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>>         {CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>>         {CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>> -       {CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
>>
>>         /* OTP control */
>>         {CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
>> @@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>                           (ctrl->val + ov4689->cur_mode->width) /
>>                           OV4689_HTS_DIVIDER, &ret);
>>                 break;
>> +       case V4L2_CID_VFLIP:
>> +               cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
>> +                               OV4689_TIMING_FLIP_MASK,
>> +                               ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
>> +               break;
>> +       case V4L2_CID_HFLIP:
>> +               cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
>> +                               OV4689_TIMING_FLIP_MASK,
>> +                               ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>> +               break;
>>         default:
>>                 dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>>                          __func__, ctrl->id, ctrl->val);
>> @@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>
>>         handler = &ov4689->ctrl_handler;
>>         mode = ov4689->cur_mode;
>> -       ret = v4l2_ctrl_handler_init(handler, 10);
>> +       ret = v4l2_ctrl_handler_init(handler, 12);
>>         if (ret)
>>                 return ret;
>>
>> @@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>                                      ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
>>                                      0, 0, ov4689_test_pattern_menu);
>>
>> +       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>> +       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>> +
>>         if (handler->error) {
>>                 ret = handler->error;
>>                 dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
>> --
>> 2.43.0
>>


--
Best regards,
Mikhail Rudenko

