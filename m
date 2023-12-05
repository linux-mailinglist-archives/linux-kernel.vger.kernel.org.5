Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AA805386
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442227AbjLELwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:52:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68AC3;
        Tue,  5 Dec 2023 03:52:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1975fe7befso601336066b.2;
        Tue, 05 Dec 2023 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701777157; x=1702381957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQnio+BjHch7uekOs0EbRaR6+xPg48w0mlLLI/zKaaU=;
        b=fGyFDt+2zfMoMGFkNb+wIqez0LxE+nJA6J0daN/LW4CpjKTBTpG5Gt9AUaEY4VWKFc
         Y/b4lLuuer2jiUCNf/A+rZ4+Ay+AWp7mxKScBDRdynDcFafxfvQLu0WouwBaD3pxB0+q
         aawAAXulKODe7QHWNAA/b2QfBM9BeKtbDNqK9fJkvRC//82r8X+0hWlt9OBbo++1dUMB
         a/d6//g4g2DGrP4PZ68TOhkGBbGkDv2L7mFDK7JcGg7PKggjMf4ZQCJeBhcOdVgSXhL/
         mSclAgN9uAVIMcf+V6YxYS/j4R9AQFoCyrip7JxinLKBrybeAi+6YcUKWTncNmGpC4Hu
         6hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777157; x=1702381957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQnio+BjHch7uekOs0EbRaR6+xPg48w0mlLLI/zKaaU=;
        b=izdRUqlLbiT921wq7u3sJQ35clLmjmc1cRkjllg7ySibdmDDd9hCavXZ2VRIYORofi
         1aIa1FBMbTEfCtIxhhGb6PZzjHBH8eKBagiCuNp0CuKj1wFaBxm1Q7nNKgnUausGBDf2
         QMcVpe9EcCRj4VIlYM66EWIZdsd/Z0C1vFH2fU5XWQY13zUEW9GV4W66gVizdl+4Op+0
         x8uCiZB98bihz/181/UT81WhZZ3H5/cS2RDhsQigJ4BUThNmz227f42/FBSU/SQ+diNf
         jnEFLxhSbTYEUteEcbmqFOz2SZUCzkHjPQOSNJrfjM1U2bZyauTDj2NMTvS80vzKW5VL
         Kqgg==
X-Gm-Message-State: AOJu0YzLp3ohxMJI9ZuniHxCxOiKmVRCLym9g9QLcOEBbnkJAnDeSgTc
        DNwZC6C0FbUm7hAtXnjt9CA=
X-Google-Smtp-Source: AGHT+IFbcUHHGMa0y7mPKTyHnJVqbuoOrcBU5Fgp7HSueg3Asjnj4OKHJ4FateR0JcHkUAKp1ewXJQ==
X-Received: by 2002:a17:907:8c8:b0:a0e:d93a:3202 with SMTP id zu8-20020a17090708c800b00a0ed93a3202mr323045ejb.4.1701777157222;
        Tue, 05 Dec 2023 03:52:37 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906298c00b00a1cbb055575sm451602eje.180.2023.12.05.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:52:37 -0800 (PST)
Date:   Tue, 5 Dec 2023 13:52:34 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <20231205115234.7ntjvymurot5nnak@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:35:27PM +0300, Serge Semin wrote:
> If the DW XPCS MDIO devices are either left unmasked for being auto-probed
> or explicitly registered in the MDIO subsystem by means of the
> mdiobus_register_board_info() method

mdiobus_register_board_info() has exactly one caller, and that is
dsa_loop. I don't understand the relevance of it w.r.t. Synopsys XPCS.
I'm reading the patches in order from the beginning.

> there is no point in creating the dummy MDIO device instance in order

Why dummy? There's nothing dummy about the mdio_device. It's how the PCS
code accesses the hardware.

> to get the DW XPCS handler since the MDIO core subsystem will create
> the device during the MDIO bus registration procedure.

It won't, though? Unless someone is using mdiobus_register_board_info()
possibly, but who does that?

> All what needs to be done is to just reuse the MDIO-device instance
> available in the mii_bus.mdio_map array (using some getter for it
> would look better though). It shall prevent the XPCS devices been
> accessed over several MDIO-device instances.
> 
> Note since the MDIO-device instance might be retrieved from the MDIO-bus
> map array its reference counter shall be increased. If the MDIO-device
> instance is created in the xpcs_create_mdiodev() method its reference
> counter will be already increased. So there is no point in toggling the
> reference counter in the xpcs_create() function. Just drop it from there.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---

Sorry, because the commit log lost me at the "context presentation" stage,
I failed to understand the "what"s and the "why"s.

Are you basically trying to add xpcs support on top of an mdio_device
where the mdio_device_create() call was made externally to the xpcs code,
through mdiobus_register_board_info() and mdiobus_setup_mdiodev_from_board_info()?
