Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D29754397
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjGNULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:11:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E530DC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:11:36 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565a8d9d832so1548877eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689365495; x=1691957495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7W8NCwpSyklTkb4rETzDttOa2ACeTzVgjQgXJUjD0Q=;
        b=v57yn+FXE2Ah3+xQYLvAp0FTCYt6xcStEOs9r6zqBFMCs7MjujiO2MnP7P+oXa954z
         ByVU1A0ByxNhBElwQAd1JWNVKmIzI2U/h1MZSrQ7Z5kJyovB78rdAbHNMFrgh7uhp5Mu
         WUqBJiF3d6y5nZQOIarkvzEs+LbHs2UCvavCtmoOxmqbdZJeQdstRJyOtfQ4ZEHjyytb
         Rosqnp9vb17UhJoIP0HMpS9MVXM/HajFQ2jHAmh/TZ6+rgGRHCVU+y9/k6aHhpbAblOp
         5QvjzR2+rhlUpJ21pdkjjlscdbc8LIZB07J6z70IpyrZpZan2vGX/3/1O21AenZxFZpB
         f4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689365495; x=1691957495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7W8NCwpSyklTkb4rETzDttOa2ACeTzVgjQgXJUjD0Q=;
        b=b813Yqh+TYOhsRk4KaK8n+UnpRI+RiMnjM/8RAEDoj/ak6sOY2nW8LF46YSig85xki
         AQLxPBQHM2TErV0DMV9QhpoJl6IcI3yqjuTZwjmFHEPxTmPqJuYblN+KW48AjC2gid8H
         vrlefekGgrrDtm9c2J4KtpxuA1vXgFOxr4ZzMIht14BaYNIx6WpSdHu2l2BjopskNkGV
         Xxyqu0wR4Dns8Ln9gBPDSzJqAx1nX9nw9ka6PaH8zdywvLuOdBalq2gp+jDJtBo3oeqz
         LyPlDyk4O+m1NZ7QQkyLOGAQRBtJS/VLn1jPgGnMgCcHJhzabbmwL4mFtATKNYdNWxpj
         mLVg==
X-Gm-Message-State: ABy/qLYwvNSfuXARgQb/Kdoog3Dt8eJwGTwXc9/ipwMz/B+sy5iwSE93
        ZRc4VLYeam29GBN550tUe7t5+agybXNKR30uQRulGMMNzviXEWdM
X-Google-Smtp-Source: APBJJlGzqcXNYOaf26GWRDbgRF0BlYkN7nDSQ7PtfSGo4JNIEjflJS1TU/2UaziT3AZYvDKoN9YkFclH2J7R+a4MMpA=
X-Received: by 2002:a05:6358:7f0e:b0:132:fcf6:f311 with SMTP id
 p14-20020a0563587f0e00b00132fcf6f311mr6602950rwn.0.1689365493838; Fri, 14 Jul
 2023 13:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230714-spi-nor-winbond-w25q128-v3-1-bdb2192f079b@linaro.org> <a5dd9f7d14c94c9be99c93b9475683bf@walle.cc>
In-Reply-To: <a5dd9f7d14c94c9be99c93b9475683bf@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Jul 2023 22:11:21 +0200
Message-ID: <CACRpkdYWEtHsTRwCYNt7sNtMfs39wKgP8CeuW4cp6VZ+F_y6dQ@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: spi-nor: Correct flags for Winbond w25q128
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 9:30=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
> Am 2023-07-14 20:29, schrieb Linus Walleij:

> > The Winbond "w25q128" (actual vendor name W25Q128JV) has
> > exactly the same flags as the sibling device "w25q128jv".
> > The devices both require unlocking to enable write access.
> >
> > The actual product naming between devices vs the Linux
> > strings in winbond.c:
> >
> > 0xef4018: "w25q128"   W25Q128JV-IM/JM
> > 0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ
>
> This is still wrong btw. According to:
> https://www.winbond.com/resource-files/W25Q128JV%20RevI%2008232021%20Plus=
.pdf
>
> This should be
> 0xef4018: "w25q128"   W25Q128JV-IN/IQ/JQ
> 0xef7018: "w25q128jv" W25Q128JV-IM/JM
>
> Otherwise, looks good. Either Tudor can change that in
> place while picking up the patch or you could send a new
> version.

Ooops you're right, I'll just pick up your tag and re-send,
sorry!

Yours,
Linus Walleij
