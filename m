Return-Path: <linux-kernel+bounces-14123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFA821812
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981C91C21550
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D02105;
	Tue,  2 Jan 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9F2kOw5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AF20E0;
	Tue,  2 Jan 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da47688fd9so458360b3a.0;
        Mon, 01 Jan 2024 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704181474; x=1704786274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wg9z40SKV9zz/Qh6H6yd7L4Gx2w+wLF8wf2B0iINmZI=;
        b=W9F2kOw5T2n/wNwoUfemH4fyx7XtpyCGklRD2MxOzgzUsB18+q5At3oWg4DbhX5VIH
         3g36M2KOMPgceng229YPdtLm4dBaBvn4SMVvrb/f+JCyE/ZQFyj96YFreXjtAFLhdZXV
         L0mRiYuSIhswdtJ1K0j1twG2WxyyLO5+P7wV0cSeXJC1dEAbKoPwuPrchRwFsD4IHajs
         g3ZEkR0kpda+6CRVKJdJPFNR1qkzx+96wIsl4rtpj8aXmXByZljxLSVKrZ5jjNjb0EQh
         fFqXjumApqBdC1u6hAG614dBJWKDy+kbg8ToJsAs6+uUgaGVAlfYE3jNpiNMUk7Z29Lu
         vsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704181474; x=1704786274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wg9z40SKV9zz/Qh6H6yd7L4Gx2w+wLF8wf2B0iINmZI=;
        b=VfEOegc+lrOFkf6tarOC/a2DRWZIKItAxXOgYxjUg55KnVsK2ATtlCbWXMWZnribab
         bSxvYXQE+o0OhVvsN71SEApq+8WzNfpS7f451Or6QeM4PyV4AJrXF+0QZ2jIiz6V2CuU
         EMZgef4Zi/tXlsL/hBv+SwlI1thPikIkfLEGrOZ+HA7EY4KpmnmkFrBArE6M1CyCJfIp
         0yKU+5g9ewN2O5YhUenUjNYw+WT+7TRMZ9y/TSl7E4YI4MTRhAT7oKOiQWfh+NZJIed2
         8my52tYXTeRJ4iRMGsiaoQ2nCxKXoWTB/9wzyHcupGk0f9wW0qfzlmEMkOSl5+sXFwRB
         QHNA==
X-Gm-Message-State: AOJu0Yy09cPRwsZKoKWuaejzwu+W7yAqce2oXiutHSKwiQcr26Zv7pOD
	ql9kTSHVioFDSVDbwdMj7nE=
X-Google-Smtp-Source: AGHT+IG7R1XLlIRSqqFaPgRkrxnUewPMPirqkWd9ZOxWtQb782pbhMKWrC7vJ9/nwC6UtJCaVtEPwg==
X-Received: by 2002:a05:6a21:3e0c:b0:195:f98f:13f3 with SMTP id bk12-20020a056a213e0c00b00195f98f13f3mr4980364pzc.35.1704181473909;
        Mon, 01 Jan 2024 23:44:33 -0800 (PST)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902704900b001d05456394csm21399587plt.28.2024.01.01.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 23:44:33 -0800 (PST)
Date: Tue, 2 Jan 2024 04:45:07 -0300
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
Message-ID: <ZZO/Az2puwFY5L3R@geday>
References: <20240102024916.19093-1-andy.chi@canonical.com>
 <ZZOQamQsHUR7eEPd@geday>
 <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
 <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>
 <ZZOwVZN7Xn2rIKtB@geday>
 <CAEzXkg0NLYxgKHr4iyoJPU7aZcrtcQFBo3o_K=qHuBpXeyNvbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXkg0NLYxgKHr4iyoJPU7aZcrtcQFBo3o_K=qHuBpXeyNvbQ@mail.gmail.com>

On Tue, Jan 02, 2024 at 02:59:56PM +0800, Andy Chi wrote:
> On Tue, Jan 2, 2024 at 2:42 PM Geraldo Nascimento
> <geraldogabriel@gmail.com> wrote:
> >
> > On Tue, Jan 02, 2024 at 01:49:40PM +0800, Andy Chi wrote:
> > > Hi Geraldo,
> > > Yes, this model is not yet publicly available, so I can't type the
> > > full name on this patch.
> > >
> > > (change to text plain mode to send out again.)
> >
> Hi Geraldo,
> > Hi Andy, please be kind and next time refrain from top-posting,
> > as it reverses the attention order for those reading the
> > discussion for posterity.
> >
> Got it, appreciate your feedback.
> > I think it is reasonable to mention it explicitly as an
> > upcoming product in order not to cause any confusion and
> > to make sure there's another janitorial patch later on
> > filling in the model details.
> >
> Should I mention it in the commit message? Or is it ok if I put the
> model name after it's on the market?

Andy, in order to clear up any confusion that might arise later on, and
to maintain high the quality of both code and git meta-information I think
you should explicitly mention both in the commit info and commit message
that this is an upcoming product.

Also, instead of just "HP" in the commit proper, it should say something
like "Upcoming HP ZBook".

But that's just my advice, now you need to wait and hear Takashi's advice.

We should always strive toward striking a healthy balance between companies'
needs and the public nature of the development of the Linux kernel and ALSA.
Unfortunately that means some details of upcoming models may end up
catching up the attention of the specialized press.

I encourage you to look on the bright side and think of it as free PR ;)

Best Regards,
Geraldo Nascimento

> 
> > It's best to leave Takashi now to attend to your patch, and I
> > congratulate both you as well as Canonical and HP for the
> > effort towards bettering Linux.
> Cheers :)
> 
> >
> > Thanks for addressing this quickly.
> >
> > Geraldo Nascimento
> >
> > >
> > > Kr,
> > > Andy
> > >
> > >
> > > On Tue, Jan 2, 2024 at 1:47 PM Andy Chi <andy.chi@canonical.com> wrote:
> > > >
> > > > Hi Geraldo,
> > > > Yes, this model is not yet publicly available, so I can't type the full name on this patch.
> > > >
> > > > Kr,
> > > > Andy
> > > >
> > > > On Tue, Jan 2, 2024 at 12:25 PM Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > > >>
> > > >> On Tue, Jan 02, 2024 at 10:49:15AM +0800, Andy Chi wrote:
> > > >> > There is a HP ZBook which using ALC236 codec and need the
> > > >> > ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
> > > >> > and micmute LED work.
> > > >>
> > > >> Hi Andy,
> > > >>
> > > >> I know Takashi in the name of smooth operation usually takes this kind
> > > >> of simple patch, quickly, since it's a simple bugfix, unless there are
> > > >> any objections, so I must raise one.
> > > >>
> > > >> Which HP ZBook? Which model?
> > > >>
> > > >> Is this a still unreleased model Canonical has had access under a NDA
> > > >> for example? Or perhaps there is some other reason why you cannot name
> > > >> the model yet?
> > > >>
> > > >> Either way, there is a need to publicly know the reason for the missing
> > > >> model information.
> > > >>
> > > >> >
> > > >> > Signed-off-by: Andy Chi <andy.chi@canonical.com>
> > > >> > ---
> > > >> >  sound/pci/hda/patch_realtek.c | 1 +
> > > >> >  1 file changed, 1 insertion(+)
> > > >> >
> > > >> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > > >> > index 7e9d8c1cedfc..1c8d5b58eb64 100644
> > > >> > --- a/sound/pci/hda/patch_realtek.c
> > > >> > +++ b/sound/pci/hda/patch_realtek.c
> > > >> > @@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > > >> > +     SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> > > >>
> > > >> Same questioning as above. "HP" is IMHO unacceptable without a clear
> > > >> reason for the missing model information.
> > > >>
> > > >> Thanks,
> > > >> Geraldo Nascimento
> > > >>
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> > > >> >       SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> > > >> > --
> > > >> > 2.34.1
> > > >> >
> > > >> >

