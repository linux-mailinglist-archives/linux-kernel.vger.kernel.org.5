Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890E80CFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjLKPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344177AbjLKPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:38 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91E123
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:42 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50e03398506so641650e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308880; x=1702913680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOZT5zqEHYky1Ps7K/Q4ciJTn5tJsl8dEphldkaSknY=;
        b=IFgbkwmi+XllibOQ9klKOZKnBHD1mYUtRzsWTeQ8ix0M6qqRMIR9oHy1FmkWo7vp/2
         /X0iHs91+FR9tCE+dYdopOSwBZbF1SUXNKSNmBFokuTBhehbDaw0LNbyEx7ETFp6XKcG
         iWAyHqif/1BMyblwqPlbh61ZNWRLU1VvXHRcKeddIsZzJBE9TGnnPBLOtOgYFDAEaq63
         SHpN9Qwi1kIVvVQtefuwx39ubreuRp4Eoy4wWrDwTjOetvjmsaan2C9edM+apecJebSh
         B/7D9z0wqsgES9TLt65guEhXc8ZBS10ebCX2JWwi8d0Ljy6GU+KBDWGEfp/fqNhnu/lj
         jphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308880; x=1702913680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOZT5zqEHYky1Ps7K/Q4ciJTn5tJsl8dEphldkaSknY=;
        b=iSDb14NVYprMKTvdkRNuCrtDCJVcxsuCiCBRFfW+pEdQ9BUqcxdm3QsnKazzL0lI14
         dlEIdcn1TEdcKqvcHCwIbpfPoMKQkeiz98fIkXXFc42+2UWZNjlE9lzdxpTI9SRbGcbN
         9Qr1XtRnCjkeu+R1mtDJp6y+Yy/rLRKjYBM1dWlT4aJY9swsdmq7B44/Qc7+ikaiI2wd
         fDoLHgwnAp3LsRJUqWcvmrtD6V7TzQ9G67ZT4rYgNDEmoW53kzSdGLwOWc+85ji4JCfJ
         hFxXO6J4vBrybtVmCMWa92KQHs9OFohnFGv8RyZyM956VfurPoXvA26sdS2i62LTdum8
         4AGQ==
X-Gm-Message-State: AOJu0YwGdERp1h8dFmaKBo+/T4IddJr4vcT4YFB01Ilf5emrkZB9j0f4
        +NuhFTshkH3Qbl57WnjAiLbrIBMLULHY9B4=
X-Google-Smtp-Source: AGHT+IHCOPlTjdNBqi3JUoYkiYaObiziNKxt5OpfQsN0bHdAP695dwHkr0Ehqcwzx9VVbzzEmXS4TnwSIMrRWbk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3d9f:b0:50d:1456:58fa with SMTP
 id k31-20020a0565123d9f00b0050d145658famr31682lfv.9.1702308880329; Mon, 11
 Dec 2023 07:34:40 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:37 +0000
In-Reply-To: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
Mime-Version: 1.0
References: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153437.4162587-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
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
> > +    /// Returns the given task's pid in the current pid namespace.
> > +    pub fn pid_in_current_ns(&self) -> Pid {
> > +        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
> > +        let namespace = unsafe { bindings::task_active_pid_ns(bindings::get_current()) };
> 
> Why not create a safe wrapper for `bindings::get_current()`?
> This patch series has three occurrences of `get_current`, so I think it
> should be ok to add a wrapper.
> I would also prefer to move the call to `bindings::get_current()` out of
> the `unsafe` block.

See thread on patch 6.

> > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
> 
> What about `namespace`?

I'll update the comment.

Alice
