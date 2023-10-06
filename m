Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABC7BB3EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjJFJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjJFJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:08:53 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1FA9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:08:48 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-538d651bc0eso1736734a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696583327; x=1697188127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=By50B9iWyiri7G4mok67XeNGnVJ8i3ORWOZUIjkYfmU=;
        b=THpIUprKsxUTfMM7VHPC9C32myqfwWQTjjA2MZCE/4OdR1nFw1jUVSRGPpEz8Pbhrr
         lYytVUcImtSEKiRepWi6uxefq32JSi2kCAibmUZy4PfxtOGSfHpTNm5RwL5PbECDs+jk
         2TLLgVSq511qbnKChTgjRcRPSoDaRlY9RM5Yt9dXHSmXqbzQBVzeD8FL6n434T7THSC1
         6wH/nDAAtgovXw7ybXOl38HLlPSFEkVoRLCs1qCt4ZuedYCQED/DBwykhLYC0vjz6TRc
         0U7z/Lxxs5ko1T/5i1dxarYYZvN9WerBB418h065O9X0yf2OAYuYdHDQ6plNw/tZM90V
         OJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696583327; x=1697188127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By50B9iWyiri7G4mok67XeNGnVJ8i3ORWOZUIjkYfmU=;
        b=qWY/kwpEyfmU8ZHM1klD25P2JQnv6+0UEvS+cRtyt8H7cwuvbLGWAHdhFpOEu73vg/
         +O7k7LTJAzDVALG4YeuOne2XPiNYqHSoikUOgil6e5Bg92wrdYHw8zmja4sdvEBLDlp8
         krw4gU9Io8Lykriad/5In8WPgeQTKlcCrmILvtYzMD4XudBbWQj85rTh5N/yYY+nZm9F
         MDlAqTbUysD6CQPzicRXtn+Kt1gVATFjX4mQ4pRABT8YnwY8+tPFD/zPEbhjcS1pkjgX
         pg3+k3OjJtjvgaEsIYLH1v2lEZfbV06awv7y/5/l7cd3piXEUZooIQ695GyvSfBE05av
         Em5w==
X-Gm-Message-State: AOJu0Yzv9ng0XMpNMJAoPI6XdrJYuR/6q1TFvEWoPt8Lclfb3rRZJNTz
        QfkAerxK5jziP3mQQmjj8+k7CloEYujOw4E=
X-Google-Smtp-Source: AGHT+IHyTF+le1HnasoBIq26If2cGaxNtJZpJWqm6IaNqDoF43T8cgXKU59KxB3YywrAUrCwKcHUxIsepOPC0bU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:aac5:0:b0:523:1f28:f648 with SMTP id
 r5-20020a50aac5000000b005231f28f648mr50382edc.4.1696583327266; Fri, 06 Oct
 2023 02:08:47 -0700 (PDT)
Date:   Fri,  6 Oct 2023 09:08:35 +0000
In-Reply-To: <20231005210556.466856-4-ojeda@kernel.org>
Mime-Version: 1.0
References: <20231005210556.466856-4-ojeda@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006090835.1141768-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.73.0
From:   Alice Ryhl <aliceryhl@google.com>
To:     ojeda@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        gary@garyguo.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        workflows@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:
> This is the next upgrade to the Rust toolchain, from 1.72.1 to 1.73.0
> (i.e. the latest) [1].
> 
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
> 
> # Unstable features
> 
> No unstable features (that we use) were stabilized.
> 
> Therefore, the only unstable feature allowed to be used outside
> the `kernel` crate is still `new_uninit`, though other code to be
> upstreamed may increase the list.
> 
> Please see [3] for details.
> 
> # Required changes
> 
> For the upgrade, the following changes are required:
> 
>   - Allow `internal_features` for `feature(compiler_builtins)` since
>     now Rust warns about using internal compiler and standard library
>     features (similar to how it also warns about incomplete ones) [4].
> 
>   - A cleanup for a documentation link thanks to a new `rustdoc` lint.
>     See previous commits for details.
> 
>   - A need to make an intra-doc link to a macro explicit, due to a
>     change in behavior in `rustdoc`. See previous commits for details.
> 
> # `alloc` upgrade and reviewing
> 
> The vast majority of changes are due to our `alloc` fork being upgraded
> at once.
> 
> There are two kinds of changes to be aware of: the ones coming from
> upstream, which we should follow as closely as possible, and the updates
> needed in our added fallible APIs to keep them matching the newer
> infallible APIs coming from upstream.
> 
> Instead of taking a look at the diff of this patch, an alternative
> approach is reviewing a diff of the changes between upstream `alloc` and
> the kernel's. This allows to easily inspect the kernel additions only,
> especially to check if the fallible methods we already have still match
> the infallible ones in the new version coming from upstream.
> 
> Another approach is reviewing the changes introduced in the additions in
> the kernel fork between the two versions. This is useful to spot
> potentially unintended changes to our additions.
> 
> To apply these approaches, one may follow steps similar to the following
> to generate a pair of patches that show the differences between upstream
> Rust and the kernel (for the subset of `alloc` we use) before and after
> applying this patch:
> 
>     # Get the difference with respect to the old version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > old.patch
>     git -C linux restore rust/alloc
> 
>     # Apply this patch.
>     git -C linux am rust-upgrade.patch
> 
>     # Get the difference with respect to the new version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > new.patch
>     git -C linux restore rust/alloc
> 
> Now one may check the `new.patch` to take a look at the additions (first
> approach) or at the difference between those two patches (second
> approach). For the latter, a side-by-side tool is recommended.

I followed these instructions, and it looks good to me:

    $ diff old.patch new.patch 
    18c18
    < index e24a0fe51bda..51821feb20b1 100644
    ---
    > index 5205ed9fb50a..8cb4a31cf6e5 100644
    28c28
    < index 8ef2bac9282c..bdab710f7737 100644
    ---
    > index 96b93830f960..9620eba17268 100644
    60c60
    < index 967ad3a0e690..115fcb053e73 100644
    ---
    > index ffe6d6373875..73b9ffd845d9 100644
    69c69
    < @@ -107,7 +109,7 @@
    ---
    > @@ -109,7 +111,7 @@
    78c78
    < @@ -217,6 +219,7 @@
    ---
    > @@ -218,6 +220,7 @@
    86c86
    < @@ -237,15 +240,19 @@
    ---
    > @@ -238,15 +241,19 @@
    107c107
    < index dfd30d99cf04..65d5ce15828e 100644
    ---
    > index 01b03de6acb5..a7425582a323 100644
    238c238
    < index 598ecf05e824..a4e9a5002a6d 100644
    ---
    > index e45ddc7896be..209a88cfe598 100644
    679c679
    < index 56065ce565bf..a6a735201e59 100644
    ---
    > index e2f865d0f716..ada919537446 100644
    756c756
    <  impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
    ---
    >  impl<'a, T: 'a, I, A: Allocator> SpecExtend<&'a T, I> for Vec<T, A>
    759c759
    < @@ -46,6 +87,17 @@ impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
    ---
    > @@ -46,6 +87,17 @@ impl<'a, T: 'a, I, A: Allocator> SpecExtend<&'a T, I> for Vec<T, A>
    763c763
    < +impl<'a, T: 'a, I, A: Allocator + 'a> TrySpecExtend<&'a T, I> for Vec<T, A>
    ---
    > +impl<'a, T: 'a, I, A: Allocator> TrySpecExtend<&'a T, I> for Vec<T, A>
    774c774
    <  impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
    ---
    >  impl<'a, T: 'a, A: Allocator> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
    782c782
    < +impl<'a, T: 'a, A: Allocator + 'a> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
    ---
    > +impl<'a, T: 'a, A: Allocator> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>

> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1730-2023-10-05 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/compiler-team/issues/596 [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
