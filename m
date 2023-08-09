Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54097767F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHITGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:06:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A07E71;
        Wed,  9 Aug 2023 12:06:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so100678a12.0;
        Wed, 09 Aug 2023 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691607965; x=1692212765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFNiyh/RpFmVAG/0/kBc/iL4rv2i1vWkHIfgKRABBw4=;
        b=ICspo8jmziYqbUxbj9Mb3lOhkP7bdXLJGNeJcDIaXMQne/T1M7pYu+H80MSiBemwf8
         3SNQ3DNnPEVoDbzolaINQPr4DWm6+k6b+pNngBbQcaZ8+PFdiDQJFWEyz/dbOztpvzoM
         Cw8LCfitzSxqKZDddQX7FeOKyqxNIm4CTvvOBXmg8UrkgO/zZlCmfNafk7EQHZsKEDuv
         5FuOz3OlANC0BnaUUvEGMeV95ILAQlqzF8gKd+X0UvzV+DapFZMjhPeBAO/RYrMoZP7C
         lBXJK79j+lpf1JFCcJ809qtNobKTeRthhtW+6NmcKIjnwyqRHVtjZdZmuilBrYPjwxtf
         G6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691607965; x=1692212765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFNiyh/RpFmVAG/0/kBc/iL4rv2i1vWkHIfgKRABBw4=;
        b=a7okqUz+gGMBSjS+FcAYW3NoQpbrAHZbUYJdl+cf3TjGQIhmI7VWQTAXIAvwSkVqtU
         YwtTvvcT4GyvDHQG9IlYlp/RS80k4kaYspg/B9Qn2D7MhKNm1EoLgoeK8PDimG9heYrd
         W6ht1tXmQBKoYegm7J5Oiwlyp6OTOFfEcuOmjOj40JoD7VRZK8ajN0zA0vrImBqM68Iy
         Sj3/5oJIWKfYvWdEsYW/6VbMW9X8nURSO5V6IVFC3X7ehNhRfx1RxJmmSrSmb+DcUaoM
         2yWtNtbHCXWy/Me6VBcVhlYofMFxrpyiBeOmLgRilvInhuyl1A9K9ZCuatHGSq2yW5w4
         hs9Q==
X-Gm-Message-State: AOJu0YwqTfKzZ2SSADII8TLj4mWs0QM2O3tL+V+ABF2GGdj0AJUeNRja
        HwL/S5vRTS2N2iUsljbl8I78Uy5A7w+dLeCDS4A=
X-Google-Smtp-Source: AGHT+IF2BpiajTE1qLjpXUXsxPx0tt9ixa6upXqc5Cn9ZheALEopErCYfLd0unzpinLEDNS7e7Npidp5X3VNM4XdC+4=
X-Received: by 2002:aa7:c751:0:b0:522:38cb:d8cb with SMTP id
 c17-20020aa7c751000000b0052238cbd8cbmr80622eds.20.1691607965256; Wed, 09 Aug
 2023 12:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
In-Reply-To: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Wed, 9 Aug 2023 21:05:29 +0200
Message-ID: <CAA76j91MN6OKKoKmwfJ7WW7qhccf0EorpO0HBZYg1Ho5c5Ty8w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 04:54, Qingsong Chen <changxian.cqs@antgroup.com> wro=
te:
>
> If we define the same function name twice in a trait (using `#[cfg]`),
> the `vtable` macro will redefine its `gen_const_name`, e.g. this will
> define `HAS_BAR` twice:
>
>     #[vtable]
>     pub trait Foo {
>         #[cfg(CONFIG_X)]
>         fn bar();
>
>         #[cfg(not(CONFIG_X))]
>         fn bar(x: usize);
>     }
>
> Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Reviewed-by: Sergio Gonz=C3=A1lez Collado<sergio.collado@gmail.com>

> ---
> v1 -> v2:
> - Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
> - Reword commit messages as suggested by Miguel.
> v2 -> v3:
> - No need to replace `HashSet` with `BTreeSet`, since `consts` is never
>   iterated on.
>
>  rust/macros/vtable.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index 34d5e7fb5768..ee06044fcd4f 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStrea=
m) -> TokenStream {
>                  const {gen_const_name}: bool =3D false;",
>              )
>              .unwrap();
> +            consts.insert(gen_const_name);
>          }
>      } else {
>          const_items =3D "const USE_VTABLE_ATTR: () =3D ();".to_owned();
> --
> 2.40.1
>
>
