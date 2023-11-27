Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1901A7FA200
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjK0OHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjK0OFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:05:50 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85819A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:01:14 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d564b98c9so1179161eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701093674; x=1701698474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOw7FonKD9MbC43k524zBSSsF7xxQpwUCU29NYnvaYc=;
        b=OJl3mNILmZTiqrlV73fwESfHGqesPKULezY5YoR/hoWDnaKMpNhk3Tf34HBwaROh53
         GcRQNkavgyhK9b3+098L8JGZ5gk1VGIVoceM2ya11oDvjHs8ML99oIHHvKZV6zt4ZE87
         mHKGWuejAx+slrIJKQcrayqNUpy2NMQIt6kLohbEvCUTQuHf4YbKiVel/cKEHLM4N4YJ
         y1g5zPBP+mzfFDGIVseumrYEZLUHl47waAS3tAlCtFGN57KnOnjfH5j8TjY4If4PBpKN
         WbAqpr9D41bcpP+VC5rcojcdR4IGZIoMA4QaSqv3JY87R70OWeeb1cJPvOYXlnZXgp2F
         DUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093674; x=1701698474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOw7FonKD9MbC43k524zBSSsF7xxQpwUCU29NYnvaYc=;
        b=Q0Diayw7MYZ2JhdV8GLdHtrwAdC2dILps1DqoIQ8ZrrzG7i2UnfQkHEk12b5obElfh
         g6xreUYD6nqKWotb1hH6vO6iHgTMx/VHEkkMWxzi/tKckWiMt+7w4I+Ellz6BL6yzfet
         LmfHp/HA9pBs4wst/zyuisX3XvLTci9x7zpcXz8ZiX5uV/SmkNwXH4PSvL0tFoUQTp4z
         8LEGoFct/fczb+/83+MezZPLqwrJWJnQdr89db2aIZtVJfpeQDujK9/WmYXEFwF4p1us
         y3S09zTBjk5N26DSDEKCqC+nKbJD8V9HakBPbFcyRSS/WTpk4K0TDCTfbV92pFHItU9f
         aqbw==
X-Gm-Message-State: AOJu0Yyh9UF7HrNH/E7BNrsUFPjC26kDnAvzzU4qPMcgeCUdnFWoSZxI
        M6S+XpLMpPmDaW+ZmusD3JtZzVkyCjRziVogceS5Iw==
X-Google-Smtp-Source: AGHT+IHW3yEZWLUXwXW7lR4kIYc6dC4HAOI3WjIsnCEwT9kCuUBav8/wXNjJwUSjpBcw7tbU4EpOfyuvEFAszzuQaQ4=
X-Received: by 2002:a05:6358:4407:b0:16d:abc7:bfab with SMTP id
 z7-20020a056358440700b0016dabc7bfabmr13836740rwc.15.1701093674044; Mon, 27
 Nov 2023 06:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20231118013959.37384-1-tmgross@umich.edu>
In-Reply-To: <20231118013959.37384-1-tmgross@umich.edu>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 27 Nov 2023 15:01:03 +0100
Message-ID: <CAH5fLghnpHCXg8c3wkpBrsxNLZjZvNZ6QDqu5rBJ8xPNkHSCAw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: update 'paste!' macro to accept string literals
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 2:41=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
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

Since there are no other replies to this version, I'll confirm that
this still looks good to me.

Alice
