Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C47AC5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 02:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIXAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 20:15:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C81F139
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:15:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f4bc88f9fso22481827b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695514540; x=1696119340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqouo1KR3QIB4VuW2gBPYmlnqE6R3OEfgs5LOzPDfWs=;
        b=L7qd4ejuReJaZZEdzE3d7Dv4HtkkRsgRx7kPOIlZqQ4zCRQR7imIbkwV7jQ9imTzbW
         TuoMVGurcDmL3M6kYdJIZUWpTwnMoY/CzSWhsWJMzlD7nbaS7g8l2To6sO7XnSPbLIFN
         zFJVn5apKpen8Ei3aP6avqbebNJBK+cG7VmE6hgLooCc2mzEjBMHojqc7YXNtmfM2JF5
         66EeSKPvuS6iHtKt3l+cnLSuajFzljNhuaz2ne2VC7DRAYjQ6qhB1t0yvdMdBIdK0syc
         KjGwNERBCEZLR8v3Yc4gz/VoFp5frPcNFjE5YToa74jLX4dNvtJz5xpIhBjeSRXZlD/B
         CBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695514540; x=1696119340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqouo1KR3QIB4VuW2gBPYmlnqE6R3OEfgs5LOzPDfWs=;
        b=dgNBuJeFS59u9c4xC0W6K3OKX/RtnmUsGOMZXNua359eXOzwY/zPup4JCsA6e3E3IA
         jUstLuEEfzYnURyKRF/sY6O/bAJyEC4LeVd5spb+sJYDrUgxLtzvxV3GX57oItkhBCLk
         mKJo38gJQZ16e37qefce1EsFofH88bTAZf3jrGSDRbwbJhgSgxVJbL67etMiYzWBtWVg
         +HYhCA+S8LTIxAMSfbDWJ08z8bJL1Dr92Cl7gK0eTniUcG5aajHlc6mDYhwHb+iqTGTS
         zgXQPti730tbduyAOsktMAC0Gv2Nxr6i4SEUIrytUYaGmTyNv82cDjw6MRig+dhurfGm
         zzMg==
X-Gm-Message-State: AOJu0Yz5jBuNVSBx+gj4e6+TX95WOvkN3fcZDezwLLh6wo2KBlqoJx7i
        PHE4YdxPRcmprbTgxaY7E88n2VzlpPUq8RX756Jg5Q==
X-Google-Smtp-Source: AGHT+IE0yIl91sQxa6F04fOPUUt9KIrlU3jmLMSMa5t82nSQSRS4kczVVRajmxsJYtg/58/7D49oidaAiDfHyQJwICU=
X-Received: by 2002:a81:5b05:0:b0:599:b570:2db7 with SMTP id
 p5-20020a815b05000000b00599b5702db7mr2470522ywb.30.1695514540275; Sat, 23 Sep
 2023 17:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175203.work.760-kees@kernel.org>
In-Reply-To: <20230922175203.work.760-kees@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Sep 2023 02:15:29 +0200
Message-ID: <CACRpkdbHOa=59DnQzZRV0BrDx0yxm97JjaR0GaeG3jywW0bRBg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Annotate struct linereq with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 7:52=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:

> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct linereq.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

That's neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
