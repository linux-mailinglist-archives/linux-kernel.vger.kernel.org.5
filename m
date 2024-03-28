Return-Path: <linux-kernel+bounces-122933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0D88FFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7451F2584A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C97FBBA;
	Thu, 28 Mar 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6qtWtdy"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AF224D0;
	Thu, 28 Mar 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630686; cv=none; b=irNWE9PkSA7kwcAjUPDolwkdLiT8wXBfvQIGuse+22KqutYLpySN/GR78IHykl5oWMWMHndt7VSLQa9e8319PmrNeLdTn8mEPfubd83uXJpi/ETvABttTAtwhBLkgqtSIpVq8I1VE8oAApJBzYb1FwjtwcmFNFuFps/59Gdm/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630686; c=relaxed/simple;
	bh=HAGqj7QpufjusPZt09mGu+og4GXNDKDPRj5hMiJXApU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrefuvLQIejBhIpR9IW3ZV7mED6l6WPOrGvBvbSyVI312j/m4IAGu5Wz7gz6q5BDmPeSn9kr48CMqIzHYX2t0Utjah7/6UFIuNt1bhDE2zjE6i/kbIPiH5NZUqU/jnaiKfozdPcp/w3C/g7KI7DBtixWhJyxIRMYsJOpB1CPsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6qtWtdy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609eb3e5a56so9734307b3.1;
        Thu, 28 Mar 2024 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711630683; x=1712235483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OlSNbbIVZdwNlWbGRGrNqpMFsqc6WZwwh4eW2yeG850=;
        b=Y6qtWtdyV5qnzSc18mnU3yOCoOD5491Sc70GvIWFes8Nxwhm2E48JOmTNJMpzySe/H
         uv2Exx6s02E+e62FJTQqeg4kbUTm3u3JBwY6AaC+yThyqyeEVBWZFjxIj/LDJKpzYOxx
         yyq54Rrmqn9KF/yKQLSM2ZcHq2/wu38N6mrR5T00IZHJANyMw4xceeeZs5yBxwBpoNv8
         OwCRNrUC83awADViLwxIP/7SHo2Ej+uV3GQr+jdtaBz6LFBtyvDED8+BZKr1h1pZh0BC
         Y7HwFbPqI81NsMrYsOD00fhC+4BTUsPOiGi8emYJCNrGKaOBxvB1WcRKTPyrUmW6JHwK
         F2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630683; x=1712235483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlSNbbIVZdwNlWbGRGrNqpMFsqc6WZwwh4eW2yeG850=;
        b=UtHoUvZuzo1wLgwwECLmgBdRuGGxsOhxnIfFjyK0Gjf/9Luk7wUha5SeW9+PSqR6Eg
         U5ieIIwFjvUCV+gL3agChQ9dvDv5++ffniF+66c6VunSN/2JiBlNsf8kYwtZrdhQ29sX
         c1sJ0MLSnJPtja67jmtYrXcitXtDQ+8QPiLxQZPsDteiMGZwrn3vgS8D3cL1ZsQ6r8Od
         R7ExyrISKRxOFg3W4HAvCmOFo3kR1L5zd0yKWeiTCq59kQlzCzfk4r/DvtQN98bvRbnj
         EmaeXpduMOoZc9HN0TXMARzUYMJiTlpH5/jJNjxvmhx7S1KtuA0mnJKICQTPbXtYDvke
         48Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV1F+xUyZ8x3Jtp76ICsQymXbwa9f5j9hz1nX0aGvGEyZpbRSz3ShQY2hdt22BlQ4cVNF7NBVySr3bKaKT7Jfo5EL+38TdXlss+a/oFr+d0ObWHdBLeiro/mLh+4TJQgPW6A6dbtTNDRkK0UlQ=
X-Gm-Message-State: AOJu0YyLyj6gNUxvpipSughWWWHnIKkz1xLyb9/dnahPwR85BRuOWtwC
	pc038R8iK2lVrddjCizh8N/rSEJyDPQT+VU9XkFKEiSnrSmmWFx1dtOG+bmyBbzAnzN1MqLYuIv
	uWDx/FLZTpED4afo+p2e71P6JtNo=
X-Google-Smtp-Source: AGHT+IEO4duWsHC7Bayh/OJwoGfH7O9EIU+fDRQ+MHe/RvmpkqXr6g0DZoEnTFBKONYbAQew2hlfT+PE36uFu3LLmGs=
X-Received: by 2002:a81:7b86:0:b0:607:f09a:d298 with SMTP id
 w128-20020a817b86000000b00607f09ad298mr2540381ywc.42.1711630682873; Thu, 28
 Mar 2024 05:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327032337.188938-2-wedsonaf@gmail.com> <20240327081317.45574-1-kernel@valentinobst.de>
 <CANeycqo9noMJGSCsjCoH29xuPTJ7NEmYnFBE__9D+tvaqsiLdQ@mail.gmail.com> <nNO5IHIkY0ti-c5334QC1qNmxmomUn7FpPoq7gw8rrty90n8s5j0r0a8opXAQL2SBBU5ZI3Bni3W7p0i4jnoPZjxQqPTcmv3qYt1emMZ4kQ=@proton.me>
In-Reply-To: <nNO5IHIkY0ti-c5334QC1qNmxmomUn7FpPoq7gw8rrty90n8s5j0r0a8opXAQL2SBBU5ZI3Bni3W7p0i4jnoPZjxQqPTcmv3qYt1emMZ4kQ=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 28 Mar 2024 09:57:52 -0300
Message-ID: <CANeycqpz59mxtbBF_0_XM6hMwGaD+RMPT_ks5XKWpeBd5MZjPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Valentin Obst <kernel@valentinobst.de>, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, walmeida@microsoft.com, 
	Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 12:56, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 27.03.24 15:23, Wedson Almeida Filho wrote:
> > On Wed, 27 Mar 2024 at 05:13, Valentin Obst <kernel@valentinobst.de> wrote:
> >>
> >>> This allows modules to be initialised in-place in pinned memory, which
> >>> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> >>> registrations, etc.) in modules without any extra allocations.
> >>>
> >>> Drivers that don't need this may continue to implement `Module` without
> >>> any changes.
> >>>
> >>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >>> ---
> >>>   rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
> >>>   rust/macros/module.rs | 18 ++++++------------
> >>>   2 files changed, 30 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> >>> index 5c641233e26d..64aee4fbc53b 100644
> >>> --- a/rust/kernel/lib.rs
> >>> +++ b/rust/kernel/lib.rs
> >>> @@ -62,7 +62,7 @@
> >>>   /// The top level entrypoint to implementing a kernel module.
> >>>   ///
> >>>   /// For any teardown or cleanup operations, your type may implement [`Drop`].
> >>> -pub trait Module: Sized + Sync {
> >>> +pub trait Module: Sized + Sync + Send {
> >>
> >> This does not compile with `CONFIG_AX88796B_RUST_PHY=y || m` (or the
> >> phylib abstractions' doctests) since the module `Registration` is not
> >> `Send`.
> >
> > Thanks for the heads up. I thought I had enabled all rust code but
> > indeed I was missing this. I will fix it in v2.
> >
> >> I remember Trevor raising the question whether we want to require modules
> >> to be `Send`. I am not aware of any examples of `!Send` modules but I guess
> >> it would be possible to write code that is only correct under the
> >> assumption that it is loaded/unloaded in the same context.
> >
> > It might be possible in the future, but I don't believe it is now
> > because all rust modules support unloading. And there is no guarantee
> > that the thread unloading (and therefore calling module_exit) is the
> > same that loaded (and called module_init), so a module must be Send to
> > properly handle drop being called from a different thread.
> >
> > Not requiring Send on the original Module trait was an oversight that
> > I don't want to repeat in InPlaceModule.
>
> I think that this change should go to the stable tree, can you split it
> into its own patch?

Sure, I split it off in v2.

Note that you'll also need the [new] patch to `rust/kernel/net/phy.rs`.

> --
> Cheers,
> Benno
>
> >
> >>
> >> @Trevor: Are you aware of any modules with that requirement?
> >>
> >> I have been using this patch for quite a while with my TCP CCAs now
> >> (without the `Send` bound) and did not experience any other issues; thus
> >> offering:
> >>          Tested-by: Valentin Obst <kernel@valentinobst.de>
> >
> > Thanks!
> >
> >>
> >>          - Best Valentin
> >>
>

