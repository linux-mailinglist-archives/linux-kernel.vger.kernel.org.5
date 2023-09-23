Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688B7AC296
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjIWOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIWOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:11:51 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5119E;
        Sat, 23 Sep 2023 07:11:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8020510203so4203010276.2;
        Sat, 23 Sep 2023 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695478304; x=1696083104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJfGRDLZlJ3GE0W4DAhvHHTAFHaYgV6lA7zrG+qb0E8=;
        b=meFoafKK/k2lSBOUkXoFg8ZKHxt3dBmuBxUJTy7+2o16z5cSqgSA+8BKWugZS/YD2i
         SnmLlXHyFWDgNf4pXwUbjk4Kp2TPlhQO/umgFDQFrVkQ6GrYQy21/+vUphpFDAX9s0vX
         EwCnkxJLEwRyWu3sIzcbdQyQdLYbXAtL/V6sFqdaJpnVjbIKskNJEVQmiwMlaaMbnbk2
         jzo3VO95280AIWdyPR7U7prtVYByLrg6LVH6rUBCGkoLE3WrWwlfEWGr/AkhpD7qe+Jp
         uvLR0GrJCC+GFJ/604nHEDsHl674aqThfaLxYS5eULhrLE0kyqym47u5KjZrbwkY9LlR
         mpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695478304; x=1696083104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJfGRDLZlJ3GE0W4DAhvHHTAFHaYgV6lA7zrG+qb0E8=;
        b=dBwsWrVw3nCgwv5fwOVBmQvqsr6zYgLsdm7JCKR4KOuegR8E/8dfDSVE+oPwHerC+c
         RBijZvuPyNovl3Z4CLdf8OT6zddSCwry64CTuOc6HyFc4tP6obIMugkDI+F3fSBJAxvX
         20n6W6ttFDkiTQKy1IgJYRLZQdRD2ReA3ZRKkggac6qwUJVGe3yZvKFuqtDeGMtyr2l9
         wLfOk9I8bUXmpZG5ERt6BaLCGsJmvf/2Alho5TSpUg91E4rffGXY4zI43/pVCyBspv/U
         5cp0VWgxVUBz+kEtsiRRADzqdyKLirP2SeYVfgm7CZ+PzLFAcPAJ4TvZ+eS0oQ4jG+wO
         /tuQ==
X-Gm-Message-State: AOJu0YzNL+xFqNCfsIPRKtpGK4TPhM0amXTYXmeXLv21IgrFz4K4xura
        4Z3Xg6CRV7Vt87jMBF/DWuaU3WBsznFp+qAdTxw=
X-Google-Smtp-Source: AGHT+IEFpfAPIesKnk0DMgl1CnsysYpgV8j+UWvNpmVtX8VXXsIJemUutNYnYsOg6G7N7gNgoyZpSPhymGMJAHDQZfc=
X-Received: by 2002:a25:d342:0:b0:d80:1263:2752 with SMTP id
 e63-20020a25d342000000b00d8012632752mr1814013ybf.60.1695478304335; Sat, 23
 Sep 2023 07:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
 <20230923081251.2f702cc7@gary-lowrisc-laptop>
In-Reply-To: <20230923081251.2f702cc7@gary-lowrisc-laptop>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 23 Sep 2023 11:11:33 -0300
Message-ID: <CANeycqoYtbE1eMOoX_ZBp_Ti-jg9eJ+JBmHjiV=nno+ocvvOqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 21:13, Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 21 Sep 2023 18:34:40 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With GATs, we don't need a separate type to represent a borrowed object
> > with a refcount, we can just use Rust's regular shared borrowing. In
> > this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> The implementation looks good to me, thanks Wedson.
>
> A minor thing that worth considering is to implement `AlwaysRefCounted`
> to `WithRef` and reimplement `Arc` with `ARef<TaskRef<T>>` or add
> conversion functions between them.
>
> It feels natural to have this this impl (because `WithRef` is indeed
> always ref counted), but on the other hand I don't currently foresee
> anyone to currently want to use this API :(

Yes, I like the idea of defining `Arc<T>` as `ARef<WithRef<T>>`. My
concern had to do with error messages for type aliases but you or
Benno (or Bjorn?) had a link to plans from the compiler team to
improve this. And we're using type aliases for our locks anyway.

So this change is in my queue. (As well as the changes to the guard we
discussed a couple of months ago.)

Thanks,
-Wedson
