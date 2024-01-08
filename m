Return-Path: <linux-kernel+bounces-19737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F282721E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4385B225B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180E4C3D3;
	Mon,  8 Jan 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSMoNcme"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40414C3AD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704726478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGkGg6RWYBQE5b/vbAuEGwRY5SKVcqrmQKtMawiQB5k=;
	b=dSMoNcmeTLjbuSMR994oEA4/zBFkkJqbatSx47utKNgBjf3mO210wLAyKQJ4PDLEJw0n/0
	l5eUGAHhbLxc/i5ja+arLU2Pn6YkCo/BFPmngtBwKaXJRzRR/AGuu1f+r+R3RfRNGCAVeG
	oNEJx0MpogBoVbj3+1uxZvNwX5YyjyM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-gj-nvBZ5NdCJ12wRdbxCGQ-1; Mon, 08 Jan 2024 10:07:55 -0500
X-MC-Unique: gj-nvBZ5NdCJ12wRdbxCGQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso521227a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 07:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726475; x=1705331275;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGkGg6RWYBQE5b/vbAuEGwRY5SKVcqrmQKtMawiQB5k=;
        b=rET88xeaGYnjJTUfq7CcgZxK8gfhD5zB7gWo9chcBg70y+qZIM/GUcrr7bMAgy/sJF
         9GISUBIgnjn8osXNlW20fxx0POeomuGa6MMl4mprlFdmssOlUwd9VKZ87lrozMpDG+qr
         MvD51UoBg4qjUn4PJYh4zsPYX7IL6c676YG3RL9o6sSZqayWATfJjTfYDkag0uz6pL/j
         sKksQdlYJsMNaJKjA9TnrwWPT5HSDbzrSV2qeDaq5Y/OAQ9E3//f29ZHpKO6iT2JN/TV
         cVkmvSWO/GMRV124fl5wCxKRiKYZBlnPYAmTmeL2+OMJnqjBPWFBPTLihLB5uqkZ6WJU
         MScA==
X-Gm-Message-State: AOJu0YwsHWu179OrPAeLwlOxzqyNodOwQaOY67AcVXbz7Fs7ZSXRl1Sq
	hdSmgNDDNaY5t6M1aLRasK+x2X8W2167LcmSMmylLQtnia+/55RIU8nUNWvW54kU735HAyMHOwD
	TyzYhfy9Z50bJ+xd2btkI/vZ0KsggMnUK
X-Received: by 2002:a17:90a:9a92:b0:28c:6529:ec9c with SMTP id e18-20020a17090a9a9200b0028c6529ec9cmr1176640pjp.92.1704726474805;
        Mon, 08 Jan 2024 07:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8hI/FTvmA45bxfRTbHrh7uolmBIN6qyyCS+HvONvtiC8qNzr83Hlrhe2QGgtKCUrt2aUQIg==
X-Received: by 2002:a17:90a:9a92:b0:28c:6529:ec9c with SMTP id e18-20020a17090a9a9200b0028c6529ec9cmr1176622pjp.92.1704726474474;
        Mon, 08 Jan 2024 07:07:54 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090ac59500b0028acb86f7b5sm57168pjt.44.2024.01.08.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:07:54 -0800 (PST)
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
Date: Mon,  8 Jan 2024 12:07:48 -0300
Message-ID: <ZZwPxNNc5pXr9kPi@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com>
References: <20240105041458.126602-3-leobras@redhat.com> <ZZgAtntCQFKbsGiW@FVFF77S0Q05N> <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 05, 2024 at 03:38:05PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 5, 2024, at 14:14, Mark Rutland wrote:
> > On Fri, Jan 05, 2024 at 01:15:00AM -0300, Leonardo Bras wrote:
> > arch/arm64/kernel/ptrace.c:2121:25: note: each undeclared identifier is 
> > reported only once for each function it appears in
> > arch/arm64/kernel/ptrace.c:2123:25: error: 'user_aarch32_ptrace_view' 
> > undeclared (first use in this function)
> >  2123 |                 return &user_aarch32_ptrace_view;
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:243: arch/arm64/kernel/ptrace.o] 
> > Error 1
> > make[3]: *** [scripts/Makefile.build:480: arch/arm64/kernel] Error 2
> > make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
> > make[1]: *** [/home/mark/src/linux/Makefile:1911: .] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
> >
> > ... and looking at the code, user_aarch32_view and user_aarch32_ptrace_view are
> > both defined under ifdeffery for CONFIG_COMPAT, so that's obviously not going
> > to work...

Thanks for noticing, Mark!

> 
> I suspect it's enough to remove all of the other
> "#ifdef CONFIG_COMPAT" checks in this file and rely on
> dead code elimination to remove the rest, but there might
> be additional problems if some extern declarations are
> hidden in an #ifdef as well.
> 
>     Arnd

Sure, I sill send a v2 soon.

Thanks!
Leo

> 


