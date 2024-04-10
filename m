Return-Path: <linux-kernel+bounces-138735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418689F9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D041F28DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3415F3ED;
	Wed, 10 Apr 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3PZRUvp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438315ECF7;
	Wed, 10 Apr 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758707; cv=none; b=rsfjgUOV3zRZN9WebrkKJuGXKK9eMI9emY6vE+p/6o1+7v0QEolQEJV+6+dLKz+NJJK9XpOnCndPb8k8eYmJjRHTmyEDovw3kgBI5Zl0+VCRiOXoX4aYXf6jLT6C7QgNOwD1X9Fav07ZGmmlJikPyP5J+CL/q8g50iGwxbcTvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758707; c=relaxed/simple;
	bh=43iHxXQ+Xn7lzGP2Qk3mNs64oX+sA9CuAlA0854WGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9/HXBpBtkhLiO52nHJBcQTyo0dXcV4/gZDnJNHVH6e8kp1W+srTedycm45SG6sP2O74SOVrohjHCaTyUlbWXPm2CNger3DqdGDpifOa7rYh8jx3Q4SXkruT7JM0hHO4Po35NsMBEwl8eY+UqgBpy0mHCrh96mAWQYK0J+taifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3PZRUvp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso7649129a12.0;
        Wed, 10 Apr 2024 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712758704; x=1713363504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GE1IW0Lti2OUmskUuiVrJg2UU8Baut/hi2lIaMb+BI=;
        b=G3PZRUvpn50cX5dG2as6j+Dkc15fuuM1kslvuFHncG+UXGiDS8UJYbkfrl5wq/QmUx
         jXTz7aTpdZdIG86SXXj3c45afr748+cqukcCeahz5aWvVYTCLTjri9rhcz8KqBS8K320
         +Z/XCohsRCBjV0D5po6Z+pdo1JaQq5WYuwOY90rWdWSqKGvS38253c76gZKQDBGUkSbd
         4MM5fPt195vFXj5DssY72kMPVzagHy+ggUIMCRJJfN7LfURhM+YzNd2AL65feyKMkRLU
         sUn7cQ1gd6wQp9/T5QYJf3WuIRiVLYFnWdBMs7A5vmWWKXDHRv3DmUXrJ5eoKy0Kudau
         +SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712758704; x=1713363504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GE1IW0Lti2OUmskUuiVrJg2UU8Baut/hi2lIaMb+BI=;
        b=ZrWUFJTs7bgvqJkA4gG8g0zdyAb2r9lcsHfdPOaK3KasvSBnIHEPwSylQ+5e65L61U
         8am1KIZZgPiyUMSlC1+PSfpBFgada0XHrZcGB1tXHe7L+TVT3LzNMhZpC/ns0rtsxrwj
         AQw2F9bmANLfFJlmAyP739W4yKYs56Z7DER89yrb104zDkrsOwdh++IDrDGL2So2RevB
         WzjI9RwiJocou0jJnLDa72NhTDQKtAkGpkXAnJdEh6xb69TzddYWw0e9vi/dvuIYlsGM
         SskMfARXmQ5mNzouqKBiLg1xI3daEOSlD0Chp25q+63A3PGf/I1ruesFd6J4FVdzdWFR
         8HqA==
X-Forwarded-Encrypted: i=1; AJvYcCWCD831vJFjJ7Bza94al8Vlkups4Nr4tH+y2dWeVk5nwpN02qw7CU/gG0GpjOl0H1pUZ6t8HLGkJW1w2EJ6pGHiUzAgZH8Y5L3MJr79+Z64gjpG7X3tsvznfElaIns7R4Nk88tqM+67
X-Gm-Message-State: AOJu0Yx+WxZWMXTFJuZH86k/ihFVPiYwb4LWjCJgkgL04J6RiIsUqKJu
	+I43R8+tNVex8lzy3PY8stgiwpNJ7x9jXPynfwFe98+OR5Jh4UQg
X-Google-Smtp-Source: AGHT+IFgbRzN8EqG0LgVdM+i6UEVhaiP9sxgR4y2h+gWh3T543XQTaKg30zVjpcIQn4wX4m9qtdv+w==
X-Received: by 2002:a17:907:7e97:b0:a4e:6223:2507 with SMTP id qb23-20020a1709077e9700b00a4e62232507mr2176259ejc.5.1712758703391;
        Wed, 10 Apr 2024 07:18:23 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id qf31-20020a1709077f1f00b00a5208537b63sm1106506ejc.141.2024.04.10.07.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:18:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 16:18:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/cpu: Ignore "mitigations" kernel parameter if
 SPECULATION_MITIGATIONS=n
Message-ID: <ZhafrPn/2mOcP/FE@gmail.com>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409175108.1512861-4-seanjc@google.com>


* Sean Christopherson <seanjc@google.com> wrote:

> Explicitly disallow enabling mitigations at runtime for kernels that were
> built with CONFIG_SPECULATION_MITIGATIONS=n.  Because more Kconfigs are
> buried behind SPECULATION_MITIGATIONS, trying to provide sane behavior for
> retroactively enabling mitigations is extremely difficult, bordering on
> impossible.  E.g. page table isolation and call depth tracking requrie
> build-time support, BHI mitigations will still be off without additional
> kernel parameters, etc.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  arch/x86/Kconfig                                | 10 +++++++---
>  kernel/cpu.c                                    |  2 ++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 70046a019d42..7d623df11a1a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3423,6 +3423,9 @@
>  			arch-independent options, each of which is an
>  			aggregation of existing arch-specific options.
>  
> +			Note, "mitigations" is supported on x86 if and only if
> +			the kernel was built with SPECULATION_MITIGATIONS=y.
> +
>  			off
>  				Disable all optional CPU mitigations.  This
>  				improves system performance, but it may also
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 10a6251f58f3..f4e4dd360636 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2493,10 +2493,14 @@ menuconfig SPECULATION_MITIGATIONS
>  	default y
>  	help
>  	  Say Y here to enable options which enable mitigations for
> -	  speculative execution hardware vulnerabilities.
> +	  speculative execution hardware vulnerabilities.  Mitigations can
> +	  be disabled or restricted to SMT systems at runtime via the
> +	  "mitigations" kernel parameter.
>  
> -	  If you say N, all mitigations will be disabled. You really
> -	  should know what you are doing to say so.
> +	  If you say N, all mitigations will be disabled.  This CANNOT be
> +	  overridden at runtime.
> +
> +	  Say 'Y', unless you really know what you are doing.
>  
>  if SPECULATION_MITIGATIONS
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 07ad53b7f119..d445763d8047 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3214,6 +3214,8 @@ static int __init mitigations_parse_cmdline(char *arg)
>  {
>  	if (!strcmp(arg, "off"))
>  		cpu_mitigations = CPU_MITIGATIONS_OFF;
> +	else if (!IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS))
> +		pr_crit("Kernel compiled without mitigations, system may still be vulnerable\n");

This doesn't really make it clear that the kernel is actively ignoring the 
mitigations= command line. I think something like this would be more clear:

> +		pr_crit("Kernel compiled without mitigations, ignoring mitigations= boot option. System may still be vulnerable\n");

Thanks,

	Ingo

