Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1EB7DBBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJ3Ohl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJ3Ohj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:37:39 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273AC6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:37:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a8628e54d4so39788267b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698676655; x=1699281455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkvEup63X/NvswoWIpVSdrCM6wW/OjO9ZV/xamvkCgE=;
        b=g8wSQfDoEn/fesrGMgwclQNbdryinuQrbbwX/AbZbNj9UTwmk93D51Uq+X0ooNsPab
         jYx6tvZ4w40xClYZOCR6UG//pI6TBoitNmWPCO9mknHqp4Khf2KPgfUGAdHyEwSlPkvZ
         rdEbOMeX8jV6X5Bx94sWkjepXd+7QClXxw2DtTwfh2fIlvcwxOZw6Q4Wrc5sbz36CicH
         mbnVwFx2PYbW6Lp9hjuVfO6TjCLmK6Z8md5pAMOvX0LAwTXYEgVH7CQLezBwe0qvx/R5
         uG261wH65dHdNWd2oNY/REefUVpiBdaOnJyiI6ZgghyhHlUm35IWdUiAx9yZZycwj2L9
         gZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676655; x=1699281455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkvEup63X/NvswoWIpVSdrCM6wW/OjO9ZV/xamvkCgE=;
        b=Qnig4kMNHlqvm9Uaerp0NYbSbExiwcfR/3pNwjxu9f6/at/2cEbGIoSJjQt+0xJgJJ
         7XgCr108oaCAj1hA9FauMmB7TYdlvcqjsPwMxyQOMSNfGRVgylWXrSW3jO4XVkYCWVPO
         eWsEnK5dIhL141rOVuI1rK/FU1gRx/y1yJkHdQx6ACL0NCnp6oQCbW4nj6ErhRcVI55/
         RXHCaL7K7ZB8TkND43zwytb5WegQA2JVvPCjyJixhmFzlXwX/D861dwfllJEMChg+Xvi
         JKfGZlylseUgnY6t6xgezZ8xuZ6Z6s6ifMrRg3PXzrNfJ3CtErKhFek1m98ZBrx1pl+O
         kGaw==
X-Gm-Message-State: AOJu0Yx23mUOVk7pD2D9xQoZw0u8Ar7rQapLh9jGedjzSJWWWLMezc2X
        WrINv4IPwvwudbmXEtXollJtNk86FWwvP5CeV9ZH2Q==
X-Google-Smtp-Source: AGHT+IHuomUh+zOvo8VjkEA9snndKjGy3W9I5R/IyKh/37t55RKlwqVFLy5AWRwPxIud0EOVCaVooiwjhV4GJik9vGs=
X-Received: by 2002:a81:b108:0:b0:5a7:fbac:4ffe with SMTP id
 p8-20020a81b108000000b005a7fbac4ffemr15205506ywh.22.1698676655663; Mon, 30
 Oct 2023 07:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org> <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
In-Reply-To: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Oct 2023 15:37:24 +0100
Message-ID: <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 3:16=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Could you please try to revert the effect of commit 339133f6c318 ("net:
> dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
> the egress tag again? Who knows, maybe it is the bit which tells the
> switch to bypass the forwarding process.

I have already tried that, it was one of the first things I tried,
just looking over the git log and looking for usual suspects.

Sadly it has no effect whatsoever, the problem persists :(

> Or maybe there is a bit in a
> different position which does this. You could try to fill in all bits in
> unknown positions, check that there are no regressions with packet sizes
> < 1496, and then see if that made any changes to packet sizes >=3D 1496.
> If it did, try to see which bit made the difference.

Hehe now we're talking :D

I did something similar before, I think just switching a different bit
every 10 packets or so and running a persistent ping until it succeeds
or not.

I'll see what I can come up with.

Yours,
Linus Walleij
