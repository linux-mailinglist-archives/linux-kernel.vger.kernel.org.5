Return-Path: <linux-kernel+bounces-152181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256278ABA67
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1801F21B31
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC414AAD;
	Sat, 20 Apr 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLM5Y60e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64896F9DF;
	Sat, 20 Apr 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603445; cv=none; b=LXZrqg1kZUqbFW596QDy1hv7Zvjsxvo0u+M9Z9dyVloCFhyGezDQ9LiSEdSOFoOGBJGbvFO6DHwBN7H1irWyDcHiTsUIz3KbaFdqxngi7Tph7y5ncIXzaeH9WdqwhHBr4Ivz/aXWan9rHaLc6VWLcU0RLgiY1gCXHWdKZVekJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603445; c=relaxed/simple;
	bh=d2Y+idK3Ze2qLNSSS7zzqAxEmlRt9o56eI03/DQs9YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1Xkk1IkhIx4BQzYnoicblEg4HJN+MTDsOcm+LCVpDcRHTncSVFj8F9Y+/Ef0Z0cKPM8uNgy4vnlcNAs55MDhFXDrGoipuE0ls/8IPjP/1e3Ojd/Ys+Bsahzwrjgvb2zyNAXkwbnFFGxX83tEhA/ePZv+NdypjvdNVd9aprGv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLM5Y60e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5708C3277B;
	Sat, 20 Apr 2024 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713603444;
	bh=d2Y+idK3Ze2qLNSSS7zzqAxEmlRt9o56eI03/DQs9YU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MLM5Y60eHDyutEenfWi+nAlLlul1vs9La6sIQBOX19D2C3Zev891B9UqgwDrFnZeJ
	 U3jUJle7qUr4cFuway59hMUoPtnULEcIIO4miZcoLQmXyC7h0yVt6xTuQKrHRITLQA
	 SHhEU8/lmGOdl2UZhRLosH94uD5CMIMN+FJYWoxcf78UwSHqIHq8rt7daJnJlkHvp+
	 8RuU7YgjCqC5MYTomb0P/e5du0wAce1CHAaxj+tx0EIEaZwHI+Q6+lEZOgan6if0cB
	 cUYUvZ/rf6ARkatjn06Rb9MA1GhyYEwRM0hP4wSSeNcEdqeXa7dMVYj1NuAk175zzu
	 VvxTMvKLzpRGA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5171a529224so3472201e87.0;
        Sat, 20 Apr 2024 01:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9qKjVmk3lSjVOF4dq6deaHpUhWZ0M05ldRhB6wq13JrIRVB1F25kcPqdr9PSmyIsOjFuxKc4as4m1sxeBezJ6zLmbXH5uEULam94G
X-Gm-Message-State: AOJu0YyFpEzlK8rtLhaV2glGWQiG+JtcQPRtvtxo2X9mWPIGNvyHnYb4
	3BHJ7Fk14XMhG9OukynDy8U7Kpg807KSRcX7UubbqumAEa3VBOGhpEv463cFG4ATNiSiWxIC/hu
	y4J+msmVp+G0GsfAOhFkoHyKWm8I=
X-Google-Smtp-Source: AGHT+IG7RpB8rXBg11bASz5e74pbzwb4JhWSwB6jtemH9s9rN8KKlboDqB17LhSPkHs8WSROhE2vmvFN3PzE0/1pJqc=
X-Received: by 2002:a19:5f12:0:b0:519:b963:6591 with SMTP id
 t18-20020a195f12000000b00519b9636591mr2472663lfb.23.1713603443578; Sat, 20
 Apr 2024 01:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416121838.95427-1-masahiroy@kernel.org> <20240416121838.95427-5-masahiroy@kernel.org>
 <ZiKJNrei7zUVaLkb@bergen.fjasle.eu>
In-Reply-To: <ZiKJNrei7zUVaLkb@bergen.fjasle.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 17:56:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQBZyKArGAO9GyjiN26cUgjmxaczStxsJG-Q0b7RW+Yg@mail.gmail.com>
Message-ID: <CAK7LNATQBZyKArGAO9GyjiN26cUgjmxaczStxsJG-Q0b7RW+Yg@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for
 source directory
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:09=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Tue 16 Apr 2024 21:18:38 GMT, Masahiro Yamada wrote:
> > Kbuild conventionally uses $(obj)/ for generated files, and $(src)/ for
> > checked-in source files. It is merely a convention without any function=
al
> > difference. In fact, $(obj) and $(src) are exactly the same, as defined
> > in scripts/Makefile.build:
> >
> >     src :=3D $(obj)
> >
> > When the kernel is built in a separate output directory, $(src) does
> > not match the directory in the source tree. It still works because the
> > top Makefile sets VPATH to $(srctree). However, VPATH does not cover
> > all cases. There are many places where the exact path to the source
> > directory is needed. For example, when adding a header search path for
> > local headers, it is typical to pass -I$(srctree)/$(src) to the compile=
r.
> >
> > However, it introduces inconsistency between upstream Makefiles and
> > downstream Makefiles; when the source directory path is needed,
> > $(srctree)/$(src) is used in the upstream kernel, while $(src) is used
> > in external modules.
> >
> > To resolve the distortion, this commit changes the semantics of $(src)
> > so that it always points to the directory in the source tree.
> >
> > Going forward, the variables used in Makefiles will work as follows:
> >
> >   $(obj)     - directory in the object tree
> >   $(src)     - directory in the source tree  (changed by this commit!)
> >   $(objtree) - the top of the kernel object tree
> >   $(srctree) - the top of the kernel source tree
> >
> > This is a tweewide Makefile conversion for replacing $(srctree)/$(src)
> > with $(src).
>
> tweewide -> treewide
>
> [...]
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 3bf5cab4b451..fe9ceb0d2288 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -6,11 +6,6 @@
> >  # Rewritten to use lists instead of if-statements.
> >  #
> >
> > -# Some driver Makefiles miss $(srctree)/ for include directive.
> > -ifdef building_out_of_srctree
> > -MAKEFLAGS +=3D --include-dir=3D$(srctree)
> > -endif
> > -
>
> Ah, it's nice to get rid of this.
>
> >  obj-y                                +=3D cache/
> >  obj-y                                +=3D irqchip/
> >  obj-y                                +=3D bus/
> [...]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 3179747cbd2c..c53d2f168801 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -209,13 +209,13 @@ _c_flags +=3D $(if $(patsubst n%,, \
> >       -D__KCSAN_INSTRUMENT_BARRIERS__)
> >  endif
> >
> > -# $(srctree)/$(src) for including checkin headers from generated sourc=
e files
> > -# $(objtree)/$(obj) for including generated headers from checkin sourc=
e files
> > +# $(src) for including checkin headers from generated source files
> > +# $(obj) for including generated headers from checkin source files
>
> this is a funny criss-cross of words; but might the following be more
> accurate?
>
> # $(src) for including headers from checked-in source files
> # $(obj) for including generated headers



These are added only when building_out_of_srctree is defined.

When the kernel is built in-tree,
the include directive with the double-quote form
should work without the header inclusion path.



Anyway, this does not seem to be a good idea.
I want to get rid of these entirely.




>
>
>
> Anyway, thanks for the patch.  I think it is quite a good way forward!
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



--=20
Best Regards
Masahiro Yamada

