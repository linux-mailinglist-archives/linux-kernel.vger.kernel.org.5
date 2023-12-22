Return-Path: <linux-kernel+bounces-9336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67B281C44B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1832A1C24E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADFF523C;
	Fri, 22 Dec 2023 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYXMhgtw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF76539A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703220211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tb3jo9fkDistC/Bb96L+r4e+sXlv7gcKU05hItOf14A=;
	b=RYXMhgtwXwW2r6zbn16gz61BGTJaiGihSaM8FrWQ1lHL6/CQuYvnP834LxHj5dKMozWvQf
	yG7iLvKtVXkqcovbBJKVD/5wN2yfHiaxh6RKqg5e6KdLhWWLK3tRjSqOMZj58IF/79VRB5
	+EZHMpTPUlaI27Y43B4pGYDsD8445kY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-4YgbalVaMieTsIQCV4ItHw-1; Thu, 21 Dec 2023 23:43:29 -0500
X-MC-Unique: 4YgbalVaMieTsIQCV4ItHw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d3f1ca0850so6460265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703220208; x=1703825008;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb3jo9fkDistC/Bb96L+r4e+sXlv7gcKU05hItOf14A=;
        b=CXeN8bwxNUsEcEvoG6+PO9emJCg6aiqf8JYvRIbgpJomjYEtzui3l9ZgS/8yGCn5nY
         SDBkdyPIodyRU6YWrQANyP/YHTSScxyGWgKzOH/yc+Wld7xzdsKdfOeMUk3yYd+RlXzy
         FoTdYalvy/iv44OhpvlhwZPK/RbWZCuEyiDFbp0fB6Yef8PzXFTP5v3Jl2rO9XMm4UDm
         kH06Nbtz8Uh9C9ueF6poiKpsEdguTWg96BRszWROWuhEuuNISVF9hsvlSp9EaInrXtpo
         mMyZCjWbHF+LtlsgO+0usJUJRc3VxQ+NJXpIj9CnOMD4SqruK5Z6v+Na3pW/x8qvCMIe
         JNPg==
X-Gm-Message-State: AOJu0YzJ7CWKApZf7MCq0HgJ4cXp8zP0mIj8djRQUusGR2x/RrEnn9AG
	funOYsSdlCPZSzuD6gbHHqg5DXTmZatp81L4RwFAJQoCyDc8QYpZlOfC12kGGScOP9Y22kzVrkv
	zEr7br9oJKMUUOnjWdze6o4uA1x+uKJov
X-Received: by 2002:a17:902:780e:b0:1d3:abba:39b2 with SMTP id p14-20020a170902780e00b001d3abba39b2mr487019pll.55.1703220208130;
        Thu, 21 Dec 2023 20:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkXxqoVlDlQ8bIhrOzYju2iBkts8tdgjz0JPgCy8zVYER40SQLv9aGh31ntsmczzWYsMWeeA==
X-Received: by 2002:a17:902:780e:b0:1d3:abba:39b2 with SMTP id p14-20020a170902780e00b001d3abba39b2mr487010pll.55.1703220207808;
        Thu, 21 Dec 2023 20:43:27 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902704900b001d05456394csm2477010plt.28.2023.12.21.20.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:43:27 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 01:43:07 -0300
Message-ID: <ZYUT22KmGJ1tJSWx@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 12:26:19PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 11:35 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > directly.
> >
> > ok
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/processor.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > index f19f861cda54..1f538fc4448d 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -16,15 +16,13 @@
> > >
> > >  #ifdef CONFIG_64BIT
> > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > -#define STACK_TOP_MAX                TASK_SIZE_64
> > > +#define STACK_TOP_MAX                TASK_SIZE
> >
> > It means STACK_TOP_MAX will be in 64BIT:
> > - TASK_SIZE_32 if compat_mode=y
> > - TASK_SIZE_64 if compat_mode=n
> >
> > Makes sense for me.
> >
> > >
> > >  #define arch_get_mmap_end(addr, len, flags)                  \
> > >  ({                                                           \
> > >       unsigned long mmap_end;                                 \
> > >       typeof(addr) _addr = (addr);                            \
> > > -     if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > -             mmap_end = STACK_TOP_MAX;                       \
> > > -     else if ((_addr) >= VA_USER_SV57)                       \
> > > +     if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \
> > >               mmap_end = STACK_TOP_MAX;                       \
> > >       else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > >               mmap_end = VA_USER_SV48;                        \
> >
> >
> > I don't think I got this change, or how it's connected to the commit msg.
> The above is just code simplification; if STACK_TOP_MAX is TASK_SIZE, then
> 
>      if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
>              mmap_end = STACK_TOP_MAX;                       \
>     else if ((_addr) >= VA_USER_SV57)                       \
> 
> is equal to:
> 
>      if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \

I am failing to understand exactly how are they equal.
I mean, what in your STACK_TOP_MAX change made them equal?

See below, the behavior changed: 
> 
> >
> > Before:
> > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > - 0 < addr < 2^48 : mmap_end = 2^39
> >
> > Now:
> > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > - 0 < addr < 2^48 : mmap_end = 2^39
> >
> > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39
> > if addr != 0. Is that desireable?
> > (if not, above change is unneeded)
> >

^

With your change on STACK_TOP_MAX only (not changing arch_get_mmap_end), 
you would have:

- compat_mode & (0 < addr < 2^32) 	-> mmap_end = 2^32
- non-compat, addr == 0, or addr > 2^57 -> mmap_end = TASK_SIZE_64
- non-compat, (2^48 < addr < 2^57)	-> mmap_end = 2^48
- non-compat, (0 < addr < 2^48) 	-> mmap_end = 2^39

Which seems more likely, based on Charlie comments.

Thanks,
Leo

> > Also, unrelated to the change:
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > Is the above correct?
> > It looks like it should be 2^57 instead, and a new if clause for
> > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> >
> > Do I get it wrong?
> Maybe I should move this into the optimization part.
> 
> >
> > (I will send an RFC 'fixing' the code the way I am whinking it should look
> > like)
> >
> > Thanks,
> > Leo
> >
> >
> >
> >
> >
> > > --
> > > 2.40.1
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


