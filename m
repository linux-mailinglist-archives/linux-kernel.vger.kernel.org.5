Return-Path: <linux-kernel+bounces-89772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51086F57C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A42C1F2217A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D05A4E0;
	Sun,  3 Mar 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btkRZBG9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACF31A8F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475168; cv=none; b=YP1Oy8l3sGy8GeOHC0DiIqBjqHEhzdYV1fVHq1j9L5DnhKdjF1R/NfHaybiTX+qKpCLkxfT5j9yB0MDSSjjPYeBEsjgRVaoTKxPpxoUvRglASGS85PJSqniDRMcam/hilO96/aLCWR49uddvsSoEvhS7/Hpl1ktZuIKs2YWmwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475168; c=relaxed/simple;
	bh=NCDrrJlc3tRE6yl7ATLHxCA3vYz9taO9U7grccTrnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSi+QPRd0WOdgwNMabdaR/hb2bnL/P9ME+YLKP5GmwDLEwCsikbhkAKByON8opzKLHeO+yIKbtwzIzWruAuPEnEEi0NAU5PpmUyr929QQsZQWrNrJ15RCN3pkuboMAdt3NhvDnVUD68Lzthu3LNk005zlDo/y2atT6nbx2E/syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btkRZBG9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-299e0271294so2431875a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709475166; x=1710079966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97ZbKR/nkeCOTOB37P+kvgKA8uhgX0z9ipBzLO+afkw=;
        b=btkRZBG9v2sWoYpJ4nT5Nlb972Nop10XcqgVM571+QtpiwGBDUClC2Ny0FlhKrmksx
         w/FoF0sb4+F5YPuhu8pCUwsiSGpq4tPHk8+8BNEqicsV1y4EOA+vs5zhbnOvAMs5m2Es
         zRb2rKfXpbRx/ekWvVsdaSOWiUuhAfydFRDQ1SSsaURFvoEfXnUm6YtDjG2ovFBPvB6/
         FbO7WMyfrb/MpiZt99219SnLTdN0iw0BZjQcu9GLFzqMKei+TG34+u7ejOFgHN5/Z87k
         Nlq2wg6GWYSCTBzpc+sGgXizWfxkEYnqWQhGm56AeuP9mAE0YaS8vkgNc+smOJXNugit
         gEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709475166; x=1710079966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ZbKR/nkeCOTOB37P+kvgKA8uhgX0z9ipBzLO+afkw=;
        b=cc2uvKrggPodbv4V9R+mg9RGlRnapRD67xjdqgRtK4VvbS64zXdUvBJ8Lt5jxkMzEr
         pjzztM/UpSjS2ZeXNjXdWx6XWGGvZFGxd5zy4iQan6KMdKoZ+DLXhT4hdy1je70PUNRR
         kkxZCxwisx6odJaztoFIHfBwfdX/6A/jGSW5LkiiWQEY83qt73jtTgTlFA/ihydPFZYD
         o7YVsdIPsGoyvnnoc/xy9sFsaONGkxl9G9RJmaSxQS3+2ZuOe3wn3j3abCLVRp4dXlRN
         ikdT7MXLpmiAZSiJ75QwGQ5iIAjyKWMTucUjo76M7Y7n0GKih+/XRBVn3erfSFWW2JNF
         43+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtrGhZkIaZvcgLopNCIGdcIA4PDztMpOMkeiLne+Ha3OzPYDcVVP8E0XgZeAtPYstGVejVsX7NP9qlVh8sAOrmDU8zk1Isxv+Nb8ub
X-Gm-Message-State: AOJu0YynEoqPImIb1yLuHXAa5uqOT35DzYVXqFX00EJZaG87G/MJ3yNz
	ga7rYGm9tswPa7KeMiKsDTKUPTJrDRT1PdAnNcsPiBhzhARv4Zhtooj6z0EFf5g=
X-Google-Smtp-Source: AGHT+IFG+wGaEtdkA4OQ9eiWV3WBTHsJ2Jsq86wcnKWy9omE+7oa3Usnduwz4hYZlHm7CS4l9UtJ9g==
X-Received: by 2002:a17:90a:4211:b0:29a:a1cd:da65 with SMTP id o17-20020a17090a421100b0029aa1cdda65mr4517702pjg.43.1709475165878;
        Sun, 03 Mar 2024 06:12:45 -0800 (PST)
Received: from ishi ([2.56.252.75])
        by smtp.gmail.com with ESMTPSA id bf3-20020a17090b0b0300b0029b178a7068sm5231556pjb.50.2024.03.03.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:12:45 -0800 (PST)
Date: Sun, 3 Mar 2024 09:12:39 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed priv field description to prevent kernel doc
 warning
Message-ID: <ZeSFV7T9Rwm2Adal@ishi>
References: <20240303140300.6114-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HiSxRJ/9FIC6peuO"
Content-Disposition: inline
In-Reply-To: <20240303140300.6114-1-prosunofficial@gmail.com>


--HiSxRJ/9FIC6peuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2024 at 07:33:00PM +0530, R SUNDAR wrote:
> ./include/linux/counter.h:400: warning: Excess struct member 'priv' descr=
iption in 'counter_device'
>=20
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> ---
>  include/linux/counter.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 702e9108bbb4..b767b5c821f5 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -359,7 +359,6 @@ struct counter_ops {
>   * @num_counts:		number of Counts specified in @counts
>   * @ext:		optional array of Counter device extensions
>   * @num_ext:		number of Counter device extensions specified in @ext
> - * @priv:		optional private data supplied by driver
>   * @dev:		internal device structure
>   * @chrdev:		internal character device structure
>   * @events_list:	list of current watching Counter events
> --=20
> 2.34.1

Thank you for the patch, but it looks like this was already resolved by
an earlier patch[^1] and in counter-next as commit 0b3bbd8f9baf[^2]. It
should be picked up with the other Counter updates in the next merge
window for the Linux 6.9 cycle.

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20231223050511.13849-1-rdunlap@infradead.=
org/
[^2]: https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git/commi=
t/?h=3Dcounter-next&id=3D0b3bbd8f9baf245ec77d86f6f5bc902105b4bfa9

--HiSxRJ/9FIC6peuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeSFVwAKCRC1SFbKvhIj
K8axAPwPx/2NnRyJz3BUspGwzmgozohYut1T6VGt9yyDNzc5kgD+MoQ0fqaxeXiZ
mb9g91TWYRxgrfvQOCAUjtl4/0v7qgk=
=hOEr
-----END PGP SIGNATURE-----

--HiSxRJ/9FIC6peuO--

