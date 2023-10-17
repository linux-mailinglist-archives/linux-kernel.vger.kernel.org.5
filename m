Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD37CBB92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjJQGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQGr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:47:29 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA6B0;
        Mon, 16 Oct 2023 23:47:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1F391BF204;
        Tue, 17 Oct 2023 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1697525245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBlwDvwhYGIsgSmVdpjhBCYAnjDFfdrZLN1FVn3zBd4=;
        b=hDTZmwUOqR3/92Etf0bXfl43fFK80p7gU57teibZRMG3XQJzL2Z+8K+/Ukgq7h5FRA8rDh
        zDJqbqGnwt5hy7hTdohCcLDh2ImDZKlR54he2ROqcwIz+88qV+IOJWg5deGItGS69hdgh8
        LWE2aesfLwnLGpkk2cqpgzNnSzLorkjliDbVzgX12m2hW8Pd09/eRBIrCmhduTC+29PC7N
        5fYA+wNhBGRCI1iqrh9C1Mg0F5TOUavuei+t7fiLMX2tgW+NbzUEScCPIFZYy7kb634Emg
        ob8yPrlai9y7Kp4lsyDx+/lVQBnyItXeqH2sVBwcQd833rs6JxCgcNiM9/3pSQ==
Message-ID: <18ff5bcc-35d8-4759-86d4-66fd9c702622@arinc9.com>
Date:   Tue, 17 Oct 2023 09:46:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] dt-bindings: net: mscc,vsc7514-switch:
 Simplify DSA and switch references
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
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
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-7-a525a090b444@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231016-dt-net-cleanups-v1-7-a525a090b444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2023 00:44, Rob Herring wrote:
> The mscc,vsc7514-switch schema doesn't add any custom port properties,
> so it can just reference ethernet-switch.yaml#/$defs/base and

This is ethernet-switch.yaml#/$defs/ethernet-ports now.

> dsa.yaml#/$defs/ethernet-ports instead of the base file and can skip
> defining port nodes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Other than above:

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
