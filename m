Return-Path: <linux-kernel+bounces-19879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BD827607
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4552833E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293254664;
	Mon,  8 Jan 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNA2+g+L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2B5465C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704733770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEaf+YhhcSSmYZv93sFV02gwVdE3edWxgyCXG4NmWdI=;
	b=GNA2+g+Lcle+Wh9pF2Ezur8Kn/uBNwBZWpu1j34Vcq3PBLsc57pYzdgqM7x6IrjPvpa3hf
	ndn4GmiZMAY9d+Mdw3/9jrnPMiZDGUCNhsc9hSi8ZPsx8HzJJOXpLDuYVhcqDLLfSD8bOu
	sJAfsPjW44Sjj9I5/eJhKX0ny27izOA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-StmsF2nCONu2DOYKsO4KiQ-1; Mon, 08 Jan 2024 12:09:28 -0500
X-MC-Unique: StmsF2nCONu2DOYKsO4KiQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9b09d1afaso2535769b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704733767; x=1705338567;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEaf+YhhcSSmYZv93sFV02gwVdE3edWxgyCXG4NmWdI=;
        b=nbeCTJQBn/QN1HgEAYUbjmZm444Rl/fQrsstPw7vA1gdZCfxkJpV/yDY08Pry3Dl2r
         C7KvHVevS9grvbKxHCDHvyTZSz22j+G3Q8iByq0eOWn5rF7DoUNzh1tsIQNwRtk75bp+
         rBe75VZDQezPLF4ppaPX/4P11brcRV3/8jrYhrM5jLMegxjz88XLp+R8lnTqmk75RBeh
         YJz+iej2EWmc4osEGW8bRibnI/FgBGzevXhPT41wMDOXb+s7BMpkeZOoBWCG5YrU3/3t
         hk+6JSMJV7WLr0JBun9tO20qL+mSEmAStvB6Rss5CRe1mDYGLw2QhltkDqBE9STzYWbk
         aW7A==
X-Gm-Message-State: AOJu0YxXu83ECqGfdiFfQ1Ggrv4l7KMIrS5/fpgxguWaR6O6OeseOeQM
	VIB2FWGyLfYTv/NYsmufZe5pJd7eYV+HJOCHCFLhbWuBG8bfAft1K3vrgCAxY6bDVZw8X2LmcX8
	HETC73PyxFQHD7s9ODscJHMUewxFNS1O/
X-Received: by 2002:a05:6a20:7286:b0:199:d4f5:9c41 with SMTP id o6-20020a056a20728600b00199d4f59c41mr856130pzk.49.1704733767533;
        Mon, 08 Jan 2024 09:09:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErO+E71s0wtZ/MsBmj6uqV1ZMA6UTitBqmGrBZDhzYfsqGb4TCxSD/drIP9YHd0TkYrPZ14g==
X-Received: by 2002:a05:6a20:7286:b0:199:d4f5:9c41 with SMTP id o6-20020a056a20728600b00199d4f59c41mr856117pzk.49.1704733767231;
        Mon, 08 Jan 2024 09:09:27 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id t3-20020a62d143000000b006d9a42f25b2sm107553pfl.201.2024.01.08.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:09:26 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Mon,  8 Jan 2024 14:09:18 -0300
Message-ID: <ZZwsPsBZad-VqZ-U@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6278e066-a443-4055-9e5c-b13dea5909de@app.fastmail.com>
References: <20240105041458.126602-3-leobras@redhat.com> <ZZgAtntCQFKbsGiW@FVFF77S0Q05N> <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com> <ZZwPxNNc5pXr9kPi@LeoBras> <ZZwdKjsNj95wlTk4@LeoBras> <6278e066-a443-4055-9e5c-b13dea5909de@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 08, 2024 at 05:26:26PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 8, 2024, at 17:04, Leonardo Bras wrote:
> > On Mon, Jan 08, 2024 at 12:07:48PM -0300, Leonardo Bras wrote:
> >> On Fri, Jan 05, 2024 at 03:38:05PM +0100, Arnd Bergmann wrote:
> >> > 
> >> > I suspect it's enough to remove all of the other
> >> > "#ifdef CONFIG_COMPAT" checks in this file and rely on
> >> > dead code elimination to remove the rest, but there might
> >> > be additional problems if some extern declarations are
> >> > hidden in an #ifdef as well.
> >
> > I could remove all CONFIG_COMPAT ifdefs from this file, and for compiling 
> > it required a few extra defines (in other files) to be moved outside of
> > their #ifdef CONFIG_COMPAT. Those being:
> >
> >  #define VFP_STATE_SIZE         ((32 * 8) + 4)
> >  #define VFP_FPSCR_STAT_MASK    0xf800009f
> >  #define VFP_FPSCR_CTRL_MASK    0x07f79f00
> >
> >  #define COMPAT_ELF_NGREG               18
> >  typedef unsigned int                   compat_elf_greg_t;
> >  typedef compat_elf_greg_t              compat_elf_gregset_t[COMPAT_ELF_NGREG];
> > 
> >
> > OTOH, the size of the final arch/arm64/kernel/ptrace.o went from 44768 to 
> > 56328 bytes, which I understand to be undesired.
> 
> Right, unfortunately it seems that compat_arch_ptrace() is
> globally visible and consequently not dropped by the compiler
> in dead code elimination.
> 
> > A different (and simpler) solution is to have an empty struct in case of 
> > !CONFIG_COMPAT, that will be optimized out in compile-time:
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 9f8781f1fdfda..d2f275d8a3e6e 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2107,6 +2107,9 @@ long compat_arch_ptrace(struct task_struct 
> > *child, compat_long_t request,
> > 
> >         return ret;
> >  }
> > +#else
> > +static const struct user_regset_view user_aarch32_view = {};
> > +static const struct user_regset_view user_aarch32_ptrace_view = {};
> >  #endif /* CONFIG_COMPAT */
> > 
> >  const struct user_regset_view *task_user_regset_view(struct task_struct *task)
> >
> > With this the patch will build successfully and arch/arm64/kernel/ptrace.o 
> > will be able to keep it's original size.
> >
> > Arnd, is that ok?
> 
> I don't see it being worth it if you add extra unused lines
> in order to remove one more #ifdef. I would either leave the
> task_user_regset_view() function unchanged here, or (if this
> works) move the #ifdef down a few lines so the existing
> user_regset_view structures can be shared:
> 
> @@ -1595,7 +1595,6 @@ static const struct user_regset_view user_aarch64_view = {
>         .regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
>  };
>  
> -#ifdef CONFIG_COMPAT
>  enum compat_regset {
>         REGSET_COMPAT_GPR,
>         REGSET_COMPAT_VFP,
> @@ -1852,6 +1851,7 @@ static const struct user_regset_view user_aarch32_ptrace_view = {
>         .regsets = aarch32_ptrace_regsets, .n = ARRAY_SIZE(aarch32_ptrace_regsets)
>  };
>  
> +#ifdef CONFIG_COMPAT
>  static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
>                                    compat_ulong_t __user *ret)
>  {
> 

Ok, with the previous defines moved outside !CONFIG_COMPAT, this works as a 
charm and keeps arch/arm64/kernel/ptrace.o with the same size. 

I will send a v2 soon.

Thanks!
Leo

> 
>      Arnd
> 


