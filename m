Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B7792AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbjIEQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjIECmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:42:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63563CC6;
        Mon,  4 Sep 2023 19:42:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso29990031fa.2;
        Mon, 04 Sep 2023 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693881751; x=1694486551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt6ay0ilUmrNIrakmOthvuLnYKcSlh/71zqVmBj/MNI=;
        b=eAVqggZ4SYFDQkPgn4YOQuLjtL7pkRlt9fAwagRklY3YslyBOUJG5lhAAN2Xtqw6qe
         mkkICwFL0xcSiR5qoSjXYHIYxDPNJR2+5SK38n46QfsU/9bkMTISu7cYWL5FgZLyfrKB
         UI7oMix7gM55h7WuxDA39BjAGydhYLVAOHOAPIjuBxSYTJdbRa9lAQVxmpcH4TOxkUkQ
         HMzCqo7fPHWjUw4+gUBup7+Rd33BmvqztccMDfGruovD1I1nif/0ewizy9Bl5a9/rYkA
         +60GB4YNC9haEOc2eeTy2+1RjWcXVGYY7K6RADPh3uHfLycVypM1tjgzAxEjvXXTDxAw
         /hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693881751; x=1694486551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt6ay0ilUmrNIrakmOthvuLnYKcSlh/71zqVmBj/MNI=;
        b=OVZAxkqjlUzQjiM22yszhNMPifMACktdH/Soke8zBmF42UNgtN1ipJE4iptpUDhYgG
         R8tF9b63VqCmglZ2TnDy4t2TzJj1bxjFHTw5RslWqQNoIPfoAvfSHd+r27koGZ2HpIIn
         XEy0MKm/rX33roKUSjcC+PKGrHpI35xUwY1hNwL1qtl2bb8cAyAlH9VjJIRQcUwNR9Mx
         offW5AUK2+iUiy7nD71SFsH3gsg4nMToNd4CX/xkOIcZukN3JxRaO3L8W5nRThbV4ikB
         3waKQ506FahqWsZRSlEeL7pe119sp5RIrmxOlLumdmvaEat1TVbMFPAl4FRZlNbUd2NO
         eS1Q==
X-Gm-Message-State: AOJu0Yxm7POxbvV6TipWyU1PFT/mBaMHLoOxMeyNgs02kJYWXK2TWq+i
        yRbrjMJ/dGWF76AOT2kiStfbNds4vCK8uO5vwQhczOTOvvH5Gg==
X-Google-Smtp-Source: AGHT+IGDYEM/D+VjDs53lbJVDTyoT0Bkv7iXApFmItzvgobWbxVZW0eXbIPiwJUhubc08jbCg8gVCb4oxy8r4PLOtqU=
X-Received: by 2002:a2e:980a:0:b0:2bd:1ea9:f0fc with SMTP id
 a10-20020a2e980a000000b002bd1ea9f0fcmr8939737ljj.21.1693881751359; Mon, 04
 Sep 2023 19:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230812091708.34665-3-arinc.unal@arinc9.com> <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com> <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com> <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com> <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com> <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
In-Reply-To: <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date:   Mon, 4 Sep 2023 23:42:19 -0300
Message-ID: <CAJq09z6eghuHY+b2y-kGmjKnLiEEOABXGKhjnB-PxJ=-GtYD4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1] ...this. The SMI-controlled and MDIO-controlled Realtek switches are
> > otherwise the same, right? So why would they have different dt-bindings?
>
> Honestly, I'm wondering the answer to this as well. For some reason, when
> probing the SMI controlled Realtek switches, instead of just letting
> dsa_switch_setup() populate ds->slave_mii_bus, on realtek_smi_setup_mdio()
> on realtek-smi.c:
>
> - priv->slave_mii_bus is allocated.
> - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
> - priv->slave_mii_bus->dev.of_node = mdio_np;
> - ds->slave_mii_bus = priv->slave_mii_bus;

I might be able to help here. The Realtek SMI version created a custom
slave_mii driver because it was the only way to associate it with an
MDIO DT node. And that DT node was required to specify the interrupts
for each phy0.
It would work without that mdio node, letting DSA setup handle the
slave bus, but it would rely only on polling for port status.

As we only have a single internal MDIO, the compatible string
"realtek,smi-mdio" would not be necessary if the driver checks for a
"mdio"-named child node. Maybe the code was just inspired by another
DSA driver that uses more MDIO buses or external ones. The "mdio" name
is suggested by docs since it was committed
(https://www.kernel.org/doc/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt).
That name was also kept in the YAML translation
(https://www.kernel.org/doc/Documentation/devicetree/bindings/net/dsa/realtek.yaml).

The Realtek MDIO driver was merged at the same release that included
the change that allows dsa_switch_setup() to reference the "mdio"
OF-node if present. That way, it could avoid creating a custom
slave_mii_bus driver.

I submitted a small series of patches to unify that behavior between
those two drivers:

https://lore.kernel.org/netdev/CAJq09z44SNGFkCi_BCpQ+3DuXhKfGVsMubRYE7AezJsGGOboVA@mail.gmail.com/
(This is my answer to the series opening message to include the first
paragraph ate by the editor)

There was some discussion but not NAC, ACK or RFC. It would have
dropped some lines of code. I can revive it if there is interest.

Regards,

Luiz
