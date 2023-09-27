Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F47AFF39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjI0JAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjI0JAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:00:06 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC06CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:00:04 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59c26aa19b7so131349547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695805204; x=1696410004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TutIAe4KzHZUJ9ATW3VpQ4iw5gN1jLgS94r63g8BT3A=;
        b=G/C9h8ACQ4gisppe+8QdxxZVETy2BjOPzbl93h6IFvwnlaZOF7aLwhGnVgF/vCzmpp
         /sYd/c15H27j9S7/5J3Ee30LhgNKyrO2fPMvDYrBIPH8LntDvp4ae0qj90nuHF1XxCgX
         NoFZ4LoAbmV2LONc/J/sgI+VqiyPfK02DixUCkfGsvcHyVBilXKOiEYCqL3dlQ6Vga1d
         WqGrPFH5yzlZRLJP8VqnoDytB4PCEV07zBJV11+7UFh9qA/EkQ7EKkZ6z4DNzMffDEvH
         6ULUeOFnTcwXME2V1C3k7g01hbn/FgeHm0zi98u1Gv0KktMGGygV6jKeGNF6OO8PSmLf
         8Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805204; x=1696410004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TutIAe4KzHZUJ9ATW3VpQ4iw5gN1jLgS94r63g8BT3A=;
        b=XGvg0v3DHZJ/RuYHm8mVYtLotr858U0t2N24lmF1qZUZ1G2oL1xJvhC6ZI8bhsjAuq
         3mJWayVTKHjYZyK8uvLe/+sOmxOyM5GiP7ubFBtD7bL7Sqi9FiJRQeY5C604vgO8QqZA
         a82Hq0aoTnK2jlcYa3NfiIzqvigrLjWrK81bEyyclVtxxs7lxg24YiOAHJgUh8Nz9KO3
         HJBgr7w9ny4fiIx74Hzc48FUV2OfhnncatXZ4Uo1AZ99SU5qsKQOjY4zASUeX2+GcYBV
         kiH06E2GY95sYuqLgNlYp0UQPI7Ld9BajCsGWfH21ooLPDDBqm0LluljUAG/d6z7yS6H
         MjXQ==
X-Gm-Message-State: AOJu0YzGdT1rcCQ2nIm56YhSrTJVjrq4AdhcX76t6qlYqy7uJZgy8kta
        EKwK15bGRF2pCv4kJVHihDtnhl2mPgkf9/FaJifv2Q==
X-Google-Smtp-Source: AGHT+IEnVNlxtU365OSVa+Vju3oylJH3jIZadB6OzZFRZDu29MnEdrWa5VJAMDN8qQBkpr8ELeV9VjCIo0BH0fj47CQ=
X-Received: by 2002:a0d:df45:0:b0:59f:7dcf:edee with SMTP id
 i66-20020a0ddf45000000b0059f7dcfedeemr1832413ywe.9.1695805203882; Wed, 27 Sep
 2023 02:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175006.work.421-kees@kernel.org>
In-Reply-To: <20230922175006.work.421-kees@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Sep 2023 10:59:52 +0200
Message-ID: <CACRpkdaVauiB0M3PNjGgcAj2Cw1gZ=NenkOuh=PKT=8uEYc5rA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: Annotate struct uniphier_pinctrl_reg_region
 with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Fri, Sep 22, 2023 at 7:50=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:

> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct uniphier_pinctrl=
_reg_region.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Excellent!
Patch applied.

Yours,
Linus Walleij
