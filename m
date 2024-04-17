Return-Path: <linux-kernel+bounces-147903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10138A7B23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55122282D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2D40847;
	Wed, 17 Apr 2024 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1rlSV1K"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEE4685;
	Wed, 17 Apr 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326077; cv=none; b=kMFpeks2iU8QHncpHUotcQGke77vgnQVLPM+4YzzWJqe7fT1AKFHVL+PRp3Jlu+0rR6ifjMrMM4OwcbDpga/nDVp8bRTutT5pgags7OqnSgi5I8wJg/HKwSF8iLAWs+UMw98A67wY08I1B5VD4wu9/XeG8HF56FzPcuCdPBp9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326077; c=relaxed/simple;
	bh=Hj1DVmeS+1devi66SWbu0PKFIaBA07E02p4XayxF74A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qip+QUBV+TtNAGVbeHwrtvWf60/dcwym+oXBzMtxed3Eudkytk+73islN2DbYXyNsjdGsdNTRX0aQ8/5yrFw6azhN7r7EZkd48qXmN0YEPopO4VWWBYrZQmcY21gfeQGDuAJPKJVr6hYFfRGI/b2e+oEquHt2Q3RC+FlWXkPk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1rlSV1K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3c9300c65so44754855ad.0;
        Tue, 16 Apr 2024 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713326075; x=1713930875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=canPiBclK9DQzkRRiaZJtMYW3uPNav/QfxFCZqrcSHo=;
        b=j1rlSV1K1WJzQFdm2OzCzMRV8CJerGigNXJg+bgDstT/7ERE4GmZpaYs9q1qT7tzsX
         lqaqlPeBLs1Qe4NMkQb5DtNOJPD0KKjR5IG8+HvVLN6naTUeBEIUxa8WRjtqq7momQDQ
         Td0HGPb2jQrjTgiUXGXhO7Cb02Ar+D3lAm8vyKSVK/YhLV4RA4g2iYQ54cYrtG2wZ4od
         Evb6dD0IbvDahHTuBgUlHN6GHBtmcsM9VDivu3buJ2wsD2oyaC/tfxB4m0/6tPq0r8GQ
         hkOmTuHiKC/qTt8MxLc7ILDI2K8go0NsSv3E/F/UjnvFDeIMfodm7Sh3N+lfrcoI1GUX
         NmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326075; x=1713930875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=canPiBclK9DQzkRRiaZJtMYW3uPNav/QfxFCZqrcSHo=;
        b=XYlJQ45pYafzJQ19aPdPzEzlffyqj8hIlSl0Bewa1vf+OdSiBIokJ44xwi4NudO9W+
         Cdwy+UfY7UwtBu4edQkkkOpRPMxmWtCorCRNcdBVYkqglkKnQYpPRspce7WxNXzLn7TQ
         s95zMS6r+iApLZGjAgoHMh97gMGDBEwckoFSY2xAgyYUV1svdmw4kMU+xpRfKk7xg2ik
         3hBIrYUb/p2JihiTm+5fKiZUrms27gthchjf2kjMU/vFgWCmdGU55WJBLfzvRtYzWH9M
         NdFBhCMc1xxWxEBuOxCXTu0+CQ5YLSgXTuGd+ocmcFV3bKJLtvSdrT5ZObE3F6cupfse
         iPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWNtRY0R2XKL9ab5hFl/wEvrkacETdK1CQiVZFBTBZYHtjEQxpSzBS3WyNRYfG89c4MCWIrYU803VvuvWVyc27bwzbUzWJM4/0yjyL/vZh0/Zwfmzh8TseDdiBQGJRc7ATjky5IZ/Mlq1L0yoBGRVU55GvXWOdroe1FQ1Lwh5z9GSYVn6o=
X-Gm-Message-State: AOJu0Yx0n87JDPQCeOfg1zvYojKQdHDaSshPDWJEnNPXRpL/myo5bKm9
	BtxlB+ktKGA3EMDBa6S/4TBaTKtd1S7gUAGzHMBpqKHCjHouqWIt
X-Google-Smtp-Source: AGHT+IHiNzZMzyM0UZhEohXcx8YVHTOMUQQkjdLI64k1HiPd0FZBmA8fgdV0CPShE250xr6eeWYz9A==
X-Received: by 2002:a17:902:c40a:b0:1e4:8c64:33c6 with SMTP id k10-20020a170902c40a00b001e48c6433c6mr17093073plk.59.1713326075219;
        Tue, 16 Apr 2024 20:54:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b001e79072ee58sm3906188plh.62.2024.04.16.20.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:54:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 58CC41860FA40; Wed, 17 Apr 2024 10:54:31 +0700 (WIB)
Date: Wed, 17 Apr 2024 10:54:31 +0700
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
Subject: Re: [PATCH 03/12] ASoC: doc: dapm: minor rewording
Message-ID: <Zh9H92HxGX18fHnA@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-3-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aUQs2ZZBvNtkctwI"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-3-a818d2819bf6@bootlin.com>


--aUQs2ZZBvNtkctwI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:09AM +0200, Luca Ceresoli wrote:
> diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/d=
apm.rst
> index 68ef79f539f2..4dfa60519a76 100644
> --- a/Documentation/sound/soc/dapm.rst
> +++ b/Documentation/sound/soc/dapm.rst
> @@ -5,10 +5,10 @@ Dynamic Audio Power Management for Portable Devices
>  Description
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Dynamic Audio Power Management (DAPM) is designed to allow portable
> -Linux devices to use the minimum amount of power within the audio
> -subsystem at all times. It is independent of other kernel PM and as
> -such, can easily co-exist with the other PM systems.
> +Dynamic Audio Power Management (DAPM) is designed to allow portable Linux
> +devices to use the minimum amount of power within the audio subsystem at
> +all times. It is independent of other kernel power management frameworks
> +and, as such, can easily co-exist with them.
> =20
>  DAPM is also completely transparent to all user space applications as
>  all power switching is done within the ASoC core. No code changes or
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--aUQs2ZZBvNtkctwI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9H9wAKCRD2uYlJVVFO
o+u5AP91G73xcF179oigFyplpIzfoirhB3QJ+Qu6JJN4s07a+QD/Rc1p0GPcQy0s
q+7TtBt2v9R9UikapGLtUIMSpthUVwk=
=NKeJ
-----END PGP SIGNATURE-----

--aUQs2ZZBvNtkctwI--

