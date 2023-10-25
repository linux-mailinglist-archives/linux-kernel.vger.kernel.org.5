Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5957D74D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjJYTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:52:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D6191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:52:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso86320276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698263556; x=1698868356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCOn6hM0y8PtKiskD2IDlVlFr7NLthwOD+ghRCdumas=;
        b=qjys1irg3Z3bUzAM6JIyRM7A8FnX2d8eObK8MxT08mwPQ0wdrX38yMAEh8NsbwpnPH
         mTIY59BmalGXg91e5WrVgZ7NWbPPxl1cnG12blDs+Toerx9OmxGM3WgwglKcDxaznAK6
         fyIvSv/WkcXhIMJkRaIEcjE53ZpbdsNUZkE3Ug9YTYHAcbKCOGyAiquN1CMK3du++Hg2
         U17oDbwT6Mbvq3K31h8ZyO7TuvVWR1davU4pn9TaMm5HNUn909R574mzbFuM3+j1N7bG
         6uCnjUajMs6ClouDx3FgewMia0+TUpwqcKzGhZ1nt+bZ0NGirKyRC/eIEhTVl3CsUDvM
         vHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263556; x=1698868356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCOn6hM0y8PtKiskD2IDlVlFr7NLthwOD+ghRCdumas=;
        b=uxB2GO/OyQosGOj1hlFAAcBLpt/8d9pjDOAyLjhFA+IVnLxjG/0QYDW6/VOaXfwpI4
         j9AyX816E2h8CCaRz8UFALG4AaZ4eDNn2XqcL7kC/h0ZuO/8PTEHvncrEzev0TuanYkD
         GhV4/GzIfIoba8gF7deWr98rdaQ/jSOtR9GiCzg87QPfDLzPGIedSk1OjsnaJRQ225br
         glxoyWna4ydGLoHu51hkwqN8tNLrm7ENRWzfdBHyNZiQNyT49Z5R8wYTV5mLxkejBH15
         kBN18zdRZbzV0ojDTBrnQZUmd7ooK0pstT7mpaxF6jcqh6peA8gH6by1VL21JVjuPZ3e
         84MQ==
X-Gm-Message-State: AOJu0Ywj6LpYOW8GMUqoxt9wkUVuNVMoDcbj0/YAlgaw/vXJYdI4HaLn
        16GoWXcDBJs2hs9b8ctt+J8WXnRxh7Fm/hFQrULRaw==
X-Google-Smtp-Source: AGHT+IHgoOgmmpzUWmo5S60BO1pUByarv7RJfy63n2SDsKKJb7QiCNekweWSxevHVGIvd6M3NvDI1/pPNIhUAhC5STA=
X-Received: by 2002:a5b:b4b:0:b0:da0:5787:ef1b with SMTP id
 b11-20020a5b0b4b000000b00da05787ef1bmr5020395ybr.14.1698263556648; Wed, 25
 Oct 2023 12:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf> <ZTgVE8TzMEPvVeOr@shell.armlinux.org.uk>
In-Reply-To: <ZTgVE8TzMEPvVeOr@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Oct 2023 21:52:24 +0200
Message-ID: <CACRpkdZceWA8dcFcCx8sFFNzTG3Kvq3itz81MxBExNGf=dyGgA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

On Tue, Oct 24, 2023 at 9:03=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> If we can't fix up all platforms, doesn't that make the YAML
> conversion harder?

It does. I'm scouting some possible routes. I'm leaning toward
introducing extra compatibles to use as markers for special node
name rules.

> You've asked me to test the Clearfog GT-8k change - which is something
> that won't happen for a while as I don't have the hardware to hand at
> my current location, nor remotely.

No hurry. These bindings have been sitting unconverted for some time
and all driving it now is my need for formalization and that can wait.

> What I can do is poke about in the u-boot sources I have for that
> board and see# whether it's doing anything with those node paths. Off
> the top of my# head, given what the board is, I think it's highly
> unlikely though,# but I will check - possibly tomorrow.

Thanks Russell, much appreciated!

Yours,
Linus Walleij
