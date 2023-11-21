Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D07F3156
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjKUOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKUOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:42:52 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4819A;
        Tue, 21 Nov 2023 06:42:49 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-359d796abd6so16877355ab.0;
        Tue, 21 Nov 2023 06:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577768; x=1701182568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3A7KpgHMK4Z79+I2bLwtyrRdlzJKFRe2k6m6RGdmok=;
        b=Q96eu84eiaewjJSbJlAY7hsa4u5TwC3G4eDGAU5Wr8YZ7WXgzDzPauZPasrdZ8rshm
         GZjR3iRVSergYzS9DchyCMWQYyJtXHfdKnIoGpBB2gQIR/l4z/98lVCJK2Kvy6IABKuZ
         kmm9vas/Jkd+tk9xSyaoxgRSlvmZyyNcb3AfHb2+j86/UToNEul5i59qqx1z4d0qUEJA
         +9AwOHyq5VomXShnuEGWk4z9GByrtA+XwLTxd2xLw8XZDDPRGJRGl5bqWXr/zmefB53x
         IVm3j4fdeQFVIqCm6Z02IeyfDikLkEReSGu2LZ38PHSmcr4GTplg77WVHURnGuirtTNo
         /d9A==
X-Gm-Message-State: AOJu0YydLFaVkqDTWjpnhrRhPAdpTO6/o/mZfbfzkiL03L45TzXQs3tN
        U6nYBke9fbQPYcIOOVW5Iw==
X-Google-Smtp-Source: AGHT+IFErelSnQ13ze33zj2Pn9ZJ8mT036wv+Q+uVkt2NH4z4GKcQqP9beqPCMRCJybBK/5ldhsxlw==
X-Received: by 2002:a05:6e02:ef4:b0:35a:e585:4275 with SMTP id j20-20020a056e020ef400b0035ae5854275mr2441886ilk.7.1700577768236;
        Tue, 21 Nov 2023 06:42:48 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s5-20020a056e0210c500b0035129b9c61bsm3232374ilj.45.2023.11.21.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:42:47 -0800 (PST)
Received: (nullmailer pid 1689994 invoked by uid 1000);
        Tue, 21 Nov 2023 14:42:44 -0000
Date:   Tue, 21 Nov 2023 07:42:44 -0700
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
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
        Vladimir Oltean <olteanv@gmail.com>,
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
Message-ID: <20231121144244.GA1682395-robh@kernel.org>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:44:58PM +0100, Andrew Lunn wrote:
> On Mon, Nov 20, 2023 at 02:50:30PM +0100, Christian Marangi wrote:
> > Document ethernet PHY package nodes used to describe PHY shipped in
> > bundle of 4-5 PHY. These particular PHY require specific PHY in the
> > package for global onfiguration of the PHY package.
> > 
> > Example are PHY package that have some regs only in one PHY of the
> > package and will affect every other PHY in the package, for example
> > related to PHY interface mode calibration or global PHY mode selection.
> 
> I think you are being overly narrow here. The 'global' registers could
> be spread over multiple addresses. Particularly for a C22 PHY. I
> suppose they could even be in a N+1 address space, where there is no
> PHY at all.
> 
> Where the global registers are is specific to a PHY package
> vendor/model.

For this reason in particular, the package needs a specific compatible.

> The PHY driver should know this. All the PHY driver
> needs to know is some sort of base offset. PHY0 in this package is
> using address X. It can then use relative addressing from this base to
> access the global registers for this package.
>  
> > It's also possible to specify the property phy-mode to specify that the
> > PHY package sets a global PHY interface mode and every PHY of the
> > package requires to have the same PHY interface mode.
> 
> I don't think it is what simple. See the QCA8084 for example. 3 of the
> 4 PHYs must use QXGMII. The fourth PHY can also use QXGMII but it can
> be multiplexed to a different PMA and use 1000BaseX, SGMII or
> 2500BaseX.
> 
> I do think we need somewhere to put package properties. But i don't
> think phy-mode is such a property. At the moment, i don't have a good
> example of a package property.

What about power supplies and reset/enable lines?

Rob
