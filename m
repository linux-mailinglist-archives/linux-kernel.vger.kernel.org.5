Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D0800ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378832AbjLAM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbjLAM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:27:39 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EBAD4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:27:44 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c9b585b0d3so24804411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701433663; x=1702038463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmL3NKrtBytG8xkjqCE6OTDeK9KHu9/kuk+P+NAf5bc=;
        b=sM8IpDg4lhRNQpQV9+4lu/VZLvSvDdWlxYsN6rekRAnX4/jhJf1YslmGyrsuAQeKel
         PACNKoyffowwY7fhY2apcfXbXGE53id2QFP17nhqisbnYWSm5CHLqkVSSCiNPs8Le/k2
         CtlzYmrbPq25maGEydJyWyegRnW0UFU/uKMWaztwT4lLqdFfnNmYlzx6f8rkLZNfNw8l
         p0gVR1ffuNQtN4vmbhXdLd2T5UAx3q2g8LGynj7Wyf9bz9kZDV/SI1y8mq+7ZasLURHL
         uWL1sXkbi8KpuERpoLDVFrOTVruDHGF4ZsoeP59mmL3DyZxSWVwOhyilpMMXo8sIa6s/
         ZtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433663; x=1702038463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmL3NKrtBytG8xkjqCE6OTDeK9KHu9/kuk+P+NAf5bc=;
        b=CQ/iwN251p809iZ/m6+WkDQf6ztlTE1T/oc6j3yf5N4m7Lm0YrjWyynuO9m8lJ5MwL
         iC2xNRngAK++GX0GxRBucTMpTc5qZW/pvPfSfGgwissdlLg03JUxYQPDAMI6gotfNfmN
         XcXxbWixupZm1xgWXyWUXz0ykMdlxXQb1pNOysDn7tSGoCnQ0p1wxaGb2/xcKYQ431Fb
         EK4Q0r8K/S+slPne5FZcY4TptP+MuAhQgipIa9Ry8VtqwH/r0NxsemlaQW3vRU0odT+/
         5eAWijTJM02XRjwXHDJyOFAYI0ZueZGGlFpJokUqckeUoOZRks1Amx5TUGR4GamVqqM2
         qUFw==
X-Gm-Message-State: AOJu0YxGVok79UcoWT01bvISAwN/AAf5Y0luon0LeSFmr8sUmYcaIPiV
        dP/5KVyrwtWTIUNImd38gO0Rwk52wL2aUIw=
X-Google-Smtp-Source: AGHT+IFPE9LTRPmOtt53LlVPvzsjsFwgDJAHkeuvqHLFmvaoQveY/d0bandq9Z/njQioenXEfi6gioDooJFlERQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:104e:b0:50b:c543:c4d0 with SMTP
 id c14-20020a056512104e00b0050bc543c4d0mr47295lfb.8.1701433662859; Fri, 01
 Dec 2023 04:27:42 -0800 (PST)
Date:   Fri,  1 Dec 2023 12:27:40 +0000
In-Reply-To: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
Mime-Version: 1.0
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201122740.2214259-1-aliceryhl@google.com>
Subject: RE: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From:   Alice Ryhl <aliceryhl@google.com>
To:     david.laight@aculab.com
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, tytso@mit.edu,
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

David Laight <David.Laight@ACULAB.COM> writes:
> > > I don't know about Rust namespacing, but in other languages, how you
> > > have to especify namespaces tend to be ***far*** more verbose than
> > > just adding an O_ prefix.
> > 
> > In this case we already have the `flags` namespace, so I thought about
> > just dropping the `O_` prefix altogether.
> 
> Does rust have a 'using namespace' (or similar) so that namespace doesn't
> have to be explicitly specified each time a value is used?
> If so you still need a hint about which set of values it is from.
> 
> Otherwise you get into the same mess as C++ class members (I think
> they should have been .member from the start).
> Or, worse still, Pascal and multiple 'with' blocks.

Yes.

You can import it with a use statement. For example:

use kernel::file::flags::O_RDONLY;
// use as O_RDONLY

or:

use kernel::file::flags::{O_RDONLY, O_WRONLY, O_RDWR};
// use as O_RDONLY

or:

use kernel::file::flags::*;
// use as O_RDONLY

If you want to specify a namespace every time you use it, then it is
possible: (But often you wouldn't do that.)

use kernel::file::flags;
// use as flags::O_RDONLY

or:

use kernel::file;
// use as file::flags::O_RDONLY

or:

use kernel::file::flags as file_flags;
// use as file_flags::O_RDONLY

And you can also use the full path if you don't want to add a `use`
statement.

Alice
