Return-Path: <linux-kernel+bounces-133018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B0899D80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D6D1C21E93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB516D305;
	Fri,  5 Apr 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LygshMJa"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA316D304
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321300; cv=none; b=H8jnzprNZiX+F6yAaHJvPBJ3AOCGJHXkEQIwjtF3BYdn1HSYOKgxFq8urj28M4+zX5ubrVfb6ZsmFZ8IAP8J6ID651K6CZO0LZdK4PDrdVESqoBpVxip6VV/Ly9NsKtb/Z6/xwQ+13BqW/b1lnsgwAT94JkET6qHrvaePEBRQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321300; c=relaxed/simple;
	bh=BONgaXjClX5aEfbEB3Q+2CYsd4fxx1TEbZSRiK4eotQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvoAZFPtfgKKAEQL84f6WkJDYPprUwnJCtu1x46GE+p6jcTimuGv6N0TzbNLVEe1SuVLi7i8DSnmIFzWxqFRaMj8cDke9wPfBynvKUC4YM0/XjsY/wT6FF4mMRCBjyJy+NX1InyhlnwtkT/8QZAOS/xaUbObSSHsrfIcSNeHZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LygshMJa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6e23253so308729e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712321296; x=1712926096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gqJXCFhYHxuGeDzQHXUm6mF/uMGESwP7Rig2uzwTrg=;
        b=LygshMJaABTCZqCx6+P+EmHvxM1yc6UNRUC35sQIxhDLEK/gGW6rcPXZ5InNIIx3Np
         jC/H9uymGWyvnBTFyB8R0++8ryBQTNLNWC8lqG30PBaVSTY87HgfH6m5O+87MVxjPljP
         UefsPmHYAnaf8gUlgS0eb9cVbhV6aOi7xnjUOPIFpHmesGHunlIBrIeEmZgX6mh/irAK
         r2UWBke4zqMLOyBrYxa2RPTJp09A1V61NL8skX9o/VGlbyN9pcFqg+dxP4q85K338sDr
         geyJZAre8QylqwSQG22OIRtAHQGfpgADRGuNYid6Nep76eSn5T3nlaNvjSRwqf/2gtoo
         wcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321296; x=1712926096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gqJXCFhYHxuGeDzQHXUm6mF/uMGESwP7Rig2uzwTrg=;
        b=JjhxlM/vb3cb/ZxM3WvdgJ52jVvxblEYskZ3bLW3tLNllCazfPY75Ru59d75li/a/7
         th2gqZaENgONfDQj4WbMUVzDq67M6zIENI2YcC6d1jpqVyrITRLniBrccOJ0UlWeVJus
         XxT281DFErdHa044QiNcIvNr+RodeqrCmdJaUrrYKK9qErmI08j2tXONHxF7713CgPlk
         dE4v265aVt6OCELRQxSCWDGowWyAlcvo1jJKRjQXTd2FoeFMBbGqGU0yLFQdwh/6PQ9l
         /2GfDYdaLcc7KVRJaAcMYEOi/9b4C5alb2Fux2tkU5WwAVUZWhmRkfdNhF8U5Yt9Zm/3
         0yhw==
X-Forwarded-Encrypted: i=1; AJvYcCWVuSLq+mB/nSHuai3EfJmQpK/2E5/SpnMUitx1ZhlwZdrDW4X770Ct2QruNy9kuBGMTzQhq4zcyiw16Xe9UjjWQxuzCBIdSfUEF/lO
X-Gm-Message-State: AOJu0YwpBL+ZpEmXaL7O9mPRh8O6tI04Yv8J5VzLglyEwF39pJRN2T85
	wHmpS1i+Q9ZzFoxiMeY41aMhK1YrZAHm5ELTtbiCeUjAhCcY2JhVGo+Nk+8kMa4=
X-Google-Smtp-Source: AGHT+IFEgm+u9cR3VSBSNQtYk5knjRxPrUMvf+kSAsf2mgyfdrQjMfXWeVpxY5HnY8fvu518V/oPuQ==
X-Received: by 2002:ac2:446d:0:b0:513:eeaa:8f1f with SMTP id y13-20020ac2446d000000b00513eeaa8f1fmr1128144lfl.47.1712321296604;
        Fri, 05 Apr 2024 05:48:16 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7c694000000b0056c56d18d07sm761088edq.48.2024.04.05.05.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:48:16 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:48:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 13/15] KVM: riscv: selftests: Add SBI PMU selftest
Message-ID: <20240405-3242460b23ce1daf905242df@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-14-atishp@rivosinc.com>
 <20240302-ed6c516829dc0ed616f39a45@orel>
 <CAOnJCUK2D6-zP4=DiXRMeFQsMc9iG5nWY-yYHMhg83h_q+OtnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUK2D6-zP4=DiXRMeFQsMc9iG5nWY-yYHMhg83h_q+OtnQ@mail.gmail.com>

On Tue, Apr 02, 2024 at 01:34:54AM -0700, Atish Patra wrote:
..
> > > +static void guest_illegal_exception_handler(struct ex_regs *regs)
> > > +{
> > > +     __GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
> > > +                    "Unexpected exception handler %lx\n", regs->cause);
> >
> > Shouldn't we be reporting somehow that we were here? We seem to be using
> > this handler to skip instructions which don't work, which is fine, if
> > we have some knowledge we skipped them and then do something else.
> > Otherwise I don't understand.
> >
> 
> This is only used in test_vm_basic_test to validate that the guest
> will get an illegal
> exception if they try to access without configuring first.

Yeah, that's good. I just don't see how we know we were ever here. We
either got the exception and then stepped over the CSR read or we did
the CSR read. Either way, the test progresses the same. Shouldn't this
induce a test skip or something instead?

> > > +
> > > +     counter_value_post = read_counter(counter, ctrinfo_arr[counter]);
> > > +     __GUEST_ASSERT(counter_value_post > counter_value_pre,
> > > +                    "counter_value_post %lx counter_value_pre %lx\n",
> > > +                    counter_value_post, counter_value_pre);
> > > +
> > > +     /* Now set the initial value and compare */
> > > +     start_counter(counter, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_init_value);
> >
> > We should try to confirm that we reset the counter, otherwise the check
> > below only proves that the value we read is greater than 100, which it
> > is possible even if the reset doesn't work.
> >
> 
> Hmm. There is no way to just update the counter value without starting
> it. Reading it without stopping is not reliable.
> Maybe we can do this.
> 
> 1. Reset it to 100. Stop it immediately after and read it. Let's say
> the value is X
> 2. Now reset it to counter  X + 1000.
> 3. Do the validation with the above reset value in #2.
> 
> Wdyt ?

OK

Thanks,
drew

