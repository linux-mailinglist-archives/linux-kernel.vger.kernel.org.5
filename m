Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5F7DFAFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377287AbjKBTiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:38:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E9186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:37:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c011e113so16186327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698953877; x=1699558677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uogr7zU4t34ibaqbgxGWB9r8NXGxVylxADwS2sMjoTc=;
        b=Q9gWsxFzXji2qke2tU/bD1uBkN/pjpD1h3fdx73ggWG755DTtOY4wuhWIYR6zvg8vU
         lLJtfLe2JL8uPZW4MUo/upXEXR9rogpekM7ApvsXR1Rdk3/qmgH9P2m/5dZzsk3SqwlH
         nxwLMYJ1S1atpHhWO7RjnHo0modLEOO5NPPSHJiF8+tGn0v2ngEKZf1cnDGYtqqqhrOv
         QgQ/EbkYbEW8G0fCBObJKkoMIn/CZ6zUKiDVHeaRW9VrpkEWXf2atUbT1VjYfdWrxVCE
         IS3lQjJY4GebOAR/TI82lyG78oi/GQZ4YBVvb4rsMhArrFisN50g7hHoJULbpfU7tMXh
         naRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953877; x=1699558677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uogr7zU4t34ibaqbgxGWB9r8NXGxVylxADwS2sMjoTc=;
        b=DkDruvPVLWRZbVqTyoXqEgfeLlHfINZeH1tKnwgaVQeeUuOrGsZLy2UoF1Pi8UUq2Q
         4TqvLH11ELNBc7xCfP7H4khcAaQg143/LhFnCmAzRJen1KJhH9GSmCtysVfd5eoFf0g3
         VNgoF0BWCBPQ5UGGNt5d1R/mXStz747UTFOIhNZsCjpoJw8omlPCtO5lfZgyQ8pNNb/P
         zBKL3kLIknOik53KRslH2RKZLW0Zl2bYZdGIq+tbOuFaYSIJZQAyLX8dFOlIGSMHqWs/
         4ssLURAwPhJoFrir4rH3mnHE3iXdOeoRCEcnJa0YiPyiGjFirw0phwElqjdZCOGghMLK
         UiUg==
X-Gm-Message-State: AOJu0YzjdJYa/9DdLv847XmYAES5f2C3n+wRJEPh3ISGjc5ktqCRGjZB
        a3hghORgiuH28EEtS7E1jrdKIw==
X-Google-Smtp-Source: AGHT+IEGxFcOOrtvJ6cU9BZ2CGnOOPvIjlvXGVkgaylmcuyrz36fI4KJRg2FJQTlw2ceemhfetI4zA==
X-Received: by 2002:a81:4a02:0:b0:5a4:3e67:35a3 with SMTP id x2-20020a814a02000000b005a43e6735a3mr664848ywa.49.1698953876935;
        Thu, 02 Nov 2023 12:37:56 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce90a000000b0065b260eafd9sm30654qvo.87.2023.11.02.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:37:56 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH v2 0/5] Add STM32F7 SPI support
Date:   Thu,  2 Nov 2023 15:37:17 -0400
Message-ID: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for SPI on STM32F7 processors. The STM32F7 SPI
peripheral is nearly identical to the STM32F4, with the only significant
differences being that it supports a wider range of word sizes, and the
addition of 32-bit transmit and receive FIFOs.

v2:
  - Add missing commit body

Ben Wolsieffer (5):
  spi: stm32: rename stm32f4_* to stm32fx_*
  spi: stm32: use callbacks for read_rx and write_tx
  dt-bindings: spi: add stm32f7-spi compatible
  spi: stm32: add STM32F7 support
  ARM: dts: stm32: add SPI support on STM32F746

 .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 +
 arch/arm/boot/dts/st/stm32f746.dtsi           |  60 +++
 drivers/spi/spi-stm32.c                       | 455 ++++++++++++------
 3 files changed, 367 insertions(+), 149 deletions(-)

-- 
2.42.0

