Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2047774A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHJJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:34:38 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C7D1;
        Thu, 10 Aug 2023 02:34:36 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 13E3CB9C;
        Thu, 10 Aug 2023 11:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691660073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9NORYv7GsgVGBwuongI0N6VrNpMdvWeZymZVRNfEng0=;
        b=Jg65Wu56tvPxDeeAy0R4OSJehvZupSKx5kOmDt2tH+BuFsi/S+btG9MfmFbGQSnp9hqGRL
        U7UDctFkGOG4AMNaui1JtiRBNwwhH5Vu8wN+f4BQ/TK5H3WEEr/GSAMRxBFWvSDpeqdRHx
        O1V/LWp8C8KT0kQEggXOt8EWOo3kQgLpxZVn5c1DiPVJFlVo3hYVk//nUmhgECZtLbS01S
        QWMDkkb+WrTWX3Zogval3cmikoxiC49Lb+hsBP6yK9MfhVHjS0QkWTh7ewAEaQDwMLvVIS
        5xIbNIzLLj6nDUdYgbNycMlfmOTbys4USkQjw0grmjv8FNCtVI2jKeMrBpQpKA==
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc
Subject: [PATCH] MAINTAINERS: add content regex for gpio-regmap
Date:   Thu, 10 Aug 2023 11:34:14 +0200
Message-Id: <20230810093414.2398217-1-michael@walle.cc>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a glob to get patches of the users of gpio-regmap, too.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20a0f7411efd..907f39825733 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8868,6 +8868,7 @@ R:	Michael Walle <michael@walle.cc>
 S:	Maintained
 F:	drivers/gpio/gpio-regmap.c
 F:	include/linux/gpio/regmap.h
+K:	(devm_)?gpio_regmap_(un)?register
 
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
-- 
2.39.2

