Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8E79E109
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjIMHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjIMHmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:42:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2571729;
        Wed, 13 Sep 2023 00:42:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso864053966b.1;
        Wed, 13 Sep 2023 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694590955; x=1695195755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqyPmr2+k/NZVSejvLbli04qwXaMrXe8lYcDTd578VI=;
        b=SmIOP7yFeienFxV223boXY0wfCGIawhEsGnyu2Sb9e8v+HarxuR0pMQb7ix3hpy42E
         TOqYTquEvoBEpHE+26nbfMtXvkWVGdEJOTLUB0D1VOY2vOSKNTvQ28UMMtO6i2UYLI8v
         T3lnQN3X4/GzUF8QFT8poJ9JsIOA+mxtcKOQ9evIbgLT9K67n0sjBOZfxtvy9iJ1ewsU
         EP3F8zLilVHKgvRiWDNePh/hFlkegJb3+bwWhkQdc7aWUdhudkPRThPb0uTODpVaccra
         7nLlGFew4rir+TRfzsIAnGgEozXmHwRN2meeq4ORxc9jUmap/bSK8raKnz6u0kfCl7b2
         gB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590955; x=1695195755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqyPmr2+k/NZVSejvLbli04qwXaMrXe8lYcDTd578VI=;
        b=EvlXA+FFWQ9jDEzXPVxUz0sI8fFfFwIgiI5lRwsa/1sKyqsTgI4ZXly7pFo0sn07Pa
         lLdo/ChGGtHGoMjIeZMBuRTfy4Zi3TXU45+MYnE+AzU+qqXTqXj5L2dUROCMTHjciKDp
         u+7HTfWy0m5LTe8bu51EVkp5Xo7A+lGTMAUWSMIqmJCsxmjH8f/jkMJe85Y7DpFKTub7
         Au94k65euXCgxSR0TWojmdxOKDZZqRPQGPaDddgVepA2PQBwBCSqNeM0W3fEDzCfikaC
         /URXlL4ZHSB4nfjgvKf7ySGYHrF5pbxHKtCEQhuEsk9ond2s5emgf6uCkmh1qZno/Kbn
         4MIQ==
X-Gm-Message-State: AOJu0Ywnt6Y04QjueJyDEHC5aXfjVXtRYo8L+lefXIyhcjuQ0kXU2vdc
        3LoAyelDrxcT+JrEHwabgYA=
X-Google-Smtp-Source: AGHT+IG9wMEyhBjSpRxfH9WcGpwpPQcuKOXyDTvt6JEficQoouj+74NmVu6JoToLxPGIgK4sRqX+TQ==
X-Received: by 2002:a17:906:74c7:b0:9aa:1020:8c39 with SMTP id z7-20020a17090674c700b009aa10208c39mr1295768ejl.18.1694590954694;
        Wed, 13 Sep 2023 00:42:34 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090652c500b0099bd453357esm7874749ejn.41.2023.09.13.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:42:34 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:42:31 +0300
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
Message-ID: <20230913074231.5azwxqjuv2wp5nik@skbuf>
References: <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 08:52:37AM +0300, Arınç ÜNAL wrote:
> On 12.09.2023 22:34, Vladimir Oltean wrote:
> > On Tue, Sep 12, 2023 at 10:23:51PM +0300, Arınç ÜNAL wrote:
> > > The phylink bindings for user ports I ended up making by looking up the
> > > existing devicetrees are different than the phylink bindings for the shared
> > > (CPU and DSA) ports currently enforced on all switches.
> > > 
> > > My phylink bindings for user ports:
> > > 
> > >              allOf:
> > >                - anyOf:
> > >                    - required: [ fixed-link ]
> > >                    - required: [ phy-handle ]
> > >                    - required: [ managed ]
> > > 
> > >                - if:
> > >                    required: [ fixed-link ]
> > >                  then:
> > >                    not:
> > >                      required: [ managed ]
> > 
> > Right, it should have been anyOf and not oneOf.. my mistake. It is a bug
> > which should be fixed. It's the same phylink that gets used in both cases,
> > user ports and shared ports :)
> 
> One more thing, I don't recall phy-mode being required to be defined for
> user ports as it will default to GMII. I don't believe this is the same
> case for shared ports so phy-mode is required only for them?

phy-mode is not strictly required, but I think there is a strong
preference to set it. IIRC, when looking at the DSA device trees, there
was no case where phy-mode would be absent on CPU/DSA ports if the other
link properties were also present, so we required it too. There were no
complaints in 1 year since dsa_shared_port_validate_of() is there. The
requirement can be relaxed to just a warning and no error in the kernel,
and the removal of "required" in the schema, if it helps making it
common with user ports.

I think that the fallback to PHY_INTERFACE_MODE_GMII applies only if
there is a phy_device (phy-handle). But otherwise, I don't remember if
the PHY_INTERFACE_MODE_NA passed to phylink_create() will persist at
runtime, or cause an error somewhere.

> > > The phylink bindings for shared ports enforced on all switches on
> > > dsa-port.yaml:
> > > 
> > >    allOf:
> > >      - required:
> > >          - phy-mode
> > >      - oneOf:
> > >          - required:
> > >              - fixed-link
> > >          - required:
> > >              - phy-handle
> > >          - required:
> > >              - managed
> > > 
> > > Here's what I understand:
> > > 
> > > - For switches in dsa_switches_apply_workarounds[]
> > >    - Enforce the latter for shared ports.
> > >    - Enforce the former for user ports.
> > > 
> > > - For switches not in dsa_switches_apply_workarounds[]
> > >    - Enforce the former for all ports.
> > 
> > No, no. We enforce the dt-schema regardless of switch presence in
> > dsa_switches_apply_workarounds[], to encourage users to fix device trees
> > (those who run schema validation). The kernel workaround consists in
> > doing something (skipping phylink) for the device trees where the schema
> > warns on shared ports. But there should be a single sub-schema for
> > validating phylink bindings, whatever port kind it is.
> 
> Hmm, like writing phylink.yaml and then referring to it under the port
> pattern node? This could prevent a lot of repetition.
> 
> Arınç

Yes, that would sound good.
