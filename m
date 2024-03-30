Return-Path: <linux-kernel+bounces-125890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF69892D75
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05B9B223A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094233062;
	Sat, 30 Mar 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYp7vNrP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3E43144;
	Sat, 30 Mar 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833089; cv=none; b=Fc4WTDiN3fafyRFs4xubbxt2hTvFHTPjZbEo8aMhrIA67SjR200TI+09y7xLxICqzb9vXl2/ZX0WTtFXr6kGuGjj3HINgYSdEfLxPod6TgyHXyf/rlUvg0IDgvhvcPU8nHr14vzG+KXDMW9G6J1y25n4q5wnEZI4wiB8AbtqjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833089; c=relaxed/simple;
	bh=CHcXrxf2ENpQddGykj9rk3TKmc0vJHsnIQfhoa/d1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDGMJgbw7uUTNcNvsRUJHkbGwVXrjcm3akhXq1A1xoQNkEifMCRhpiMmmub9EPrq13C8sxRMXBErgJmUM0GU0cBb/YBWPwpbxFyzuiH/h/wTXcvMaBA24NVXRdhh5PpfjDUCGCrsKkdWI7upcjSWjNPgz0Ch36q1dTsXZKzcFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYp7vNrP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c0bd07e7bso3198910a12.1;
        Sat, 30 Mar 2024 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711833086; x=1712437886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FfCXTwbIMZ0/LT2fPdhGW3nMXxEswf6TerbPzBdQ6o=;
        b=nYp7vNrP4H6zxpt+VWqWiLxFuhvnUn9PhikSF+Qd+wu/XbGaVHX+zgk5bAK2paJCSY
         dOdYpNkm1AGS4d4Tpho22pJoWmOvKkkNJ5PXVoegiClRps/KLCCUok8FUJdMXDRT1zbb
         nGQrMRIa0FETxYrGP9bDwXl83ukC1B+wCFduUhI/1eauVrH3GO/ggMZOoCrafy4o+M/7
         REV38wFjl/6dBlMO8VgS6gDdl0071CQ4SclNRbbZtS+7plD2Gc8srVdXLBU16VXRUKpV
         gk4FQ5689wtStLlKlsCA7TYk6g2zMKkyWMIj0b8qV/wMpGOD21rizhMCm/30pajQuh/r
         H6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833086; x=1712437886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FfCXTwbIMZ0/LT2fPdhGW3nMXxEswf6TerbPzBdQ6o=;
        b=SsP4hsVgfU+L7txdZ6IfDh/h4AGfKCJ67EXJ92vTdC74U0DlwicS2r+Ol5wC7X1oDc
         r0qq/3HSSuxToUoqwMC0gbVHgW5qYIbfxMsoVQ4WyfRh+77cLCW0HpeoaJJIIwoHG+Cr
         zkDCNjQIiOCg/+xJ5MMDECCAjfRIcRaXQNZWAKxxceyFelMBtexh+8mI/xQXeiDWBNgH
         ohG1hruVb++72ckz2XGmtE4OdUr5QpTh1tVEQF5FvHTV1WYcLJqi3kCrO2GQO6/8OBVW
         07pZ+xwl2xrVFuuPND7kJfDaUXz+z/HQOXeAUJr39IJ4BRCp7i/OnSLiQsFEIKRk1D5o
         cNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnBrSOYtl/MJ1PE+Gp6dEqlXYvZ+pQ4g0fNTuOdWvHWI2P/o1emDoRT5a1PSoNCVHHTLKI7/4BTM85IQVAOeLeCG0R37cuOmu1nl1wwRQqkQ0dVUL63Rzu76YEwID/ekSEa4LICkuw0Y5k6ORSchQRcOs8iXGHXX+GSdMw1+G/iNrnss0w6X9QIdWGwuZ2mg==
X-Gm-Message-State: AOJu0YxW7mTqLTZN2dMZLnw7G8df9ZtDhAqUzePPbK18LkJ8d45kSIPG
	F5Bm8gHx7QRnNlOW7iMzgya9p1Q/vjgerVUVouDPVXsZVQy4lUU3
X-Google-Smtp-Source: AGHT+IF9fQng7glW1xiinlWjLAuPQJtBuNkRL7PDVj0cI0LwYsHs5I0gGvhlMWzwySRIuCzhsGUoUA==
X-Received: by 2002:a17:907:78d7:b0:a4e:5a23:24d with SMTP id kv23-20020a17090778d700b00a4e5a23024dmr470387ejc.38.1711833085563;
        Sat, 30 Mar 2024 14:11:25 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id xc4-20020a170907074400b00a4e5ab88803sm314414ejb.183.2024.03.30.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:11:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 22:11:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86/amd/uncore: Use kcalloc*() instead of
 kzalloc*()
Message-ID: <Zgh/+xSyOil37H1F@gmail.com>
References: <AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>


* Erick Archer <erick.archer@outlook.com> wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc*() function instead of the argument
> size * count in the kzalloc*() function.
> 
> [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Link: https://github.com/KSPP/linux/issues/162
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com/
> 
> Hi everyone,
> 
> This patch seems to be lost. Gustavo reviewed it on January 16, 2024
> but the patch has not been applied since.
> 
> Thanks,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4ccb8fa483e6..61c0a2114183 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  				goto fail;
>  
>  			curr->cpu = cpu;
> -			curr->events = kzalloc_node(sizeof(*curr->events) *
> -						    pmu->num_counters,
> +			curr->events = kcalloc_node(pmu->num_counters,
> +						    sizeof(*curr->events),
>  						    GFP_KERNEL, node);
>  			if (!curr->events) {
>  				kfree(curr);
> @@ -928,7 +928,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  		uncore->num_pmus += group_num_pmus[gid];
>  	}
>  
> -	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
> +	uncore->pmus = kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
>  			       GFP_KERNEL);
>  	if (!uncore->pmus) {
>  		uncore->num_pmus = 0;

This change is nonsense, kzalloc() is a perfectly usable interface, and 
none of the arguments are user-controlled, so I don't see how there 
could be a real overflow bug here.

Thanks,

	Ingo

