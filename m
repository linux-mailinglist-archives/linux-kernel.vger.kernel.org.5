Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE4810F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378437AbjLMLCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbjLMLCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:02:43 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16079BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:49 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2cc3005da23so8057281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702465367; x=1703070167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wF8JoHNULRLQuvkLOWSPJJbTKCRhS7xnLTzqlYvSs1g=;
        b=TMeN+1N/ZauI5KZf61b3oHUXaDJqbktHfTdUC5kh6SdT1BOtnxHFjcIVlAryO9meS6
         O4xMnR2KEFnp5XSrpek2R2J6I4/Xxc1DDbUlyoFQS2mYcnCORUEuU1nOsNwuZqAbKRXN
         Tvz6ZVsxcveRIVLQP/4sCRHtXBoGdHODMLJ3X5dubCzsIbqfb9fE74PS2lqTRyeUw7R7
         ECwPiDhq9PTiz2UlNx9lg/w3spCLAMPDM49iN2O+aB3Kj5sbZ4FpOhO47OYNSaZdFKpw
         zVwiL4Rhab5yH0UDfiOrTnao4o/nZ5lWNArn2MYqZ0dOrIFIu1BPJe7cgRrsmir+2pSA
         1XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465367; x=1703070167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF8JoHNULRLQuvkLOWSPJJbTKCRhS7xnLTzqlYvSs1g=;
        b=IZxPog0NVHTyBPmyLazy+2CZ75eP1OEYVAc3ZVWPzNX/bllYoIQYzqK8cKybbM7Hf2
         pFGD8O59vgZxDv/EyILBKPZx871QRIccGtkLsDoAhR6tSX6pY60FX0VH1sa95HM7h3zd
         fHczyNRcxw8gypNR+Ixekes3RlnifRl29SR1xL+iUEzGaDmLzo3RS0VZLs+SZNmYFTEf
         KkpIGN1AMA+RY0WdlrH6M1RxW/07Vex2AtlqD7sjSA9raLGDWEe44/Hiq4ZJbz3/Wzj9
         PQrqAO3lXbclCCrc+a8G7UpuMqg77rrEhOByY0eQy8vxJ5/4yf4Vj3VrV0/Iqnx8Tpad
         IJoQ==
X-Gm-Message-State: AOJu0YyZ/oeht/ySbUaWPzOl4QBTAS4MmJkA7aZB96GyKELTkf6gqaTu
        r+RkoIVTq4SzPf0b1ejR3Tl2u98gpmnpbXw=
X-Google-Smtp-Source: AGHT+IG8r/n61eq7vzq1h7EddFgGLqT69C2TTHTuuwMHQzYKsTazngtWEvA6k0fmgGuhq8lXkQ0iXrRHMRNxYbs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9c8e:0:b0:2c9:f93d:994b with SMTP id
 x14-20020a2e9c8e000000b002c9f93d994bmr127544lji.4.1702465366826; Wed, 13 Dec
 2023 03:02:46 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:02:44 +0000
In-Reply-To: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
Mime-Version: 1.0
References: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213110244.446502-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
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
>>>> +#[pinned_drop]
>>>> +impl PinnedDrop for PollCondVar {
>>>> +    fn drop(self: Pin<&mut Self>) {
>>>> +        // Clear anything registered using `register_wait`.
>>>> +        //
>>>> +        // SAFETY: The pointer points at a valid wait list.
>>>
>>> I was a bit confused by "wait list", since the C type is named
>>> `wait_queue_head`, maybe just use the type name?
>> 
>> I will update all instances of "wait list" to "wait_queue_head". It's
>> because I incorrectly remembered the C type name to be "wait_list".
> 
> Maybe we should also change the name of the field on `CondVar`?
> 
> If you guys agree, I can open a good-first-issue, since it is a very
> simple change.

I think that change is fine, but let's not add it to this patchset,
since it would need to be an eight patch. I'll let you open an issue for
it.

Alice
