Return-Path: <linux-kernel+bounces-15989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03F8236A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917351F25AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C561DA2A;
	Wed,  3 Jan 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uifg7oyk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D81DA21
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704314083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX7BzCsdBzWcwtB5ciPRsuFeZU5q4lF8Kx0DlbuB/5c=;
	b=Uifg7oyk2fyDFmJz7+g/crhTaCvmry9vorwhUp4mNWYJDWtAkcmx4548a5cR8uRfTJigu/
	cdPp0SsxQWUkSXasVmbMbbpJ05PvjA1tsvJxY6VTsZEZR97RPHtoMeanoNCtV754Yo4EXf
	fmg/4K0538PjPYwBcreeETdEvq7cpyM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-nmAruV2qOhaMk4taT2C7mA-1; Wed, 03 Jan 2024 15:34:41 -0500
X-MC-Unique: nmAruV2qOhaMk4taT2C7mA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fe9fa7f4fso105992495ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704314080; x=1704918880;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX7BzCsdBzWcwtB5ciPRsuFeZU5q4lF8Kx0DlbuB/5c=;
        b=sOsHWLogQJRYSzTsaQEA+Oj7fGAXa5cfjutRQbrRfKaCweNKZx/W6OHWVVdBDrcqoE
         gv6T6PdpUMcl9vbEa1kwzbaISR0yIi9UMZYKN5OvTd3+wJ0reeR82w9zwNjc+KoKIYFp
         SWC8i7RfMXurKvjaSZ8LnoqGwEKpfkjM9COYJKLRjK4L9kJGMgRLMUqS2tMNpacnXJlZ
         z1cc9j7g5onjidTOVE9TGoMVnRJigGVsQB3KzVyrjtFH1B6LSvvookV/O5zagjAB8Z37
         4HICo570lIYWIJpqo5SeEnQPh/hVkvuNgPPsHwDDcHJqqGiVvGxkjzEejwR6tvmxDviB
         XKSg==
X-Gm-Message-State: AOJu0YyBwGWxQ7REcVVWCNz5R8gxAF1V/3Utz4S+B4zEvL/vYnRXHhG9
	mhDa6QfZpOOOjWl6869slahIH3AiMGKRaNirVd3WsD6v4xxWVK0KG0tnVX7TKf3JANsUGEa9ETw
	P1nGISFJdSwaUwyZBAMlSdzTMRGyRsETf
X-Received: by 2002:a05:6e02:20cd:b0:35f:ca37:c4d5 with SMTP id 13-20020a056e0220cd00b0035fca37c4d5mr16559840ilq.118.1704314080745;
        Wed, 03 Jan 2024 12:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElkXfRwXeQ0zLdK6u+AW5iDdQ9uJb6J5D0NvPWmHZDlgrBZS9EE8h5rwtClC0OWfUFQde28A==
X-Received: by 2002:a05:6e02:20cd:b0:35f:ca37:c4d5 with SMTP id 13-20020a056e0220cd00b0035fca37c4d5mr16559822ilq.118.1704314080537;
        Wed, 03 Jan 2024 12:34:40 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id j33-20020a63fc21000000b005cdc9b091b7sm4862359pgi.53.2024.01.03.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:34:39 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Wed,  3 Jan 2024 17:34:29 -0300
Message-ID: <ZZXE1WoXaAdkrH8A@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103-4f92e1f7290975300ecc64ce@orel>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org> <20240103-4f92e1f7290975300ecc64ce@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 03, 2024 at 08:48:12PM +0100, Andrew Jones wrote:
> On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> ...
> > +#define CBO_PREFETCH_I(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> > +	       SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_R(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> > +	       SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_W(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> > +	       SIMM12(offset), RS1(base))
> 
> These should just be named
> 
>  PREFETCH_I
>  PREFETCH_R
>  PREFETCH_W
> 
> without the CBO_ prefix. The other CMO instructions we've added have the
> CBO_ prefix because their actual instruction names are e.g. cbo.zero,
> but the prefix instructions are not named that way.
> 
> Thanks,
> drew
> 

Sure, that's ok this way :)


