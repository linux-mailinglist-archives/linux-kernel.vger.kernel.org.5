Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C12751FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjGML2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjGML2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:28:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6918E;
        Thu, 13 Jul 2023 04:28:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso713938a12.1;
        Thu, 13 Jul 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689247686; x=1691839686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqGooZ9sePUQXEjYto5Vlnx9X4OCC5Lb+CkMJuu3W4w=;
        b=Ib9fT9L1CHJhvYQOkATILlBpEjunv7kugRxcfoh2bAxHcAB1XxT3XfxFI7kYxJ97oR
         lzD3o160L99zYAHqirdY4deywfV73bqS+SQBbI+J56wPTFd3X1ctecEsbgJcD/lt9+Zk
         Uo7jv7uBgOuBGnPAaeQ4+8FwNdLT4m5UwybYAHKiPuh1W4uoeQeIHaj/yY2BeY0niXA2
         wobmb+jL6YRSnjkoQZYXMPbQD4dEh0KqN+1vRtTmNCsGxSSZ74E2hpNgTu+46nIsUg1m
         KOmEUjDLRe/0LpdwvKvTXEcCE90ZQyYkNRT+DDIlbcjurYXhI5cuj5MRjjUgo1TEtVUm
         EJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247686; x=1691839686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqGooZ9sePUQXEjYto5Vlnx9X4OCC5Lb+CkMJuu3W4w=;
        b=jgmb1zL/K33ACQhx415Rbqx7mxT4iAtqWuMFe/s69pIvhYIIY67EiUb6dVW3eqvYkj
         YqPI/3NkASVUzbK1O6z/a1t12KzihC85K3jptgkiL5NeNT6oPiAhNzboHKaplojYECkB
         Loo91V/IYlYew7PSj+F5uKHDnFAg4JtZnxvoNbmJIaygyMzufmRrGIAr57gHBVVPpaC1
         gt2sEHCVkNjuFAc6VZ0tfyRDLk88ze0RWCAgLmDSWDHQU1RlWo9srPAPi6B5pV11JHVf
         Y2FaUAQKKaGR0yOLjOa8qWCKskyPVr2L/9+RSTDnj9AGiaCQe8cxWl/8bWgUiPJRybRa
         8y9g==
X-Gm-Message-State: ABy/qLa3FLl9vSTZpCUWsivhSw82/l7BRli5nDsCHNA5q7RaYoCkOBwX
        Rzb0CkXnskq4/Foh0RnQJiLd99HJ7NSG72lmc/M=
X-Google-Smtp-Source: APBJJlEPnNOZlGzLpNRTo6ErSuKGOdnoT9/D+9tpLpZIg3Bd8YbgZ6mMMEmppQtq0Y8UUje7ePrQ0KNtnfQ6thOFquc=
X-Received: by 2002:aa7:d507:0:b0:51e:1a5d:bc8c with SMTP id
 y7-20020aa7d507000000b0051e1a5dbc8cmr1393680edq.42.1689247685814; Thu, 13 Jul
 2023 04:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230712194625.never.252-kees@kernel.org>
In-Reply-To: <20230712194625.never.252-kees@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jul 2023 14:27:29 +0300
Message-ID: <CAHp75VcUL+pchLdDk6VJgUrQYemD6pu-Pp3+nyrAr8yt6L+kuA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Foolishly claim maintainership of string routines
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Jul 12, 2023 at 10:46=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> Since the string API is tightly coupled with FORTIFY_SOURCE, I am
> offering myself up as maintainer for it. Thankfully Andy is already a
> reviewer and can keep me on the straight and narrow.

Makes sense to me!
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..b639d6123856 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8672,8 +8672,11 @@ S:       Maintained
>  F:     drivers/input/touchscreen/resistive-adc-touch.c
>
>  GENERIC STRING LIBRARY
> +M:     Kees Cook <keescook@chromium.org>
>  R:     Andy Shevchenko <andy@kernel.org>
> -S:     Maintained
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git =
for-next/hardening
>  F:     include/linux/string.h
>  F:     include/linux/string_choices.h
>  F:     include/linux/string_helpers.h
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
