Return-Path: <linux-kernel+bounces-73247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D372585BFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0811F24871
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E77604C;
	Tue, 20 Feb 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cpdQCDy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7636F085
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443224; cv=none; b=HawbCJQ8gh23WyOx2riC5uTfUxi4sJcYb2UZAH+Vhjn6GyprPAcrAVO5WXpq8zGVaKBncoGL4AbgDEMi5QJzL/Ap8Z5sBE05qVTRAM20/1UqVgj9oAidvzS2B8gEgNQv9NkHeKB13hwOJqcMUcr7JOcqjW0AMuFRQmfiLOPckfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443224; c=relaxed/simple;
	bh=7D7kf8p8aX2ZzflAMDnkhBwWgiUvsRg8uan55wPtdeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rD2cAqdXdr3EvOVokuJk4ifplYHTZAMNcUuEgCU2Kkr1O7iniMq+lO5g1WJ34296uLzVFA59WUosFqjichXjIYKqs3p0//xSGguX2j12p91EiyLac0shVznU4elVKW//sCh8+4L8wlUAH5sk9AQAvCiezjk6fVNX1cJ9FsycAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cpdQCDy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608748e1014so4012717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708443222; x=1709048022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fzOe/J4kuriO/maOGNH55dN19fVKQtEmyIcU4m9sns=;
        b=3cpdQCDyg0mp5DZW2QTFvCcek4NqeDX7/LxCgHwuElM503dUoBSO7gIT1zXFtIJoJk
         Eqrfn3tQlO17zTIzFUB5Da0CpBVfAvgOvjTuzPeLRyqGkd3rW5zKtdM6laTGO/dw3B5u
         EcKxClAj1BrDglpYlG9x8rSdRLTNcFa+vPjHpaDq2PG7n8LWl0/PRern/zFiBMyNvxsk
         hgWsLiCYmfUMjvmN5Hsedn3k1BFFML47uUqPRqS6ntAraoVtSVWuWqLXNCIKV0npv5vX
         2jVBdx7V5bsKNZ01R9eOsrIa5l7iHQ0RSqopNvC/mfGngYDFlJ/WDHPyyVZLo/g5VPHR
         u6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443222; x=1709048022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fzOe/J4kuriO/maOGNH55dN19fVKQtEmyIcU4m9sns=;
        b=KrUX/fNe2qfi7FjH+RJpqJbUDWZ8WYNDyvrWSVXdksRy+G3M9PDUskzgpI+sYfWpf5
         VhpRkf3q1zshD1Lp9Zz6Vqh2XVr9rR5XiJrCVoWxhU0v4URyTgv1r8lUFAZv97kmsbgB
         vG5BrGQfWUSEgEd/OlHDXhdUqQe2Clsnu/Qa7lTrTFqGwJtLXpM7Yr5HeffIgHE3uji6
         jV5ij1KN7qpEDfmIXZfvXcqL1mSViRr5AbnUgVEo4fFdH6NrmNHGy3Pn9RPfJqY4DMFl
         y/7z1jJJFuMzH5q8llPaQmhTY/fzDZwQ1w31hDeIFABHrxBELrkWHkuTtGFmAJFahIS3
         h5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXu7p+g4XKUTHRaRPnM5VA1gq2m0StZzY80MYWEfHOZyGO7adS5o9j+v2IV/jI9wef5o5fqG5XLbzDLgusD/DDvfPaD7itGa3cN805H
X-Gm-Message-State: AOJu0YyDR0Y5SOV8GVIwtR9+HJWe7xDL8/tCLwuQcekWJJD8g7MJ5s3h
	SzayrPZZouzlmtyw9yOXvD9k47mGl+pGXlgoPJ5OFj/gHjSMiMhRI7Vzz+uF5z+4Viwe3Z+gEXA
	0qQ==
X-Google-Smtp-Source: AGHT+IHV2QTvanF7VyH48/qvRHmtqg+UWhaoc+cyGK8cObSo3PadCiUndGKk4nt1DLGsJf5NFU55wseFcsE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4f83:0:b0:608:6c70:8d6 with SMTP id
 d125-20020a814f83000000b006086c7008d6mr178184ywb.2.1708443222505; Tue, 20 Feb
 2024 07:33:42 -0800 (PST)
Date: Tue, 20 Feb 2024 07:33:40 -0800
In-Reply-To: <20240220134800.40efe653@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220134800.40efe653@canb.auug.org.au>
Message-ID: <ZdTGRQJIO0Te8zF8@google.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the kvm tree
From: Sean Christopherson <seanjc@google.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Paul Durrant <pdurrant@amazon.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 20, 2024, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-x86 tree got a conflict in:
> 
>   include/uapi/linux/kvm.h
> 
> between commit:
> 
>   bcac0477277e ("KVM: x86: move x86-specific structs to uapi/asm/kvm.h")
> 
> from the kvm tree and commits:
> 
>   01a871852b11 ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
>   3a0c9c41959d ("KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA")
> 
> from the kvm-x86 tree.

/facepalm

I asked Paolo for a topic branch specifically to avoid this conflict, and then
managed to forget about it.  I'll rebase the xen patches and force push.

