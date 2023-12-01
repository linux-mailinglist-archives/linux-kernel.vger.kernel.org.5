Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6A800A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378618AbjLALrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:47:47 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639E1704
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:47:53 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bd3ac2a8aso1722095e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701431272; x=1702036072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1GqQ4TrIojcjyDirpeDTGx+n3XD+xjD29/oGpLNfI=;
        b=MyZfR5+SGN0FhAH/+aiSSa5Fxv2pKfXcJ+75yqnXxvQjqbNBeRDcQcievpFYglujkc
         DhXM1fo4edTrakiCOx0FM97hNtPZ2d3TUjRlBcWqMTBlNK/4vsxmoZySEsnRr/lIbh0o
         u13iyIyylhncz+mzUvZwCrjXs/UfStO5j6AhlIKNWYz42BpacRM98h6iUwOnQglafX7W
         GAOwVQGkKhXO/IieXBopZMOZFizm3nmcYWuhdnIU+tIqdfdw17KzDTYq5s5QV8bCEyoc
         SPyvuLP+6BEN9O+/33w0xAM3ikaYuwNxU1t2+J1Z4htSXGgZ+ufmSa90DdR6GLXR/fFD
         0xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431272; x=1702036072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1GqQ4TrIojcjyDirpeDTGx+n3XD+xjD29/oGpLNfI=;
        b=Akne2Ft1HqdbxOmIE39wnTQTgWPiJ3th6KuoL9eLPws77l22zQSfnO+R7itYBtfsPy
         yP9QlmtH0yOmxS1qU8Hr5TO09wfbfwNW4GW0reocjKgsBe8UWBTYLPLBbxCQMeKpgsfe
         ghdDE3M1xd1/i0Kmqs/K39hkXT2bqnVRTUKsb3DRlYvLyZxCwM9BlSimsz5Hh4Hgf78Q
         0SyE5TlNtR/EVG/6W3FSlZqPSfg2y5vkonLz4HbMKq4uFo+ezGKvSwu86xDxWjdfvu4w
         inylUIkNeQ6dgjLe9WedHeb538giNMQq7W+SQ/g7hOaWx3N9YJ7KSv6rUVPey8Pf7u30
         arzA==
X-Gm-Message-State: AOJu0Yx1wkQU6V1skNrmyiKDka4dK5Rxrz7YLyUQiOzsKmhELencHG7i
        lkM9Eoe4jvMEhhcFan0aAFeOQaS1I0tEF9A=
X-Google-Smtp-Source: AGHT+IGmdHD9ndeAoG99U6CjjEVBhoGpQPpovxP6HXHrU+LrFLBMj6V3Szk+lEYNslRiUnlO96T3DeFoBd52niY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a19:c207:0:b0:509:440f:3c5 with SMTP id
 l7-20020a19c207000000b00509440f03c5mr41495lfc.1.1701431271741; Fri, 01 Dec
 2023 03:47:51 -0800 (PST)
Date:   Fri,  1 Dec 2023 11:47:48 +0000
In-Reply-To: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
Mime-Version: 1.0
References: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201114749.2207060-1-aliceryhl@google.com>
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
>> +#[pinned_drop]
>> +impl PinnedDrop for PollCondVar {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // Clear anything registered using `register_wait`.
>> +        self.inner.notify(1, bindings::POLLHUP | bindings::POLLFREE);
> 
> Isn't notifying only a single thread problematic, since a user could
> misuse the `PollCondVar` (since all functions of `CondVar` are also
> accessible) and also `.wait()` on the condvar? When dropping a
> `PollCondVar` it might notify only the user `.wait()`, but not the
> `PollTable`. Or am I missing something?

Using POLLFREE clears everything. However, this should probably be updated to
use `wake_up_pollfree` instead.

Note that calls to `.wait()` are definitely gone by the time the destructor
runs, since such calls borrows the `PollCondVar`, preventing you from running
the destructor.

Alice
