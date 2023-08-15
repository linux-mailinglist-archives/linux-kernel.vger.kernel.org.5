Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38677CCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjHOMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbjHOMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:44:18 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9C1B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:44:15 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 152E23F20D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692103454;
        bh=aKXkgUDnJHg2N5PCGlfRG9EGkT+Cy8Mp+msAUINj40A=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=P3TwwjcMjTziRkFx0HmlpIZ+yik2lbQdYtQZBJ4nQDdgjnvkt0LSUvDji7t9WJSK2
         ERjhDeohOwCyo/XYLBnzsTTlG8ppR5MqdNji/SYr6liGQwLfvfSkXx+FCIaMulNJJU
         0kjlPgWVDCpJY6l2sfUXJ5tS98mniFkpIBm3Mp5OxZ1HhRNHcCDZZws4HifY2DMJcH
         NJKBbnC81O2iU61ML+TXPJ4pFMK+9q9FWJabDK7uGztSw5hsspF1+zlLH1Asxwwwfx
         uDk7GGElrxqZvxk/AkDEZva/eYD3/LhWSdrAI2n/bS8FfdwZYOqUE99CWSeO6apsxs
         mDQ68wFNQ+WJw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5256fdb3e20so657458a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692103453; x=1692708253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKXkgUDnJHg2N5PCGlfRG9EGkT+Cy8Mp+msAUINj40A=;
        b=dghTHIcttyYdab2IvzOeasCUc56vy7mT1jlRYc8PI/VQoglfFAZFRdqGqEQyOSJdFx
         DBM301LRQm9yBtw3RWMY+/ssWybBUM/JaJbFsCcLtF6+N5394XU6vykFIVA5A+UJKOKb
         nWzOxqQr7+M8EQXSgEaqQXypq34h5NmqrO1Ci3pexa7vyIbRAKpYOYMsU4EzVgOgjGzC
         F98kGjZYPUwiL9FnL/Tkh91xvdJjD0XVgt+EPINwx84j+Q4kwk/6Mi7JkoX1K7SDaHMz
         aTUghNVbK9Tqr/2zLU3IPFJu6/HicacvDfqS46edgDmEEByGI06IYRBWY65PdMWGJiwj
         GZ1w==
X-Gm-Message-State: AOJu0YzGIG2e0DezJ98JVljk1LC49JjA3c3FRb7kuYjn5BYoE/HblX2p
        FXYq5eOsLsKBwtdheWZGVJQffgiDw1bmHwIlA1HzARC05q/oy+AP72Jfh95iDEOHjbS4E4HQ10L
        jWvsqjypr+PtVe6Py4APcHidZBIqDJcZO+uPQUHX3OQ==
X-Received: by 2002:aa7:c417:0:b0:523:37ff:1170 with SMTP id j23-20020aa7c417000000b0052337ff1170mr9409105edq.16.1692103453509;
        Tue, 15 Aug 2023 05:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs/E8V2NDX2XcJZXAbneao9RjH0N0K37FNbOeFzjvaaz6pGskl/cJoC5Rjc2K/AfZKmz/mkw==
X-Received: by 2002:aa7:c417:0:b0:523:37ff:1170 with SMTP id j23-20020aa7c417000000b0052337ff1170mr9409084edq.16.1692103453179;
        Tue, 15 Aug 2023 05:44:13 -0700 (PDT)
Received: from localhost (host-79-33-195-131.retail.telecomitalia.it. [79.33.195.131])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b00525683f9b2fsm2320484edq.5.2023.08.15.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 05:44:12 -0700 (PDT)
Date:   Tue, 15 Aug 2023 14:44:11 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] rust: fix bindgen build error with fstrict-flex-arrays
Message-ID: <ZNtzG3Yy1US+dpP4@righiandr-XPS-13-7390>
References: <20230815065346.131387-1-andrea.righi@canonical.com>
 <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:06:36PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 15, 2023 at 8:54 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") enabled
> > '-fstrict-flex-arrays=3' globally, but bindgen does not recognized this
> 
> It may be more accurate to say libclang here (bindgen forwards the options).
> 
> Also, df8fc4e934c1 did it so only conditionally (if the C compiler
> supports it). This explains what you are seeing: if I am right, you
> are compiling with a modern enough GCC, which enables the option, but
> with an old enough Clang.

Oh yes, indeed! I'm using clang/libclang-14 with gcc-13, if I switch to
clang-15 everything seems fine, so I can simply move to this version.

> 
> > compiler option, triggering the following build error:
> >
> >  error: unknown argument: '-fstrict-flex-arrays=3', err: true
> 
> This should only be true with libclang < 16, since Clang 16
> implemented the option, right?
> 
> In fact, Clang 15 seems to work too -- it seems the compiler does not
> error if the option is not within [0,3] (unlike GCC).

The combo gcc-13 + libclang-15 seems to work in my case, instead with
libclang-16 I get this:

  BINDGEN rust/bindings/bindings_generated.rs
  thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h_146_2)" is not a valid Ident', /build/rust-bindgen-0.56-DgAMvF/rust-bindgen-0.56-0.56.0/debian/vendor/proc-macro2-1.0.24/src/fallback.rs:693:9

Thanks,
-Andrea
