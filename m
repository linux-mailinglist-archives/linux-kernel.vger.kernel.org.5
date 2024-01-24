Return-Path: <linux-kernel+bounces-37337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA183AE78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52768B2AF12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BA7E573;
	Wed, 24 Jan 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TN1vD+8M"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D04695
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113941; cv=none; b=V1RMxpNQBkFfHloKsnk47lO2sO1T1rRihkqIHevlU83eBaFZiRIHpFf2YXh+P5LfOAA/KsK8bGvfSotTMq9NhpBbUO1+a51yuhji9QyzMRxx20SfM8S07FDWsAbBEph2HDWLmL8gFCIN/9qQnqq9Y7R1PET3HIep4+F44w+NA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113941; c=relaxed/simple;
	bh=+zqCmFWMLWHr8Gkc0x56tIkqc6LdU6Qb3vc+IyEL5iA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZ+TgbpeGjaMd/4DcDRBYKT/v3iOQz30O2JrMxzrk9AcBiEI3VBJ84puLt9eGmlC7pxYozR+KpA5CQ3oasioj9VUOzIUIIppcjfRj+pDt3qJ/EGeWSwK61+MNdFNDU32xeSzPAOvbzJ/+/d9taKfTi5oIocTXlwTD1k7Q61aCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TN1vD+8M; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso8289849276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706113938; x=1706718738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g82foanF1CJTmaDLSQP4Ghn9FVcWHiz28lTGASp7l48=;
        b=TN1vD+8MPZC6fnYjgQZlBEbZ3eBtbBn096XKshKSkcci03jMpdy4KMMGHZ+mOQy7BL
         29RXIlgX0bA03ia5Hm6chxI2PrQ7NqtXKfO8k0a3zXn10ZKmsEmqmpuq/dxTj6nTnP4Y
         RePx1/3ZJEaAQNlbLh/lv5FgDi/VdCEYhk8r9pHM4zmZ+CytG6DTc1b51n9jZlIjrb6L
         96RokG7ut7qBNGHmyLD6m2GDLILecD41NWgASmVeuhmlOvxWUisXhq+4DjZ89sB+6RqW
         Ur6AbzijwYqNzzgGD2vG+jBfMewBXy1L5A6EKtQBBjtHaMusxWsSf0cXxGu0icuR/fty
         UbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113938; x=1706718738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g82foanF1CJTmaDLSQP4Ghn9FVcWHiz28lTGASp7l48=;
        b=Db4uIKgjhEvm0hIflW7RNP23I/6jsXStDjnRz4LCZtqhn4ywVgx7NdThiD1zaTSzug
         yLHHysMeZW/ZvnXnOSM+m9/T4+t6u+mX8iiHkBdZCJ7rTyXzESxy4IwieboYHFsaZwH6
         cDBBCTnSHyKcoM1xS6/WhcXAf+2NQN94EEnYc9DqhsgL8GciKwvvtSBT8gPgY0GZJKlr
         hi69jBOXZx4dgb5eegMduanF9Fu2HlL/IJTjQ6HIJzhsmg1ij4fTfCBlpjR3nAY1FULy
         55MIIs3JcaVsmpJ9gsLVqA7GuQ1aGWhIWYvpxGwwlRFVqpAlT/SL/YdHDR8diBMpYNdm
         oIwg==
X-Gm-Message-State: AOJu0Yzj17KmzPE/o0l0x9hqS/8l2BXb2m03krPVDFj+0plPnalS9pym
	KO6XQcALtQQNgG+lLDLUDb3LgDdYJ7yV4gQAYQqNglSVBGGaFpr1Vo3M0MhuuFRtSFGEnFgE7YC
	/GA==
X-Google-Smtp-Source: AGHT+IGm+X2BYZPWf+ByTxMEw+p1Jyx19F3jDSILRZ/fuxnNRR0npnBrb0S8PZ9zL6t3gEdep8RITYwr6nI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:989:b0:dc2:2f33:bc28 with SMTP id
 bv9-20020a056902098900b00dc22f33bc28mr453003ybb.6.1706113938754; Wed, 24 Jan
 2024 08:32:18 -0800 (PST)
Date: Wed, 24 Jan 2024 08:32:17 -0800
In-Reply-To: <20240124160248.3077-1-moehanabichan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124160248.3077-1-moehanabichan@gmail.com>
Message-ID: <ZbE7kd9W8csPRjvU@google.com>
Subject: Re: [PATCH] KVM: x86: Check irqchip mode before create PIT
From: Sean Christopherson <seanjc@google.com>
To: Brilliant Hanabi <moehanabichan@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 25, 2024, Brilliant Hanabi wrote:
> As the kvm api(https://docs.kernel.org/virt/kvm/api.html) reads,
> KVM_CREATE_PIT2 call is only valid after enabling in-kernel irqchip
> support via KVM_CREATE_IRQCHIP.
> 
> Without this check, I can create PIT first and enable irqchip-split
> then, which may cause the PIT invalid because of lacking of in-kernel
> PIC to inject the interrupt.

Does this cause actual problems beyond the PIT not working for the guest?  E.g.
does it put the host kernel at risk?  If the only problem is that the PIT doesn't
work as expected, I'm tempted to tweak the docs to say that KVM's PIT emulation
won't work without an in-kernel I/O APIC.  Rejecting the ioctl could theoertically
break misconfigured setups that happen to work, e.g. because the guest never uses
the PIT.

> Signed-off-by: Brilliant Hanabi <moehanabichan@gmail.com>
> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 27e23714e960..3edc8478310f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7016,6 +7016,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = -EEXIST;
>  		if (kvm->arch.vpit)
>  			goto create_pit_unlock;
> +		if (!pic_in_kernel(kvm))
> +			goto create_pit_unlock;

-EEXIST is not an appropriate errno.

>  		r = -ENOMEM;
>  		kvm->arch.vpit = kvm_create_pit(kvm, u.pit_config.flags);
>  		if (kvm->arch.vpit)
> -- 
> 2.39.3
> 

