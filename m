Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2D75E3E9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGWQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:45:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299D191
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 09:45:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d066d72eb12so2384216276.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690130732; x=1690735532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z4Q/5i212yOfDJHSZ237NJV5w/BOsCv0oJZlIG69OI=;
        b=FNsDYxJQhN4UYlo+NaIAuZ4TSaC1B2tgqtuVqVH3IoE2onNMulPmKxMTcCXNWLO6mV
         O5jSPzamZfi45jV+9vI2ygWXyo1O4wOko8kVYYuXY7HeXuvoscW1iCrKxS6wrT7iTGsv
         J+UxYDIM6aPcGKvps3u0qCPY7+BBssLn5Wk6wMk7M9mrXZyM/7GEhpitJHi4oD0G2TqI
         aeGfLDQ66q11u+wvgjruyRbpAt84zp7O+HhNwRjpAI0gN7mkQzNbzyOezHHQhr1w8dD1
         QuU98M1BjjfDwT2Oqig+C1MbetYUISgzbh4r4KvQ7xLni5Kw35f5QfPIqCP/DTxhDmSP
         GCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690130732; x=1690735532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z4Q/5i212yOfDJHSZ237NJV5w/BOsCv0oJZlIG69OI=;
        b=Ie0JNZoLAVLJ4J9ssE36r6Z2cL0s4noRIE641IipGjST73Jhhk6zZmut6/oJFhCWCj
         IVHQTxwOtDjGI8uIqU7haLFPZU73lGreU5+gpemyrwy+aUGE86yaQjaDHjf712G2J1d/
         liTaVrbXya0g5N8ggxTvmt3qwIsGayN36Y2DN2U1mIquOYZNWjdgiq9a78aH1NAoA1vZ
         lka17r/fUJ9QEPs51eKtkvdDhuo5hHTIIZs2f1QpwwQSzzUxWpnoxYUtP4KDsBX/dcWm
         1BD+vld5YWXyq+vSGajg6M1un0uqlKEzkRiEa+OfrrI1iDBMUTLidW/sDp0Kh439Esnh
         ZTDw==
X-Gm-Message-State: ABy/qLZTloc74tT69EJUqMRY7fSOSIPAHjQivoBhjWDre0WQaJKLRCD4
        lwTrr/xfhO8hnIrBVQxcHyQU69VbGjIkZLb2kaXa2w==
X-Google-Smtp-Source: APBJJlHvhLN9VFNppA3TR3b1CrYYc4K0cwFupMPvPmsFSAY7uxPuqkSik5JiuIYuW7MEFv3Fwa4OHPTSm6EZd+QBRhs=
X-Received: by 2002:a25:2642:0:b0:d09:b2b1:9771 with SMTP id
 m63-20020a252642000000b00d09b2b19771mr2708738ybm.14.1690130732609; Sun, 23
 Jul 2023 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230719152007.197710-1-arnaud.ferraris@collabora.com> <20230719152007.197710-3-arnaud.ferraris@collabora.com>
In-Reply-To: <20230719152007.197710-3-arnaud.ferraris@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jul 2023 18:45:21 +0200
Message-ID: <CACRpkdZ2Fu8jyyyDd4e1yq8g4bDoj2gCd4KnntST8uYvDNKUZw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2 RESEND] drm: panel: Add novatek nt35596s panel driver
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
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

Hi Arnaud & Molly,

overall the driver looks very good!

On Wed, Jul 19, 2023 at 5:20=E2=80=AFPM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:

> From: Molly Sophia <mollysophia379@gmail.com>
>
> Novatek NT35596s is a generic DSI IC that drives command and video mode
> panels. Add the driver for it. Currently add support for the LCD panel
> from JDI connected with this IC, as found on Xiaomi Mi Mix2s phones.
>
> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
(...)

>  .../gpu/drm/panel/panel-novatek-nt36672a.c    | 251 ++++++++++++++++--

So are you sure the nt35596s panel driver is so similar to nt36672a that
they should share the same driver?

With all the magic number sequences I'm not so sure, do they really share
any of the magic numbers?

If not, consider creating a new driver, and then base it on the
nt35510 instead.

> +static const struct nt36672a_panel_cmd jdi_nt35596s_video_on_cmds[] =3D =
{
> +       { .data =3D { 0xff, 0x24 } },
> +       { .data =3D { 0x9d, 0x34 } },
(...)

These are never nice. Do you have a datasheet so you can provide
defines for the magic hex values?

The construction with these .data seqence array
should be replaces with some open coded sequences
I feel, bit this pattern is already in the driver so I guess it's OK.

Yours,
Linus Walleij
