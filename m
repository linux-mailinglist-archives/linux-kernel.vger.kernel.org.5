Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6637AC29F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjIWOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIWOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:20:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5371A5;
        Sat, 23 Sep 2023 07:20:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d867acf14aeso588218276.1;
        Sat, 23 Sep 2023 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695478826; x=1696083626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBl/h0an7nIUaCEYje4Eux0NrQkvTENlUgF4eKZqlAU=;
        b=HppP1XmlAcMPDGUfYm/vNV8fQx5Um/6QMgS6FyqihDvYbTLRwTNUNOJ/tYCNQ1d0Iu
         jFstWs6OAWiXP8srG5QMfSe1fbBP+dbduf2U9bx4MJgbpEqV29f4fhBi6TD8Xi0BLNDf
         s1Kyd05RfAtfdlnd/Rb22jIBMdyMLL+eePRPBy5hdesjlP64ewHYSWLLKNvwBeRdaCyg
         Rt40UDiBtMifb2Q3lUU4qjTNX+XpBpktzaiCHpUTEG4sa5ZZrlVM6FP6jE80iVHwETgP
         EOO0o1yYZbckio8Gdain7ZaCdwP9NCxAJ4z8wnXB2ZIBu7YfyEJvYKaWhFr5FouYiRY9
         wrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695478826; x=1696083626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBl/h0an7nIUaCEYje4Eux0NrQkvTENlUgF4eKZqlAU=;
        b=gja/nSJ1BfwNK63mCP/MWF6L1uvQBSgGKoYb60A8ia/iCBF+dv7OKTPRK0+7vh72BL
         nKziRhjV1RE1QSVd8iZlcZXqN5tu00PjGQ11aGyClSlMrCmMWXo5sa56KFyrUVVsNTVU
         dr5cpOjVj0CevV0/hRg8EAyHYRzyCNGbKvEMz7arpNQHFRe5PRbTTEKaW7A9IvET6I8h
         sUesTlOR5TFESXT+VuLqys53OREknUe7qiuyBz2rBuvtItDhB6Ts7Fen2UnPDr9sJS81
         qKy9VOKGdzyoCEE/QfgbbvCqkWRexjIgJtkQHzbt1+dTIIWWcqEKYOFoFeFn87Xu2xNf
         EJJA==
X-Gm-Message-State: AOJu0Yy4UyX0DlGzDikrKOi9Uo93jFxhdHFpFBTOb27rvh1BFYg8puDl
        n2I4qDdSDXMU2/QbxTk32GAnzhehXI8ZlvAWbAyYPrAFab0=
X-Google-Smtp-Source: AGHT+IFdZncERuv+UUHOGlhJYbZWMio+nUpWKT14eoSAU8+1jMT8oSVMo3nFrYnxdnOKtNVU19RJU+xJd95ehpnrckg=
X-Received: by 2002:a25:44a:0:b0:d78:6ef:9178 with SMTP id 71-20020a25044a000000b00d7806ef9178mr1535680ybe.17.1695478826643;
 Sat, 23 Sep 2023 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
 <20230923081251.2f702cc7@gary-lowrisc-laptop> <CANeycqoYtbE1eMOoX_ZBp_Ti-jg9eJ+JBmHjiV=nno+ocvvOqA@mail.gmail.com>
 <CAH5fLggKf1sXdpnihcm-qOMDk9ewkDB9ZyW3wVdhmuhtn9sPFA@mail.gmail.com>
In-Reply-To: <CAH5fLggKf1sXdpnihcm-qOMDk9ewkDB9ZyW3wVdhmuhtn9sPFA@mail.gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 23 Sep 2023 11:20:15 -0300
Message-ID: <CANeycqqZeZtVNdZyfbtE0HJKrBf7+=2rDgn0NwGb2_895bq3zQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sept 2023 at 11:15, Alice Ryhl <aliceryhl@google.com> wrote:
>
> On Sat, Sep 23, 2023 at 4:11=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gm=
ail.com> wrote:
> >
> > On Fri, 22 Sept 2023 at 21:13, Gary Guo <gary@garyguo.net> wrote:
> > >
> > > On Thu, 21 Sep 2023 18:34:40 -0300
> > > Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> > >
> > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > >
> > > > With GATs, we don't need a separate type to represent a borrowed ob=
ject
> > > > with a refcount, we can just use Rust's regular shared borrowing. I=
n
> > > > this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> > > >
> > > > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > >
> > > Reviewed-by: Gary Guo <gary@garyguo.net>
> > >
> > > The implementation looks good to me, thanks Wedson.
> > >
> > > A minor thing that worth considering is to implement `AlwaysRefCounte=
d`
> > > to `WithRef` and reimplement `Arc` with `ARef<TaskRef<T>>` or add
> > > conversion functions between them.
> > >
> > > It feels natural to have this this impl (because `WithRef` is indeed
> > > always ref counted), but on the other hand I don't currently foresee
> > > anyone to currently want to use this API :(
> >
> > Yes, I like the idea of defining `Arc<T>` as `ARef<WithRef<T>>`. My
> > concern had to do with error messages for type aliases but you or
> > Benno (or Bjorn?) had a link to plans from the compiler team to
> > improve this. And we're using type aliases for our locks anyway.
> >
> > So this change is in my queue. (As well as the changes to the guard we
> > discussed a couple of months ago.)
>
> Will this not cause issues with DispatchFromDyn and the Receiver
> trait? Maybe it's best to have Arc be a real type and just provide a
> conversion?

I don't think it will but I haven't really tried it yet so can't say for su=
re.

One thing I learned (obvious in hindsight) when doing the locks is
that we can have impl blocks for specialisations of a type, so
`DispatchFromDyn<Arc<T>>` will expand to
`DispatchFromDyn<ARef<WithRef<T>>>` and it should be ok.

Or are you worried about something else?
