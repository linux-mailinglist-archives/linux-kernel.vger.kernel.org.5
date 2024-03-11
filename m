Return-Path: <linux-kernel+bounces-98722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465B877E61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006EC28108D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112D381AA;
	Mon, 11 Mar 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDe13D55"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E182EB08
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154261; cv=none; b=g3GCXQXqPNHT/5XnSu4JXGIQ9qpG5lM6xX1wJ38Q6EMMcfN0n+ygX+ReCQJG55FhGbVCKqIoOk7HGW/qJGCtCMKIM0gmXbzFs67mi58YLNPvUeRfHRMfdtOoNpfmncQ4kREaSkey2IE7csa3I/BgF6k2Y4b9hLGzdkifQRCb2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154261; c=relaxed/simple;
	bh=+bJHxt/KB77v31jr8cMHA2sysiR2xPD4/CuaaqwHhpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jncbaS0hc0AnrxBCn1/jHwIeK918OMULIWZ9J78lA1BpgGaYHjqMpRxpGFtKVR8WT5hJnvaF8i1BQor9OmK9t4yf9fQiaLU0Ldwh9MJW1C3HSXZIE/IflOguIF9xIv8joboiSIypbrpW62LBCWyPQPvlEyOIwGs89QKxvKfxfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDe13D55; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b282961so38919527b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154259; x=1710759059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkH89xHzV1IOGFDhkdj9/o38QLblihNlGOq4CZ122VI=;
        b=lDe13D55PjwiK7w/nkxe1zF8h1XDwcYnjjchIgKNeOcPO1qYfpG5o1M/AZJK0LdsrE
         MQiM9vmMRZX3+/xKPwGIZqxaE69qS3hsHQ98mBC+JIF/3NM348q8i3BjMkj/Q6En/7dA
         88wSHbfH5qqCRfFyg4JJhsxfBIUC9AvE8Dl8t1sMKpdIJKFFSLNPOd4JSQchRhCs0Q6J
         6lfPtQgi3xYTYfJB6Vw2pAokIC0uQRR0gUNf2aZZiK81q0OXrSby8HdWpATUk9+OGSV5
         y8BIne2ibnTbDqikWODCexVUUf5FUDA1bgv7/CnuM/uhcfMIQTTMI0vcvHoC5v8nrw9b
         kqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154259; x=1710759059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkH89xHzV1IOGFDhkdj9/o38QLblihNlGOq4CZ122VI=;
        b=dXm721m+8lU76Mrk92nMXT7UtqKh5uV1b4xGdxTtKOpEfWsXa2Wi/jKyt4T/1qtK/P
         oc6mKiY8C7DUweioofYqP2qzbEa0zvNp9LzPWDjFLTLHg8pyJt8ChLPieGBva+mh/Xd8
         9Iu+HpQLqKnj7pr4HsGuYVKRTaYMeRE9BF3pHfB2ne0BZQI8Ku4Y1hP7WFM86YjFv6Pk
         JhHjLvSpgC2YC2FKnrEFhbflkaxiQhrFuPZcOVdteE5PxQXBABofN8KXrhkKuCRG1LTf
         1ViuKW1CBWcHe7CwGJ1C4FNTOh34JbsOCGrZ6IucvIzlhQ5JFc3qsxA6DuJaQY+GDpJe
         wR4w==
X-Forwarded-Encrypted: i=1; AJvYcCWmg4A+JemFmTMuRY2bGmnZSbNJvR71Zfyq3yBNYylInCJQbQksnJwJtyWrLqrFOS1oY9OTXyNECZzplSgw5yPdYOV0y4/zIbD7wZhJ
X-Gm-Message-State: AOJu0Yz8Ll/3dUDPAWGuS2caBx2oVxg0JaFxnC5/mQFUooQq2pmUGFJT
	rVdmc1hCUeTWMQfirpZTj3zJdq+zD+ks7gXGJ7ObvfoePCYxAzjrivOC8Nvz0xV/WhAhzzZLkgL
	+L+OdAaOisUeNyg==
X-Google-Smtp-Source: AGHT+IGk2L4RyDWsKEcTyzOXU5v0TXO+qH8NTfIYrhBPgHVqCAeETCeddjOHE8Z9t06NiIqRNoH7ePmbWCeR9e4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:dbc2:0:b0:dc6:d233:ffdd with SMTP id
 g185-20020a25dbc2000000b00dc6d233ffddmr1754817ybf.0.1710154259109; Mon, 11
 Mar 2024 03:50:59 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:50:56 +0000
In-Reply-To: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311105056.122734-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Wilcox <willy@infradead.org>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: akpm@linux-foundation.org, alex.gaynor@gmail.com, arnd@arndb.de, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maco@android.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	surenb@google.com, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, aliceryhl@google.com
Content-Type: text/plain; charset="utf-8"

Alice Ryhl <aliceryhl@google.com> writes:
> +/// Flags for the "get free page" function that underlies all memory allocations.
> +pub mod flags {
> +    pub type gfp_t = bindings::gfp_t;
> +
> +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The caller requires `ZONE_NORMAL`
> +    /// or a lower zone for direct access but can direct reclaim.
> +    pub const GFP_KERNEL: gfp_t = bindings::GFP_KERNEL;
> +    /// `GFP_ZERO` returns a zeroed page on success.
> +    pub const __GFP_ZERO: gfp_t = bindings::__GFP_ZERO;
> +    /// `GFP_HIGHMEM` indicates that the allocated memory may be located in high memory.
> +    pub const __GFP_HIGHMEM: gfp_t = bindings::__GFP_HIGHMEM;
> +}
>
> [...]
>
> +impl Page {
> +    /// Allocates a new page.
> +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocError> {
> +        // SAFETY: The specified order is zero and we want one page.
> +        let page = unsafe { bindings::alloc_pages(gfp_flags, 0) };
> +        let page = NonNull::new(page).ok_or(AllocError)?;
> +        // INVARIANT: We checked that the allocation succeeded.
> +        Ok(Self { page })
> +    }

Matthew Wilcox: You suggested on a previous version that I use gfp flags
here, or that I rename it to e.g. BinderPage to make it clear that this
is specific to the kind of pages that Binder needs.

In this version I added some gfp flags, but I'm not actually sure that
the Page abstraction works for all combinations of gfp flags. For
example, I use kmap_local_page when accessing the page, but is that
correct if there's a user that doesn't pass GFP_HIGHMEM?

So perhaps it should be called HighmemPage since the methods on it
hardcode that. Or maybe it really doesn't make sense to generalize it
beyond what Binder needs.

What do you think? How broadly does these implementations generalize? I
would be happy to hear your advice on this.


Andreas Hindborg: I recall you mentioning that you also needed an
abstraction for pages. To what extent do these abstractions fit your
needs? Which gfp flags do you need?


Also, sorry for taking so long to submit this version. I spent a long
time debugging the crash that led to the submission of [1].

Alice

[1]: https://lore.kernel.org/rust-for-linux/20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com/

