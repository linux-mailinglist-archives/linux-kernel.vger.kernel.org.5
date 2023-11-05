Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DD7E16A6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKEU4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:56:39 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E4E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:56:36 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7b3d33663so45468307b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217796; x=1699822596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6QEyl2SUHinJLODwuehCU3YQb03M8xY6TOhu/4Xq68=;
        b=CDJJexQ7h/6F+C6pkgO0vRYt3HKgKk9/8ZbVT/xo0Lxp1uC40IP7On1djHawUiEJzO
         c9uDlO5ATBKKhUchIQAle270lZrKmyqg9+FG+yZxzj5ADbWeCfgzQ2rbgsn1qC1FxEi6
         B47k0NY7RZbuwrLvaFo/cytLtwvsfpHDW+r0CThA0DtErzveKf5fSGhZwA73pJ/JNqkI
         nWzYpP7eUW9QB1BWT7YjAUNQsWYQumPQzIIFegFBR35RXCccy4vKLgzFZsaVs2GBk5Fj
         vfAp5YnrdaRnHRn61Wg0qDzNihObHKmD9WUhrotRx+0Pz2i5dfWR6vB5L643rzu+18qL
         OeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217796; x=1699822596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6QEyl2SUHinJLODwuehCU3YQb03M8xY6TOhu/4Xq68=;
        b=RUKGm/zE9+W9Zni0u6wjSYGy3/Zf4qnT8EWhOXAayKoN2eitR/iD4PtsRwcJ9SVyJ4
         BFV0HlSL5vYeBo0kknytPJjqx+DaUoVQyeM+AUlGhChYeZnuOofeHGT2ytC9TzVPT2fD
         BZ4L6DtaA3IIo6iO4wUkQp7vK9v0kakzbzjMXt62yRvxyWFXpO8TSdsFf1tH2n56hBAN
         hBdGyhaYH+B0RSDYDz6EEUO2VLFyTB/7kX5IIFiSpz6W696uD0+F+ljrNIY3JjV7hGLl
         ZTVw7Zn3XLS32IS+vsFehnLedLMLyZeMt2JnvFyjIvP002VEVUSokBRYSazW0ERofEkQ
         V8wQ==
X-Gm-Message-State: AOJu0YzLrqFRkmDIj+l+96hferMUf32JCavck/Bqgi6V2kz/r+zhZP8K
        bBHjxBmenk4EC1Wv78rhQK/X1UeeGVYEwqQV+SUYhQ==
X-Google-Smtp-Source: AGHT+IGrBlLDBzl5QYMUEq8ZYbSLDgWpthp2RHHdVa+K8PvdjwCEDI/B3NFocFtHXGZ/fdZx5BrNzzTlf4Vzkt9zu6k=
X-Received: by 2002:a05:690c:a:b0:59e:9a44:9db9 with SMTP id
 bc10-20020a05690c000a00b0059e9a449db9mr8923885ywb.26.1699217795923; Sun, 05
 Nov 2023 12:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org> <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
In-Reply-To: <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Nov 2023 21:56:23 +0100
Message-ID: <CACRpkdYp1kiGY0K7kNF+qadPyq1hu3G=2oc1gXnCt3DjtiJxag@mail.gmail.com>
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 3:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > +              * Just bypass on bigger frames.
> > +              */
> > +             word1 |=3D TSS_BYPASS_BIT;
> > +     } else if (skb->ip_summed !=3D CHECKSUM_NONE) {
>
> I've never looked at how the network stack does checksums. But looking
> at this patch, it made me wounder, how do you tell the stack it needs
> to do a software checksum because the hardware cannot?

I read up on it: the documentation is in
Documentation/networking/checksum-offloads.rst
and in the header for skbuff, include/linux/skbuff.h

Actually we should check for =3D=3D CHECKSUM_PARTIAL which means
we need to do the checksum (!=3D CHECKSUM_NONE is not inclusive)
then I call a software fallback directly from the driver if I need to.

> Or for this
> driver, is it always calculating a checksum, which is then ignored?
> Maybe you can improve performance a little but disabling software
> checksum when it is not needed?

The ping was somehow working without proper checksum
before, but I think I'm doing the right thing now, also tested with
HTTP traffic, check out v2.

Thanks for pointing it out, the patch looks way better now.

Yours,
Linus Walleij
