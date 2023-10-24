Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9619B7D591B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbjJXQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjJXQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:48:27 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93BAC;
        Tue, 24 Oct 2023 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nnNLDj4uW/y9atsQNBKnJTpDkBDpPKX+YvjuCTopJyw=; b=PjSMhl3lS71qYHlyD5L1WfCg50
        2UPhEVM7eleWNQ3kWuI4EX9GLQbB+PEgqC7npE4VgqAOFODUO38FcXtHtFBQcXd0gJEBGU3pTdx7b
        m2uivzGvVLfe9fFDwr53KPLvn5ZEDvi4oOKg0GZwAfwMWwLlNlxJn3x4XP/eHcDkY/ek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qvKZm-00063j-7b; Tue, 24 Oct 2023 18:48:18 +0200
Date:   Tue, 24 Oct 2023 18:48:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
Message-ID: <c02f0050-6e15-4aad-a8a7-44a9911d8857@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-4-romain.gantois@bootlin.com>
 <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
 <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>
 <932bef01-b498-4c1a-a7f4-3357fe94e883@lunn.ch>
 <CA+HBbNHb2RF3tfDYRTG6AndhmW1U4tvFmiC+rhYwH8SCLqSUzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHb2RF3tfDYRTG6AndhmW1U4tvFmiC+rhYwH8SCLqSUzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It is being accessed as regular MMIO so the MDIO bottleneck is not present,

Just out of curiosity, how long does ethtool -S eth42 take? Can you
compare it with an external qca-8k switch?

	Andrew
