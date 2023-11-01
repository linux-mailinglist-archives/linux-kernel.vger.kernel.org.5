Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98DE7DDF47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjKAKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKAKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:20:36 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE84E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:20:34 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so2038851241.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698834033; x=1699438833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz6VSHMner62jDzigXvDmGikA8eTXSz2/q7goADHTxs=;
        b=n4wuCNA3a+iOpCV0KjLF6K24a4NscTfTlnZ4iGuEV8HiVLWk7xMuZD1wrr+Uh4WpKz
         JCEyaQ+7YxXQhOslBnf84hrYVTg7TsmEqNvCcFnAJpvNiAgwJ0jAjKaZwJwC18WruWvE
         5prI6t+Yr2YnAsFUjk90NN4WLG7fb9jB1d/6Vps8/3SF/qv3XGThYmr2GXDzNpyIWD0q
         lU83sZLYbbqnPwQl/r6vQQkceePSyJJ1Yyd8GeCb3R27AsAj0DkosyM7G1pCg3p3e0Og
         Msdttte5m+ReBW/AzcoNG/B2oH/953S4i4DTTe7wpE3MJuU4K/WBjsat9s3rngaweJOJ
         i3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698834033; x=1699438833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz6VSHMner62jDzigXvDmGikA8eTXSz2/q7goADHTxs=;
        b=anOl6Uy3E1GYCQTE/LVnw0XYI8uZX7a7zfqWsMhg5fm1g2ad9L0WA5HeUUJc/z2jsN
         hCc5dAe4UJl5foP6T9vrc8sEqmgMJ7q9SW8Asu4KqpIltdj8c75Ysq1Q6hG6DHq6JhRH
         zM1JrfLajumoCsiliRorSnvJAxIRc3WXBnfD12/Gz9Y/H4LmMhdo0uEwyExMk1hNobj8
         jVKcQb3qrIDKPCsEpavVRWhKplnEt1A8UntMZimAmE+F9NIxXYm8Et/hajRjP3chQbDy
         DGSf88hw1bGwy+iy+JULTlhXvW6tON/nneIHW3j6M7reD2SLiaA3lAGoYvZ2mp1BxP3S
         VUGA==
X-Gm-Message-State: AOJu0YxOowQP2ohoF60Ho1/OO2IfyRwVE1QEO0J7+01HGUfuNID9j9Ed
        FKo5HNesGSXu51+LuoqqXnbKRyeVQRGUoVPsOe/JIG294qChnhOi0i2gaA==
X-Google-Smtp-Source: AGHT+IHdsVmFFMJ9OQqgYB/RwOFuXkwU/9iXlbSEOFRRZoUtRdN6idmJL2hW80l6eDsFQldYkXn4iC8CPPcau9py4/0=
X-Received: by 2002:a67:c38f:0:b0:452:4e56:5e19 with SMTP id
 s15-20020a67c38f000000b004524e565e19mr9811075vsj.13.1698834033149; Wed, 01
 Nov 2023 03:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231031201945.1412345-1-mmaurer@google.com>
In-Reply-To: <20231031201945.1412345-1-mmaurer@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 1 Nov 2023 11:20:22 +0100
Message-ID: <CAH5fLggk=YEtB798S+vWHV8J6GZ39rXYcvVnm1apt_BOZvAooA@mail.gmail.com>
Subject: Re: [PATCH] rust: Ignore preserve-most functions
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 9:20=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Neither bindgen nor Rust know about the preserve-most calling
> convention, and Clang describes it as unstable. Since we aren't using
> functions with this calling convention from Rust, blocklist them.
>
> These functions are only added to the build when list hardening is
> enabled, which is likely why others didn't notice this yet.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
