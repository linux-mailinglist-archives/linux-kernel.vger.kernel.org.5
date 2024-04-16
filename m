Return-Path: <linux-kernel+bounces-146750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C08A6A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8A02828CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDD12A17F;
	Tue, 16 Apr 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiqY2Qgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3B8664A;
	Tue, 16 Apr 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269338; cv=none; b=XcmIbU6K+gggNZZp1SG7m2tSSztcLEyZoknDacfF+lxEE2uQ4y1YUVsvmUQoe8mjJoyZ4kwTBDZVwsGJzN0NxTY6vOcvIS1hudA5cBE5aXasPXidj5O8LBUYm+Z3rdXqg2PGrAa1+l+G/9S6E4YZTd1ZDA+Mkk96029+2NxWRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269338; c=relaxed/simple;
	bh=DQUVUBmWOEYMRx80TTv3GDn8+m96ebnHtitk5QfgZ9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miewY8IlG0m50VAkB26mOIBUga5pUDPkDbS3RPc7zCHnAuZoZHUO/aS6OpGy0UqlveoDYOvHPr989PuByoEeKTOLx46Ck4lPTOwA1LocZrw2z6xcloMsgJSTOYCfbiGN+NozhTFearA+02oaO99blqu2JjegQDT6nh1TpjGaIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiqY2Qgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779EC32783;
	Tue, 16 Apr 2024 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269338;
	bh=DQUVUBmWOEYMRx80TTv3GDn8+m96ebnHtitk5QfgZ9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JiqY2QgkrMrXDRbJsUeKiCh7Ev/3BRywKZ6QyxborsGmGhGczjEVrGQD0eCqRuH1n
	 zdNRKrX/bV45HtqEcMHqeuubPcuFBcXklLKymLdjqkKwcjCVDyrRkE2XR9cU7GC0AU
	 9nEs48kSaZ0Q4LDo7CsyCDrTxCQwoiGHhBO3/H/OaIT77jg9PRN5xQzmYuuqovb0/C
	 lI0Dy6s70ZVMtZuwlvsaWv1KCX/mvkdsWX+NLl+VBvLgFMytJnxTs30IuW4s/JCRb7
	 Y2QzGx1nTPW1Po5fhxJnVcy1lqeK4Y7US+f+mwsSM/ytZR/iScqy8BBXVcbfr4RtyP
	 1FHnHv39md+3A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so53395931fa.2;
        Tue, 16 Apr 2024 05:08:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyi8LyG3RDqIm7clh9DmpvLAM8tAeoe+B8gA8cu8jiJLBAKbIaKmUuQdMEUCVPI5jW/LQ2ZW3zLhGAMP/s3jAohme1expXg3bnt/YX
X-Gm-Message-State: AOJu0Ywj9YlekvpR5F/CVZMorf3RBf8fnOqkLw/MG7a2NEb63O+WS4N8
	+m3MrNKtVOFRByiEAjFAh5tDHTnsy65yZEzvA+DNkQsGzrB00HuTRjG9GBlF83QabzVS92FVd3g
	LDSHQiJOqGhvfKPMvjwJvP74E1Ow=
X-Google-Smtp-Source: AGHT+IECgrzVB1Oesmtr0uOyzJGEA1d3yyMP9Je5d5+wXjHwa4RyVl3/Ri8WjRool3QdctkZUBGL5Y8UgsKW+YiLZck=
X-Received: by 2002:a2e:a696:0:b0:2d8:c151:80ec with SMTP id
 q22-20020a2ea696000000b002d8c15180ecmr6687994lje.52.1713269335719; Tue, 16
 Apr 2024 05:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408071758.2526806-1-arnd@kernel.org>
In-Reply-To: <20240408071758.2526806-1-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Apr 2024 21:08:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRYJzOVP8eDhLHoqrcm165ztc4cwazu+tquqSzeGGUkg@mail.gmail.com>
Message-ID: <CAK7LNARRYJzOVP8eDhLHoqrcm165ztc4cwazu+tquqSzeGGUkg@mail.gmail.com>
Subject: Re: [PATCH] [v2] scripts/unifdef: avoid constexpr keyword
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Tony Finch <dot@dotat.at>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:18=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Starting with c23, 'constexpr' is a keyword in C like in C++ and cannot
> be used as an identifier:
>
> scripts/unifdef.c:206:25: error: 'constexpr' can only be used in variable=
 declarations
>   206 | static bool             constexpr;              /* constant #if e=
xpression */
>       |                         ^
> scripts/unifdef.c:880:13: error: expected identifier or '('
>   880 |                 constexpr =3D false;
>       |                           ^
>
> Rename this instance to allow changing to C23 at some point in the future=
.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Reviewed-By: Tony Finch <dot@dotat.at>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  v2: include fixup from Tony


Applied to linux-kbuild. Thanks.


> ---
>  scripts/unifdef.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/unifdef.c b/scripts/unifdef.c
> index db00e3e30a59..ff15efd6e7d7 100644
> --- a/scripts/unifdef.c
> +++ b/scripts/unifdef.c
> @@ -203,7 +203,7 @@ static int              depth;                      /=
* current #if nesting */
>  static int              delcount;              /* count of deleted lines=
 */
>  static unsigned         blankcount;            /* count of blank lines *=
/
>  static unsigned         blankmax;              /* maximum recent blankco=
unt */
> -static bool             constexpr;             /* constant #if expressio=
n */
> +static bool             constexpression;       /* constant #if expressio=
n */
>  static bool             zerosyms =3D true;       /* to format symdepth o=
utput */
>  static bool             firstsym;              /* ditto */
>
> @@ -819,7 +819,7 @@ static const struct ops {
>  /*
>   * Function for evaluating the innermost parts of expressions,
>   * viz. !expr (expr) number defined(symbol) symbol
> - * We reset the constexpr flag in the last two cases.
> + * We reset the constexpression flag in the last two cases.
>   */
>  static Linetype
>  eval_unary(const struct ops *ops, int *valp, const char **cpp)
> @@ -877,7 +877,7 @@ eval_unary(const struct ops *ops, int *valp, const ch=
ar **cpp)
>                 cp =3D skipcomment(cp);
>                 if (defparen && *cp++ !=3D ')')
>                         return (LT_ERROR);
> -               constexpr =3D false;
> +               constexpression =3D false;
>         } else if (!endsym(*cp)) {
>                 debug("eval%d symbol", ops - eval_ops);
>                 sym =3D findsym(cp);
> @@ -895,7 +895,7 @@ eval_unary(const struct ops *ops, int *valp, const ch=
ar **cpp)
>                         lt =3D *valp ? LT_TRUE : LT_FALSE;
>                         cp =3D skipargs(cp);
>                 }
> -               constexpr =3D false;
> +               constexpression =3D false;
>         } else {
>                 debug("eval%d bad expr", ops - eval_ops);
>                 return (LT_ERROR);
> @@ -955,10 +955,10 @@ ifeval(const char **cpp)
>         int val =3D 0;
>
>         debug("eval %s", *cpp);
> -       constexpr =3D killconsts ? false : true;
> +       constexpression =3D killconsts ? false : true;
>         ret =3D eval_table(eval_ops, &val, cpp);
>         debug("eval =3D %d", val);
> -       return (constexpr ? LT_IF : ret =3D=3D LT_ERROR ? LT_IF : ret);
> +       return (constexpression ? LT_IF : ret =3D=3D LT_ERROR ? LT_IF : r=
et);
>  }
>
>  /*
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

