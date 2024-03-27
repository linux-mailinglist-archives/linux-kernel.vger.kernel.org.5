Return-Path: <linux-kernel+bounces-121920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987688EF73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18B71F27316
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320F152173;
	Wed, 27 Mar 2024 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWPiFRAg"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DE13C9D1;
	Wed, 27 Mar 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568617; cv=none; b=DhYMumZJVI/Rcve/VBfzjCMztBUMj3YR4iCS6jupHryuiX/QuOxJxXsr+a4A00U0ZmAlFTrY1XqnzSqr+xraMYU4QKX4Wtem31VzyQPthC850FubRa64xYxYg4F8n+zFlJdIeZC7Zf+xNgl7ftnRbDhP/Z6Z7iLrRHh4FuNWe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568617; c=relaxed/simple;
	bh=uMkOMTTCJYMqd0bOvlMSglUb5JXgQT3RbYPO6J/obB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb12AfM9/13z0lmPCA+OIggO+QlCNl3oxwIQg3dtPWjTWptw+JbV0EYoHNX6K/OyRonIYyMFqJnByaQWWCYRZF4MNWc6qVeNXHMgxEKReBS64gWWLlTKJed21Z+kjQ0w7Niw1WhMvHoGceDtP8myJNAAAQGJbhCHB+OOSJ9wFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWPiFRAg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so1313961fa.3;
        Wed, 27 Mar 2024 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568614; x=1712173414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c64xHlCzEqyAPC97zuuo4cscMpx4AHNYnhUI1IMgUA=;
        b=eWPiFRAgrSZdCJTtEIsfwkMwDKfuF3kdCZ4GUUkD+8m5GdyzU3ALJwE+iOEnaI45q6
         QdveOYnHoHzux8zyEcaQ2YOsoSi73qT7v3Pc+UZJackFHbt+nARdOXI+TmjPygqbE3oc
         gpXoKo2rtBlZlQp+ALkdgeGrTieYBeKxQs4C2Cudwa6C32U7NUW8f7YtDNEnuM8bBK7x
         VulWeh9YhixF8irxYJN/ukJ4Hwz51H7eDC6VeVm0acIzaWsUKwB45RChLvEoBsoenSOX
         Ze3EzUfGZq78Tm0le8R5A1OZ4fXqkBVJX4fdfCaBuZ4AqETyK4XxYEQHCxQ+0RSEme1y
         Z/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568614; x=1712173414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c64xHlCzEqyAPC97zuuo4cscMpx4AHNYnhUI1IMgUA=;
        b=Wg5RDwyRAWYFaqdUbGgAYsrfwZAnBzVkJ6Nzvfq/E1vwnI7S0SHrhmv20uZ0ZYV7aP
         qjQXrDegXnXd2hlg7dKTQLywuCFlQClFqZu4TlRV93aQXckmt5rqWMd/cZ5sIR3nndY7
         LG/dDpBHjWTW877gMUIDegkPFLAiGYhXUjoGD0z+g2vzOz0AKsA3BOmOjEjzkSNmcpb3
         r6a235BZekmHVv7WJBwXvgbpHbq/esnvEDcKeDH10FB8p6zxaxYblBUXegJT9Z0dHQAN
         g4WkmUfEX6bk7592N/U21VA2Ytx1kgDQCJBpvRZ70oJd0NvLrJdglWMQBVflj/HnZf5U
         GKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEbUr0HceySEN2HOYC5AinBaPl7CNGHqoMFIPCd5QxXp7HTPSeGZP9ujUNgRm9FqVMGMmrTyDjpocX+R1m06ycVUwxcMQGDH1aGik=
X-Gm-Message-State: AOJu0YwygqT5mi7QAJDpJJWzY0rJmcbHINYaDRgWqVQyITPS8ESEYK+p
	73XQo+xMsEFK3ZjSlatY82UIsos+W42YpR/zb1pE8sFsw5x0+2ZIUr+Fi/ljS+Y=
X-Google-Smtp-Source: AGHT+IG9yzcV9fBkYZKDIGCOXbhoCA4Hz1gvtdCmTrhIctSfKXVoTIph0m5FtO+5obLDUuhb8mYXXA==
X-Received: by 2002:a2e:9cd8:0:b0:2d5:9bd4:4496 with SMTP id g24-20020a2e9cd8000000b002d59bd44496mr702498ljj.50.1711568613516;
        Wed, 27 Mar 2024 12:43:33 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b0056c4372c161sm608546eda.55.2024.03.27.12.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:43:33 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org,
 =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: Ondrej Jirman <megi@xff.cz>, kernel test robot <lkp@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Rob Herring <robh@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Subject:
 Re: [PATCH] ASoC: sun8i-codec: Fix build with CONFIG_SND_JACK_INPUT_DEV
 disabled
Date: Wed, 27 Mar 2024 20:43:31 +0100
Message-ID: <1785985.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20240327080542.3649840-1-megi@xff.cz>
References: <20240327080542.3649840-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 27. marec 2024 ob 09:05:34 CET je Ond=C5=99ej Jirman napisal(a):
> From: Ondrej Jirman <megi@xff.cz>
>=20
> When CONFIG_SND_JACK_INPUT_DEV is disabled, struct snd_jack doesn't
> have 'type' field. We can't rely on this field being always present,
> so store the jack_type in the codec driver itself.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403261243.kcXCPAYs-lkp@i=
ntel.com/
> ---
> This is a followup for https://lore.kernel.org/lkml/2vhd45kylttgonosdcfn7=
ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh/
>=20
>  sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 43795362fed0..b5dafb749c3f 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -232,6 +232,7 @@ struct sun8i_codec {
>  	struct delayed_work		jack_work;
>  	int				jack_irq;
>  	int				jack_status;
> +	int				jack_type;

Where is this variable set? Below I see just usage of its value.

Best regards,
Jernej

>  	int				jack_last_sample;
>  	ktime_t				jack_hbias_ready;
>  	struct mutex			jack_mutex;
> @@ -1352,7 +1353,6 @@ static void sun8i_codec_jack_work(struct work_struc=
t *work)
>  	struct sun8i_codec *scodec =3D container_of(work, struct sun8i_codec,
>  						  jack_work.work);
>  	unsigned int mdata;
> -	int type_mask =3D scodec->jack->jack->type;
>  	int type;
> =20
>  	guard(mutex)(&scodec->jack_mutex);
> @@ -1363,7 +1363,7 @@ static void sun8i_codec_jack_work(struct work_struc=
t *work)
> =20
>  		scodec->jack_last_sample =3D -1;
> =20
> -		if (type_mask & SND_JACK_MICROPHONE) {
> +		if (scodec->jack_type & SND_JACK_MICROPHONE) {
>  			/*
>  			 * If we were in disconnected state, we enable HBIAS and
>  			 * wait 600ms before reading initial HDATA value.
> @@ -1376,7 +1376,7 @@ static void sun8i_codec_jack_work(struct work_struc=
t *work)
>  			scodec->jack_status =3D SUN8I_JACK_STATUS_WAITING_HBIAS;
>  		} else {
>  			snd_soc_jack_report(scodec->jack, SND_JACK_HEADPHONE,
> -					    type_mask);
> +					    scodec->jack_type);
>  			scodec->jack_status =3D SUN8I_JACK_STATUS_CONNECTED;
>  		}
>  	} else if (scodec->jack_status =3D=3D SUN8I_JACK_STATUS_WAITING_HBIAS) {
> @@ -1417,17 +1417,17 @@ static void sun8i_codec_jack_work(struct work_str=
uct *work)
>  		if (type =3D=3D SND_JACK_HEADPHONE)
>  			sun8i_codec_set_hmic_bias(scodec, false);
> =20
> -		snd_soc_jack_report(scodec->jack, type, type_mask);
> +		snd_soc_jack_report(scodec->jack, type, scodec->jack_type);
>  		scodec->jack_status =3D SUN8I_JACK_STATUS_CONNECTED;
>  	} else if (scodec->jack_status =3D=3D SUN8I_JACK_STATUS_CONNECTED) {
>  		if (scodec->last_hmic_irq !=3D SUN8I_HMIC_STS_JACK_OUT_IRQ_ST)
>  			return;
> =20
>  		scodec->jack_status =3D SUN8I_JACK_STATUS_DISCONNECTED;
> -		if (type_mask & SND_JACK_MICROPHONE)
> +		if (scodec->jack_type & SND_JACK_MICROPHONE)
>  			sun8i_codec_set_hmic_bias(scodec, false);
> =20
> -		snd_soc_jack_report(scodec->jack, 0, type_mask);
> +		snd_soc_jack_report(scodec->jack, 0, scodec->jack_type);
>  	}
>  }
> =20
> @@ -1491,7 +1491,7 @@ static irqreturn_t sun8i_codec_jack_irq(int irq, vo=
id *dev_id)
>  		if (scodec->jack_last_sample >=3D 0 &&
>  		    scodec->jack_last_sample =3D=3D value)
>  			snd_soc_jack_report(scodec->jack, type,
> -					    scodec->jack->jack->type);
> +					    scodec->jack_type);
> =20
>  		scodec->jack_last_sample =3D value;
>  	}
>=20





