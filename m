Return-Path: <linux-kernel+bounces-138671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A048089F8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B6285F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47012179217;
	Wed, 10 Apr 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My09kEbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C0179211
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756777; cv=none; b=aTi67dqKFedCFffHVWwE9e27RNds3iRYpZp4W0gTt9DdnBzQot7CGzyXT4LVd6eH4Y90tubjNt13KGVG1nXl7aoxmBAtaIy0jKrtKE/6CCHQ34yIgDdSZhx3lheJyKZA+Am61TMMOgwd8Cg4VZUxaazb7HEEeYB5fn7e9OrMoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756777; c=relaxed/simple;
	bh=HK7tzglHO1mGwIZMuKVgNT3TKyVNovyIlNjN9sB7whY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvTZehGQ97usqrnhC1mANJV0OkT2PnxqSVrAIO0JUsVpqPk9vr5aklITYRC6RCnkorfdUJXGnl15V8ND3hugv1m9R7TJWED6tqoD4wLrClcpHpfWlxzkQ6S2CxM2R+SiNNtf96Wa9unYt0aYrvYPqYUEVwcAcTMYzg1lWnNnMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My09kEbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F14C43394
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712756777;
	bh=HK7tzglHO1mGwIZMuKVgNT3TKyVNovyIlNjN9sB7whY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=My09kEbPVhjDZl664qcsJdW7gXUIQGFFMH21A6dwQPmEyesveeIR2zVScqK7XE/Bg
	 qYXak0758dSpAIqRMbuzB6ZC+mmWM3ZUauwr0VUg5heYigk4DyAhpgngiJg9gVgfYH
	 Rl00wiBsn6+CkTDGWrFJiOFlROPlLIArEkDmLKDk6MIdBRv5njVA+7usp9OV+VcmB2
	 JDVtFJxp9PdY//dnOejt1azVl8cMukZO+ZBQR23cgjzXZa1f/a1RzIvWr9Er6/iMxl
	 ofO4b7JeB3xCYKJGfIDHloo34zW/djIwCDnm+F8NO14i7SBoP1erbRUb3Ectdj9vbH
	 41yN2IQFAMg/A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d700beb6beso73299771fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUerSdqOiNyxlawlQYanT7vKpF+6+dQHOA9p3WH6O+OmvHIFo9X2Lusv1JHqqKQrUTF97wjJC6E2gg5Jmk0lJiNSc895kvDWHYUyVZH
X-Gm-Message-State: AOJu0YwyRF6mufl6bQIYUqTLWSYwN3uFTW6jeXzZZW4GiemhKVF0oC1U
	gCdF7uPzDskTsPUm1NUeAOZw3P9HnDu27S3nixptZlF6AtWK1Xec2nnPWvac/KZrn/JDbGIqMcE
	26c0GTaid5rIwtWrall9FmbtX2hc=
X-Google-Smtp-Source: AGHT+IECfMOOCBUWoptINFic3uCpGr5MyHFQaRahfPJbLZOaTa7xSLsUVlW89HW8gnyyTqi72/VszCj46hLgKLeFh6E=
X-Received: by 2002:a2e:91cd:0:b0:2d6:b0b5:bb12 with SMTP id
 u13-20020a2e91cd000000b002d6b0b5bb12mr2025156ljg.18.1712756775490; Wed, 10
 Apr 2024 06:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102520.348017-2-ardb+git@google.com> <ZhaM2N3EONa7tNgl@gmail.com>
In-Reply-To: <ZhaM2N3EONa7tNgl@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 10 Apr 2024 15:46:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEFDqaHa-St+3k3N+Ngxn=u7ovf4wfYnPdL8xzJSoiibw@mail.gmail.com>
Message-ID: <CAMj1kXEFDqaHa-St+3k3N+Ngxn=u7ovf4wfYnPdL8xzJSoiibw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Conrad Grobler <grobler@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:58, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The early 64-bit boot code must be entered with a 1:1 mapping of the
> > bootable image, but it cannot operate without a 1:1 mapping of all the
> > assets in memory that it accesses, and therefore, it creates such
> > mappings for all known assets upfront, and additional ones on demand
> > when a page fault happens on a memory address.
> >
> > These mappings are created with the global bit G set, as the flags used
> > to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
> > defined by the core kernel, even though the context where these mappings
> > are used is very different.
> >
> > This means that the TLB maintenance carried out by the decompressor is
> > not sufficient if it is entered with CR4.PGE enabled, which has been
> > observed to happen with the stage0 bootloader of project Oak. While this
> > is a dubious practice if no global mappings are being used to begin
> > with, the decompressor is clearly at fault here for creating global
> > mappings and not performing the appropriate TLB maintenance.
> >
> > Since commit
> >
> >   f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")
> >
> > CR4 is no longer modified by the decompressor if no change in the number
> > of paging levels is needed. Before that, CR4 would always be set to a
> > known value with PGE cleared.
>
> So if we do this for robustness & historical pre-f97b67a773cd84b
> quirk-reliance's sake, I'd prefer if we loaded a known CR4 value again,
> instead of just turning off the PGE bit.
>
> It's probably also a tiny bit faster, as no CR4 read has to be performed.
>

Fair enough. I'll go and change that.

