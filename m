Return-Path: <linux-kernel+bounces-147902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D78A7B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C63C2831B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB040847;
	Wed, 17 Apr 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEgAm91v"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0228377;
	Wed, 17 Apr 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325807; cv=none; b=uzvYG1vw/wpdstfQYDSVp23n89fdjyVPuZbvsd6uJwZHzWbiVdM5Xem1muZZkSpO/yPFzgJJIfvzmqjQBWr7Ix99gj7pjDWNdC8DngYRM3SnHLPQvuzyni5JxlsD0e33jdGExSVRqCQstRLfXMAnI6Rph1iqyEooqPfj9viz7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325807; c=relaxed/simple;
	bh=6aMLs/p7uQeidHu4TOfmlGpoIun981aR05OPBaaX4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuXOtPmkYGjoTmHvXDJf+HrtxOH2sFrh7/hbM99NPEwEKjE9t6p9zzjWjBhgHzywGgkaG5spb2Wx62r+0MeYVpH7/6GSKKBcdXYn/e1FZPvmnOO5BwpDi1a/gmdk8ZkpwgK2FsbsA5as1jgEFtiqfFC15KRAVcY8Gva2ebROZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEgAm91v; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so3545717fac.0;
        Tue, 16 Apr 2024 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713325805; x=1713930605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h00s7gBtw4VPIHusdKddXgmfRbvsvFgdsk1a5bljj/Q=;
        b=EEgAm91v5Yf3gDpLWOG2589RBk1D0lEc/IoQLqrrerks/uJu/vNVqqeJCqLOTDzhNL
         0XtnjHxFoST5RkeY1XEF6TyXTTBC3q3Cm84S4AOs/XlBiXunyOlT4Ds61tkZQoZzjOFD
         zT+vRfyNga67NTs2e7XMzm0HUrkY/N9doYxiZ3WDjOrl+t2BOC7iWB2kdpnO8NqrH3bI
         CZvsDx3/Tyc6x9B72xKRoropeOCOCOj5VL7Sc0zGHApA0LU14K/2pjrUoYgUgIHarR8E
         pgS/zHXgLPR7pUQ8XOwPn82sCWZrndtMQL619MsC31OEDkXiJmGg++foX+A7al8mQSSk
         IM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713325805; x=1713930605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h00s7gBtw4VPIHusdKddXgmfRbvsvFgdsk1a5bljj/Q=;
        b=e2bBIDmDz00pcCC2ukV78XqpuWFSjYa/FRFFMHZxA3UgwdVqt07B3EPEz4MnD0it1A
         Qe0+7zkHgPtyt0HWIMHdJxeHV8on0m+csKk+XeK4xiPhJErlyNHKihdaA8UpoUmLU6G4
         wVifnVJvhYjgLrz7PeOozSWRX40yRj9/op5Zk1W8cUiZlz36DfdBNXcPb77FEgtTs56I
         iNW309tc0VNkwmcxZIGPq5S63UHjEzx/tx9+t4zECf1wnnOHEH4Jor53BkxWC1dnDSAZ
         4BfPRxJvae7jWxosuiAWOeEVFnlDw0E1JNLm3CoUkj6y4wEon1Mk3v2RdcT8SQ7tHxZM
         Mb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT0DjCdhqfd1Pc7HjUIgizBFb9Fasowvfs88D2H8owFNvdCAmzHjUvtCIAT0MRRExUWsm2MCjKYw4ODATpTs71/NBi78PIuwG6whL5aX0QbOUhT+1utkspMz23oYmjek+WwKJp+8N6MWIA/eiQH/7DSIEJxWVaYoXR4gwYTppXzynBYAo=
X-Gm-Message-State: AOJu0YxiSQgiJb2qauOdsKgi1Iijduvuuy9+rEEmZ8kQYKVJnVSItd/2
	EOJJyajpLaz+EJ1/lUD/AhSAQJ28uSWWY4wvNX4dt2FGTD5rSkYK
X-Google-Smtp-Source: AGHT+IHxsAOWZUIs0ioXX5+gCWVy7v2qTz6kHzGO3H6TXkUS48v46D68Or9D2br3iyA6MGGmEt49ng==
X-Received: by 2002:a05:6871:b27:b0:22e:a204:9bb5 with SMTP id fq39-20020a0568710b2700b0022ea2049bb5mr17697702oab.53.1713325804987;
        Tue, 16 Apr 2024 20:50:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j3-20020a635503000000b005e83b64021fsm9577462pgb.25.2024.04.16.20.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:50:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5E18218491EBE; Wed, 17 Apr 2024 10:49:58 +0700 (WIB)
Date: Wed, 17 Apr 2024 10:49:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] ASoC: doc: dapm: fix typos
Message-ID: <Zh9G5TX6682WzvbI@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-1-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u9U67xacMNIq60tW"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-1-a818d2819bf6@bootlin.com>


--u9U67xacMNIq60tW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:07AM +0200, Luca Ceresoli wrote:
> diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/d=
apm.rst
> index c3154ce6e1b2..59f65b181828 100644
> --- a/Documentation/sound/soc/dapm.rst
> +++ b/Documentation/sound/soc/dapm.rst
> @@ -50,7 +50,7 @@ Stream domain
>  All DAPM power switching decisions are made automatically by consulting =
an audio
>  routing map of the whole machine. This map is specific to each machine a=
nd
>  consists of the interconnections between every audio component (including
> -internal codec components). All audio components that effect power are c=
alled
> +internal codec components). All audio components that affect power are c=
alled
>  widgets hereafter.
> =20
> =20
> @@ -221,7 +221,7 @@ when the Mic is inserted:-::
>  Codec (BIAS) Domain
>  -------------------
> =20
> -The codec bias power domain has no widgets and is handled by the codecs =
DAPM
> +The codec bias power domain has no widgets and is handled by the codec D=
APM
>  event handler. This handler is called when the codec powerstate is chang=
ed wrt
>  to any stream event or by kernel PM events.
> =20
> @@ -236,7 +236,7 @@ a virtual widget - a widget with no control bits e.g.
> =20
>    SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
> =20
> -This can be used to merge to signal paths together in software.
> +This can be used to merge two signal paths together in software.
> =20
>  After all the widgets have been defined, they can then be added to the D=
APM
>  subsystem individually with a call to snd_soc_dapm_new_control().
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--u9U67xacMNIq60tW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9G4QAKCRD2uYlJVVFO
ozTlAQCqr9wXRi7bjRSuhd7WFGsq8P2WUE1gMgbCEJAHpn+thwEAhQXEwJMw20mt
QJIMfJ6+KbBYcjUxEm44cboQu34snAw=
=QOJt
-----END PGP SIGNATURE-----

--u9U67xacMNIq60tW--

