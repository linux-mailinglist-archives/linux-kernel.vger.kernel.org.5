Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5E80CF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbjLKPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbjLKPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB2EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcabf9ac88so471020276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308872; x=1702913672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiZZ9BWQrfU3B+itk0uJFctS4sy+cPBcfjf8sS4Yi9w=;
        b=CWhHsPc53L99xpDSpeF0SBWwLHvlPUff999OwvzcmiKbbYpR3GnWiThPbjcfHGrVUD
         7iIxJbHrdgImBkd9hNsjCZAk5Rv8mF8umKh1RdViUzIdPwo2PUAwna3ZYuWndVvMtYHB
         jKuHT1jyvqS9a0BVsqNu4Rn2Uy7sMIdDkJMjOoWiKCPC7X/CYmqTB9xuL4uORXlLLGjx
         u4czkqOHRJQrgGZZ0VsHUmTxw1Oozm0zhwDvGSQJg9SPqvsh4kHU1cBmlz+OcWoW/Pam
         rP2Jvw65C1Z2Yinypw92b+2tfnClS4gAHOGwzrNQX9SXUGIXEanjYYfuhnhvddRje4Rr
         hd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308872; x=1702913672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiZZ9BWQrfU3B+itk0uJFctS4sy+cPBcfjf8sS4Yi9w=;
        b=e4B6JTvw8xD3I/9ndpjaZppZjMjJieSyzAT7RmunyToJ74bEHKgLsavRl+TJnJFflw
         8nidYE8Jx/GyKREgAQAEoWlIPSN1RlsgxJrmMaPFsGu5dM39ATBM3FSJfRIatL13lZrG
         ifb1vp57bgn3eLJwh+SvGcZlqSFk2kOCdXwpVPMz4Cej1KmpNCkEj5w+iX9Rlf0EM9PL
         puSZPKwapsHJVIC75p4ZzXxvL6mO9ceWX3lwQ3427WoE77WDxeIgdvx2wWeop0BYXmCs
         Iv192ld/gR2Wsrz28ftZYqE+1gluEn/R/roX3TKpn++5hy1zkN344ZOtwepWfjr7jhEa
         F+Eg==
X-Gm-Message-State: AOJu0YwvnTLZUYXvGV9devTdIPYm2vUqyX9dGlvgrzg5oA2I7RlPyUfj
        HdfkrF6IH18lSc7eNs+lZxACSzFOGxkKqRo=
X-Google-Smtp-Source: AGHT+IHjep4U52xAMd+Y/b1o+2FrpgTrAImOr+BT/csxNQyrNZAhy+3hPBTOFvPRd40QEX6hnE3AilS3NrISjn8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:698e:0:b0:db5:3fa6:d4d1 with SMTP id
 e136-20020a25698e000000b00db53fa6d4d1mr40063ybc.13.1702308871579; Mon, 11 Dec
 2023 07:34:31 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:29 +0000
In-Reply-To: <ZXZjoOrO5q7no4or@boqun-archlinux>
Mime-Version: 1.0
References: <ZXZjoOrO5q7no4or@boqun-archlinux>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153429.4161511-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
> On Wed, Dec 06, 2023 at 11:59:47AM +0000, Alice Ryhl wrote:
> [...]
> > @@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
> >          self.0.get()
> >      }
> >  
> > +    /// Returns the credentials of the task that originally opened the file.
> > +    pub fn cred(&self) -> &Credential {
> 
> I wonder whether it would be helpful if we use explicit lifetime here:
> 
>     pub fn cred<'file>(&'file self) -> &'file Credential
> 
> It might be easier for people to get. For example, the lifetime of the
> returned Credential reference is constrainted by 'file, the lifetime of
> the file reference.
> 
> But yes, maybe need to hear others' feedback first.
> 
> Regards,
> Boqun

That would trigger a compiler warning because the lifetime is
unnecessary.

The safety comment explains what the signature means. I think that
should be enough.

Alice
