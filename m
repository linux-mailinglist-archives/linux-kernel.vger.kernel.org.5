Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AA7A9A68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjIUSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjIUSjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:39:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030BD2052;
        Thu, 21 Sep 2023 11:22:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DB5DE0003;
        Thu, 21 Sep 2023 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695320525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9iU/unn2B5Lg59HKhzCVV0eWDfanHflmRLaK3sdqHo=;
        b=hIAvQ8dgDH08u0BdHXTRIonGAo3yKFcZMxt3uw1qDZt+5ypJM3sJ8rIIGEcwJHGsRoCaR2
        nifRNtpjmn7gbCEdBRqJLjOFn75cZwYAcde/5iEG/trGreT3o1bM9iKxU+HgDHKAPKa+G6
        Jih/l/+El0+VJyWic6ezaTZoSmTUD4vc8twqBfLOUADhLTcNE24hbSjRqw84uEROq3R32d
        LRudTD7HMQ1tbNO1XwIXQtasht2CBb5tWbQ7fPTz5pMthOnuUlVdU1aMrNn9xUw2PbB83C
        jw74tIo2/G4YcjHYlpb20jMeWYMc/0OX6IdrPVnzwLA259K7WqTosgU1i6+GRQ==
Message-ID: <85cc3b27-417e-4cf4-9f77-347a338c9d67@arinc9.com>
Date:   Thu, 21 Sep 2023 21:21:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
 <20230918181319.GA1445647-robh@kernel.org>
 <16710cf9-8911-4fed-8e2d-b19b581446c1@arinc9.com>
 <a8d49992-4fa8-4a9f-b954-79011a3040a8@lunn.ch>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <a8d49992-4fa8-4a9f-b954-79011a3040a8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2023 16:00, Andrew Lunn wrote:
>> - Link descriptions must be required on ethernet controllers. We don't care
>>    whether some Linux driver can or cannot find the PHY or set up a fixed
>>    link without looking at the devicetree.
> 
> That can lead to future surprises, and breakage.
> 
> Something which is not used is not tested, and so sometimes wrong, and
> nobody knows. Say the driver is extended to a new device and actually
> does need to use this never before used information. You then find it
> is wrong, and you get a regression.
> 
> We have had issues like this before. There are four rgmii phy-link
> modes. We have had PHY drivers which ignored one of those modes, it
> silently accepted it, but did not change the hardware to actually use
> that mode. The PHY continues to use its reset defaults or strapping,
> and it worked. A lot of device trees ended up using this mode. And it
> was not the same as reset defaults/strapping.
> 
> And then somebody needed that fourth mode, and made it actually
> work. And all those boards wrongly using that mode broke.
> 
> The lesson i learned from that episode is that anything in device tree
> must actually be used and tested.

It looks like the root cause here was the lack of dt-bindings to only allow
the phy-mode values the hardware supports. What I see here is the driver
change should've been tested on all different hardware the driver controls
then the improper describing of hardware on the devicetree source file
addressed.

If a devicetree change that ensures proper describing of hardware is found
to break a driver in the future, then that exposes a bug on the driver and
the driver will have to be fixed. I don't see this upholding writing
dt-bindings that ensures proper describing of the hardware.

> 
>> Although I see dsa.yaml and dsa-port.yaml mostly consist of describing an
>> ethernet switch with CPU port(s), there're properties that are specific to
>> DSA, such as dsa,member on dsa.yaml and dsa-tag-protocol and label on
>> dsa-port.yaml.
> 
> I would say dsa,member does describe the hardware. It provides two
> bits of information:
> 
> Which cluster of switches does this switch belong to. You probably can
> derive it using the DSA links between switches, which is also a
> hardware property. But having it in device tree makes it simpler.
> 
> Which switch is this within a cluster. You need to be able to say:
> Send this frame out Port X of switch Y. How does a switch know it is
> Y? It could be strapping, which is clearly a hardware property.
> 
> dsa-tag-protocol is similar to phy-mode. It tells you the protocol
> running between the CPU port and the SoC master interface. You often
> can imply it, but again, it could be determined by strapping on the
> switch.
> 
> label is an interesting one, and probably would not be accepted if it
> was proposed now. But it has been around a long time. It also does
> describe the hardware, it is what is printed on the case next to the
> RJ45. To make the user experience simpler, we then try to make the
> linux interface name match the label on the case.

Looks like we can incorporate dsa.port and dsa-port.yaml into
ethernet-switch.yaml and ethernet-switch-port.yaml with adjustments.

Arınç
