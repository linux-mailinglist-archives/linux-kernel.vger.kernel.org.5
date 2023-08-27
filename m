Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7494E789C20
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjH0IaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjH0I3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:29:51 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376A11B;
        Sun, 27 Aug 2023 01:29:48 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so288494466b.3;
        Sun, 27 Aug 2023 01:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693124987; x=1693729787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGz6g/mmAoLvV1y0UfNZXG+WHctT9zF9GzJjlAsRgRQ=;
        b=GqhFqdhbNWx3q9N7YkBwjznW/nKlnizZ1Bav/Rq+UURHQH2p+L9h5jp+Eu8JBk4Iey
         Vl4GRvwCzeL6sNmk+FRrRQHRXRUDI+PmnGBh9fZCdJHxqOxHBOnbdDOMBqnrSH9f5g9I
         gnwD/E0evHyqGsPI2byEw7xqJGjIQBPugXV6NZdlr43YoA0TAyemxbtCRgvs+MfmIsgy
         WZlmZl1lNAaq3gNu+PUgN8qX+4b/fvyG1ZsOYjo6Zdg/vwKnrR/PCSmo6oKw+1I4Amyc
         eT1g2MnHdAeuoHXCbqzXZrsgfPmGoPUPp+634nYnsP07ombh4X3A8mEnKwKNwj0MokrY
         dlFg==
X-Gm-Message-State: AOJu0YwfLV1gbELFxWfPKqmoRHzw4xUIkB9GSL73E8aiksp7e6BjVJqw
        9AuWThU29K8ttGDurKjNnM8=
X-Google-Smtp-Source: AGHT+IEzVaNmHJYY+TLWlWVjbbdc4h/PHWeeLFvgs71G0UHGzhtRlne2tpflEwrzklczAK9k5I5rlg==
X-Received: by 2002:a17:906:73c7:b0:9a1:e758:fc70 with SMTP id n7-20020a17090673c700b009a1e758fc70mr7956512ejl.77.1693124986949;
        Sun, 27 Aug 2023 01:29:46 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906840d00b00992665694f7sm3144793ejx.107.2023.08.27.01.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 01:29:46 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, Lucas Tanure <tanure@linux.com>
Subject: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7 SoC"
Date:   Sun, 27 Aug 2023 09:29:44 +0100
Message-ID: <20230827082944.5100-1-tanure@linux.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
Since V1:
- add Signed-off-by:

 drivers/tty/serial/meson_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index c4f61d82fb727..790d910dafa5d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
-OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
-		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
 #else
-- 
2.42.0

