Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E213F7D124E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbjJTPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjJTPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:12:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE8FA;
        Fri, 20 Oct 2023 08:12:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso145722466b.2;
        Fri, 20 Oct 2023 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697814763; x=1698419563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZU5hBj8/e4oDuCRh8BssYew0LlrPlrgUCeK6Uhar2WQ=;
        b=hRQ0+ABGvWBkF2Q1fXlM+GQl2LcHIPMLpchIFGBPlahA/NP40FKcgNofnqbNVStStt
         GWKGrXX1v9lqCIUn7L/HibwqF5d8UzDvc+8tSxa7KDOvPoTiJ+SUSplPxeU6nXwzv8zm
         2+81Z8jfeZQrS3As3q4cllMz5n8p7S8FRVOoJlWfqJdC/mDyIM22aXr9K9Sh/7thNAG+
         E4lsLyvzdnIWV6Nt1pDqCjU0xP6uIlfU/Uul/PjYLq8/YN6/Mb75RcyLJa6C5hLBt915
         kRobuu8P/RmPGvF83ZnEGci04CblVclAuYAXJKrAhYtyrV7ovp5ikC8iH8Ij2YKxXbr1
         dtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697814763; x=1698419563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU5hBj8/e4oDuCRh8BssYew0LlrPlrgUCeK6Uhar2WQ=;
        b=uD2g8aseqaxe3b79Odjs14hDLxhsf4Eehg85f5MWRtX/VZfpGJuhMherqo9i7u9sfx
         5iKR/fYD4B0WsLhfMxBDmYrqo0tmIp3Dk1ed00lMtGsrc4zUx2o/UP5ZBYSg5RpVw3/V
         f/Qi2HkjBcAjBQ4kkM65m15S4rAt5/4pA5NMeBzJJxfqtsYvqnw0zlytEN/9jG8QFX+G
         iB13aYX3jgvuQPY1PNAL0QTfzv5FMyg/KYewSqGU+8clu5xf4fmjYOUQDYjv+DIVURMu
         Wy3T371Xg3a44HEN29azAu6s/jLoha64xGwPkl3fTR7QwuPx1MIH9gfd3SBeuHV5dCmu
         /GJg==
X-Gm-Message-State: AOJu0Yx9gQbHsftQrEgqhNIm7FBL2eh8ssONNnq0IyO2LS9ej14uqpME
        OTGVFs6T/au2k0uoAFdz27I=
X-Google-Smtp-Source: AGHT+IHpR9r/JHxcLJl5Vxxatg7b/wgqRKDdY/W5Fw63VB9oSzgnCKlz5RaNbTQa568EZAW9WyPbsA==
X-Received: by 2002:a17:907:3f22:b0:9bd:a063:39d2 with SMTP id hq34-20020a1709073f2200b009bda06339d2mr2130957ejc.16.1697814762995;
        Fri, 20 Oct 2023 08:12:42 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm1650051ejw.158.2023.10.20.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:12:42 -0700 (PDT)
Date:   Fri, 20 Oct 2023 18:12:40 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231020151240.3gdcftg2aaz7bnal@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231019153552.nndysafvblrkl2zn@skbuf>
 <CACRpkdbskk22SLmopUTD78kMWL_gcOa=YWHLFtrkDAD5=W=HFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbskk22SLmopUTD78kMWL_gcOa=YWHLFtrkDAD5=W=HFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:47:20PM +0200, Linus Walleij wrote:
> On Thu, Oct 19, 2023 at 5:35 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> 
> > Yikes, both these examples are actually broken,
> 
> As you can see from the patch, they are just carried over from
> Documentation/devicetree/bindings/net/dsa/marvell.txt
> 
> +/- fixes to make them pass schema checks.

(...)

> These examples are already in the kernel. Migrating them
> from marvell.txt to marvell,mv88e6xxx.yaml doesn't make
> the situation worse, it's not like people magically start trusting
> the examples more because they are in YAML than in .txt.
> 
> But sure let's try to put in better examples!

You are not correct here. The examples from
Documentation/devicetree/bindings/net/dsa/marvell.txt don't have ports,
and the way in which you added the ports is wrong (at least relative to
the way in which you kept the mdio node).

> > What you have now is exactly what won't work, i.e. an OF-based
> > slave_mii_bus with a non-OF-based phy_connect().
> 
> Yeah when I run check_dtbs I get a few (not many) warnings
> like this on aarch64 and armv7_multi:
> 
> arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dtb: switch@0: ports:port@4:
> 'phy-mode' is a required property
>     from schema $id:
> http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Ok, the warning is valid, but I don't know what phy-mode to put there.
It is unrelated anyway. Some warnings will be expected after the schema
conversion, and they are not all mechanical to fix. When we put schema
validation in place for checking that CPU ports have valid link
descriptions that phylink can use, we decided to be lax in the kernel,
but strict in the dt-schema. Hmm, not sure what were we thinking.
We didn't have a schema for Marvell, so we weren't even seeing many of
the validation errors that you're now uncovering.

> Isn't there some in-kernel DTS file with a *good* example of how
> a Marvell mv88e6xxx switch is supposed to look I can just
> copy instead? We shouldn't conjure synthetic examples.

(...)

> I'm game. Point out the DTS file and I will take that.

You can use https://elixir.bootlin.com/u-boot/latest/source/arch/arm/dts/imx6qdl-gw5904.dtsi#L211
(optionally renaming switch to ethernet-switch, and ports to ethernet-ports).
That uses the subset of the mv88e6xxx kernel bindings that U-Boot also
understands, so taking a U-Boot example is actually preferable.

> > One other thing I see as a deal breaker for this schema conversion is
> > that $nodename for Marvell needs to allow basically anything (invalidating
> > the constraint from ethernet-switch.yaml), because we can't change node
> > names in the case of some boards, otherwise we risk breaking them
> > (see MOX). If the schema starts emitting warnings for those node names,
> > then it's inevitable that some pixie in the future will eventually break
> > them by "fixing" the node name.
> 
> I already did a bit of hippo-in-china-porcelain store in the patches
> in this series mostly renaming things like "switch0@0" to "switch@0"
> (yeah that's all).
> 
> Is this part of the problem or something else?

Yes, for most of the switches, renaming their OF nodes should not be a problem.

For Marvell, I'd exercise extra caution and only rename those OF nodes
where I can confirm that doing so won't break anything. Marvell is one
of the oldest DSA drivers, and you can tell that the bindings have gone
through a lot before becoming more or less uniform.

Anyway, for the $nodename constraint, it _looks_ all mechanical and trivial
to fix (unlike the missing phy-mode that you point to, above), so someone
will jump to fix it. I would like to avoid that, because boot testing
will be key, and a board is not always available.
