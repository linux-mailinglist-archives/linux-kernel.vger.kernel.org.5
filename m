Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAC80CFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjLKPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjLKPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:36 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68911114
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:39 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50beec22e48so2546835e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308877; x=1702913677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stu0ZJZ/iLBAZujmR+p0lyyYHMpojeVivEZwAc09IiI=;
        b=JVOG2RBXpgkYv28ZrIIeKFc+eDkGGcxdfTjlIh4qJJ25AWuruy/dtD+I2U2Kb6CcVp
         fht/4jrJi9scxT7Se98ChBYWUy43uuvyyIPzPShVfqCfsDxL1buvpBxP7pnO6l/lPLl9
         V3vDz9zzsXJIab5sCi4spx68TzQ41RnGtdarog3PIjgMDsh1CHi0a94MyMsXYin43+UC
         E23GXFSV3jvIV0KtKoomLUcWZxSJ5AxeZ2cqzzuL+DCuD0QAcKDZ9AzyD4ThD8PW5ROt
         qbLgHkmRfG+BMlwTjI0zEFWTTcb+g34UJ9148DADPIS/5UmwW23N2z/MTeUMnFoZ/PBh
         35RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308877; x=1702913677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stu0ZJZ/iLBAZujmR+p0lyyYHMpojeVivEZwAc09IiI=;
        b=fOZ/t+1yF833Xv/6+GwNbE/jxE70tGl0tBtvTWqXL4dKkMAC6tLKoBqBSjuHqcmxz3
         9Ct8AHxZ7zgc7815iupMMVkIx1z3j+DpmfnJFy0msysInVoHuUMFcTi49FIbUBeA4mmt
         /bDBGqevpzAPfaiSrdSCHDjC6rv6Ra96dIKvI+yNTuvMN3mfHWanNti//tBqh6zZOA5S
         1PRo/do0yZze1upRgSh01ZD8+MwxrcHavAU6acMxsQELLlzfYz69hysEUzm4yLcI7K9S
         OFNaV5AAfm2ACKuVBUYMUL5ZF+wjRKtAFqmVem1HqIhZgUgn3UFh+tZbLBRBKKHu5uPl
         Igjw==
X-Gm-Message-State: AOJu0Yz/I2Aue46psO0Lu5ilyRacJRaHieNyrOM+cJYInrI+ImtyV7v+
        qxlMGytAN5bRg5fkdtZ00QSCPzmb5+l/7z4=
X-Google-Smtp-Source: AGHT+IHe/749pN/R8WQkCJ1upgaYzu708xvKyEorYDCSSeYyZ0ox0S8WXyOzIyQ9xNHiCWGEDFo6MKwF6uX2Tes=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:4c0a:0:b0:50d:1395:ef0b with SMTP id
 t10-20020ac24c0a000000b0050d1395ef0bmr77884lfq.4.1702308877536; Mon, 11 Dec
 2023 07:34:37 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:35 +0000
In-Reply-To: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
Mime-Version: 1.0
References: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153435.4162296-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 4/7] rust: file: add `FileDescriptorReservation`
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
> > +    /// Commits the reservation.
> > +    ///
> > +    /// The previously reserved file descriptor is bound to `file`. This method consumes the
> > +    /// [`FileDescriptorReservation`], so it will not be usable after this call.
> > +    pub fn fd_install(self, file: ARef<File>) {
> > +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> > +        // guaranteed to have an owned ref count by its type invariants.
> 
> There is no mention of the requirement that `current` has not changed
> (you do mention it on the `_not_send` field, but I think it should also
> be in the safety comment here).
> 
> [...]
> > +impl Drop for FileDescriptorReservation {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
> 
> Ditto.

I'll update this.

> > +/// Zero-sized type to mark types not [`Send`].
> > +///
> > +/// Add this type as a field to your struct if your type should not be sent to a different task.
> > +/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
> > +/// whole type is `!Send`.
> > +///
> > +/// If a type is `!Send` it is impossible to give control over an instance of the type to another
> > +/// task. This is useful when a type stores task-local information for example file descriptors.
> > +pub type NotThreadSafe = PhantomData<*mut ()>;
> 
> This should be in its own commit.
> 
> Then you can also change the usages of `PhantomData<*mut ()>` in
> `Guard` and `TaskRef`.
> 
> It would be nice to use `NotThreadSafe` as the value instead of
> `PhantomData`, since it is a bit confusing... 
> I think we might be able to also have a constant with the same name
> that is just `pub const NotThreadSafe: NotThreadSafe = PhantomData;`.

I was able to get this to work with a `const`, so I will use that.

Alice
