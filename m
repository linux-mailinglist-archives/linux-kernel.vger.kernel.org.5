Return-Path: <linux-kernel+bounces-14085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421918217B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D0E1C21301
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D91C16;
	Tue,  2 Jan 2024 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd/7kAN6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029620E0;
	Tue,  2 Jan 2024 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so2182284a12.1;
        Mon, 01 Jan 2024 22:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704177720; x=1704782520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nrk2FDet856vYGV07IdPp+JACyoEXbs5nWd39tdWEEg=;
        b=Gd/7kAN6RCD/skJ/Mn5tkuNNBMoPOKDxWBnEldHdS5ewTni4w9k40eIZj/spm4mLcs
         4359y75sVGO8BHUrK1ZBL+W01KtI8iuRYZoCJraqNHGruT06qrIesJrSMsIAg5onfi7N
         dqifexewn+p1MG1qaMzAWl0uPP1S+9Fncvyra8dezL4i6ShKu/MoLd+XkSL/aswg39yp
         /exsSasT8ydwIqcn49fo4oogDGxKMEAKagcuNvgLv/JYB06NBy0UBdSjcOa6zzGb39io
         L9PJFGiLCcv2CucFQgibYNcxuO70CEb4zcgYWwWRtG20GqzL4gWRfYLNVLl5X72ZTwUA
         hfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704177720; x=1704782520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrk2FDet856vYGV07IdPp+JACyoEXbs5nWd39tdWEEg=;
        b=BUAy9R/V7xj0MoQYiFe6UIdpG0Uw1AkneOpNwRfK8a6I/0iYnZlgp/Yt7XEdd7blJV
         6OXf74hWju/CBB0z43apl5gBPWXYjrcv680Qv1va2CnrBAO+9synBPsV+G9cK9eOD2HI
         V9Cxe5/+IFCJ1nVMAnjAplFvY9P2vLwp6uIFSzxUo1wj18MYu/HCyUSoJli8DCfONaMT
         v6oWUSX0S06lmephsp5UZH6Q5NlF5vrsZPIU2OtfkOuuqdkOqSbK6gE8Lfdt5PcvPaQ7
         vbE2XhyAeFl/hp8Gv8U76EhLHMcttEMplZMGZU1ZHyUpNS8N2d73b864v6Gii0CYkF4u
         ryLA==
X-Gm-Message-State: AOJu0Yx19uTVflGoI9ejk5Lk4CqNwTYrgOkjCMzaQNhyrovpzsWbWl1k
	38zrobpOE3uq5NBTC6ExfWM=
X-Google-Smtp-Source: AGHT+IFKFXdgJWi6TxeDdQsoH7UnHwfSykvXrO68D121GKKr/chXHH58HEkr581s5RLPgs81WIC+/Q==
X-Received: by 2002:a05:6a00:1409:b0:6d9:cc1b:83e0 with SMTP id l9-20020a056a00140900b006d9cc1b83e0mr5918668pfu.20.1704177720253;
        Mon, 01 Jan 2024 22:42:00 -0800 (PST)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7991b000000b006da13bc46c0sm8973136pff.171.2024.01.01.22.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 22:41:59 -0800 (PST)
Date: Tue, 2 Jan 2024 03:42:29 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Andy Chi <andy.chi@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Luka Guzenko <l.guzenko@web.de>, Yuchi Yang <yangyuchi66@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook
Message-ID: <ZZOwVZN7Xn2rIKtB@geday>
References: <20240102024916.19093-1-andy.chi@canonical.com>
 <ZZOQamQsHUR7eEPd@geday>
 <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
 <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>

On Tue, Jan 02, 2024 at 01:49:40PM +0800, Andy Chi wrote:
> Hi Geraldo,
> Yes, this model is not yet publicly available, so I can't type the
> full name on this patch.
> 
> (change to text plain mode to send out again.)

Hi Andy, please be kind and next time refrain from top-posting,
as it reverses the attention order for those reading the
discussion for posterity.

I think it is reasonable to mention it explicitly as an
upcoming product in order not to cause any confusion and
to make sure there's another janitorial patch later on
filling in the model details.
 
It's best to leave Takashi now to attend to your patch, and I
congratulate both you as well as Canonical and HP for the
effort towards bettering Linux.

Thanks for addressing this quickly.

Geraldo Nascimento

> 
> Kr,
> Andy
> 
> 
> On Tue, Jan 2, 2024 at 1:47 PM Andy Chi <andy.chi@canonical.com> wrote:
> >
> > Hi Geraldo,
> > Yes, this model is not yet publicly available, so I can't type the full name on this patch.
> >
> > Kr,
> > Andy
> >
> > On Tue, Jan 2, 2024 at 12:25 PM Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> >>
> >> On Tue, Jan 02, 2024 at 10:49:15AM +0800, Andy Chi wrote:
> >> > There is a HP ZBook which using ALC236 codec and need the
> >> > ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
> >> > and micmute LED work.
> >>
> >> Hi Andy,
> >>
> >> I know Takashi in the name of smooth operation usually takes this kind
> >> of simple patch, quickly, since it's a simple bugfix, unless there are
> >> any objections, so I must raise one.
> >>
> >> Which HP ZBook? Which model?
> >>
> >> Is this a still unreleased model Canonical has had access under a NDA
> >> for example? Or perhaps there is some other reason why you cannot name
> >> the model yet?
> >>
> >> Either way, there is a need to publicly know the reason for the missing
> >> model information.
> >>
> >> >
> >> > Signed-off-by: Andy Chi <andy.chi@canonical.com>
> >> > ---
> >> >  sound/pci/hda/patch_realtek.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> >> > index 7e9d8c1cedfc..1c8d5b58eb64 100644
> >> > --- a/sound/pci/hda/patch_realtek.c
> >> > +++ b/sound/pci/hda/patch_realtek.c
> >> > @@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >> >       SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> >> >       SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> >> >       SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> >> > +     SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >>
> >> Same questioning as above. "HP" is IMHO unacceptable without a clear
> >> reason for the missing model information.
> >>
> >> Thanks,
> >> Geraldo Nascimento
> >>
> >> >       SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >> >       SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >> >       SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> >> > --
> >> > 2.34.1
> >> >
> >> >

