Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505E7D4D45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJXKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJXKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:05:45 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C5D118;
        Tue, 24 Oct 2023 03:05:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83A512000C;
        Tue, 24 Oct 2023 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698141941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MN831TqYZOpqvXC2XriVIlPZsef8tm9lyCIKQly4bCk=;
        b=pOadOalyRqzNXEzU7qu+TIY9M3RWnqbI1XIgDabGwHefnL2/iZJ5dnjy/XB9TZpY+aMTQt
        9nj8KmYLay3idnZ6x0yErnGA8jbnDsXkCVu8gmVi7SGlbqFQvcxiyGyjqw7vs9H+QacyYF
        Q5hATO6pb+tQgcX9nQ6btGQagj3lDiCemrEDBX+TFzQOrNF+9L8um7f9ADf/9XoPUv+95V
        YBAPArUCTegkCaV1wqC8mwdmxnbawPFaSvUK5woxDHGb83xTHmAfM6euGzNVOpaKqt6ORu
        vniZngFevfyrcP/RP333G5SNFysVCY1rkzuumGLimeKy8GEua2M6mszO6LsoMA==
Date:   Tue, 24 Oct 2023 12:05:53 +0200 (CEST)
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
In-Reply-To: <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
Message-ID: <498ee025-b1b7-eafc-3758-993c5d564f67@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <169808266457.861402.14537617078362005098.robh@kernel.org> <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com>
 <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Krzysztof Kozlowski wrote:

> On 24/10/2023 11:54, Romain Gantois wrote:
> > Hello Rob,
> > 
> > On Mon, 23 Oct 2023, Rob Herring wrote:
> > 
> >> pip3 install dtschema --upgrade
> >>
> >> Please check and re-submit after running the above command yourself. Note
> >> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> >> your schema. However, it must be unset to test all examples with your schema.
> >>
> >>
> > 
> > Even after upgrading dtschema to 2023.9, installing yamllint 1.32.0 and running 
> > without DT_SCHEMA_FILES, I can't seem to reproduce this error. I've also tried 
> > rebasing on v6.5-rc1 which didn't show it either. However, It seems like 
> 
> v6.5-rc1 is some ancient version, so how can you rebase on top of it?
I just cherry-picked this patch series on v6.5-rc1. I also tried v6.6-rc1. Since 
Rob mentionned basing his series on rc1 in his last message, I inferred that he 
compiled the dtb checks on the last kernel rc1, but maybe I misunderstood what 
he meant. 

> 
> Which commit this is based on?

This patch series was based on:

6e7ce2d71bb9 net: lan966x: remove useless code in lan966x_xtr_irq_handler

which was the latest commit in net-next/main at the time. Essentially, the patch 
series is meant to be based on net-next.

Best Regards,

Romain
