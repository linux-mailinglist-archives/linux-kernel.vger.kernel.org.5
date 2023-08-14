Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9926E77B3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjHNIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjHNIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:20:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C959EE4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so37446525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001202; x=1692606002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOhZF7S2DEx7MhxKavLsQLjZHhmWbqh7NuoRDJKNBTY=;
        b=XDhYqIuSK5EX/3HgIE9f+NFoudhk+4NBOG8870h11dNzpBDUOBridTh4zSrFIW0fx7
         A/xqx4y16iUSwoX3uYPF7lImfZCpHMwhaGCGkOSJeKmlYHw1nE4eNxyTdfknJkNFzzSq
         jXFuvy1jTTtOz1zNW1HqD3f38oel3rn/4WSLXl5xoj9AkxPwOeMzYimjb5PT9tdDlXFn
         4aZrPgEZSf8H6x2tcDcUUv4KBwZ+xcxNcgnMGaKFyjygufjmSYoRUGYLQomuzdNUBzjA
         Yh/m+Q0Zesk8z2p/JmvIEbGn24h06NASIEY55C59jSj5MU/fZtecsz7UQ6rxhJUCAqUt
         iMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001202; x=1692606002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOhZF7S2DEx7MhxKavLsQLjZHhmWbqh7NuoRDJKNBTY=;
        b=jYvI0blGK2beUOqbeEhPd2ZgE+QBjj734I/VLpihr+/IRRYlEjojT+XsUvJd46fk+I
         P7rrSTU4oJLSPiXGfBWZIhdpdy3Grt+PxuOEDlmTvtC5SI2SUBehodn7PV6adflGD/RE
         9iOGUGVWImm921llkw/oQO9/svBsA4JWA7E53IM2C8Ta47PHtWsV3NXt9fqSYtyWrRp2
         iKEZwZLS5L0YHoDSQ3guxoTESoyL6eSt98JR4g59c3t8dN74gPekZw0y+WVj11x3sFei
         4mnKApiViiTqRdSkTZlp1iuskaZgAnthvVhzqQNFKr849xKWUjuqkvh6z7IcVFOeeEvr
         I8yg==
X-Gm-Message-State: AOJu0Yx4PIqXC3jx5uhwyvO/2mh7Z6DaaqBVQSkK812igrHFjEN/HOAv
        K38x1oJLfbUW6WV/TJOBG/UU8A==
X-Google-Smtp-Source: AGHT+IGP5UO5fYq3iwVKUitezCVv4EUFlANCy8dLLXHKmY42St+nrJ2AbN/HVyqIBzipX+sx40KW+Q==
X-Received: by 2002:a5d:5183:0:b0:315:9e1b:4ea6 with SMTP id k3-20020a5d5183000000b003159e1b4ea6mr6404183wrv.58.1692001202425;
        Mon, 14 Aug 2023 01:20:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b003143ba62cf4sm13661259wrw.86.2023.08.14.01.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:20:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 14 Aug 2023 10:19:52 +0200
Subject: [PATCH v3 1/3] irqchip: irq-versatile-fpga: remove obsolete oxnas
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-1-e2ba579a49d3@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xrcvmb4OrJIxT9W4K4DYvx35BanxWgzznHWlkuqpl9U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eOvJ5Z8nxWDyXp/OFOosHrXRpttxDRuSo7frD/Z
 h0xDFyCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNnjrwAKCRB33NvayMhJ0c96D/
 9C/caIIUSYf+PlQlUQOiUDxI6siJ4QFbW3SVBUYEoqb8KcuNwfwBWxlNDeceIUIAdunfReXzrC9LvF
 5InVjX1zHa17f81p0aW/D262dkyvlTFtAAb/ZLqg6zsOBpj4GsIZHQrGWVYKLl1mpdiPrbyahskJNl
 DGr5E3mRjyEPTgKgTH8+JgstuGzd+5P1tWHmO0i3GJRrBLZF00va9lIlRv6dRKoAH2TW6sm6jde+r/
 ldXT2cKq03Xjl09cWvP/m9YYY7Vj4zkor3qhKCa+mxRnGQiHtqJVVkA04po305eyhCtfieS/uswZa/
 /2tEr0UqgvNwJ8AimIJCW/xzPuvp8c6tRMc69J4sqNwmqzBSW/ktytKjcsJMYKa9oLuFQ7sz4EJgdD
 w2rAuTVXj2TUWXghCcMFTra2elFVYEU8tVKm3qxEY7Ph0H8DoFpUyOGO2sWdS9ok/oG6ptYEYriI9o
 wrPkiEBUhTa/j4CGhdvyI0awLq5SFgIFgHsEAyL3bwO7zGepJfiP1NljmkI8QJcjTWW423yZdlso3o
 h/cimFD+Hir9k2J+DGragMHWSDZuMSTGC360csFZRd0uKzaLdTX7Dk/CPcGvWXuAw5VKqbVkgwyo9Z
 aQ2yxNp7orkJk7B4T/KPwPXkUc+60tRf95I6MhDTkVdOdrX3pY1GKKovTyaw==
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

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 IRQ controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/irqchip/irq-versatile-fpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index ba543ed9c154..5018a06060e6 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -242,5 +242,4 @@ static int __init fpga_irq_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
 IRQCHIP_DECLARE(arm_fpga_sic, "arm,versatile-sic", fpga_irq_of_init);
-IRQCHIP_DECLARE(ox810se_rps, "oxsemi,ox810se-rps-irq", fpga_irq_of_init);
 #endif

-- 
2.34.1

