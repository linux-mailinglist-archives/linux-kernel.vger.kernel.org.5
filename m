Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB9751AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjGMICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjGMICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:02:12 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9933C30;
        Thu, 13 Jul 2023 01:00:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47F8AC000C;
        Thu, 13 Jul 2023 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0r7ogdmgCqQZyvfvesUVl72YF6nI4bT74X6FmO2pwNE=;
        b=Tt6DqdaTIvYJ03V43HEvPKPDFqzSMtWdMKUop9m5dy5BbdUosmCowZL7y+hm+tjpr6UA4F
        RSF6yw6aIowvCkb8PvT/ALygCJ3NxMH3pgtXwh/RAQ2Swq2lApbErshp8KEP9iHGXOmH7Q
        G/ZQ1/Y105arzbg/4xwndgPZ4HKmuEfoxp565iGu9EamAwMe5pFmvfoPiqcVS30msNY/hv
        li8GDHBRySKlEgbuz1c5g/UlXdZbC4BaSvhfE1BOuc7mJzKiiXNJAYzGjsX53i/Vj5yyF7
        TMtcUyZz8uJ9mW63iWmmzkX1oDqfn92lioTTvV9yjWo10SqjdPJzXtzQI7tojg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2 06/15] dt-bindings: mtd: oxnas-nand: remove obsolete bindings
Date:   Thu, 13 Jul 2023 09:59:05 +0200
Message-Id: <20230713075905.486684-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <20230630-topic-oxnas-upstream-remove-v2-6-fb6ab3dea87c@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b7c9b576b5f61fe4b8705bf419a1fb09541e4be8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-30 at 16:58:31 UTC, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> for OX810 and OX820 nand bindings.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
