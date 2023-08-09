Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFF7767D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjHITEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHITEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:04:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D212C10DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:04:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so2340151fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691607859; x=1692212659;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoIERmiBBLKkASybWOp4oJC+EW2j6JMye2Kl5N+XUR0=;
        b=VLT0qvyqjtSurIhfdjo4yMyPCJM+MS69Re4nEISv9Jv3SDZ/zNH8KUhkHdlgJTZ0O+
         Y+vyD+AnoJon212RIUQAzYQIjMeN6s8DJhdilY4b1xQDJDu6TFyD0nx/qCg6bUCFrNRD
         8uPgmvS157KGcKk2PFBnaK7gdPUQkI/42+gDUVWu+LFDBhNr+0X5jn/NEpc7MxnMpbMd
         qpVtXud28EKPgtZDW6EFoawt+0h8kztN/WrcjKF9d42Jy30IKcgMCtP+OdBVXyk7PDAK
         /mUiu0Tz3Z75EeRRwsWg9de7YEO5mbX8dfkNEPgkEIi8RyjCLcI2vYGyv/d67MIiaopy
         nZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691607859; x=1692212659;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoIERmiBBLKkASybWOp4oJC+EW2j6JMye2Kl5N+XUR0=;
        b=IVZ6qqfNNtiHoJe01ml7Sx47t9Vu5xdtnrxGxkSMIovIJEFy3bWIjZEeRWcQVqX9az
         cCb+6qJtEozmSxNkl90RH7ydG4zE1YVFPbMr1gjKYF81u3Q0+31xWMn47zMK/d0HWi/d
         84SpCItWdk4sKVii5vHEn3CDjIjg/9y4ZNSd4xl2ptXLQAsucc/bMDDs3z0kWTldd3JG
         eZ9nE+albECFQvdwtzJ3MrC/crbThMLLRpBvceApnDyqsppVlaSNTjZaGvINXAgP+U+p
         GgvjxXB+k5lug6uFSo/HoS2T530mbsKcr9GfsbhIOukRumfWBIdIT6vD5qE4rWMSZWK3
         zrBg==
X-Gm-Message-State: AOJu0YxOyZodvDFLnJswxbNKp9LQRPMh+tc5pzcs2dah0W158fb8bs2X
        qbuZFBL88ZvHeNLxzMbA5qalLQ==
X-Google-Smtp-Source: AGHT+IG2BVjl6md9gBXu/8Udjjji60YXFadktZhjTPRa0AfT6MvE0TkrbXE6PslMt3D7ePw9a5TXJg==
X-Received: by 2002:a05:651c:238:b0:2b9:5eae:814f with SMTP id z24-20020a05651c023800b002b95eae814fmr54552ljn.50.1691607858808;
        Wed, 09 Aug 2023 12:04:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906394d00b009931a3adf64sm8588962eje.17.2023.08.09.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:04:18 -0700 (PDT)
References: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado 
        <sergio.collado@gmail.com>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: macros: vtable: fix `HAS_*` redefinition
 (`gen_const_name`)
Date:   Wed, 09 Aug 2023 21:03:08 +0200
In-reply-to: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
Message-ID: <87bkfgghqm.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Qingsong Chen" <changxian.cqs@antgroup.com> writes:

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

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

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
> @@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>                  const {gen_const_name}: bool = false;",
>              )
>              .unwrap();
> +            consts.insert(gen_const_name);
>          }
>      } else {
>          const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();

