Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0976F0E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHCRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHCRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:52:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2192698;
        Thu,  3 Aug 2023 10:52:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so1340500276.1;
        Thu, 03 Aug 2023 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691085138; x=1691689938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLFGIWhoW+xqNc8aXak0hFn7ZAy46FaCIx1Frul5CHQ=;
        b=aJ5vjOH1vsWackal3PomRTSl603CbwlR8jfvI7eidOLrZ4xz3SBj0mUTQsgqgUAsZI
         6JDasQelj8c48xA/v7QrA2Qsf84wA+xOfOW58pNGClFVHdZeMPDkQ8E0u6zq6WigiT/p
         s0RDBw7e4E6iMDQyfcAsu25N7kCQaT8UxTiCi1Wp7GWzJ0A9kUg7lKzyqPA26UseH0HQ
         Ouq/xrEvw7oHdk3eidnzWk2j7M5gOgslHTds9x9A12XG4QLt42g06Zf3Ad51CwMJLEjZ
         iGbEDl6UBXnmzwgYJOH5Ngao6nFsWTFoHgFFBJeSHO9/mEwLnC2aiiu0j69ynA9Zh2CM
         6INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085138; x=1691689938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLFGIWhoW+xqNc8aXak0hFn7ZAy46FaCIx1Frul5CHQ=;
        b=YE/5HYkdD6pvF+Z59Ls1uB4iBVPL856vxg7XcIKNC8jChm+WQPS/pnBpH0zmLss/zn
         QC2EkrmtBfjSSZdLGRnEECf9X9lqe5IaCSBBdfidwlmiWsu7JQuAl4IQ1CvDChKjxl5p
         YAVC42XOD2zReca/0Te32376k2B0SX3u1catlfJhZqVWeUNxLM9gS3OIRvWyc61HOBfV
         f1qv5vAXZj3N2ui6cAPpCpkjVM5KnfhMvzzJ+Y2MgrwXRm9fyGG71R+IVJrKpsOz3D/x
         Y1z2+nr1rUETC0MjbJNED7+WZiqeZT7FpaMuRGWDDf3pVn5Am+nYC4T8icAJWKHRULNX
         qeDQ==
X-Gm-Message-State: ABy/qLZVUczgcW1wNDcs1/OBfPC7cMaIN8ITYC59DVChAdFMyhlQv6qw
        0+RuzFj1t7XPr+Vmk/A9Zrr53CxmoHCHv8Uwiks=
X-Google-Smtp-Source: APBJJlGDthqPUKGG3foZRnQwGHFg84mLW5KP2xC06rKN85ahgMbgg1191vngKUDORqns9IJdSEugQTx1fEIcIhTrKTs=
X-Received: by 2002:a25:145:0:b0:bfe:e383:6297 with SMTP id
 66-20020a250145000000b00bfee3836297mr16151459ybb.19.1691085137731; Thu, 03
 Aug 2023 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230803093418.51872-1-tmgross@umich.edu> <CANiq72nhsqWsxHKmyNWLtV8AwdA1hAq5ooyJ0WNVrnzRnpjAFA@mail.gmail.com>
 <CALNs47tYsLq8wo3aiqU5Kmi8OFJgf6cugiRLJNiXZGUYdaVojQ@mail.gmail.com>
In-Reply-To: <CALNs47tYsLq8wo3aiqU5Kmi8OFJgf6cugiRLJNiXZGUYdaVojQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Aug 2023 19:52:06 +0200
Message-ID: <CANiq72kRjdKMuvYEGnATBN_mNSREfCJk0i8q79amhiA_ZaMXBw@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 5:35=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> 1. For anyone reading/writing abstractions, it's useful to quickly see
> how exactly bindgen did the C -> Rust mapping

Do you mean using the integrated search in the generated docs and that
that is faster than e.g. grepping the generated file?

> 2. Abstractions may want to link to the C side somehow, linking the
> bindings is an easier first step than linking to sphinx (in the future
> we may be able to do a bindings -> sphinx link)

We definitely/already want to link to the C side in some places (e.g.
all header links, and some docs that refer to the C side, etc.), so
this is definitely valuable. But the ideal solution would be linking
to the actual C docs, indeed. I think we should avoid duplicating the
C docs infrastructure, if that is the use case here.

For that, I proposed to the `rustdoc` maintainers taking a map of
references (strings) to external resources (URLs), e.g. via a JSON
file or similar. This would be useful for a bunch of projects / use
cases, and I think the maintainers saw value in the feature. In the
kernel, for instance, we would generate a list of links in the C side
(e.g. mapping the `foo()` string to a URL, so that then a reference
like [`foo()`] in the Rust docs would be mapped to that URL).

Writing the `rustdoc` RFC has been in my backlog for a long time, but
if you would like to get involved, please let me know. It is a nice
time to come back to that, because the Rust docs are going to be in
kernel.org soon.

> Maybe a stronger "prefer abstractions over bindings" message would
> suffice to discourage use outside of reference?

Not sure if you mean in the module documentation or elsewhere (if the
latter, we have that in the kernel docs already as a "should").

> In any case, I will put this behind a flag so it is not enabled by
> default. While I'm at it - is there value in adding a config option to
> pass `--document-private-items` to the kernel crate, or supporting
> `RUSTDOCFLAGS` like Cargo does?

Personally, what I would love to see is that the documentation allows
you to see the private items but keeps them hidden by default (and
this could be applied to the `bindings` discussion too).

That way, users of subsystems do not need to see docs for private
items, or implementation details, or `bindings`. But, when needed, one
can simply flip a switch and see those immediately.

This would provide most of the benefits, while keeping the amount of
knobs/variables to maintain (and to learn, for users that want those
docs) as low as possible. A potential downside is, of course, build
time.

However, as far as I understand, that is not possible right now with
`rustdoc`, but would be ideal for us (and I imagine other projects).

An alternative that does not require `rustdoc` changes is providing a
second render of the docs in a subpage, e.g. `private` or
`implementation` or similar. If we go this way, a "top bar" (similar
to the one in docs.rs or Elixir) in order to select the kernel version
could be interesting, and could also be useful for other things such
as the "private" switch or arch/config selection if we end up with
that.

> How would switching to the library work? Since that seems like a more
> involved discussion, would postprocesing `generated_bindings.rs` be
> acceptable instead? I have been playing around with a python script
> that extracts the `#[doc ...]` blocks and (1) fixes the escaping and
> (2) formats parameters and fixes their spacing, I could extract this
> to a separate patch if it may be a while before we can use the
> library.

I think it would be best to go for the switch directly, i.e. to try to
use the "official" feature first (it was added on our request... :)

> Ah thanks, it just looks a bit weird in the diff.

My pleasure!

Cheers,
Miguel
