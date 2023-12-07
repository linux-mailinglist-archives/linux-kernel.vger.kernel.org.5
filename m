Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A938082ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378250AbjLGIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378232AbjLGIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:24:41 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9AD5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:24:45 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-464889ff296so103950137.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701937484; x=1702542284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMcgPtxedE6RMJpz2dDYWTEHuZvSSox1/TA44eUbS6E=;
        b=xvgTdpFLITonXaZaCGxoBpNPhwkqXM87THzNhuKUbLEy1FtqbzNB4+CsS0r4Zisac/
         ViQh2c9GC5PXde9iel/fV9e49wpkFUm0yBXuNQWYcL44xPWcTk2biOxQPrxBPfGc0uV6
         m5lsdVsw2qZmYluxbEGikI+B4h1GX4zohGRB8eVC13PUIAbNLyoJBenjesbpL3XFzyAx
         4lM2bgpdsx7kRWBBF+2IKldgcoqLuF7eVg7ZBFB/TUROjBI5yxR9PW3fIOjGgClbqY6s
         onw5W7+nk/xU3hFaVxmfiC26bNFYoSAp75TH0ogupgkf/qdKoFd4LUWjq1QGB+PYc/oo
         TjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937484; x=1702542284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMcgPtxedE6RMJpz2dDYWTEHuZvSSox1/TA44eUbS6E=;
        b=G8wPwVDlYnbyWftir/xsUpj50TYxh1aUEeM3JaljANBqbuJl6U7kk2/Bnk7tqBm+xJ
         wIjj0ds1eqnYDgn2Isf/RmrZSLC+JA+FkLW/h1RmPsaquzOTQwm4XOjgh5qKewgU0yP2
         ihbVrJceIs/BVYglNrrDtrDQvhZLb8L3dLWqGKi87F3/9cnA1O2bNGOapk2AWdcMcz6n
         7IuhoeJszSh08hr/1XCzABfH8BaPW5lIfSWWxkcYRi42LonVnZU8FT+o5Guwqx1zedTj
         2I7CCkLfFFXt7MgJKb+scLDgdmXcnFkTi+XW6rgNqS/HJYWJcZ0M2eUB0ZU8xJ0aiYLf
         Lsbw==
X-Gm-Message-State: AOJu0YzPdftvXJ/eAUqVlFLg4gFHWtdv3GydKdA6m755ibqENuo42tyA
        phynBtBR7qvwF5JNDwShaSFSoQh/fGGI3nz19M95U/MMHkfshP+I
X-Google-Smtp-Source: AGHT+IEZflt6LGcPeoXvYp4U050gUi6Al3p5Q8rF1gVNp9yJ4fO2/kBMQx2FxV0uSx5HLUQFyjVCnvYa+MWpjW0vb58=
X-Received: by 2002:a67:f708:0:b0:464:8c0f:2ab7 with SMTP id
 m8-20020a67f708000000b004648c0f2ab7mr1364976vso.14.1701937484627; Thu, 07 Dec
 2023 00:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20231206030523.302-1-rdunlap@infradead.org>
In-Reply-To: <20231206030523.302-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Dec 2023 09:24:33 +0100
Message-ID: <CAMRc=MenMowQVw70XXpKW3F99Pu4T77FghvsUEPZxDGz6jMh1g@mail.gmail.com>
Subject: Re: [PATCH] gpio: max730x: don't use kernel-doc marker for regular comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:05=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Use a common C comment (/*) instead of kernel-doc notation to prevent
> warnings from scripts/kernel-doc.
>
> gpio-max730x.c:3: warning: This comment starts with '/**', but isn't a ke=
rnel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> gpio-max730x.c:3: warning: missing initial short description on line:
>  * Copyright (C) 2006 Juergen Beisert, Pengutronix
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/gpio/gpio-max730x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
> --- a/drivers/gpio/gpio-max730x.c
> +++ b/drivers/gpio/gpio-max730x.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2006 Juergen Beisert, Pengutronix
>   * Copyright (C) 2008 Guennadi Liakhovetski, Pengutronix
>   * Copyright (C) 2009 Wolfram Sang, Pengutronix

Applied, thanks!

Bart
