Return-Path: <linux-kernel+bounces-145362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879E28A540C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1505AB23615
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE378C74;
	Mon, 15 Apr 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b51JChLb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660B78676
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191434; cv=none; b=tVyL4uHNMyQdJAXvYKLh/KpEwCE4OcN/8SzjDgs7Z/BLsllXZKIpZ92OY1g1UVMMA+t90AnvVu2D5oYikHITDobcWQOZMxhEXqR0JOHU9YMUNhGrRrDE5zsYAEECc3gD/ABAULz+idBWItPzzhWqrWmgrHXbTJMqALY4yIHmKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191434; c=relaxed/simple;
	bh=w0eyMKWTZscv6UqDhMkbwu1ZzxZ2alXxQgYF7I9Bdck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4rI293/o49lD8Yy8hkwLMYJvKA9DN9sM4RGclQWxlPYM9SBlRFr0jVrm9qTnAHsnFqN1eKvNUNTR6I3lltbEKz813IFz9jgumgB3HcMEeY4b0TaXrnwa0w0Sp+wCkitRT7nJLz6/8UiElOAIVx/Tk1Sa35WLScZ9ElDMc870RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b51JChLb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed054f282aso2231637b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191432; x=1713796232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxkgnUs+kBMGiJuwP3wApGOJHNIKCPg1iHNxfXmCeQ8=;
        b=b51JChLblAplOCpHPCa8aFKsxcMYksSLpP3NNgs+5FofdUnoS69edN68R6nX5FTGX2
         SARdyjpMBxPSWbK9VXixmZL+U3DSlJcsrMX5/mPvWGGNSxu23uR+cSQiyXcClx7nNXFh
         //OQ9SoTyMlwzYSj/DCAPR46zFBdHZHXZQpef6gRfGGQbe33khHRghODpjc3cBGWshtu
         AJ8pBemlkcPBxrN+YShrnSExk5NA8VWrimGyNqR2TaVXevi6ujfiaLdNFV+hPQCwYnct
         WeOv+MZ5+9e0fX+Wl4cfJq40nZFPPcRRIy1xqWKLaiUbGliubm1u98lPJBtACy5acV7C
         pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191432; x=1713796232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxkgnUs+kBMGiJuwP3wApGOJHNIKCPg1iHNxfXmCeQ8=;
        b=bGg0ajgEA9YuK5ms63BaSHitJV8zyIq+7c2gitd6alIObljIEqReW58yxZNpKHKox0
         cd69eEcrzfLuaiwE+DUzx1tISaIa8hqhSvszPHVWALXTMMG0LATXap+TI+U4eiT0brO0
         PrCifmwPTuhPf/6zOWzKT3aK5sgzWzlHF4rTsshdZkSVVB/te0mqkav4hZTUHUk3i5AU
         kNWWJYPO6T97g7dkYpn+ydlktKWdUXBbzdwpkDZOKmbs/BZ8mgmWvXSKkqUexqO2xfLN
         tb5Qwk3vygh7V3BjPUcH9jeHk8ehdN/1JbDJuxEm/wGh/LjW7nw2AqGOe4FBO6OpY/JJ
         4iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVM+jkD8soW6bKMcHpqFLS4sYRwh68K+22Pnvin+rOlHoPbAiTMm38UMbM8qJ6bWh8vi1WCLApZT7HcRcL+lIaPWwqAR+vKI6bFtJN
X-Gm-Message-State: AOJu0YykP7o85SNQdg8olf/WVr1cfRbxFaF5S8xXxXd3vpzRc44m0Vz9
	IcqKxVN8KNFBp3cL9ZMCdHC3S2IdZe4unQ8fgX1ZkS8XJp0Tywpg
X-Google-Smtp-Source: AGHT+IEqcAqUqtYh/KP0MdkXTBsdUaAq3tHbRzSrrLSYR8NONpFCq0LMvNa0Lrr1mOr33eSJRtzz6g==
X-Received: by 2002:a05:6a00:22c2:b0:6ed:def7:6acb with SMTP id f2-20020a056a0022c200b006eddef76acbmr11091850pfj.14.1713191431494;
        Mon, 15 Apr 2024 07:30:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id y21-20020aa78055000000b006ecfc3a5f2dsm7257230pfm.46.2024.04.15.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:30:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B36CA1846908B; Mon, 15 Apr 2024 21:30:26 +0700 (WIB)
Date: Mon, 15 Apr 2024 21:30:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/3] drm: drm_blend.c: Add precision in
 drm_rotation_simplify kernel doc
Message-ID: <Zh06AuQ80Zm6LqXw@archie.me>
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
 <20240409-google-drm-doc-v1-1-033d55cc8250@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nd2Ooc566udnyVEp"
Content-Disposition: inline
In-Reply-To: <20240409-google-drm-doc-v1-1-033d55cc8250@bootlin.com>


--Nd2Ooc566udnyVEp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 12:04:05PM +0200, Louis Chauvet wrote:
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 6e74de833466..8d4b317eb9d7 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -321,6 +321,11 @@ EXPORT_SYMBOL(drm_plane_create_rotation_property);
>   * transforms the hardware supports, this function may not
>   * be able to produce a supported transform, so the caller should
>   * check the result afterwards.
> + *
> + * If the rotation is not fully supported, this function will add a rota=
tion of 180
> + * (ROTATE_90 would become ROTATE_270) and add a reflection on X and Y.
> + * The resulting transformation is the same (REFLECT_X | REFLECT_Y | ROT=
ATE_180
> + * is a no-op), but some unsupported flags are removed.
>   */
>  unsigned int drm_rotation_simplify(unsigned int rotation,
>  				   unsigned int supported_rotations)
>=20

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Nd2Ooc566udnyVEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh06AgAKCRD2uYlJVVFO
o0l/AQD4NUxDF1Iqicep1DXiZGPvZhf1jPwez0pMPAHHpKhKxAEAwpEufXVwnGPh
Pn+pnPga4IpjnDY7/8jcKtpeg+/lkwo=
=CuX8
-----END PGP SIGNATURE-----

--Nd2Ooc566udnyVEp--

