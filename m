Return-Path: <linux-kernel+bounces-147910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F48A7B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9747F1C214B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928434084E;
	Wed, 17 Apr 2024 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK1HmUma"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C31E888;
	Wed, 17 Apr 2024 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326387; cv=none; b=L469d6wXZaMAswN4YAiO7xE4KtxPfdURsETG1FNPJ3RxY+O8QV9x+/JvM6GqeR75OKJ4ofiRwiNqmiL26fJPSM2aZ3EErjRa3OQGO2IUUz4ojyVI/8f1+ZJK9VEFN6DmT4a8xm3ScZZUaGRxYTqCEOw6OR4GnZmy8ZSTG+9DC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326387; c=relaxed/simple;
	bh=L4PLcjAiH2fQqPBh+3bDVWjszJ8IoLxh4ltZFgI7w8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft+COn0eDgWkzASJpOhyMoLg33VFgCZFtoRpQ2km95VCKWndqtod/k0cCZy6N3xG6vhOvPlPGbRxykTE1cMafKYm0FmToK7gQYdughqaFlNrVyyQDe1eUC34dEvVIyFiMuCrJ21Oc8Q9KKVLWxhPJnVTpwrkQpjYRJFDs927X9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK1HmUma; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so352862e87.0;
        Tue, 16 Apr 2024 20:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713326384; x=1713931184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbsQ4Tu1m1w7HPSGaOV59vQbfIj8SB/VQJFRuERsF48=;
        b=jK1HmUmaJkcJgDP4bsP2bWxxm8hvp1cZnoa3U88d/1kXCboW9rn8FysSw+78V4wSre
         ukuG6u8iwA+vl04Jn5NKw18jrQh7qBAN7Vq+Qk+9yY1K47kcac/GHTBiF8H7ndGKQAs8
         4/sLQtliPpOh81K7uGyRpktqlpM+2s8ZK4+jDHzBpvjHIOxdL5IA2nnrVy84QFO2H0iL
         ii1n7uePCm9dhjWw+5v+LCc4sqK+b46jYXQXGj7l1f+DeGCI+YjRU6aMcIJywygeZg1u
         iL7l7XbgW0I0PQJENdH7yePAq0FvDx+Sq5/QhUKSL3pINS2hIKeSCqbEHO/t32lDgnoW
         0kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326384; x=1713931184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbsQ4Tu1m1w7HPSGaOV59vQbfIj8SB/VQJFRuERsF48=;
        b=nqXJJYokFFWuQXzn3wgFCv7CmJtOwzIXcXceih7kPYqh8zSrk97x5SCGa6GkORF57/
         yt8U1qzMo7iH5OyBmS11wIWkosTiSNvsO1Bvh4O4Evj3UNJWFKhnLe+HjMeb1WWqOnIz
         IhYxZTHifOcm59975hxteHpvLmUHdlhRG/16BXBlWSKY09sNfYiXJYdAjgjyrwA3txPm
         egrwPgr+Q5PCb2EMzQuEt5+6Hwfg6cXRKNG0TDlEtEoqFFPhuvEd8Cx1A1b5l2VNngX5
         BYD+IKjPI/rOWItWo2scGVfT3bALeZ+f5XNVAzD7qU9SbyVjpL9DPl4nmYGUAti2bpEA
         8l1w==
X-Forwarded-Encrypted: i=1; AJvYcCU3vl4k9eW41+CdTuP1BasCT+TBQwz3mIX8cWKKke9ZrOqGN0IJLP8fBBgzZQUtBfwON7dhrI0T+7RBa9dT3C1o7258Oo0TuYRReAql6nYfPQEpB7oAyxeqGk57Kaq7YvXCuXDwksOqmSoKkwNtn3o=
X-Gm-Message-State: AOJu0YyJQeCKFoyvI8rDdUPUC5ZtRdcHSphzwICTAoB3aPHGQH1LhPT6
	fI/LdOO8MfdDpp9wo7DrAO4ZuAKpOdOTs3LAGjZKy+4DclfxGuRq
X-Google-Smtp-Source: AGHT+IGJbqPeA0nzEzMxCKCTupCUv7UpWbKMysKwjI//QWk683T2vAiGZLfusv4y0ebLSjhUchGNNw==
X-Received: by 2002:ac2:4e42:0:b0:516:d713:382e with SMTP id f2-20020ac24e42000000b00516d713382emr1267054lfr.12.1713326383909;
        Tue, 16 Apr 2024 20:59:43 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1204:59b2:75a3:6a31:61d8? (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e9c4d000000b002da968f03f9sm590524ljj.89.2024.04.16.20.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 20:59:43 -0700 (PDT)
Message-ID: <1075d36b-be92-415e-9c93-a9141a09802f@gmail.com>
Date: Wed, 17 Apr 2024 05:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't used
 at runtime
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "Kaplan, David"
 <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>, David Howells <dhowells@redhat.com>
References: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
 <20240416092720.GCZh5EeB3bPWVDBMoV@fat_crate.local>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240416092720.GCZh5EeB3bPWVDBMoV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-16 11:27, Borislav Petkov wrote:
> On Wed, Apr 03, 2024 at 07:10:17PM +0200, Klara Modin wrote:
>> With this patch/commit, one of my machines (older P4 Xeon, 32-bit only)
>> hangs on boot with CONFIG_RETHUNK=y / CONFIG_MITIGATION_RETHUNK=y.
> 
> Ok, this should fix it:
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Mon, 15 Apr 2024 18:15:43 +0200
> Subject: [PATCH] x86/retpolines: Enable the default thunk warning only on relevant configs
> 
> The using-default-thunk warning check makes sense only with
> configurations which actually enable the special return thunks.
> 
> Otherwise, it fires on unrelated 32-bit configs on which the special
> return thunks won't even work (they're 64-bit only) and, what is more,
> those configs even go off into the weeds when booting in the
> alternatives patching code, leading to a dead machine.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com
> Link: https://lore.kernel.org/r/20240413024956.488d474e@yea
> ---
>   arch/x86/lib/retpoline.S | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index e674ccf720b9..391059b2c6fb 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -382,8 +382,15 @@ SYM_FUNC_END(call_depth_return_thunk)
>   SYM_CODE_START(__x86_return_thunk)
>   	UNWIND_HINT_FUNC
>   	ANNOTATE_NOENDBR
> +#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> +    defined(CONFIG_MITIGATION_SRSO) || \
> +    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
>   	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
>   		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> +#else
> +	ANNOTATE_UNRET_SAFE
> +	ret
> +#endif
>   	int3
>   SYM_CODE_END(__x86_return_thunk)
>   EXPORT_SYMBOL(__x86_return_thunk)

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

