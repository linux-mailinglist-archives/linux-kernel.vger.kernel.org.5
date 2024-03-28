Return-Path: <linux-kernel+bounces-122351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070788F588
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA24DB224AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD262B9DE;
	Thu, 28 Mar 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLwigaMc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306482C6AA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594258; cv=none; b=sV7yOW3582qhlynowDWS46mvd4GhSeRJflb8RNEOfJ2XOhZosLygTJLF1mQCJiBP/CWvEhft+9fgRYqf5wf8ufiFsCI4nUmpB1wulrtBuh5sSD2ITaPIm0d3Mvc8CjEsHYhxZkFXGQFhyEy3My57aPqstZKk/76VSqDzxbCTy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594258; c=relaxed/simple;
	bh=6kiqhJKQshLo/BjwdEMSoc1e4fwgvGXzMhgJJcB1bNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jd6yGD403c2lcT2OYNY8iSN46a7j7mhIkxFrmn4tpWXjGkBJYEF6yZ2JzMZFFt+dweBdc1eGHxbPc+5eQ42bTWjDk2ESpF2seUdxdIBBk7i+FLGBUtttVBh97tJYnFS+t2lvEUTwUUxmDS8GnL6L12sHY+ZmVwMuhsb868eYRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLwigaMc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so639430276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711594256; x=1712199056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=seKwScTc9wqkrhGrgx5tr+y5GeB++CIZke1OsGxBUZc=;
        b=FLwigaMcsfUuCqo5xC/tWwHVh0IId4RtoR2lUSFapiZL5H1M0rFRVXgrsJdQTSn765
         yTSmvHtIsYv6W1lKvIs4HUN4F/V7xbLK2Mv4aQijvYcWDrOhrCDUdsDB8ZKC7ykHD/+R
         2leiLQjShNywaN/cU2hGuWRs2mWuOqRgGqJH3wTLfj3syxKdrXXUbZvYu5IxRYAuvKYV
         dn6Zqw0sadLat2zKM7xinfO4v2VkLtQoLkxeLahjZjP3EQ43U6OBZWa31AZZ4YJsxElW
         ycGyS46TQxc+v/X/EnqC3vHhRVTiQ+lIwaiSPWNZU67BjzRBC7hCdRnFbNtTvALMtsqL
         EWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711594256; x=1712199056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seKwScTc9wqkrhGrgx5tr+y5GeB++CIZke1OsGxBUZc=;
        b=mmrA6g7oK1e/1+Qj3KnTfgCmTf6gV5CuJo78VAILkUCk1PWXDj8+/V4UgNsuWlwj8b
         0dSkQSGpj8vLzdLJq9HLvFjaS5itsvrbKZlFchwhCfWK6KcD1kXY23+PHzV4Fb2UYIBT
         j4+QEwLJex+9FYAkS6OlJKaqkK0KepcWW0BHoh9ZAmhpci6Q+d11z9aIasCd8Lpb8N6r
         rlsrb39gROO5zICALrOHTjDGKvHmaQLXZ3HpeQ4vqZLLoxqSNTyhtk4RxAQwDlSWejfM
         Z60Wc4vfbCe0xv1oPiXDk6TKHrSE9lYspkmthuA66+PiRuvNwN3Oj8CQN1poaZrkg3kC
         6/xw==
X-Forwarded-Encrypted: i=1; AJvYcCWc20VguQGf0MbhrVMy1wbDGThDvLVBAx84d8vIfYROth2EUDlAeFa0kah4pCVu9k+T/oY3BwiDuj8tctMIAGOlw+iBmToGHBYdaNWs
X-Gm-Message-State: AOJu0YzWw39+/9ddeXfCiUaVcnj2B+rsQHmjYW01ZZ1H1FGEJt6Ix32p
	e7a2zZepjoaCjSMau+0SQPeQS0SJrl4DMIz7GoSIPPb5wLddY0YwhilSKFekSpgOHH6PnKWClAU
	kGy6wCj6rTvFNlSWxNr04ew==
X-Google-Smtp-Source: AGHT+IEO9/kWiBlfm+yWQ+WCwdKpSW8LEFVaawt8sTBofKxrZN8NZmXedY9jk9Xhy7bDK1Xf3oVmIhdKSvQRsIc+mA==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:160f:b0:dcc:79ab:e522 with
 SMTP id bw15-20020a056902160f00b00dcc79abe522mr160235ybb.11.1711594255835;
 Wed, 27 Mar 2024 19:50:55 -0700 (PDT)
Date: Thu, 28 Mar 2024 02:50:52 +0000
In-Reply-To: <20240314232637.2538648-16-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com> <20240314232637.2538648-16-seanjc@google.com>
Message-ID: <diqzcyrfkr1v.fsf@ctop-sg.c.googlers.com>
Subject: Re: [PATCH 15/18] KVM: selftests: Allocate x86's TSS at VM creation
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Allocate x86's per-VM TSS at creation of a non-barebones VM.  Like the
> GDT, the TSS is needed to actually run vCPUs, i.e. every non-barebones VM
> is all but guaranteed to allocate the TSS sooner or later.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 5cf845975f66..03b9387a1d2e 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -519,9 +519,6 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
>  				int selector)
>  {
> -	if (!vm->arch.tss)
> -		vm->arch.tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
> -
>  	memset(segp, 0, sizeof(*segp));
>  	segp->base = vm->arch.tss;
>  	segp->limit = 0x67;
> @@ -619,6 +616,8 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
>  	vm->arch.gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
>  	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
>  	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
> +	vm->arch.tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
> +
>  	/* Handlers have the same address in both address spaces.*/
>  	for (i = 0; i < NUM_INTERRUPTS; i++)
>  		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

