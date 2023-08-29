Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38F78BF11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjH2HTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjH2HSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:18:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5B1A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:18:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso94346276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293530; x=1693898330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/le9lg8HNXw+xNcfMZ2DkxbxE28NZz/pHklIKly6GE=;
        b=hn2jJWDupwjUSCe5USg8z0TOEuTKNjSNKVVInIU12YCkp2e0zxjVnQz59MEN4u+ukn
         V18Z8z0bHbD4rPRBwjbH26NuP+P74oKJ/7J4iHMCh/sMGkXw0VryhNbeCdJrrY7hkNrN
         0VtHqfc+JElXXuVxhwn8yEVYaxXRwfzRm4UhM+2HORD7t6WYhPed66n1RiCM447NJRSc
         X4bxXID9uR0JGutjZKcPLHKcjZq3TqlP5dOHkkEnO8lmHxQ764OMHZVdnIb0SfnIiIzJ
         bHsb3YVLtS+R8wFHif8mhMt9oOGaI2hMakjuWbiC/CCOqVcSl2e8IeShyM0++XyhAql+
         l/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293530; x=1693898330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/le9lg8HNXw+xNcfMZ2DkxbxE28NZz/pHklIKly6GE=;
        b=LaqsL7r5TJOpQjCHt/Qm80v7JPdbpvqsFy5iQnwyJM8HXMj4VzQO93lPZ6MzSuRXvt
         yThAfN6zgJ9mc2XZ8gMzdqqQr9edOXBamnDmU5KQnw7du0BzUYODZhd29rzJS/siaVH3
         6Oq/1PyN2YflXRTNJEgTcyem8pHpE1bCSTVh+v993RBb/RfYqgajsXUYRtNt4MYBIs59
         QvpWB+E+sO4vv72zgiH7bOCeIr7FAaoD9+IXJOIMyG48V45EsCvzMQfZeG6Wugk7VM+O
         5iCledNPF9zTmCwv0rc9kus5CMY2gx3w8aQJ9YpqA8dKlOCcvbBW7c49iYYx/5wq5W0a
         Rkrw==
X-Gm-Message-State: AOJu0YzzshNOI0n20z7LytnivAOI2f/RE5YJ0TJRhgB1l4IGKUhz4Njv
        u2viMz7JbblXcp1LFHxbcH2jEhEIL40j2SuGwDrzaw==
X-Google-Smtp-Source: AGHT+IHh9savmxG2TT0gLsT3nt4v87OMyIMGiKB6sqLe0uJYi1H9dQl6Yr1wfWx4InznhxXRV59j+8WblbAF5kYo6Zw=
X-Received: by 2002:a25:ccc3:0:b0:d77:f99e:7b1e with SMTP id
 l186-20020a25ccc3000000b00d77f99e7b1emr15286296ybf.48.1693293530259; Tue, 29
 Aug 2023 00:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Aug 2023 09:18:39 +0200
Message-ID: <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
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

On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) while
> checking if the device is compatible with atmel,hsmci. Instead handle it =
in
> the if() condition. The compiler optimizes out the entire if() clause if
> the first expression in the if() clause is constant false.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for tidying this up Balamanikandan!

Yours,
Linus Walleij
