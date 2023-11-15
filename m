Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912E7EC90C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKOQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:50:08 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D2126
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:04 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso9390336d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067004; x=1700671804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aC5w+N5Heh6KPJfLTmPFbd48gQJyNdKHiN7BtvnhWX4=;
        b=IE6usIVbu/wLj2HfOCYgU6Y38K8qnbu6Ff5lfBZpWHUEfzDvn++xf+Gk4/tmyJZX8I
         vUjKrPk80iZ0mMKyISeIsPfLtEFj4naapo6pP/0D51bzVCxv21Tzyo7Qosvgwaj7Tiqu
         9DVS4RNTZmOmGOeOwco6hxtdVntxLu28fmC/ro5JmdE4IQ6pt/ERlzWDB0UUS9oBhL6i
         OI/EA8+I2pOEpkYwbD/uLD6N0lqtt0vR5hlJvhAwIfZkAhaOmdepp0NjXJ21C1KNdrhy
         KVc0MNeoYHqNolgfJkCaQlj8ZoBqn/KdbjBtunSlRShbw7w25UMx4rFcucRG0SeGZu48
         kJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067004; x=1700671804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC5w+N5Heh6KPJfLTmPFbd48gQJyNdKHiN7BtvnhWX4=;
        b=rYmF1C1Ox4cx60kxcwFu+YA5OR9ZtwlPnqpr/y1O4TlcF8MvSMbcvNIeT/n3FUkebn
         pTdRN0EJoCA3pZxGHMDu6KqSyAdmsitnSzw41Eu3XTkKZys9zw4TNKj+mx8lUv5Bi5MY
         OFGXALNBR3XUbCnmjii4iBYj4Y/QvG9Uz8RiFbmScSem3BeTjN/PP3Ras7B9R5NYNmMQ
         H8uGE+6brY/+RtyYWdgNiwTEwLCrumdImjcCMoHpbxWWuohHaMGfjuaNArtZ+pZPh80K
         46KIeCkaB+m/tgiLQWFPXtXFZzMC/0U3obCzwYrqF9fqbsVhWdD7LbE/tkVE0xTbeoqB
         In3w==
X-Gm-Message-State: AOJu0YxuoTM3lKB/GP3myBfQV44gGsxT85oH9ngUgVJIjAtBIzout9Xd
        Km4W88p+qyl+Pf0KOegjrZYVzA==
X-Google-Smtp-Source: AGHT+IFDXQyAglPrSiPusXkmaMsX7sU+swotUQYO5tBi1yQNW+84CElcs3yVu1MIDkx3y01bGva+lg==
X-Received: by 2002:a05:6214:c2c:b0:65a:feb1:ec46 with SMTP id a12-20020a0562140c2c00b0065afeb1ec46mr12565814qvd.6.1700067003998;
        Wed, 15 Nov 2023 08:50:03 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id mn16-20020a0562145ed000b00670a8921170sm658781qvb.112.2023.11.15.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:50:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
Date:   Wed, 15 Nov 2023 17:49:58 +0100
Message-Id: <20231115165001.2932350-1-brgl@bgdev.pl>
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

Let's start working towards removing gpiod_to_chip() from the kernel.
Start with pinctrl. The first patch should go through the GPIO tree
and become available through an immutable tag so that we can get more
conversions in this cycle elsewhere.

Bartosz Golaszewski (3):
  gpiolib: provide gpio_devie_get_label()
  pinctrl: stop using gpiod_to_chip()
  pinctrl: don't include GPIOLIB private header

 drivers/gpio/gpiolib.c      | 14 ++++++++++++++
 drivers/pinctrl/core.c      | 18 ++++++++----------
 include/linux/gpio/driver.h |  1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.40.1

