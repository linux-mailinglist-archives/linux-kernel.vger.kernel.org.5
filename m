Return-Path: <linux-kernel+bounces-14015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7807F8216DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7146FB2106D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB610EC;
	Tue,  2 Jan 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLLJDVSW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC87EC6;
	Tue,  2 Jan 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fd902c6b5so79052905ab.3;
        Mon, 01 Jan 2024 20:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704169540; x=1704774340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgu+L4a+/WjpDzPChrb4wmpOc+fKr17SKFK+8wM2uf0=;
        b=gLLJDVSWAC5aoSmCG/cb+sRKwWEp0fIZgphSAZJS7tuKgcGyX5EDQ5PYYeO05J53Xo
         3dNu1g2aAa2clTMI4visJln4BY4kdmpyksOrXyL7m+jc8whE6dyZjEsbTUXnvyI+kgH9
         RZ6hykBXBILvj1xWxmOLP0evfBWFSRrbMFPSCXhkhtGqav19RfhoV+eoTZkuYnESi4Vn
         uBTN9ja5Z6XYxUtzkX77WJPi1nmqf3taAWEYPDHjukwJm0j9Xp2FIS+DTz/0jP0fYwnM
         td3MOrqENXaROuYhiyh2RB0vv3MN6OtbNvurG80Q9wn3UnzANlzsEfSkjobxDC+6FOLY
         pTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704169540; x=1704774340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgu+L4a+/WjpDzPChrb4wmpOc+fKr17SKFK+8wM2uf0=;
        b=LFFyLloN2wc3djoQ604+4dYCDaES8HMc9XJ6c3HmnUoT/GEgxCAi34PuTUNZATVMYG
         QTNpCAQKYT4dyqdjsxA32fqcj6wvYt/xckaE23MPgHcCO1bIDyXtGspwOA6TXKA2jywJ
         NMReYQaeGfRfxamocp+mkdUmygBBKjiOJoS+ZDQKwmAnOxpVnTuq5T9zH03fJ+BF4jdS
         +sC/Me7df/ZwqUqxSO8OgQsyelnngN8ecOaf20UeA9JgQrdgenqK0w86zwbM13yXC/fz
         Rd4Qr1KRtRKbLbV8namvbXX9oUh52V4oXwW2xfryZv5s6LF6mMUYzhlJW6F00ZOCepWD
         ZkOg==
X-Gm-Message-State: AOJu0YwPR1jdc+Iadi4Es4vUkVVgS+75/wVoAudQ6/5sT/3kCn7AG7/9
	Kl1BSH/I1X+DHVC02VQgjGI=
X-Google-Smtp-Source: AGHT+IFWqjQSfHgcTGsot6wD9z4gdmFYaUUekqZrAob7I8yMqCSxqoX7FH4fPJY6HQWE6FjdSNi42g==
X-Received: by 2002:a05:6e02:1d13:b0:35f:ccab:360e with SMTP id i19-20020a056e021d1300b0035fccab360emr26472618ila.1.1704169540585;
        Mon, 01 Jan 2024 20:25:40 -0800 (PST)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id jd19-20020a170903261300b001d4ca3087dfsm44726plb.234.2024.01.01.20.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:25:39 -0800 (PST)
Date: Tue, 2 Jan 2024 01:26:18 -0300
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
Message-ID: <ZZOQamQsHUR7eEPd@geday>
References: <20240102024916.19093-1-andy.chi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102024916.19093-1-andy.chi@canonical.com>

On Tue, Jan 02, 2024 at 10:49:15AM +0800, Andy Chi wrote:
> There is a HP ZBook which using ALC236 codec and need the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
> and micmute LED work.

Hi Andy,

I know Takashi in the name of smooth operation usually takes this kind
of simple patch, quickly, since it's a simple bugfix, unless there are
any objections, so I must raise one.

Which HP ZBook? Which model?

Is this a still unreleased model Canonical has had access under a NDA
for example? Or perhaps there is some other reason why you cannot name
the model yet?

Either way, there is a need to publicly know the reason for the missing
model information.

> 
> Signed-off-by: Andy Chi <andy.chi@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 7e9d8c1cedfc..1c8d5b58eb64 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),

Same questioning as above. "HP" is IMHO unacceptable without a clear
reason for the missing model information.

Thanks,
Geraldo Nascimento

>  	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> -- 
> 2.34.1
> 
> 

