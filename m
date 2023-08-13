Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7C77AABD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHMTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHMTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:02:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF6170D;
        Sun, 13 Aug 2023 12:02:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so56808211fa.0;
        Sun, 13 Aug 2023 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953350; x=1692558150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1lGPqv1iSWWYndcdm44N796wnrwYOzK/z733GpYzNk=;
        b=XiCI7liiU5Y+icmm8yci6xws0x3WQYQEwyvgXGsqkFEoZx7tuJdWJKhN3GCN2DyUF1
         4IyL95YD3CQ7Nc7vyk3ts1qnnju0za83OWiz2xZ9cBAUwh2p0WxJfsRGBn86mZdIIkk/
         XKlYkVr4gc69NnL3g71JvPsJyYwL+sRPSOOf6bzSBHeV/k20hdWGtHz0q9y5lm9qGVuf
         WEiXmzXtI+RRyhBlNUfqIensHEEepUu8OeodNKmpWe6Cp42FvePmEUZjqKgiVm/9hMiT
         J8kNEbYVP+P920fy+cX1fSEVIX50IAO2+tGS2vKT4OPKmR4uux0tHK1FfjL+x/WtsxvU
         E9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953350; x=1692558150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1lGPqv1iSWWYndcdm44N796wnrwYOzK/z733GpYzNk=;
        b=bWB+vQDG56igrFVtd3JYAPSYii17qGztXwfnTVru/DNz7QuDnvKkNvQFT43pYmn0jB
         WM43Me1Cl75jERnnH4ODDXZ0mgPVMhzPJnkUHxkDLi1z/yzBOAJHGfVJiPqAquxlArds
         L1SHQpGIzvaCbuBBkQ/QDn5DXy9Wm19Pl0dliFHPTeBnkjVhbtJVdI+ltmbEw+NRGsvJ
         +cObC8aGG3zAxnxoG61cxQIJw8JChrP1gsuGKuCxEp4KWUHBcYXPqv3lSvkY1PWGFH7x
         G/bJpHzrtB3dSoOGPXXq92TtVKP7I9iNMP1IxlHMRd3KMCLcxLKst2XjHTUtdo/qK+/w
         GAVQ==
X-Gm-Message-State: AOJu0YxIOsHMzJTO7hAXK9IKUENjx+wXI+PqJguAQ5i4MGZx/bK9YKts
        j5cXcY7IZgCke3L5HMqXnjM=
X-Google-Smtp-Source: AGHT+IGrieknj/tH+gn9lVfd6xWvlDTto2rG2CojERZaieo4pEES6TqmKcjZxrDymguLVX6hXVZy3Q==
X-Received: by 2002:ac2:4d84:0:b0:4fa:21d4:b3ca with SMTP id g4-20020ac24d84000000b004fa21d4b3camr4649958lfe.2.1691953350032;
        Sun, 13 Aug 2023 12:02:30 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0052567e6586bsm209432eds.38.2023.08.13.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:02:29 -0700 (PDT)
Date:   Sun, 13 Aug 2023 22:02:27 +0300
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
Message-ID: <20230813190227.6k2qyxfewbkmatn6@skbuf>
References: <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <891c0b67-abe1-416c-aa94-675f7f3d8044@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <891c0b67-abe1-416c-aa94-675f7f3d8044@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 05:58:57PM +0300, Arınç ÜNAL wrote:
> On top of this, I'd argue to document the internal MDIO bus on the
> ethernet-switch.yaml schema instead.

Why?
