Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF96768A27
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGaCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGaCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:51:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B5E46;
        Sun, 30 Jul 2023 19:51:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso6548029e87.2;
        Sun, 30 Jul 2023 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690771908; x=1691376708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxOncAZZSwxSjo1ZI50mqwsE79qvN7QLICaEDitUUas=;
        b=nNZJEIaSCRJz5iHti1x4T0EYR5v/n7v2Kbtac5bnLQH2YsieD3zd5LM73/QXxJ3Tm5
         A2lm9vWNASv5GFI8q85J0neaAbLGQN49hSwF/9Rx8UfRjd2rfxEg5dAOqOSBGv48aoMU
         uzkEkRtvyuvm9qaMAbJTbd9uq6WT6UC5TN/PzUJ+ZxXUgeKVjRWD1FxdRyOGrOEVCgjX
         K3N6RJVhiaTvTRftW3FPnFEK9W0ktKZDAQx1IGPMEu0znngoky7tChbVBc+QewqMZKRQ
         VOvLUsKaJQ3mFqsbSVCCXuNc7P1bQSgkYI+XEemGSjp0/7oZBRVPEf+yhSupGp6QfTfA
         7YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690771908; x=1691376708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxOncAZZSwxSjo1ZI50mqwsE79qvN7QLICaEDitUUas=;
        b=UfhOH6tTUD7BuPTKtxoNNtPyARK0Y7XLsGSrvlqccOUNt4ydrnI+Zk/shW40xN/vr+
         f0I8vJ8yfRyi7+ef7hedEx2gpEwzoYqU8rzPaRnXYtv/Md4UFZr2ES74uBliVwBzoZ4i
         le4SGAnI6fP6l9Ty98OsrP9PVOzDbpkVGqzrVrZ1mrL8EBvma87QZnZbYJyHB9LbcXYl
         wBWGDoztAv3uznKxvP9LucDnF65K0XoeVGMyTd6wfxqvcX9br+X2pHV6xKkLrkDXN7sO
         /yIn+Z44MU7utFSm1YNpGgaVA4kSrxctpf/n+eoaObqltVEQG8XbIbz8kbIvL+cpM1qU
         yDdw==
X-Gm-Message-State: ABy/qLaPawF++6XgnE60s/TXaFoJ6KQUKQSkngU9tZj2uKFLVcGmgPS8
        EWnNUO4OyInAAlmjiROIkaY=
X-Google-Smtp-Source: APBJJlEoCvbJIRltUf4SYSVno+HB2sozy4IBOku2TXrVh+XLRqREYRz2QR12zk0uSFre6olJZdBCyg==
X-Received: by 2002:a19:ca16:0:b0:4fb:89cd:9616 with SMTP id a22-20020a19ca16000000b004fb89cd9616mr4537549lfg.0.1690771908164;
        Sun, 30 Jul 2023 19:51:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c44a000000b0052238bc70ccsm4843753edr.89.2023.07.30.19.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 19:51:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C214F27C0054;
        Sun, 30 Jul 2023 22:51:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 30 Jul 2023 22:51:45 -0400
X-ME-Sender: <xms:wCHHZCWFecp3VQAV4446EDqpg10rtVHctlhYGVGA0aZNL33n86uinw>
    <xme:wCHHZOkKb3_ljUtnoJHZ2redVYfsOMx7r5yCH8qKunmy8ZhaN0FE_K6GGt73zjXvf
    tckkXbm4dxB1nz2EA>
X-ME-Received: <xmr:wCHHZGZTQRqx_gODK--i1NnTmekKP2gqC-VlHNPscm08ZQluwVVgbrmSFYaE4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:wCHHZJWSqXmIqkjdSEmzADsvJvqYtd1bUDXM1EZ0oCGlgAljxLI2eA>
    <xmx:wCHHZMkLhbo1J6XpxpzWGuWGJAsvUXJ9qoYlGBfqGAWtRYgeuxiHpQ>
    <xmx:wCHHZOc2b583DzvJFiG0dWmz7414aAVkKGflGM1B3IyOK_Ib2bgBqw>
    <xmx:wSHHZFciWq12aapXLKurGBXx67PI8LA3xcrp_LOAkQnwO0JuU1CY9w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 22:51:44 -0400 (EDT)
Date:   Sun, 30 Jul 2023 19:51:03 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v3 03/13] rust: add derive macro for `Zeroable`
Message-ID: <ZMchl359xrEdPPNn@boqun-archlinux>
References: <20230729090838.225225-1-benno.lossin@proton.me>
 <20230729090838.225225-4-benno.lossin@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729090838.225225-4-benno.lossin@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 09:09:35AM +0000, Benno Lossin wrote:
[...]
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index dddbb4e6f4cb..b76c198a4ed5 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -124,6 +124,12 @@ macro_rules! quote_spanned {
>          ));
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
> +    (@proc $v:ident $span:ident ; $($tt:tt)*) => {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
>      (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
>          $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
>          quote_spanned!(@proc $v $span $($tt)*);
> diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
> new file mode 100644
> index 000000000000..0d605c46ab3b
> --- /dev/null
> +++ b/rust/macros/zeroable.rs
> @@ -0,0 +1,72 @@
[...]
> +            TokenTree::Punct(p) if nested == 0 && p.as_char() == ':' => {
> +                new_impl_generics.push(tt);
> +                if in_generic {
> +                    new_impl_generics.extend(quote! { ::kernel::init::Zeroable + });

Looks like the support of '+' in `quote!` is missing ;-)

Regards,
Boqun

> +                    inserted = true;
> +                }
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '<' => {
> +                nested += 1;
> +                new_impl_generics.push(tt);
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '>' => {
> +                assert!(nested > 0);
> +                nested -= 1;
> +                new_impl_generics.push(tt);
> +            }
> +            _ => new_impl_generics.push(tt),
> +        }
> +    }
> +    assert_eq!(nested, 0);
> +    if in_generic && !inserted {
> +        new_impl_generics.extend(quote! { : ::kernel::init::Zeroable });
> +    }
> +    quote! {
> +        ::kernel::__derive_zeroable!(
> +            parse_input:
> +                @sig(#(#rest)*),
> +                @impl_generics(#(#new_impl_generics)*),
> +                @ty_generics(#(#ty_generics)*),
> +                @body(#last),
> +        );
> +    }
> +}
> -- 
> 2.41.0
> 
> 
