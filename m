Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB11C7CA3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjJPJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJPJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:12:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DCDE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:12:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50325ce89e9so5512209e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447575; x=1698052375; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ8ecWrZiBw7tKD+R4W1tepO49kifDs5CDZYCV5hVF8=;
        b=x/DqVFu0XAlmpHk/tbtYegO91wxWWNucwPd1Ar+YDQSYKMdCxYwGgbJmnlD3I0n2on
         OonIDjG0FKLXaEt4drRddyggZl45oNzcjYj6/Vfu2xPD4Dd6nToiAqk15yafR8nshdUH
         gB4wPweiJYiUgHC6VPMmsl6XHP6O5LwSSjCo/GJd9n05TLPPqIb99w/TAjPSY07LMh0D
         2R57VFDAOSAjINmR1vKH2jwDu1K7sbfrYXeiHE6r99DKr5eX1p5QXXI8Oeu57dS4G9/C
         2RmzN6i08VgqBulXJYpjrebR0SOHuHpDDYHMGa4bNYHy0Lrz2DpZPb6HSOU/V30tR7s1
         0VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447575; x=1698052375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ8ecWrZiBw7tKD+R4W1tepO49kifDs5CDZYCV5hVF8=;
        b=IoKN2XKuJb+tEZ4H0PcOpviZ8hNIZhXoZfO1u+nEiyWM3AfGAy37eV5g4rjwWraZR9
         Md3LdSgNntwAoAeRM5Qyfzmy2feZ4IJTkmUoZRWLjGqAUEjM9EQUkZtnVYNvXNnPt97i
         UEMomsv3mhIEpNlUPibuNE5na1k1JrfEA2cTA/aaJLk0iC60BrbXlC40XTlVjlmrRX0U
         omG7PcmOhb6Fg+TMX58/I3+wGYeFdXK+pjB9mcoyJQLZ3xNuUpS7MAANAbUSmbMSGlT5
         ALsL4monQDi8yf3o6CUNdJZxggRQ9dRZ0WgDis4eemGWTqcJk6LylXXh5iMLZb5S0CJT
         yuPw==
X-Gm-Message-State: AOJu0YypJwLk1P7YZGj6/IMwzaHzbRkQ6sVDhTt0gayTEQidqDo9n1Sw
        kkNF0IPWNmoLlurMsh7RnGm7Cg==
X-Google-Smtp-Source: AGHT+IEyNwIV4lQLtApT9PUXRaVGf07GyDdtakoBSXy1ah0wDPOGkKQGeCoFWnPvGcaojFu4SR19dQ==
X-Received: by 2002:a05:6512:328f:b0:503:1c07:f7f9 with SMTP id p15-20020a056512328f00b005031c07f7f9mr24887142lfe.29.1697447575471;
        Mon, 16 Oct 2023 02:12:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:12:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v3 0/6] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date:   Mon, 16 Oct 2023 11:12:53 +0200
Message-Id: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJX+LGUC/3XNyw6CMBCF4Vchs7amFy7Fle9hXJR2gCZYTEsqh
 vDuNnWjC5Z/TuabDQJ6iwEuxQYeow12dinEqQA9KjcgsSY1cMoFo1SSh/IRp4lIiTWrOHkpRyY
 0qXUpuqY3vDeQrp8ee7tm+QYOF+JwXeCeltGGZfbv/DKyvH91Jg71yAgltGG8U20rq0ZfJ+uUn
 8+zHzIa+S9UHkM8QU2vFZVdLWXZ/kH7vn8AZKge/xIBAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows the path we could take with this, deprecating the
weird external bus thing.

I don't know what to do about the irq lines with a pointless
type flag that should be onecell:ed.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Some Device Tree fixes are included in the series, these
remove the major and most annoying warnings fallout noise:
some warnings remain, and these are of more serious nature,
such as missing phy-mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Fix up a related mvusb example in a different binding that
  the scripts were complaining about.
- Fix up the wording on internal vs external MDIO buses in the
  mv88e6xxx binding document.
- Remove pointless label and put the right rev-mii into the
  MV88E6060 schema.
- Link to v2: https://lore.kernel.org/r/20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org

Changes in v2:
- Break out a separate Marvell MV88E6060 binding file. I stand corrected.
- Drop the idea to rely on nodename mdio-external for the external
  MDIO bus, keep the compatible, drop patch for the driver.
- Fix more Marvell DT mistakes.
- Fix NXP DT mistakes in a separate patch.
- Fix Marvell ARM64 mistakes in a separate patch.
- Link to v1: https://lore.kernel.org/r/20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org

---
Linus Walleij (6):
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
      dt-bindings: net: mvusb: Fix up DSA example
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes

 .../bindings/net/dsa/marvell,mv88e6060.yaml        | 105 +++++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 243 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
 .../devicetree/bindings/net/marvell,mvusb.yaml     |   6 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |   2 -
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |   6 +-
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |   2 +-
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |   2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |   2 -
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |  16 +-
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   2 -
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |   2 -
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |   8 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |   4 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |   2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |   4 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |   4 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |  32 +--
 .../boot/dts/marvell/armada-7040-mochabin.dts      |   2 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |   2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |   6 +-
 24 files changed, 397 insertions(+), 171 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

