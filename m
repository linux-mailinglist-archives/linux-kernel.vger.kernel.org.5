Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD07F84CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjKXTiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346041AbjKXTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:38:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C30F98
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:38:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65471so16601825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700854702; x=1701459502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo29Pg6VNXcoZW2fzTe3Exl4UruvYkYsRFBRPzTu39Q=;
        b=Ux+2bQwCt6O3XZb+roPLnnpioroTIGqzNBkZVJ/dbl1IIv5fQTWg+tBIpBuealOs+4
         3jWxmcWADfpQ9a2l1/MkW/F92BSwbOk3QFW8w1Fm2J6+cSfcgsZ9kyWdxjpd1oZJ3sru
         ldebIBLFmaemjB0qgOS6sbxKoeC+Z23fWMVAidqIhMa/Ll0ArF8wV0ZxrXbp9dvcDtak
         Jz9Yiri+MH1SeHnBGilVlXDj6td+88CPp0GgWad37Vm3YTD7u4ubCayagVeVU3F8ttU0
         dFpnODiE3Ez8V7iZYC3A3mn4ZVG8iTTZ14OHyyiMJyDC54wtmprXMiQDLIicNgB1WqMj
         hYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854702; x=1701459502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oo29Pg6VNXcoZW2fzTe3Exl4UruvYkYsRFBRPzTu39Q=;
        b=Y9xZSp3o1jQylht0VfD2pHabvw5k9SEHR+lxjveio1ANXEHljoLT5pukMp544qkPnM
         fKZv5NIFiQaHRui2HZjgass07twh2R0Eb2D50+Q3esJiXSgDMzAv6YSzQDvOG2JI09Bl
         7VAzIZftVPTX/ebQf4dnJRY3GvaZ5uzO3cwPhXm6u2zjSzgb7LQ6qef7RY297F4wgdTd
         S6RdVVSumLLuQNL8O1TBLRffsyAQA0ArJzf2JRIcVRe43Gb0XAmsxO3oaiyIDVpSVA3B
         mjMhCrzYLh/2f5qmF7BzZvlkUthqL1abtqiUUMEporBdYBxKAdIjd3mlexMWHDez60x1
         1oMw==
X-Gm-Message-State: AOJu0YxrJAL1hldHv3XMCysvtFQEgFreC5SYmXb8JMhXqfxxhSb2j+KA
        N33eoqWEb0Y8noknDlGnPUtIgajXUYcZGXnMfwo=
X-Google-Smtp-Source: AGHT+IGfl+OyZpDfH2xQ9iX9WVmKJbwY+46/sluTw97DybZiS6lCSpXeGR3tYuA0CS+9zYqPo+CwoA==
X-Received: by 2002:a05:600c:1384:b0:409:19a0:d247 with SMTP id u4-20020a05600c138400b0040919a0d247mr3176861wmf.18.1700854701875;
        Fri, 24 Nov 2023 11:38:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e3fd:5fc1:c04:51df])
        by smtp.gmail.com with ESMTPSA id n28-20020a05600c3b9c00b0040772934b12sm6599320wms.7.2023.11.24.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 11:38:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: immutable branch between GPIO and pinctrl trees for v6.8-rc1
Date:   Fri, 24 Nov 2023 20:38:16 +0100
Message-Id: <20231124193816.30412-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the immutable branch for you to pull into the pinctrl tree that
provides the new gpio_device_get_label() getter.

Bart

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-device-get-label-for-v6.8-rc1

for you to fetch changes up to d1f7728259ef02ac20b7afb6e7eb5a9eb1696c25:

  gpiolib: provide gpio_device_get_label() (2023-11-24 20:27:37 +0100)

----------------------------------------------------------------
gpiolib: provide gpio_device_get_label()

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpiolib: provide gpio_device_get_label()

 drivers/gpio/gpiolib.c      | 14 ++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 15 insertions(+)
