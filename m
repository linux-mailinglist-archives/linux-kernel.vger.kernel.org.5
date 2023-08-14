Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54077B3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjHNIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjHNIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:20:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B29AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so3492568f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001201; x=1692606001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esPHR8O6X5bh9IoLHOiOHIU3krlV6rNwOrRUOA+gIUo=;
        b=QdyRM+tSjIUNtVGG3bdjEietP8Q2d1h3KJuEHViTr4USevxwefNxmxfgjWp+Fqi4m+
         GJpixORRA94GzU5axi/iYDFVzlFBizCg/1nfFWeEGT0MP11vdKtdA91uuyIB2+PLtaWh
         d9wqLtply0g2s5GIEGXzSVx5wa3jwKlh/ssjiq2d4w50GRf7IonlF/qpqOwP2/t1DCZk
         AXXPs8jD0++owPBFfZ4Pxg3ymrExTABb5jWa8tq557dZw/rJZjsWRY5//tbvQ1h9+srP
         XQH18q/5zB5pcP9D0DPSLGZ2X/FCUZXJMJv65ixmOm6H1Ke9B50G2/YFap2kvrubKTtd
         /rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001201; x=1692606001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esPHR8O6X5bh9IoLHOiOHIU3krlV6rNwOrRUOA+gIUo=;
        b=N1/O9wjmwr7O+NgQ0ov0FnyUUtEQ2MbYu4IJNfIP2MWwTuR/f3J9zQSJ9EgApoO2rU
         QN8jdHeD0znFdY8JS3FPxCkOGNjNQfbIUTFhdIlA+i5DjDw20bHielJLwPCSut3SntCt
         OhNVIxMrl1j3N74gL6DfFUTKlssKqRzIausB7NKnNHDu9O2XTpWn46s2+e7MhpwuJviV
         EJ0PWglQgbcPI3J0L2hRR1akc2/8Kat8r9NgfZlzGuHs2XgGoG7YBblVl1Egw2IKuw/e
         2p5aXKpL3uEU0hCYlblm9NTbpkYJJuenCB0BKrfFGBWIELj56dP3/DmYxm2+33L2RP6T
         qqHw==
X-Gm-Message-State: AOJu0YzLZZSfV9QsuiDL0SY0NBUzNP288rBRuKepfgix/Yccu7XaofIZ
        E8uXqN4SKFl2IduPpQcq4IcRTA==
X-Google-Smtp-Source: AGHT+IEgmRsds34cslKDbyzCn7RIbp/IVD36Gq4bcl6RY6FcYmeCaeZR6THT0cmNsrr98F8PwaJJvA==
X-Received: by 2002:a5d:525b:0:b0:314:1a09:6e71 with SMTP id k27-20020a5d525b000000b003141a096e71mr6992068wrc.53.1692001201484;
        Mon, 14 Aug 2023 01:20:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b003143ba62cf4sm13661259wrw.86.2023.08.14.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:20:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] ARM: oxnas support removal
Date:   Mon, 14 Aug 2023 10:19:51 +0200
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfj2WQC/43OwQ7CIBAE0F8xnF1TIFbryf8wHpayWJIWmqUSj
 em/S3sxXozHmcObeYlE7CmJ0+YlmLJPPoYS9HYj2g7DjcDbkoWqlK60ljDF0bcQHwET3Mc0MeE
 ATEPMBFgramxTOyISRTCYCAxjaLtihHvfl3Jkcv6xTl6uJXc+TZGf64Msl/a/sSyhgr2x+6Oz0
 lrpzr0PyHEX+SYWOKsPVuvqN6YK5kyNRlvC46H9wuZ5fgMPKRwuKQEAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Andy Shevchenko <andy@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BV4eCveGpLmDCBGhcN3GoiI5PrQx89zH76D6FcS4Be0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eOuqaVY1uku6v+pz5LuDuN5iAslAyooWobVLTOr
 tZzgElGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNnjrgAKCRB33NvayMhJ0ZHaD/
 9gVyNvGWHyD2raAARWC5plh8EM5pfDj1qNzgaIRKz6CbVcEvw2brHkhAGGpK+gpmKVTRt+WCidx3la
 4GHMEDOBYbg66XJCbAUTuEcNxz63tmbD+1ZIuI9w1G3W6NAPb92w8ZNRZyK699YQdzJ0Hks0fWrmGz
 yq7Qy5iJVFo3AjKqbp7RAWrhJsqYqEHp79DXlygA9gwzZdgNDw0TyawPi7Qxm21pzWDly4nf7AQcoG
 wwjSzV+s7pVvkljNECGghf8Tx/5Ej50/ZhDPu0Xo/ge0RQlKqY3gUDUnCrMqh0T1zCSFQTH4xph3JY
 9kDCva0LLx32A3VWsXnEQ3Anpq5oAjbk5koTTlzIaaw8wUPXXzZFok5BStUD1z1Y//Be9kxHZy8cgi
 dmFpR8Vdk9x1F3iiSTvGJTLYHsEbmRbE75zRbXSTKSW7d4EYuv99A8t71u6yimKdZLxbzeOhe28PoQ
 fqCJ9AF8ZBJSm21rKhi0QE4UjS3L8FlrCHJEUVntiX6qhV91RRJH8rqqU7POv2epBBmI36SFGyoXLX
 IDgLQvoy8JvIuB/IlLkZ8mgHZf+K7XetdUJ/pK8ImTvWpMEC3IWG5s2pJpIsAE9H1gCobXVIBl8nFc
 KpiHd3CZ/37k1+q4gUbF5+iQO3Fzx/0/20o5z//R3ZqnRaTOUcznU8Fd1RQQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With [1] removing MPCore SMP support, this makes the OX820 barely usable,
associated with a clear lack of maintainance, development and migration to
dt-schema it's clear that Linux support for OX810 and OX820 should be removed.

In addition, the OX810 hasn't been booted for years and isn't even present
in an ARM config file.

For the OX820, lack of USB and SATA support makes the platform not usable
in the current Linux support and relies on off-tree drivers hacked from the
vendor (defunct for years) sources.

The last users are in the OpenWRT distribution, and today's removal means
support will still be in stable 6.1 LTS kernel until end of 2026.

If someone wants to take over the development even with lack of SMP, I'll
be happy to hand off maintainance.

It has been a fun time adding support for this architecture, but it's time
to get over!

I'll send the remaining patches in a final PR.

---
Changes in v3:
- Removed applied patches
- Moved net & pinctrl to a separate patchset
- Added Andy's tags
- Link to v2: https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org

Changes in v2:
- s/maintainance/maintenance/
- added acked/review tags
- dropped already applied patches
- drop RFC
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (3):
      irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
      dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark oxnas compatible as deprecated
      MAINTAINERS: remove OXNAS entry

 .../bindings/interrupt-controller/arm,versatile-fpga-irq.txt   |  4 +++-
 MAINTAINERS                                                    | 10 ----------
 drivers/irqchip/irq-versatile-fpga.c                           |  1 -
 3 files changed, 3 insertions(+), 12 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

