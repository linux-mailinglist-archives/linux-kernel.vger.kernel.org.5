Return-Path: <linux-kernel+bounces-30585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84483210B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0942861EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBD2EB09;
	Thu, 18 Jan 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QriCtqnW"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED312E405
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614527; cv=none; b=bA4faapk8WdykkFytHAtm4puMLNcW85yJDzSH5hvsfUOvqnFPCL5VD7bkhj4rrJlWaAYoW7dKBV5ty6wAsrrv5gwPyIRpaw7YTmc5DSjozTcI9HR31a+qqVTGQq/R9rC1sH5y4VHlfLEvfT2hVakF1hi17XEzQTqzAiBiuytSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614527; c=relaxed/simple;
	bh=Edof3HGd9iGAuFabvWL99OAkcFUpbmsJtzrwMu87x4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXCjG4Uvu04gfo4b8xhaKKQCta2m3GpmsmxMbcCMFYYkxAwLoU82BJunCjDRLp1TmBkjTnFKM3jYrCVuWEr4P5I3RBsIpoJSFaYTc91H73bdDAYEY7iNV9Nj11Ooq11WPKvnLn3vn+pzYGLU+59GRJN2p2dir4j7JB9Zv9B2bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QriCtqnW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f0629e67f4so1043167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705614525; x=1706219325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGdgVUyAK1aAflsT7iZ9NPgtBe4T35/dr8bobRRTOjs=;
        b=QriCtqnWa0JFJYhdyTC5SrfQf+2ZVQ7K+shHaG9fJKOCsZ5/sPOrU3Ej2mErbAblm+
         PjwLeLho2baY4Z+Kz4Rh4zSFj1PbDZgMZF5SyUEN4QviNGzosm0lE+YMnK6zPO5LBlyF
         bkP5OZX6+rv3JZc+yvod3AZhWfF8KYSV0yj/K8p3dG4btpYVPNVp4XXuHbNcSrV+yI/g
         6u5H/GpMHj8Ud0tBSbixbErjj7IcwS/LiIRv26lDW8IJaX/u0X3sG2FWLjxXwl0kuN6C
         J8JyT9TIb6oHyAdfrXsX0imPhMR0eoBsy/r81QqGWYh6OsU5HPuvS0w+UH/QDLCZ1QRG
         O2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614525; x=1706219325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGdgVUyAK1aAflsT7iZ9NPgtBe4T35/dr8bobRRTOjs=;
        b=A9SH6Uszirn9N1MP/1qBiPUKwT3PAlP4H1fPKxy0l4Q0Q3x+eqhO/qgd8NP4I+0jOD
         FyFxC8iBZEModQZUXCX3KHszmhSkhjDVOk4caP8TPw1ptqBRyCMWI+3mBaDrXkR/3j4e
         W/FTrGh6uiF78k9h/KEkEqgMrVQQEtGI5eeKXacai2i3evy7ETYUETNEuNCBtQDkfqoJ
         Z9SJscPy+zkL8ocieiPs/RETzh/rDPsNtCVez6NEZUPsCRVcmSQPLe4YWKjThtc4wwYz
         BNsyMofZjHxLfkpvvta2d56dCrNfhvuq2sn81PhuIuBT79oXNSMrOtCc/YHiUNtrMsJw
         i5sA==
X-Gm-Message-State: AOJu0YxCzXR3MgdtT7VmPnPyKp+V3SYNjQ9u/0YtKlHGmYhoj63V9ADu
	aqdzMFJC2zZfyRa0jyoJ3wBHA6KSTRenwlYj7W50C2yxZR6IDpSQ
X-Google-Smtp-Source: AGHT+IGVMDVZxgqMFbHQywDUbtvVUzwbz++sS9yXUzkKQh4cCDaE3ihLfZ8Q5uFdp6tk6+OzvG/wuQ==
X-Received: by 2002:a81:c20e:0:b0:5ff:958d:5b2 with SMTP id z14-20020a81c20e000000b005ff958d05b2mr955427ywc.51.1705614525244;
        Thu, 18 Jan 2024 13:48:45 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:b45f:9648:c2e:2e36])
        by smtp.gmail.com with ESMTPSA id p207-20020a8198d8000000b005ff60d85d1bsm2147803ywg.80.2024.01.18.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:48:44 -0800 (PST)
Date: Thu, 18 Jan 2024 13:48:43 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	intel-gfx@lists.freedesktop.org,
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: Re: [Intel-xe] [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK
 and BIT macros
Message-ID: <Zamcu7tts8mqX0b4@yury-ThinkPad>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZJOwC5LIEySpduQJ@yury-ThinkPad>
 <4ezps56sdj7fmr27ivkaqjakv4ex46f5cvmy6oqr3z6gkhiorl@us4qd53jzq34>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ezps56sdj7fmr27ivkaqjakv4ex46f5cvmy6oqr3z6gkhiorl@us4qd53jzq34>

On Thu, Jan 18, 2024 at 02:42:12PM -0600, Lucas De Marchi wrote:
> Hi,
> 
> Reviving this thread as now with xe driver merged we have 2 users for
> a fixed-width BIT/GENMASK.

Can you point where and why?
 
> On Wed, Jun 21, 2023 at 07:20:59PM -0700, Yury Norov wrote:
> > Hi Lucas, all!
> > 
> > (Thanks, Andy, for pointing to this thread.)
> > 
> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> > > Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> > > masks for fixed-width types and also the corresponding BIT_U32(),
> > > BIT_U16() and BIT_U8().
> > 
> > Can you split BIT() and GENMASK() material to separate patches?
> > 
> > > All of those depend on a new "U" suffix added to the integer constant.
> > > Due to naming clashes it's better to call the macro U32. Since C doesn't
> > > have a proper suffix for short and char types, the U16 and U18 variants
> > > just use U32 with one additional check in the BIT_* macros to make
> > > sure the compiler gives an error when the those types overflow.
> > 
> > I feel like I don't understand the sentence...
> > 
> > > The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
> > > as otherwise they would allow an invalid bit to be passed. Hence
> > > implement them in include/linux/bits.h rather than together with
> > > the other BIT* variants.
> > 
> > I don't think it's a good way to go because BIT() belongs to a more basic
> > level than GENMASK(). Not mentioning possible header dependency issues.
> > If you need to test against tighter numeric region, I'd suggest to
> > do the same trick as  GENMASK_INPUT_CHECK() does, but in uapi/linux/const.h
> > directly. Something like:
> >        #define _U8(x)		(CONST_GT(U8_MAX, x) + _AC(x, U))
> 
> but then make uapi/linux/const.h include linux/build_bug.h?
> I was thinking about leaving BIT() define where it is, and add the
> fixed-width versions in this header. I was thinking uapi/linux/const.h
> was more about allowing the U/ULL suffixes for things shared with asm.

You can't include kernel headers in uapi code. But you can try doing
vice-versa: implement or move the pieces you need to share to the
uapi/linux/const.h, and use them in the kernel code.

In the worst case, you can just implement the macro you need in the
uapi header, and make it working that way.

Can you confirm that my proposal increases the kernel size? If so, is
there any way to fix it? If it doesn't, I'd prefer to use the
__GENMASK() approach.

Thanks,
Yury

