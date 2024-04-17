Return-Path: <linux-kernel+bounces-148400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9F8A81FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A091C226FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A76D13C9A1;
	Wed, 17 Apr 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0xCc+NJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6413C80E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353005; cv=none; b=Aea96Nv16md6z3H1lsrtMu2krWTesXRzWkSJpV/TiLDoZS86cyG6iACG66YFxJJgMgm/S/AjfbNzjZVQb0z2m2oJSmB8bcmfxhESg0c4nJBoDisoz6X0hi5SBFWrnG5FkaINi3/n0XSfQ8LeGH8XHDUN8HV+c+19Xp3j/GReC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353005; c=relaxed/simple;
	bh=KPx2ZsqWpzZLK3m3WMgWg1Tq0M4fucX/fotRCnYiRgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFLLIpxjDGkCgzPOct5JBgV746lqxCdKdUwznbWhmj+LjBEPawQJ/7asMNyKkeQtsTP5n9fexe4wxh2cIAIDTmScr8AWP/Y4tNkuLEGDmdi/hHQZZuxw6QrqVMGBXq6wbTTUu2i111upwM6UtqB58QjIaTbs9BiZOWULV5xDnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0xCc+NJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4187981999fso17862555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713353002; x=1713957802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WUQ8LhAsMpwwq/+rPAvVmYYIR8bLgyILBO1ofwpQzI=;
        b=k0xCc+NJ66obQpGJSfZLqkLOnH0FHj7kHKofkTpOcYnbVjmvTfjbcbYWW0GOpuWIus
         qyr/RTzx+zCcEZQLTUspSA52NoRfHvo9X/Izx8ViYJREeFK8UpUhEFoxkQKfXel457kD
         o/Qb0wqrBFLX3IBNLCQAIW4RNAlQO8gZlUPyFEOSGwbFsTUlpqmNQy2ieIJFPvKZS3i+
         fBUmjLqQZhtfLzObu0u6Ha8yAj+EXoCh7qIWU2geVoyYp6esV9k486OoTXNv+oExJgjJ
         T3q2LTE7DadQZGxZywQlK3uHgfxlyKyEzx2cblouRJNMhtQlH+CkW4ewMHhKjbMRLlj+
         KLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713353002; x=1713957802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WUQ8LhAsMpwwq/+rPAvVmYYIR8bLgyILBO1ofwpQzI=;
        b=oS3VpOU5Vf8TDyb3bNOaAGQrX4Ua98F/6xGPNi6zRdLVNzsqsk8fX4o9bZhl0QGu9h
         9MpgxwCb03nFtlh4N2IAA5cbT0BHwmNrvQLH7Z1YfhJ/BzpGqCMTUqINE6JWw7qtRGhq
         9SJe/LAR3ePxbDo4AUlA63SJic0kDyTlQCAhyhwQA99Nxe67kQcDBUZ6ti/Fzxhs/5mI
         UScukGDqSZt2lnwP5tV0GhACOGoYnAZ52PbQxtXyh+DepHOAraQ9lCVV4jU8sRBDsORx
         +E88ZeQUGyri5XrR96tFydePRG9rlI/xtQHQmN00ipon5hkkitlVRr8iEeNI9+ayRE20
         264g==
X-Forwarded-Encrypted: i=1; AJvYcCU4h6gDCghokZo08JEAVRw08y7Sf0IUjl7SuG7WuCxNViHXXTpkGqyVfmujLAYEygRlYNuX6ABv9d83lw+C0h/7TvGf6TrB4oOSul7O
X-Gm-Message-State: AOJu0YwB2oaKIl37DXhS5RxQE6DlJZP9v9nj/hke2lVHkXdGgdmT6hjz
	6+U0l2V7Ubu2KGTcFOLDufpRK9THfZnmOkhfUMY+KBl7XBwkMjRU
X-Google-Smtp-Source: AGHT+IHbYjlDV0+YJR4OeiatmxSq2gp292lirHdqgY6S0B8P486DYzv2fUV1C8ws1WtegEN2YLdlEQ==
X-Received: by 2002:a05:600c:46d0:b0:418:676d:2a51 with SMTP id q16-20020a05600c46d000b00418676d2a51mr5249443wmo.15.1713353001837;
        Wed, 17 Apr 2024 04:23:21 -0700 (PDT)
Received: from gmail.com (1F2EF007.nat.pool.telekom.hu. [31.46.240.7])
        by smtp.gmail.com with ESMTPSA id cg17-20020a5d5cd1000000b0033e7a102cfesm14397193wrb.64.2024.04.17.04.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 04:23:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 17 Apr 2024 13:23:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <Zh+xJpjaHjF2qvmV@gmail.com>
References: <20220302043451.2441320-1-willy@infradead.org>
 <202404161413.8B4810C5@keescook>
 <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
 <Zh8dTOZ_YxeGhp-L@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh8dTOZ_YxeGhp-L@casper.infradead.org>


* Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 16, 2024 at 05:29:02PM -0700, Linus Torvalds wrote:
> > On Tue, 16 Apr 2024 at 14:15, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > I was looking at -Wshadow=local again, and remembered this series. It
> > > sounded like things were close, but a tweak was needed. What would be
> > > next to get this working?
> > 
> > So what is the solution to
> > 
> >     #define MAX(a,b) ({ \
> >         typeof(a) __a = (a); \
> >         typeof(b) __b = (b); \
> >         __a > __b ? __a : __b; \
> >     })
> 
> #define __MAX(a, __a, b, __b) ({	\
> 	typeof(a) __a = (a);		\
> 	typeof(b) __b = (b);		\
> 	__a > __b ? __a : __b;		\
> })
> 
> #define MAX(a, b)	__MAX(a, UNIQUE_ID(a), b, UNIQUE_ID(b))
> 
> At least, I think that was the plan.  This was two years ago and I've
> mostly forgotten.

I think as long as we can keep any additional complexity inside macros it 
would be acceptable, at least from the scheduler's POV. A UNIQUE_ID() layer 
of indirection for names doesn't sound look a too high price.

I had good reasults with -Wshadow in user-space projects: once the false 
positives got ironed out, the vast percentage of new warnings was for 
genuinely problematic new code. But they rarely used block-nested macros 
like the kernel does.

Thanks,

	Ingo

