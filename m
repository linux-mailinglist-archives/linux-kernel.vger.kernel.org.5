Return-Path: <linux-kernel+bounces-15732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224CF8230FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4534C1C23A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7F1B288;
	Wed,  3 Jan 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br2YNMnV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CD1B27F;
	Wed,  3 Jan 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e9a42582aso2898598e87.2;
        Wed, 03 Jan 2024 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704297910; x=1704902710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MW1jQPu224rbEEeyM1X/QZLP/txX703VWVb2odsAfYI=;
        b=Br2YNMnVJ9Rw3aSDVlqqiCiG3up2Sgf/agStc7CgTphCWC8YdRlm+4hoNZWINVLH3r
         vFt8ewm81GGB3pDwfcc5lAKn1biakjqwhap3TLY7z2Dce5rdW+EKP8w+SU4IAbKi/yD9
         gZXkD8RNn/pwRfp+jNtg8eBFnTwX8Yz3wGGr/fGMUOJWjDgq3dzZyJq6l3U8ok5pAOlP
         1Com4cE+4maFcA/6UrRd0slZb8ibeyOInrdvtq+CQ1ZR0i9122fHVckpIrQ+pjhlg783
         92MyFDH2ohRiVBc45C3Tg74YKbqEllEuXgHzGGek1WjJ9+qA8+bEnPjeRzfRE5ecXaKF
         AfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297910; x=1704902710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MW1jQPu224rbEEeyM1X/QZLP/txX703VWVb2odsAfYI=;
        b=qIllV8praLTG+EYCCnmm85AMIb2U+03sKW2cHpQZkgoUr85kT8Hh/zM4JKgHTBWOBN
         wVWGdEzgAugOHr3eVfBN2pbqkRtcU87ubXlFzMM4G5ZG08W60CDQbJl0BOyPpVNFJ9wj
         LIkqA4u/5aLDJTvpkp0MXRmkBkJu1Ep4Xcj1BPUg86XWOPzzG0txU2CyGecDKQkImz/K
         HKPSDcjO++bXeLCG8iYEsKnZJhbihEH+P/uJNzHLamqAp3PqNKVssdKlFZv9YA95UHOK
         6/ijgaD4MaY56/zt+/TJaGrzAbGLzEdXvnkNJ2oF9hu+/hkLciqRNwhtlzTq67X9AD7D
         AGbA==
X-Gm-Message-State: AOJu0Yy3gHXfYVSMI8ts6NXv6y8oQBEv4dkdKusWxjLnhKUYDMU9LA5H
	qvqe3LrjQMmQwy9nvIcLicLbGcEa3BrxWphlBTo8uYmV4rU=
X-Google-Smtp-Source: AGHT+IH86QHuT0k9Qfl7OLMI2JboD5IN0h5gjZH0IWf7JsDs6QpF5jey+HjAl8XWCh0AatV42ZMQ4vPC/vYzTByXf/g=
X-Received: by 2002:ac2:4a67:0:b0:50e:6d96:4b28 with SMTP id
 q7-20020ac24a67000000b0050e6d964b28mr7045064lfp.137.1704297909923; Wed, 03
 Jan 2024 08:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103135454.376021-1-masahiroy@kernel.org>
In-Reply-To: <20240103135454.376021-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 3 Jan 2024 17:04:32 +0100
Message-ID: <CA+icZUX77miqFC5=iH_9e4BZw5hc1Ci8A3cHL1uGPnzHw258Hw@mail.gmail.com>
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Happy new 2024 Masahiro,

some small nits.

What about adding links to the commits...

linux/export: Fix alignment for 64-bit ksymtab entries
[ Upstream commit f6847807c22f6944c71c981b630b9fff30801e73 ]

linux/export: Ensure natural alignment of kcrctab array
[ Upstream commit 753547de0daecbdbd1af3618987ddade325d9aaa ]

^^ AFAICS in linux-stable - v6.6.10-rc1 includes both
^^ Is yours a follow-up and makes sense for linux-stable releases?

...and CC Helge Deller?

Best regards,
-Sedat-

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-r=
c.git/log/?h=3Dlinux-6.6.y

On Wed, Jan 3, 2024 at 2:55=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> The .export_symbol section is discarded by the linker script, hence
> no alignment is needed. Simplify the code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  include/linux/export.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 0bbd02fd351d..dff230bb5aca 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -15,13 +15,9 @@
>   */
>
>  #ifdef CONFIG_64BIT
> -#define __EXPORT_SYMBOL_REF(sym)                       \
> -       .balign 8                               ASM_NL  \
> -       .quad sym
> +#define __EXPORT_SYMBOL_PTR    .quad
>  #else
> -#define __EXPORT_SYMBOL_REF(sym)                       \
> -       .balign 4                               ASM_NL  \
> -       .long sym
> +#define __EXPORT_SYMBOL_PTR    .long
>  #endif
>
>  #define ___EXPORT_SYMBOL(sym, license, ns)             \
> @@ -29,7 +25,7 @@
>         __export_symbol_##sym:                  ASM_NL  \
>                 .asciz license                  ASM_NL  \
>                 .asciz ns                       ASM_NL  \
> -               __EXPORT_SYMBOL_REF(sym)        ASM_NL  \
> +               __EXPORT_SYMBOL_PTR sym         ASM_NL  \
>         .previous
>
>  #if defined(__DISABLE_EXPORTS)
> --
> 2.40.1
>
>

