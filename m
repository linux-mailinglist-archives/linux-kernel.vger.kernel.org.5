Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2B6751FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjGMLRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGMLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:17:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBD26AE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:17:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so4993235e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689247068; x=1691839068;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQg97wBXe3P0z07YZIHkWsGOthPp2ylFeuaEh8lcL5g=;
        b=fnT0JxbBGGoisk9+3XNkZZcv2SkvY8ojpQLL8pva71+onsqpaGXHZCsn7i2GLweYFl
         9hWiYrw/Ewjk7pN7/Q5hwbkTvrXVeCgpEx8J3oXbWljZqUkCGAKsyFQqygMikg04m1fF
         HgUD604I2qNi05XgZKtkc/j9dx+9YrXjRgGFlIay3w2t8ZeZghgJY4U6hMpzQvRy9aEU
         pFd6SdERn3qrw+qEe0NjSzxnPDGKR3nzV9EP8axpOz0aQio+chMOpTFEkvU36KgwV37o
         uqPYVo9RqPup0SGnN5xa4BZhhMvEhfjyispMYjYaPdLOG8gjoGPM5E1tCeNUjd/wd6Sp
         nEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247068; x=1691839068;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQg97wBXe3P0z07YZIHkWsGOthPp2ylFeuaEh8lcL5g=;
        b=T9FWgmeroG2kOFZd3w5OygvWIEK1nocfFHRTKlQUbtmpnswECaCZb1HHdSrjvxdyQR
         +uSrjEN+Ll5dKs98dxqO8nRTLPcnva3K7HGFosvW5ZrIuoqSji6Qvfap+gdl1paIFT2i
         cPzpfgTsA03xQLZqzVCf9OnaBPw8d9OymsGSpXuRZ/F+e1mgUFLFPy+E1BHLoUQ6Zlas
         JEOeO7B/fqrrNDBSyVcrAnRUny+NmMBbSlgbzkii/d6YOumAyuHBMsfdRdYRJNAlkrYo
         XYP+s9gIcyKZtYPGy5ZAvXV+YRtxyR3SyjiESPAlsPwiVXe/yyIuUmuLXuNmMhEYOlC0
         YsXg==
X-Gm-Message-State: ABy/qLaKGXzwJ+P6/GUbbRmDDrpqj/mfjHAPWMVEUe0/BoFIBHlaEv6X
        BiXLpBgYJsTMwrFdI/YlD0c7kg==
X-Google-Smtp-Source: APBJJlH87+cyagSht4LdOPuIJ+1dwMis7Qky9NEDILlxQd4l8J85GnFiCzPwZ/cdZ2oAsxEtwt50HA==
X-Received: by 2002:a5d:5966:0:b0:313:ebbf:3696 with SMTP id e38-20020a5d5966000000b00313ebbf3696mr1098202wri.46.1689247068442;
        Thu, 13 Jul 2023 04:17:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003fc17e8a1efsm7832235wmd.45.2023.07.13.04.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:17:48 -0700 (PDT)
Message-ID: <61ca392d-fbfb-2c1d-16ce-771193252e67@linaro.org>
Date:   Thu, 13 Jul 2023 13:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net-next 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 04:17, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-R or 10GBase-KR.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Beside that:
1. no underscores in property names.
2. Don't use syscon as an excuse for laziness. PLL is a clock, not syscon.

Best regards,
Krzysztof

