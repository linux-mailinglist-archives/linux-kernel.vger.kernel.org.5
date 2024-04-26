Return-Path: <linux-kernel+bounces-159821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CBF8B349C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E919F1F22E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A3140381;
	Fri, 26 Apr 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmcZtXGo"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E213F01A;
	Fri, 26 Apr 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125254; cv=none; b=uy2PPi4JvLssowCqBWmM3NTKVxsigY+rgn8isQXVggl/kMbDwpOidFyjx4cc7sAfgLLGT+pgiw/DcCL/r0LeUxVavP9b2haSyWRSNvptXToviZvKvrcw6CzKF9IBHVPy+AQpso//24h42J/xwOZ5eM4P2baf8+YhYo0iVkemdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125254; c=relaxed/simple;
	bh=B8iZwl1tSPR7hZn9aDmfmPPvd4dqIX6kZXOjez5f1tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3caY6ZEdBx5PuJQsJVUNbLa/gD/AaG2mBOnN8KXHFxBYmUZ5lzIjviXoEY0299APXHGflP50KEruMDb35qp72sjmtUpLwh6u+tyIvOBn8nqw1M42iSkC9iJL7sefL8Ph30CFZRXaNYsEvf3iNg7wrAfuXvpXqO1LHbVTDry8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmcZtXGo; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4dac19aa9b5so672809e0c.2;
        Fri, 26 Apr 2024 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714125252; x=1714730052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv2AnzM+IRnKHtYwA4l3TTkES9QCslE+SVgv6ZpTagM=;
        b=TmcZtXGosk7TxCw3njLBi6L1mhWBZJN1Qf15nWmHTj//9Q/s1gGj1XnVBrried4dNF
         9Zec4gwZQa9Psa8bcf6SmrSYFnvXs076kdxisQYCJOkGkTZYpLWD+ekQEa6riKEb6qtS
         ojlGjxJHliDvCuhjbCSK6D0eremDEIlwFF0+QKtbcLVmK64CQcQdBrV0iQqOF1tK7rvX
         apnTGk2w7HJZ0kaDooDRF+ybxvocC3EVfY9b4gAXPNXYFkbHTGtiEw262RJ48K7/s/pu
         69PtplacUrhLf6JBcH4rzEyQndSSp6fw//EJjARjwzoFbiNqyLnVhZ4iYXHVA/P/hzPx
         Do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125252; x=1714730052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv2AnzM+IRnKHtYwA4l3TTkES9QCslE+SVgv6ZpTagM=;
        b=lo4J1fFKUOHFk91kpmB5geLpe/Jau10wdj7K9csVv+d5N1drXSxGCGT4N57KXBwqQN
         OqsZcez16QxX9E9Vs593S+85kIIGier7pigHou8gQ9ErZFidod+/xd8speCsM0BY245M
         U6TAm1Ee4FNjaXBpj9+qBgNfFm06NhwWpQZsOprGAjJ3Go5BH2GFaPTfH007qeJcHNjO
         5dq+1te+WR3LHDEcslMscOsyX4hPUrmU2vjR5FI8HfVWod29/PqJiVRZdSsX/Ek5qr9e
         6pAb/Lm5QtauQLRuFKGiJWC0ttfWGAYOeDCudxwcGfxPClYnB8YcDDuhuLMyUL1rqoe2
         XfBg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Rsfy5iRP9s1VcSzcADq3xbPtoxoiZhmOzyEJ/N3Z8z0K1IGp9HRiVbykWddXoBNAjTRZbCqxPvfzSP/KKz2pKuJQwr+4t0wTmtUJxWxqCuil2Gi6vluNPjwPHB+8X054waNw84+7sSdhAruADYw6LELy/h468TgI1OLuKX3dqGMe
X-Gm-Message-State: AOJu0Yyxelod29ZLCGiEYPBNh+eZbBUBYQXPDL6AuxowwM6V4zFzJzsv
	BkQOZM30KInDTVVG01vyuZBIA3YmR0d/6BpeH2ata6kg1NdZ0JY8TJzK+vVlizw8W5czn/iIcyQ
	2Lww7kKgk9ykN28elzVB7gHiSmlw=
X-Google-Smtp-Source: AGHT+IG0ipQ4rKvgJihRKb06cwykLATWUBuMR/QaDj4gg4w5nDCDHsUTmMk16VSSdjFOGsP5wdS2W4FDOVlkPfeX96Y=
X-Received: by 2002:a05:6122:1788:b0:4c0:2d32:612f with SMTP id
 o8-20020a056122178800b004c02d32612fmr2060791vkf.15.1714125252037; Fri, 26 Apr
 2024 02:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403224254.10313-1-21cnbao@gmail.com> <20240403224254.10313-3-21cnbao@gmail.com>
In-Reply-To: <20240403224254.10313-3-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 17:54:00 +0800
Message-ID: <CAGsJ_4yjf0=5LbytmseCazr8jg-MWYVzY3d6bJc8VcwJsneUEQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
To: akpm@linux-foundation.org, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, joe@perches.com
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn, 
	chris@zankel.net, corbet@lwn.net, dwaipayanray1@gmail.com, 
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lukas.bulwahn@gmail.com, mac.xxn@outlook.com, sfr@canb.auug.org.au, 
	v-songbaohua@oppo.com, Max Filippov <jcmvbkbc@gmail.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Charlemagne Lasse <charlemagnelasse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joe,
any further comment for this ? May this patch get your reviewed / acked?

On Thu, Apr 4, 2024 at 6:43=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Xining Xu <mac.xxn@outlook.com>
>
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
>
> For a macro such as the one below,
>
>  #define test(a) do { } while (0)
>
> The test result is as follows.
>
>  WARNING: Argument 'a' is not used in function-like macro
>  #21: FILE: mm/init-mm.c:20:
>  +#define test(a) do { } while (0)
>
>  total: 0 errors, 1 warnings, 8 lines checked
>
> Signed-off-by: Xining Xu <mac.xxn@outlook.com>
> Tested-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 14 ++++++++++++++
>  scripts/checkpatch.pl                  |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index 127968995847..a9fac978a525 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -906,6 +906,20 @@ Macros, Attributes and Symbols
>
>      See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725=
/
>
> +  **MACRO_ARG_UNUSED**
> +    If function-like macros do not utilize a parameter, it might result
> +    in a build warning. We advocate for utilizing static inline function=
s
> +    to replace such macros.
> +    For example, for a macro such as the one below::
> +
> +      #define test(a) do { } while (0)
> +
> +    there would be a warning like below::
> +
> +      WARNING: Argument 'a' is not used in function-like macro.
> +
> +    See: https://www.kernel.org/doc/html/latest/process/coding-style.htm=
l#macros-enums-and-rtl
> +
>    **SINGLE_STATEMENT_DO_WHILE_MACRO**
>      For the multi-statement macros, it is necessary to use the do-while
>      loop to avoid unpredictable code paths. The do-while loop helps to
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..9895d7e38a9f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6040,6 +6040,12 @@ sub process {
>                                         CHK("MACRO_ARG_PRECEDENCE",
>                                             "Macro argument '$arg' may be=
 better as '($arg)' to avoid precedence issues\n" . "$herectx");
>                                 }
> +
> +# check if this is an unused argument
> +                               if ($define_stmt !~ /\b$arg\b/) {
> +                                       WARN("MACRO_ARG_UNUSED",
> +                                               "Argument '$arg' is not u=
sed in function-like macro\n" . "$herectx");
> +                               }
>                         }
>
>  # check for macros with flow control, but without ## concatenation
> --
> 2.34.1
>

Thanks
Barry

