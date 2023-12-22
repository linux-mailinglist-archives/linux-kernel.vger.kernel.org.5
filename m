Return-Path: <linux-kernel+bounces-9939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31F81CD82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A972B215C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AE28DB7;
	Fri, 22 Dec 2023 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y55Ij6pG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA4286B5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703265371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qufab8DMOBe7zRcqBWbIAI8IYAio0OXUluoCRgVTRkA=;
	b=Y55Ij6pGwHQU54+kI7oGA5OLTBV0OYVJOoTawPGy5FMxPSpQbKlm5Tqqur36NaKStmF7c3
	55C8YCG00j27Ie39yYCCpaCi8wXkJp+YdJWB75XeqbBfNAPW/TC/3r+yivCwMeQdOS6tSo
	weahaeV5tVu+aXkOK8VIxzeMKwfEJ/0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-4DArAswxPHW5KlMPziWvmQ-1; Fri, 22 Dec 2023 12:16:09 -0500
X-MC-Unique: 4DArAswxPHW5KlMPziWvmQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d7609cb718so2168946b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703265368; x=1703870168;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qufab8DMOBe7zRcqBWbIAI8IYAio0OXUluoCRgVTRkA=;
        b=gK3+yjscYOsbp8u22TQuVlU3myW4E+2n3XauyVUgAYjinuh0MH4ln3P/+U1aln1DpD
         rQirXt4E/X5ExQdbKNx5v+ewcfjtB9XmjYt/hvDtDkRsuEiKEZKPTK52rIVpOP7tfKrA
         jqK90VNaLvV9hS+svUz8Rs2K2g6MCY1x2WTom11ZIbaxICnFqF4UMM3Rl8ARH+PSdq2Q
         +2UR6TPTaH/xeNcqP0kUUwhioW3joFQeICYn9WjpUvZCK36bdZusEhS9pmDQrcrPTEQ9
         k3+LQ3vIZhRaM4RST8IXc53KBAKIG2+y0OaYEJbSS6Abm19WZQ0VSkUYK9/T1keUOGYc
         kDqg==
X-Gm-Message-State: AOJu0YzbHSAdIW+dZOk0hJZaXDOvShw7rkt9X2CBNFvun9VqjXtoPEsK
	s3CGeNGHKbs+5fIBtpjIPJFQvH+/+aEERQx7jNCZhLqg8CcG1fxBgi6wVl6nQHf/Yci2Ti9WD/b
	txgY0oQW+b6pofE7bGL9ztdW640ZHlSG1
X-Received: by 2002:a05:6a00:2342:b0:6d8:53f7:e2d9 with SMTP id j2-20020a056a00234200b006d853f7e2d9mr1615069pfj.12.1703265368508;
        Fri, 22 Dec 2023 09:16:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPljs2dAbEEi2xfH9vMHVrk7J7/8VKCXzbf8sh7H43Q+YpnZpvsQeTWEqw48VWhBeksqCekA==
X-Received: by 2002:a05:6a00:2342:b0:6d8:53f7:e2d9 with SMTP id j2-20020a056a00234200b006d853f7e2d9mr1615054pfj.12.1703265368215;
        Fri, 22 Dec 2023 09:16:08 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78c47000000b006ce64ebd2a0sm3764799pfd.99.2023.12.22.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:16:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] riscv: Improve arch_get_mmap_end() macro
Date: Fri, 22 Dec 2023 14:15:53 -0300
Message-ID: <ZYXESbdaiW_G-eby@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTShV+xBjHwQKGEQG-JgEUVa6S8egZNcN7xt_2rPucph9Q@mail.gmail.com>
References: <20231222082711.454374-1-leobras@redhat.com> <CAJF2gTShV+xBjHwQKGEQG-JgEUVa6S8egZNcN7xt_2rPucph9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 07:48:36PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 4:27 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > This macro caused me some confusion, which took some reviewer's time to
> > make it clear, so I propose adding a short comment in code to avoid
> > confusion in the future.
> >
> > Also, added some improvements to the macro, such as removing the
> > assumption of VA_USER_SV57 being the largest address space.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/processor.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda549..2278e2a8362af 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -18,15 +18,21 @@
> >  #define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
> >  #define STACK_TOP_MAX          TASK_SIZE_64
> >
> > +/*
> > + * addr is a hint to the maximum userspace address that mmap should provide, so
> > + * this macro needs to return the largest address space available so that
> > + * mmap_end < addr, being mmap_end the top of that address space.
> > + * See Documentation/arch/riscv/vm-layout.rst for more details.
> > + */
> >  #define arch_get_mmap_end(addr, len, flags)                    \
> >  ({                                                             \
> >         unsigned long mmap_end;                                 \
> >         typeof(addr) _addr = (addr);                            \
> >         if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> >                 mmap_end = STACK_TOP_MAX;                       \
> > -       else if ((_addr) >= VA_USER_SV57)                       \
> > -               mmap_end = STACK_TOP_MAX;                       \
> > -       else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > +       else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> > +               mmap_end = VA_USER_SV57;                        \
> It's clearer.
> 
> LGTM.
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks!
Leo

> 
> > +       else if (((_addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) \
> >                 mmap_end = VA_USER_SV48;                        \
> >         else                                                    \
> >                 mmap_end = VA_USER_SV39;                        \
> > --
> > 2.43.0
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


