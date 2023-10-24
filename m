Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6A7D5931
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjJXQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjJXQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:51:59 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504FDDA;
        Tue, 24 Oct 2023 09:51:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so3200135fac.0;
        Tue, 24 Oct 2023 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166312; x=1698771112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KDQl75KbMe5uLN513yRphkBvJX1k6bz7ls81M+yKsc=;
        b=LMje8IXszpXduRpCyhKxHO0NmedDYfQjOR2EQx6bdfnhyMiE09KFsy9wWXPEMMjUNQ
         JiYG7slBWpuXMRlLX0tFkz26/F6/S099zKjkAj3nQGLcum/DOF+AF8ysfht6SYdxQ6Ro
         UsjQLDbjN7UkV/t08ykqGKYbH7Fcw7cvkOrOBXsuPVWlpFmcgDMcx/guegOe1Vh+Spwb
         plvS0Kfn8Cas6LWhFCraztIG+KDIsJHwe0jIa6dyHQteL6RWHb0hTHT74xCX3LLIROle
         Ex5iS6jGwNZr6hHooc9loz0CeJtEy2u1b+WtfZUHWUIHkBkcm6EKXoL2ZAHg4l75/CVC
         6aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166312; x=1698771112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KDQl75KbMe5uLN513yRphkBvJX1k6bz7ls81M+yKsc=;
        b=kvBF30B0hNIj/pqwxEtxP3J4wNxW0PtxjCM0Or35lhOKNDyAs0+uPNX5kjkf4XjAno
         oeA6jN9aUo3j9d5OWIX6jPoSA6l71bJDkBF7fGBeILbvUaLgYowQaML197I4i/kyJl2P
         nR5yCFFXCfHlz1XNjGwWuNcZnlTD0jnVTULpUGdxXUu4SwIwvQUnGWaoIUyrNCifiiJX
         N72OhLbUnsAVna4OUaf4Tlz7/K+SiqWXQqzfF8szapNsh0ILQvH2V31l3Bie6f1jT3LD
         fpPhoJufgAaVmrBLgJiyiwkspf/5YATgZd4rx1XjYzE4k6X5Bq+bKbvSLkoUG3/rFOJw
         Va6Q==
X-Gm-Message-State: AOJu0Yx9M5++T4gBuje22ggMwSdkKAzwVU/OzElJf8pCt//sgjFLNfoY
        Ox+cvzpPFz66WyrvVaj9TOE=
X-Google-Smtp-Source: AGHT+IGi/yuFN4nFlJtB+prJuFd9VC+vQzxoC0HUzYl6hU6ba6YsljDyerd5+Xs+6cpDul8Gf5s6lg==
X-Received: by 2002:a05:6870:ebcb:b0:1ea:1b5e:fed4 with SMTP id cr11-20020a056870ebcb00b001ea1b5efed4mr16886877oab.39.1698166312474;
        Tue, 24 Oct 2023 09:51:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b007788c1a81b6sm3570638qkp.46.2023.10.24.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:51:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D1AD27C0060;
        Tue, 24 Oct 2023 12:51:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 12:51:51 -0400
X-ME-Sender: <xms:JvY3ZTSY0KC9JXTx2NtsAk8Tq6w8xdhp5HOJNStv-0adxcCiXDG1kw>
    <xme:JvY3ZUyidZGd7zun-VFXwGf5H_gksarpmX98NbZwYIgMnZtIOQNJT4Z_88cfKleP1
    bhUHskP7VRvYp0owA>
X-ME-Received: <xmr:JvY3ZY26Vhx_gv0CsU2fO_F_vQOb900cYNeMNfRPPvRwlzPZMsru_a6EgHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:JvY3ZTCIZ4EGmyP90o_hGYSdZRzRyEyklSh6adVP3GgRyiOv4Krzow>
    <xmx:JvY3Zcjg84UK2P5DqeMrozetrqKMCJqYsYsW04Z_URVurPbzlebe4w>
    <xmx:JvY3ZXoBEU67RqVvr1uAc426tF3iPFfyvTjZtnQrqjS0zfBEfSTbYw>
    <xmx:J_Y3ZdZcA4z7qLr0geiZj5Ra3Zf2Pm3XAI0BoCWRvdT3IMyEL9vIMw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 12:51:50 -0400 (EDT)
Date:   Tue, 24 Oct 2023 09:51:10 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string
 literals
Message-ID: <ZTf1_iB9AgHlPnls@boqun-archlinux>
References: <20231008094816.320424-1-tmgross@umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008094816.320424-1-tmgross@umich.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 05:48:18AM -0400, Trevor Gross wrote:
> Enable combining identifiers with string literals in the 'paste!' macro.
> This allows combining user-specified strings with affixes to create
> namespaced identifiers.
> 
> This sample code:
> 
>     macro_rules! m {
>         ($name:lit) => {
>             paste!(struct [<_some_ $name _struct_>];)
>         }
>     }
> 
>     m!("foo_bar");
> 
> Would previously cause a compilation error. It will now generate:
> 
>     struct _some_foo_bar_struct_;
> 
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Trevor Gross <tmgross@umich.edu>

This looks good to me, but could you (in a follow-up patch mabye) add an
example demonstrating the usage, which could also serve as a test if we
can run doctest for macro doc. Thanks!

Regards,
Boqun

> ---
> 
> Original mention of this problem in [1]
> 
> [1]: https://lore.kernel.org/rust-for-linux/20231008.164906.1151622782836568538.fujita.tomonori@gmail.com/
> 
>  rust/macros/paste.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> index 385a78434224..f40d42b35b58 100644
> --- a/rust/macros/paste.rs
> +++ b/rust/macros/paste.rs
> @@ -9,7 +9,15 @@ fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
>      loop {
>          match tokens.next() {
>              None => break,
> -            Some(TokenTree::Literal(lit)) => segments.push((lit.to_string(), lit.span())),
> +            Some(TokenTree::Literal(lit)) => {
> +                // Allow us to concat string literals by stripping quotes
> +                let mut value = lit.to_string();
> +                if value.starts_with('"') && value.ends_with('"') {
> +                    value.remove(0);
> +                    value.pop();
> +                }
> +                segments.push((value, lit.span()));
> +            }
>              Some(TokenTree::Ident(ident)) => {
>                  let mut value = ident.to_string();
>                  if value.starts_with("r#") {
> -- 
> 2.34.1
> 
> 
