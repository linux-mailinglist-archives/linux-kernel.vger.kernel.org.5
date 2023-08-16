Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBD77E15C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbjHPMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbjHPMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:20:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41626A9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317c3ac7339so5505878f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692188436; x=1692793236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLh/negnTwluibo6jtiJjzohUikGXUShD/K+FOySKiw=;
        b=Anx1XYN13rdyuN8+XOJB7ld+3JrSxDVieeevuFr/sOI8VfnZDbBxoTSbMYiqjri658
         hrhj4P5rBe9r3hFu/kZpTJmkTmD9YTiPMMmx+KLvydZaK1EZ/GycMZaAG0Uv6LTT6rx2
         2JctPaAxa9hGxxHYduZCFckSmo5CpX+nHbX7qNtoa/mK5ITB+KfRuV3D29PSXniK1VzR
         eZhYdgznJJKo3xWhk1BjBjMFDJEpYR7paW65YqVpYX1ROIyqi+OysAoFXYoC4dY0bRMg
         E8FoIqnvwyAhwQhH/TTtfHRqpj3H18CUU/fyfjpcXMi+uvPf+2X/4GkHlUhnf0OgHsbW
         X2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188436; x=1692793236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLh/negnTwluibo6jtiJjzohUikGXUShD/K+FOySKiw=;
        b=dzQ1vUHcgYv4L4o6tLnWeo9JblO5TB1oCzCrmujOb/VVdJV8YJQ2LNI6ZMoAyrglgd
         B26SeCBaidDt6Fz7eVG0YgxT+RfhvrAvgE8YOkO745YBbagmCKufc1ILJ4Z7Wv0dbVtP
         ZuSiKre8c9uhu8xz9SLSAVTYXNOI70AOmsim628+9A3WiveSE3hJwLN/PzOWzaKxuGoR
         uUDDnUdkF1Yk0dQkl3acDy+kZYBZjXUtz4Vn+QVYCQfRsw6Vc/KL8s6mSGlDK8CcuCnK
         wUZ0KicWJLji3tIrSYnE6GZYN9byDmzvHv24C8fyReQ6wGDCd9pNj8OYauFsdToRpkEP
         cD+A==
X-Gm-Message-State: AOJu0Ywtg39NG+oSMx+4SMQqGc/aAOM/kEwtHXT3+v2czbawwqkA1x1N
        7IxvgwZUHh1KtazmzafGdO7diQ==
X-Google-Smtp-Source: AGHT+IGhOLt0CZddayDndy/iUcglJyQGtRzjOPAvpFHUqMQzctkcdACIYHjlED9Y/3MOvvQsUDDqjA==
X-Received: by 2002:a5d:55c7:0:b0:315:ad1a:5abc with SMTP id i7-20020a5d55c7000000b00315ad1a5abcmr1612887wrw.5.1692188435603;
        Wed, 16 Aug 2023 05:20:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:55ba:c083:817:86f])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b003196b1bb528sm14566112wrr.64.2023.08.16.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:20:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes down
Date:   Wed, 16 Aug 2023 14:20:27 +0200
Message-Id: <20230816122032.15548-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Wake up all three wake queues (the one associated with the character
device file, the one for V1 line events and the V2 line request one)
when the underlying GPIO device is unregistered. This way we won't get
stuck in poll() after the chip is gone as user-space will be forced to
go back into a new system call and will see that gdev->chip is NULL.

Bartosz Golaszewski (5):
  gpio: cdev: ignore notifications other than line status changes
  gpio: cdev: rename the notifier block and notify callback
  gpio: cdev: wake up chardev poll() on device unbind
  gpio: cdev: wake up linereq poll() on device unbind
  gpio: cdev: wake up lineevent poll() on device unbind

 drivers/gpio/gpiolib-cdev.c | 127 +++++++++++++++++++++++++++++-------
 drivers/gpio/gpiolib.h      |   3 +-
 2 files changed, 105 insertions(+), 25 deletions(-)

-- 
2.39.2

