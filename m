Return-Path: <linux-kernel+bounces-14062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBB82177D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0B21F21B17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956E15BD;
	Tue,  2 Jan 2024 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cV44ltPJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E11110
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 659E43F73B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704174592;
	bh=fLFoGUEkFptOzsytOMQgVkEYrrG8TjyytJsIzbEYWU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cV44ltPJ3hjXDtlYRM5Of6ZdtQG1qKCiUV+qVbdLbt4UcKynKFVdQviUE3/2QDiCn
	 ecm6MHehmRAswL8MtHsFk8GIQu3XddEW7zapwlDuXfsTOBo9Td9zatvMsiX0BxrnGZ
	 PhBaqm8csHN8b48EkdIYYqAGv+0oZgIdoV9DWelxNPr0PlBj3Opq6/xKtO+T3F9gVh
	 DQxZkrIOBCwpIkJo8I6YcjYe0Tc8unqt98m6aaYAynjAhef4Xg6CgzQBPTN+FS0OvS
	 bPocQUBMtyFXaH0834QNA+8gpEctsyi1jv20PmGowLz0bqFDOAHN28JbPiicEH8JjI
	 0G8ZEwPLF8JCA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28bf83bcae2so10631762a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704174591; x=1704779391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLFoGUEkFptOzsytOMQgVkEYrrG8TjyytJsIzbEYWU4=;
        b=I8uPnhDSGifU2E5ckw2oC2QKz4wksN7NSxInIQzbA9Kh1LL44vbLoQB14LWYu4gt+T
         IoWrmz9RR1dOATCc76cST1sRt/1BzZCDusA0Eh9LRVc3Sxhvq0aZHz+IuGSD9LssKLFi
         TXHrfSPrhRO9Eu7cCQ9dTfN81rEjoFt/gUXcCS0iNq5HWnmfdkCMdeHYH+JwgbHOMTVy
         eu7HXIyLOlGnpVbAPSZI1WVpwz7+ji8bZaiSv/Dk/2Q8DmnwSPb/S8UBQaPmz0r4nbDS
         HB6yCWZ/SNT+pLctSomwezJz+sID62ovWC7UnK8Kb3G5DXuF562+xYk+tsnMcxUKVVqG
         +MrA==
X-Gm-Message-State: AOJu0YyyEurP5flTJllizduJlGPxoHwmln/uRmCpVQsJ896Dmi1ue01w
	00LB84JSctQw92zHAuvECgJ/06j3BOkJS8UID7itoIZRz7Gcdrkg7U6RvjLiLwOYXWD9Jv4swzK
	fnoMdr6QEqAeJBnjCjnQLsXOvVGhGn4y7h6ALZ8NQ4d85s4ww/iLbwl4TrhdaBT8q
X-Received: by 2002:a17:90a:728c:b0:28c:a26b:a26 with SMTP id e12-20020a17090a728c00b0028ca26b0a26mr3875969pjg.3.1704174591096;
        Mon, 01 Jan 2024 21:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZadO3MQRP5EEFtCFCY6qGF7arVqwj3G0vRp4Jp89v1SCIruOZUSGhtuaMJBetAy98YxsUg7ICU8Nrl1zzugw=
X-Received: by 2002:a17:90a:728c:b0:28c:a26b:a26 with SMTP id
 e12-20020a17090a728c00b0028ca26b0a26mr3875965pjg.3.1704174590831; Mon, 01 Jan
 2024 21:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102024916.19093-1-andy.chi@canonical.com>
 <ZZOQamQsHUR7eEPd@geday> <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
In-Reply-To: <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
From: Andy Chi <andy.chi@canonical.com>
Date: Tue, 2 Jan 2024 13:49:40 +0800
Message-ID: <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>
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

Hi Geraldo,
Yes, this model is not yet publicly available, so I can't type the
full name on this patch.

(change to text plain mode to send out again.)

Kr,
Andy


On Tue, Jan 2, 2024 at 1:47=E2=80=AFPM Andy Chi <andy.chi@canonical.com> wr=
ote:
>
> Hi Geraldo,
> Yes, this model is not yet publicly available, so I can't type the full n=
ame on this patch.
>
> Kr,
> Andy
>
> On Tue, Jan 2, 2024 at 12:25=E2=80=AFPM Geraldo Nascimento <geraldogabrie=
l@gmail.com> wrote:
>>
>> On Tue, Jan 02, 2024 at 10:49:15AM +0800, Andy Chi wrote:
>> > There is a HP ZBook which using ALC236 codec and need the
>> > ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
>> > and micmute LED work.
>>
>> Hi Andy,
>>
>> I know Takashi in the name of smooth operation usually takes this kind
>> of simple patch, quickly, since it's a simple bugfix, unless there are
>> any objections, so I must raise one.
>>
>> Which HP ZBook? Which model?
>>
>> Is this a still unreleased model Canonical has had access under a NDA
>> for example? Or perhaps there is some other reason why you cannot name
>> the model yet?
>>
>> Either way, there is a need to publicly know the reason for the missing
>> model information.
>>
>> >
>> > Signed-off-by: Andy Chi <andy.chi@canonical.com>
>> > ---
>> >  sound/pci/hda/patch_realtek.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realt=
ek.c
>> > index 7e9d8c1cedfc..1c8d5b58eb64 100644
>> > --- a/sound/pci/hda/patch_realtek.c
>> > +++ b/sound/pci/hda/patch_realtek.c
>> > @@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fixup_t=
bl[] =3D {
>> >       SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIX=
UP_CS35L41_I2C_2_HP_GPIO_LED),
>> >       SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIX=
UP_CS35L41_I2C_2_HP_GPIO_LED),
>> >       SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIX=
UP_CS35L41_I2C_2_HP_GPIO_LED),
>> > +     SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MIC=
MUTE_VREF),
>>
>> Same questioning as above. "HP" is IMHO unacceptable without a clear
>> reason for the missing model information.
>>
>> Thanks,
>> Geraldo Nascimento
>>
>> >       SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35=
L41_SPI_2_HP_GPIO_LED),
>> >       SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35=
L41_SPI_2_HP_GPIO_LED),
>> >       SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP=
_CS35L41_SPI_4_HP_GPIO_LED),
>> > --
>> > 2.34.1
>> >
>> >

