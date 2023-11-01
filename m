Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332C7DE600
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjKAS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKAS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:26:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD04E8;
        Wed,  1 Nov 2023 11:26:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-778a92c06d6so1614585a.2;
        Wed, 01 Nov 2023 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698863214; x=1699468014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VZ3WV5n4DWHHyNJJ+MsK66NBj333/Q6gIZOzccKpE8=;
        b=EATGl0iQUtWhn4Zs2IBjEkVrP521+PdmG5VqiLXSOVMQnA4+YEvVpCWNgZqa476Ucc
         mRFtN3NezePPwo2XXyj/yvIueJiFsBPFQcGXrPpRZnnpITD4sfQIanN3Og8om5CgW8tA
         6HY1lM2wcHhnQm/yt2N6nlbwNWEsJ65QzXpbaZcfmRHnbvcN0Vv3nvJ5mv+cypb1qs68
         M7hEer2XLbUxom1wgbhbGXy546CoySAS+uGULtQ7VuFmD5su/Qg4VeL89h6J27lkywbT
         BmuTbCbitljbPCtVx9JLjj1p+DEwgqpnAiaMS1SGJ01a/gr3XEAdgcv6i5YF0/8t1luk
         dfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863214; x=1699468014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VZ3WV5n4DWHHyNJJ+MsK66NBj333/Q6gIZOzccKpE8=;
        b=R8TWKSTXJfbh6o61L1vICM4OPrqdeXYyvn0LrHmgHRqP7nx+ggyJ1VWfROmiyGQ1i9
         PBFIjHsQsCpfahKNZmb+UveytVwja3LvS/hlHm8zSjQuU4a2SpEBRil1daMtAFjyWX6i
         Fyv1Wp2pXfSwlMsfdXrffu256pt4yFNI0LysZA5vATsh5YGdLkJlETsug09Myic99FJl
         HEJaiLrax7ljWUSsGIwmrniQfpClXkn2qM0DNIwkWMJxxotmQ0f30e+lndtwrPMjD2WO
         cWZ+yoK2nTXHLxzHDfbzIOvTZ2Ly2cY5fGt6c6S6FkFd6mS8bIr0uwjBjEhhmFG16u9B
         PLCw==
X-Gm-Message-State: AOJu0Yyk7wFd85AvZZsk01prOsp8gw1RcFqpFMciJZhvuV3NOQrqULxB
        9Iu1Nt59vguh6C6otr1C9so=
X-Google-Smtp-Source: AGHT+IGdZeKlaiQJOZt0j8/lfOIhTom1x5FwogBoM9ZVcHXZVgCjrQUSCvZSpak8Q1d9FYbjkh+PTA==
X-Received: by 2002:a05:620a:1786:b0:770:5ba6:af74 with SMTP id ay6-20020a05620a178600b007705ba6af74mr18257781qkb.18.1698863214112;
        Wed, 01 Nov 2023 11:26:54 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w1-20020a05620a094100b0076d6a08ac98sm1646904qkw.76.2023.11.01.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:26:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 34FEC27C005B;
        Wed,  1 Nov 2023 14:26:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 01 Nov 2023 14:26:53 -0400
X-ME-Sender: <xms:bJhCZZWWsIUI6REjc9Zh4YMaLkK7niaIPsGYgl6AL30BuPxTNQ0mcg>
    <xme:bJhCZZkXzOJPVZtQZqu4hcg-EbT_qso41A0GpJQ8XbXfkH4SYd_uoZ6cNWmNc13ol
    7Vrf-Ycj1IJ785qOw>
X-ME-Received: <xmr:bJhCZVbahVQKP2EZ2ob25TWrDBXcVnmsHlgg9gEmHwsLmLbRA-qSHegGo7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:bJhCZcWmUl_NrKjDI8cAOOBNaPQfZO6vEk9rvxLUvB0PVjwjIOGi9Q>
    <xmx:bJhCZTnE5ac8NMMvJbXF6fPB7TumYk-mApg0SfBMRy-3BvdtQnxZ2A>
    <xmx:bJhCZZdekr7aK0xBlA_BlyRpxfc5G0C5nUUIewit8hEM9ncfUgghlw>
    <xmx:bZhCZTEqx_Zapl8Yvq6tFPzcT2NxGWdBrrQn7d_eGbHM0EyS9TO91w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 14:26:51 -0400 (EDT)
Date:   Wed, 1 Nov 2023 11:25:47 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH RFC 01/20] rust_binder: define a Rust binder driver
Message-ID: <ZUKYKw8QlPguQEBM@boqun-archlinux>
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
 <20231101-rust-binder-v1-1-08ba9197f637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-rust-binder-v1-1-08ba9197f637@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:01:31PM +0000, Alice Ryhl wrote:
[...]
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -21,6 +21,7 @@
>  #include <linux/sched.h>
>  #include <linux/task_work.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/android/binder.h>

I wonder whether we could (and should) move this into
rust/uapi/uapi_helpers.h

Regards,
Boqun

>  
>  /* `bindgen` gets confused at certain things. */
>  const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> 
> -- 
> 2.42.0.820.g83a721a137-goog
> 
