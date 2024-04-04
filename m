Return-Path: <linux-kernel+bounces-131671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47C898AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15831289C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAABF1D547;
	Thu,  4 Apr 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Glzqzh1P"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B3D272
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243157; cv=none; b=eyfV6JbpIcUUEBcl+9C6aA6AOvu9tAqFV/wV6wYLdFcwzAkA7z2w01RBKbmtUwpraiafgcraFxvTMmcNBra6sUZTyX+eoo3vZ46HQuc0LQHRCGfyQnmOLfMA5mZ4KU07/8S7kxurjJDjkpyTgo9GsPazF6ZeEkxdRuQ7Nq/kjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243157; c=relaxed/simple;
	bh=9pCwI5rLluyqtKsh2NShOZejLdkgTqnq8f0wSQ9Nb9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m8eSaQruiye+ZyTCG7KrAHQpyht/rPtlUF136hR/mJ+sil21j76nkZ2xW8cDvqD6a2hVSurK62GJKOVZ1G2cFE6NLrZ412Mv0zematChUxN3L4cxulof9alJHLaOmgx/l9wrm7ed+ldiC/GqfY4mP9mI6NLskCjrIJ7C4qn8LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Glzqzh1P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so1968325276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712243154; x=1712847954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUXSMqrAFeMZhzUDd522kajaYKlUc1pmVeNZWeTCyCk=;
        b=Glzqzh1PSwpinaoiw35fvGMKVNc/ejrJUbJ0TW5ou/ar5sm7NUSZBBOJZLmSwyG/wX
         q2TAn4EANDM8A6NLlkFnfFBitNNXoc8LHZ6f3u7czIXFRAbHQXHbh4gcyMO4jV7gdeyr
         A3ie/CF8NimS1rjcbPpwZRn4OwRFp4h9TuUeGXWovDIpzmaT0b8BPLc7s8W5ghGK4seH
         V9w4uxAMe73wsBKZgRtAQQCSi8+0ha/khlPoJNCfonMIqDtNeEVMXBl35kPmw4jA7VPs
         1eYFAE/J8xzwZDZmLSZNlwfX2tC1a7+PsD/t+cGGR/GW5UMcKz9BoluJQCyDipVbZfB9
         p61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712243154; x=1712847954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUXSMqrAFeMZhzUDd522kajaYKlUc1pmVeNZWeTCyCk=;
        b=c8VXRWYYWT9YSMsyp2m5YIeUJsLYlg43GyxtV7tKEs0ZCEtWx74YiHiUfHxI8aKUC8
         9Y/+kAECc9XmRyAS9nPNNvhns9gnQxKpQBhofsj0tzptkdFW6FyonZlAzIsXYlx6v03K
         /9bHMLeo36btzGaLGMLBq0/WQROLp4Wbgm/Q1IQNp8pVuqF4r5I2GTURTYAfqTtuIkCS
         IcMsIQPYnXN4ZNT4Ft6jmJYRI/iZqysUHicXVYTqpcNU0UN0uNRVA7I6lws+CV8lJ/ug
         UegLXbgJUFGqwrsoc1aXPfqiF+TMzEenX6EUlUxm/aFcyLCHP9YmS+bUkfx5AVwdHVLg
         gC4A==
X-Gm-Message-State: AOJu0Yzyzl0qhaSKjzm7AOHAjiB9J3xj1wdC6HMCoMspoLPdQfKEgJj1
	Utv1VcNo8DsLR3lD9z5w0V5zMiVa+d/vyKN6TvARC7/KWgMEjURQ5Meu7qrsPA+esdMMDitKQbz
	2eQ==
X-Google-Smtp-Source: AGHT+IHc0XI/w/DQGs36JwrzvGz3GFnwNtR/s0enRPkVbAxI/QW10yHMNjXC3YQLZZFA/t7SYTuV2ebO9c8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b83:b0:dc6:dfc6:4207 with SMTP id
 fj3-20020a0569022b8300b00dc6dfc64207mr702053ybb.10.1712243154484; Thu, 04 Apr
 2024 08:05:54 -0700 (PDT)
Date: Thu, 4 Apr 2024 08:05:52 -0700
In-Reply-To: <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com> <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
Message-ID: <Zg7B0JwJD6sfjVIY@google.com>
Subject: Re: [PATCH 4/4] x86/xen: Enumerate NX from CPUID directly
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de, 
	x86@kernel.org, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Dave Hansen wrote:
> +/*
> + * It is too early for boot_cpu_has() and friends to work.
> + * Use CPUID to directly enumerate NX support.
> + */
> +static inline void xen_configure_nx(void)
> +{
> +	bool nx_supported;
> +	u32 eax = 0;
> +
> +	get_cpuid_region_leaf(0x80000001, CPUID_EDX, &eax);
> +
> +	nx_supported = eax & (X86_FEATURE_NX & 31);

Heh, I wasn't looking to review this, but this is wrong, and the fly-by comment
I was going to make is relevant (and got really long once I started typing...).

X86_FEATURE_NX isn't a bit, it's bit position: (1*32+20) & 0x31 == 20.  I.e. the
code would actually need to be

	nx_supported = edx & BIT(X86_FEATURE_NX & 31);

The TL;DR version of comment I came to give, is that KVM has a lot of infrastructure
for manipulating raw CPUID values using X86_FEATURE_* flags, and that I think we
should seriously consider moving much of KVM's infrastructure to core x86. 

KVM has several macros for doing this sort of thing, and we solve the "way shorter
than any helper" conundrum is by pasting tokens, e.g.

	#define feature_bit(name)  __feature_bit(X86_FEATURE_##name)

which yields fairly readable code, e.g. this would be

	nx_supported = edx & feature_bit(NX);

and if you want to go really terse with a macro that is local to a .c file

	#define F feature_bit

though I doubt that's necessary outside of KVM (KVM has ~200 uses in a single
function that computes the support guest CPUID).

Grabbing feature_bit() directly from KVM would be cumbersome, as __feature_bit()
pulls in a _lot_ of dependencies that aren't strictly necessary.  But if you do
do want to add a generic macro, I definitely think it's worth moving KVM's stuff
to common code, because all of the dependencies are compile-time assertions to
guard against incorrect usage.  E.g. using the "& 31" trick on scattered flags
for raw CPUID will give the wrong result, because the bit position for scattered
flags doesn't match the bit position for hardware-defined CPUID.

But if we went a step further, KVM's code can also programatically generate the
inputs to CPUID.  x86_feature_cpuid() returns a cpuid_reg structure, which gives
the function, index, and register:

	struct cpuid_reg {
		u32 function;
		u32 index;
		int reg;
	};

E.g. if we move the KVM stuff to common code, we could have a helper like:

	static __always_inline bool x86_cpuid_has(unsigned int feature)
	{
		struct cpuid_reg cpuid = x86_feature_cpuid(feature);
		u32 val;

		if (!get_cpuid_region_leaf(cpuid.function, cpuid.reg, &val))
			return false;

		return val & __feature_bit(feature);
	}

and then the NX Xen code is more simply

	x86_configure_nx(x86_cpuid_has(X86_FEATURE_NX));

If we wanted to go really crazy, I bet we could figure out a way to use an
alternative-like implementation to automagically redirect boot_cpuid_has() to
a raw CPUID-based check if it's invoked before boot_cpu_data() is populated,
without increasing the code footprint.

