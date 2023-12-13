Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38383811D22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjLMSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:44:29 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEACF2;
        Wed, 13 Dec 2023 10:44:35 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-dae7cc31151so6916327276.3;
        Wed, 13 Dec 2023 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493074; x=1703097874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o89+rTPkyZ2u4xqSnh8fhH0cKv+jKXfmZsjDkxKQnFo=;
        b=LTVsUC0ADO27O2dqOjerWAWK3PuyUFgtZg8TJo1kCcEmJaa1nYDkyRG4GFMP/mLxwt
         YxNfnRAjmmhGcL3W5vXxgfx4JnlFrNwgCYGOroBLBQawGB9S72jUKOPvf5GawFH8XTVF
         SD9k+87O7doWFMZN/je9PpeWDF+UWt/MdHGB46De/HaRHHAmRvdviJOsqqx2AXKtqASI
         EnKpCXOdQ7WaGTZ3jRKbC0EzGfg6QGJkR8FdHaiwxlHFh6gED7Mw6gzq4BUktNf79E7k
         ovy1j68lr+P+sCbfCM0gWQbMYasWrxqG2gWag86L5DdIXCUQHPzvVpr2hY7tdvOBf0W/
         IBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493074; x=1703097874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o89+rTPkyZ2u4xqSnh8fhH0cKv+jKXfmZsjDkxKQnFo=;
        b=hK7pSSdZCLnRXh1agnXa0KfFEpmg2HpC7pHRpbzYzN/EPWpNmE87nW/0M4vSWxFYJG
         2H6+Y12hKf7w9iVHqkROiote/hDLfBlc1GxDkdecLGRxXih3rLAxU+kaHPV6bvPhAn/V
         oJ9khTNUiob1dSmXsP2n6I7ym7aHduwVwcfXhoq+7COUgg3SprjgRWL2H8gRHo5TtuBS
         jtBDL/lvqotYm+wcdXCGtclutEDlpPdmhgVPuDzYN9T/l++Z9v57RNW8iwiRraC4L/5I
         oj76iSv637ri7Nlc991Lcwk0zBSDPrGVAJ4wCDcid3pl3BpxSRmsAJnViptiSn3Wn0Jh
         VibA==
X-Gm-Message-State: AOJu0YyKDcGd7bQtjvYqiJooj5C1Y3vB6YVyFmfXt+LixteNbBnnF0Tf
        /w5UcXxTceHYHSPJKSoPIfDFbXF+zv/7Akl3sXc=
X-Google-Smtp-Source: AGHT+IGDDcv7QCiCuPSgHt8BFeRN1ktb30czOglJRpkstgMMmptWXTVb6nUszHCqmwSYC+o+Mumag18lqKuwy+cyayU=
X-Received: by 2002:a05:6902:1b04:b0:dbc:bcc7:2580 with SMTP id
 eh4-20020a0569021b0400b00dbcbcc72580mr2460332ybb.56.1702493074534; Wed, 13
 Dec 2023 10:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20231118013959.37384-1-tmgross@umich.edu>
In-Reply-To: <20231118013959.37384-1-tmgross@umich.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Dec 2023 19:44:23 +0100
Message-ID: <CANiq72mv_9J5LAUNdMtYX1S=OPCr0-R_gS_V0c4ZX8Br3H86nw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: update 'paste!' macro to accept string literals
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
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

On Sat, Nov 18, 2023 at 2:43=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Enable combining identifiers with literals in the 'paste!' macro. This
> allows combining user-specified strings with affixes to create
> namespaced identifiers.
>
> This sample code:
>
>     macro_rules! m {
>         ($name:lit) =3D> {
>             paste!(struct [<_some_ $name _struct_>] {})
>         }
>     }
>
>     m!("foo_bar");
>
> Would previously cause a compilation error. It will now generate:
>
>     struct _some_foo_bar_struct_ {}
>
> Signed-off-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` (with an added `:` before the example since
that is our usual convention).

Thanks everyone!

Cheers,
Miguel
