Return-Path: <linux-kernel+bounces-80108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E957862ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FD81C20947
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8FD14265;
	Sun, 25 Feb 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4DfQLAt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128E10940;
	Sun, 25 Feb 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873104; cv=none; b=Zcm0X8CQngVWEJHdvXv2D5rDi7PFMGeo0/rkY+y/nXALO7Xio6LG3LnUIxdQ21FfS6bVwC5QixtUaZpg0jjuxIG+XO6OsD+dpF5iO4eOHWbBU0qgsphdZ4g+RXJLoITCEoDvVt9tkQbYu8/i8FydNMCuwAi0av5JCPoGj+He2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873104; c=relaxed/simple;
	bh=FM6nJpDCc1vTozkefXWX8nK7wjoHIU1kHnGlUGQYR1I=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HVm7tWYz5+dhhfWDnNXrf6NSfzW/yLMGb3rEF5WK1pYqKzzF3hwiTuRlzudTkGb0tzibQiYt2ahFX9W49zeWpAqlD4OProG0TXYl0ofTjhugqssqx2WJGMl6GKhZkCsWrzHmNk2xY77z6X7fLDNEsCIP00QxFCab85UAugMRtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4DfQLAt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d28464c554so8242181fa.3;
        Sun, 25 Feb 2024 06:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708873100; x=1709477900; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rktew8MetB6Z0tBx0bsqxvoGbPOtckZbNwltCbnvHNA=;
        b=Y4DfQLAt2P3sdYU4cIPErL7Yrnkh6/bYPoYiDjloDoTP4XwqrCYzuIeA9eN04BHmLW
         6W+yzvE4a1Xv0C5eQGme5BF3Q5x0zHLPIGu2aTN/d0c5tFuAN5n3gEiw5xDd0GbY6hYQ
         P+QUo5oLtlok7auBr70iW0hm+o+TYn+bU3zGkCcmw6ZgS6v2TfFz3zGI332ri51RKyN4
         7vfQR2p3ttRGsxlMJ3toBHXTL33FrEs9M+QHWiPVbaopW+c+gfy3XrU6dwxmCyAC957U
         muIXbj6wO9UeR8k39cX8QR/4CqkEfOTuT58NVyavLOFkQl1sJXk/ms6GlnHOCmEAusK1
         1dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708873100; x=1709477900;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rktew8MetB6Z0tBx0bsqxvoGbPOtckZbNwltCbnvHNA=;
        b=kImBMWf+S+uIirVQk8LoZ1cxEfqP6REZFUINOBnrgTvg822JWJwgkAp/BZ+coeoIBK
         G+DgF4A0QinE6u2OXddAWX/bpRHUzP/ln2SIzH/cmxGsg5uRc5nV5hwVET3fbJ73lWbj
         QmyUjP9kCXa7kL5Fx1X57C87B0QA8wwGnuon02aFzIfuCR+QEE86QQEBOaz0ZVsh9R3f
         pUCyJBnLvokZNeTxSrTltM0qMaqd7VFvIgATX1o/p4YE5MMNbrDMlhbs4LjX/2UHrnDX
         0txZkHS4f/sHKtyfNyGeyhVk2a3v6cw5y5ErEEmL2feZr8V2FCXF93lu73EUpl5Jmuy1
         8hbA==
X-Forwarded-Encrypted: i=1; AJvYcCVjRNbgApVxrPassWLOtYS9RaH/HkFF4w79gAL7SlG87a2rxTC8chkdXsjw3qoNXH5/s4485fQpEux117h6OOcULdZvhXBFOE/69eXz
X-Gm-Message-State: AOJu0YyCShcZZd8f7eRCy30/6het1ygUF16TIOykPtqIPL5WGKfei48q
	IDp/6VFFNWp1jZ40DlcUxjBPj7S/tez6WxY53Zt+2OHA2IF+tR2W
X-Google-Smtp-Source: AGHT+IH+LprkObfbkRp6BVn/uduHWcpYb+/dLuzRnktTRYfWKngVThd7TtrxnLsBibGZl1C/OxJ0Kw==
X-Received: by 2002:a2e:a265:0:b0:2d2:2e67:be2e with SMTP id k5-20020a2ea265000000b002d22e67be2emr2636183ljm.46.1708873100122;
        Sun, 25 Feb 2024 06:58:20 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651c102200b002d236c89d92sm565484ljm.135.2024.02.25.06.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 06:58:19 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-13-mike.rudenko@gmail.com>
 <ZdhWzCNalXnScMQy@kekkonen.localdomain> <87h6hzdsi4.fsf@gmail.com>
 <ZdpL4UxSy8elHkdZ@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 12/20] media: i2c: ov4689: Implement vflip/hflip
 controls
Date: Sun, 25 Feb 2024 17:15:18 +0300
In-reply-to: <ZdpL4UxSy8elHkdZ@kekkonen.localdomain>
Message-ID: <87il2cd20n.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2024-02-24 at 20:04 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Fri, Feb 23, 2024 at 06:21:20PM +0300, Mikhail Rudenko wrote:
>>
>> Hi Sakari,
>>
>> and thanks for the review!
>>
>> On 2024-02-23 at 08:26 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>
>> > Hi Mikhail,
>> >
>> > On Mon, Dec 18, 2023 at 08:40:33PM +0300, Mikhail Rudenko wrote:
>> >> The OV4689 sensor supports horizontal and vertical flipping. Add
>> >> appropriate controls to the driver. Toggling both array flip and
>> >> digital flip bits allows to achieve flipping while maintaining output
>> >> Bayer order. Note that the default value of hflip control corresponds
>> >> to both bits set, as it was before this patch.
>> >>
>> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> ---
>> >>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>> >>  1 file changed, 22 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> >> index 06ed9d22b2c8..6cf986bf305d 100644
>> >> --- a/drivers/media/i2c/ov4689.c
>> >> +++ b/drivers/media/i2c/ov4689.c
>> >> @@ -42,6 +42,14 @@
>> >>  #define OV4689_REG_VTS			CCI_REG16(0x380e)
>> >>  #define OV4689_VTS_MAX			0x7fff
>> >>
>> >> +#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
>> >> +#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
>> >> +#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
>> >> +#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
>> >> +#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
>> >> +#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>> >> +					 OV4689_TIMING_FLIP_DIGITAL)
>> >> +
>> >>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
>> >>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>> >>  #define OV4689_TEST_PATTERN_DISABLE	0x0
>> >> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>> >>  	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>> >>  	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>> >>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>> >> -	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
>> >>
>> >>  	/* OTP control */
>> >>  	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
>> >> @@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>> >>  			  (ctrl->val + ov4689->cur_mode->width) /
>> >>  			  OV4689_HTS_DIVIDER, &ret);
>> >>  		break;
>> >> +	case V4L2_CID_VFLIP:
>> >> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
>> >> +				OV4689_TIMING_FLIP_MASK,
>> >> +				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
>> >> +		break;
>> >> +	case V4L2_CID_HFLIP:
>> >> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
>> >> +				OV4689_TIMING_FLIP_MASK,
>> >> +				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>> >> +		break;
>> >>  	default:
>> >>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>> >>  			 __func__, ctrl->id, ctrl->val);
>> >> @@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>> >>
>> >>  	handler = &ov4689->ctrl_handler;
>> >>  	mode = ov4689->cur_mode;
>> >> -	ret = v4l2_ctrl_handler_init(handler, 10);
>> >> +	ret = v4l2_ctrl_handler_init(handler, 12);
>> >>  	if (ret)
>> >>  		return ret;
>> >>
>> >> @@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>> >>  				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
>> >>  				     0, 0, ov4689_test_pattern_menu);
>> >>
>> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>> >> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>> >
>> > Could you take the default value from the mounting rotation?
>>
>> Could you provide an example (maybe a link to an existing driver) which
>> does this right? If I understand you correctly, I should flip default
>> for both flip controls for 180 degree rotation. But what should I do for
>> 90, 270 and all the rest rotation values?
>
> Looking at the patch again, it seems that the image wasn't flipped both
> vertically and horizontally, but only horizontally. Was that the case?
>
> Shouldn't the default then be no flipping?
>

Do you mean setting FORMAT1 and FORMAT2 to 0x0 and HFLIP and VFLIP
controls to 0 by default, and doing

   case V4L2_CID_VFLIP:
		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
				OV4689_TIMING_FLIP_MASK,
				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
		break;
	case V4L2_CID_HFLIP:
		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
				OV4689_TIMING_FLIP_MASK,
				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);  // do not invert!
		break;

in ov4689_set_ctrl? The issue is that we get a mirrored image in this
case.

The publicly available documentation doesn't clarify this, but it looks
like the horizontal flipping bits in FORMAT2 are somehow inverted. All
the other drivers for this sensor I've found default to FORMAT2 = 0x6
(none implement flipping controls, though).

So I see two options here:
(1) default to HFLIP = 0, FORMAT2 = 0x6 (as done is this patch)
(2) default to HFLIP = 1, FORMAT2 = 0x0

I like (1) better, because it results in non-mirrored image by
default. What is your opinion?

>>
>> > The default should be upside-up, but this is an existing driver and
>> > changing the flipping now could affect existing users.
>>
>> Do you mean default rotation value when missing device tree property?
>>
>> > <URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/drivers/camera-sensor.html#rotation-orientation-and-flipping>
>> >
>>
>>
>>


--
Best regards,
Mikhail Rudenko

