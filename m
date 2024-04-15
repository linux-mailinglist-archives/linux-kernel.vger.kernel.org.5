Return-Path: <linux-kernel+bounces-144914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D97B8A4C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590471C210CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0CB5B666;
	Mon, 15 Apr 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLql3mnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCF4EB20;
	Mon, 15 Apr 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177185; cv=none; b=mxElo/hYXccoISl7y6HV/DOmdJkgtHcI4KYWlKoku6/060nMq2x4Gnl7SzO6YkAuwE6IJStJ2yo6QA9Haa/H4Qd56iI0mIsz5wbrCArbf6bTS1fyniA3kokFBy40dLsHQliCr6YexKqpytJpi7AttXcXOZLSRQxJr5BkUQIGOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177185; c=relaxed/simple;
	bh=XW/Ia1u/3MDd6pzWmjlOQCD4x4iG3aFM/KtrJwYeQZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT56NBSmwW+rzYJoGu/mgn+GUrlOy02J1O4DblKR/zBsN2auyytfj7JWuT+anF+ECFwITW6B6qPj3o8ne0E3DCsSPadNPk5HtQpD23QCXurS1PKqJ/uA4xgYPg33Vzf7DHauwJRsak2hGPiH57FsIisps7JEO8lhcU0cNQw0uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLql3mnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F646C113CC;
	Mon, 15 Apr 2024 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713177185;
	bh=XW/Ia1u/3MDd6pzWmjlOQCD4x4iG3aFM/KtrJwYeQZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nLql3mnwAM0W+FmQ1NlgqzGIRlfmRi+2VWlT/GcNdq91Y2N28CxzcSnaxyfNaqO+z
	 faWvCajTWAd4th7d7GJRV5pDWG7H6Y3yWF/66TvqBJkR/KKv2sj3CbRz9Hh21d4en9
	 fEm4B+ZaTgwhUOD2OKWHdvayHfoolEF7eCUnndYHdE7fMMzuzg1jaqn1ikUdC30Wwq
	 68IMeuep7/ONiOI7GjW/PuKFD3vhm53Xouxwh9IZ9g2mdcQwq31VIfO/+ffNBEY2xa
	 KSZvd6eHPIPY8vccFGxLsr8w61Xx1674Gecm9v2djzjp08Y6jcHL9InTna1chJ/fkk
	 rQeGvgFrwfntg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895138ce6so35514071fa.0;
        Mon, 15 Apr 2024 03:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt/9d1JswxzctK3JFfcNOO9hY9oaivxnjCEmWL0C41mRVWDQ+XZAYHuhualMYpAwk6nQDVype4ShGjI5mc0+F8jF3lopP/O5O8tYiD5ReRJKkPxZthBKH4BBL1zkSJ7xNGrjr9zwAfc9n5
X-Gm-Message-State: AOJu0Yz5/37LUC5E16Yl2dYGduyVxcGcMW4a+sVDRFAzu4ZpLzXOaBc+
	kX6lvXT751Ea/PtsMnXHjymIyy9yJ19EW/Wt/0IqsrfnfzkWQ/HyQDGq5233Xf9qr0e5XqcTfKG
	Qjgk//JS0vJSlS1tCfvfoqKn9pqs=
X-Google-Smtp-Source: AGHT+IFd3P+rYqmJz+E++PdQUKllUqGh0DRXtaNZjHHPq96DmQhZyYk6LpnwtzbcVJpR1py2cdjwe6YfZoztey5gH+I=
X-Received: by 2002:a2e:3c15:0:b0:2d4:6f33:2e59 with SMTP id
 j21-20020a2e3c15000000b002d46f332e59mr6272412lja.30.1713177183753; Mon, 15
 Apr 2024 03:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415101345.3807776-1-vchernou@cisco.com>
In-Reply-To: <20240415101345.3807776-1-vchernou@cisco.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 15 Apr 2024 19:32:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3VJN5Ga1aJnrpaPoPaKMCZR3dauo-SWaH9=y9zv1F5w@mail.gmail.com>
Message-ID: <CAK7LNAQ3VJN5Ga1aJnrpaPoPaKMCZR3dauo-SWaH9=y9zv1F5w@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.build: fix ext mod subdirs build with
 separate src,build dirs
To: Valerii Chernous <vchernou@cisco.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, xe-linux-external@cisco.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Valerii Chernous <vchernou@cisco.co=
m> wrote:
>
> The change allow to build external modules with nested makefiles.
> Current unofficial way(using "src" variable) allow to build
> external(out of tree) kernel module with separating source and build
> artifacts dirs but with nested makefiles it doesn't work properly.
> Build system trap to recursion inside makefiles, articafts output dir
> path grow with each iteration until exceed max path len and build failed
> This fix update "src" var during processing subdirs and resolve
> recursion issue
> Usage example:
> make -C KERNEL_SOURCE_TREE M=3DBUILD_OUT_DIR src=3DEXT_MOD_SRC_DIR module=
s
>
> Cc: Valerii Chernous <vchernou@cisco.com>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Valerii Chernous <vchernou@cisco.com>


NACK.

Please do not send hacks over again.










> ---
>  scripts/Makefile.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a293950e2e07..75ea9052ea4a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -490,6 +490,7 @@ $(single-subdir-goals): $(single-subdirs)
>  PHONY +=3D $(subdir-ym)
>  $(subdir-ym):
>         $(Q)$(MAKE) $(build)=3D$@ \
> +       $(if $(findstring command line,$(origin src)),src=3D$(patsubst $(=
obj)/%,$(src)/%,$@)) \
>         need-builtin=3D$(if $(filter $@/built-in.a, $(subdir-builtin)),1)=
 \
>         need-modorder=3D$(if $(filter $@/modules.order, $(subdir-modorder=
)),1) \
>         $(filter $@/%, $(single-subdir-goals))
> --
> 2.35.6
>


--=20
Best Regards
Masahiro Yamada

