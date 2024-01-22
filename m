Return-Path: <linux-kernel+bounces-33100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9257683647B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A75228A77E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0733D0A4;
	Mon, 22 Jan 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwjTQEET"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013393CF74;
	Mon, 22 Jan 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930210; cv=none; b=uzzQ0kLjDmGox+mk5gapb3wVRrFXECmc2ex4XF3lQzhynJmZ37exRPN2ELIV3zZbAmJ8a8HyoXp0DCh7jEP4i2LN9L9qEaGypc0MN46gPpOqN8/pRmZsDZ4Lq4FTR526kzKA7W2WOLYDciIxo1iZJ7BAwGH3obkkz7DvTf4Ix70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930210; c=relaxed/simple;
	bh=4A96w+cR55kul34CYotNgJL0RvYxGwYFawLwerjklIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4Y4GoVG1tY8r4ffHUkDW49oRCl6VQCNH4IHmHciAyY8g5nlizFpdH08i8KPAEUfOLha5cK+2b8GhanvuVobLb2Qtht9Y/U+vAuuIlr7pvmEQV1MLBC1J2w8M3BJYhx63oGOw3c2gI9t2pIx3CzHzUW/H8QOpvttTelH3yJ34IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwjTQEET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E89FC43390;
	Mon, 22 Jan 2024 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705930209;
	bh=4A96w+cR55kul34CYotNgJL0RvYxGwYFawLwerjklIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NwjTQEETO+/6HPaYF2F3ycrYsC4xNzT1rXT0Qcr7hpKbQjTfxm3nY4SlYOo2q9vOg
	 Ll3mUDjPoBBm3/7vmwXoQUucNKBSBRN+afHTa64bD9UYA3pf/WCwLlCORbUQbn72hv
	 /23X5wLkNPGSlv3HI0KQhlQtj8prDlzM3WGFvmohWwnxodQ6gYHO3JijJW8zR8x70K
	 gnjUMy+K24XbDw8qMZyQLXrgGRVQRE13HIkPFdleWqorT02Tr5KXXx+qo3DtIiDnM4
	 uPzihnQnPL6yOdPa7bH6fpVMMCXBQmE87OTkB3hvwWyHNUceT0R2LM0kfoHo1BD+7I
	 ZNuQI1sLF4+tg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2108c7829caso975758fac.3;
        Mon, 22 Jan 2024 05:30:09 -0800 (PST)
X-Gm-Message-State: AOJu0YyW2iPVNRPswi7JGVrzhFYhXd9rgKx10OpjkNBVwAW2HgnbvQ9u
	iGuaw+zKQWVPPZg6vlvS+wr5DbOniAdGfbalfaSdEEZ/jJQKlckwjjsrVyXq4B96kyLKSPqDfug
	9LNBEjt1w44Die07rGZzAa/6fJPw=
X-Google-Smtp-Source: AGHT+IG3o1mwiOT2MlEY81yj8SVBfdY2+4Wk5uvdd4OM0SFC1IwEY4q7u6DJbEgjqPYhgIhrvdW1SKjMVwf8TKEVntA=
X-Received: by 2002:a05:6870:a113:b0:20e:1f0c:4354 with SMTP id
 m19-20020a056870a11300b0020e1f0c4354mr2266067oae.12.1705930208894; Mon, 22
 Jan 2024 05:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com>
In-Reply-To: <d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 22 Jan 2024 22:29:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDD2gC53T5n7vCUH6O6mdAm801fTWyKi9fji+5Kb+0ng@mail.gmail.com>
Message-ID: <CAK7LNATDD2gC53T5n7vCUH6O6mdAm801fTWyKi9fji+5Kb+0ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] modpost: inform compilers that fatal() never returns
To: Aiden Leong <aiden.leong@aibsd.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu, 
	clang-built-linux <llvm@lists.linux.dev>, 
	=?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+CC: clang-built-linux list, Fangrui

On Mon, Jan 22, 2024 at 1:04=E2=80=AFPM Aiden Leong <aiden.leong@aibsd.com>=
 wrote:
>
>
>  > The function fatal() never returns because modpost_log() calls exit(1)
>
>  > when LOG_FATAL is passed.
>  >
>  > Inform compilers of this fact so that unreachable code flow can be
>  > identified at compile time.
>  >
>  > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>  > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>  > ---
>  >
>  > Changes in v2:
>  >   - Use noreturn attribute together with alias
>  >
>  >  scripts/mod/modpost.c | 3 +++
>  >  scripts/mod/modpost.h | 5 ++++-
>  >  2 files changed, 7 insertions(+), 1 deletion(-)
>  >
>  > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>  > index ca0a90158f85..c13bc9095df3 100644
>  > --- a/scripts/mod/modpost.c
>  > +++ b/scripts/mod/modpost.c
>  > @@ -90,6 +90,9 @@ void modpost_log(enum loglevel loglevel, const char
> *fmt, ...)
>  >          error_occurred =3D true;
>  >  }
>  >
>  > +void __attribute__((alias("modpost_log")))
>
> Hi Masahiro,
> I cross-compile kernel on Apple Silicon MacBook Pro
> and every thing works well until this patch.
>
> My build command:
> make ARCH=3Darm CROSS_COMPILE=3Darm-none-eabi- \
> HOSTCFLAGS=3D"-I/opt/homebrew/opt/openssl/include" \
> HOSTLDFLAGS=3D"-L/opt/homebrew/opt/openssl/lib"
>
> Error message:
> scripts/mod/modpost.c:93:21: error: aliases are not supported on darwin


It is unfortunate.  Indeed, I see this message in:

clang/include/clang/Basic/DiagnosticSemaKinds.td


Is this limitation due to macOS executable (PEF),
or is it Clang-specific?

Perhaps, "brew install gcc" can be a solution?










>
> Aiden Leong
>
>  > +modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
>  > +
>  >  static inline bool strends(const char *str, const char *postfix)
>  >  {
>  >      if (strlen(str) < strlen(postfix))
>  > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
>  > index 9fe974dc1a52..835cababf1b0 100644
>  > --- a/scripts/mod/modpost.h
>  > +++ b/scripts/mod/modpost.h
>  > @@ -200,6 +200,9 @@ enum loglevel {
>  >  void __attribute__((format(printf, 2, 3)))
>  >  modpost_log(enum loglevel loglevel, const char *fmt, ...);
>  >
>  > +void __attribute__((format(printf, 2, 3), noreturn))
>  > +modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
>  > +
>  >  /*
>  >   * warn - show the given message, then let modpost continue running,
> still
>  >   *        allowing modpost to exit successfully. This should be used
> when
>  > @@ -215,4 +218,4 @@ modpost_log(enum loglevel loglevel, const char
> *fmt, ...);
>  >   */
>  >  #define warn(fmt, args...)    modpost_log(LOG_WARN, fmt, ##args)
>  >  #define error(fmt, args...)    modpost_log(LOG_ERROR, fmt, ##args)
>  > -#define fatal(fmt, args...)    modpost_log(LOG_FATAL, fmt, ##args)
>  > +#define fatal(fmt, args...)    modpost_log_noret(LOG_FATAL, fmt, ##ar=
gs)
>  > --
>  > 2.40.1



--
Best Regards
Masahiro Yamada

