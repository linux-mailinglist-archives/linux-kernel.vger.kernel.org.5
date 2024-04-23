Return-Path: <linux-kernel+bounces-155434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1BB8AEA77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5691F23193
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF85820E;
	Tue, 23 Apr 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J9u1MPcJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA375136E1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885298; cv=none; b=fZSQ0IWUuc6ejlq2nmZcshz7+g8yrg6BEcDIRccmGmR88MYqCHjgY03lrMgFfD9H0jaTEvIbQYv7sRyzkwgy7mQmc0GsdnvVYqG7bksSKg0gp93DlBiA8vL8/EgCDvVvYtyB+gJxU3r+9C7+2vx31+VkfSuEFlq+puAvfHqI0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885298; c=relaxed/simple;
	bh=a5cD2LaaptC8wxD989v/1J0kMmeKcCSfjFsf7Y0J2sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k76CNpBpu6yO0nf3VQc96Ucp220Os0TKEFRpDVkR7/jcE+C0k08+qdiEUqWnTacQyu6ejxRBoqyfhiTSamH5T5xVWxSH8H67/BWWBFxzvh0797PYw8KIc16kwvWCUvNxkOShnRcScbu0rgc38Zy4cWYnVhLo4HkudqKU/5ZzXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J9u1MPcJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso8729298e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713885294; x=1714490094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zF9sVBcXt3p+LHo6Ft4b30wlVpGZC//wb02folK/K8=;
        b=J9u1MPcJPHT4dqSrXs9JbKZQOQPoeKh8fZhf6X/xPGM6EC4GoPa5mPsAVtR0dJ9V8Z
         ndgB/rntHyKyzRtWG9WbHwmcqIisFZlBzJEx8wBNrjgECM8PsqWXxOixqqulZxix6C31
         c5wWtxooo67YWl6eF5zsKPCDRk551DkmwsqfBrX7LL0iHIH0moGcXYt69vehaVbrY2aY
         Sm9P4AvxFFBJFsLnubzucGRLHGwOEF7fwhX17DNqKYrlWdPkjqzQJ+br2cbITA1LWUbz
         FGRdmvjbfTCpHJEI1zWheelIS5Lb+BWqCyjGkBdQ8ukCjacEYsEgZpENTBGTh+CSRiDP
         RChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885294; x=1714490094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zF9sVBcXt3p+LHo6Ft4b30wlVpGZC//wb02folK/K8=;
        b=QstFWtAkN+QZ2Q9TRZXDK+LKTJC7C6sqBDtzgqBWCHWh6h2UMJNfIC8CT0YufcDLot
         l7eV56fqy8oDFVfichBFzQpP7Sq7dEL0WTaOTs17bDyHUUKLN+a1FM3KJInZHNZj6+X+
         XIQzMzzdmy6wBusUMMxAkgc80EXX12Oim88M4tc/Q+5int8tP8uVilSOOzI5wXbLCsku
         YeeyOJZpTf9/oGgPLL2FOvB9h7FZj0uDw1B6HhYVvgszuKQIDyhGAULX4+Nfwm+6U/ow
         xWc0NyD/VR8XLbZaw1fCLwAVsN1b293TgXAkPc+nWhiPWV3uYJr4/EoqzvoTaxkhcnLO
         UwVw==
X-Forwarded-Encrypted: i=1; AJvYcCXuj2+FMgbQB+Hcw50AnXjSlQuD1hbSnhCeQ5x6Jzehac0RVI69Mz69Z/0KZkYkTxxHdpVOCJOF2mN1Vh1bsUIu3wt09/+0rluwUbb1
X-Gm-Message-State: AOJu0Yy44u25Lk8OIkNdCVM5pKIGQifxUjKXgY++vWQm/O5zT82l3KGk
	G+17DLnSB7B+02VE+E8f4eGE8MayNLPSWEqWb+HsGcgwZFsXihaa8DEKnKc5aH0=
X-Google-Smtp-Source: AGHT+IF1/35Nlkwm9xUrkG3SYoD/oQBvgVGLdQGrEiz/Yiw++BMQpMgPiC/tA6FalJ2ScXPHHIEd6A==
X-Received: by 2002:a05:6512:483:b0:518:e7ed:3c7c with SMTP id v3-20020a056512048300b00518e7ed3c7cmr10661458lfq.14.1713885293863;
        Tue, 23 Apr 2024 08:14:53 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709067c4a00b00a4e5866448bsm7115652ejp.155.2024.04.23.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:14:53 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:14:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Anup Patel <anup@brainfault.org>, Thomas Huth <thuth@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
Message-ID: <20240423-0db9024011213dcffe815c5c@orel>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
 <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
 <ZifMAWn32tZBQHs0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZifMAWn32tZBQHs0@google.com>

On Tue, Apr 23, 2024 at 07:56:01AM -0700, Sean Christopherson wrote:
> +others
> 
> On Tue, Apr 23, 2024, Markus Elfring wrote:
> > …
> > > This patch will add the malloc failure checking
> > …
> > 
> > * Please use a corresponding imperative wording for the change description.
> > 
> > * Would you like to add the tag “Fixes” accordingly?
> 
> Nah, don't bother with Fixes.  OOM will cause the test to fail regardless, the
> fact that it gets an assert instead a NULL pointer deref is nice to have, but by
> no means does it fix a bug.
> 
> > > +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> > > @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
> > >  	const int state_sz = sizeof(struct kvm_nested_state) + getpagesize();
> > >  	struct kvm_nested_state *state =
> > >  		(struct kvm_nested_state *)malloc(state_sz);
> > > +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
> > …
> > 
> > Can “errno” be relevant for the error message construction?
> 
> Probably not, but there's also no reason to assume ENOMEM.  TEST_ASSERT() spits
> out the actual errno, and we can just say something like "malloc() failed for
> blah blah blah".  
> 
> But rather than keeping playing whack-a-mole, what if we add macros to perform
> allocations and assert on the result?  I have zero interest in chasing down all
> of the "unsafe" allocations, and odds are very good that we'll collectively fail
> to enforce checking on new code.
> 
> E.g. something like (obviously won't compile, just for demonstration purposes)
> 
> #define kvm_malloc(x)
> ({
> 	void *__ret;
> 
> 	__ret  = malloc(x);
> 	TEST_ASSERT(__ret, "Failed malloc(" #x ")\n");
> 	__ret;
> })
> 
> #define kvm_calloc(x, y)
> ({
> 	void *__ret;
> 
> 	__ret  = calloc(x, y);
> 	TEST_ASSERT(__ret, "Failed calloc(" #x ", " #y ")\n");
> 	__ret;
> })

Sounds good to me, but I'd call them test_malloc, test_calloc, etc. and
put them in include/test_util.h

Thanks,
drew

