Return-Path: <linux-kernel+bounces-14105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A98217E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E121D1C21339
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626591FD2;
	Tue,  2 Jan 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WeFtMi+z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFFA20F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 297A73F747
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704178812;
	bh=MOiHQuQRDpvagvM10QNfEZBhf60btdOVa4ecWD3alXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WeFtMi+zIC8MPW6S6KpxN8XZ8pGfT/QPO+KR+nNLA+0dloz7Q5hjVjohtU9IWSyKu
	 HmM5wIn5CAnqCgGh8eLCJNfsKZyqXTDuuv6u9/BzjzINOLccXfj6biALxaIXOwJejH
	 I3ZKFe43NIR5VQ0LRUwGymZCH0Jg3M6dlNzB61wJrshpoGMP226bFzwE4h3oFm7c1/
	 sCiCiX8ScXNSZSyWe2JjGjE+QesifkW4taChhy2b6VVPtCNKv/y2cikE46KuTNbiM+
	 /5dJO5AY5RxaQ9xkKSZowH3m9aSm/1B1aE7cdQ4XVW2jzNtRigfn+Obymo/dFgLBJw
	 I8RflAmNlDapA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28c5c622a3cso3106737a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 23:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704178808; x=1704783608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOiHQuQRDpvagvM10QNfEZBhf60btdOVa4ecWD3alXA=;
        b=w3fXi+JMcpuJdnbV2lEYLNM2X+d+FhmH928zRIpNUNEW0VhLBEsGN6CqUKFtHqTUGl
         auzbQSoGicAga1mAnsbDlQMeLyJqvE1CQZSwsNuPoCMIlmDywgGIvGG5ZAcbXimedAL3
         iJbBrAc05mfdnvXjmbEK3kPemFGiAaP0JDpI9/ltwMbtEMceMU7zd9uPOxPAqgv3+cQR
         Msx8CKk6X1hlIGhWPB/AHP3TTV501i8lMo/kWd0aYLrcbykRxvDzv0rGx/4x0hO1S58C
         4J1SO9wQCgFsJd/Gp/jFidwV2JokSbzx7yVi9ahFfVrMhA2h1coMzdtNht89FXgCNVem
         Wa/w==
X-Gm-Message-State: AOJu0Yxnl9fXw2zSxIAi4O/sKSzFd2flRGRU6Qzdm64Coz5yqk83i4ne
	urDHT6H7cIgZ2QIcvPhYBQ6+3UqEA6nB22oefbsRR7y4/FdYWdBJ1GGDxzlyRh6LcMn99X9FrOx
	5e/dk0PCxdYGK17/YtrGZbgfG3EnMLrof+23VcY3UvGJoePhRZOHFk1+Ba3HWZtp6
X-Received: by 2002:a17:90a:540f:b0:28c:2b73:aea5 with SMTP id z15-20020a17090a540f00b0028c2b73aea5mr4134067pjh.34.1704178808188;
        Mon, 01 Jan 2024 23:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyzSSdiAp2rFi+1ChELgHYsz1t5ZIeMV+/axMC+n7I382sxXEQ3+n7RCqhZyF49IiPHJuyF2vMAE87owcSZ7s=
X-Received: by 2002:a17:90a:540f:b0:28c:2b73:aea5 with SMTP id
 z15-20020a17090a540f00b0028c2b73aea5mr4134059pjh.34.1704178807827; Mon, 01
 Jan 2024 23:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102024916.19093-1-andy.chi@canonical.com>
 <ZZOQamQsHUR7eEPd@geday> <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
 <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com> <ZZOwVZN7Xn2rIKtB@geday>
In-Reply-To: <ZZOwVZN7Xn2rIKtB@geday>
From: Andy Chi <andy.chi@canonical.com>
Date: Tue, 2 Jan 2024 14:59:56 +0800
Message-ID: <CAEzXkg0NLYxgKHr4iyoJPU7aZcrtcQFBo3o_K=qHuBpXeyNvbQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, Kailang Yang <kailang@realtek.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Shenghao Ding <shenghao-ding@ti.com>, 
	Matthew Anderson <ruinairas1992@gmail.com>, Luka Guzenko <l.guzenko@web.de>, 
	Yuchi Yang <yangyuchi66@gmail.com>, Vitaly Rodionov <vitalyr@opensource.cirrus.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:42=E2=80=AFPM Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> On Tue, Jan 02, 2024 at 01:49:40PM +0800, Andy Chi wrote:
> > Hi Geraldo,
> > Yes, this model is not yet publicly available, so I can't type the
> > full name on this patch.
> >
> > (change to text plain mode to send out again.)
>
Hi Geraldo,
> Hi Andy, please be kind and next time refrain from top-posting,
> as it reverses the attention order for those reading the
> discussion for posterity.
>
Got it, appreciate your feedback.
> I think it is reasonable to mention it explicitly as an
> upcoming product in order not to cause any confusion and
> to make sure there's another janitorial patch later on
> filling in the model details.
>
Should I mention it in the commit message? Or is it ok if I put the
model name after it's on the market?

> It's best to leave Takashi now to attend to your patch, and I
> congratulate both you as well as Canonical and HP for the
> effort towards bettering Linux.
Cheers :)

>
> Thanks for addressing this quickly.
>
> Geraldo Nascimento
>
> >
> > Kr,
> > Andy
> >
> >
> > On Tue, Jan 2, 2024 at 1:47=E2=80=AFPM Andy Chi <andy.chi@canonical.com=
> wrote:
> > >
> > > Hi Geraldo,
> > > Yes, this model is not yet publicly available, so I can't type the fu=
ll name on this patch.
> > >
> > > Kr,
> > > Andy
> > >
> > > On Tue, Jan 2, 2024 at 12:25=E2=80=AFPM Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> > >>
> > >> On Tue, Jan 02, 2024 at 10:49:15AM +0800, Andy Chi wrote:
> > >> > There is a HP ZBook which using ALC236 codec and need the
> > >> > ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
> > >> > and micmute LED work.
> > >>
> > >> Hi Andy,
> > >>
> > >> I know Takashi in the name of smooth operation usually takes this ki=
nd
> > >> of simple patch, quickly, since it's a simple bugfix, unless there a=
re
> > >> any objections, so I must raise one.
> > >>
> > >> Which HP ZBook? Which model?
> > >>
> > >> Is this a still unreleased model Canonical has had access under a ND=
A
> > >> for example? Or perhaps there is some other reason why you cannot na=
me
> > >> the model yet?
> > >>
> > >> Either way, there is a need to publicly know the reason for the miss=
ing
> > >> model information.
> > >>
> > >> >
> > >> > Signed-off-by: Andy Chi <andy.chi@canonical.com>
> > >> > ---
> > >> >  sound/pci/hda/patch_realtek.c | 1 +
> > >> >  1 file changed, 1 insertion(+)
> > >> >
> > >> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_r=
ealtek.c
> > >> > index 7e9d8c1cedfc..1c8d5b58eb64 100644
> > >> > --- a/sound/pci/hda/patch_realtek.c
> > >> > +++ b/sound/pci/hda/patch_realtek.c
> > >> > @@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fix=
up_tbl[] =3D {
> > >> >       SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287=
_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > >> >       SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287=
_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > >> >       SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287=
_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> > >> > +     SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED=
_MICMUTE_VREF),
> > >>
> > >> Same questioning as above. "HP" is IMHO unacceptable without a clear
> > >> reason for the missing model information.
> > >>
> > >> Thanks,
> > >> Geraldo Nascimento
> > >>
> > >> >       SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_=
CS35L41_SPI_2_HP_GPIO_LED),
> > >> >       SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_=
CS35L41_SPI_2_HP_GPIO_LED),
> > >> >       SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_F=
IXUP_CS35L41_SPI_4_HP_GPIO_LED),
> > >> > --
> > >> > 2.34.1
> > >> >
> > >> >

