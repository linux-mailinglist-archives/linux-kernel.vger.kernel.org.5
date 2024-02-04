Return-Path: <linux-kernel+bounces-51670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85361848E1B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63AB1C22852
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4FC224F9;
	Sun,  4 Feb 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2RAMHM3"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1823224D8;
	Sun,  4 Feb 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053937; cv=none; b=r/zm4DPGQlIPJohmVIK9aNztbk1cZcgEYgEICpNbAhGchL6yO5T3dMQdQnZcEHfXPRWU9ghQwr1miCGJr5ghGruB0VtM/NuL5xLvph75vy8WFpKfVVdYLndhp4ZtquakEToADLkRLUQVVnSjBbRnVvoDyknpVsOBOFoXZr2cpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053937; c=relaxed/simple;
	bh=R7yUDFylbArJCDYp4CVW4mOktiFo/ofzfOeyBZlCa+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0QWBw+AVoKoXP3Xedf4U09Zw+cJaqyP4yV4QXdQyay5wEpJ5lymsJ7qsxmHlfendmP1q5b0hFP+HNyrki/N76MSQRKzfpGKnuiu3hCEoscXeDDe9pWYniZzdbSQ1KZl2mKmJd4O9qeGuyPw98+LxNFX/JU89rTxfL8rZN1+Txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2RAMHM3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290fb65531eso2563636a91.2;
        Sun, 04 Feb 2024 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707053935; x=1707658735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALUPxq4ZJwbinmtiV3F8u9Svkc57KnxMA5fpTX6Vc6M=;
        b=X2RAMHM3M39Z5h/SS5HLJzxMcAs9KZ42Bpb9oYUWInaaLB70lq/NdPrxg/3Cf/GKs2
         xNOXLFH7fHOwLuThfKY8qFOpE8GcoFJ16SwxdDS6WhuaEH/Eb7kVALUg5UdnsdvLUqgx
         QSR40O9iUtXTUTkgEcBSweWBxBBYBeqy1nYB6joGsp4uWgr1QCWbGar9VgmLYczN1WNz
         ltEXknepLMXa5MPCvgtoYuOAab0QvxeRXKfKtazBsmiCAWDsGn3P1HPF+Ye3qwQPHM84
         hNWJtuZQ/BmqcbrgI3RvgZR093QTeL644eHIrPPXwV9Vgawls8I7+a7hva63cBFeO6cx
         Lo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053935; x=1707658735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALUPxq4ZJwbinmtiV3F8u9Svkc57KnxMA5fpTX6Vc6M=;
        b=jYj7A+k1uAG641ugqO7p0Gtc+ytVuOx+jDJtdh+UIVMnbcnkg4j4PBePYua+ShREl7
         gLt6EZDtScqWsbk6ou8zQ9N/4T6nBZ+3MjH14QOAI6mPQJdCaSH4c6ZraYHSwNl5JmyQ
         /s8dIybo8g5yt2RBUtXU1gsU8wR+vlXcAcB01EpYUls6su8xfTSKsScItPoiACnzlgqM
         6olHR6qAq1FfLkxB/5jccf2Om+QrTXFfyYZq4/Dgj7sqST0O0UEjBYZ2FCKz3AYWyQvZ
         zbYiyYAhujNVX6DSXIASmj9BrURWAOCs03l/QdltamiMDmmb4S2eYyToOrCflOIYW9bA
         Y/Iw==
X-Gm-Message-State: AOJu0Yz9k9Ii99KapWkwl+sTFZahdRCFxbV+3f/oM3T793q5wrY+Uy/o
	NLo4ZNMtLq/ESFfVasMni6UDp40goOI/NaNQdSgGnbj6vP7mj/pb3e0MrOEdwg8=
X-Google-Smtp-Source: AGHT+IFFenJTOl9GPleKl+k6ZhdLSl/yilXgpk/4IfAXyQlTtQ1cBKqjWQu+V5uYJt1EkTU7tfnSUw==
X-Received: by 2002:a17:90a:9385:b0:295:b591:26ed with SMTP id q5-20020a17090a938500b00295b59126edmr9067946pjo.15.1707053934929;
        Sun, 04 Feb 2024 05:38:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1JvOrrQ2zoTN5g69IgS3E+rQ72QnmGd9dIVB0bl4ottDgriueLy3Qyxwtib9Uh57MtydMAbxqmJ6VHzyl8306GQlxgecFI5C57n1nZ6pD0dIns8sZZMSuuK9x3AqRKcY/amWrtmwSy7FgmdB2TbV6smbPtdfijw==
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090330cd00b001d961ebf31bsm4615577plc.82.2024.02.04.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:38:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DDC72184DAE06; Sun,  4 Feb 2024 20:38:49 +0700 (WIB)
Date: Sun, 4 Feb 2024 20:38:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: multiple .rst files: Fix grammar and more
 consistent formatting
Message-ID: <Zb-TaQYEVE29duCT@archie.me>
References: <20240203215345.4396-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ClGYZWwBz0LpnQpN"
Content-Disposition: inline
In-Reply-To: <20240203215345.4396-1-thorsten.blum@toblux.com>


--ClGYZWwBz0LpnQpN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 10:53:45PM +0100, Thorsten Blum wrote:
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide=
/sphinx.rst
> index 3d125fb4139d..2526811489bf 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -63,8 +63,7 @@ Image output
>  ------------
> =20
>  The kernel documentation build system contains an extension that
> -handles images on both GraphViz and SVG formats (see
> -:ref:`sphinx_kfigure`).
> +handles images on both GraphViz and SVG formats (see :ref:`sphinx_kfigur=
e`).
> =20
>  For it to work, you need to install both GraphViz and ImageMagick
>  packages. If those packages are not installed, the build system will
> @@ -108,7 +107,7 @@ further info.
>  Checking for Sphinx dependencies
>  --------------------------------
> =20
> -There's a script that automatically check for Sphinx dependencies. If it=
 can
> +There's a script that automatically checks for Sphinx dependencies. If i=
t can
>  recognize your distribution, it will also give a hint about the install
>  command line options for your distro::
> =20
> @@ -283,7 +282,7 @@ Here are some specific guidelines for the kernel docu=
mentation:
>    from highlighting. For a short snippet of code embedded in the text, u=
se \`\`.
> =20
> =20
> -the C domain
> +The C domain
>  ------------
> =20
>  The **Sphinx C Domain** (name c) is suited for documentation of C API. E=
=2Eg. a
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index 50b3d1cb1115..4c1552160321 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -144,8 +144,8 @@ Bison
>  Since Linux 4.16, the build system generates parsers
>  during build.  This requires bison 2.0 or later.
> =20
> -pahole:
> --------
> +pahole
> +------
> =20
>  Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from =
kernel
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howt=
o.rst
> index 6c73889c98fc..eebda4910a88 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -351,8 +351,8 @@ Managing bug reports
>  --------------------
> =20
>  One of the best ways to put into practice your hacking skills is by fixi=
ng
> -bugs reported by other people. Not only you will help to make the kernel
> -more stable, but you'll also learn to fix real world problems and you wi=
ll
> +bugs reported by other people. Not only will you help to make the kernel
> +more stable, but you'll also learn to fix real-world problems and you wi=
ll
>  improve your skills, and other developers will be aware of your presence.
>  Fixing bugs is one of the best ways to get merits among other developers,
>  because not many people like wasting time fixing other people's bugs.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ClGYZWwBz0LpnQpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZb+TZAAKCRD2uYlJVVFO
o6LXAP9LER+inJkvJyemzh7msDV+3YcY/N8k8g0xva5rXFx9yAEAgNatOyWui6/R
+rGd8qwq9Ttely+TiOmq9W2oGAzapQE=
=OGPV
-----END PGP SIGNATURE-----

--ClGYZWwBz0LpnQpN--

