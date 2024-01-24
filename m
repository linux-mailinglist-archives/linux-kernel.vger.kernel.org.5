Return-Path: <linux-kernel+bounces-37708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4283B436
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C531C235DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406AB135400;
	Wed, 24 Jan 2024 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HULPRXyk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27C131E26;
	Wed, 24 Jan 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132625; cv=none; b=IhTwj05em74pwCj3NPmWwOyQcv2RvpQRONHAkjofrqX5S4cqFiejUsTNCOqHWTUJwU6jzm096/iSN0BXTy4l9uNeqTy2J9PHwH//JmVvDR2h02tKCmAwb2MHC+2Oj1CwTnVSMLVrpZD372GMpRr32ce2ez17/wuP1jSG0qqWyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132625; c=relaxed/simple;
	bh=ZF8/t0mRHALw+nHwdJFr6ZZiZtwLtij4wgJWPTKNluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHuHHVWYwmxjOoYCceER8VumKkl18CtpJL+WoqcGn1OG5WfpDAuNMEt6z8NCOlx3xOgvKtqsCGuKTxi4ANaDWgi214BoxNN0nceNs4728S97BJg//Bf5WUGwrGWFX+MH4pvrNgeSJtBZo3/uljU1HeJF43zEqlc/hazVL8vzJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HULPRXyk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337cf4ac600so5515297f8f.3;
        Wed, 24 Jan 2024 13:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132622; x=1706737422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tg6vlOJdIGK8tq0vrQAo3bCHPF7VlBCqruzxipzmg3E=;
        b=HULPRXykY5fOcPszzcYbmVnsptUiG8VeiF5a+ltQXOcg1fItkGNxxsu5NOm8jo4SbI
         DXON1+Q7tRlVXNbQe+49RB5osX+vfAC1cCSyluKgBPRWE0v9BFt/rGQznwbvN6+1VJ8L
         0lBKFql9gwbM0tF3k7wuPHRJznIEE8q8tFA/AMBA4HVrtfEyZKNhOifEq4fwZSWuHgc8
         rkCeOqCF4PtnsK8WPM31+j5OLmOspWNS2JTZ4rSEqDPXcfaMEEFCG0ZjU6oRXbELz74j
         hjiGwcJWu3mBS6bNmUXG90W7eLsPRLOUh9tW0F9T7j1TF7M5PRmLwBKoTl1m0RB5/rJz
         +oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132622; x=1706737422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg6vlOJdIGK8tq0vrQAo3bCHPF7VlBCqruzxipzmg3E=;
        b=wDIAdSFgmD24IHGPhm2l82jsv5oDtQ1uYFT7FHSuVgZGn1JZWUaLZXXU9QdSDjUHgp
         ljRi21J3NBQFi1EYn5V/sQIlopNsS0J3OfI5+dh4PmQ9xir38sk8lbKX36uRU+cJCvQb
         WwUeKWux71pZhYCgrLBKtuLpxUQqUPIRYWTqyI2F+7uuavtdTW1N3vkJ2as5Es8Co/Gk
         +vQRrLUyUkqzJf/EGxDA0JZStYe5dEmYN+0J/blU2FQS1AlBeLrnPRQWRoEh74QkdiW4
         3Tc+v8ghuuFLq09LxdnG4s7GQY1f57pnt3QRW2YnJnExR/fuTc1jTEwXlVfXwJ/+pewf
         4Izw==
X-Gm-Message-State: AOJu0YxsD8QxzJkMSYG1GufEVm21krwKrC3pMmZSxv4i5hr1v6sOeVKt
	/zffkbMzMs7/DGWGLlWmq2A0oWFwJOTtoj3rJGEBgVAC24x6+eDm
X-Google-Smtp-Source: AGHT+IHr4rlR/jsqg4UhvhM22LlkdwhEz3vyqEedXc7T2SDNhM04UimPxufVBGGISy/LOD8NkSJcyQ==
X-Received: by 2002:adf:a188:0:b0:336:5f15:5533 with SMTP id u8-20020adfa188000000b003365f155533mr941828wru.54.1706132621880;
        Wed, 24 Jan 2024 13:43:41 -0800 (PST)
Received: from andrea ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id cl22-20020a170906c4d600b00a26a061eef8sm292575ejb.69.2024.01.24.13.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:43:41 -0800 (PST)
Date: Wed, 24 Jan 2024 22:43:36 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	paulmck@kernel.org, corbet@lwn.net, mmaas@google.com,
	hboehm@google.com, striker@us.ibm.com, charlie@rivosinc.com,
	rehn@rivosinc.com, linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing
 command
Message-ID: <ZbGEiEgeGwzUcTe0@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
 <aabea058-0088-41bb-822a-402669f348bb@efficios.com>
 <ZbFahHxi5laA6CbI@andrea>
 <e4e1ee4d-b96c-47c7-bf81-5f4d3b0ce5dc@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e1ee4d-b96c-47c7-bf81-5f4d3b0ce5dc@efficios.com>

On Wed, Jan 24, 2024 at 01:56:39PM -0500, Mathieu Desnoyers wrote:
> On 2024-01-24 13:44, Andrea Parri wrote:
> > > > +# riscv uses xRET as return from interrupt and to return to user-space.
> > > > +#
> > > > +# Given that xRET is not core serializing, we rely on FENCE.I for providing
> > > > +# core serialization:
> > > > +#
> > > > +#  - by calling sync_core_before_usermode() on return from interrupt (cf.
> > > > +#    ipi_sync_core()),
> > > > +#
> > > > +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
> > > > +#    uthread->uthread and kthread->uthread transitions) to go back to
> > > > +#    user-space.
> > > 
> > > I don't quite get the meaning of the sentence above. There seems to be a
> > > missing marker before "to go back".
> > 
> > Let's see.  Without the round brackets, the last part becomes:
> > 
> >    - via switch_mm() and sync_core_before_usermode() to go back to
> >      user-space.
> > 
> > This is indeed what I meant to say.  What am I missing?
> 
> Would it still fit your intent if we say "before returning to
> user-space" rather than "to go back to user-space" ?

Yes, works for me.  Will change in v4.


> Because the switch_mm(), for instance, does not happen exactly on
> return to user-space, but rather when the scheduler switches tasks.
> Therefore, I think that stating that core serialization needs to
> happen before returning to user-space is clearer than stating that
> it happens "when" we go back to user-space.
> 
> Also, on another topic, did you find a way forward with respect of
> the different choice of words between the membarrier man page and
> documentation vs the RISC-V official semantic with respect to "core
> serializing" vs FENCE.I ?

The way forward I envision involves the continuous (iterative) discussion
/review of the respective documentation and use-cases/litmus tests/models
/etc.

AFAICS, that is not that different from discussions about smp_mb() (as in
memory-barriers.txt) vs. FENCE RW,RW (RISC-V ISA manual) - only time will
tell.

  Andrea

