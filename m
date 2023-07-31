Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B1768A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGaDBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGaDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:01:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F493E54;
        Sun, 30 Jul 2023 20:01:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf91956cdso256570466b.3;
        Sun, 30 Jul 2023 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690772477; x=1691377277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecUeirOJHielqU2V2QVVlEgRhDgcv2ltG9OUNcEijcA=;
        b=nX0e097CSjr22VDhuIDIPeIgbVAIX7YH0gJQP2A8blXy9F7xn5KBxQEPuE9+Fu45LY
         ODMVDuVEfhL2Scjm7EpqDwGICiM4WUi7Zdcs0UhNKc8+wJ4RmyO1VBXfyBj1vTDgvWp0
         Z2wgpBN8g4pnkwqgNf+5mXk/pxk9/xSH4jR2SzVkKBO3SmMRYXuvCddZS7phDlXDn1yG
         04X0DlzOWQWc9DXrREXThstgiHgGH3K5D1kppiJqqwMzrZzJRzfl/44HcnrFwb51x2um
         xZf20gYYCbuM0UZGkEFYYXNbQt4HZ5fRl/NlcANSqD3zfzyT28skJmiHjjBmmYt/O8jD
         UyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690772477; x=1691377277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecUeirOJHielqU2V2QVVlEgRhDgcv2ltG9OUNcEijcA=;
        b=Y/S/kiM+G8QO/3KcqM98pfFoPvxSg9X+ltJi4jMpotmjSl5BExOzk5VRlngTzoEmKd
         abPafLY6JEN9x5lf02uIWzmNUCGpGpDfVNux/kvrJXkjdCZXMtHIn2CM9Km5ilPMHXHF
         Apy3Cdf0trr8ZleMCM/VKaQGSe3qVhKvYm2ujyWtyaHi+0jW68l8OaHNLeCTYTPaTxFS
         JIUYXHQAriqdg2UqpPbqDx+jrDVA/0zMLp2JIWlz9NmCh2peapKWWHhr+932iLxtlsmz
         m/rURThU67/+PBbpfsRZNLyDrICUUYP8QxXBT3WVoLpxt5bT6LiNvjiQ2z6W2EmbYHIi
         gPaQ==
X-Gm-Message-State: ABy/qLbBMBcHHoFcpfwrpL568iwJ1jP7R9yR6UiB+2Ry394DbYptctPf
        AFN9C2Tiv85ZmwNqb8TGvM4=
X-Google-Smtp-Source: APBJJlEM6I/lSlKGXZQNa4yMbGUH/reP8m1tygmzdl+8XpVkEnwdqvfxsZZFN8QbbZqBxg1jMF+CRQ==
X-Received: by 2002:a17:907:7817:b0:99b:627f:9c0d with SMTP id la23-20020a170907781700b0099b627f9c0dmr4835252ejc.27.1690772477455;
        Sun, 30 Jul 2023 20:01:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v25-20020a17090606d900b00992e265a22dsm5500004ejb.136.2023.07.30.20.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 20:01:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1309727C0054;
        Sun, 30 Jul 2023 23:01:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 30 Jul 2023 23:01:15 -0400
X-ME-Sender: <xms:-iPHZNeKPJdM5RYXr36b7F9wTaxdAPi-tIdd5S1lQAu_v_m3ipS_pQ>
    <xme:-iPHZLNjroExiln0MvVR1zH-LI1UnDkkxybu_5Fly89L7O7L-JWte6uLS4pucqAxR
    NWV2IvWLldvytJAew>
X-ME-Received: <xmr:-iPHZGidN_9kjyY47ntasgX3wkPLaetLB3rFI7KPOqXcJLBwfboj3GwmZXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-iPHZG_h3DJ28HVkmVU4xt8O5frYly_iCXN5KkwwiRp8aK59mz04Lw>
    <xmx:-iPHZJt6LWt0DLOWai32HJfrH0oCDeNgkZ_WuepiPiCkX9Whuu0KJA>
    <xmx:-iPHZFEST3C9a8ZDb7FlxAJycDRkBtSAO-QhTUqFf0m9-bs0RLy-LA>
    <xmx:-yPHZKnpI9DMQjnLdnCtA3Ldfy0KNmbTOn6oUzfiCIZfJXmNys87xg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 23:01:14 -0400 (EDT)
Date:   Sun, 30 Jul 2023 20:00:33 -0700
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
Subject: Re: [PATCH v3 08/13] rust: init: Add functions to create array
 initializers
Message-ID: <ZMcj0TswxyCu5hpd@boqun-archlinux>
References: <20230729090838.225225-1-benno.lossin@proton.me>
 <20230729090838.225225-9-benno.lossin@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729090838.225225-9-benno.lossin@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 09:10:02AM +0000, Benno Lossin wrote:
[...]
> +/// Initializes an array by initializing each element via the provided initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mutex};
> +/// let array: Arc<[Mutex<usize>; 1_000_000_000]>=

This is nice, but (if I got my math correct) it requires ~30G memory on
a 64bit machine, and when this example got generated as a kunit test,
my poor VM took forever to finish it ;-) ;-) ;-) Maybe descrease it to,
say, 1000?

Regards,
Boqun

> +///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
> +/// assert_eq!(array.len(), 1_000_000_000);
> +/// ```
[...]
