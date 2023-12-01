Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2C8009F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbjLALcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:32:03 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED1F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:32:09 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c9c5db77b8so14282761fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701430327; x=1702035127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOZpL58Jg4dcaTG9rxFjgV+iNJy0SUwpN+cVHaOTK8=;
        b=DpAlR7b1gfKaV5G4DkOktOrpkNFTHXN99NM7vnAsBSprhz7htoquvhbyuNIC93w2lb
         YVqejhuUs1rwrz20PNWLEWlh2hvepocBeFFdeC/g/wA4h3WW06bk4kW395yQdKZ4J1YY
         pumiS0Wf3OJdELl8es8SW6FD2+43ag+/5B7YcrJfmEfLkOcwC5GAp2ckBeS1Qs+iUyXY
         wDxDrGglN3SB+rlcUjVCM7FR4tjOvUs8AzyQVibPGp2flrGabO2EHc32CbdYUgio/CVT
         McNk7irD6MHt7hdQBEkDLf46LTKqXfXvsUEZyetRa6YhdAvrBHgQ9ZrMghc9zjywTEIb
         YNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701430327; x=1702035127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOZpL58Jg4dcaTG9rxFjgV+iNJy0SUwpN+cVHaOTK8=;
        b=uEP8j4fQq/DAGu3CzMN9f3srmUXAITNXmUbUtphfGvspTC6xf+rSyM6FXetKmav4Bj
         G1k/ReGtAB1cx2lRmtAOhQCuqv5QmprK4xhvmiJb0HfRyURu2mcFI1Kh7aU/RSBK9y3O
         5cLJKP26ZsHEpKY8/2zOvr7C/eNyF/jaXfhwBoha9TxurEDMZlN8uOt5LRKnHO13ySOF
         9aBB7k8p34JLgBq85kuXrvVVOFjtyuW1iicYsFGiy8kYPbUiDwQgnSEuJ9xz2u7J7Z8i
         E6I9PLVjnqfG+WCH33CraYSee9VjdA6MpyOS6VXUgn6+cuGQhs0iiIgwSQKgKILiUZfm
         xcuA==
X-Gm-Message-State: AOJu0YwIvT6tyQrN4UA70B+Ofog+F8AVRfUjXx9juoRaWu2J0VGQyTVb
        ZxeGU3xA32YoxPHGAPiP9eEjcT0gBx8Opz8=
X-Google-Smtp-Source: AGHT+IGQ9UU+rJ5wMq5QBX+PqlTqstUtITM9JfiPzFSkJIOsOvhOpYJ2qAay+9m2rwj3g7HlQCT29mybUK2Tgd8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9984:0:b0:2c9:bacb:ab13 with SMTP id
 w4-20020a2e9984000000b002c9bacbab13mr61192lji.5.1701430326787; Fri, 01 Dec
 2023 03:32:06 -0800 (PST)
Date:   Fri,  1 Dec 2023 11:32:04 +0000
In-Reply-To: <_xnOTacjwsOFSA4oog2DJs0VLa1w0EaSPM3rqDUjIZAmNgiq0V0-bJwfVZdDKaydes_rJb30Zz4TyacYImYZHK6i0-LR8AYbQa2T1l0h3K8=@proton.me>
Mime-Version: 1.0
References: <_xnOTacjwsOFSA4oog2DJs0VLa1w0EaSPM3rqDUjIZAmNgiq0V0-bJwfVZdDKaydes_rJb30Zz4TyacYImYZHK6i0-LR8AYbQa2T1l0h3K8=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201113204.2201389-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
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

Benno Lossin <benno.lossin@proton.me> writes:
> On 11/29/23 14:11, Alice Ryhl wrote:
> > +impl FileDescriptorReservation {
> > +    /// Creates a new file descriptor reservation.
> > +    pub fn new(flags: u32) -> Result<Self> {
> > +        // SAFETY: FFI call, there are no safety requirements on `flags`.
> > +        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
> > +        if fd < 0 {
> > +            return Err(Error::from_errno(fd));
> > +        }
> 
> I think here we could also use the modified `to_result` function that
> returns a `u32` if the value is non-negative.

I'll look into that for the next version.

>> +    /// Commits the reservation.
>> +    ///
>> +    /// The previously reserved file descriptor is bound to `file`. This method consumes the
>> +    /// [`FileDescriptorReservation`], so it will not be usable after this call.
>> +    pub fn commit(self, file: ARef<File>) {
>> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
>> +        // guaranteed to have an owned ref count by its type invariants.
>> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
>> +
>> +        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
>> +        // the destructors.
>> +        core::mem::forget(self);
>> +        core::mem::forget(file);
> 
> Would be useful to have an `ARef::into_raw` function that would do
> the `forget` for us.

That makes sense to me, but I don't think it needs to happen in this patchset.

Alice
