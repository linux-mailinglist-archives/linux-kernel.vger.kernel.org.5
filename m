Return-Path: <linux-kernel+bounces-19816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB898274A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C1C22D43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D46524C2;
	Mon,  8 Jan 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYXkgRng"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1F524A0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704729912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv79to8IgCK/Eom14q4H1jU+f+w7C2emyrlOzgVlZdA=;
	b=IYXkgRngPFR9wpcWzZjInGoEGr3PBjpnSA4smCmDofzzkFxkhIKqOPCwqsUEcCQgqtMPnL
	EhYDIZmaku5xjQoOzWkWLqVosc1QJhy3I1eIrCqPOrn/Y3cB1M7WUBt1IyS4sl4hBZUQZR
	6gpxvAESMdQzhMIVnhXp5S+bYvY5Ydc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-oN7le2uNPg2OEsu433xQCg-1; Mon, 08 Jan 2024 11:05:08 -0500
X-MC-Unique: oN7le2uNPg2OEsu433xQCg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so268143a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704729908; x=1705334708;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv79to8IgCK/Eom14q4H1jU+f+w7C2emyrlOzgVlZdA=;
        b=tcOK2ffammHEqb46p2pVfR2CkxXktumSGtKiLAu7tFpRECl/e+yVQA6yJBsZCiOgXX
         kmKzYmk2HFRsSFbVUvWUmdJtnyzsXg/wmhB17wjc6CFusJD/Hv9IxdRRs8CRJuLwSh5L
         J4P2VNhmomjTj0gExblowwZuT927sEkUMjc+Xye92h0nekcbBUng2IJP1l/t+h05Ga95
         e4q/i5drIzy2Y/z5SCIXNOkSaz0e068CbyjpTY6nTXFJ9TmZfl8WA7727P/ojhNoNm7l
         ibszzbc11G+Lq4DqI0nkDAonf06953qIxlnRN57n9Ik7tJKiWBodCJvuhr5U5/FbjuCM
         8pjA==
X-Gm-Message-State: AOJu0YzoYwa4Gtigg9MDv4i0FQBdWTbgdcYT9Nt0CBg+E3U757P6AvYH
	ih1p9J3bx3psX5jNTK84zSZPolkbZRYIUEK3N7htCMFZ+W4SfKg21x2hJNR+QBUrT36Q6mGzsHG
	eN/xOz8FnYJEifxkdo8NBMzDlw3WXIrXh
X-Received: by 2002:a17:90a:d998:b0:28b:c10e:2f1e with SMTP id d24-20020a17090ad99800b0028bc10e2f1emr1285433pjv.23.1704729907869;
        Mon, 08 Jan 2024 08:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYObcTdEFCcLBxuhh9m6/RGhFaF0OMmenCn7oXy+SA1boH9CjQS70YktOx0qVV61BW+RKuxg==
X-Received: by 2002:a17:90a:d998:b0:28b:c10e:2f1e with SMTP id d24-20020a17090ad99800b0028bc10e2f1emr1285414pjv.23.1704729907553;
        Mon, 08 Jan 2024 08:05:07 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id p15-20020a056a000b4f00b006d9e76be7cesm44050pfo.73.2024.01.08.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:05:06 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
Date: Mon,  8 Jan 2024 13:04:58 -0300
Message-ID: <ZZwdKjsNj95wlTk4@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZwPxNNc5pXr9kPi@LeoBras>
References: <20240105041458.126602-3-leobras@redhat.com> <ZZgAtntCQFKbsGiW@FVFF77S0Q05N> <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com> <ZZwPxNNc5pXr9kPi@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 08, 2024 at 12:07:48PM -0300, Leonardo Bras wrote:
> On Fri, Jan 05, 2024 at 03:38:05PM +0100, Arnd Bergmann wrote:
> > On Fri, Jan 5, 2024, at 14:14, Mark Rutland wrote:
> > > On Fri, Jan 05, 2024 at 01:15:00AM -0300, Leonardo Bras wrote:
> > > arch/arm64/kernel/ptrace.c:2121:25: note: each undeclared identifier is 
> > > reported only once for each function it appears in
> > > arch/arm64/kernel/ptrace.c:2123:25: error: 'user_aarch32_ptrace_view' 
> > > undeclared (first use in this function)
> > >  2123 |                 return &user_aarch32_ptrace_view;
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > make[4]: *** [scripts/Makefile.build:243: arch/arm64/kernel/ptrace.o] 
> > > Error 1
> > > make[3]: *** [scripts/Makefile.build:480: arch/arm64/kernel] Error 2
> > > make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
> > > make[1]: *** [/home/mark/src/linux/Makefile:1911: .] Error 2
> > > make: *** [Makefile:234: __sub-make] Error 2
> > >
> > > ... and looking at the code, user_aarch32_view and user_aarch32_ptrace_view are
> > > both defined under ifdeffery for CONFIG_COMPAT, so that's obviously not going
> > > to work...
> 
> Thanks for noticing, Mark!
> 
> > 
> > I suspect it's enough to remove all of the other
> > "#ifdef CONFIG_COMPAT" checks in this file and rely on
> > dead code elimination to remove the rest, but there might
> > be additional problems if some extern declarations are
> > hidden in an #ifdef as well.

I could remove all CONFIG_COMPAT ifdefs from this file, and for compiling 
it required a few extra defines (in other files) to be moved outside of
their #ifdef CONFIG_COMPAT. Those being:

 #define VFP_STATE_SIZE         ((32 * 8) + 4)
 #define VFP_FPSCR_STAT_MASK    0xf800009f
 #define VFP_FPSCR_CTRL_MASK    0x07f79f00

 #define COMPAT_ELF_NGREG               18
 typedef unsigned int                   compat_elf_greg_t;
 typedef compat_elf_greg_t              compat_elf_gregset_t[COMPAT_ELF_NGREG];
 

OTOH, the size of the final arch/arm64/kernel/ptrace.o went from 44768 to 
56328 bytes, which I understand to be undesired.

A different (and simpler) solution is to have an empty struct in case of 
!CONFIG_COMPAT, that will be optimized out in compile-time:

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9f8781f1fdfda..d2f275d8a3e6e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2107,6 +2107,9 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
        return ret;
 }
+#else
+static const struct user_regset_view user_aarch32_view = {};
+static const struct user_regset_view user_aarch32_ptrace_view = {};
 #endif /* CONFIG_COMPAT */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)

With this the patch will build successfully and arch/arm64/kernel/ptrace.o 
will be able to keep it's original size.

Arnd, is that ok?

Thanks!
Leo



> > 
> >     Arnd
> 
> Sure, I sill send a v2 soon.
> 
> Thanks!
> Leo
> 
> > 


