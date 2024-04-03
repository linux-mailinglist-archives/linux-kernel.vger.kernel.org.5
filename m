Return-Path: <linux-kernel+bounces-129142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDD8965CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2351C224AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA455E4C;
	Wed,  3 Apr 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB6P/Cqu"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C254744;
	Wed,  3 Apr 2024 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128502; cv=none; b=ii7seJsx23ocy9CVdj7iKqLz/VIrJCCWr6K4ukLqzJZnVsPBactruUDJdrl1CMz7gADJNtjd1/EVCGZ3Cqxd6M+ZbdNk6eV6OzvHu3FiDNutFD/hnHxv3CRdo0BzwbOFrcBO+fEAB/MZY0zhCpALqCR9vh+/Pai1mlYVVC4y2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128502; c=relaxed/simple;
	bh=eZE1WUPObM6XWEfXi56fAhtr6YphZUwOjMKiQg1rT28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOy0eAJgkQ4q8UpMfC13gEj001GsVU8PgC/VI5CU72nEnIiCj4oTOs4ysG8mkYwJlMCmJpTEzKwr8cvg+YELm/cxSBr0HTmfL8RON5o1QWit4PJIZ45Dqa6ISQ/T8RABXGTMbo6ksw1UTYOE1BmirrzXSHNJXKR9rgcaHh2wVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB6P/Cqu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430b7b22b17so37627531cf.2;
        Wed, 03 Apr 2024 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712128499; x=1712733299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZE1WUPObM6XWEfXi56fAhtr6YphZUwOjMKiQg1rT28=;
        b=hB6P/CquWNi/TK2xZ+et35ftWJgMjjRho+IILv1njB3Yr03KyghHGW2SIEoZWDJHX/
         n9Ec2oVB8ih/hGOJDUYCJy3st/sx8w3oN3Zbs9z/0A2ofrTcnxCbaQkD9+2FyTT2RD+E
         iFQDMk2k6/w0A5qdQ95YvIUASlvZpZDQ4+TGYAxv8J7rAYUY+EHxOQU5Z/Ha1vnJY0vP
         Vm5d7d96uZOCorx2dG+Zrs2BoaK2ifuXRns7eqNQqvIPaahShe1trhbhKfTBv/1d+Kv7
         BdlyWlUDLoQmUQ5RnLT2kfXeWUdbOyJ32/tH0rgdP1ja8BEhRDBfkFclWLlGaERmGN1R
         gyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128499; x=1712733299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZE1WUPObM6XWEfXi56fAhtr6YphZUwOjMKiQg1rT28=;
        b=E2ThMqm4jW8ks2bBrbM/rEqcV2HVvkf2AKwfzmDoAPlVeKrGgfNtXQ8nTh+Eq8ud+T
         BZMGG9fBiQ/XwikA62xSz68e2J8T+XTLUidBsE0Tp8VeJCozTmDLRntxcsH0a69DUQ4d
         YsH9L10wZ2KGd027x6tGJW8lpjKq7Kal6fRJ85e5xN5Y/ckRXS2nhR5bVrj9IZPqAKcn
         Q+N0T7jUp6oK1/1TCYBVaTvLp63EELq4njS2KmEtSZIyMbQya5G8fP9jkea1UVuH6CMY
         25Q9kbBYaOEZs0Q/qR1Jma4Hfbx+nwXM3W7MP0lb7TQ88p0bUO1VMsZe/8nlyLBJhNo5
         qk8A==
X-Forwarded-Encrypted: i=1; AJvYcCWbQccPNl+mHD0HugBeXXddmuugqbyflfNCicqYuFD8b4jXGvvQnCNV8fjWfddJsYJSSzDg3L9WO+iCMi+/1Mlmi+bGF/XD3JyVJxV6kP/jdTraGPYdXdZcmr3uS6gP1QciYuorOo0HZOBo
X-Gm-Message-State: AOJu0YygUSrI/UL70rbyggzYvp45FMdBPp6bnnoFCFGXLRoMvAciCm7Q
	5boljRcjVE7/OJwSUA1uMksfNl1l6kjnxBc/Te0PDwGb38je2LjZZ7Mi6XNShK/HSyhlf9VKYcK
	EsP1XR+8ZAHe7fGu4+S2vBa7oIi8=
X-Google-Smtp-Source: AGHT+IHyKNZwWr3vJFxmQHM+hwOlCqtBzmYisGR8eSHQwTIUZCsyuedimo1clXd+K+pFzqShHBl24vI+Dd+SmaEA0pI=
X-Received: by 2002:a05:622a:50b:b0:431:2a50:e15 with SMTP id
 l11-20020a05622a050b00b004312a500e15mr17564848qtx.39.1712128499583; Wed, 03
 Apr 2024 00:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
 <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
 <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
 <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com>
 <CAFGhKbzdWLw7fmRTLYPhEycWZvfjE-OCvnWct2A_kWVe94-p-A@mail.gmail.com> <CAFULd4ahxmEiJ37hLXUg3RwZMW9GnkN=38ZuirSq_cu3VHMU0g@mail.gmail.com>
In-Reply-To: <CAFULd4ahxmEiJ37hLXUg3RwZMW9GnkN=38ZuirSq_cu3VHMU0g@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Wed, 3 Apr 2024 09:14:48 +0200
Message-ID: <CAFGhKbzJ-icVy-YmPVSNd4O4AA-4QGiaYZWM+2T=xq5_-MB4MA@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Am Di., 2. Apr. 2024 um 22:40 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>:
[snip]
> > ```
> > git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
> > git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> > patch -p1 -i ~/p.diff.txt
> > git clean -dfx
> > make allnoconfig -j$(nproc)
> > make kvm_guest.config
> > echo CONFIG_MODULES=y >> .config
> > echo CONFIG_NET_9P_VIRTIO=m >> .config
> > make olddefconfig
> > make prepare -j$(nproc)
> > touch net/9p/trans_virtio.c
> > make C=1 M=net/9p/ trans_virtio.o CHECK="sparse -Wconstexpr-not-const"
> > ```
> >
> > This now shows the warning:
> >
> > ```
> > net/9p/trans_virtio.c:831:1: warning: non-constant initializer for static object
> > net/9p/trans_virtio.c:832:1: warning: non-constant initializer for static object
> > ```
[snip]
> It's this part:
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index d7779a18b24fc3..bf9815eaf4aabf 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -212,7 +212,7 @@ void ftrace_likely_update(struct
> ftrace_likely_data *f, int val,
> */
> #define ___ADDRESSABLE(sym, __attrs) \
> static void * __used __attrs \
> - __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
> + __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
> #define __ADDRESSABLE(sym) \
> ___ADDRESSABLE(sym, __section(".discard.addressable"))
>
> But ... how is this not const?

@Luc Van Oostenryck Do you have any idea how to correctly implement it
to make sparse happy?

