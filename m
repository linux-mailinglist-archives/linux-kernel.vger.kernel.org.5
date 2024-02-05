Return-Path: <linux-kernel+bounces-52663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B638849B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF08D1F27390
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F221363;
	Mon,  5 Feb 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8SAX0s5"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE3210F0;
	Mon,  5 Feb 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137645; cv=none; b=o7uP3Q2BNloiL2YzMKq6tjhBh2WGVZVlJ75PuwTt2PEgKAG8HbzLvG3zgBKHyA5vhQvGxTRFEb34VjbWUAK1Qr3uDbFx/pK6IY4y/XZ8wDikqi8LzM7bEmAb8RiHIRY8s5yBgb07T4+BxvJYCovUMXALXcDegSAgtt2p2VkZo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137645; c=relaxed/simple;
	bh=VCKvwMzG7w42NeF0InbR1amJ2floGRc0HxWfyTRcevU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brjOQnpkMkKMcXh5OWYjkoVrRZNUC9P2y3/9OtRLHa+ABo0KEfs5f6lUWF9WWFdTiy9os/9Y1oq2C/4LVS4ZQoKNAYrY/z6UEEUaLKw9BKSADPH4E+t8n5CwDJKT/6UYJydXJmQvJJtBtrlati8yB4by1L+w2qIjy73dyLLlXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8SAX0s5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100cb238bcso7872468e87.3;
        Mon, 05 Feb 2024 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707137641; x=1707742441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14UfJITL0dkLd5SyibepbNnNaR97wsfScRKTGspT4eo=;
        b=e8SAX0s53j/m7sVON/iz50DSQtTdlh0TFb/r4sw0LwGCQ+vApnSTh9U2lWGm6G6fi4
         pceIZ7vmtySQEBbBPeCBPNHVUZWXJQeTXaKfsU/l761J6I2Vwg6735NMtOq1aEJJjzSh
         wwB1hx8RnNDT40rg3foHmeOKqByYlYZyttlG2Z9QBQGjTBFJ02/WO2Oj9wnISaYh1fbR
         eLwaUPncBSJbmYrP4zvyNbs+fFcrz22XUHTKCKQRwxRB9WCJqbRR57mEMixm/4laQQlS
         FZlynuSQkkn9D3FFzYguTXUbfVKLckrmf84J3Uf6uO8zKqjDooVQ6/PZkCvYOZ8TCmD3
         nW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137641; x=1707742441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14UfJITL0dkLd5SyibepbNnNaR97wsfScRKTGspT4eo=;
        b=ok3ZdvV2yElwjjgejRgABQcK69KRhTO+DzpL+ndFhc4aN1IfQEV5wjwtE5PYvx0jqG
         cYYnmNqwqloJB5dG5DEhxwF7jLYofFWOw9tj9bezAbetLp4KyZI4MIg+GLEvbLk3hw39
         6azipR2AEuuf3nLY2kwe8gqFNh71/HHMLRguPcmESCsFL71l9Y9m/qX4hV+WncUmX2B1
         uI04dj7ULRB5+LhPlqE7tljBA9VAnvuzaWIhHJdzGRA+lZtZEVWQ9nKOU9ojksGNYYJY
         bNrSSCADVLJQR2EgvLUp3Q9/jgJgfnQZcSY0yF0/1BX1iHQX1F15AmCZNzZxYcSQVf3q
         sMzw==
X-Gm-Message-State: AOJu0Yx/QvjbfAKSsWhHP5Ov2Z/o16Kp1O9+uYaShTbJz0/3ZjNR5adx
	8kaJqg8TR/UyHnQL4OkVN+mHFkAlhiFxnG5/v74Y7vO6eTeyqtps
X-Google-Smtp-Source: AGHT+IEstjd+gZA5Cwb9QE2UQ/KG2Wg84chLizfiWugJ6uIGX8oINJ/rvF1ahqw65PMnNrUF6dU2xQ==
X-Received: by 2002:ac2:4837:0:b0:511:53c6:2d with SMTP id 23-20020ac24837000000b0051153c6002dmr820067lft.46.1707137640551;
        Mon, 05 Feb 2024 04:54:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVUOahf5fd4pgIFmBCGkSP9TbLXOsKXAPzRLRivxXn//rhvweVuzFaDJ69xc7kbw+FUKoSpgmwG4aaUPFlpq7i/w2y3x5XHlAXboKgAe+bCWEuoT1B07kP0HmIZyjQzxaiZsSqdGUHspZlgw/Li0Fwn3HjboC60MEQ6wersRVUa8UlLZbTMP3U820JjCd+Q6+koSANQ3XceUCzFMYnhYbe5KLNRf9tyCUykZal6B0K3E20u+Ii5nWPoeB4Wuf0zIIX7krLC/sokKHCDUz/tChepB5C0U3TssT2luDxlm8lSQRDx2R43noYFIvhibezzRs8F3i235b4cJjKwRr0A6YB2F1Xh1bBOLR88ajJEbiZEJx7kyila69E1SoVMBAg4I251at2/KBtLkRjifszg7gnX8PssSnDKlelEvq+WseDxs3Kbgijx3E58G/TKsogl4DR6p2e16zhQK4FN80ZdpWPnsUQmRZL9RWMOm6QY4ASIbA8J4LvAuEyJTPnAWbws3yY2Az35zeUq8TsurKhu+BbiNeIV2h689CmWyRPVPG0=
Received: from ?IPV6:2a02:6b8:83:1506:8b8c:af7e:d3ba:a153? ([2a02:6b8:83:1506:8b8c:af7e:d3ba:a153])
        by smtp.gmail.com with ESMTPSA id i11-20020a056512318b00b00511525b9d57sm230097lfe.43.2024.02.05.04.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:54:00 -0800 (PST)
Message-ID: <67a842ad-b900-4c63-afcb-63455934f727@gmail.com>
Date: Mon, 5 Feb 2024 13:54:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240205093725.make.582-kees@kernel.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20240205093725.make.582-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 10:37, Kees Cook wrote:

> ---
>  include/linux/compiler_types.h |  9 ++++-
>  lib/Kconfig.ubsan              | 14 +++++++
>  lib/test_ubsan.c               | 37 ++++++++++++++++++
>  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
>  lib/ubsan.h                    |  4 ++
>  scripts/Makefile.lib           |  3 ++
>  scripts/Makefile.ubsan         |  3 ++
>  7 files changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..ee9d272008a5 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -282,11 +282,18 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>  
> +/* Do not trap wrapping arithmetic within an annotated function. */
> +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> +#else
> +# define __signed_wrap
> +#endif
> +
>  /* Section for code which can't be instrumented at all */
>  #define __noinstr_section(section)					\
>  	noinline notrace __attribute((__section__(section)))		\
>  	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> -	__no_sanitize_memory
> +	__no_sanitize_memory __signed_wrap
>  

Given this disables all kinds of code instrumentations,
shouldn't we just add __no_sanitize_undefined here?

I suspect that ubsan's instrumentation usually doesn't cause problems
because it calls __ubsan_* functions with all heavy stuff (printk, locks etc)
only if code has an UB. So the answer to the question above depends on
whether we want to ignore UBs in "noinstr" code or to get some weird side effect,
possibly without proper UBSAN report in dmesg.


