Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B807A314B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjIPQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjIPQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:01:10 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292418E;
        Sat, 16 Sep 2023 09:01:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD3E820004;
        Sat, 16 Sep 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694880059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cicF7chj7riRpPja3q96dvd4VI1Db8nQ+jlNJBelRdk=;
        b=eGZbIXcnDc09K7Gp+rHBN3OWiS/9NK5vw0Gj4xYPxi3VsYaLThWXFfxH4EV8zHrfJJBo6T
        9fq+QNQP1zC4Ukto5j86b4GRfy0XcYAfBXBr/WCRyDMELcpISzTyfM9WJ5GCNKy3mUQ+1i
        LR4/aFA3t3jgS4u2fQGC3Xm4+nr9pk69bV1fe3l0MFGebw11iqbOEYW9guWMrtY0FiDZl2
        KZpnwCsEGY4KEPfCQRmVTmSx/o31pU9Va4K99L9c9nYjT/MaJkviA7yVC8v6pQ/6lIECS4
        gY4v/1Vv0/grUi3JTXrI7+1/mcdFNKdZ11PDij6YbPh3xCAOO59eKmW3FKYuUQ==
Message-ID: <bdd2b752-21f9-4d1e-85e1-75a04479bc73@arinc9.com>
Date:   Sat, 16 Sep 2023 19:00:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Marcin Wojtas <mw@semihalf.com>, erkin.bozoglu@xeront.com,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Machon <daniel.machon@microchip.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Magnus Damm <magnus.damm@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Steen He gelund <steen.hegelund@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, mithat.guner@xeront.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        George McCollister <george.mccollister@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        DENG Qingfang <dqfext@gmail.com>, Felix Fietkau <nbd@nbd.name>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        linux-mediatek@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Alexandr e Torgue <alexandre.torgue@foss.st.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
 <169487630940.1637895.12001153052612710003.robh@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <169487630940.1637895.12001153052612710003.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2023 17:58, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 'anyOf' conditional failed, one must be fixed:
> 	'fixed-link' is a required property
> 	'pcs-handle' is a required property
> 	'tbi-handle' is a required property
> 	'phy-handle' is a required property
> 	'sfp' is a required property
> 	'managed' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#

I will address the examples once I get a comment on my paragraph starting
with "RFC:" on the patch log.

Arınç
