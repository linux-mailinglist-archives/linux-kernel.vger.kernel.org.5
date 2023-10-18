Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528747CE0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjJRPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJRPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:17:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55345EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:17:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227A5C433C8;
        Wed, 18 Oct 2023 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642220;
        bh=h3p1Fgw5s66YZXzFyyzsdTutBTpnztoMsycATj7QWJc=;
        h=From:To:Cc:Subject:Date:From;
        b=KkACMXt9SXHbr8xJ35K5NJ7gmujYnG98pC583tri3SyZ9RbIZm0Wq+5MILfnrtt2o
         GTiBhK4T7LOBuDQCtwEFLHDk0nzXzqL33NfIkfVIQy6RXneLj3ZdK2paZxqIcxfHz/
         uNT5dKCvPTLkMXC3R7HQ0ytAyyRkTOVTjSzhx4OMyByuTvq88MkEkuovqN1AN+58ju
         gzmyzSU6wxMF4Rb+2qzTKijpkQbmUA2EMB48R/eqF6HNZOo9Y6CINTMErYqCH7Pkun
         kaTqkggFJLpPdDkpSLb3jGseeaFfN2LdKAm8/plBU8Pz54AP2xEl2q3SPNjZXpqLqa
         jDPWxkyK/9Ung==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: usb: vialab,vl817: remove reset-gpios from required list
Date:   Wed, 18 Oct 2023 23:04:48 +0800
Message-Id: <20231018150448.1980-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "reset-gpios" is optional in real case, for example reset pin is
is hard wired to "high". And this fact is also reflected by the
devm_gpio_get_optional() calling in driver code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

since v1:
 - remove th1520 usb dt-binding part, this isn't related.

 Documentation/devicetree/bindings/usb/vialab,vl817.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 76db9071b352..c815010ba9c2 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -37,7 +37,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - vdd-supply
   - peer-hub
 
-- 
2.40.1

