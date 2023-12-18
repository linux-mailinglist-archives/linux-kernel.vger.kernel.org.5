Return-Path: <linux-kernel+bounces-4371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4588817C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83011C21C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C47349E;
	Mon, 18 Dec 2023 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpykLe7i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F537348F;
	Mon, 18 Dec 2023 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc5ee69960so25946331fa.0;
        Mon, 18 Dec 2023 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702932421; x=1703537221; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=3SIXDp75ZHCEs87qRhLFCCPIElvpLyVBzTpsncQ+3Og=;
        b=JpykLe7iTr1G9owPwP1BnL7J1DdbfO96nHmFj3/+YVXX4HujYyfibgg7JwfTy0/1ks
         Q22R2g7zaFjK69o8PUQEF2Va06OHpwXnoMVqOxj863/n7c0Hok9X99UNV2OCzWvdWQBq
         j1TJ3IEFoAyZyYL3QjqSNk+e7P+/PFtzcx+A0hTeJXNysxcbNCJTU5KV+J4eKc4ooL3W
         r3r08k1eG4IrvLmur0SvOzzFX4t/lSAQXVy7jwgX2NaW7RfP5mNN7Ry0qh1kB6RHrScv
         n1VsYmL6dl3SG6MPrbxlw7iMOBwiJtbgkjHn5jOkk6M7dRrmtpk5piquMTTLwTGChEDn
         JW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932421; x=1703537221;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SIXDp75ZHCEs87qRhLFCCPIElvpLyVBzTpsncQ+3Og=;
        b=PmLuDRaEc1Aq9l1TA0wX0uVy1hO1X2MJdMAOQM7kPz/rozuUhhGCuBGDCy8XYyNPgA
         9s8NAan6gpEx0ahAijveuwoBHII5k0k/GD2vbvx+M0EyA6XhmkoAvc+ocHtIoIoE4mM9
         oExRWEqUR+koNUdtSLfceWvB7/1K5ZBXvNhxEzS/uK6Z44im8VxNJUECEzIcT7NnuIYy
         evlO3BZ+r9QfsFgQJ+YZvPIDs2W6WXCEfLgSh5sOyvEufX4kNeaIYtOaBuzZbT/a8cKl
         nwN22MQetHzMfPdqYSpxThx5LS1mP5TxxEnVWO/2q3cLIpXHfsBcwEMeq4itLMjqgVMB
         LFhw==
X-Gm-Message-State: AOJu0Yyh92WL4sisGjZN0D5KD0dVzc4QYMDoGhT8C1He3NtEt65K4Ua9
	rUJr8LBGnokKeVCniGkawdU=
X-Google-Smtp-Source: AGHT+IFXCrMN7zl1aUbx1ydt1lz0r879IoYa36r//tRk/ToNNlqSKcI/ZWDk5XvAOFB8ElmnsCyPQw==
X-Received: by 2002:a2e:90da:0:b0:2cc:6ebd:fad8 with SMTP id o26-20020a2e90da000000b002cc6ebdfad8mr870450ljg.19.1702932420809;
        Mon, 18 Dec 2023 12:47:00 -0800 (PST)
Received: from razdolb (95-24-145-153.broadband.corbina.ru. [95.24.145.153])
        by smtp.gmail.com with ESMTPSA id x9-20020a2e9dc9000000b002cc7d567dffsm30090ljj.103.2023.12.18.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:47:00 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-13-mike.rudenko@gmail.com>
 <20231211221533.GK27535@pendragon.ideasonboard.com>
 <875y13pnn6.fsf@gmail.com>
 <20231218180459.GS5290@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH 12/19] media: i2c: ov4689: Implement digital gain control
Date: Mon, 18 Dec 2023 23:10:25 +0300
In-reply-to: <20231218180459.GS5290@pendragon.ideasonboard.com>
Message-ID: <87msu7p7b0.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2023-12-18 at 20:04 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> On Tue, Dec 12, 2023 at 03:52:48PM +0300, Mikhail Rudenko wrote:
>> On 2023-12-12 at 00:15 +02, Laurent Pinchart wrote:
>> > On Mon, Dec 11, 2023 at 08:50:15PM +0300, Mikhail Rudenko wrote:
>> >> The OV4689 sensor supports digital gain up to 16x. Implement
>> >> corresponding control in the driver. Default digital gain value is not
>> >> modified by this patch.
>> >>
>> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> ---
>> >>  drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
>> >>  1 file changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> >> index 62aeae43d749..ed0ce1b9e55b 100644
>> >> --- a/drivers/media/i2c/ov4689.c
>> >> +++ b/drivers/media/i2c/ov4689.c
>> >> @@ -35,6 +35,12 @@
>> >>  #define OV4689_GAIN_STEP		1
>> >>  #define OV4689_GAIN_DEFAULT		0x80
>> >>
>> >> +#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352A)
>> >
>> > Lowercase for hex constatns please.
>>
>> Ah, missed it somehow. Is this convention kernel-wide or media specific?
>> I think checkpatch could have detetected this..
>
> It's media-wide :-) Lower-case hex constants are the majority through
> the kernel, but there's no tree-wide ban on upper-case.
>
>> >> +#define OV4689_DIG_GAIN_MIN		1
>> >> +#define OV4689_DIG_GAIN_MAX		0x7fff
>> >> +#define OV4689_DIG_GAIN_STEP		1
>> >> +#define OV4689_DIG_GAIN_DEFAULT		0x800
>> >> +
>> >>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
>> >>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>> >>  #define OV4689_TEST_PATTERN_DISABLE	0x0
>> >> @@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>> >>
>> >>  	/* AEC PK */
>> >>  	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
>> >> -	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
>> >
>> > Is the default value really x2 ? That's not very nice :-S
>> >
>> > It would be much nicer if the default value of the control mapped to x1,
>> > otherwise it's impossible for userspace to interpret the scale of the
>> > digital gain value in a generic way. I suppose that could break existing
>> > applications though, which isn't great.
>>
>> The datasheet does not explicitly say how register values are mapped to
>> the actual gain. 0x8 comes from the original register tables, and can
>> also be found in a few other drivers for this sensor, although they do
>> not implement digital gain control.
>>
>> OTOH, the power-on value of this register, and default value as found in
>> the datasheet, is 0x4. This was the motivation behind that "(2x)"
>> annotation.
>
> I wonder if the chip has a TPG that would be located before the digital
> gain. It would be a nice way to test the digital gain scale.

Thanks for the suggestion, just tested that. Unfortunately, all the
supported test patterns are not affected by digital gain at all :(

But what if we set the digital gain control's default value in
v4l2_ctrl_new_std to 0x400 (power-on default), right after that set
ctrl->cur.val to 0x800 (default value before this series), and explain
the situation in a comment? Thus we could keep the effective default
value, and make it clear that it is 2x at the same time.

What do you think?

>> So, I'm afraid that we cannot interpret the absolute scale of the
>> digital gain in any case, unless we have more documentation. I tend to
>> keep the default value of 0x8 for the reasons of not (possibly) breaking
>> userspace.
>>
>> > Out of curiosity, can you tell what SoC(s) you're using this sensor with
>> > ?
>>
>> It's Rockchip 3399. I run most of my tests with AGC and AWB off, to be
>> sure they do not hide some important details.
>>
>> >>
>> >>  	/* ADC and analog control*/
>> >>  	{CCI_REG8(0x3603), 0x40},
>> >> @@ -622,6 +627,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>> >>  				OV4689_TIMING_FLIP_MASK,
>> >>  				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>> >>  		break;
>> >> +	case V4L2_CID_DIGITAL_GAIN:
>> >> +		cci_write(regmap, OV4689_REG_DIG_GAIN, val, &ret);
>> >> +		break;
>> >>  	default:
>> >>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>> >>  			 __func__, ctrl->id, val);
>> >> @@ -650,7 +658,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>> >>
>> >>  	handler = &ov4689->ctrl_handler;
>> >>  	mode = ov4689->cur_mode;
>> >> -	ret = v4l2_ctrl_handler_init(handler, 13);
>> >> +	ret = v4l2_ctrl_handler_init(handler, 14);
>> >>  	if (ret)
>> >>  		return ret;
>> >>
>> >> @@ -693,6 +701,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>> >>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>> >>  	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>> >>
>> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
>> >> +			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
>> >> +			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
>> >> +
>> >>  	if (handler->error) {
>> >>  		ret = handler->error;
>> >>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);


--
Best regards,
Mikhail Rudenko

