Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A197FFEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377149AbjK3Wu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjK3Wuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:50:52 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D0C91;
        Thu, 30 Nov 2023 14:50:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b8903f7192so897810b6e.0;
        Thu, 30 Nov 2023 14:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701384658; x=1701989458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9WwWZklN0+vDMUHEvugiN9GLGkxGRM9Mi/9Ul82cU0=;
        b=G9xF+sDw8cfPlKP2o/y36pPN8MexE9lZ1ImbVHHxM+fo24+69BPT5QSTSyuMBCbY25
         JasR5cjJYm8X/z7rMoER1yhdU6VHTL93LdKDDb5ga2SHfJ0XqX9tnOs0DWYXYuBhAp5N
         KL/p+fm/zxejDn9m1NsOKASyNSTJmnl6n9atQDb09qxI0Qfck0swtqpiHNwO0iPxZYwJ
         k/MqVvAW6fRWmOKvpR9YEXlaNldOaDi+DsnBprkJXSwFE90t0SbJYit7cvw6nRdGqdWq
         WKxLMveK2Lr2WeTAARSfGKJ9pOWpL1FzE9HHntN+AiMaTSchpNGhjH8yK9449omknZ78
         ar1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701384658; x=1701989458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9WwWZklN0+vDMUHEvugiN9GLGkxGRM9Mi/9Ul82cU0=;
        b=Fbmm8aW5bMWPw0QTMmIq+LGPYosyqW7oF7hW0qY+DfPKr1PSAHcwKtEkAu3foEu4Q9
         maNMmwAABD/Ls0zQE019CjAaLWeVCOMnOYjo9yjpG69YAnYjDKVDTXyaiGQ48h68g/Nm
         88Bgie0my+ysmXjSQpM+ikfEA7OKQWHm7DOx0J82x8wkozdvT7jzU585gI6868vE7ZjB
         hpKRzlfhZtim3IUrKjxrM4HkT3UY3YadtenvCGWlAss10cYjrebRPLxbs1xpy4HCuZz8
         oNjBF1+ZSikcNTS3eO9vRLsIsbZcFMuAnIPsuIW0JLWPJHiTpcVwTlxo0iRK7NdtsVBZ
         3s/g==
X-Gm-Message-State: AOJu0Yx8pKlJgpl+TFMyzQSoCD6mlzYyQvM/SkLq5NHkxaOs6rx+rgHt
        cZ+VdfOtVUaF02zdvnm9jfk=
X-Google-Smtp-Source: AGHT+IHHqa2BAvp52jry9MyArbZJZ++S2L7AL8Wt6kw+X6HYLK+spG+Ab62C3S9/lvV8GA9icyKAYQ==
X-Received: by 2002:a05:6871:e499:b0:1fa:d6e7:afe0 with SMTP id pz25-20020a056871e49900b001fad6e7afe0mr2341151oac.56.1701384658387;
        Thu, 30 Nov 2023 14:50:58 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o16-20020ac841d0000000b00423829b6d91sm904566qtm.8.2023.11.30.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:50:58 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6448C27C0054;
        Thu, 30 Nov 2023 17:50:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 17:50:57 -0500
X-ME-Sender: <xms:0BFpZTmjNyO3oF6v_Lt59lTff--CU9ho_EPPua_jbZ8PUD5rQgoIlw>
    <xme:0BFpZW3R1ykypLK5g6XhdSIObLGAQHbEHpnzcm-xTbZeH_E134ccZLm5wRw2XKKJe
    Ja1KwNJf9v4dOWrRg>
X-ME-Received: <xmr:0BFpZZpx6ERcuYNBUswBJgUXf-WI9yybjBzeWRBg2VA_o6igZWGYiRLYr4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0BFpZbkm5LdzT3vE41N4hjSPpmUEyTVlRF0JMmLPygPvoLHUf-vhXA>
    <xmx:0BFpZR13vqMb7FyZz3LX_IPIEm6g8U-ShYhGp5iJSKvXTVjHPRU1-Q>
    <xmx:0BFpZathv0zmEcHegDNZ_apjEwnuNEVC6IauIylCmnVXsjdeYX7xxQ>
    <xmx:0RFpZSd9on4wAc6osvZHqUVsZHeisouzSjDj0cgW3iL8KDJLsSm7Sw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 17:50:56 -0500 (EST)
Date:   Thu, 30 Nov 2023 14:50:07 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <ZWkRnxT4ymjn0tYM@boqun-archlinux>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-7-f81afe8c7261@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-7-f81afe8c7261@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:12:51PM +0000, Alice Ryhl wrote:
[...]
> +// Make the `CondVar` methods callable on `PollCondVar`.
> +impl Deref for PollCondVar {
> +    type Target = CondVar;
> +
> +    fn deref(&self) -> &CondVar {
> +        &self.inner
> +    }
> +}

I generally think we should avoid using Deref for "subclass pattern" due
to the potential confusion for the code readers (of the deref() usage).
Would it be possible we start with `impl AsRef<CondVar>`?

Thanks!

Regards,
Boqun
