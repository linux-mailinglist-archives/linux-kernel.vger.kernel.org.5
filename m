Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273CD754DB6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:44:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BB1B6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:44:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3efee1d44so2605393b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689493491; x=1692085491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNeu1aSAOWV9cTwJrwJjCyAEzfhewjn9LWWDsQVPJOU=;
        b=f55wqcBnzsPuGvFgcV7S30fVIAjLFD/6CaDXVCtflYWZVQm77o+Up7PGHxzrl197iy
         ZRVTxmeTxgNABWuMlXEQdQVWD4/muPwdm6exxs/89PEYBFVKQ/73r1yTlJ00CkhYxBOJ
         CkeqaETuKd4F+RV90TvaBrkhZVG9k7lwLvJE+sQAmmOj2tIg8qMY2x+Pn6Xf2OntqpDX
         oxtfiI7G4ctzazFA//opIdql9xkx2tQBg4P3JcmoPeBnvBWWWQh5r7wiHZT4ZSJfo/7x
         6cq4FkNgzV+/lFqUpGjdhDlZ7kYesgT121zhrICYHYIfe8sUYUijXjXEtloEKKHyVcfr
         hemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493491; x=1692085491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNeu1aSAOWV9cTwJrwJjCyAEzfhewjn9LWWDsQVPJOU=;
        b=CJWdx1V/0Fr7j80YL856VLNPFXUkLITBkx5AvWH15cq0zGFeIJfpSv46gz+mU24Qi9
         m1Ieyckho5fXChxlU6qCRQHhpQ1t/NQw1f9dPtY9wuQ4HjNcGqhV3M9tQEZ2vM/LzzqO
         Js5NFz8LK1dZcIThuV3n8gjDsi5hbrrxirk6t3Uwp+Sxj0pSasgI6gBV4daEa29aU/e5
         wKp+/OaqqEVprDdoNsH3OBn6q9FjuY3ZFOBOmWues42yDWwxmwSQB7OF9N9RvqETETwS
         8dgnnyYBx9o4GbzIuV8/6h80A4TL8WyOpUdn8ML5XYIOXVzpGj2sY1NS8RKcOB0BoOfD
         vW5A==
X-Gm-Message-State: ABy/qLZKSxJ65gbAUF3QJnP8ViNQMH0ZI4Yo03hkB9ai4lkBD2mtKGzH
        yIhC7CsasqjxfKk3Gzi01moUMW1J4T2Gxh19gALNbcXwfUX2cinX
X-Google-Smtp-Source: APBJJlHg9TIjNJoR0KJ1xSImJXVM8YS2ylVnZjdANs6P1wCtC6glnOhx36IHH7gWvcOmUl6KxLWNBnIBd6IXOI5eKRk=
X-Received: by 2002:a05:6358:339a:b0:132:962d:b5c5 with SMTP id
 i26-20020a056358339a00b00132962db5c5mr8008716rwd.30.1689493490839; Sun, 16
 Jul 2023 00:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230622074520.3058027-1-linus.walleij@linaro.org>
In-Reply-To: <20230622074520.3058027-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 09:44:39 +0200
Message-ID: <CACRpkdYOMtAyCCvv-t0tF6ztNnCdw6gGLOZskmD3QX4_3jyURA@mail.gmail.com>
Subject: Re: [PATCH] misc/genalloc: Name subpools by of_node_full_name()
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, could you apply this patch for fixes?

Thanks!

On Thu, Jun 22, 2023 at 9:45=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> A previous commit tried to come up with more generic subpool
> names, but this isn't quite working: the node name was used
> elsewhere to match pools to consumers which regressed the
> nVidia Tegra 2/3 video decoder.
>
> Revert back to an earlier approach using of_node_full_name()
> instead of just the name to make sure the pool name is more
> unique, and change both sites using this in the kernel.
>
> It is not perfect since two SRAM nodes could have the same
> subpool name but it makes the situation better than before.
>
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: 21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
