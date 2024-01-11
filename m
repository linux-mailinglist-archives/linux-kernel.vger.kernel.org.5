Return-Path: <linux-kernel+bounces-23149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9882A84F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56F51C23437
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E7D2E2;
	Thu, 11 Jan 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfygzK7L"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4BD26A;
	Thu, 11 Jan 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d54b86538aso24055495ad.0;
        Wed, 10 Jan 2024 23:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704958090; x=1705562890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7o2fp3va6PrIWcX8vUj5HYMxS4ZIp+2h3KD5TCjvz8=;
        b=BfygzK7Ls24K3c3KFTCHSYb+UJLmcGwoBCMdxsEYkN8Dz48Pqw8nWdTbupZ6teu8QY
         f+WGfnf/se3Qbk+XcobV7ibArXSGuyUKK4OYMzOdUNYS3QZD1qaOoXiAtF0CuS2HfeWq
         hvxn9+pN3W9v2c+FpSw/edkoijGi04Nxn29IcNkQXlHVy8+1z+oRlRgR67i2dct4ya0t
         7F2jh8OAoXi0+rVxwYtq6Klp5vBLAJki4GBOIYLYRkMvEDiU5jeoH0v/qHE4co9EEvLK
         +WIXOz2HJeEW3oqbO0kwZoUMwiq6GqcUzfD6YEc1A+IKaGf6t8AfcNy03kt7cm4XMXJQ
         QFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704958090; x=1705562890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7o2fp3va6PrIWcX8vUj5HYMxS4ZIp+2h3KD5TCjvz8=;
        b=p7hSNrcTHYEu/4otZgOkkW+i/Eu+MBnzOjEUQL9xAjyB3f5aaUgS6GMUKGzgao2gQf
         4Fxk9KXenu8TYT4kXtISEZSjxo1pSIqamiks/AEr+QGLz5LygmEe8qxTk5RXjwDF39f1
         avklebJH9sLVRUv+uAEI7+R3Mvlawx9F/nqUJoxvq6futnhv+OT9CyqDOsLTSAwNlVrt
         hSEyrOBYrsrz4G9QqqQu7tewiWVWUagDZc67C9e4hvb6vXcM7w+0EUvWUlWBXLjAQDAt
         B01dNcnk7CjVXwnC7qSCAe8uiOsSswhuSV4mZgs8zfOGOSTeBj23QewvN9CAncMGdTGu
         vZlQ==
X-Gm-Message-State: AOJu0Yw94L2sHb2K7yPKdRF5ECCDiP294YeJtzGCk+PqURBtk9NDJuLf
	66EXZXFqX/HfK0hgBxIbl/Q=
X-Google-Smtp-Source: AGHT+IGl35uLlQRJwX4rvJzLGZrtgZstO0G3rpfy7BBTIi9UZR4sWdYeEO5QUbzFqaZyYXxS2sm4Lw==
X-Received: by 2002:a17:903:28f:b0:1d4:2066:6b7 with SMTP id j15-20020a170903028f00b001d4206606b7mr986820plr.69.1704958090495;
        Wed, 10 Jan 2024 23:28:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d4bb7cdc11sm491328plb.88.2024.01.10.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:28:10 -0800 (PST)
Date: Wed, 10 Jan 2024 23:28:06 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Ogletree <James.Ogletree@cirrus.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <Fred.Treven@cirrus.com>,
	Ben Bright <Ben.Bright@cirrus.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	James Schulman <James.Schulman@cirrus.com>,
	David Rhodes <David.Rhodes@cirrus.com>,
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
Message-ID: <ZZ-YhtIulqrSFc3R@google.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
 <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
 <ZZ3JNuLp-ZfGOQRF@google.com>
 <42A07166-6569-4872-B5E0-6D71C6F3656D@cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A07166-6569-4872-B5E0-6D71C6F3656D@cirrus.com>

On Wed, Jan 10, 2024 at 02:36:55PM +0000, James Ogletree wrote:
> 
> > On Jan 9, 2024, at 4:31 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > On Tue, Jan 09, 2024 at 10:03:02PM +0000, James Ogletree wrote:
> >> Hi Dmitry,
> >> 
> >> Thank you for your excellent review. Just a few questions.
> >> 
> >>> On Jan 6, 2024, at 7:58 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >>> 
> >>> On Thu, Jan 04, 2024 at 10:36:37PM +0000, James Ogletree wrote:
> >>>> +
> >>>> + info->add_effect.u.periodic.custom_data = kcalloc(len, sizeof(s16), GFP_KERNEL);
> >>>> + if (!info->add_effect.u.periodic.custom_data)
> >>>> + return -ENOMEM;
> >>>> +
> >>>> + if (copy_from_user(info->add_effect.u.periodic.custom_data,
> >>>> +   effect->u.periodic.custom_data, sizeof(s16) * len)) {
> >>>> + info->add_error = -EFAULT;
> >>>> + goto out_free;
> >>>> + }
> >>>> +
> >>>> + queue_work(info->vibe_wq, &info->add_work);
> >>>> + flush_work(&info->add_work);
> >>> 
> >>> I do not understand the need of scheduling a work here. You are
> >>> obviously in a sleeping context (otherwise you would not be able to
> >>> execute flush_work()) so you should be able to upload the effect right
> >>> here.
> >> 
> >> Scheduling work here is to ensure its ordering with “playback" worker
> >> items, which themselves are called in atomic context and so need
> >> deferred work. I think this explains why we need a workqueue as well,
> >> but please correct me.
> >> 
> >>> 
> >>>> +
> >>>> +static int vibra_playback(struct input_dev *dev, int effect_id, int val)
> >>>> +{
> >>>> + struct vibra_info *info = input_get_drvdata(dev);
> >>>> +
> >>>> + if (val > 0) {
> >>> 
> >>> value is supposed to signal how many times an effect should be repeated.
> >>> It looks like you are not handling this at all.
> >> 
> >> For playbacks, we mandate that the input_event value field is set to either 1
> > 
> > I am sorry, who is "we"?
> 
> Just a royal “I”. Apologies, no claim to authority intended here. :)
> 
> > 
> >> or 0 to command either a start playback or stop playback respectively.
> >> Values other than that should be rejected, so in the next version I will fix this
> >> to explicitly check for 1 or 0.
> > 
> > No, please implement the API properly.
> 
> Ack.
> 
> > 
> >> 
> >>> 
> >>>> + info->start_effect = &dev->ff->effects[effect_id];
> >>>> + queue_work(info->vibe_wq, &info->vibe_start_work);
> >>> 
> >>> The API allows playback of several effects at once, the way you have it
> >>> done here if multiple requests come at same time only one will be
> >>> handled.
> >> 
> >> I think I may need some clarification on this point. Why would concurrent
> >> start/stop playback commands get dropped? It seems they would all be
> >> added to the workqueue and executed eventually.
> > 
> > You only have one instance of vibe_start_work, as well as only one
> > "slot" to hold the effect you want to start. So if you issue 2 request
> > back to back to play effect 1 and 2 you are likely to end with
> > info->start_effect == 2 and that is what vibe_start_work handler will
> > observe, effectively dropping request to play effect 1 on the floor.
> 
> Understood, ack.
> 
> > 
> >> 
> >>> 
> >>>> + } else {
> >>>> + queue_work(info->vibe_wq, &info->vibe_stop_work);
> >>> 
> >>> Which effect are you stopping? All of them? You need to stop a
> >>> particular one.
> >> 
> >> Our implementation of “stop” stops all effects in flight which is intended.
> >> That is probably unusual so I will add a comment here in the next
> >> version.
> > 
> > Again, please implement the driver properly, not define your own
> > carveouts for the expected behavior.
> 
> Ack, and a clarification question: the device is not actually able to
> play multiple effects at once. In that case, does stopping a specific
> effect entail just cancelling an effect in the queue?

In this case I believe the device should declare maximum number of
effects as 1. Userspace is supposed to determine maximum number of
simultaneously playable effects by issuing EVIOCGEFFECTS ioctl on the
corresponding event device.

Thanks.

-- 
Dmitry

