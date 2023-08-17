Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFC77EFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347900AbjHQDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbjHQDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:45:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67C526A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:45:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5409541a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692243914; x=1692848714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1BgjUd4XeLDjePWLEkR6YV2AiwpHk7vLupAQf6XJLQ=;
        b=TvgxcjKypMfJeopGsUNlMXTiUHcfuLHQ/y2jvog9XzAJ3arUvziwgeymTbDVDXJFON
         0zVyTwy7OJQhGWjYkMs5oK6URxYhyfHYxv+HkNPWZiNeTZm59BxVAP0jhM/FrkTRO/gh
         g0uGDl27dEWbKesbWcwe80Fu9ixMwAbcyLO7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692243914; x=1692848714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1BgjUd4XeLDjePWLEkR6YV2AiwpHk7vLupAQf6XJLQ=;
        b=LugB9guVrxwwcl5s+szHdkas/mr9hl98mbObJdp4f9LaTaiGNhMe64nHOn9+drBWDW
         tynpBMYmydZRFY5VApACZNn2mSkV18JdtiigyNZBdnemDisGFAdyYH9BKoR1q9jWV+K/
         u3tMFteJoa/mPtSv2miJ5/hE+/Bp9pr1Z5jnmx/nJMigybx1w3fupNwkGrm1+eR+PnqX
         YxlWc0QYM94ivWbuprsl99+VE5X0PyxswhLE+8O9MQnqeIh/CosS/0QrESyfTubN+DG7
         IFAkCONZ/2Jyyqi5YL8AIkz+yqGlDnn8EKd+VajLEdUxlYfDlboZtJYbSks7QGcXVZ38
         sAZw==
X-Gm-Message-State: AOJu0YzbQzI3G9o/f9TCeSSekbjuyk5jkeREWENsLCK3b4PNlZUWPl7L
        gmATRFDNG25I4yZ1VJPYiNHWWw==
X-Google-Smtp-Source: AGHT+IH8lolk4W+WcKJ1Kxtt09L5YGzywK1Nuph+YXsBY0VuP/2D2X85rls5K/9b24WwiohRWWW+PQ==
X-Received: by 2002:a05:6a20:748b:b0:133:6219:15e2 with SMTP id p11-20020a056a20748b00b00133621915e2mr5072261pzd.21.1692243914250;
        Wed, 16 Aug 2023 20:45:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020aa78d56000000b006765cb32558sm4292519pfe.139.2023.08.16.20.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:45:13 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:45:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] rust: fix bindgen build error with fstrict-flex-arrays
Message-ID: <202308162043.3D267E19D2@keescook>
References: <20230815065346.131387-1-andrea.righi@canonical.com>
 <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> 
> Kees: this should only affect `__builtin_object_size` and not `sizeof`, right?

That's correct. It would affect __builtin_object_size,
__builtin_dynamic_object_size, and -fsantize=bounds instrumentation.

-- 
Kees Cook
