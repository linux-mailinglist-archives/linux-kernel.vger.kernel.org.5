Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412017D4D03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjJXJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjJXJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:54:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7866118;
        Tue, 24 Oct 2023 02:54:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B12B1BF20A;
        Tue, 24 Oct 2023 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698141274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6kpnCauGpieWhcMLKeK1rtS0Ofn4S7bu6jwngyl3s0=;
        b=L+Xqh5Fx2hVbFpW0OYWntx/WrCJXy4GXTE0DVdPVQGEU879NpTo2VCtqKl8EecnRz+us/n
        0eD2Ic3DphekNkJwZoe+ZlO94pwlwIDomXT9/GSlERM8WEgEm1YrCjqPIlZVHAI7kgiyhs
        r0GcytSD7vlUQSAMaTYwW+V03QMztxGa47Dr6e/bT96j/6Fgxml91yQ+xUK9LiNDiIs6qy
        LRryjMKU7CT96ixVyiNFy/WS4g+LdKXMsAHFMsj/Scx36mCSgQE+urHwzz3u9U7/bY4sw5
        F40xBEdfI9hKDfjRExeWrretWdk+w4dLhS4xyrpiuD90jSaU7gYi2YY3ct8ezA==
Date:   Tue, 24 Oct 2023 11:54:44 +0200 (CEST)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Rob Herring <robh@kernel.org>
cc:     Romain Gantois <romain.gantois@bootlin.com>,
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
In-Reply-To: <169808266457.861402.14537617078362005098.robh@kernel.org>
Message-ID: <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <169808266457.861402.14537617078362005098.robh@kernel.org>
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

Hello Rob,

On Mon, 23 Oct 2023, Rob Herring wrote:

> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
> 

Even after upgrading dtschema to 2023.9, installing yamllint 1.32.0 and running 
without DT_SCHEMA_FILES, I can't seem to reproduce this error. I've also tried 
rebasing on v6.5-rc1 which didn't show it either. However, It seems like 
the error is related to the psgmii-ethphy node which I'm planning on 
removing anyway.

Thanks,

Romain
