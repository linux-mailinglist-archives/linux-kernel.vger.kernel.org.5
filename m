Return-Path: <linux-kernel+bounces-9804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C009081CBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9691F26C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E852375A;
	Fri, 22 Dec 2023 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWzzLhQm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0623745
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e6c86868so15907165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257358; x=1703862158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6dm7WMM/NFGIZP+OY+8wDbWwQqcxE0Rs1FBVgsjsyc=;
        b=jWzzLhQmn9tgwFKi360TpwbGKE5BBxFAZ3nacR2HBOpI+qNw8PeHxcWYF9+1KlCyPc
         6CgkNqegYbrJXF6NwxG5nrOwGk77hDZendT1a6LTix2zuDP+LA8E5m3RxdxRkH0ajKob
         j6ZQv6ftb9HlLFSO5j6lYgib1rbl18kSEjJNE9CRDL0aWltHd/0aT8jrj2MlWVcIsww/
         /gVhprxYcLcK9OtMy+fmNadYhW+0BOnhptOaHI3Gy5PuFE3vOfuBoyMKPLczr+leWlcR
         V5CQvS7I2VCxam9O9eAR+Wpjtu3meOxRyHlHowGSJ884Vr6EHOLDrEyIEGVoPtQOD7y7
         YCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257358; x=1703862158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6dm7WMM/NFGIZP+OY+8wDbWwQqcxE0Rs1FBVgsjsyc=;
        b=GcqTJJ3n/dKndBaoGXgzROsJYHjgj1MkSNKEEVJNQRrkSIQzqgXiA+h/QUa+qVY9ot
         Nbn7GZXMbnQHIbdQFqgc2qoWKQXwSMW5r/BuqR7uMliIHVaRRFlFp03AOVlknJxYkN29
         t2yHoYjPGxb1siuL77zWW/e5JWHpTT9SYXt/7MNzct/+GquEgriAi54FVFIMiZIx9Ra6
         MpqjbbWfSUaNahY37uAK6pnNM5iXd2ZeKi11g6QBdOGd3nXXY6+XVi72XTUmNvnu26Lh
         zWESypxXEsQ0BILZNFfy2vG/Ej8gua9B3Vccv6laCkreTIl4pHooI6NNlt06mPZkOp7y
         NtZQ==
X-Gm-Message-State: AOJu0YwT3Oy4AL3JmamUtzuLm2/rN6dMo+w7MVjZWqWUoFCIc6h/1RIx
	9TLgiIV56R7tpBtlm7VFngM=
X-Google-Smtp-Source: AGHT+IGqGk74vO9va6NONHyTYfJhbSWKFtLl13+mwBHu3+2bItAQM4AY5E2mDdfrHXIgvZiXk+wJOQ==
X-Received: by 2002:a17:903:114:b0:1d4:1b8e:30d1 with SMTP id y20-20020a170903011400b001d41b8e30d1mr1183931plc.29.1703257358343;
        Fri, 22 Dec 2023 07:02:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id jk7-20020a170903330700b001d3e992000dsm3587176plb.220.2023.12.22.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:02:38 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	horms@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] x86/kexec: fix incorrect end address passed to kernel_ident_mapping_init()
Date: Fri, 22 Dec 2023 23:02:27 +0800
Message-ID: <20231222150227.95193-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221140300.4fcfd4945eeb3b6c145a969c@linux-foundation.org>
References: <20231221140300.4fcfd4945eeb3b6c145a969c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 14:03:00 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 21 Dec 2023 18:17:02 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > kernel_ident_mapping_init() takes an exclusive memory range [pstart, pend)
> > where pend is not included in the range, while res represents an inclusive
> > memory range [start, end] where end is considered part of the range.
> > 
> > Therefore, passing res->end directly to kernel_ident_mapping_init() is
> > incorrect, the correct end address should be `res->end + 1`.
> > 
> > ...
> >
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -44,7 +44,7 @@ static int mem_region_callback(struct resource *res, void *arg)
> >  	struct init_pgtable_data *data = arg;
> >  
> >  	return kernel_ident_mapping_init(data->info, data->level4p,
> > -					 res->start, res->end);
> > +					 res->start, res->end + 1);
> >  }
> 
> Thanks.  When fixing a bug, please always full describe the
> userspace-visible effects of that bug.
> 
> In this case I'm assuming "none", due to kernel_ident_mapping_init()'s
> upward rounding of the address?

Passing [start, end] rather than [start, end+1) to kernel_ident_mapping_init()
may result in the identity mapping for the end address not being set up.

For example, when res->start is equal to res->end, kernel_ident_mapping_init()
will not establish any identity mapping. Similarly, when the value of res->end
is a multiple of 2M and the page table maps 2M pages, kernel_ident_mapping_init()
will also not set up identity mapping for res->end.

