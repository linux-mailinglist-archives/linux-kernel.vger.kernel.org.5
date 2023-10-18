Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA597CDA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJRLMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:12:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967910F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:11:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c93507d5so79653187b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697627518; x=1698232318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO/PDoCfvCIQp8CUhsVVtzA3USwqbfuZSWYXmX0vX4k=;
        b=NdUqHgThFaSS6CRiu320pMsNt8v76A9IMR56kWxn6XxfWZKQlYBE/3cmIhmnFqZa/M
         76MExfEnETGwcB0CZMzHlF5OPx3aQBSFLiJP+hOd0CIZF33/zVS5lKNLUOxTFUA5EBnL
         /ZJTdUdPa48bUvCxCtNHV7/hGAzJqnFqHR6vu1kRYG1BENL1opSDfpxZo5uhOkMECEE8
         8s2bv87hCe7OQLzJ/OkGRvFh21oxtEpy72ipOzoysiIT4gU5JbkKqtiXJ/G1mv50K5IG
         3HTeD5c8JTRgA7DJWMQZYM6UKMfWKLPxA7VhRqhz6ZL6ktiJA6REv+W3b7J55MyBuYLD
         rS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627518; x=1698232318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO/PDoCfvCIQp8CUhsVVtzA3USwqbfuZSWYXmX0vX4k=;
        b=tGJTJj1WsFlsNOZA7ex37BhvxMB14cdMXzfTfE8s+6hGaFZzk8Mj12s8ky/9458xkS
         b+SvllWXWjaXwHwQY7RB0LP7gZ4HRXHEJxj4elw7QfJJlJ25MSkGEHt+LsKQ+OMS9JTl
         p2HiAScCCWLEaGHNt+M/0hXNmSmStDwrdL3KUTPsr+bBa2rOt3mTUPPeHyiX8oRkYOzA
         ErQpzHBr5ZUizvO7MS7kyI3QMUpX2OoZKI4RkkgchmpI/duwmsg3RS//He/FlW6iWr8D
         q13+0WFuLiErF4Jnaz4erdI195f7g+Z8YmDJWHfyg+vt+P86JspmdoOvmVFIm5NIE7EI
         KLfQ==
X-Gm-Message-State: AOJu0YwdTCslxBbvI9i4zpS9RpO0tt2VeRzxHyGm5ipkmzykrzV54tW1
        bKuz2M9WOKZIblwmeBRHonSMucKJI2sOaNszYeP6+Q==
X-Google-Smtp-Source: AGHT+IGTZPUv5/Bw0Oc83FUy4A9roYHlmtR56tiA4w8g5dxVWLG7VhIBIjSwO1UMnGprrSPG2GfXojIrtvGv8qyCwVA=
X-Received: by 2002:a81:a214:0:b0:5a8:19b0:513f with SMTP id
 w20-20020a81a214000000b005a819b0513fmr5479705ywg.14.1697627517806; Wed, 18
 Oct 2023 04:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org> <169762516670.391804.7528295251386913602.robh@kernel.org>
In-Reply-To: <169762516670.391804.7528295251386913602.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 13:11:45 +0200
Message-ID: <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Rob Herring <robh@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:

> > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > a DSA switch node need to have a ports or ethernet-ports
> > subnode, and that is actually required, so add requirements
> > using oneOf.
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)

Really?

+  oneOf:
+    - required:
+      - ports
+    - required:
+      - ethernet-ports

Two spaces after the oneOf, 2 spaces after a required as usual.
I don't get it.

Yours,
Linus Walleij
