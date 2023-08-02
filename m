Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2176D596
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjHBRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHBRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:38:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB39468C;
        Wed,  2 Aug 2023 10:37:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d3522283441so69561276.0;
        Wed, 02 Aug 2023 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690997838; x=1691602638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djWM5i9lKuUVTLXZbqtDmTQwu3LeHQksxQd/wmHnh5o=;
        b=d+ZqYhUfDUN7p9LdY3RpuIzJMd7/pk4utBEwCUvys8aVbnL08kEqjn6rYYsrihOB2X
         caUoVRK/F6TxJhWMBbla21BzgwTrx7fmAGlpNIzC9UD95KvtSmBtRSpAwTfeEWT8lddM
         54kOAl06sRsi57LMujdMT8CbIQHYCF6JF2XGlzVFE3tVL6NmQodJnuYwl5AdcvVoXcRB
         KScVP3TdV+HTFwfPM1ZAGV93wtGfMynKS7Horqh9HUqdEbmV9UV0JFYMi93UCji4u2EV
         19g5NDzQP14KJhpcSek45Va/jxNUPc79QY1b6VqnQxqklMW3FLcYzCKTdCLruVQRJhXL
         j/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997838; x=1691602638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djWM5i9lKuUVTLXZbqtDmTQwu3LeHQksxQd/wmHnh5o=;
        b=Yr7f7Fo7taSooThiRaS+0xaZ2ogTxLtGHAaHtR7PkM9Rcxw9301JvguerF7dneZOKE
         Y/rxIC1Px6tZm+0cIAR7j/kuHL9GdiJds+Dx0Fow6GKZRzO+mBMMlTf7GrsystjqrB2Y
         pq+47cngEDPDPmz/OOwOzkCn69ybSfkkmyBapHFhFa2m/vuPgWPzsBsWIv7DMIdU8JTl
         gMRsgZ0JHJy2qdy4rBl7naxB9pyalGaqohtdzYiHeIXdzyV07WW+ZB8d0n7rJM5W/Ck3
         0ka81m6J6ZzxhOn5aspYl9xg6IZTCJ8kmVvZm5x9cKS0cPHwfdGsBpAUB3k3HrQJdzi6
         bz3g==
X-Gm-Message-State: ABy/qLbxsf7nQaEYQvPCJaAsrFKok9i3CesJ+zWD9s8tcMDx+9FqPJb8
        V5NycAbk6HmUl1z3+z/AyNqeMU+311zwoYtTi4s=
X-Google-Smtp-Source: APBJJlFflbXVYJnnaINl6W4YHAywrJSCmKBN9jOSruqUIJFmxeDQ9FIdYHqotl8nB4n+IvqYUGTpzE9KuUhP157xeYk=
X-Received: by 2002:a25:74d6:0:b0:d0b:5a37:1a9e with SMTP id
 p205-20020a2574d6000000b00d0b5a371a9emr14316092ybc.34.1690997838098; Wed, 02
 Aug 2023 10:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kD_ESDSh-gVmUS18HtVmkY=bgxkR7Wo=OiwfMyyD8EFw@mail.gmail.com>
 <20230411091714.130525-1-varmavinaym@gmail.com>
In-Reply-To: <20230411091714.130525-1-varmavinaym@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 19:37:06 +0200
Message-ID: <CANiq72=UK_VK23yVWy1A4GyfSKduEn5qLD5EXPxEaX=bYjJNqw@mail.gmail.com>
Subject: Re: [PATCH v5] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Tue, Apr 11, 2023 at 11:19=E2=80=AFAM Vinay Varma <varmavinaym@gmail.com=
> wrote:
>
> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.
>
> The change involves adding an optional parameter `external_src` to the
> `generate_rust_analyzer.py` which expects the path to the out-of-tree
> module's source directory. When this parameter is passed, I have chosen
> not to add the non-core modules (samples and drivers) into the result
> since these are not expected to be used in third party modules. Related
> changes are also made to the Makefile and rust/Makefile allowing the
> `rust-analyzer` target to be used for out-of-tree modules as well.
>
> Link: https://github.com/Rust-for-Linux/linux/pull/914
> Link: https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2
>
> Signed-off-by: Vinay Varma <varmavinaym@gmail.com>

Applied to `rust-next`, thanks! I tested it and the generation of the
file seems to work on the sample out-of-tree module. We can do the
other improvements later on. I removed the newline above your SoB, by
the way.

Cheers,
Miguel
