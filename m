Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875375E493
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGWTmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWTmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:42:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EEAD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:42:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d07c535377fso1679883276.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690141328; x=1690746128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay3/eaFB0phovm13Qd1bOLsG3Es2DyLvGejXTaS4q4U=;
        b=HAxlucnKdeO4JPoSpkgIKQGB9tRnSd4Sqyg/N8IwICd7sWf3K7AZGX3wNsd+AikBKN
         AiGEXIGP5ukBjOcayTV5ty3t5fQsDANnEqi3NFM6pNzkYdWcxpsJZbVbv0hIn3AQjuNZ
         qg+nuONbgEPG6yZdQVAPMHdxfhr0STqkZxOhhZ6d/ccfPPDI2oRafVeGYlsfSquhptkx
         mM7q/lBj4ndCETwEh7iZKFD6jYQ8/Az9G1QIavKtoA7hZq05pr6V1wysSdylsJtwuUJl
         9TawfkH0oCVHqL3DtflQ+pIc+T/134U37iNvEsD5cUwJzQSNaywaJO/jumg1vjugbqxP
         IiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690141328; x=1690746128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay3/eaFB0phovm13Qd1bOLsG3Es2DyLvGejXTaS4q4U=;
        b=JfsSQOjEPVWBaBDEs8zKM1Etsao/IPe+0ZalyGCZ0o6DZW7ZZxyYr+yNwSDtO4gWh4
         Te/YjWCbptgaLZ2bP22FKEiY7ZwODE+GvrjRNu1mTXz6GReCnGrXnH/CoZeycNABXh0W
         0h6Z1KaBA/VPlj+AwUsKFxJROlgUK9wEasJSgtjNTjkaYjhBywW87ilbzCOyAfdfEo1o
         L137bLPy5X7Z5KJDAXmqo/GfjdUjdyKWpeIq6cJhHpJsnZu7AHArEM0kYT/MxdkW+e/5
         r5uDrKPrZwixx3jpUE5UvFuQuv6HA36902eAJ2UIUHTlE2YOtUmjyY1quMETgA3BH4T6
         r+pw==
X-Gm-Message-State: ABy/qLY6fbd66KMLPBKUdvYtSSBz8lIYBgMuAz2ghmc1l9w37T9oukkG
        3SGe8ykS0vGpryQ0nsSCpVW55m0SaQLTaXAcVh5y1g==
X-Google-Smtp-Source: APBJJlG+gbAx16cl9uw30afY0MrdCHU2zjimXfqSl6S7KhEce0zaN1261XuOaXx6BAuEWxLwP5bEWP9fHi9+vUGp9hs=
X-Received: by 2002:a25:1503:0:b0:c8d:1b31:62fb with SMTP id
 3-20020a251503000000b00c8d1b3162fbmr4928906ybv.26.1690141326525; Sun, 23 Jul
 2023 12:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201652.17168-1-mario.limonciello@amd.com>
In-Reply-To: <20230717201652.17168-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jul 2023 21:41:55 +0200
Message-ID: <CACRpkdYoxoZ0G7QzQ7XV2FPh9gUJG-CKfpFY1xNQdbBcJOQ=3w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Don't show `Invalid config param` errors
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:17=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> On some systems amd_pinconf_set() is called with parameters
> 0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
> which are not supported by pinctrl-amd.
>
> Don't show an err message when called with an invalid parameter,
> downgrade this to debug instead.
>
> Cc: stable@vger.kernel.org # 6.1
> Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all config=
 options")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied for nonurgent fixes.

Yours,
Linus Walleij
