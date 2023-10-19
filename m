Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB77D0016
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjJSQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjJSQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:57:40 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA4130;
        Thu, 19 Oct 2023 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1697734656; bh=Fj8aJKU7DWLRGOAkmo8ksuB3I0hdR2JFWf7TkxgKTuQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YB65RgKyqjDKlUsn3OmxI+sCijdwMf+Z5XzUdSA02/1I6dRZWqBSW5Oqa234RjJvo
         sg3bAliq45Lyt38aO2r6vLX3LLB3Nzo1lhm1IPevcxWU8EGiMO05AlQWJGR2bXBusV
         RcCwT4dwj9kXO8Etay+noUvbG5U9sxIbDhk3n0io=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 2/4] dt-bindings: mfd: rk806: Allow system-power-controller property
Date:   Thu, 19 Oct 2023 18:57:24 +0200
Message-ID: <20231019165732.3818789-3-megi@xff.cz>
In-Reply-To: <20231019165732.3818789-1-megi@xff.cz>
References: <20231019165732.3818789-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Declare support for this property.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
index cf2500f2e9a0..3c2b06629b75 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
@@ -29,6 +29,8 @@ properties:
   '#gpio-cells':
     const: 2
 
+  system-power-controller: true
+
   vcc1-supply:
     description:
       The input supply for dcdc-reg1.
-- 
2.42.0

