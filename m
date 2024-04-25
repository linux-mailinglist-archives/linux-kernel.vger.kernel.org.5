Return-Path: <linux-kernel+bounces-158813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36B8B2532
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D6A283E66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0C14B088;
	Thu, 25 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diKqYFuM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF114B089;
	Thu, 25 Apr 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059351; cv=none; b=nKbo0/SGrY7xLQceMkvH+w7DWyxS0PD9rHTCKuPQyMrOOQ8QkVIFpta8wyToVN1vL2OSTQzTPTZS3PFIRPbkg/FSJ9LtXJ161ZJsx0EgSkcl+2x3lNXLLch3CwU3B+kU3EWclFsJr0T8AkLaDMRxOwMVIU0mIiuZY+OfANvrTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059351; c=relaxed/simple;
	bh=07GVtflPLexEXhrkAckXUsbUizZLt8azEHrY6p7cuuY=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iESU9lt2HBfH/Cq1n04TL6giMKGGcQYKnTT+15GFmsnn0y/R6xaHUPcI+h5bzKCQd0IK1nfJ7HvDinStqlRSP3ayjtJZ7jCS8JpdRJiGtHhyjvPrnCjGQekUoOTtsXoHtgZ0ztqCQxAeGViRIgpFXHjAG9rR3LzkQpWXf7tH8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diKqYFuM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5194cebd6caso1288685e87.0;
        Thu, 25 Apr 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059348; x=1714664148; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZnqzL7HjOluCQJ9FxDBIu8w6EzJgvkkZbKbDc0WHmA=;
        b=diKqYFuMPtu6uDjiIn3hw7ZcgzutAJWqNniXz+OTZ0/nWgVjHs0owB8GuOBsk4jCpI
         PTD26pbNCPUVup4z0R2uK5yPuGYvGF8+k1+4KqEKMXfknjkUurbThP3g9a7k8RZ6sy29
         tgeJdnVrxQbXA8WxD7cVqc39Fcp4WZzzj34w8ZTadn0fn+6Zw6yG31l4GwM4lDvpcREc
         mSkZUidM6/xuPWE8kZPaCFwB3uKVpkE85+j/ddQKDhY3CdVxsrohWtsfQN5HOleQPGpL
         Hpr6KKmnRIXHjLd3Rzh9K8boC2Y7Ve6qO+gVrosnPK0vEWS4ZxTIhPOcImP6H3Qx2baL
         fKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059348; x=1714664148;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZnqzL7HjOluCQJ9FxDBIu8w6EzJgvkkZbKbDc0WHmA=;
        b=kmlWbz51/FZ7HkBwT42jiK7MUn1NzmuN8NJvcvhDZXOM3m3S34P6g+5f5R4iAMX6sw
         Mo0sFaWYMxX0+b2X1jxoIcqdcPHARm4ohlrtwiN+qeYADN0wK5/sMhdKMJ3WwFdyDxrN
         8t7lcAQsgfUIz0hqUb2dgL+iWLj6VtJbE2fSHkb1Wi2SEGqNvduNd3zi5CSaJHFPN/Lk
         0xX+eUJv6NQfQCz85lGlDCQLZw2JLm+L3I99uMrsGqcEjvj3qa5b5Dl03zPjn2VbmAXU
         qSboenw/BOXiR4xPi3Jf/21oL+CkiLf5krrdB15EYVQptvCrhYJsOCGu19wVPMpg9xxg
         OfzA==
X-Forwarded-Encrypted: i=1; AJvYcCVSRVpAy94x6RTlna7HH/KphQ/nvdzKRx/AeUvI8rJY5RwZEW2ijNJBUBHTGFWelgKuSKFmA41bsvPncbhMt9VqDPoUMVaHAU+RfbxAN/+O4dR611x13+xDmIzLqBLIzpQRJV2IAIhLMls=
X-Gm-Message-State: AOJu0Yx498caictK4SyGElCJzUgwKlfLkPy/K+mf/mY4/y/LEX2Y4baf
	aa0gGdo+lHJ5Mzay+nTSPs37EakTwNEcw+/Ymyz89rfqW+kdzqwR
X-Google-Smtp-Source: AGHT+IFuCEsHzQvzbD8XVPvlH6IqpOoftCmj0Vr0zcapZZToJyz7ddZlrzfNFYWacqsjZ6NrgxbFAQ==
X-Received: by 2002:a19:ac08:0:b0:515:a6dd:9657 with SMTP id g8-20020a19ac08000000b00515a6dd9657mr4075058lfc.16.1714059347473;
        Thu, 25 Apr 2024 08:35:47 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d15-20020adffbcf000000b0034b1bd76d30sm10361271wrs.28.2024.04.25.08.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:35:47 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=914da399af0607f643709bc2fc1a510fd796868e26554216cfbbe1ea8aa2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Apr 2024 17:35:46 +0200
Message-Id: <D0TBBT7FZ3E0.14ZFOT5S4QZPR@gmail.com>
To: "Miguel Miranda" <mmikernel@gmail.com>, <jonathanh@nvidia.com>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <skhan@linuxfoundation.org>, <javier.carrasco.cruz@gmail.com>,
 <julia.lawall@inria.fr>
Subject: Re: [PATCH] drivers/soc/tegra: Replace dev_node refcount management
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240424015306.1796838-1-mmikernel@gmail.com>
In-Reply-To: <20240424015306.1796838-1-mmikernel@gmail.com>

--914da399af0607f643709bc2fc1a510fd796868e26554216cfbbe1ea8aa2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 24, 2024 at 3:53 AM CEST, Miguel Miranda wrote:
> Remove the manual refcount management of device_node
> and instead, use scope-based resource management.
>
> While the pointer never gets out of scope it reduces
> somehow the risk of missing the of_node_put() call.

I don't understand what you're trying to say here.

> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Miguel Miranda <mmikernel@gmail.com>
> ---
> I only have a deprecated jetson nano dev-kit, but need
> to test this on hardware. I am exploring options to
> build a rootfs to test this using qemu-system-aarch64.

It doesn't look like it'll be necessary to extensively test this. Just
by inspecting this we can see that it doesn't change behaviour. There
isn't really a big advantage to employ the __free() mechanism here since
we have exactly one of_node_put() to clean up, but I guess why not. So
maybe reword that commit message to be less confusing.

Thierry

> ---
>  drivers/soc/tegra/common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index dff6d5ef4e46..94d11102d90f 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -28,14 +28,12 @@ static const struct of_device_id tegra_machine_match[=
] =3D {
>  bool soc_is_tegra(void)
>  {
>  	const struct of_device_id *match;
> -	struct device_node *root;
> +	struct device_node *root __free(device_node) =3D of_find_node_by_path("=
/");
> =20
> -	root =3D of_find_node_by_path("/");
>  	if (!root)
>  		return false;
> =20
>  	match =3D of_match_node(tegra_machine_match, root);
> -	of_node_put(root);
> =20
>  	return match !=3D NULL;
>  }


--914da399af0607f643709bc2fc1a510fd796868e26554216cfbbe1ea8aa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYqeFIACgkQ3SOs138+
s6H5zQ/9EMK+VQev1WAylRx3Sw+siqhIpJzdjWxcth+ARRVneIbGasJY05wGnXK/
DcQAbz5jtlTxh55f5VfwqpmU1KCmnnhmI8k1M5pgFUVgBzXhotHuGtSOs7efo0H/
2NmQirCL+fYZhhEhwWGbXVQ24zTISAeWPKIk6W9nOihc/3nyz1/MMLwMNL8XWbSX
tavXXFvNx4u86RF7RBDmFO0uK1AOutz21TfOzpCieTliS/O67O3Utgko3/Lgr6ze
2HuCQN6ex+wHguYlYWYccFGhyb94O/w8krQWrU6q9KlLkf5vtRQtJDaFHlHy8/vM
fzD+JCNWg2eyuIZl7PdxcDkBZCC9k6hjGucJ96VzCo+Y4Rhi+NLo1lQodGAuwc/P
xh9H9cs8vC3wk09i9zzecRIeIUZTJbFO+H96R4HWbLnwL/IFxfWA3Y2y42ma5RtU
9x3A6TO6NEVZsWs6VPF0qSaEydWbk+PRxMXYEmvCEAghbLh3F7zGIASkNJm8vfv+
5b3eW+G9SaQAJzEZ56jRDiBF6ckEYq0aSuLGaPOhPizS2uH04bFpxbJnaYb3Qe4U
MPjoqA8f3FVIn5fxsVMTRgdSL5zF87KaRZDpAipumrlVjnHzyqiryVrlr35XZ3vt
F6mYy5jTrUqJHNr+ymUx9R+V4VI+U8cithp4pEwK1QulCm9m/co=
=Qpbs
-----END PGP SIGNATURE-----

--914da399af0607f643709bc2fc1a510fd796868e26554216cfbbe1ea8aa2--

