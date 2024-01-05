Return-Path: <linux-kernel+bounces-17375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6C824C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF531F22AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A03D1C3E;
	Fri,  5 Jan 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcIYhALv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A81854
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704417414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYg2hT5GJFO9Dm7UK9vv+m54JH3ByTaotG3gHMUWSUE=;
	b=YcIYhALvlATs+qFWB18r8pI5hxWtlzyadg/onBebARN5Ja8vvGd9t/Q/06n/Yj5HhzG3pf
	pOrnS049+22hWgIIZGuRzwoztZhqAPacw2nxMIjunmOqSGv+i1GhMNGlcYoJL00ibe04X/
	P+iKApQ+V6/rayEiG835E+4CRXUbrOg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-5C7nuTflNIWpkmuypgN7aw-1; Thu, 04 Jan 2024 20:16:52 -0500
X-MC-Unique: 5C7nuTflNIWpkmuypgN7aw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce098b08fdso631118a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 17:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417411; x=1705022211;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYg2hT5GJFO9Dm7UK9vv+m54JH3ByTaotG3gHMUWSUE=;
        b=u+d1Ut+ICEBRgsy8c4OFwh2wvFVl9//W8rqGKIO+YmpNH1xley0yXN1KBXnQjckE3w
         bCeGYCGFHpCrd98Z/PvAOqUfSkvKA65d8A5vLx4dCRx/zR0+EU4QSRzkkdmOqcJHGFmT
         AsQtN/mWA8PCN4i1KZECc8mkXFnrD1zzUgdWVsJhaB+8HuXdNsFsFgix8mxd0dxe0Imi
         zD5rmzyHC9lYJtHnTUgkantmGARx+INVEWIaNLcsMg4lMjihiz5lxepCEorLjdzVLdDz
         R50d20WvkX2NhOe6lng0UYGNpyJtr5lhQYBFFNQO2e+jWA/QbQi7t1wrrbvOWqvztDae
         TAew==
X-Gm-Message-State: AOJu0YylrGx6m2q+0NOgarA8dDXXP1rkxvHC/3xiYq4bl3QoA7uI50Hy
	pEEjMR69KnfSVekWfWz1stW9cCSuCR2wVPenbsBl+PRY3jmXZZhBIx8vll2Ysvcg05I5dee7C78
	zP42s1mm4zbIWwhVokRNmvIgch59Shmz7
X-Received: by 2002:a17:903:985:b0:1d4:e0e6:693 with SMTP id mb5-20020a170903098500b001d4e0e60693mr1286311plb.35.1704417411089;
        Thu, 04 Jan 2024 17:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPdpjsnnQ4TQBGiWJZm3UZ6CIwGk4aZKcDyuKK3ECvN3dbEXpbAHii3Y/0MTOuDP2Q95V7Sw==
X-Received: by 2002:a17:903:985:b0:1d4:e0e6:693 with SMTP id mb5-20020a170903098500b001d4e0e60693mr1286294plb.35.1704417410748;
        Thu, 04 Jan 2024 17:16:50 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3efd:1dbc:859f:ecb4:d775])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d3675664c9sm232413plh.59.2024.01.04.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:16:50 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Teo Couprie Diaz <teo.coupriediaz@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] arm64: add compile-time test into is_compat_task()
Date: Thu,  4 Jan 2024 22:16:39 -0300
Message-ID: <ZZdYd_VADgVyITH1@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8412ce8a-7016-4f65-99d3-ce472a75d8cd@app.fastmail.com>
References: <20240104192433.109983-2-leobras@redhat.com> <8412ce8a-7016-4f65-99d3-ce472a75d8cd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 09:43:56PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 4, 2024, at 20:24, Leonardo Bras wrote:
> > Currently some parts of the codebase will test for CONFIG_COMPAT before
> > testing is_compat_task(), probably in order to avoid a run-time test into
> > the task structure, while other parts of codebase will just test even when
> > the option is not compiled in.
> >
> > Since is_compat_task() is an inlined function, it would be helpful to add a
> > !CONFIG_COMPAT version of the helper, allowing compile-time optimization.
> >
> > With this, the compiler is able to understand in build-time that
> > is_compat_task() will always return 0, and optimize-out some of the extra
> > code introduced by the option.
> >
> > This allows optimizing-out code when the option is not selected, and
> > otherwise removing a lot #ifdefs that were introduced, making the code
> > more clean.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> 
> This looks like a useful cleanup to me, 


Hello Arnd, thanks for reviewing! 


> with one change:
> 
> > ---
> >  arch/arm64/include/asm/compat.h | 5 +++++
> >  arch/arm64/kernel/ptrace.c      | 6 ++----
> >  arch/arm64/kernel/syscall.c     | 5 +----
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> > index ae904a1ad5293..3cc61cbbb9062 100644
> > --- a/arch/arm64/include/asm/compat.h
> > +++ b/arch/arm64/include/asm/compat.h
> > @@ -100,6 +100,11 @@ long compat_arm_syscall(struct pt_regs *regs, int scno);
> > 
> >  #else /* !CONFIG_COMPAT */
> > 
> > +static inline int is_compat_task(void)
> > +{
> > +	return 0;
> > +}
> > +
> 
> I think this bit is not even needed as long as users
> include linux/compat.h rather than asm/compat.h, as there
> is already a macro definition in the common file:
> 
>  #define is_compat_task() (0)
> 

Oh, I was unaware of this macro. Thanks for pointing it out!

I just checked every use of is_compat_task() in the codebase for (arch == 
arm64 && non-arch code), and it seems like the file will either include 
linux/compat.h or another header which includes linux/compat.h. 

So it's safe to assume the macro will be available for every user.

I will send a v1 soon.

Thanks!
Leo


