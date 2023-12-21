Return-Path: <linux-kernel+bounces-8278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897AD81B4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4228C2889DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516B6BB51;
	Thu, 21 Dec 2023 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjzRbNfF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9376AB8F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3352b525so6869115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703157876; x=1703762676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGkZwIdmLi60ShwVAK7ggKym2AkjQZ0+N0ICnJdPIpA=;
        b=LjzRbNfFZjNeoDaQifr5t7h6v5whBuT9gmVP+/pk6xxXp3y8pSVmpKh3FokSy0TNG6
         VGOU3KLZqaEr32KYbBlf7ssv7z6afx1WnPaSreCAVgzRvSgvInvVBI+/XzPB3ugd7yeV
         +cm6xAbeEjs1QKSoZUhf4kObMzAtrwq4ZEoDSmz549Y5SxjH8CzJhGrJpuY9Giiz2O7t
         muOs8LszmE4+pGSyus0dRxLUjoNxMKbb6RVm5Nf+QrOoMxbU9pso25SrkC87V5BLKNdZ
         eFEl1Oal3hnXBn3h+2DXgfjhOGs9EWdWwOhv6+TsrAmdCmMyc6S62RJAn7fgJBt7MYIS
         8qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157876; x=1703762676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkZwIdmLi60ShwVAK7ggKym2AkjQZ0+N0ICnJdPIpA=;
        b=b5cEIlt+GVxaqTwOvc/LojtRq3vG7BMmMSG2HK1KpzEBTWBgC2aRnXMwwEXIFKnRzG
         0xVKnk8RwqkYwfCzqVyHCu3fKUxvbHDerFiDfPi/ZuEtjmwoaH7sYvVcOOC1bBLBUPGG
         21okqR7zeEPpPlb0IzJaoGKUtadiEVUqjtaMlU9OgNAOv/kABnu9R3CyiwYEQ5FQ6qit
         Tc+HmPO2OFDjJJJkCxAoEiKxkG88kTK5yZAdlIqdcYWr7cfF7R8FkihYPFbRpt7pHhy9
         A/aTKQXMbWV8/Moe2iJlyleVk/bEdoWcUJRv/E/ViOWOTEfiPWn/76OojkQaGR5jkOzE
         eYgg==
X-Gm-Message-State: AOJu0Yxq7zSGAnDiHdGrK1UVvK0gdp/vHInutNwqIaICQ9ikKETb9Hbk
	0GKe49uE3OfmFqQyzJkdsg==
X-Google-Smtp-Source: AGHT+IEY0zeOkEmWqxzOZOz9OMEjZ8EZ5dx8hGr56e2e8YMsAf+s1y30sszRmEvQ0vIVdg0Em94KmQ==
X-Received: by 2002:a05:600c:4445:b0:40c:2d85:3a01 with SMTP id v5-20020a05600c444500b0040c2d853a01mr657257wmn.161.1703157876018;
        Thu, 21 Dec 2023 03:24:36 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id d24-20020adfa418000000b003368d3437d5sm111465wra.44.2023.12.21.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:24:35 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: sbinding@opensource.cirrus.com
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com,
	tiwai@suse.de
Subject: Re: [PATCH v2 1/2] ALSA: hda: cs35l41: Safety-guard against capped SPI speed
Date: Thu, 21 Dec 2023 12:24:34 +0100
Message-Id: <20231221112434.13730-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8170413d-07a8-4e77-b43d-78cd9e4ea76f@opensource.cirrus.com>
References: <8170413d-07a8-4e77-b43d-78cd9e4ea76f@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for incorrect expression and confusion, it is indeed not the driver
that hangs. What I meant is that _computer_ "hangs" on wake up from
suspend. Unlike boot, where driver does not delay boot process, on wake up
from suspend it seems it does - after lid was opened/power button pressed,
with firmware loading taking ~180seconds in total, computer still has
black screen and is irresponsive for said duration, which is completely
unacceptable.

I do not have enough expertise in particular area, but it sounds very weird
to me that audio driver is delaying system wake up process at first place.
Was this intentional? I would assume/guess most correct solution would be
for driver to run non-blocking, like it does on boot, but again, I am not
too familiar with the subject.

> (~80s per amp) to load the firmware.

Besides firmware loading, there are general initialization/communication
taking place as well. I have disabled firmware loading to try: at a speed
of 3051Hz, it takes ~16 seconds on boot (non blocking, so not a big deal)
and ~7-8 seconds on wake up from suspend (blocking, so it is still not
acceptable).

I am myself extremely exited to get support for 9530 in upstream, but I am
just afraid that such a big wake up delay is a huge hit on a end user, and
would affect everyone with 9530 where intel-lpss patch was not applied yet.

> Instead I would prefer that we instead disable the loading of the 
> firmware in this case.
> Without loading firmware, the volume is much lower, but at least you 
> still have audio.

This indeed sounds like a better approach, I did not think of that. This
should work much better for generic cases, but unfortunately, will still
not prevent devices with _extremely_ slow SPI from badly affecting UX

Taking into account the above, and unless driver being blocking on wake up
can be resolved, perhaps it would makes sense to do both?
a) Your suggestion - disable firmware loading if SPI speed is not in MHz
range and
b) Do not initialize device at all, if SPI speed is ridiculously low (like
for example 3051 Hz)?

I have tested on 9530 without firmware loading, with SPI speed set to
50000Hz: it delays wake up by ~0.9-1 seconds. Subjectively, I think this is
the maximum acceptable delay.

> I have a patch to do that, which I was planning on pushing up 
> (hopefully) today.

Thanks for following up on this!

> 
> Thanks,
> 
> Stefan
> 
> >   		/*
> >   		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
> >   		 * This is only supported for systems with 2 amps, since we cannot expand the
> > @@ -219,8 +232,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
> >   		 * first.
> >   		 */
> >   		if (cfg->cs_gpio_index >= 0) {
> > -			spi = to_spi_device(cs35l41->dev);
> > -
> >   			if (cfg->num_amps != 2) {
> >   				dev_warn(cs35l41->dev,
> >   					 "Cannot update SPI CS, Number of Amps (%d) != 2\n",

FYI intel-lpss patch was submitted for review [1]. However, as it is in
different tree, it cannot be guaranteed that it will be always applied
when your patch for 9530 and other Dell devices will be applied, which is
why I am insisting on safety guard against _extremely_ low SPI speeds.

[1]: https://lore.kernel.org/all/20231220205621.8575-1-alex.vinarskis@gmail.com/

