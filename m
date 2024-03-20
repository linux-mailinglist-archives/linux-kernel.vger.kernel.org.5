Return-Path: <linux-kernel+bounces-108871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C488112A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A631F23956
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673283EA8A;
	Wed, 20 Mar 2024 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewiHOs1w"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B73DBB7;
	Wed, 20 Mar 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935161; cv=none; b=sDg361HS0h1xTrYi7q6WWd30N3VWg+pmDmCieaDtdjN48Z/etp/wX8cWTeEZmBKHR5xEa2ysIZQfFTBBVecgggodQNOZkMhmcDQ5e4H86OJjbrEZNEla0aNXmoz+l/Z1s/UVW+zvuoybuo0UmatIYkislWsrRhHr+4FeL93WayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935161; c=relaxed/simple;
	bh=01oY2je8eUOPUwF8l+M2wheZEGh5GUw6lBQ6Dq+yEmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlxn2HJl3fLm3nkrIwM8Fc7KohWjZLQ0znDVesqNV7+7cqi9E7ocI4fBBX/qYHsGeRdAxS+BACfbkGpCmbAXPmX0sSm/An/EXn06o4CGtTadWfhgI1aaha7CAHhzTBSpCzWsy+tqReAvKVmRp90wTPOYUz2RFgRvZsYiIl4QF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewiHOs1w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e162b1b71so5600711f8f.1;
        Wed, 20 Mar 2024 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710935158; x=1711539958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v321yfLmo8GBQ/y8FJ9LR+n1jyv6fOuhCRdabZc9zbA=;
        b=ewiHOs1wF0IUyDLCJRvJ3oQaCmAY81+I4h/uKzaR+Rd7UVQE/309YT0tnxaaQF0rT/
         pLgbgNbq4ghIT1cxYNnhdqh0ulJYv5stUhhI1vsubExIUrTUDBgUetnm2rIwdF4XftTE
         2oEpUVY39O9QThJjUcYcS4aY6oJBqbNJNq0cFYoJuoKkoPlGj60SJk06Zeh6kJfrv0l0
         RbvRWAZjbmR9v9xyM69gPpswCXzylABqYzf4MNkoyjW7KC7Wr/ztxMHAh7KAMzW2tX5C
         tdnGryJnBZtetSpXe3Maru6/A2dj9Ludl/ORFZ1x+46PMBkHWw4v23gynfgnFzp0dHEG
         mbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710935158; x=1711539958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v321yfLmo8GBQ/y8FJ9LR+n1jyv6fOuhCRdabZc9zbA=;
        b=a+Cd7vGSPzhrAucoFtsQQ9A+DUe/UUgPcTbbDF0MIPvNr0jFH34HN5H6K70QbAXa2A
         dabFXtNnVx8RTq40yE7D6nBhod/EInJyL8VBa1ZAGaIcgRpUHdDoMNXShfHHpyt9QipA
         2bNQWVgVsRVYyLph+trjtwOisQM6G9YDihiGPkD+5JSu431Hl08vmgpCUf/3cEmZiSk/
         iOtzNNJVf4d83EHcS3f7ZheVdoduQm4kXRGCoKAGC0LBsnsl8VZ1z/0LYjWDArdb50rT
         Wxaer0majv1ztM5SYYvb3plpXzGxhXfZo+n+lye4MCIYcfTAAtjvkkmdLgoJOt3UjPBf
         15hg==
X-Gm-Message-State: AOJu0YyCpEd5k9w3pU8qTLPaojIT7OvqpaG3oy/Fr/egDmbEewv4P6Ph
	NMLvE3CYh7SbQ4cRJyLAUVXKTYrNR/nYWc6mSMqAzvpZ9860W5tKgc4MM7NXUtA=
X-Google-Smtp-Source: AGHT+IHIaGpH1SUarfLTXZGxXsKLAEga/PSUIi9Ln03X0/ldyAVFMhtdUSadRf3ON54Hu7jEdhucQQ==
X-Received: by 2002:a05:6000:544:b0:33e:bf0f:8156 with SMTP id b4-20020a056000054400b0033ebf0f8156mr3563811wrf.38.1710935157831;
        Wed, 20 Mar 2024 04:45:57 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm11741024wrb.62.2024.03.20.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:45:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 20 Mar 2024 12:45:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Cc: linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip: x86/percpu] x86/percpu: Convert this_percpu_xchg_op() from
 asm() to C code, to generate better code
Message-ID: <ZfrMcyZXCBQD/sE8@gmail.com>
References: <20240320083127.493250-1-ubizjak@gmail.com>
 <171093476000.10875.14076471223590027773.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171093476000.10875.14076471223590027773.tip-bot2@tip-bot2>


* tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/percpu branch of tip:
> 
> Commit-ID:     0539084639f3835c8d0b798e6659ec14a266b4f1
> Gitweb:        https://git.kernel.org/tip/0539084639f3835c8d0b798e6659ec14a266b4f1
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Wed, 20 Mar 2024 09:30:40 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 20 Mar 2024 12:29:02 +01:00
> 
> x86/percpu: Convert this_percpu_xchg_op() from asm() to C code, to generate better code
> 
> Rewrite percpu_xchg_op() using generic percpu primitives instead
> of using asm. The new implementation is similar to local_xchg() and
> allows the compiler to perform various optimizations: e.g. the
> compiler is able to create fast path through the loop, according
> to likely/unlikely annotations in percpu_try_cmpxchg_op().

So, while at it, there's two other x86 percpu code generation details I was 
wondering about:

1)

Right now it's GCC-only:

  config CC_HAS_NAMED_AS
          def_bool CC_IS_GCC && GCC_VERSION >= 120100

Because we wanted to create a stable core of known-working functionality.

I suppose we have already established that with the current merge window, 
so it might be time to expand it.

Clang claims to be compatible:

  https://releases.llvm.org/9.0.0/tools/clang/docs/LanguageExtensions.html

  "You can also use the GCC compatibility macros __seg_fs and __seg_gs for the
   same purpose. The preprocessor symbols __SEG_FS and __SEG_GS indicate their
   support."

I haven't tried it yet though.

2)

Also, is the GCC_VERSION cutoff accurate - are previous GCC versions 
known-buggy, or was it primarily a risk-reduction cutoff?

Thanks,

	Ingo

