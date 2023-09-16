Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51617A2F75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbjIPLJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbjIPLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:09:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E604919A;
        Sat, 16 Sep 2023 04:09:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 563A6240002;
        Sat, 16 Sep 2023 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CLnt81HC2PDi8+eg097J5b0q3LjbSM2hFWX7ICGCp5g=;
        b=SivAsr92jUS2r0D2NuCC/Bjn/qkCXjinijlFQKJE8l4HdVRs2nX5x9qJC/rV/xc5w1WPyo
        LSAm0IcgnIiv/+lpVRPws2MMxkAtbwAcvYX7sL1pKBJMHExKnLRYmMXwDjwhOXY6hxbpHQ
        DjJ/V+d5/Dv29SXYRMJHsBOklcA2MVm8LHIQ8YC2GRAo9tcHoWSFVTKc9tP0fuIevUbwWH
        QNgAw5TIo+pETaj4Y9aa6UJBCf2xDfZTpNeCMp6TuU7etbvdZPGsKdcZDSX2ynFbjuLim0
        i63MG9ODlAa6pGVyT8kJELfj03IJuqB/2aO1Hrb9yvU8a+hEndME6rWnKUcHBw==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
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
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Woojung Huh <Woojung.Huh@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v2 00/10] define and enforce phylink bindings
Date:   Sat, 16 Sep 2023 14:08:52 +0300
Message-Id: <20230916110902.234273-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello there.

This patch series defines phylink bindings and enforces them for the
ethernet controllers that need them.

Some schemas had to be changed to properly enforce phylink bindings for all
of the affected ethernet controllers. Some of the documents of these
ethernet controllers were non json-schema, which had to be converted.

I will convert the remaining documents to json-schema while this patch
series receives reviews.

Cheers.
Arınç

v2:
After many discussions on v1, the concept of the patch series changed a lot
to document the changes from v1.

Link to v1:
https://lore.kernel.org/netdev/20230812091708.34665-1-arinc.unal@arinc9.com/


