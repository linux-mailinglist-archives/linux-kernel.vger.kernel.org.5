Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63F97E4F76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjKHD3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKHD3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:29:52 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73718C;
        Tue,  7 Nov 2023 19:29:50 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso275790b3a.1;
        Tue, 07 Nov 2023 19:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699414190; x=1700018990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/22H5hWcaotqfz6rBy+/U8/l/usKjhroCvWtxgHYPM=;
        b=LN32auB3+KtjLcfRqrS2aFyyfoxbgxLsbheMBQCgwVAaP3xDVEcvidzFSyKZmReEuA
         Q22TFpwaS8re4Oe1RrQEF9zvCm27ouFATG7cacl4yZaW1lE2mJfrHR1vrNnEht30rI/C
         FrKIrS6PnsukJmgDK/Rl0aOqD7FMzRnAliLDRK/PyiBj0S36XaUSNUX401vu1STU2nzA
         xFFpgVrCLZqSZbiAiQ0b9l82zwR08DGOUZLkHQMeJjjZP7MmazanTwTYl53G7byINsBH
         wAT5EcV8bdCy4Y8EUQV2KvwmsokwIdnrNhGcSthsPAQH0GOxp4DYfbUjavq00fCLPI7S
         NdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699414190; x=1700018990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/22H5hWcaotqfz6rBy+/U8/l/usKjhroCvWtxgHYPM=;
        b=LsbU80LxNDDwl6TdOV4XbXKI2/iDIn1hjqtFPA/X0xXMl9MI+BZGNFwj4KprJfTzL3
         HwFzV2K08dVdyKtlIxaifaiAvuGVXmJLxDO4jWwfULifjMnWnmuF7E9OubO2IRvAyODV
         XrVHmUXbWvl1U8+Sy2kNHGr823B//JCaNQioFYtCtHbqkiDayCaXQi8LEWt05APOuzts
         EpBzBO0phgXY0L66PTSVOD014lDEPtbD0XwgTzkeQbjUkZSLmkNI8oQCBqvFXz0EoY8d
         D6snw5gO3eXI1xgwlQjJ8h33AlcJiH5Zj6LtyMiMpEv3+YZcH0QdvhIH1ktfAa+N4Gmy
         uIBw==
X-Gm-Message-State: AOJu0Yz17XWrG4Ba/DqBspPvyDzqDusKqqsB5q0qhKWNO3T0Fc4P020G
        ov1WYXYTHSyEev2zL4VIduvdQFCxR8pZw3QU
X-Google-Smtp-Source: AGHT+IE18ayHRr5W6IPnwBb6Iks66/95SNt7LnpMHfj0h5eDAL4wnmiwNMk/CSjFEb0vMXoYQEH/jQ==
X-Received: by 2002:a05:6a00:4445:b0:68f:cdb8:ae33 with SMTP id bs5-20020a056a00444500b0068fcdb8ae33mr958583pfb.10.1699414189952;
        Tue, 07 Nov 2023 19:29:49 -0800 (PST)
Received: from localhost ([115.192.116.120])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7880c000000b006c33ae95898sm7931405pfo.78.2023.11.07.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 19:29:49 -0800 (PST)
From:   Yuxi Wang <wyx137120466@gmail.com>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wyx137120466@gmail.com, Yuxi.Wang@monolithicpower.com
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] leds: add mp3326 driver
Date:   Wed,  8 Nov 2023 11:29:19 +0800
Message-Id: <20231108032921.3134115-1-wyx137120466@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the mps mp3326.

Signed-off-by: Yuxi Wang <wyx137120466@gmail.com>

Yuxi Wang (2):
  dt-bindings: leds: add mps mp3326 LED
  leds: add mp3326 driver

 .../devicetree/bindings/leds/leds-mp3326.yaml | 184 +++++
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-mp3326.c                    | 627 ++++++++++++++++++
 4 files changed, 819 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
 create mode 100644 drivers/leds/leds-mp3326.c

-- 
2.25.1

