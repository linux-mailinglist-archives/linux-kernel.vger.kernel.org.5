Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62AC7F16DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjKTPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjKTPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:11:42 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C010F;
        Mon, 20 Nov 2023 07:11:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4387B240006;
        Mon, 20 Nov 2023 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700493095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLMeAASwEvkwM5ARSBtAZOQghxCaeyY75R6X+if1WqE=;
        b=EkKetB+wXFOXzu45jcP6q9hgdQzKT9+5OHVLW2zOFn8URL/SigTzG9AWgS6nrEwMtiMpTB
        N4sd+uhNHabIe0/3iC+laVyBUqaIE2g5dudV+3yB1oP9FOH6xB3cdfYzUDmyOMiKPGkql8
        JOnw1xXDKKEz3QHHJGF4GUkh3u7bga5BE9uqa42/K+gUFPksiReAhVzevONDW1avOjEoO+
        m1RCQ/xyE/oNKA7muxsQJrYshLOSuGRg6unBLQtIQ2wdAHhbMang6/sgXsr98HK4BDtFDr
        DxhTb4EIUQ+fHfsX24X5YUaz6UO9tSLX8gDf98/TuXBwzTCQPF0snXrZBhMWcg==
Date:   Mon, 20 Nov 2023 16:11:31 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 00/14] net: phy: Support DT PHY package
Message-ID: <20231120161131.2c0e2892@device.home>
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On Mon, 20 Nov 2023 14:50:27 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Idea of this big series is to introduce the concept of PHY package in DT
> and generalize the support of it by PHY driver.

I don't have much to say on the series itself, I looked at it and
didn't find anything obviously wrong, however know that this work can
also be helpful for some other use-cases. I have in mind the Marvell
Alaska 88e1543 PHY, which is a 4-port package that can either be used
as a classic Quad-PHY, or a Dual-PHY, each PHY having 2 ports. Having a
DT description of the package is a good step towards being able to
auto-detect which configuration to use for that package.

Thanks for this work,

Maxime

