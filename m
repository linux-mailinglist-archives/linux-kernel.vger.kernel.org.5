Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A67D4F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJXMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjJXMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:13:13 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FEF9;
        Tue, 24 Oct 2023 05:13:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21F7D240007;
        Tue, 24 Oct 2023 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698149586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=93RoybtCmurkEhmIcEikf8HjaYFy2otQkCDnAt4Q9kg=;
        b=ELKk/21vjkPETZrMa4aDzQBq4IDx0/H74mmiNL06MB34Yl/+2q6kw44OHlOe3F5XqibIT2
        vsv04tEI8l3XtSsLBm8ygRdVQgM6cpCd1YODIunnTCtwWOmxewC/y5+GdKsvM7nrjlvcRZ
        0Nb9Hztu7D/J1iqK7rrVlf+9wjwBSQu45suHEf95RVgoLU4I17N5JlWzTbleOtP5YU0QNs
        8erlqmOSckGnRVrieB0s6uQ1Jqy1mQuAp2jB3y4XsKyegNhUsbwEL21xeJ/Ey3denUKuSY
        0qSjLkJ4uiGdk2OF1I6ryrwoR7fubqZI2RL0FhvlVtZWM1yLbixuAseiOf3Z6w==
Date:   Tue, 24 Oct 2023 14:13:17 +0200 (CEST)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>, davem@davemloft.net,
        thomas.petazzoni@bootlin.com, Paolo Abeni <pabeni@redhat.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
In-Reply-To: <7018bf8b-1f89-408e-8649-3788a28f3b1a@linaro.org>
Message-ID: <0389bcc9-b74e-5394-d15a-17914ec3c1a9@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <169808266457.861402.14537617078362005098.robh@kernel.org> <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com> <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
 <498ee025-b1b7-eafc-3758-993c5d564f67@bootlin.com> <7018bf8b-1f89-408e-8649-3788a28f3b1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Krzysztof Kozlowski wrote:

> Rob's bot might be using not-yet-released dtschema from main branch,
> thus the error. However the error is true: you added a custom field
> without type. That's why I asked: where is it defined?
> 

I didn't define it anywhere, that's an oversight on my part. The psgmii_ethphy 
property is a handle to an MDIO device, which I thought was integrated to the 
PSGMII bus in the IPQ4019. However, I just learned from Robert Marko that this 
MDIO device corresponds to a SoC-facing PHY integrated in the external QCA807x 
IP. Therefore, I'm not convinced that this MDIO device should be handled by 
the ESS driver.

I'm going to have to consider refactoring the psgmii_ethphy handling out of 
the IPQESS driver, which would make this device tree property unnecessary.

Best Regards,

Romain
