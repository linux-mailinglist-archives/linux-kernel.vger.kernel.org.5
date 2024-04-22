Return-Path: <linux-kernel+bounces-153973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD8F8AD577
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE76B24419
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1B1553A6;
	Mon, 22 Apr 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7FTY0wR"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE7155A5F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816045; cv=none; b=OrC/4vhb6EgHQfufJMtSuhLvSJR0w/GdZcwcjPiiiqn3s2jKjyOCt71bHkHc2NO4mF6zrhmomzLFU+dIeBHmY3xsn3tTGwDYKKQuf+YKwa0aDQOq41ZSZgHdDb5bE5mLb7QSuvPBIm55q8HRcTdi/8bXf028JQE4IN2yGPUHeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816045; c=relaxed/simple;
	bh=w73HfiYnWwpu22cet+/ZAEMnJZalyDlZClVTYCzYQA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHnUTWKCsSHbGZ8q1gbSUm+9PpiLMCt/CHhbgGTnM4lpf2cWvSPOAHheYEhKoZ43nA2dlsHMQHcWuy+zj4ipT8I5LV5Fx4jbtbw/Rtn1N15ruw+BRmZJMzg2DbFkFf3+hTQL/RfnqiwHDYzwHrvcXqJzDJ7fc6nse/RFD7Snn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7FTY0wR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7906782388aso137539485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713816042; x=1714420842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uaIorGvibEPapT+EI3puYZViKeGUbEeX94MZujzW9xA=;
        b=W7FTY0wRc4hkcu3uzx4woDcWDThTtFuNbo31ODgJ2VsNkqv/ZSZEAnFIf+1um6MUP4
         YP4qZq4/e8IkATAcrsql+EyIPQHWDIr7R3MOEoEpyNCE7ZbbA7L5furfC6/AarQuz1AV
         MCFRoY1JavAixNzRUyIpBBdJsx7FzP896LJS7raH4PA6f7jDA++mSWhb0cixTNQoRgwk
         jE+JtShZ413rpOJnybzksXZcd+aCoZ2LjOp6IZDRPZ58Sr9PuQHRMcyYqLbrZyEnZcrZ
         Xcj9PDmXoogBnN4welUXzBGzS6J99ffDLXgjTeU8IYh/2f02gCsqS0eP8/DmYtekekl2
         YXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816042; x=1714420842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaIorGvibEPapT+EI3puYZViKeGUbEeX94MZujzW9xA=;
        b=wiRxXzsbA7P6NpxbvV6i0CEaj+uOTWhKjH4Rpo4JzQONWHoHu/kdhKQYR6kyKmLd1Q
         hfOJABieYAKrUgJ/1VM5zqX28bFgT65F4uKQdHJLTd8U71og1uhp5QtlgDgvWQD5YMHd
         AOX2n7Oumfr+f6OLxaYNp5NDlSN2WDkZz6IIymEZiiN4LzC/3VkeOU6lzxsYETBzZ9LT
         9RI6FPCB4Fn73BBEtagdNE8wXdMS8B83Nt2e/EZ+eTSLXFGPxo3wl6+5/UZ3ryvRPuDg
         ymDlt+/90WrpJ5GRgtcRBUH3wE6bhk3JlZaJS6t+kIy50nUs0tNZ4xDc0xbfC3VPERRr
         Z4sw==
X-Forwarded-Encrypted: i=1; AJvYcCXUMxKO+6u31LEF5k5Wp7Acak3OxKW89ciPOjWRzBycQURdJKehx2Do0Vq0JKVh+D5FcYcRoNczGGkzXfb8K/LJwBbUlYZQS9cG1F2+
X-Gm-Message-State: AOJu0YywAMnhuKjMg76GPDyBBM9QlJ4jZE6yitllED0itlnNVsM2pOsU
	on3npvlxUoVH3PBd/c0fA8vV3HbQ2hubfg79aMjvbS4YoPa2/ELW
X-Google-Smtp-Source: AGHT+IFbcUNJPgqRtVFsMfYMFpb8EP2I+lD+BBayex+qFWeXrsrwGf9k5KCTR6GC3EDUljBvSe7QLA==
X-Received: by 2002:a05:620a:5792:b0:78d:6ef4:c790 with SMTP id wk18-20020a05620a579200b0078d6ef4c790mr12556186qkn.30.1713816042539;
        Mon, 22 Apr 2024 13:00:42 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a0d5600b0078d5a756e61sm4585493qkl.60.2024.04.22.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:00:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B806C1200066;
	Mon, 22 Apr 2024 16:00:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 22 Apr 2024 16:00:41 -0400
X-ME-Sender: <xms:6cEmZh_0SCUx0RYJ-9b7lNBTFreyORtqwUODVThZUUFihlASsrMW6w>
    <xme:6cEmZlvn7aH0gEd92l-R9r2PPZetCr5a5cajF8oK23ZMQcH5qOVq33b5aPh2klq5y
    NriIjY-ji7KjsOIyg>
X-ME-Received: <xmr:6cEmZvCba9kSbL99Xfb2Wx_gq8bOw1alP5j2pganEmjMdSarCQD_fh70hv1qJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfel
    feehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:6cEmZldxDmfjGahBWWTD4eFh67ryFmQe_9FDVo_tHAF30S3FxKe5Hw>
    <xmx:6cEmZmMwcgXV3ttL_YOinbregSCZzuutkYpe1wXPLqjEeVLIfI_1tg>
    <xmx:6cEmZnkoQt9029iYozSrD3xh1KLAZTj4ccSCB_WkoBTlEna2ShkhMw>
    <xmx:6cEmZguDsS8RGyqvuG-mYe19rWzoWG76Cu99K79zVeu8NItprNtkbQ>
    <xmx:6cEmZot6JSv3ETuXiH8ukJYDvXlRdJ1iVVGa25lJuqF7LvTt6BU7AhG9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 16:00:41 -0400 (EDT)
Date: Mon, 22 Apr 2024 13:00:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
Message-ID: <ZibB5zp5DcCmC9gP@boqun-archlinux>
References: <20240422151752.53997-1-ubizjak@gmail.com>
 <Zia-VeObR-m6Bf39@boqun-archlinux>
 <CAFULd4ZhTAY9irw8V=MLZpjQK+q0AM_Aw8g2E=ivHjv7+5m9Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZhTAY9irw8V=MLZpjQK+q0AM_Aw8g2E=ivHjv7+5m9Zg@mail.gmail.com>

On Mon, Apr 22, 2024 at 09:57:04PM +0200, Uros Bizjak wrote:
> On Mon, Apr 22, 2024 at 9:45 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > > diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> > > index 466af57b8ed6..0a985784be9b 100644
> > > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > > @@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
> > >  #define PV_UNLOCK_ASM                                                        \
> > >       FRAME_BEGIN                                                     \
> > >       "push  %rdx\n\t"                                                \
> > > -     "mov   $0x1,%eax\n\t"                                           \
> > > +     "mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"                \
> > >       "xor   %edx,%edx\n\t"                                           \
> > >       LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"                            \
> > >       "jne   .slowpath\n\t"                                           \
> >
> > There is also a "cmp $0x1,%al" afterwards.
> 
> Not anymore. Please note that the patch is against -tip, where we have:
> 

Oh, thanks for the information. Maybe it makes sense to mention the
patches dependency in the commit log?

Regards,
Boqun

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=91095666125a666c8f20c2323b742c53165c0325
> 
> Thanks,
> Uros.

