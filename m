Return-Path: <linux-kernel+bounces-99230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8E87854E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26291C21064
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA463604C5;
	Mon, 11 Mar 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZi3DRy2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3855C13
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174007; cv=none; b=VLMvR7ThM59NOPKoh9+TwpOFgv/7SY6SD3QSW78Fv2SH/wrou7P2JjhswM2Ftf9T1X13r5KTre8d9TrEFMnPIJ3tBD9JjGokhMuUEnswYxfUecBTqD2k4xy8i6RY53j89kl+yXCEOXEpBFld395t3JVE00uCtYl+BQ5N7XTueMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174007; c=relaxed/simple;
	bh=XqrW57kewSATiu8nwXh6JUfzDnbXUzc3KuEeWvN10OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHQRz0H/1I4A7v9p/HvXQWtkjcjwefjwLhkiZ65/BsZRmSutg7ET1EodNP6nWqSU95hOPrs3YyGDIZQc2BPLOkNbqE7lhu6NcI2dErTTJQWFzL2iSZsZKBWonolVRjhyY/yAmYqOV9U3hFd1s8jQLTnuD7tLEeajjsraD8n0NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZi3DRy2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0694df25so28520337b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710174004; x=1710778804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWczKAWQT0mbMSpf1iuFE4nPkXsyl42XdLdakB0fL8Y=;
        b=vZi3DRy2E5UBS3WRiJ72ihiUu+MGqgYjCZE+yo6ltgTS73NO2Hcw+9WbUDQfWtMat3
         6zL3XC9NfHHPfOeWCAopeoWKqno0PzOabZl01XE1ipGy2hIu4C9WTfJP34rBDkPfxOLS
         NQJ8xm9VkSckStPplFtFf8zKr/lAcor1cwEsVh3NHgDOUvKkEIuaBZ3MkJKzY60tc8UC
         vQqPM7LgVNJbda7RBOd75H1UgTmMVGuVGgL4tbDXxqAm1AkcfhnPktmMNW4Okqv199Sq
         R7XWe8AkUuDZXfo0BYAIFysdvzl9zeSwzLaQcO7VxcBF5WKNhIyqA9y59+NmiqSaCQ16
         KgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174004; x=1710778804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWczKAWQT0mbMSpf1iuFE4nPkXsyl42XdLdakB0fL8Y=;
        b=IXTONBk83lgqr9+2efsaD4sUDMzbSCez/BR/wDUN4aFQQCMacIsVMEEPRwqrUR3HSN
         reIp0m+CAonXQrc7iRihcu+iSYFCmIA4I7pTyLLbR3Ih+JddjZezKMZNHQbT1RHfAvwz
         f1YzKwiQPUDqnMuuqvb/YJQQqz26lQBNyOeZmlC8xEgOVZyXVnUxzumMRVQ/N1T8TYH/
         pXGAeola0y8OiZ5yTwmoYYIZMtIO3MnCJSXtNmA7dhhvyPuzjVbj9gofmmTr6bNlmz3q
         TXxLFyt1MSCjJrtLoMIgHTM0S5py50gw7x2mr7qHXNkPlseadymsUwtu7REB3XR1ryCt
         SSAg==
X-Forwarded-Encrypted: i=1; AJvYcCXlMIIm3t1R5ZV/csJjFUqZ9bwyo5Z1MxLXaer3fo+b/wYTSWEhSgbLty/eazFOtTlkMNiHEnXEXRGLF1ZOPUnC4mUyRO91VIENSvqG
X-Gm-Message-State: AOJu0Yzv8jliBlJFvU3gKE692b+1sFGiLr9TSkxqI3fQSEF8lsBVqwYo
	sCSbJBX7I5CLNrSsz32LJ4WUHynaESbramCFotgfE0EUhRSOxLbhgSy+xTtf9JcrsMR+E9g41MB
	6bA==
X-Google-Smtp-Source: AGHT+IEO1bvj1AxOzixJ05DjcIRkTFT436rrj+zGF1gRPpfWPL5f5N5YGkSFbziWOWugB81Mep0QIgmnxsE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d98c:0:b0:609:371:342b with SMTP id
 b134-20020a0dd98c000000b006090371342bmr1303285ywe.1.1710174004522; Mon, 11
 Mar 2024 09:20:04 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:20:03 -0700
In-Reply-To: <tencent_4B50D08D2E6211E4F9B867F0531F2C05BA0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_4B50D08D2E6211E4F9B867F0531F2C05BA0A@qq.com>
Message-ID: <Ze8vM6HcU4vnXVSS@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: treat WC memory as MMIO
From: Sean Christopherson <seanjc@google.com>
To: francisco_flynn <francisco_flynn@foxmail.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, rdunlap@infradead.org, akpm@linux-foundation.org, 
	bhelgaas@google.com, mawupeng1@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, francisco_flynn wrote:
> when doing kvm_tdp_mmu_map for WC memory, such as pages
> allocated by amdgpu ttm driver for ttm_write_combined
> caching mode(e.g. host coherent in vulkan),
> the spte would be set to WB, in this case, vcpu write
> to these pages would goes to cache first, and never
> be write-combined and host-coherent anymore. so
> WC memory should be treated as MMIO, and the effective
> memory type is depending on guest PAT.

No, the effective memtype is not fully guest controlled.  By forcing the EPT memtype
to UC, the guest can only use UC or WC.  I don't know if there's a use case for
the host mapping memory WC while the guest uses WB, but it should be a moot point,
because this this series should do what you want (allow guest to map GPU buffers
as WC).

https://lore.kernel.org/all/20240309010929.1403984-1-seanjc@google.com

> Signed-off-by: francisco_flynn <francisco_flynn@foxmail.com>
> ---
>  arch/x86/include/asm/memtype.h | 2 ++
>  arch/x86/kvm/mmu/spte.c        | 5 +++--

Please use get_maintainers.pl.

>  arch/x86/mm/pat/memtype.c      | 8 ++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)

