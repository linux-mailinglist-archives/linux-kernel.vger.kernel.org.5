Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7776EBE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjHCOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjHCOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:08:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696F1FF0;
        Thu,  3 Aug 2023 07:08:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso991813276.1;
        Thu, 03 Aug 2023 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691071681; x=1691676481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb1aZWQnbifz16U2517ArsPdHyVT8qzE12vInUcoAt4=;
        b=ebrpSM4TGU27+eZrt6b46SfKawasjkJFKbmFSZK0BT7hOZ1tKOjkMoC0vR5vTBCjSu
         Z48JOOq1FGgVBtJhlzjzODuTpmRqPddr8H8ETzZYNXfvzcmXBC701acfC+9fqxZxsDKX
         YF2APnmkmaaZy1wPZJjjzVnzTgu5j/4z+FfTZmmEu/GxJ+0dYUF+b2PSl7I7csWgATvy
         8W/FGuPfvDLJidU98qIviLCud51nDEpZ+4YKPBzkySqHwG86DBRi47UAa5utMuas8guY
         5HzUSN4aWVz/Y2nQ6RmuJo/GYIuEblRJG7IxfZeYjNICgLOkF/3X9nc++hwxO04L4x3A
         8Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071681; x=1691676481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb1aZWQnbifz16U2517ArsPdHyVT8qzE12vInUcoAt4=;
        b=hWnZ/x4TAX+M0HgHQ7xqEVUU6VbdIKPMnzAffQDFWZCYZjuuLy8BgikF4t7W7O89wi
         sp6tNpVHN8CIzhV5oGFmgmOaRM/cPkwlS5Q2L69FhCp3ILsA6ujpnmgJ05ZJ+pSJKek+
         B+L4lC3nqehftiYWjh1hbZbr6ETn26yUfkS94yaClbqnstccID8ckI5OPcH33FtiMlYp
         umetiEO+6GVUu/PQ3E87wxUWHm6rrGyK2OfsZ8H0z+uGNciN5kkALrA+vFkYdvmtCCgL
         5CPzFTlKitv4BmmUCR0CQ8Bfq9VKLZtAznULRNF02Mh5GcCr74xfnKaSRAg2bbLwS6en
         e8Gg==
X-Gm-Message-State: ABy/qLa+jxRS2p7d6goQ3UrOplAt3rKbralQFGm6lVs3vwF6BremFtsk
        krk5ZgpK+5KdIBkLNP2lotI7P3comEmVrG7FWTI=
X-Google-Smtp-Source: APBJJlFXP4Sa4yNhuW2mCuFdlEBTS9oAsUrp0FEp+qHxyfLa85hSCjyn/scAvmXIqvXDvZyBlOyHUWNeE8G42dmTcn8=
X-Received: by 2002:a25:3757:0:b0:bcc:c347:81de with SMTP id
 e84-20020a253757000000b00bccc34781demr15061592yba.36.1691071678851; Thu, 03
 Aug 2023 07:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230803093418.51872-1-tmgross@umich.edu>
In-Reply-To: <20230803093418.51872-1-tmgross@umich.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Aug 2023 16:07:47 +0200
Message-ID: <CANiq72nhsqWsxHKmyNWLtV8AwdA1hAq5ooyJ0WNVrnzRnpjAFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Generate API documentation for 'bindings' crate
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:36=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> The 'bindings' crate currently doesn't have API documentation available.
> With this change, it will be generated as part of the output of 'make
> rustdoc' (similar to the 'kernel' crate's docs,
> https://rust-for-linux.github.io/docs/kernel/).
>
> This patch is a RFC because there are a few questions:

I think the first question to answer would be whether we want to
expose `bindings`, i.e. what are the advantages/disadvantages?

If `kernel` were a "normal library", then I would say we shouldn't,
because users should not need to care; and, in addition, the goal is
that leaf modules do not need to access them directly.

But, as sometimes happen, it may still be quite useful for some
developers nevertheless (the same way documenting the internal/private
details could be).

So, it would be nice to have an overview from your point of view on
why it should be done (or not).

> 1. Do we want to make this the default, or a separate target/
>    configuration? I don't think there is much downside to always
>    generating.

One downside of doing it by default would be going against the "avoid
`bindings`" guideline (ideally rule).

Another one is render time (the C side is trying to reduce it), I
guess, especially if we keep adding headers over time.

> 2. The entire '.config' file could be included in the doc output, to
>    make it easy to tell what settings the documentation was generated
>    with. Would this be desired? Maybe with a '--cfg
>    include-dotcfg=3D".config"' flag so published docs would have the
>    option (unsure whether it may ever have sensitive information).

This may be useful orthogonally to rendering `bindings` or not.

> Bindgen is currently invoked with '--no-doc-comments', I think this may
> be because some blocks were mistakenly interpreted as doctests. Once we
> upgrade our bindgen version we might be able to remove this.

Yes, that is https://github.com/Rust-for-Linux/linux/issues/323 and
https://github.com/rust-lang/rust-bindgen/issues/2057, which led to
the addition of `process_comments` to `bindgen` in v0.63.0.

> Side note, 'rust/Makefile' seems to have a mix of tabs and spaces - is
> this intentional?

Yes, it is intentional. For instance, the command definitions use
spaces like the vast majority of the kernel `Makefile`s.

Cheers,
Miguel
