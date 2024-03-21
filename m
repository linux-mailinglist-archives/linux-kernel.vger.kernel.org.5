Return-Path: <linux-kernel+bounces-110769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E729D88636B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B481C226B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E14685;
	Thu, 21 Mar 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUdJn0ad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1115CB;
	Thu, 21 Mar 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061034; cv=none; b=GtpOKvRl0O5irkhcvaAxnLkQzneFuhTofeSl65MQ/PIT1LWlC3OB+oWb1sSSqJpZsqNHJfpOhWnuJgzrbAFNa8xkk+Tz3ZCD+jO76Wvj2HkvlI/mUlLdxLEw5A73JLyZkEoO+PIwcDLK4ZmZAmR6FSksD92/IegBbTcDeGk8/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061034; c=relaxed/simple;
	bh=9YLEvPVut+aEhkwjdQYiPaE9xdwsFeRs7v8R3ObEQmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPizfZHo/vYQzn76Lkss6CPaZkNdq95vco2qZ3Xg1OJUcRnPWHAodCdDgnUAlVFpqd0UklbtZzOBRjDjTMMjQOV8W9f0DSE2xLuOgNxR4rPokjclecyACBmMSabEJWbP/ptMFoxRE4NRi+kfO6uFYkVRh+7z4TGGgWyCRmqvLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUdJn0ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506BCC4166C;
	Thu, 21 Mar 2024 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711061034;
	bh=9YLEvPVut+aEhkwjdQYiPaE9xdwsFeRs7v8R3ObEQmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VUdJn0adZJJQHfherYOceG2h1ETcDR1bhdhtJsUxs9wVLJSsBcSTZ+/1ksbxDTDSq
	 u3BLCFckXqhRyGjAHy7B00ZhHsoJ84oxk+VivG6HA85k4002ivBPtLrPFttalcOTHb
	 MxgdenyKDhWltvBzPmylYbn6xIbdV7oHVeZSqEykOsiVZlknfmP+a2tbc92B/5GGtb
	 8bTelp6jMGCN6wblwCuHNnmIcYOVb04Q5kB3NjlZsONvFWRg+5msMIp8DTnB4krI/q
	 sGlUOSSGCIcblL7b0fpCtaVG2xywFwgRG453BreOhmaPKhHT3qXl1ypQF4Zc0Xv9ro
	 1igrJ9OYG6U8A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-514ba4e5640so2458776e87.1;
        Thu, 21 Mar 2024 15:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiQS2JKp8OzSNY1t5GdGYlPFVIMPmdpoCY04e/w41vSwgxzC3Qu3PxAsBDYC4VYUJPDb85INVD2ddLct/nSNtUlePFebEH7wlPkJRnSULaqBVUaAOganHIlCAJCVjMGGoYeKH3199Karv5DRpR
X-Gm-Message-State: AOJu0YwF0z/ctPHIt0BoQOVVYjdb1kNwdFFebFH3fg9QRMT4zdnVDB+p
	MQ8AEK2/w9q5Th41Ty1kYemQ3Lr9bkWSHWWSIXnrVwm131SZKe3ZcgiH2Q2AGFcKOeXyrUFowFZ
	SLsGkpiQg7awj2uNsR0xqoZXPUHk=
X-Google-Smtp-Source: AGHT+IFEt+m2d6qmvyuzhfq9miPm16KRAZyNPzt4/1WPHVMW64H38oH9/SsT+7om4AyuYaPbm+lS1yoJfQEihUk7sDQ=
X-Received: by 2002:a05:6512:249:b0:515:8d79:1b37 with SMTP id
 b9-20020a056512024900b005158d791b37mr108001lfo.4.1711061032487; Thu, 21 Mar
 2024 15:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk> <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk> <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com> <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
In-Reply-To: <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Mar 2024 23:43:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
Message-ID: <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: David Laight <David.Laight@aculab.com>, Jiangfeng Xiao <xiaojiangfeng@huawei.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "keescook@chromium.org" <keescook@chromium.org>, 
	"haibo.li@mediatek.com" <haibo.li@mediatek.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"amergnat@baylibre.com" <amergnat@baylibre.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"douzhaolei@huawei.com" <douzhaolei@huawei.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"kepler.chenxin@huawei.com" <kepler.chenxin@huawei.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"nixiaoming@huawei.com" <nixiaoming@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"wangbing6@huawei.com" <wangbing6@huawei.com>, 
	"wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>, "jannh@google.com" <jannh@google.com>, 
	"willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 12:24, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Mar 21, 2024 at 10:22:30AM +0000, David Laight wrote:
> > How aggressively does the compiler optimise 'noreturn' functions?
>
> I've seen cases where the compiler emits a BL instruction as the very
> last thing in the function, and nothing after it.
>
> This is where the problem lies - because the link register value
> created by the BL instruction will point to the instruction after the
> BL which will _not_ part of the function that invoked the BL. That
> will probably cause issues for the ELF unwinder, which means this
> issue probably goes beyond _just_ printing the function name.
>
> I have vague memories that Ard has been involved in the unwinder,
> maybe he could comment on this problem? Maybe we need the unwinder
> itself to do the correction? I also wonder whether we should only
> do the correction if we detect that we're pointing at the first
> instruction of a function, and the previous instruction in the
> text segment was a BL.
>

First of all, I consider this to be a defect in the toolchain. Given
that the compiler knows that the BL is not going to return, it should
simply emit a BRK instruction or similar after it. This would catch
inadvertent returns as well as eliminate this kind of confusion.

The ARM unwind format is not really suitable for asynchronous
unwinding, so unwinding across exceptions is always going to be hit
and miss. Also, we should consider what the unwind information
actually tells us: for debugging, it is useful to understand where we
came from, i.e., how we ended up in the situation where the backtrace
was triggered, but what it actually tells us is where we would have
gone next had execution not been interrupted. The latter notion is
important for things like reliable stacktrace and live patch, which
need to know where a task might be returning to.

Returning to the first instruction of a function is unusual, but in
the light of the above, I don't think we can assume that it means that
the call originated from the preceding function, even when it ends in
a BL instruction (although it would be highly likely, of course). The
tracers and other instrumentation might insert probes in the return
path, and I suspect that this may result in a similar situation in
some cases.

Given that this particular issue would just disappear if the compiler
would just insert a BRK after the BL, I'd prefer to explore first
whether we can get this fixed on the compiler side.

