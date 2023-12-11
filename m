Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EB80CF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbjLKPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjLKPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:25 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF1E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:30 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bfbf019d3so3368313e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308869; x=1702913669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rctRxd7Ih5xwyv5baEpKW/ad4RMHUzIW0rCHfR1fe9s=;
        b=yVdacp+hh8/stabKGGBktm9cFwg8p+paAgf1tew4U47Z4813vxvzI4vsbAWVFC4gJb
         q8IJkrAsFpC8fTjB53lN6cRQ8ndZ1fnvK4Zo+X06sRPL2zNdkKGDSf7FR9p85JyW5DcC
         mv182GZQlpWMGWFggYpm6gOTM325YQg0rJwWzMYTq1T+ICit2xaQYtCSr85lKUBwz+y9
         7qWcnhJGB7GCkSZ5bZ+iiCS2mp2bxhUmNu5q5Gwj30EUEqIbURCgwXs+/mBL13CuH9hr
         Ph8uYW5al/M6QpPNt43yJUiiRreIXQqsSr1CKa3ooPLVHZ4IHrKKPz7yAcoNFCjVeIkV
         sttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308869; x=1702913669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rctRxd7Ih5xwyv5baEpKW/ad4RMHUzIW0rCHfR1fe9s=;
        b=BaXTmARk1kW91ZEmCD04IYgSPRJr1i9/P+j5O8rzRmlf9lHv9Ie4oaavkpNAB8CInI
         2jWnY4+6nVHSv+Tiwf+0OrrhPEQN6xTP7Q2MTvc4EhgKCbqp8Zxl2/f01lDa+r+R+5xv
         DwZ6e3mEkBn5R2Teiv8XjCLU+o8JjxkvOQ4C9M3XFkSQp8FCHonFnXj0N7o0YeCAUbBX
         Ja9IBDr3dwzwCNUJXspY0cQLOcIdUOEkTMRo7Yk7hSO2YALitJhD0yYSmKB/iuFVaxO3
         jXdsGkpkDjaV0sODsK5Tgw6oINH1Fl1Mo+stImJ8zVy2fcpy7D4GM3oemHSRTgGTmZJW
         BLXg==
X-Gm-Message-State: AOJu0YyWw4IgAjjW+XgTV0MLurKcR0cM13JWqGuJvoh0D6hnUOKM9a8k
        n4BYN2JRot8eZks21KQDmqlHFJvtgaUF1wk=
X-Google-Smtp-Source: AGHT+IFUSkgsTrAXrdZfRjPh+Y4r8FjzWQuE2Vy5UzW7EdYa53me3IAAQr/8OF7qP//zkA4p7sR+JwmTncJyjW4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:118a:b0:50b:ee6a:c41d with SMTP
 id g10-20020a056512118a00b0050bee6ac41dmr33367lfr.10.1702308868720; Mon, 11
 Dec 2023 07:34:28 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:26 +0000
In-Reply-To: <8VBM8spxE8lhkvhYGfxxUFwslCWxi-ZL6rGHHDYD6Gn5dZqsdUQfZYDqtykJzQNFJVsQje_B4hGVDRqy3zY3TZGLSL7_YXbhKcIYfvBS02I=@proton.me>
Mime-Version: 1.0
References: <8VBM8spxE8lhkvhYGfxxUFwslCWxi-ZL6rGHHDYD6Gn5dZqsdUQfZYDqtykJzQNFJVsQje_B4hGVDRqy3zY3TZGLSL7_YXbhKcIYfvBS02I=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153426.4161159-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> On 12/6/23 12:59, Alice Ryhl wrote:
> > +/// Wraps the kernel's `struct cred`.
> > +///
> > +/// # Invariants
> > +///
> > +/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
> > +/// allocation remains valid at least until the matching call to `put_cred`.
> > +#[repr(transparent)]
> > +pub struct Credential(pub(crate) Opaque<bindings::cred>);
> 
> Why is the field `pub(crate)`?

Historical accident. It isn't needed anymore. I'll remove it.

> > +    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> 
> Can you also justify the `cast()`?

Will do.

Alice
