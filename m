Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4177B6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjHNKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjHNKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:40:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFADA1994;
        Mon, 14 Aug 2023 03:40:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99d6d5054bcso763319966b.1;
        Mon, 14 Aug 2023 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692009595; x=1692614395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aBAVpXS8NM/S563eJtaui9WR2vwiGDxIvWqt84h+Oyw=;
        b=V70f5VYcQVBIRnMn6jR03+6JOI14+oCqXEWxRdHaanV/itzXjH9HeO9NNoZV7KFT9j
         nYaWU4HQ6T6n3IV5dPW7x9uINA6vgEvjmG0DE3jMr2iFoHsEty9DIWE/MdLgCbpm/BJg
         nnAXEbLjMJtg9Wlm3s9H9HmJBQ6at1Jj3kpH4+req6Fyj/yHbK08CPwZHLZfUNamu9U+
         APEy+XpTZzT1EwQD/sNFi8r3lzivs55sBQIvAjPMS7pfp+p4ueqyPl9bk0ilH+zuWTKU
         tJkkYVwN/Qa+zF6n1GnoNUJ6ypDlepd+/oT7wD3Tg7wZ3QjeDCeaq10emFC6At5osy5m
         24ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692009595; x=1692614395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBAVpXS8NM/S563eJtaui9WR2vwiGDxIvWqt84h+Oyw=;
        b=fbvpR0OyRiDN2QB5ojvGSmbYIYXnF/D+UykERLGj3zhSOhB/SZcFEdIwyQzRIRFVm9
         EZshLEwXQFFR/KaNNmSa2h33MHz2hDgJGy7KAoHkDC88TEVLSc5RvESbZynZrjwqJHBs
         WSZN00O3lg42AELUgSH8mz/+Bqy5XDt4i+aLPg+RHu1UWPgSeYT+CyDwAa7XO3y4NTyq
         9hJceaHWGdzNFndY56lxQEtNdjjcaX2GMO2fyCmqzb7cC079tBmZM8HPMrR3gdE+9yRO
         Hgd7niNGpEmFUnz3JBdLP/jz86HMU5kNzGpLK/Df1O6sY3skgSU/XcDAyXtwnr42sbIq
         OZxw==
X-Gm-Message-State: AOJu0YxzdfsYCJByJJsjzUgvEN6GB9pTFjTHlS6Ka8c0Azt/tkWJbIiP
        W8y5Fvmdlzx0JG46rLnIzvA=
X-Google-Smtp-Source: AGHT+IGWQdWdFfldoc+s7RKd4/99QgX6XSZumLq8F7bFXSVWECP7EKR6y4ID5N1QKyWzkJA/s+6bjw==
X-Received: by 2002:a17:907:2d94:b0:978:8979:c66c with SMTP id gt20-20020a1709072d9400b009788979c66cmr13860963ejc.18.1692009595070;
        Mon, 14 Aug 2023 03:39:55 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id o8-20020a170906288800b0099cc15f09a0sm5495409ejd.55.2023.08.14.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:39:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:39:51 +0300
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
Message-ID: <20230814103951.epdk3bzhkn2h7oul@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <891c0b67-abe1-416c-aa94-675f7f3d8044@arinc9.com>
 <20230813190227.6k2qyxfewbkmatn6@skbuf>
 <af044838-36ef-4ed3-af0a-a58181b6345a@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af044838-36ef-4ed3-af0a-a58181b6345a@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:06:19PM +0300, Arınç ÜNAL wrote:
> On 13.08.2023 22:02, Vladimir Oltean wrote:
> > On Sun, Aug 13, 2023 at 05:58:57PM +0300, Arınç ÜNAL wrote:
> > > On top of this, I'd argue to document the internal MDIO bus on the
> > > ethernet-switch.yaml schema instead.
> > 
> > Why?
> 
> Because a generic switch can have an internal MDIO bus, it's not specific
> to a DSA controlled switch.
> 
> Arınç

I'm not sure it's that simple. Check out arch/mips/boot/dts/mscc/ocelot.dtsi.
Its switch IP ("mscc,vsc7514-switch") is on the same hierarchical level
with the "mscc,ocelot-miim" nodes (so, not a child), because the MDIO controller
isn't part of the address space of the switching IP. Actually that could equally
be considered true for DSA. Placing the "mdio" node as a child of the switch is
one of the possible options, but it has its limitations and is certainly
not the only one.
