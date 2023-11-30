Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EC7FEBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjK3JXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3JXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:23:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4158F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:23:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca2e530041so12121457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701336205; x=1701941005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rlz4Una5lFEdcC2rxxNxFbJRLCbKuqXfn9V1CN1skN4=;
        b=IyX8nwYATpgWd6Xf+K2Ych8TVib3UTc0bGcV+olAaK3B/RkH+s7eUv0fWpzZqRe55t
         oR0thQXPEVOVH9ohU7fZ9eEmPe+oujLZJTUM+U1wlFzJ74F7gvvDQQIQi79PpEdFR0Gj
         d+03DEqVex1LiYWS+kLcDS7DWWEMqWd631HliV4Bz58kQrEgD5MqobI9G+MP8EYm6fZr
         0mfLpRyIl2xzO21PPBE2zq4NIc+5v7J1XUqn6LgVaDAx7p0QS9xVxxgVEs65vLX4R1fj
         9g9hpngpdvcbG2XkTMEuZprJuTBAyCGNQG5Qy1auU/OBB1TEe/YauLDf/ZGVcik6qgze
         EH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336205; x=1701941005;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rlz4Una5lFEdcC2rxxNxFbJRLCbKuqXfn9V1CN1skN4=;
        b=oHIdp6ohnhEFKZhQGFzgMugdWmpooVNlFKA4g7H24waBPu2RYfDAahQvNGsdkKHqjr
         OTbtIcu0ywSi9sxczCt+PLhV3Kb/vimZ15tVbU995Bl98MhRwO9hYn1ppt7AXJZHo2Ym
         wHwbP7DU+N9uG+7YcphVmDCbf+Ogno/sNdMnMCnKyoBMRNqGvIzdKoqL4jEqqf0KIXQU
         9ENqpu+3GDvZOIUJFTGQQtqbklFBKbfTkZWKmjyMqddmMD1IO/GjEp4ZRt9R8KEiIFyB
         yah8tzGXgqbGffYop8FSJrsvXIaA7nJ342erKW1utdihTg0S51qjg4xezXtZ/suDQLj9
         Mcrw==
X-Gm-Message-State: AOJu0Yya9RHGLZYfI3zsTRa3FGfhe6yVumFxsBhGIZeyfAdobeIrQ4m1
        lUB5BZW7L5jD+ctBEPsrS9WWO7X538AfvtY=
X-Google-Smtp-Source: AGHT+IFnTBdOgXqv9aG4V5ypYxcSK4AqZ78cyVIWRWikDj2NKK/NN9uLebd5Q/2Wb6u9J7wU7xuNHmhlR3CmVfY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:7082:0:b0:da0:59f7:3c97 with SMTP id
 l124-20020a257082000000b00da059f73c97mr671479ybc.12.1701336205366; Thu, 30
 Nov 2023 01:23:25 -0800 (PST)
Date:   Thu, 30 Nov 2023 09:23:22 +0000
In-Reply-To: <20231130-neuwagen-balkon-aa1b34055fec@brauner>
Mime-Version: 1.0
References: <20231130-neuwagen-balkon-aa1b34055fec@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130092322.110837-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
From:   Alice Ryhl <aliceryhl@google.com>
To:     brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Christian Brauner <brauner@kernel.org> writes:
> On Wed, Nov 29, 2023 at 06:14:24PM +0100, Alice Ryhl wrote:
> > On Wed, Nov 29, 2023 at 5:55=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >=20
> > > >> +    pub fn commit(self, file: ARef<File>) {
> > > >> +        // SAFETY: `self.fd` was previously returned by `get_unus=
ed_fd_flags`, and `file.ptr` is
> > > >> +        // guaranteed to have an owned ref count by its type inva=
riants.
> > > >> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> > > >
> > > > Why file.0.get()? Where did that come from?
> > >
> > > This gets a raw pointer to the C type.
> > >
> > > The `.0` part is a field access. `ARef` struct is a tuple struct, so =
its
> > > fields are unnamed. However, the fields can still be accessed by inde=
x.
> >=20
> > Oh, sorry, this is wrong. Let me try again:
> >=20
> > This gets a raw pointer to the C type. The `.0` part accesses the
> > field of type `Opaque<bindings::file>` in the Rust wrapper. Recall
> > that File is defined like this:
> >=20
> > pub struct File(Opaque<bindings::file>);
> >=20
> > The above syntax defines a tuple struct, which means that the fields
> > are unnamed. The `.0` syntax accesses the first field of a tuple
> > struct [1].
> >=20
> > The `.get()` method is from the `Opaque` struct, which returns a raw
> > pointer to the C type being wrapped.
>=20
> It'd be nice if this could be written in a more obvious/elegant way. And
> if not a comment would help. I know there'll be more text then code but
> until this is second nature to read I personally won't mind... Because
> searching for this specific syntax isn't really possible.

Adding a comment to every instance of this is probably not realisitic.
This kind of code will be very common in abstraction code. However,
there are two other options that I think are reasonable:

1. I can change the definition of `File` so that the field has a name:

struct File {
    inner: Opaque<bindings::file>,
}

Then, it would say `file.inner.get()`.

2. Alternatively, I can add a method to file:

impl File {
    #[inline]
    pub fn as_ptr(&self) -> *mut bindings::file {
        self.0.get()
    }
}

And then write `file.as_ptr()` whenever I want a pointer.

Alice
