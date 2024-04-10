Return-Path: <linux-kernel+bounces-138605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3989F8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E408B2EB52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78715EFC7;
	Wed, 10 Apr 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2U5wc37"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634015EFA3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755819; cv=none; b=ifY4vdas2gNR+MVp371YZy8YwaJ9sPJ8D0m0uP5YtBK1r15N0CmtqvZF30K/wt5krnieD8lKXH3R30RkLUg1Ytl7TcFMxJ1ixtoya9Frjq1PEZkajDJNVds+pakOttGJgVSOTt6gNYkH/+OWjIP2P0iXIhIU3jwSM8h0zU26S7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755819; c=relaxed/simple;
	bh=bPjjFNOuVqj8uTs7HSVmg7oHVdZXttYF/pCsKDF4NiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX7GIawwQG9htEcIV66SCV4ICe/Qs+viPw4MbSUafKWhY6mttRWd8xkESf7SbcioYV1OGvyqN8LPbCtHwqn1DBLy/7K2BU5W7DbqYasyBrqL1fjIYCkaV1RVYRUEO0Ym+bw8+41AMKDojyqsFJEfeaa6sba14Ee52wpgSD9UtiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2U5wc37; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516dd07d373so3214194e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755815; x=1713360615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6huWT3pIf2LggD24RYO6XCPDGs7IwM/cm9Lv9S51+pc=;
        b=G2U5wc37MfXKlpyXItRqxOx9Y6nslVQ3S8kqQZlFVNdaS0vgiRGlGUeUaC/rcN/FiR
         XvsfcJRw63TV67aL8FuEtodTxEBrT97/LQCouGTQ+B2R6SPodEBPeEalWwW/4AZuDfaU
         Dox0FDxB+SRRzl/LdAzYkYosncsMKq0/B7vc5UJS7ASXNODRZSrr8bgBmpg2IaHAJe/H
         CovaGlk7EcggdBPYWmlNmgx9kA4bYZhJ1vSVFobsad3Tty0YViedtEeAj0nQR9+kDwFq
         sAIgytpGDSiwSdoCh/f7Yyfe1NM9jfsajgJ99UYS2IP69heghzBJt67An+Pwmy/EO826
         1F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755815; x=1713360615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6huWT3pIf2LggD24RYO6XCPDGs7IwM/cm9Lv9S51+pc=;
        b=HY+qrKko75AV05kS9FS9BSaK2IRSfOk2hS80ydEbORHOTlRmpyIN7WETGZyFm7w14P
         N+EpbpEkExM9OG5ok8VzZyRQsAKNtMGEzO/lHJu5sEMS54hr/YXYZ2PsloeW8XZYjCVt
         CHp/OVmDqCIzYThvk6kP3MztVmZebIFq0BQJi5FMfRxQP9EcxpzuqGZvUPfsl4DkA9b6
         MRgy65VHkXnz+6OZnESk5yBmCFPFltBMFU9CNzPnvBLEWLkO3/wc1g3JeerFIbBlcJUL
         a9FwpbHVLG0LndyPC28fviBUTY7l5O1Qv4pb576n6JHZI4XclPJjDwOZzZFZlTwo+82J
         FgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJIJEyG8CJi8bEbbCcsgmLKijupePZTRvfEfHxil4EG5UhKrZHD89HPk5w1KFs8cZewJ75Q4OtcZbrzqdKjwgeFnGzP0uiyXxNRXwJ
X-Gm-Message-State: AOJu0YwToD0VqKOozkSuJVmSpUzjlnweLbKxpPGSfRCxlScg1cMkbIx1
	Dbabh7XJN6DT2C/EnQYDWjfhE8pMhaS1SrG4DNEgwpmg7yB1Xppw
X-Google-Smtp-Source: AGHT+IGdMEkTcnCwwLp9NweuLi3rHBrnXqxoZtVHGn23tRdfHE++3CUoyuU1cgBxItKyluZnNWoTHg==
X-Received: by 2002:ac2:548e:0:b0:516:c8cb:6642 with SMTP id t14-20020ac2548e000000b00516c8cb6642mr1515786lfk.19.1712755814923;
        Wed, 10 Apr 2024 06:30:14 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7d452000000b0056e247de8e3sm6444905edr.1.2024.04.10.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:30:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 15:30:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] x86/smpboot: Add map vars allocation check in
 smp_prepare_cpus_common
Message-ID: <ZhaUZFY5MUyy6hWK@gmail.com>
References: <20240409182940.664482-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409182940.664482-1-kiryushin@ancud.ru>


* Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> As of now, zalloc_cpumask_var for various maps in smp_prepare_cpus_common
> is not checked.
> 
> If allocation fails, it will not be known, unless the not-allocated map
> will be accessed. The situation seems not very realistic now, but could
> get more relevant in the future, as number of cores (and amount of
> allocated resources) grows.
> 
> Add a cumulative status for all zalloc_cpumask_var() calls in
> smp_prepare_cpus_common() and error message in case the status signals
> that any of the map var allocations failed (per cpu).
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>  arch/x86/kernel/smpboot.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 76bb65045c64..3b24c2e1fa3b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1042,11 +1042,16 @@ void __init smp_prepare_cpus_common(void)
>  	}
>  
>  	for_each_possible_cpu(i) {
> -		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
> +		bool ret = true;
> +
> +		ret &= zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
> +		ret &= zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
> +		ret &= zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
> +		ret &= zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
> +		ret &= zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
> +
> +		if (!ret)
> +			pr_err("Failed to allocate map for CPU%u\n", i);

So:

 - That doesn't really solve anything, nor does it propagate the error 
   further up. Plus memory allocation failures within __init functions for 
   key CPU data structures are invariably fatal. While there might be
   more cores in the future - but there will be even more RAM. This error 
   condition will never be realistic.

 - The canonical arch behavior for __init functions is to return -ENOMEM 
   and not printk anything. But that's not really an option for 
   smp_prepare_cpus_common(), which feeds back into the 
   ::smp_prepare_cpus() callback that doesn't really expect failure either.

My suggestion would be to simply pass in __GFP_NOFAIL to document that 
there's no reasonable allocation failure policy here. That's better than 
needlessly complicating this code.

Also note that this code has changed in the latest x86 tree (tip:master).

Thanks,

	Ingo

