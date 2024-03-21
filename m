Return-Path: <linux-kernel+bounces-110586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408A28860F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E99284BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511A134402;
	Thu, 21 Mar 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8uXhGgB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D1133994
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049208; cv=none; b=lfBHCA9u9EmZMfko2l/DvqwI6eLxYc8zVqZ66oSoo/jv5ci8btvN3WeDvBik4IMNIt7LerzWdt35yAKPuvJ5S5eoSzC/Bu55JqhvRH6VodwDJCPhXzOo9aBctBCkMwTWAfYib/gISOxEF2VgZc3TD/SUHWxA6V51rK0pQj6d4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049208; c=relaxed/simple;
	bh=sx5ON9pMeTTSZ6CZ4IkGsUxPUCNhak7rtQyRB7P3Qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtvRjTC9uLBG64lYu7m9wwTZi33z5c/KWioHA7pfNnqf7WuFLXX3rscPjJzcn9aaJ+JnuXJAFeI9+8Wq9KGmDkYjDvKo65r0nllbv2AVo28OzHomu/OOL4Kk9BHvS2oe2VbKuBL84ItolV6bIC+R75mk53bgoglgYsvbji923Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8uXhGgB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4146562a839so9497375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049205; x=1711654005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc3IyT9/nOYDM1xCe3KQXQuTa8RBuyRI2nTt5FngkWY=;
        b=e8uXhGgB19RHrNIYW6w+oNT90vk7PQFetbCQs6KjK2q9cp+j1a2ul3ThnKNu5us1Mx
         ETbvjmGauTtYzX+QGmLdf0muuO3RwTwWyxekxCvA0yxxE8wHTCAFHNVEn4lZoaxdwygN
         dERM3eLV4uLk8rkARwSCGJab93/uRUS+iBZZOLCXckAvvrjrp0onKO+8au20yFRVzWqt
         1WK4+age/R8d9E0W+KF8aYxjcme3tpQMrMeEB2LvQweDUu+3vTnjc5GqOkuW5Jhk6dti
         F9uqyKp2Yg1qLXx/5v5AxlEm5h6QdofV1EeK8qZ5wn1oN9L99IPTtgCoxkKsakj3gL0g
         oiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049205; x=1711654005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc3IyT9/nOYDM1xCe3KQXQuTa8RBuyRI2nTt5FngkWY=;
        b=f4m3ictLwvBkpMjkBAIEpQCMpIhq4j8KkQ4kSEuyeQdOvPzqu4+hnaFS+0POLJ+/3m
         HU4CYUXDC6gnCd72E+0rE5oH/oipqe1bfchfaOX86KcKOBjRb824sWWJW7kV+Te6UvTQ
         /wdsoN+/CvW2LPNyRT6Zi2elW0CKskGuN3T48ZywrkXiKxcZD/iqBM4ixg8tHpkzxARN
         1PpYY02r2siNUHJsiqyXDVzMS1D65W+JrMlb6QW3y/aq7j1ctbFnTQtrZ8O3CY6xoj0C
         dhSnG3UD670aMbBxN9QyF+nCCqrhmo3AHQbsBhOQc2u93Xj9U4wjS0AllMWI+kuYpcbb
         bsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiwT+s3jMKFDI01FSlHZahTvXYGHazM4lz1d5n0tLNeDvWqPYiLfSWWL3cD10N4thYq3THqPDAH0Q/HiZ59Fa7WwbtRzDN1ozM7tUT
X-Gm-Message-State: AOJu0YzGFEeqGPo/YB0WJDdDuqrUt16HJrErabB1ywob3YSUmpsRI58Z
	JfjCRLEpzdP6WbOUttoCRE2JVatcTerPWrmX7degmxz+ueniZ68swLGgNgtOWC0=
X-Google-Smtp-Source: AGHT+IEkxQnGQvuOsKmtCS2xGwIqpVLPEDHOw5WawYKlev2hYh5B3vJwvVZGhlWlM3L/sDR0c9r7Og==
X-Received: by 2002:a05:600c:45ca:b0:413:133c:b9c8 with SMTP id s10-20020a05600c45ca00b00413133cb9c8mr62933wmo.33.1711049204991;
        Thu, 21 Mar 2024 12:26:44 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b004140837a0d4sm680841wmq.3.2024.03.21.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:26:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 21 Mar 2024 20:26:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 2/2] x86/CPU/AMD: Improve the erratum 1386 workaround
Message-ID: <ZfyJ8sObTIvwm17B@gmail.com>
References: <20240321120548.22687-1-bp@alien8.de>
 <20240321120548.22687-2-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321120548.22687-2-bp@alien8.de>


* Borislav Petkov <bp@alien8.de> wrote:

> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Disable XSAVES only on machines which haven't loaded the microcode
> revision containing the erratum fix.
> 
> This will come in handy when running archaic OSes as guests. OSes whose
> brilliant programmers thought that CPUID is overrated and one should not
> query it but use features directly, ala shoot first, ask questions
> later... but only if you're alive after the shooting.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 6d8677e80ddb..c02b07feff6e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -15,6 +15,7 @@
>  #include <asm/cpu.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/smp.h>
> +#include <asm/microcode.h>
>  #include <asm/numa.h>
>  #include <asm/pci-direct.h>
>  #include <asm/delay.h>
> @@ -804,6 +805,16 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
>  
>  static void fix_erratum_1386(struct cpuinfo_x86 *c)
>  {
> +	u8 fam, model, stpng, rev;
> +	union zen_patch_rev p;
> +
> +	p.ucode_rev = c->microcode;
> +
> +	fam   = p.ext_fam + 0xf;
> +	model = p.ext_model << 4 | p.model;
> +	stpng = p.stepping;

Please make this 'stepping' - we don't have a single 'stpng' variable name 
in the kernel currently, and that's very good so.

Thanks,

	Ingo

