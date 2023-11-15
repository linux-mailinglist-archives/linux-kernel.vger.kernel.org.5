Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F37EBFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjKOJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:51:10 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC7511C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:51:07 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7fb84f6ceso68553277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700041867; x=1700646667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tmf2nRZN1s/CHTKzt/jZkzy4o27CfCTxzAeztvQEdk=;
        b=qhxVZcgDq+7LFnZR1nXnJ+Z5ax38INsPmfiZHmIF2q0lSuGlhrzD7y8nCAO4Bo7uET
         TAfTX2rotlFZ8Yim6UsUlotPAfXVeQUq0W91NIXEkYU05kori/ZeDtGo8eZ5eUMfAZHK
         c1StQZ+GmW7SmeKTll9tRlLr+KNro23kgAyI0t0Og2piZjjIWQEouQZNwxEJUGw7mVbt
         hdMznRYWPqw3JtRaEC3yQQKIoKq1e6jqMHGECMW7oAPgWDh/z9pBYoH0n7ZkaqpfrduO
         r1/t11txAV8Yd2HVsnaXHNus2FWMLjeT7gKko5PWY5kx/LThWGdKpl7SSFrAtP1ifTl+
         EkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700041867; x=1700646667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tmf2nRZN1s/CHTKzt/jZkzy4o27CfCTxzAeztvQEdk=;
        b=dw8tWMmGS8+2rPmzB13X6bRQ9d4ITEx0lA9dlFFw0mVE24xiwx0mEvF8iN6P3xSuoi
         hGIjptHzxhg3G1rpSSYWrxTzYNbW7fhM2RACzkDOowF06nL8N/CFaGGJh/IP4eN7aGEO
         LNr2Ra7KkKhbxxqCVnHYkr/FbYRkZ0GhGxaaXHYx2gHi6IIZKtTyYj2v5jI23G/h2eSE
         Xd18Zc6USg1jMQVYTYY5x4MvJDbnmaIk+IkLlrlJPigYCbDBvDSCraL/g3wDe1Vvr9Hv
         QUpjr3eYmbtiMkQcBBShlyvfDNouvyuZM1AEDrGFvqQYAqtovRHKKSOizEomfj9SKXzt
         CxnQ==
X-Gm-Message-State: AOJu0Yxsb9vtQUjbJRrjXtPhgm03eMROnmATQjf51ZstVQYsyaMcf2Mx
        mbCjWaYa7pZnknnidvZHdzlUvHchIxn17v/2tvRJhw==
X-Google-Smtp-Source: AGHT+IFSgX0z5IlGDoT/0m+VbJ7P43EUtewnNSaZqeSORdKG017CT78/HSbY7YbPEenWZdoSQofQPbPdtldquHeip9M=
X-Received: by 2002:a25:655:0:b0:da0:95c0:d157 with SMTP id
 82-20020a250655000000b00da095c0d157mr8553037ybg.51.1700041866709; Wed, 15 Nov
 2023 01:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org> <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
In-Reply-To: <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 10:50:54 +0100
Message-ID: <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
To:     Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:

> So i have one open question. How do we merge this?
>
> Can we just take it all through the DT tree?

If we don't expect the affected DTS files to have orthogonal
modifications we certainly could, if the respective subarch
mainatiners are OK with it and can ACK that approach.

For Marvell that's you I guess :)

For NXP VF that's Shawn Guo, Shawn are you OK with
these changes going through the net tree?

Yours,
Linus Walleij
