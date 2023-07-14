Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C698D753775
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjGNKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjGNKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:05:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3B3595;
        Fri, 14 Jul 2023 03:05:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so3658398e87.1;
        Fri, 14 Jul 2023 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329137; x=1691921137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC3KL2hS1JnlkqIBEqFx8ev38o43ew/IXaL/ADvToRw=;
        b=sGq92oZlq8xUWpYsUnoMDFKic+NBh+UNK7O9CoNl+52dqL38MkpJFDAzdpQNMEsTzc
         AhV7BaJ45jlODMxnOnKjBtPTlSeVjTFMV7D5GGPhuLJua0YMtq1NGIqU5VAc5wjPlaTH
         67kRS0OTicF3/F0ssY5LAV0WbGGSqDAP22oRYJ6qAvR4xDE+2n6W4fjOvxvt4HPd2gVR
         8gMy8tCyhhD8GHlp+wQUJzi7j/TpV27YIRleAD39vyREteCWNLB0RoF2Ihj2oCOuyI+a
         jtWOFfbqk3qgGIlp0HdEwApXPpaMNT8d4PV6AGFQgb91NwntynOdvoheAUEYQ3SZqcQF
         PoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329137; x=1691921137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC3KL2hS1JnlkqIBEqFx8ev38o43ew/IXaL/ADvToRw=;
        b=W8NHFoSzfWY9RW2Ovs0opHe653zh7WpWu3aHm7ebzEZmEj4zomOi7mK1FStFtzTdSf
         wVZCMLDsrs1F/kNWhfHabm8cvqqKdlUsKidrACCmsI9QHnKYsjy35KoS+alGvDe8Q0Iz
         anwe7JAji+e1kpNaM+1GFBEiJdInvLj5je4s3+8bRZN4LbyWDlFKnlcP3etEnCZK33hE
         26B4LYBV5JjihxVZ1COKr84BExwsBDhIy7uReptxmrUV5tgcOnUDDKkqwai9wgEYhEON
         QW+ibj+gsyec8uEDkY/TrJHguP59HjvvVMVBoK2fBwu/pZvR4TpmTMJGtXMuAmZDjvF0
         wg8A==
X-Gm-Message-State: ABy/qLbSYrKrkaQU3lTs1JrVhWI5soUaeEKjSoJkCnIim4cMFMk4+Qav
        uYIWdbGiTJ42qgq71qwPGBXdLC0VlKtMCqn0Fd8=
X-Google-Smtp-Source: APBJJlGpmaod1q6JB0TeZZQvgjcZdV+jjuUg364ZTYvjCugWGsS7U7OSkLwyObWN1itUElPRsGJvSzIZ7ZKSPFpf2OE=
X-Received: by 2002:a05:6512:31ca:b0:4f6:e06:50bb with SMTP id
 j10-20020a05651231ca00b004f60e0650bbmr834325lfe.30.1689329137011; Fri, 14 Jul
 2023 03:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
In-Reply-To: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Fri, 14 Jul 2023 13:05:25 +0300
Message-ID: <CAPDJoNv1HW-5uCj21PX3t23rJ+sbTL4Gm5pDis8HGJ-VTr4dug@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:39=E2=80=AFPM Asahi Lina <lina@asahilina.net> wr=
ote:
>
> Trivial implementation.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/str.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index c9dd3bf59e34..a94e396d39e1 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -606,6 +606,12 @@ fn try_from(cstr: &'a CStr) -> Result<CString, Alloc=
Error> {
>      }
>  }
>
> +impl fmt::Debug for CString {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(&**self, f)
> +    }
> +}
> +
>  /// A convenience alias for [`core::format_args`].
>  #[macro_export]
>  macro_rules! fmt {
>
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230714-cstring-debug-ca021fe0ad78
>
> Thank you,
> ~~ Lina
>

Glad I wasn't the only one missing this, now I don't have to write the
awkard `&*` anymore, as in:
```
pr_debug!("trying to open {:?}\n", &*filename);
```

Cheers,
Ariel
