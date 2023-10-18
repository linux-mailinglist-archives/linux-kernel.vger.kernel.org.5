Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762B7CDA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJRLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:37:24 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDA111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:37:22 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a87ac9d245so39628347b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629042; x=1698233842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibBJyoflxMS2afxFGqsv5c5GwukKSXqA1+zh4x2as+k=;
        b=q2lLG2lw8LkDsY/Fcj+qsMhuRDPN30MnTc6ddL82FBkdpEdyxTO4PwArBProNwvQtI
         +fc3FHXUgjaej4mUJLCnu4N585chfulmBWStl9EsHShSPYBWn12H+t6ww4iV4rcIPOEm
         eoM0abM+Y8ep7Uz47kZuBSFtq/6Ewd6Vk0/h/wYWplmFBrI32qMNYsGKsc1BFO6eqUph
         HLLBZbrDSa+yFgW4Fx+MG4yjmcYrR/osRuEWbZTRvn8rsuW2X6N4fAdHqZHEltD2SN2P
         150+rY5UVnzX2M/pAY+EJVkyavc3WSxk/rsqyPt5ouB4qsTi296AgTgVl6al03/WI7Sn
         og1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629042; x=1698233842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibBJyoflxMS2afxFGqsv5c5GwukKSXqA1+zh4x2as+k=;
        b=Biyx/WYxU2WVvcvfLTezOd0iE9qPwtrprTDmKE5Ch9T0+grIM7rG/3rkwRYPjivF2p
         mIhu8ogwfEU/EvFpTt4PmBpz/C+S1OfxcMC1tzL897NLUSc0NaDssnJJYwgKY20MI1Uv
         zH6kmZHieZC/FSh1FismSW852GjPyMX2yQmsLJSdu8ygG/goHJReocz+e3YYV/HlD1Yb
         ptugZoixl9b1V3MqUs3NVuYiuWhEWOIsa4hSPZOGXxSbQs0Qg/EvaSr1d6dZHZCT96uu
         ElyjgCYu/y8aqoc92EuBHlpd+E6xgGigUOEk1c6K4Tg55vfysW+CXsukxbkvg1fwDDvn
         /Q9w==
X-Gm-Message-State: AOJu0YzhrxygUp6nilP9lFoAU7KD/ddLgsLY8HPcIc4s7leZVB8lTM5m
        ZhSRlJ5kE1OiDFv8hxkIDK7O4jw8grNu0KM5/fSKDA==
X-Google-Smtp-Source: AGHT+IE75mXYYgUQv5l73Vl5L22dr+4CYg+Lk4Ei4q1AvQqBIy5FH+CDcNjtjq5F7t62tXm4y3QBwhP/N0B5gX/8qPo=
X-Received: by 2002:a81:6dca:0:b0:5a7:a874:d83e with SMTP id
 i193-20020a816dca000000b005a7a874d83emr4891684ywc.42.1697629041772; Wed, 18
 Oct 2023 04:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org> <169762516741.391849.18342287891015837205.robh@kernel.org>
In-Reply-To: <169762516741.391849.18342287891015837205.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 13:37:10 +0200
Message-ID: <CACRpkdZff9fbeJdxqudCtjad=FVKTKQtvo_=GiEBOvnw5xQapw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/7] dt-bindings: net: mvusb: Fix up DSA example
To:     Rob Herring <robh@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example=
-0/usb/mdio@1/ethernet-switch@0: failed to match any schema with compatible=
: ['marvell,mv88e6190']

Isn't that just because the bindings now come last in the series.
Which is in response to a review comment, hence this warning
didn't appear before.

Yours,
Linus Walleij
