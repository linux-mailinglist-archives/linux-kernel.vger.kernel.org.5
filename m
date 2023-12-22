Return-Path: <linux-kernel+bounces-9438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA281C57C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2691C1F2587E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848CBE50;
	Fri, 22 Dec 2023 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N90IZcop"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C164BA3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703229753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTt+9iUZa1ry1u7dZuMvANKr2dvD8bziPbEHXPTEpgk=;
	b=N90IZcopE8qaU+s7HXei4fj1KNuNG6R/uHizEgQqt2DebhpxmFCivwo/FnGdl5PoLAjjq5
	po41Zx6ZVCASUJWUhy7gaVnjtz0oW6tlnQvNnOcVmZP7TQTPiElH5eXUgS3w5Pz6vJpqRF
	D7jdzvJhmxZQMwga3L29aUXBMTWJUgw=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Imszz2p_MiScscaaKTgvWA-1; Fri, 22 Dec 2023 02:22:31 -0500
X-MC-Unique: Imszz2p_MiScscaaKTgvWA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20366427972so1985620fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703229751; x=1703834551;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTt+9iUZa1ry1u7dZuMvANKr2dvD8bziPbEHXPTEpgk=;
        b=sbCV6+9RcDn19kxtqllo42qX7LohyASvi0EDT9rGGu6t2/o2x3i8CjXdLkSiNh/c0N
         h8KTSH3VZR3XxOqWiydZjyHnCQALJ7OKgTDoFiDuwtUSf5WhKWy8lhktsLcZ046nuo2R
         4itG+aRSU/Iqky2vsT2QWLyLyTB30QNZGxuPO/pgGxqz8slwgGSfxP5bJYtwJfHhp9/F
         LXV/d0ai5OGvLCvTDxSMIdSmboW8Xg+24IovQ/OPCyOfWb6HTzcuXClMy3en6oyrAjwD
         Fk9b9dS4id2S1Ce4nTpjqGD09Zu6bdch1bHSQvbBhmOjP8+DbKjvHZ0lGmRAK9csf7Oc
         PlAQ==
X-Gm-Message-State: AOJu0Ywdlz4vDMwl6091pgsnCVKGQuQWq3jjmNkbUF5T2nIGmcLOHtf3
	bYD+jenbOISagtNW8KRh2CJg/FP5pm5dDvhI8XmnBFmB+Ga5c8LhxEh7x5TbjT6D32Kppn+I/S9
	LH/FTOD0GS7EStdHEtmgN7meSTzXO16Wh
X-Received: by 2002:a05:6870:1686:b0:203:cb22:9758 with SMTP id j6-20020a056870168600b00203cb229758mr1303895oae.50.1703229750959;
        Thu, 21 Dec 2023 23:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/JSRJPFXgXyRgxXvKFED2AMV+29LOtLLqALCr/cz7qUisEfaTUszvi8YE4qAHtSRnGnvgWw==
X-Received: by 2002:a05:6870:1686:b0:203:cb22:9758 with SMTP id j6-20020a056870168600b00203cb229758mr1303889oae.50.1703229750744;
        Thu, 21 Dec 2023 23:22:30 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id v21-20020a634815000000b005c1ce3c960bsm2615943pga.50.2023.12.21.23.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:22:30 -0800 (PST)
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
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Date: Fri, 22 Dec 2023 04:22:10 -0300
Message-ID: <ZYU5InA7WcpGKaRF@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTQSZSWJ7qZQckuALHkcJb8kEGTnb8wJQ9H2wgODkN56Lw@mail.gmail.com>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-4-guoren@kernel.org> <ZYUVTFqvIIqv7D9O@LeoBras> <CAJF2gTQSZSWJ7qZQckuALHkcJb8kEGTnb8wJQ9H2wgODkN56Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 03:16:45PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 12:49 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 10:47:00AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Remove TASK_SIZE_MIN because it's not used anymore.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/pgtable.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > index 74ffb2178f54..e415582276ec 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> > >   */
> > >  #ifdef CONFIG_64BIT
> > >  #define TASK_SIZE_64 (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > > -#define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > >
> > >  #ifdef CONFIG_COMPAT
> > >  #define TASK_SIZE_32 (_AC(0x80000000, UL))
> > > @@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> > >
> > >  #else
> > >  #define TASK_SIZE    FIXADDR_START
> > > -#define TASK_SIZE_MIN        TASK_SIZE
> > >  #endif
> > >
> > >  #else /* CONFIG_MMU */
> > > --
> > > 2.40.1
> > >
> >
> > On torvalds/master:
> >
> > $git grep TASK_SIZE_MIN
> > arch/loongarch/include/asm/processor.h:23:#define TASK_SIZE_MIN TASK_SIZE
> > arch/loongarch/include/asm/processor.h:36:#define TASK_SIZE_MIN TASK_SIZE32
> > arch/riscv/include/asm/pgtable.h:881:#define TASK_SIZE_MIN      (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > arch/riscv/include/asm/pgtable.h:893:#define TASK_SIZE_MIN      TASK_SIZE
> >
> > I can only see definitions, without any usage, so agreed on removing them.
> >
> > FWIW:
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Thx
> 
> >
> > I would also send a patch for loongarch, since they are in the same boat :)
> Eh... I've sent one yesterday together.
> 
> https://lore.kernel.org/loongarch/20231221054624.2208019-1-guoren@kernel.org/

Awesome! :)

> 
> >
> > Thanks!
> > Leo
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


