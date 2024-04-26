Return-Path: <linux-kernel+bounces-160175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E758B3A36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A5288907
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1614885D;
	Fri, 26 Apr 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq51WKjr"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805B13F43A;
	Fri, 26 Apr 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142367; cv=none; b=H8tZsSPv7387w8ViFNMSDcc+4z7ThSERPx5epDN5729jM7jEU5geqSaOBk0CfZ8OKeW74UU6oC3qOn8UDABF4kzdcBZiOKxNgSIWwOV/5uVgtb48pImx6zF83suV4OkFM8nCE+CJeJIibyS4xOggaYMq2F8a38zcXX/eNkr2TiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142367; c=relaxed/simple;
	bh=GrYW9CDBavo2dcW9zM8Gw/4eM+v8rP9srC8IHUunxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPRZPVVFaQlpmGFh3876Qz5FZfKHHPhVWxuZR6FG0vzUGk3oVAUK1poieNg4bJ484ciRULJBOGF8aU87eEYRVnRCrO8+y2QYUD/oA6FU0tYOW94Y+Ys1K/LcIS9DSde9pqA59HDmjvZPwv0JQh1Q77eJo28qGYExsbNFnoMiWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq51WKjr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso3420465e9.1;
        Fri, 26 Apr 2024 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142364; x=1714747164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6+Pa/hI1y9ZPcsTSA6wG8AnTaAGOiXpZcyJZzX026s=;
        b=Eq51WKjrouMFwzggvNQc4OiiH9ylm8ionjqrGB0eoVV+sIR7ZZ6up8InCz5SR7A1pF
         Zj+LdumQxK0ua2eLyb/EXTa2GCimmIrLtQa7WBWAXwAViDk1sVK2LcfAoO4BOfcLveIA
         SpdS9bTvpKhSw2K+SYZD6y+27WX/m/tEBkuBp+xFwnVm9iz1X2YnReEd8tx9jHfatAFu
         ejZOxP49iX0HCflvXwor4V/bZAOy5OTBg2Rueia2DN4izhp1vdHYVUp7PyRSlCOF0T/+
         OPdPYvocz2/CnPxodTlkia8oUapqYlvPUbSaShq0RBGebmg5G5Kpele65NG2ubvNkjmF
         80bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142364; x=1714747164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6+Pa/hI1y9ZPcsTSA6wG8AnTaAGOiXpZcyJZzX026s=;
        b=KPAJwdOaYnnops28HlgS81TGUO86SZEF7wlUkFAIl1UmmpackZZ8aW7yRF1kG0M5u/
         LGGuaN0T1irK6ctkQHpP+n2HP9TBTa6W/8Z/P6ar1wMbyGUISMeGm5nRAgH+0FEGNNze
         +Evgsvi6EhGEPYp+SJXnPGQ6CSCrxMbysFQMfj+snn2z8fbBPXYJ4s8uHeRG9kMUDZi+
         VG9s5hujUeb8d1WcFMbm2pdtLr6aweQ3od5yJKTTPwPtYJph1tT0xii5i2F1eScXjXJK
         eeq7xjp0XCUCtqG6+HlsULrXCDJTia+YW8rwlm62mXde2c9VjVWR1Ym92In7w3bh0v1x
         o5fw==
X-Forwarded-Encrypted: i=1; AJvYcCXt/DrIBo0ND9fTK5GB4nJ9QTEt8eO8mCVnmGQI3YSnwN+pKUdW5dLZbCOTUuDhpTyMH38hLaWtJr+7XMOs4ZwtcN/b0JDaUCGQXuy5WVB3YZ4RZR4BEqznYcPY9+18TehZPK63+/UrGlk=
X-Gm-Message-State: AOJu0YxWxvo9KZYPtdGut54HfBd6r+hcOGX/E6ZX3Kl3yetki7H/apPI
	tFEADNqsl2XbalXmOe+ekqN3zEvZ/gR6O7ZbP+vKUbBoP7VTJ3IR
X-Google-Smtp-Source: AGHT+IEeWmdV/an942UKZb0UcElZTOltLZZNCg90qG5k3ACvdMG2TZ2EWCL32aHLDIlkCsd0vGPv5g==
X-Received: by 2002:a05:600c:3b86:b0:419:618:ade3 with SMTP id n6-20020a05600c3b8600b004190618ade3mr2897823wms.19.1714142363495;
        Fri, 26 Apr 2024 07:39:23 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm35036561wmo.21.2024.04.26.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 07:39:23 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Joao Schim <joao@schimsalabim.eu>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] ASoC: sunxi: DMIC: Add controls for adjusting the mic gains
Date: Fri, 26 Apr 2024 16:39:22 +0200
Message-ID: <2262648.iZASKD2KPV@jernej-laptop>
In-Reply-To: <e256942d-eba1-4800-bd02-c490167dea12@schimsalabim.eu>
References:
 <20240422150213.4040734-1-joao@schimsalabim.eu>
 <5772237.DvuYhMxLoT@jernej-laptop>
 <e256942d-eba1-4800-bd02-c490167dea12@schimsalabim.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 25. april 2024 ob 13:03:56 GMT +2 je Joao Schim napisal(a=
):
> On 4/24/24 20:42, Jernej =C5=A0krabec wrote:
> > Hi Joao,
> Hi Jernej,  thanks for your prompt response.
> >
> > Dne ponedeljek, 22. april 2024 ob 17:02:13 GMT +2 je Joao Schim napisal=
(a):
> >> The AllWinner H6 and later SoCs that sport a DMIC block contain a set =
of registers to control
> >> the gain (left + right) of each of the four supported channels.
> >>
> >> Add ASoC controls for changing each of the stereo channel gains using =
alsamixer and alike
> > Add SoB tag.
> Yeah, i realized that too late. Thanks for bringing that to my=20
> attention. I will add it in v1.
> >
> >> ---
> >>   sound/soc/sunxi/sun50i-dmic.c | 34 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dm=
ic.c
> >> index c76628bc86c6..f8613d8c3462 100644
> >> --- a/sound/soc/sunxi/sun50i-dmic.c
> >> +++ b/sound/soc/sunxi/sun50i-dmic.c
> >> @@ -14,6 +14,7 @@
> >>   #include <sound/dmaengine_pcm.h>
> >>   #include <sound/pcm_params.h>
> >>   #include <sound/soc.h>
> >> +#include <sound/tlv.h>
> >>  =20
> >>   #define SUN50I_DMIC_EN_CTL			(0x00)
> >>   	#define SUN50I_DMIC_EN_CTL_GLOBE			BIT(8)
> >> @@ -43,6 +44,17 @@
> >>   	#define SUN50I_DMIC_CH_NUM_N_MASK			GENMASK(2, 0)
> >>   #define SUN50I_DMIC_CNT				(0x2c)
> >>   	#define SUN50I_DMIC_CNT_N				(1 << 0)
> >> +#define SUN50I_DMIC_D0D1_VOL_CTR		(0x30)
> >> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0R			(0)
> >> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0L			(8)
> >> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1R			(16)
> >> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1L			(24)
> >> +#define SUN50I_DMIC_D2D3_VOL_CTR                (0x34)
> >> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2R                     (0)
> >> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2L                     (8)
> >> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3R                     (16)
> >> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3L                     (24)
> >> +
> >>   #define SUN50I_DMIC_HPF_CTRL			(0x38)
> >>   #define SUN50I_DMIC_VERSION			(0x50)
> >>  =20
> >> @@ -273,8 +285,30 @@ static const struct of_device_id sun50i_dmic_of_m=
atch[] =3D {
> >>   };
> >>   MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
> >>  =20
> >> +static const DECLARE_TLV_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, =
1);
> > DECLARE_TLV_DB_SCALE is old name, SNDRV_CTL_TLVD_DECLARE_DB_SCALE shoul=
d be
> > used instead.
> I can't seem to find that define in HEAD. what code-base are you=20
> referring to that i should checkout ?

Here is define:=20
https://elixir.bootlin.com/linux/v6.9-rc1/source/include/uapi/sound/tlv.h#L=
52

However, I'm not sure if this message means DECLARE_TLV_DB_SCALE is
deprecated or not:
https://elixir.bootlin.com/linux/v6.9-rc1/source/include/sound/tlv.h#L12

Best regards,
Jernej

> >
> > Other than that, it looks fine.
>=20
> Thanks.
>=20
> > Best regards,
> > Jernej
> >
> >> +
> >> +static const struct snd_kcontrol_new sun50i_dmic_controls[] =3D {
> >> +
> >> +        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D=
0D1_VOL_CTR,
> >> +                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_=
VOL_CTR_0R,
> >> +                       0xFF, 0, sun50i_dmic_vol_scale),
> >> +        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D=
0D1_VOL_CTR,
> >> +                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_=
VOL_CTR_1R,
> >> +                       0xFF, 0, sun50i_dmic_vol_scale),
> >> +        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D=
2D3_VOL_CTR,
> >> +                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_=
VOL_CTR_2R,
> >> +                       0xFF, 0, sun50i_dmic_vol_scale),
> >> +        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D=
2D3_VOL_CTR,
> >> +                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_=
VOL_CTR_3R,
> >> +                       0xFF, 0, sun50i_dmic_vol_scale),
> >> +
> >> +
> >> +};
> >> +
> >>   static const struct snd_soc_component_driver sun50i_dmic_component =
=3D {
> >>   	.name           =3D "sun50i-dmic",
> >> +	.controls	=3D sun50i_dmic_controls,
> >> +	.num_controls	=3D ARRAY_SIZE(sun50i_dmic_controls),
> >>   };
> >>  =20
> >>   static int sun50i_dmic_runtime_suspend(struct device *dev)
> >>
> >
> >
> >
> Kind regards,
>=20
> Joao
>=20
>=20





