Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56277F84CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbjKXTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345987AbjKXTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:40:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13B98;
        Fri, 24 Nov 2023 11:40:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54afd43c83cso1166628a12.0;
        Fri, 24 Nov 2023 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700854820; x=1701459620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKrRg2snxExqJdFGigUYh7T7Fc6aEzueP8JRF0HCrTo=;
        b=jnEfe2+VbZBpN2wMsD3w96vpmbBE2wc2X/QwHv7yt0dtmByK91FIHcgt82ldqDrPrh
         27bh8nXMj2zU6XTUipw9OiB/9PmqewQNYwSqscxSgwPEswURcJkPuhTtWmgMOAtxb9jN
         OnH8pL94RXFUb0lc1KPjO+oamHC5n/XrL6mIsvmZ8rLGsN52PSddrj/r3HlQvt+VLg5J
         xyw8ZvvhrHIzUswjeuEn8A163s4X8JrmG1jHN34/sAbVnx8CGSxwDl32yRaPgrYTSWLS
         f2S68tS1TdoMfzDLjyXRwrM1UEutnFoCXswaAE+UaPifHNnYGUIMGmwqF+u6wN7CYI0X
         GbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854820; x=1701459620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKrRg2snxExqJdFGigUYh7T7Fc6aEzueP8JRF0HCrTo=;
        b=LJs8oVlIGs2PGAv9zlxz/hlgpEn+5hyUL5tXmQyt9zsOoWJSk80bEOV5oASbvwRaRv
         YY58JPGqhSB3YJsHwNlfkONjAABZaD3Na99IvRCIX1vB4fojkoudDOqm2mvOoyO7x24g
         5uyVT9l9ZZ8gNWM6pAR4Z+8JcM9pDtTRw1hTvQLogcIQe7wKqz004/3u0mwcTUPDPME2
         ytnDtbbi3gRmEny5lmvqyrv7QvTSdg5NGD5JXMZwkkvsp0KcS0LioYuLegRawkpaYVnA
         99i2JiIsO4nQqLlcKMijedOfcZN5DYk4aW+QNIHsopPMK7gP4KO6exWxo7N+Yu6umTXi
         Mmng==
X-Gm-Message-State: AOJu0YyhosQWHaPAKACqVnkqYKyf4EypDkQ8KReeR75lQPxjcIPEewSF
        TiQ9X6F2xfj769T6sRcIHq8=
X-Google-Smtp-Source: AGHT+IGItN29AlffdfAFP+pdBb+pUmXR0qRXvVcejscZr6unZPC/VQI53oWhDMvt4V3MPYz/KIrdxQ==
X-Received: by 2002:a17:906:f1d4:b0:9fb:f99c:3ea with SMTP id gx20-20020a170906f1d400b009fbf99c03eamr2802823ejb.52.1700854819659;
        Fri, 24 Nov 2023 11:40:19 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906111900b00a0435148ed7sm2464856eja.17.2023.11.24.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 11:40:19 -0800 (PST)
Date:   Fri, 24 Nov 2023 21:40:16 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
Message-ID: <20231124194016.tcmu4w2r7jrnv6mo@skbuf>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
 <20231124165923.p2iozsrnwlogjzua@skbuf>
 <b8981dc4-5db0-4418-b47d-3e763e20beac@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8981dc4-5db0-4418-b47d-3e763e20beac@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 07:35:35PM +0100, Andrew Lunn wrote:
> > I think you are hitting some of the same points I have hit with DSA.
> > The PHY package could be considered an SoC with lots of peripherals on
> > it, for which you'd want separate drivers.
> 
> At least at the moment, this is not true. The package does just
> contain PHYs. But it also has some properties which are shared across
> those PHYs, e.g. reset. 
> 
> What you describe might become true in the future. e.g. The LED/GPIO
> controller is currently part of the PHY, and each PHY has its own. I
> could however imagine that becomes a block of its own, outside of the
> PHY address space, and maybe it might want its own class LED
> driver. Some PHYs have temperature sensors, which could be a package
> sensor, so could in theory be an individual hwmon driver. However,
> i've not yet seen such a package.
> 
> Do we consider this now? At the moment i don't see an MFD style system
> is required. We could crystal ball gaze and come up with some
> requirements, but i would prefer to have some real devices and
> datasheets. Without them, we will get the requirements wrong.
> 
> I also think we are not that far away from it, in terms of DT, if you
> consider the later comments. I suggested we need a phy package
> specific compatible. At the moment, it will be ignored by the kernel,
> the kernel does not need it, it probes the PHYs in the current way,
> using the ID registers. But it could in future be used to probe a real
> driver, which could be an MFD style driver. We need to see updated DT
> binding examples, but i don't see why we cannot slot it in at a later
> date.

I'm not suggesting to go for MFD right away. Just with a structure that
is extensible to possibly cover that. For now, a package node with a
Qualcomm compatible, with the most minimal driver that forwards MDIO
access to PHY children.

I can't speak for the future of PHY drivers, since I don't know enough
about PHYs. I'm just coming from the DSA background where I really wish
we had this sort of infrastructure earlier. Now I have the SJA1110 which
still lacks support for the interrupt controller for its integrated
PHYs, and a bunch of other IP blocks in the package, because it's so
incredibly hard to make the driver support the old-style and the
new-style device trees.
