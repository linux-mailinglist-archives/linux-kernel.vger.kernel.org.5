Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1177D492D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjJXIBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:01:49 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEAA10E;
        Tue, 24 Oct 2023 01:01:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A369E0009;
        Tue, 24 Oct 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698134504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXSyIwNPdYoqMmZdYVydwIght1sBMANhzc18yNPNSho=;
        b=ZhpE6DLRcEXWm+QE6JtlA+DMkRtgI38j1hNa1wJO7zAonXyNCpbkfIdxXMrHA+HuDqFlm1
        7uGf9N1fjDuBD6wZzBLc5T3qAwk78wiyOjppc9aadM2zivjB595m3L1qVQy+VJJrz/trIa
        wdzM5WsxXqhEuzdHLer4P+HGbD/cu6x85IZ4U8XlaBT+pdSKCX5VQGNgmJRixHSzYIIaT5
        g1YF0i9c4YYxrxVWH4KL0C1LowK142P6Tu31SQB6054E7V7kq59DxUR+/+0oGY/6KugXcA
        dEBSBXCc+O5p7R+H7ygfaX3v1LJ7xrYbcu32g7vrot1DOSFrrrG1j7+wsHjenw==
Date:   Tue, 24 Oct 2023 10:01:56 +0200 (CEST)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
In-Reply-To: <81d7b86e-aee2-4222-8c7a-52d0b710a2f2@linaro.org>
Message-ID: <ad6b786f-5c06-02ca-2e8b-388692b24c57@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <81d7b86e-aee2-4222-8c7a-52d0b710a2f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Krzystof,

On Mon, 23 Oct 2023, Krzysztof Kozlowski wrote:
[...]
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm IPQ4019 Ethernet switch subsystem driver
> 
> Bindings should be about hardware. Please drop "driver". "Subsystem"
> also sounds like Linuxism.

The "driver" part was a mistake, I will drop it. However, the "subsystem" 
terminology seems relevant here, as the SoC documentation refers to this IP 
group as the "Ethernet Switch Subsystem". If it's okay with you, I'll change 
this to "Qualcomm IPQ4019 Ethernet Switch Subsystem (ESS)" in the v2.

> > +properties:
> > +  compatible:
> > +    const: qca,ipq4019-qca8337n
> 
> 
> What do you want to express here? ipq4019 is not qca. This is Qualcomm
> (so qcom) SoC.
Agreed, I'll change the compatible.

Thanks,

Romain
