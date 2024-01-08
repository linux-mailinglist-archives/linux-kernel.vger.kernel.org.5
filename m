Return-Path: <linux-kernel+bounces-19552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB8826EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE801C21E18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBF4652A;
	Mon,  8 Jan 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0qlnKAM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5574643C;
	Mon,  8 Jan 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336897b6bd6so1975521f8f.2;
        Mon, 08 Jan 2024 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704717473; x=1705322273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydZi+7MEKV7AqVazGsUhXNex/I1gb98UFo+mMABX9Jo=;
        b=F0qlnKAMVyEojigP6n2Rwp8co9HaSQOQk5C3jlCtlW41KfT9fN7Alc8jbzeEK9skVu
         ky3hZdJKSzaI98wShNjtKgGGwZH0D7ybPnPNmymh42Eyhmus/dfZeXbdhqc8Wi7tmNL7
         asljOJUx8hSnO7n9BeJw8ucEK4ahs3uO6MhekPg0mm3GWnpeu7vQVR39p0a/B5tVoo2x
         j5v8f1jd2FimPKTlDL6X/sroty1J5tau7x4pRD5SaI1U2GtOXado1lmZVRuGI9qkUnvY
         Yl+zvHV3gdRpU8+xKCC1XUdziVIrYDc/A1kbikzdam/IyKOi9Oz2NZhPPMfGDehsgiAE
         XM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717473; x=1705322273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydZi+7MEKV7AqVazGsUhXNex/I1gb98UFo+mMABX9Jo=;
        b=TtHVQVBs1VFP1+94GCoGYXOkVQSO13hdJCYjfHJzM9zAsRY2jFWF8hVAzsZDAdOXhy
         y+JIPXnONb01OU2XjuomWxLy23AjbK37TIWFTfo+MtSK/bA+hHltGGoypkxQxYaxtveX
         9+gjLQxDSiSUH4SuPmofbrepqPe6CRqHv/Bhh9ZIXkupYPcTpVr7MYxPVbnAuHVr/3pR
         oaGJExxnKlumuS3E4p0MjCHQKGnR982NSKZCBpGr4LEIM/Kc82+ggqoCFcPB2OM2JW5B
         oy4L6TL0fMUn/vfl/7rQRXrdhtDFfjQAuUqzWzzGz/+T9AF+UmxoGbsELJ7I/OX7nfsh
         xNBQ==
X-Gm-Message-State: AOJu0YyMSQPYf4cNtrxh/kmFPPaPhPBihqJ0jKh2ZyUjvgvJtqsh8ySj
	SqqJwFUzPes9lCVpLD7X2x8NCrbBqm835FFDVGo=
X-Google-Smtp-Source: AGHT+IHTqYiIpN1dr5yrgM+CDdeE0g5tfbnhXHENK5rJ+Qg3UHLEQuqNdauBSsC9gsUbW0OQEWfi4io6/vHLjuvObsE=
X-Received: by 2002:adf:fd43:0:b0:337:6f4a:122d with SMTP id
 h3-20020adffd43000000b003376f4a122dmr372152wrs.128.1704717472748; Mon, 08 Jan
 2024 04:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_CD95311972BE7A11FC41B4F5718E14E02D0A@qq.com>
In-Reply-To: <tencent_CD95311972BE7A11FC41B4F5718E14E02D0A@qq.com>
From: Huayu Zhang <zhanghuayu.dev@gmail.com>
Date: Mon, 8 Jan 2024 20:37:45 +0800
Message-ID: <CAB5Sz22VwnZg0=-i+sMwuf2VDnvmwjdth9RBjcMJmc5yLWk7zA@mail.gmail.com>
Subject: Re: [PATCH] add DSD for ThinkBook 16p G4 IRH with Subsystem Id of : 0x17aa38a9
To: Huayu Zhang <932367230@qq.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	james.schulman@cirrus.com, david.rhodes@cirrus.com, rf@opensource.cirrus.com, 
	perex@perex.cz, sbinding@opensource.cirrus.com, kailang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for missing the info within patch. As mentioned in the subject,
the patch is using to fix the sound issue of ThinkBook 16p G4 IRH with
Subsystem Id of : 0x17aa38a9. But this just enable the downside (bass)
speakers. When I tried to adjust the volumn, it atually mapped to the
frequency division (the lower volumn actually set the bass speakers,
and higher volumn map to the louder sound of up facing speakers).
Wondering if this related to ALSA?

On Mon, Jan 8, 2024 at 8:28=E2=80=AFPM Huayu Zhang <932367230@qq.com> wrote=
:
>
> From: Huayu Zhang <zhanghuayu.dev@gmail.com>
>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  sound/pci/hda/patch_realtek.c        | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41=
_hda_property.c
> index 35277ce890a4..b1844224123f 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -93,6 +93,7 @@ static const struct cs35l41_config cs35l41_config_table=
[] =3D {
>         { "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 0, 1, -1, 1000, 4500, 24 },
>         { "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 1, -1, 0, 0, 0, 0 },
>         { "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 1, 2, 0, 0, 0, 0 },
> +       { "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 0, 1, -1, 0, 0, 0 },
>         { "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 0, 1, -1, 0, 0, 0 },
>         { "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 0, 1, -1, 0, 0, 0 },
>         { "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },=
 0, 1, -1, 0, 0, 0 },
> @@ -427,6 +428,7 @@ static const struct cs35l41_prop_model cs35l41_prop_m=
odel_table[] =3D {
>         { "CSC3551", "10431F12", generic_dsd_config },
>         { "CSC3551", "10431F1F", generic_dsd_config },
>         { "CSC3551", "10431F62", generic_dsd_config },
> +       { "CSC3551", "17AA38A9", generic_dsd_config },
>         { "CSC3551", "17AA38B4", generic_dsd_config },
>         { "CSC3551", "17AA38B5", generic_dsd_config },
>         { "CSC3551", "17AA38B6", generic_dsd_config },
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index 1dcfba27e075..3eae1a5d9bcd 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10256,6 +10256,7 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
>         SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2=
781_I2C),
>         SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_T=
AS2781_I2C),
>         SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP=
_TAS2781_I2C),
> +       SND_PCI_QUIRK(0x17aa, 0x38a9, "ThinkBook 16p G4 IRH", ALC287_FIXU=
P_CS35L41_I2C_2),
>         SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXU=
P_CS35L41_I2C_2),
>         SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXU=
P_CS35L41_I2C_2),
>         SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXU=
P_CS35L41_I2C_2),
> --
> 2.34.1
>

