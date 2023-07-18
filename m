Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4AD75832A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjGRRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjGRRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:00:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D8273A;
        Tue, 18 Jul 2023 09:59:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992e22c09edso720442666b.2;
        Tue, 18 Jul 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699524; x=1692291524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ulw/ALqDhV+55v6B2HfDiA8756U1VPUvxl6g64QMlDw=;
        b=E/yWojZ+Al8+/faHny5Lw56CZPJ3N7qEmKDKI3xfVtvC/AT8R9y9Ra0MQrCI41XcNM
         +hlH9Rf73ofCj/Wjb56RD6Uo/bro3u8gxStDChZTJoJfjki4juBb6HgruSC7n+zTyNvT
         /mZ3mOfQGThxAE/IQ7yXDAJWuR4PsTNIwWqnw3t3ggTpY0NPhB5klmSguZPVPadPSpWq
         LIzPplmxuB1CDZ3qzoMOHHXsBGPxelzlnBH2WkD7PRhth2GzSPve4yISrsVurYCdhgbq
         WDd5UKynXsUdKucLxPdhFGEcDdkp3AHCnE+Y5iZOFQmRBUn8SM5RSTAmNO9TyJvLbEkQ
         wiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699524; x=1692291524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulw/ALqDhV+55v6B2HfDiA8756U1VPUvxl6g64QMlDw=;
        b=Gtctal0CSRMKyfGfDHqGvvhvirffVXzv7k12QgBmkrXGES6GNAEgIrpmPCcVtD1KLa
         R1ZKubJPPJ2VcwZ75JZWOxeOyEwWNMK9Fd4HiQVIAHwGLmQ839JmU2+K6h8DjJ0CasgO
         t/9ISQAZ1D/luW7Ai14hlm8UQEQ9fKgiDhAwt5xiEnznYn02FKN9H5+984Bynf3tOA/t
         HfXAXkeRkbcdA3RWTmoNJBS1p7SbHv5UtosAEZRZgf4sv0KyWKCce5NUM285HHpSuKtt
         RFnMNLH5cKZNqTmkMR2R8LqxIT6fB0wz8S12MXB8XmN/NpgtcQGd+BrNQ8ECE2HNwP/W
         4r2w==
X-Gm-Message-State: ABy/qLZr3SYcjkMkFJB/EVduliy2r9ExW9iwbvGsBeltMzy/KciZBvaM
        gI3ZsaMdEhcOOyk+WmOFVdA=
X-Google-Smtp-Source: APBJJlFgf4GJ/l4UK5sN6cmPg3I3TXRkTGsobZx2gEc4CRrE7Y6+aQcBjJSxuxYH/h3e31wyaYO8SA==
X-Received: by 2002:a17:906:10d2:b0:98e:16b7:e038 with SMTP id v18-20020a17090610d200b0098e16b7e038mr465685ejv.23.1689699523752;
        Tue, 18 Jul 2023 09:58:43 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709060b1400b00992e14af9b9sm1212251ejg.134.2023.07.18.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:58:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 95E9227C0054;
        Tue, 18 Jul 2023 12:58:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Jul 2023 12:58:41 -0400
X-ME-Sender: <xms:wcS2ZPGGFQ9hyeSyRv3zLRcKsE2JE8QTP0cCZSMkHtC_WRU3mOqWQQ>
    <xme:wcS2ZMUWiW9xQP3JyRx9nbrnwrwbTUcM5XOI15ODruDHR-oHUqmV7iYd_m2-YkUXm
    2pFiH-0qTEWJRvqmA>
X-ME-Received: <xmr:wcS2ZBII0HKTk57RUCnWmwHZO8XyqQFyBk8nbmwKU5AZw85srv_RfZ56Boo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeugffgvddtiedvffehheejjeeuieejleevieejgeetffdtgfejjeet
    veetudeknecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinhhugidrtghomhdpthhokh
    hiohdrrhhspdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:wcS2ZNEHTxtyd4WchfxyqrDIJdGgfriBjFJEg0ILRJdByAVfekw-Bw>
    <xmx:wcS2ZFXem1CIZcysVSxLDRaG7OfDY9XMpBKBi9jOKj6OZcsbkem-CQ>
    <xmx:wcS2ZIOkYIlKjiSlVxX4m2bXLn0KzndRV8GwMMqg1Hl-cMv2R9AHcg>
    <xmx:wcS2ZOOvOt6v6nEDXzU_yVF3nGFlfkEjtcqRdu6_pWuUGmGKEseDTw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 12:58:41 -0400 (EDT)
Date:   Tue, 18 Jul 2023 09:58:37 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add Alice Ryhl as Rust reviewer
Message-ID: <ZLbEvZpHicXT5aSm@boqun-archlinux>
References: <20230718054521.1048785-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718054521.1048785-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:45:20AM +0200, Miguel Ojeda wrote:
> Alice has been involved with the Rust for Linux project for
> almost a year now. She has been primarily working on the
> Android Binder Driver [1].
> 
> In addition, she has been reviewing patches in the mailing
> list for some months and has submitted improvements to the
> core Rust support.
> 
> She is also part of the core maintainer team for the widely
> used library Tokio [2], an asynchronous Rust runtime.
> 
> Her expertise with the language will be very useful to have
> around in the future if Rust grows within the kernel, thus
> add her to the `RUST` entry as reviewer.
> 
> Link: https://rust-for-linux.com/android-binder-driver [1]
> Link: https://tokio.rs [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Welcome!

Regards,
Boqun

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..f19f34e3926d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18542,6 +18542,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Gary Guo <gary@garyguo.net>
>  R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
>  R:	Benno Lossin <benno.lossin@proton.me>
> +R:	Alice Ryhl <aliceryhl@google.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://github.com/Rust-for-Linux/linux
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> -- 
> 2.41.0
> 
