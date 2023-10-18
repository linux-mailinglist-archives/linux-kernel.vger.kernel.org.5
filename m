Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001DB7CD710
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjJRIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjJRIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:53:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5A103
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:53:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a8628e54d4so30647827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619193; x=1698223993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIfc9x+57+MR4MQsFxr/3D1qUh4GWaKbi6uC5iQj2KM=;
        b=A/Pk8h49ehZ29O0w0iKml7ynBA8zowwZ5tmiz45VAgsXWt7kmtGmzeQLBfhkHzocYl
         Krfv2TOEq2SVD/VItz5ABk6HxJbMYAFmI5NgVtu8e2f9RgaU5s7jlgzu9SMwYQOLxWAS
         qZxzejJDGQAomxCUjC+c/WlbPPjnrnBX9GwoRbM0oRAzJYgoKmhIJ/edzmtE4aYiUWgl
         FAp+pMvng8pSd6SIYe2AueMxTEYhSOyi3nXpbYUix38ROoX4JexPwxOnk1JP7IFWHIgT
         BTeuw3dZ3A3PBzYvmuDC/Z0RgtQOnTttCGN9mrOb+G7+VBRzuMmpanNXn+LX/K05Tsbc
         2hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619193; x=1698223993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIfc9x+57+MR4MQsFxr/3D1qUh4GWaKbi6uC5iQj2KM=;
        b=eq1+sdxDSQqNweIJCLAa52CGkwfGmNiJ8PDNDoYp/2yyTLeeFb0ktnlIJVN7KmWFTn
         Fag6CQ54CSd/RF7E9I4TrQ1tu9/TINdXFqinoW8sRH+XUCGRV7fw4RRpvd7OTex6p255
         C3g29QiGsavF6GBssGFpOsuqfguA7pkaBOohNWjaaw9mev+M9KbhuGWPtT0E/yWFYfUg
         mSolDvWsrF2fMxVK3hHxug0E1Bi/+H83YZ0LFzZhFdfWX9iSqpMDp8qpg9CAE5rjV29w
         ZZlFZ/gAX2s6U0APPCxDjJO294FrCx6OlCJNyB4ESy8D/a2wo1fXSHEIkjIjP6TdBqve
         DZ2w==
X-Gm-Message-State: AOJu0Yw8U9itgoKANEy8l/l9wSvCUJmUOMmScG6SJndHDszl8WX4X9HK
        LiQg9/M02ld268fCxOGCQWXw8BGNAnOk8d2x5qxkjQ==
X-Google-Smtp-Source: AGHT+IFeFSERqZ0ts/x8xJld6sINEyqZb9YdNFdgX/IXWU45eqvj1p1KrrBezJyPl0/qLY0DPRMIhme6p1Fr7jMtf+o=
X-Received: by 2002:a05:690c:ed1:b0:5a7:cb5f:ee0a with SMTP id
 cs17-20020a05690c0ed100b005a7cb5fee0amr4033573ywb.17.1697619193088; Wed, 18
 Oct 2023 01:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
In-Reply-To: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 10:53:01 +0200
Message-ID: <CACRpkdaie8-0W+=9AD49KqyW+-Zrtkhs8BjHJCVDrkxF6hVAkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] dt-bindings: net: Child node schema cleanups
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:44=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> This is a series of clean-ups related to ensuring that child node
> schemas are constrained to not allow undefined properties. Typically,
> that means just adding additionalProperties or unevaluatedProperties as
> appropriate. The DSA/switch schemas turned out to be a bit more
> involved, so there's some more fixes and a bit of restructuring in them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Oh this drives a truck through my Marvell binding work. Luckily it
also solves my most annoying problems so I will just rebase on this
and continue, all good!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
