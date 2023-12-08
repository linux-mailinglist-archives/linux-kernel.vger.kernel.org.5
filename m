Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF5880A68E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574151AbjLHPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574147AbjLHPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:06:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055F10C0;
        Fri,  8 Dec 2023 07:06:29 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b9e07690ccso1087795b6e.3;
        Fri, 08 Dec 2023 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047988; x=1702652788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6pOl44hnRB0dR/4pW+aUDm4MDjfxjNHERGp+p3r9Ks=;
        b=RKGZJ1oyu1oqtzBh7o6NWd9xtRkwNjSZhcIA60MV6w2bnqt9MEjIUhchJY7zekJOCG
         JnLVZFybqQpp1lkP4LnAYqXkCcBzV/ngdf0KGu+0fWFG9uo2165cbG/u6dDV8UvrsEXm
         vwcgPxnNRR12lQRm9i7QXdqaadgOsicojbbYqJV8pdpcFsxBIDYN2UB2Mi24om9FlJdg
         2d3s9GAsnY5rqa6YLNJrmMObkf75LNzFIOUKdNk10etNHLrvxtchWY6vIpZJV5BObFiI
         pkCVm+7A6RfNi34mfIN8XGfV5vQ8o7Ce10LQU8iLLdkVS93yOUzK2dBGaCNscaP705ZZ
         tnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047988; x=1702652788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6pOl44hnRB0dR/4pW+aUDm4MDjfxjNHERGp+p3r9Ks=;
        b=RXFORxUeZn1MQWs7njUjEOnoHIZ+yRGPh8O4sslUXTtAyCRqyXOVrYd1hPKqSYj8c9
         zJPUS4CJ5L1uHmWVl6rGR0QIbqEZVOLBU9d1WFKgGzlCYXv6oXo1Qae5ICDRvJWJ4p8m
         sjXaZc9MOPJ2fzU80xs6yYXjaIIPXJ77ImXMPGVj3nVvpkSkyoywWeqqFSzwbK6lJI6f
         d+vYvymVH8rMom+c5fp2ZAGc+mz7xGpWrn9KZJBkVrwprR/kHJuHncmSMulaPYnohT/+
         4fEq3mr6B5GrB1/x0/UOS0iw8VWIi69Y3WphJuogOlu7WDrz3vOegoQEz46gjJYqWKdK
         iGOQ==
X-Gm-Message-State: AOJu0YzbDuOG7uSn02bSSf3bQW0Mc8J3c5hwLJmVF2HP4ZbJFZg5p4ng
        hJV/E2PREsrTC3ALNx9CVH+X1YZO6RM4GKglIkQ=
X-Google-Smtp-Source: AGHT+IEhSuVMBLg3I/VAynBjKxWD0Av3ewES2MqnKcaUDavCJV44U8FRNmSesRCL++zVPSTROJlOtkiynJgtwAFZF7g=
X-Received: by 2002:a05:6808:222a:b0:3b8:b063:5d6c with SMTP id
 bd42-20020a056808222a00b003b8b0635d6cmr163139oib.83.1702047988710; Fri, 08
 Dec 2023 07:06:28 -0800 (PST)
MIME-Version: 1.0
References: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
In-Reply-To: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Dec 2023 16:06:17 +0100
Message-ID: <CANiq72=0pOVCq2+nNArT4P_FTLDjUFBtVM=X7Emn9FQbB4QqkA@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: Clarify that 'rustup override' applies to
 build directory
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:18=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> @@ -39,8 +39,13 @@ If ``rustup`` is being used, enter the checked out sou=
rce code directory
>         rustup override set $(scripts/min-tool-version.sh rustc)
>
>  This will configure your working directory to use the correct version of
> -``rustc`` without affecting your default toolchain. If you are not using
> -``rustup``, fetch a standalone installer from:
> +``rustc`` without affecting your default toolchain.
> +
> +Note that the override applies to the build directory (and its sub-direc=
tories).
> +If the kernel is built with `O=3D<build directory>`, the override must b=
e set for
> +the build directory instead.
> +
> +If you are not using ``rustup``, fetch a standalone installer from:

Thanks Viresh!

I think it may be a bit more clear/compact if we simply change the
"enter the checked out source code directory" sentence instead above?
What do you think?

Cheers,
Miguel
