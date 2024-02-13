Return-Path: <linux-kernel+bounces-62870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C0852727
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3258EB261E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11807494;
	Tue, 13 Feb 2024 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB066ddO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56E6AD6;
	Tue, 13 Feb 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788957; cv=none; b=lT9A396vvJl1K6jmuQU0H0v3yKVY0PP+Uk0fI8JVb0gxUaCe/zonBPkgCnHaUCiBkyFtbfnohfBVh0fJdnZo3QAy4rbq0TH4p5ngWjoXdVyuP8soIxvUiqR9VAT+z0Ur8Gk0ulXSj9D0Y5cmNryFYJI0kM69kVCfQmrGkXhGxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788957; c=relaxed/simple;
	bh=fwi+S6J+pteyq5souUcQ1aE411KhyQboibrZURAETGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+h3980x5cP1AgiBqu3UoSQQ52WElPTPp+zJiJdOonR7A2OzqsY4tKLPfjmOQe6G47PQlGHXha5ghpJVFmk9NzEE8qSgAFfk3lkKhJ6daoyUOwfyG2kFRzX9q7epsLKy+qigJlM6ohSkgWgfALlH5jR4Frum5LwKtjc84n6sj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB066ddO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF5C433C7;
	Tue, 13 Feb 2024 01:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788956;
	bh=fwi+S6J+pteyq5souUcQ1aE411KhyQboibrZURAETGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SB066ddODX74QE0NXa6YM4dNF3B/RHTy/yqZSYALXk8oCKpBrej/OrEdmIAZ8XMve
	 HOxbZl18aKLQf75Lo9ZKmdQL3FvET3tqHo+scfINU44j25ZrAm8u4vfxBXBW4KyMdE
	 1NQzF+/oOD+EjhvMLevfbG3y9abmvL9K9Wzz0G23mfty7L8X+rphG3ZiRSoPTYSxVc
	 S35oupbf/MWD9ZEwN67SVagld7EzUExGyMMbe2gorDngh9eEtEnhLB4zuAMyPTBHQ6
	 afpbhRqEqAM5B4sozXPC4HYEvfENn4dDtXYBqsHX6FR6mIJmHVQJx3n+P7VB4O8Wsf
	 MSK9EuLAJBgyA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5114c05806eso6109797e87.1;
        Mon, 12 Feb 2024 17:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBdjn7HHeACsVU5fL8zgYGzM1FETA/Srs/cdY5vppgTVAoAj9xWMwYDmdTsBWKkAkmFKbqen7sFHrchAYWdxHzFhAmmnGjxwudP7gY
X-Gm-Message-State: AOJu0Ywr2+HNBXypdhqZyywiwEOt9PJk3AAnRKs2s/c3iAzIeQzSN5cI
	UUKHCGBQ3/t9iN6oQkXyFCOzDrNQbbpqpdHf3HLZjBFoMvyVHaYLuqSdGUGhecyrFwK/GT74PtH
	e2ubeObv5AISIuyZE8rlDXZqoPQU=
X-Google-Smtp-Source: AGHT+IEvAcxySNDK5LFyWfGkXegyxgDeA7TWn8kqRJrtoaDM8U7l6muFRj8GgN0zyqA42UyUG172uMMnBToTM3xhDec=
X-Received: by 2002:ac2:4c0e:0:b0:511:68e9:f698 with SMTP id
 t14-20020ac24c0e000000b0051168e9f698mr5384203lfq.61.1707788955189; Mon, 12
 Feb 2024 17:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213012035.750928-1-andrewjballance@gmail.com>
In-Reply-To: <20240213012035.750928-1-andrewjballance@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 13 Feb 2024 10:48:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaW1V5X79BFW5_YTKY+n+OSp+_ACpRxpiw+VOJ+2hf=g@mail.gmail.com>
Message-ID: <CAK7LNARaW1V5X79BFW5_YTKY+n+OSp+_ACpRxpiw+VOJ+2hf=g@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_commands: fix invalid escape sequence
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: linux-kernel@vger.kernel.org, nathan@kernel.org, nicolas@fjasle.eu, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:21=E2=80=AFAM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> this fixes the error, "SyntaxWarning: invalid escape sequence '\#'"
>
> the error can be recreated by running


Not an error.
It is a warning.


>     make CC=3Dclang compile_commands.json



What is more important is to mention the Python version
in the commit description.

Example:

---------------->8----------------
With Python 3.12, '\#' results in this warning:

  SyntaxWarning: invalid escape sequence '\#'
---------------->8----------------



Please update the commit message.




The make command is not so important.

I quickly confirm it in the interactive mode
instead of running the build command.



$ python3.12
Python 3.12.0 (main, Oct  4 2023, 06:27:34) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> '\#'
<stdin>:1: SyntaxWarning: invalid escape sequence '\#'
'\\#'
>>> '\\#'
'\\#'





>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index 5dea4479240b..93f64095fda9 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file=
_path):
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending=
 on the
>      # kernel version). The compile_commands.json file is not intereprete=
d
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#'=
)
> +    prefix =3D command_prefix.replace('\\#', '#').replace('$(pound)', '#=
')
>
>      # Return the canonical path, eliminating any symbolic links encounte=
red in the path.
>      abs_path =3D os.path.realpath(os.path.join(root_directory, file_path=
))
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

