Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B587D02F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbjJSUC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BBB9F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C358C433C8;
        Thu, 19 Oct 2023 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697745773;
        bh=2MggdwhgnildvMk7NTDjOnoS6Jg5jQXkqNkqB0aYHMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RiedKH/Y9dbYa6ubDlG7uoC+WUOghwhKS6eWHt3VkrGMdKiVpXgjr3wa1Syt8GXzb
         aSB+8hDbY/HNr9zWPmh72fzVc8GWH6W+XurEWZqjj3vVuJBbCPtrrW/G/J1v2DaTpA
         ZsbVxpeds1O29uH8kEZLDd9zKF+bkYcUw34+b2WjZNQHf/KTADVgYG04uGSniuLo33
         Fo+oLOfnmd9qbPJ5MdS3C5zbsyiNyTJq3NAGDbqj4j6DslvZ/IYJqV+KYeiy76VqQJ
         Hlyp8sUZp8E3iRaOCKosL3bacUhMlLBYdcV78uPcq/PwPb+8a0xG4neCLulkJzM5pO
         /nbDUji07J9oQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso50783e87.1;
        Thu, 19 Oct 2023 13:02:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKZGhiaRU7dSDQiRJDADsL8AtWjbqaob/EHCWVsn3mZYf5LWrz
        vbQm1kQbyWln1yZe/YIcnH/72IjY+1aclfxTJA==
X-Google-Smtp-Source: AGHT+IHnua5COj4QgtXUHQNJd1cUfAW0WlEMmymFNUywVpcrDbobt71n9JgwhpVYyWQmFIz6kp8EPizyDSqyxeaxEtQ=
X-Received: by 2002:ac2:54af:0:b0:502:9fce:b6cc with SMTP id
 w15-20020ac254af000000b005029fceb6ccmr2235339lfk.11.1697745771855; Thu, 19
 Oct 2023 13:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <169762516805.391872.4190043734592153628.robh@kernel.org> <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>
 <20231019134902.GB193647-robh@kernel.org>
In-Reply-To: <20231019134902.GB193647-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Oct 2023 15:02:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSex0o_jPV=MNsF7oUnaLx97FpiqJXPhUZH=kv7JZM0w@mail.gmail.com>
Message-ID: <CAL_JsqKSex0o_jPV=MNsF7oUnaLx97FpiqJXPhUZH=kv7JZM0w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:49=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Oct 18, 2023 at 01:39:45PM +0200, Linus Walleij wrote:
> > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a re=
quired property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a requi=
red property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a re=
quired property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a requi=
red property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> >
> > Fixed in patch 2/7?
>
> Yes. If one patch has errors we drop it. I should probably just give up
> on the rest of the series instead.

The bot should work better now not dropping patches when there are
warnings. It will give incremental new warnings with each patch.

Rob
