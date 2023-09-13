Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5279E885
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjIMNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjIMNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:00:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F631989;
        Wed, 13 Sep 2023 06:00:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso8999985a12.2;
        Wed, 13 Sep 2023 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694610052; x=1695214852; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YrbAZ7p+q0hOYwba3y8YZqHpfIOsVvTzknQ/Q/Cixt4=;
        b=h0yD0aAnv4+XqR7pucMoFGVVlvtqY7MRd1/KWFLgAV5vNJyqzVo6LvjTCyjF4VQ1BD
         fmvucMUgGfxazxI6xob9M8E/N0OQ5bPpwFWnjEyjMrxcEhSSUQr/LeGXTE4paAIQt+gw
         X4BRdAnPaZ0+HGgwAwQpKYituheU+gOBIWD5ZEolpFsVk0ZvS5s65h0NM6O2I4ShzzIZ
         sa42Z591XrhF+7/+b0yecp4mP0teoZ+BqzA/ANIeRrHvrQcr14jmS0EHKnqHowPndOHf
         eYrXXoI8pWezOXPQl3Nnkfg5Jr7TpAcFzoGmP1QMDsCokkEM6qdagnbL2t8Nb9Jber99
         5dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694610052; x=1695214852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrbAZ7p+q0hOYwba3y8YZqHpfIOsVvTzknQ/Q/Cixt4=;
        b=b4bLdaUqPbCOPBNYxzmCLPgaLcm6yQf1HvEdvNSpZYuPYSelH2pKgSc6GoiSGLgY0t
         NXlCJUoj83/LUBlX1H9iwRkEPY1Sf8qIyI0Jiv3uo35omAOPY9mT+hf0UGgQUfhGvQwJ
         Ck5b/6bA4bz4dO+8BdStwaWzF3SGCJzHcOWgqqVPOPM1AP82oFGTd5ENku21Gw3aBgb+
         2kMNEkmQu0hZsIkr2vehTIy3x8m59tu1JlitKapgRY9gIMGngzgpet8dmOQm/IJyxd2A
         NVsWRROX6MGis13C30dR5K0BIPS/oUO8SJEPb+z16pxbflXyR7YuT1zUrbpLfct7B9Wt
         SUSg==
X-Gm-Message-State: AOJu0YyzKm2T1j1AkuZGdHVyUGHPymgYm3qvOrknaZbOgAfgCYWbooHG
        JHonphimhisMKNDMahwEMkY=
X-Google-Smtp-Source: AGHT+IFZY1lZRYIGtnHSSLJ5Dv9nUSo3FSHlEpmP7yJBNk19dcocL3jmULDt3kHQBRqk+jZdLrELeg==
X-Received: by 2002:a05:6402:743:b0:52f:b405:4f21 with SMTP id p3-20020a056402074300b0052fb4054f21mr2383088edy.7.1694610052353;
        Wed, 13 Sep 2023 06:00:52 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id j18-20020a50ed12000000b0052996528b81sm7285107eds.45.2023.09.13.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 06:00:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 16:00:49 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230913130049.ivvl4vzjcfedsddr@skbuf>
References: <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
 <89c9b84c-574c-4071-9524-9207597a3f0a@arinc9.com>
 <20230913110404.co7earmnbzf6hhoe@skbuf>
 <137fd54d-7d2d-4d0b-a50b-cca69875a814@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <137fd54d-7d2d-4d0b-a50b-cca69875a814@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:35:11PM +0300, Arınç ÜNAL wrote:
> On 13.09.2023 14:04, Vladimir Oltean wrote:
> > I don't think they're for switch ports only. Any driver which uses
> > phylink_fwnode_phy_connect() or its derivatives gets subject to the same
> > bindings. But putting the sub-schema in ethernet-controller.yaml makes
> > sense, just maybe not naming it "phylink-switch".
> 
> Got it. Should we disallow managed altogether when fixed-link is also
> defined, or just with in-band-status value?

Just with the "in-band-status" value - just like phylink_parse_mode()
implies. If not possible, just leave that condition out.
