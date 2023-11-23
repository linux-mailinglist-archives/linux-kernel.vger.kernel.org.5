Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60E7F679F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjKWThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjKWThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:37:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA401FF6;
        Thu, 23 Nov 2023 11:36:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32deb2809daso783629f8f.3;
        Thu, 23 Nov 2023 11:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700768164; x=1701372964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QW6tI0VHpBIjgHCH5Ff0+qLlXVxkpAX7d83oOLeIsRI=;
        b=VVoD2rHpP/xg5wqXa/vJa8LYEmWtbTEu8hDlYL6wYWFaZOko0n6Ib9FPi35TvP4ocI
         A1s8Gg3wGfGijeadt0LMFjde6PclDduAbG1JrJj2dCAMubt9gpQYX0kARADuhgbFgBWR
         NoWD68pk0gNYMv7DzrVRMyo3ZajKxBsBk7SvTPXcJNt9QpBuHvHImCrokZkj7KJFtij2
         qnntrtaMFWkfDg0k3kgj6nrIee9gfSFnSDH+nE3NG9DGhaugRmz4ZOYZw9+fpyr9ajG8
         brLzTdsRV6P2lRuD+4BpnUxtF7mjoH5VT5VV2WWEUYb2trvhOHk+KLE/9F6cTqpWhvg9
         PKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768164; x=1701372964;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW6tI0VHpBIjgHCH5Ff0+qLlXVxkpAX7d83oOLeIsRI=;
        b=kQL2dMEZzygiZwwzDpYgI5BWED8ASYkHUjrarHFmNyWGPVsi6Z7rYLEZ+4f0ZliZZe
         BehPk9IugmIADnODcVqioHIpaW7HIcAbu08P0k0NFUSRH7aAdVp5T068bMiSz/Z7QOEV
         Kxp3Z7hEbjxBbDogZu4Z0/8Yzy9jlVStefG5/UZ3UlAkAWvcxqXsjZzAF/WjjGLJ+vD5
         PXv5fi+2DE+RlTIw5rcmHa5MEtEqbhkcm/QoB1Xyj5xUVLmW3d3c7bNy4icW9UmA0vm0
         Lv0vxiUAenLchsWsF6Wy2xUEeSZc2gYrFQhkx2pKj78hu9YkUVrZalY5eLaEEas0NyKf
         t33w==
X-Gm-Message-State: AOJu0YzdkNIDRZByohNng65C57wAiYoF74czB8XArP7Nkr0+XBueIHzt
        ilL5Qy2QgqCJpWUxnSy2oXL4JOtnjR/PNQ==
X-Google-Smtp-Source: AGHT+IGTnewfVDDU26YNpIgEsAKe25Oi3ZbRjAwSfLwOCZVIekJqTG1IwEOPirisjxnLfXVeZzk89Q==
X-Received: by 2002:a5d:5384:0:b0:332:cc7b:8484 with SMTP id d4-20020a5d5384000000b00332cc7b8484mr377488wrv.48.1700768164315;
        Thu, 23 Nov 2023 11:36:04 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d4e82000000b00323293bd023sm2465891wru.6.2023.11.23.11.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:36:04 -0800 (PST)
Message-ID: <655fa9a4.5d0a0220.b01e8.7f5b@mx.google.com>
X-Google-Original-Message-ID: <ZV+poTDVxDA0g9LE@Ansuel-xps.>
Date:   Thu, 23 Nov 2023 20:36:01 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>,
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
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
 <6a030399-b8ed-4e2c-899f-d82eb437aafa@lunn.ch>
 <655f2ba9.5d0a0220.294f3.38d8@mx.google.com>
 <6eb2e061-5fcb-434a-ad43-370788075597@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb2e061-5fcb-434a-ad43-370788075597@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:07:14PM +0100, Andrew Lunn wrote:
> > compatible = "ethernet-phy-package", "qca807x-phy-package";
> > 
> > With "ethernet-phy-package" a must and "qca807x-phy-package" used only
> > if additional property are used.
> > 
> > My current idea was to use select and base everything on the possible
> > PHY compatible (and it does work, tested by adding bloat in the DT
> > example and seeing if the schema was rejected). Had this idea since the
> > compatible would never be used.
> 
> The DT people are unhappy with PHYs don't use compatibles, so
> validation does not work. It probably too late to add compatibles to
> very PHY driver. But this is new development work, we don't have any
> history. So we can add a compatible per package to make the validation
> tools work.
> 
> So for parsing the tree in the kernel we look for
> 'ethernet-phy-package'. For validating the tree using the yaml tools
> we use the 'qca807x-phy-package'.
>

Ok clear, what about the generic ethernet-phy-package.yaml?

Idea was to describe common properties there and then specific PHY
package would add every common property with $ref and add their special
ones on top of that. Would that be ok? (similar to the current
implementation with ethernet-phy-package and qcom,qca807x with the only
difference that qcom,qca807x.yaml would also have the compatible set
(currently missing from this RFC)

-- 
	Ansuel
