Return-Path: <linux-kernel+bounces-9464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF681C5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD54C285FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B649468;
	Fri, 22 Dec 2023 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehIzeb0m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24CC126
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpTevB0OltACm1vWMEneYn7/ybFMTDRFwP2TO8aqlX0=;
	b=ehIzeb0myYLbuWPwRTuVZ/adKeta3QqIrBZIN6cXSymX5jL1fsLjQpRbxQkXmFXVcy8k0S
	lMrtKw32ukyT94jr0RQcGYpuHBCwwuyPsmZV8JkPBy0s+J5uk18a/qQsZjOJSdJtx7pu54
	S9DKFyKbj3OARNe9a0L/3X30SDoQRxk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-wXO1bSTQOamjNKuDOU58dw-1; Fri, 22 Dec 2023 02:49:28 -0500
X-MC-Unique: wXO1bSTQOamjNKuDOU58dw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cda0492c8eso1524982a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231367; x=1703836167;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpTevB0OltACm1vWMEneYn7/ybFMTDRFwP2TO8aqlX0=;
        b=KRsuQfe/bAiz20/kwiUovMlOVRqK+UukgWkY3TJh4OIrrOAoULTEzkcq/dcyNLqPmW
         ilfzdac3gSxsnrnPxGQmOTTdnpGiTO6KtA5WICO0ox/VBztyJy8oDhhJw6GWOtvTsotC
         MVKXZDrFpKeaCLDCmcO/2oEFXNuyTz8Yq+ObujcOP+Zm156rCvXrBbn6dW7q1kvNGKmc
         tDmFsqlbkR1CIP1/tOxWjDxg53KdUybEuhPaiQzHy8KiyzNfAYKh/qKF0u4VyUjSzNlw
         ExK3ZH8tkmdkBHGGM5rEhGktjRr5qPYu9oGPrgLsun/W13Hi2O5CC5fZfdp7mqU4MhL6
         +mbA==
X-Gm-Message-State: AOJu0YyvzOZd/77v32Z5eMbNS1d0eYZ0HbPMNHplv2t2KxWcDbJym7Kr
	AXoluuY0sNl5EeIpLXKttNec0Yz5OoeWmNUyXpaWxtdzLkLoBAdSHtQONW7GYor/Y72yukz+wvf
	X6FgVupB9Uhzyk1ZIRwcq7zOb/qlk5XRo
X-Received: by 2002:a05:6a20:471b:b0:18f:97c:8a43 with SMTP id ek27-20020a056a20471b00b0018f097c8a43mr939683pzb.110.1703231367585;
        Thu, 21 Dec 2023 23:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTVjH078mJcskjC5RvSLGFskWovJSny2sYuwP5d4jjjTNCIU4EOyqMc7rWoXuq7QFAPMBPMA==
X-Received: by 2002:a05:6a20:471b:b0:18f:97c:8a43 with SMTP id ek27-20020a056a20471b00b0018f097c8a43mr939679pzb.110.1703231367265;
        Thu, 21 Dec 2023 23:49:27 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id sr5-20020a17090b4e8500b0028afd8b1e0bsm2417484pjb.57.2023.12.21.23.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:49:26 -0800 (PST)
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
Date: Fri, 22 Dec 2023 04:49:12 -0300
Message-ID: <ZYU_eHpQzr7XGMNV@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTQ33JmhUZtr6nkAY5mXRxOEA88pXy1CHcU0jNMzcQZz_g@mail.gmail.com>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com> <ZYUT22KmGJ1tJSWx@LeoBras> <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com> <ZYUeU0URQvgw42jt@LeoBras> <CAJF2gTQ33JmhUZtr6nkAY5mXRxOEA88pXy1CHcU0jNMzcQZz_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 03:20:15PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 1:28 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 12:50:44PM +0800, Guo Ren wrote:
> > > On Fri, Dec 22, 2023 at 12:43 PM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > On Fri, Dec 22, 2023 at 12:26:19PM +0800, Guo Ren wrote:
> > > > > On Fri, Dec 22, 2023 at 11:35 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > > > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > > > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > > > > > directly.
> > > > > >
> > > > > > ok
> > > > > >
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > > > > > index f19f861cda54..1f538fc4448d 100644
> > > > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > > > @@ -16,15 +16,13 @@
> > > > > > >
> > > > > > >  #ifdef CONFIG_64BIT
> > > > > > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > > -#define STACK_TOP_MAX                TASK_SIZE_64
> > > > > > > +#define STACK_TOP_MAX                TASK_SIZE
> > > > > >
> > > > > > It means STACK_TOP_MAX will be in 64BIT:
> > > > > > - TASK_SIZE_32 if compat_mode=y
> > > > > > - TASK_SIZE_64 if compat_mode=n
> > > > > >
> > > > > > Makes sense for me.
> > > > > >
> > > > > > >
> > > > > > >  #define arch_get_mmap_end(addr, len, flags)                  \
> > > > > > >  ({                                                           \
> > > > > > >       unsigned long mmap_end;                                 \
> > > > > > >       typeof(addr) _addr = (addr);                            \
> > > > > > > -     if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > > > > -             mmap_end = STACK_TOP_MAX;                       \
> > > > > > > -     else if ((_addr) >= VA_USER_SV57)                       \
> > > > > > > +     if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \
> > > > > > >               mmap_end = STACK_TOP_MAX;                       \
> > > > > > >       else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > > > >               mmap_end = VA_USER_SV48;                        \
> > > > > >
> > > > > >
> > > > > > I don't think I got this change, or how it's connected to the commit msg.
> > > > > The above is just code simplification; if STACK_TOP_MAX is TASK_SIZE, then
> > > > >
> > > > >      if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > >              mmap_end = STACK_TOP_MAX;                       \
> > > > >     else if ((_addr) >= VA_USER_SV57)                       \
> > > > >
> > > > > is equal to:
> > > > >
> > > > >      if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \
> > > >
> > > > I am failing to understand exactly how are they equal.
> > > > I mean, what in your STACK_TOP_MAX change made them equal?
> > > #define STACK_TOP_MAX TASK_SIZE
> > > #define TASK_SIZE       (is_compat_task() ? TASK_SIZE_32 : TASK_SIZE_64)
> > >
> >
> > yes, I am aware. Let's do a simple test with the new code and
> > addr = 2^27 (random 32-bit addr) and compat mode.
> >
> > if ((_addr) == 0 || (_addr) >= VA_USER_SV57)
> >         // Evaluates to false: 2^27 != 0, and is < 2^57
> > else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))
> >         // Evaluates to false: 2^27 < 2^48
> > else
> >         mmap_end = VA_USER_SV39;
> >
> > mmap_end = VA_USER_SV39, even in compat_mode.
> >
> > We need the extra is_compat_task() if we want to return 2^32.
> Yes, my stupid, I fell into the wrong logic. Sorry for the noisy part,
> which should be removed.

Don't worry, I also do stuff like this when I am too focused in the issue 
:)

Thanks!
Leo

> 
> >
> > Thanks!
> > Leo
> >
> >
> > > >
> > > > See below, the behavior changed:
> > > > >
> > > > > >
> > > > > > Before:
> > > > > > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > > > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > > >
> > > > > > Now:
> > > > > > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > > > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > > >
> > > > > > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39
> > > > > > if addr != 0. Is that desireable?
> > > > > > (if not, above change is unneeded)
> > > > > >
> > > >
> > > > ^
> > > >
> > > > With your change on STACK_TOP_MAX only (not changing arch_get_mmap_end),
> > > > you would have:
> > > >
> > > > - compat_mode & (0 < addr < 2^32)       -> mmap_end = 2^32
> > > compat_mode      -> mmap_end = 2^32
> > >
> >
> > This is correct!
> > Yeah, since you changed STACK_TOP_MAX to be 2^32 in compat mode,
> > any addr value < 2^32 with compat value will return 2^32.
> > (without the change in arch_get_mmap_end(), that is.)
> >
> > > > - non-compat, addr == 0, or addr > 2^57 -> mmap_end = TASK_SIZE_64
> > > > - non-compat, (2^48 < addr < 2^57)      -> mmap_end = 2^48
> > > > - non-compat, (0 < addr < 2^48)         -> mmap_end = 2^39
> > > >
> > > > Which seems more likely, based on Charlie comments.
> > > >
> > > > Thanks,
> > > > Leo
> > > >
> > > > > > Also, unrelated to the change:
> > > > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > > > Is the above correct?
> > > > > > It looks like it should be 2^57 instead, and a new if clause for
> > > > > > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> > > > > >
> > > > > > Do I get it wrong?
> > > > > Maybe I should move this into the optimization part.
> > > > >
> > > > > >
> > > > > > (I will send an RFC 'fixing' the code the way I am whinking it should look
> > > > > > like)
> > > > > >
> > > > > > Thanks,
> > > > > > Leo
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > --
> > > > > > > 2.40.1
> > > > > > >
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


