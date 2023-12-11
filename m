Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15680CF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjLKPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjLKPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:21 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD149DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:27 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2cb01b2950cso18198151fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308866; x=1702913666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quKkQtDAheMF2d2l383YfhdmdDBNq69Kqr0DxY+KMkw=;
        b=FFV9FKn7kl/ny0nza0ThrFt5QMxSaOhfRjD1pgshwnb22WTfWk87cE8RiZrGFt0WeG
         xTNyUJ3i6nVz36V9Etfigqu61F1NIDfUu/4vESCLvfw6sYHDPUvaKzQXoVinSi1fFRMn
         8R47r3735qCgfVL0Y7Re+7UlLBp7sC/kUhqJx2XWOGVV822Rdn400qUpsj6WEGmfyM9c
         EcMlTWEQCeaUo9oXgiu1URGLRhU12556gdlM0Ei5tShAni33xa19sn4V/FkaVqyCk3yl
         4PwAPONcSRMnJaYroJ0PnK+QddaBtIivYHaF/ckkbDBspAtzRvV5SDUpi1iz4fIVv8KY
         HS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308866; x=1702913666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quKkQtDAheMF2d2l383YfhdmdDBNq69Kqr0DxY+KMkw=;
        b=SXdCnfCqsw+Aljeh/8zrzYbVObLd3JDrF1FYUnaIEpS3q0nmp0/4KQ7Z1Yni1bnBoe
         UCfoXJ/eqBefWJ91wfcL8hIj5LXm2uFEeacO3394VojQhKPFLw0aF+U8ykwFru10POx/
         5UzdsU17HHlHAz4OUBFX7Gm+iUILnNbpUN1Fn3GnpwZwW/Zr1VvpyX+eYEQqi9+hbyVZ
         HhouIt84ShCRio8rRY2iaxtXZt2mS79SzKGYGAxjWYgv9bpOX74HfYjNW49VW73LYL+H
         NaTRySzTfq9ehQro9F8QoWkhHU+IRZJFqk0CgOooizsTAWEySrpBODB77YyzmphVUGVN
         p4uw==
X-Gm-Message-State: AOJu0YxQlUdblsJJbTelL7Ovfz2/N9qbIau5BW22UcNres2okTLrFUmd
        SqGdb7HhJxl9qEYDQ1N1Nshh9ClJHjP/Qh4=
X-Google-Smtp-Source: AGHT+IG8Cg8DINjQAYQUvGbJJE7A8mvaWFGAWJ8W1agA8FjPYmtW/ujH6tQlBNwpTSqn4hac9NByvFt3FV6R7Uk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9c8e:0:b0:2c9:f93d:994b with SMTP id
 x14-20020a2e9c8e000000b002c9f93d994bmr92946lji.4.1702308865917; Mon, 11 Dec
 2023 07:34:25 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:23 +0000
In-Reply-To: <9q-gcPBFqAZ1mAEZ333ax8Y16e8foTXUWsMijcJyvMhBVu91g4cBo3xRVXVFJeMUW3_67bCukA-bfAzpCwXdbHqwEdciNa8UJBJaCL2q2nw=@proton.me>
Mime-Version: 1.0
References: <9q-gcPBFqAZ1mAEZ333ax8Y16e8foTXUWsMijcJyvMhBVu91g4cBo3xRVXVFJeMUW3_67bCukA-bfAzpCwXdbHqwEdciNa8UJBJaCL2q2nw=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153423.4160836-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 1/7] rust: file: add Rust abstraction for `struct file`
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> wrutes:
> > +        // SAFETY: `fget` either returns null or a valid pointer to a file, and we checked for null
> > +        // above.
> 
> Since now both the Rust and C functions are called `fget`, I think you
> should refer to `bindings::fget`.
> [...]
> > +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> > +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> 
> The comment should also justify the cast.

I'll make both changes.

Alice
