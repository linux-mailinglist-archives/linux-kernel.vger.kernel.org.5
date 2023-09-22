Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1D7AAFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjIVKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIVKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:59 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D485CD7;
        Fri, 22 Sep 2023 03:42:51 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6859F71B;
        Fri, 22 Sep 2023 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1695379370;
        bh=38Kbb7gGkyqodA4KPBC9VNUY13Zo33fOgrid7RcPgZk=;
        h=From:To:Cc:Subject:Date:From;
        b=HYc56Al+GgE8ZqC0VehhO511PydhQ4g4f5KY6ViILEw0QgrT2tblOlRIzu0eUZHGa
         7fraUyodeYrjrGDHc6K/tF7pQyj6TifG6UbfnIi3QllNLMaCNKGia/7HQAtQrmuYF4
         0/JyPoFfJ92u+7u5RNG7qbRzDTYPrlEOouyh66Oo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] watchdog: aspeed: Add aspeed,reset-mask property
Date:   Fri, 22 Sep 2023 03:42:32 -0700
Message-ID: <20230922104231.1434-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
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

Hello,

These patches add a new aspeed,reset-mask DT property for the Aspeed
watchdog timer, which specifies exactly which peripherals should be
reset by the watchdog timer.

This series is a replacement for a patch I sent earlier [0], though
using an entirely different (DT-based) approach and hence not exactly
a v2.

I've tested these patches on ast2500 hardware and a qemu ast2600
model; test results on actual ast2600 hardware would be welcome.


Thanks,
Zev


[0] https://lore.kernel.org/linux-watchdog/20230922013542.29136-2-zev@bewilderbeest.net/

Zev Weiss (2):
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,reset-mask property
  watchdog: aspeed: Add support for aspeed,reset-mask DT property

 .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
 drivers/watchdog/aspeed_wdt.c                 | 11 +++
 include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h

-- 
2.40.0.5.gf6e3b97ba6d2.dirty

