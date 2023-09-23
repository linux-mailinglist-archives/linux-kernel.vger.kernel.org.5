Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D97AC295
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjIWOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIWOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:11:23 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A41A5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:11:17 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7ab9ad973e6so329591241.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695478276; x=1696083076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpWIj06OHy+rOcF8H0SHbdUYQECR4YDN/XNL+G5tLbw=;
        b=jv/S/yfHavaRUp/HAxrkLgUuz5rndItgHUGiD/sM1alOFcTzUVzrkxmdPq7Uz14sNS
         ihs6Fp1QcE87/NwvZcWK2X3dmOP9ifyz2fNgKQYhZE0q/lH5pm3+Hxx4tXNsd3yQ+wE6
         8qAT2hGKHca5iD/v6EEFo7eBcfncKhyWWgq3PRwH5bZWY+Q10YCOThbrKJPurUggr7Fa
         jG8aY/M8FMw2ZiP997p9sO8HjLLGFwZX4hdUnX9QwLOgG9F029gey73FXTo1cB3Deylh
         0HhsMUSHR/HvZxJP2o4FXAaGkWRbKxR33rm+KUzJHZmzDW1ofVKccbw8Q3FrSjLAYdCm
         4DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695478276; x=1696083076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpWIj06OHy+rOcF8H0SHbdUYQECR4YDN/XNL+G5tLbw=;
        b=bIrLGmH/qXQj6FnyR+IhDbtkZ/9oUaqcSIsDhC8lEa/DNorAFPeg61tQDB0O2yWEWT
         uksn1Y+wb1RFiHhl6roxtOuiHo6a1xm5Nw48JhONZSWuG/qaY/YVv2U4HNZTERTl7wL1
         /nL2O3e6xZJA2VKNlRplZMIxp7ufTIDBP5ON5zYuEu5gcaZ3bYfjL6aHIVCbHzRAHYol
         p3drmbneMO3BC7UVL6cAcCkWqYL8pNlyxjQfmx8se3axgAUTVpL87oyIbGi6XB9VuYH6
         7/6u4mJ4l3wsMykV9BhSWTQAqI3fD8xj3eq22HgscTKgrR7BpT+9XF/jw31upVFeGVtM
         em1g==
X-Gm-Message-State: AOJu0YzMrGBjrTjb2TKQJs4EfJTncbesEMG7yb9R0VhrQBIeYMRPqZjj
        IdJOy5CwqiAjjcoT1ibbq5M3Jh2l8Gl34UZsVUIVSw==
X-Google-Smtp-Source: AGHT+IFYuJ34LCtmmTNhxO2yfGMqz5cQFVlQau7VX4NObs+J09ZySBpsuxzp2XsvghVlmjZXHV3ozAIgh8Z9TEhhMek=
X-Received: by 2002:a1f:e484:0:b0:48c:2b9f:ee1d with SMTP id
 b126-20020a1fe484000000b0048c2b9fee1dmr857396vkh.16.1695478276304; Sat, 23
 Sep 2023 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230923024707.47610-1-gary@garyguo.net>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Sat, 23 Sep 2023 16:11:05 +0200
Message-ID: <CAH5fLggiad7F2QJnZ5dSe4sGkXC7iA-9V0+v=+Q+6b7-+D9DxQ@mail.gmail.com>
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 4:47=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
