Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C188C80068C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377989AbjLAJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377991AbjLAJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:06:34 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884791713
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:06:40 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bcd1578c8so1945741e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701421599; x=1702026399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JTU9CaHiSbs+o3JtKXRUkQIh0ncmcY1dLiLoH2GmSc=;
        b=eRDiVXl/J1Agej0Ydb4tN2X57AnRHeJUzyHAhbzAm1VWss/THydLxgLa0hQdGZN8dw
         5pEH1Tys+h+JWpqEmUDzLS+jB9fR8AhUGSjO/2KrqKOH5R4Tw3h6QeGxa+hxFjYFdkgJ
         dcXgR4C7Cqy9PcvY5RVP7yDmEtcqAoQNOl4eL3Xc0/ym1QruDVjN3sAq2VtCwtZ6dh64
         sqkH4mM51y9XsWFRtNawvuDHB36V3dWG8ClVyHMvuszrjpEMU+nWQzoOaBXcwlE+bwiw
         QYG8i/depsz5/nDVozJaNkZLVsNB0wwkg1MVUttrLEoWWFpg8j4XHlT4QZgpURCzFQwK
         Kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421599; x=1702026399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JTU9CaHiSbs+o3JtKXRUkQIh0ncmcY1dLiLoH2GmSc=;
        b=pHfrwymj6oa/zBwJOttJ7W233fQbtYX0A7IXkQsKpeYjbddpiaat6j/a0Lr886DE39
         KsNBsUFfLs4k7sM8CesOfdgkfRZEc29ldIu5SUBsrviEg1NQdHfKutu3jUYBaWIPtYDc
         njN6b2Vjn723RpxrMzJj724FRiber9lZxs5ACl84joKZ59Roq4FCrqLMkHkJrKSij3c1
         9BRl3oIJeJxz4JYd+/2wFZOTwTE1IzmiI0YsrlHzoldtFPkzJ7uDF2g1zLilK7XUraiP
         Kw2b3riJQ9Pim+1PCbjIg31EKCzCNruiTJmlfusv/Ts/q3ba8HxhM+993ekdxLfq3U2s
         L8KA==
X-Gm-Message-State: AOJu0YxngYREKxt2ondpkQ4sMnFOCnSsMRgVNAUX+8NjJ3ABEUAZuO8W
        LihCXJps7DHo5pOnb/hZcMWP3AYl0SHisXU=
X-Google-Smtp-Source: AGHT+IF1d71ZSf2Kl5mbx0A46QnrKWBkTAOhf3JIYbyOUWPIwbkOelkfoAfTB16bjtarCcRq9aTx9X9Pkee6Tmo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:203:b0:50a:bbf5:6697 with SMTP
 id a3-20020a056512020300b0050abbf56697mr34127lfo.4.1701421598775; Fri, 01 Dec
 2023 01:06:38 -0800 (PST)
Date:   Fri,  1 Dec 2023 09:06:35 +0000
In-Reply-To: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
Mime-Version: 1.0
References: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201090636.2179663-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me, brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, cmllamas@google.com,
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
> On 11/29/23 13:51, Alice Ryhl wrote:
>> +    /// Returns the credentials of the task that originally opened the file.
>> +    pub fn cred(&self) -> &Credential {
>> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
>> +        //
>> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
>> +        //
>> +        // TODO: Replace with `read_once` when available on the Rust side.
>> +        let ptr = unsafe { core::ptr::addr_of!((*self.0.get()).f_cred).read_volatile() };
>> +
>> +        // SAFETY: The signature of this function ensures that the caller will only access the
>> +        // returned credential while the file is still valid, and the credential must stay valid
>> +        // while the file is valid.
> 
> About the last part of this safety comment, is this a guarantee from the
> C side? If yes, then I would phrase it that way:
> 
>     ... while the file is still valid, and the C side ensures that the
>     credentials stay valid while the file is valid.

Yes, that's my intention with this code.

But I guess this is a good question for Christian Brauner to confirm:

If I read the credential from the `f_cred` field, is it guaranteed that
the pointer remains valid for at least as long as the file?

Or should I do some dance along the lines of "lock file, increment
refcount on credential, unlock file"?

Alice
