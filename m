Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A187FC175
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbjK1Pfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346878AbjK1Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:35:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A279D1;
        Tue, 28 Nov 2023 07:35:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C40AFF806;
        Tue, 28 Nov 2023 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701185747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO0oeiUpyqbOgvAxbqOeRIw/9jHxJtwd/pdok3s36o8=;
        b=PlXSi2sBmzn0/PFbfGLe0lOa8p9Rp3u9AJp14hX9ZaxUcbYWXQHwR99gVR0d5OG+AnYAjJ
        pU/wiqt725xhZd/WqjkZ++yokakY9tCVqgiWC1DPsd3tVpwdMNTdGzyY/FWVAb5EK1eSTV
        tB0hnUuKJ0uz8LtoluRhvxjEKZDEEDMrZPJLNu3HfBVrWniDZpAOEn7V0MXVNEvH5Fv7iN
        PfuifIj2dsySSzzpgK0n71RpQCZMK7UrhKTL1a4e7+x8hq+BFIxJbw3JZYX4qnJJB38+8g
        so+dfnK8Dqt36J0fEkUoarRamwn3CQByBRkZ/8GlFyJYXjjXFtBO9qdJqUcQcg==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Tue, 28 Nov 2023 16:34:59 +0100
Subject: [PATCH 1/3] dt-bindings: pinctrl: pinctrl-single: add
 ti,j7200-padconf compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
        u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "ti,j7200-padconf" compatible to support suspend to ram on
j7200.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index 45a307d3ce16..c11495524dd2 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -31,6 +31,7 @@ properties:
               - ti,omap3-padconf
               - ti,omap4-padconf
               - ti,omap5-padconf
+              - ti,j7200-padconf
           - const: pinctrl-single
 
   reg:

-- 
2.39.2

