Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102717F7DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjKXS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:27:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB41BC6;
        Fri, 24 Nov 2023 10:27:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so324598766b.3;
        Fri, 24 Nov 2023 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700850439; x=1701455239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZE0Duv0jXkYD1Uf9wlPJY0p/L8iUSaCA0xiviM7UDY=;
        b=J6DiO/qfxLwtBhN82edsegESQt2N/UQVSVzMRnbOi8xSdcK0ZSiiXdV/xRkyiXpw3a
         fp8lDr48Djyd13MF+yX2Z9pMvOdDEJW/Be4bE1gmxkmSAvNsit9ckM2Aq61mkbN7ITTX
         JFn8sMRkycOtlcubzoO9pQQb0FfB32hgy7UO1dqt60RPEBr/w5YVDsHl173gOxcSmFBk
         GKyCc3qjd1fZzceyyhktQCDAcfDB7cog/+Sp3ihkQPH//riZl5IFhkzICERtl6u/Aloz
         BEd20jzVjB3LG5GZwRQjI4A1wmmStigjv+vRKhniHUpr0IHpMxQvb5kYHWVkCBvAdsX3
         CxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850439; x=1701455239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZE0Duv0jXkYD1Uf9wlPJY0p/L8iUSaCA0xiviM7UDY=;
        b=PXupsankMVFr16ZntAm3hbXaNIKsLtkENAsQ6RpePyb8mUsLEc3ASRVC+ZRoJmZUJB
         MnVPoRVAvcpmwXRfQoeYyYX4tMQ6AagT3rK2gL85ASQKDbF7Yx1X9CkKu3X9qoDDeXOp
         oheKuquEn8RSN4puS5utQAAhf6KkEeNcCG3Q6v1eS/nVvhrp/NrNnpH1TAcFF91sDhpW
         nj4MCqP4kKOTUeIMtVcXy8SCdE4U3ouou+bl2ka7xMs3yfe/Gi8qdWY4W9sYi35ihoyH
         JD8QJeyp/yjZsvkNpuPvHYui3uxYidI6qv/6OjMlhZG2jutKcc0oMOAD5SWYbY1I5UbP
         WmMg==
X-Gm-Message-State: AOJu0Yyanlsx1XFbsfbCneO5YaC6FrqNvTYhoIPJxFKSU15LX8LJdbc5
        NtxeZU/5L6cdVhY/MvLEAYE=
X-Google-Smtp-Source: AGHT+IFuywZgZqeVIukwbFqD8q5mrgqH2bkh0mMo/lbicvHhoDUxK4WwGP+s8nvCyvyHtUVJhgXK6g==
X-Received: by 2002:a17:906:3fd0:b0:9b2:c583:cd71 with SMTP id k16-20020a1709063fd000b009b2c583cd71mr2509480ejj.50.1700850439417;
        Fri, 24 Nov 2023 10:27:19 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id k18-20020a170906579200b009ffe3e82bbasm2356276ejq.136.2023.11.24.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:27:19 -0800 (PST)
Date:   Fri, 24 Nov 2023 20:27:15 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20231124182715.azmi3fwrdg3gfdkj@skbuf>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
 <20231124165923.p2iozsrnwlogjzua@skbuf>
 <6560dc65.050a0220.182b5.650c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6560dc65.050a0220.182b5.650c@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:25:16PM +0100, Christian Marangi wrote:
> The main reason is the fact that PHY package are already a thing and API
> are already there (phy_package_join/leave...) so we just lack any way to
> support this in DT without using specialized code in the PHY driver.
> 
> This is really completing the feature.

Hmm, I see struct phy_package_shared as a mechanism to tell phylib that
multiple device structures are actually related with each other, because
the device core, and their parent bus, has no idea. If you're under
control of the parent bus code and you can probe PHY devices in any
order you want and do whatever you want before probing them, I don't see
why you would need struct phy_package_shared any longer? I don't see why
this feature needs to be completed, if that involves changes to the
device tree structure. PHY packages assumed no changes to the device
tree (they rely on a hacky interpretation of the MDIO address AFAIU).
If we change that basic premise, all implementation options are on the
table, I think.

> The only reason for the generic "ethernet-phy-package" compatible is to
> have a solid detection of the node in PHY core. (I assume parsing the
> node name might be problematic? Or maybe not now that we require adding
> a reg to it)

Our opinions seem to differ, but I don't think that the package needs a
solid detection of the node in the PHY core :) I think phy_devices and
mdio_devices already cover everything that's necessary to build a
solution.

> Also I don't expect tons of special properties for PHY package, with the
> current probe/config implementation, a PHY driver have lots of
> flexibility in all kind of validation.
> 
> Consider that the additional global-phys and global-phy-names are
> already expected to be dropped.
> (we know the PHY package base address and we can calculate the offset of
> the global phy from there in the PHY package probe)
> 
> And even the phy-mode has been scrapped for more specific solution...
> (some assumption can be done on probe by checking the PHY mode and set
> stuff accordingly or even do parsing in the PHY package node as we pass
> the OF node of the phy package)
> 
> The PHY package node would be reduced to a simple compatible (and even
> this can be dropped) and a reg.

So why does it need to be described in DT, at this stage? :)

> I feel there is a big chance here to generalize it and prevent any kind
> of mess with all kind of similar/equal code that just do the same thing.
> (and we already have an example with the PHY package API usage with
> every PHY having the same exact pattern for probe/config and nothing
> describing that the PHY are actually a package in DT)
> 
> Hope it all makes sense to you.
