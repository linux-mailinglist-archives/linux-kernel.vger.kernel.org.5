Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB587D1013
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbjJTM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377317AbjJTM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:59:57 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C8D61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:59:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579de633419so8336457b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697806794; x=1698411594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFC/B00tUI2hXABfcSdP/RdnPPeUlHvWc23J3vC1mo8=;
        b=foUvfQU0BLptbJBxK7DRcxWBDl4s950H52WKbEUUpoUd22VoX9RtTPpI4OxOYnF4az
         TXtJeBEVMDZk1Yfnwzq8oVRxeJ8GN27HmTjhxGu2buqcu5jKb2kx6pwC8Gj1Msy7JvEu
         YV9INu23Imn4YcTKACkoRMRPVXXA+X3febVFAHUHKVb74Q3aIThxbcZZuX3So7+IFPOa
         O4zmP4WvFCnFS3MA5tnaWQi5ubJGT53/HBmCXv84y7+OEecycOCIGJg0iiWTvbpL8ZBC
         fiVFAz0KmRKmMS/AcRiBToz6JAnNdpszKHGtBsrakLOcohCPEl9z+sNrcMJMOPyxnNWj
         hfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806794; x=1698411594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFC/B00tUI2hXABfcSdP/RdnPPeUlHvWc23J3vC1mo8=;
        b=AcxqbxdBhsN7GKr0bTizWeLQCyZ0SOu2VIpvebnA3s9UQHh0sLiXjej/3prHes3vj/
         aKtKdK4ejpAvMIoGLbUhhHfub8xgHEijAZZgmr5bk2023/5Y++yynRCtBBqI2xNuX6Y/
         UN1qI7XN0qUFMoqAMjKOswSUfm94i19XQImb56FBPQt4DS+HJkBFO3fj/60qvKd2hsOD
         ROXUYa0b1ZCn7lNH3RUzIAWTUClvyMPF3p51hdZJP/fhj2eaGDyzd8Q5tFVml/K6JzFv
         pR4T0ONrEKxcxVerp/acsDoHrwEXx7dyv/5enbrQlPPGYHiJbk4T93rai8RKD6pjdI5J
         Jiuw==
X-Gm-Message-State: AOJu0YxN8UbcAXqnY/RkK0C8DWoVqKSWWvclac6Eu/7JFOFZnAC9nSty
        t9KQmK3v8W3Ax6kus+OcQVQRftxq9cEtLF16dqzyyA==
X-Google-Smtp-Source: AGHT+IFaEnMKB0meMkvyhN4BbXF4gAdnlozEeoARMKEWNdhaivAk0ry/mu1R4xUPut/elXgpxZq5kcDKovovpb4EQoQ=
X-Received: by 2002:a0d:e843:0:b0:5a7:dac8:440c with SMTP id
 r64-20020a0de843000000b005a7dac8440cmr1964960ywe.23.1697806794468; Fri, 20
 Oct 2023 05:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf> <20231019144935.3wrnqyipiq3vkxb7@skbuf>
 <20231019172649.784a60d4@dellmb> <20231019162232.5iykxtlcezekc2uz@skbuf>
In-Reply-To: <20231019162232.5iykxtlcezekc2uz@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Oct 2023 14:59:43 +0200
Message-ID: <CACRpkdam5UZWbB_tAKoU3_jdZLbH0TFT3yt3Xf9G1b=_42e4zQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

On Thu, Oct 19, 2023 at 6:22=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
> On Thu, Oct 19, 2023 at 05:26:49PM +0200, Marek Beh=C3=BAn wrote:
> > Yes, unfortunately changing that node name will break booting.
> >
> > Maybe we could add a comment into the DTS to describe this unfortunate
> > state of things? :)
>
> Well, the fact that Linus didn't notice means that there are insufficient
> signals currently, so I guess a more explicit comment would help. Could
> you prepare a patch?

I can just include a blurb in my patch so we don't get colliding
changes.

Yours,
Linus Walleij
