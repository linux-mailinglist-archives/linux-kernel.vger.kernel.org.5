Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24B77CD21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjHONFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbjHONF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:05:27 -0400
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 06:05:25 PDT
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247110C0;
        Tue, 15 Aug 2023 06:05:23 -0700 (PDT)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by forward200b.mail.yandex.net (Yandex) with ESMTP id 5C0046D3D9;
        Tue, 15 Aug 2023 15:59:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:17a3:0:640:53a6:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 900576008A;
        Tue, 15 Aug 2023 15:59:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3xeYJg5Wma60-NJiIOuGT;
        Tue, 15 Aug 2023 15:59:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692104354;
        bh=qVobqAw1ejIeOmOQL3G2D1I+HOKk97SjxD2o3Soufo4=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=TzaQnxGslyFELK2A8isOQFJlRqsl1BMGBTYnSU9v2DDDFD+92kQZDxyVdL9oZVBuf
         m/JUeBf8nCsX1joutmBJtUrbIDTY9zut9nzcI/IuVYpTG8HCr8PdxtEYF+Tt6rCt3i
         snm5h3JLrGSoZsGzcmZh6xQ/rguVG4YniWUOgpfg=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com,
        Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: Add Orange Pi 5 board
Date:   Tue, 15 Aug 2023 15:58:59 +0300
Message-ID: <cdb5f1d686425e7dcb953c83749153f9321f9afc.1692102057.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692102057.git.efectn@6tel.net>
References: <cover.1692102057.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Orange Pi 5 SBC from Xunlong.

Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ca5389862887..b9649e27bc82 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -877,6 +877,11 @@ properties:
               - xunlong,orangepi-r1-plus-lts
           - const: rockchip,rk3328
 
+      - description: Xunlong Orange Pi 5
+        items:
+          - const: xunlong,orangepi-5
+          - const: rockchip,rk3588s
+
       - description: Zkmagic A95X Z2
         items:
           - const: zkmagic,a95x-z2
-- 
2.41.0

