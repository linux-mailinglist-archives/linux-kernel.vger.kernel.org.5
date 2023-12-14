Return-Path: <linux-kernel+bounces-21-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D7813AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA98B2197E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556D6979D;
	Thu, 14 Dec 2023 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4jQWA1S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCA69790
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3364a5ccbb1so754672f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702582620; x=1703187420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFubgADP9XhdCLx967vVc5Kz7bKh+8vvZX0YN/15/s4=;
        b=m4jQWA1SUmCxMaXJDOkofVlyO/iKv6WtVK7+CP6FRF74B9e0eDEgK+onoZ8/Z192eB
         tT7zD284qzqHgvfSLe1BI2oBAVaaS65xr09uZyC70lnUVmV3Mo44MV4X6rdfzAdDkcwy
         FAMuFzuR4hZiYqHdmdGwLzp5hPoQETPPE7njroVc49Vse2KQmoG8dVz/oeIExsG46/0I
         phIaTuMmBrB1O+LE/yYIfODdfyy0dy3SrDQqTjMC2Sn/8QpPat9I/9GUMHr3YW86+H8K
         px7Njf2tGp+kmuOxuS47DynLQzsKhzd/4aM2IvGvRHVF0ayaS/XEPh3tnw+rgX9Ktr38
         j5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582620; x=1703187420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFubgADP9XhdCLx967vVc5Kz7bKh+8vvZX0YN/15/s4=;
        b=A+2KL9DEBUQi4ay6wTvEEnfvXzJ+9RqCnqZ7WW3Sxgh+iKAjZlY8O6vRWSlUw7DcyJ
         nRA7h5hbP1SI4jjgmUGuejfDBWN49qgsAkg5Z65GZoL7XAka/zd7VjYR9Btsr2n610Ec
         Ws4vgIAOJ5ng/iOfIkeu5yVt7Uct/Tt3GUS3G7HaplL/KYFZLKpHhsioF0n4gFchpPdm
         /1QebTs9A5uEcaK3b8A/7vLAWTstENXY1rIH19C2hApI9B1tCQXWi+rJrPLn/A7JqcbU
         OWjAtQqfKW2omnaVkSbqntCBuJN4osLaWJOEO+xn+uIwfxebEPTzEiEGdmTGZTJYtYYY
         bLFg==
X-Gm-Message-State: AOJu0Yx2fnbf733ybb0UVWtkafNwfAaCyJGWiEnSDrutEJI7Uw3f4FKV
	Smx6G85dJAF5+VON8YUQPQ==
X-Google-Smtp-Source: AGHT+IHcXLj5OmgS9QESNFSohmdOoItGwQ/x/a/xAWVvqRZ/S+U9+6YbzNiEtyuMCorI4IJWVesZXg==
X-Received: by 2002:adf:ef84:0:b0:336:4b83:3e6b with SMTP id d4-20020adfef84000000b003364b833e6bmr655940wro.117.1702582620265;
        Thu, 14 Dec 2023 11:37:00 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6282000000b003363432c0ffsm7090118wru.113.2023.12.14.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:36:59 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: tiwai@suse.de
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com
Subject: Re: [PATCH 1/1] ALSA: hda: cs35l41: Dell Fiorano add missing _DSD properties
Date: Thu, 14 Dec 2023 20:36:58 +0100
Message-Id: <20231214193658.18969-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <87ttokpyws.wl-tiwai@suse.de>
References: <87ttokpyws.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can I be awkward and ask that we hold off on this patch chain until
> then?  Then we can add this laptop using the new approach.

> If/when the chain is accepted, we will add support for a few Dell
> laptops as well, including this one.

Sounds reasonable. I'll be looking forward to your new framework.
Once up, I can adjust my patch, and if everything still works as expected,
push updated version for review.

> Instead of erroring out, I wonder if we can noodle our way to the
> appropriate clk and clk_set_rate it up to 4MHz for this particular
> laptop only?  Stefan's taking a look at that.
Thanks for the initiative. Potentially that would work, however, it would
require to go up the clock tree to the divider. Since its clearly a
firmware bug causing lpss miss-configuration, I intially thought it would
be best to have it resolved there. If you need more information, I would be
happy to share results of our debugging with you via private email.

> Also, any SPI rate >~100k is probably just about usable, so we don't
> want to error on <4MHz.  Quite often the spi clock is set at some value
> just below 4MHz.  It's unclear if this is going to get fixed in the BIOS
> at this point, so we don't know what exact rate we'd eventually receive.
I'm afraid I have to disagree here, 100k is _way_ too slow. Not sure
intentionally or not, but wake up from suspend is held back by Cirrus
driver. At 100k, I got these results, on boot:

```
[    5.561244] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Adding DSD properties for 10280BEB
..
[   11.251145] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - SSID: 10280BEB, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: -19
```

And on wake-up from suspend:
```
[  307.162720] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: DSP1: Firmware version: 3
...
[  312.515588] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: 100000 Hz actual, DMA
```

This means ~5.5 additional seconds of black screen on wake up, in my opnion
this is completely unacceptable. With 4Mhz, it takes sub 1second. Moreover,
the first time (after preconfigured by ALSA delay) sound is played, it
seems it needs to communicate with amplifier, and it takes additional few
seconds to start playing at 100Khz. With 4Mhz, its practically instant.

I agree that it is unlikely for Dell to ever fix its firmware. Thus either
in case of intel-lpss patch, or via clk_set_rate direclty from Cirrus
driver, lpss divider would be set 1:1, SPI controller would receive 100Mhz
clock directly, and set it to whatever is requested internally (currently
4Mhz). This way, lowest 'usable' rate should be irrelevant.

> Quite often the spi clock is set at some value just below 4MHz
Perhaps to address this, we could error out on say half requested rate? In
reality, it will be either requested rate/just sub requested, or something
totally off, like the default 3051Hz in this case.

> This will break once you pick up AMD's multi-cs patches, we should use
> spi_set_csgpiod instead.
Thanks, will correct.

> I suppose the error-out was due to safety reasons, but the clock
> adjustment works, it should be fine.  Let's see.
Precisely, since it is indeed unknown when exaclty/if ever firmware will
be fixed, and/or when our patch to intel-lpss will be accepted.

Regards,
Alex

