Return-Path: <linux-kernel+bounces-18761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A88262A2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0681F21E3D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455931C26;
	Sun,  7 Jan 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5u0jgYm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C15A6;
	Sun,  7 Jan 2024 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4ba539f6cso6689285ad.3;
        Sat, 06 Jan 2024 17:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704592727; x=1705197527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpRuTEKvJx0gbLJtVqj6qMf/1yr9BSLwA5oR8rW2Q5k=;
        b=m5u0jgYm5aZ+kaY4ALUEX6nHuMsHT3SMD5eGKppWWNQwHlK1taG+kn8hDCDnPgyQIu
         xJ2ntiHoVRfBbMjCTwiinrCKMjJEHnqB3tgdgn6GtZcEBFTosRaPDHxJ/+WR9MB4uFjh
         GNv9lSwoS9IyPNmcmtqDRrKlydbCDHqMGpsQBIkx/zEuynZsXJnmDQzi8lWUbZyWvP6w
         iVqKof70nUJsL/qns67sxOgk7I7ME6U3HTfUzkMK4OHCu/4tqSoF1bC5cnXF/Cl7bLN+
         PVOW2kIfxLz1wBXo7JZzxkkH22bWSHbAuFWst3bdBgoyldEWHlIZkusgnBOml1j6XrqT
         0rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704592727; x=1705197527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpRuTEKvJx0gbLJtVqj6qMf/1yr9BSLwA5oR8rW2Q5k=;
        b=JEXEuMqDFuuLU46torxHCxvsx0ZIZ8quZpmzeCTwnARoXix4MsMPeIoFSxeBijiq1I
         flKAbECMmAHrUkunTSmwWjlCs4p+2OFosEa8EsMiLp5ruP79TN2xuNNoelqhq+hXi/Lj
         SW1syGWxdAZWnQDHD4V4aapRYcAtBFdo9VMq/z8X9ow8M8Pala2glH9xWlRutFHn7Nkv
         vZ03xWc0eBnzijJRvClszIfY1x6QTfjGXdWg9fqIPJoF0n8B8xDyxeKnsvyAEB1VZE51
         WUDtZt92BQ38Sd6xwKEM8405o5OyNyZ47UD/MqWIO2nuTpBT2eTD+N9fBzTrMci7z2Ha
         naRQ==
X-Gm-Message-State: AOJu0Yw1Jfe8FLLsEBBIzdLlOXFGEBjZB0FRn0J+qAn2FJ/gfce2cywT
	97kAlOYKGMb1HbVZ3BDRH2I=
X-Google-Smtp-Source: AGHT+IFwORjAQ3+/kya08SFVo6+/B9XcraiA91XJgeooU5o0Nl3IQyfEos3VyTbZ8/ZPHugbwZV8Qw==
X-Received: by 2002:a17:902:d4d2:b0:1d5:830:19bf with SMTP id o18-20020a170902d4d200b001d5083019bfmr1825830plg.113.1704592727314;
        Sat, 06 Jan 2024 17:58:47 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e05d:9c84:c3e5:2daf])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001d3e44faf1asm3671567plb.272.2024.01.06.17.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 17:58:46 -0800 (PST)
Date: Sat, 6 Jan 2024 17:58:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Ogletree <jogletre@opensource.cirrus.com>
Cc: James Ogletree <james.ogletree@cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Peng Fan <peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Shuming Fan <shumingf@realtek.com>,
	Shenghao Ding <13916275206@139.com>,
	Ryan Lee <ryans.lee@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:CIRRUS LOGIC HAPTIC DRIVERS" <patches@opensource.cirrus.com>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"moderated list:CIRRUS LOGIC AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <ZZoFUwOEF6NByIp2@google.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104223643.876292-5-jogletre@opensource.cirrus.com>

Hi James,

On Thu, Jan 04, 2024 at 10:36:37PM +0000, James Ogletree wrote:
> +static int vibra_add(struct input_dev *dev, struct ff_effect *effect,
> +		     struct ff_effect *old)
> +{
> +	struct vibra_info *info = input_get_drvdata(dev);
> +	u32 len = effect->u.periodic.custom_len;
> +
> +	if (effect->type != FF_PERIODIC || effect->u.periodic.waveform != FF_CUSTOM) {
> +		dev_err(info->dev, "Type (%#X) or waveform (%#X) unsupported\n",
> +			effect->type, effect->u.periodic.waveform);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(&info->add_effect, effect, sizeof(struct ff_effect));

structures can be assigned, no need for memcpy.

> +
> +	info->add_effect.u.periodic.custom_data = kcalloc(len, sizeof(s16), GFP_KERNEL);
> +	if (!info->add_effect.u.periodic.custom_data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(info->add_effect.u.periodic.custom_data,
> +			   effect->u.periodic.custom_data, sizeof(s16) * len)) {
> +		info->add_error = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	queue_work(info->vibe_wq, &info->add_work);
> +	flush_work(&info->add_work);

I do not understand the need of scheduling a work here. You are
obviously in a sleeping context (otherwise you would not be able to
execute flush_work()) so you should be able to upload the effect right
here.

...

> +
> +static int vibra_playback(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct vibra_info *info = input_get_drvdata(dev);
> +
> +	if (val > 0) {

value is supposed to signal how many times an effect should be repeated.
It looks like you are not handling this at all.

> +		info->start_effect = &dev->ff->effects[effect_id];
> +		queue_work(info->vibe_wq, &info->vibe_start_work);

The API allows playback of several effects at once, the way you have it
done here if multiple requests come at same time only one will be
handled.

> +	} else {
> +		queue_work(info->vibe_wq, &info->vibe_stop_work);

Which effect are you stopping? All of them? You need to stop a
particular one.

> +	}

Essentially you need a queue of requests and a single work handling all
of them...

...

> +
> +static int cs40l50_vibra_probe(struct platform_device *pdev)
> +{
> +	struct cs40l50 *cs40l50 = dev_get_drvdata(pdev->dev.parent);
> +	struct vibra_info *info;
> +	int error;
> +
> +	info = devm_kzalloc(pdev->dev.parent, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = cs40l50->dev;
> +	info->regmap = cs40l50->regmap;
> +
> +	info->input = devm_input_allocate_device(info->dev);
> +	if (!info->input)
> +		return -ENOMEM;
> +
> +	info->input->id.product = cs40l50->devid & 0xFFFF;
> +	info->input->id.version = cs40l50->revid;
> +	info->input->name = "cs40l50_vibra";
> +
> +	input_set_drvdata(info->input, info);
> +	input_set_capability(info->input, EV_FF, FF_PERIODIC);
> +	input_set_capability(info->input, EV_FF, FF_CUSTOM);
> +
> +	error = input_ff_create(info->input, FF_MAX_EFFECTS);
> +	if (error) {
> +		dev_err(info->dev, "Failed to create input device\n");
> +		return error;
> +	}
> +
> +	info->input->ff->upload = vibra_add;
> +	info->input->ff->playback = vibra_playback;
> +	info->input->ff->erase = vibra_erase;
> +
> +	INIT_LIST_HEAD(&info->effect_head);
> +
> +	info->dsp = cs40l50_dsp;
> +
> +	info->vibe_wq = alloc_ordered_workqueue("vibe_wq", 0);
> +	if (!info->vibe_wq)
> +		return -ENOMEM;
> +
> +	error = devm_add_action_or_reset(info->dev, vibra_remove_wq, info);
> +	if (error)
> +		return error;

Why do you need a dedicated workqueue? So you can flush works?

> +
> +	mutex_init(&info->lock);
> +
> +	INIT_WORK(&info->vibe_start_work, vibra_start_worker);
> +	INIT_WORK(&info->vibe_stop_work, vibra_stop_worker);
> +	INIT_WORK(&info->erase_work, vibra_erase_worker);
> +	INIT_WORK(&info->add_work, vibra_add_worker);
> +
> +	error = input_register_device(info->input);
> +	if (error) {
> +		dev_err(info->dev, "Failed to register input device\n");
> +		input_free_device(info->input);

Not needed, you are using devm_input_allocate_device().

> +		return error;
> +	}
> +
> +	return devm_add_action_or_reset(info->dev, vibra_input_unregister,
> +					info->input);

Not needed, managed input devices will be unregistered automatically by
devm.

Thanks.

-- 
Dmitry

