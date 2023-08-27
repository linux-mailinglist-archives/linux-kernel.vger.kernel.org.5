Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C9789C3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjH0IjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjH0Iin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:38:43 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40FB7;
        Sun, 27 Aug 2023 01:38:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DD1120002;
        Sun, 27 Aug 2023 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1693125518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skW65uQLk894K9XJtfeHQDWUnHUg2Kk1PFt/VALrobw=;
        b=TgU3MJmA9QvoUrT12sBLc5bWK9BNdvquWgzTEHXBCtHwHbog5s1pwPctEiNXG/edJLwCXf
        YaZLjqtKOpgXEo5X1ub0mFsQKpNCA5BtJYpvCPUyDFD7a/7g4eXxLcrq8uqwwB5mGPnZd7
        XclvxF/jntWYO1steCgqTYl2IJ19Sfh67MHyERsu6qqLCC1ep+MF530HXkVAcvUIWc1KmH
        oEb6TiOGMMdGuWS2Tupi1PtcI2aKYi+f2Zxp95VIvoXwj1owAUnMLoWgqDba4X4CC7OEIY
        802VYXxPFcdHEZRVAk2P6/ZS2FHI4YcyZZ1pPRKROq04s9AOyhf4OvTZmllh9Q==
Message-ID: <b3edd0fe-af28-4ae5-a584-7cbaba8b2e06@arinc9.com>
Date:   Sun, 27 Aug 2023 11:38:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
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
References: <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2023 16:09, Andrew Lunn wrote:
>> Ah okay. I didn't consider the switch architecture where the data interface
>> of the PHY is connected to the switch, and the PHY management interface is
>> connected to the mdio bus that the switch is connected to.
> 
> The generic Linux architecture for PHYs and binding them to a MAC via
> a phandle allows the PHY to be on any MDIO bus anywhere. DSA has some
> additional shortcuts to support 1:1 mapping if the switch has its own
> MDIO bus, without describing it in DT, but this is just in addition to
> the generic code.

Understood.

> 
>> Not json-schema documentation, don't care about:
>> - ar9331.txt
>> - lan9303.txt
>> - lantiq-gswip.txt
>> - marvell.txt
> 
> The marvell switch can have up to 2 MDIO busses. If i remember
> correctly, there is also one switch which has one MDIO bus per port.

I will work on writing a schema for these once I'm done with this.

Arınç
