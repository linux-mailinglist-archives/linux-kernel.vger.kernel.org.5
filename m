Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426507D0DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376990AbjJTK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376974AbjJTK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57828114
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5629fdbf8so3300101fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799361; x=1698404161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XGWCJzM/g94fBfiFjQE9ovQs61u2T9WwU8kHFzzAHc=;
        b=wz60kAjupRd51/JXl/J1mE+AWT2q1Ep73VTJj7DyTeBlBzoWR7tqIx0fSdv8atBfeG
         lTTJE21BFJfsDmOgCg7w/VagJIIAd9GgusC8huzZWZFh/dILQB6LImxLKKt0tnQkrZag
         IYgYrLe6/O08RQ5Fw6RPDDvR4hfr8Gr+wnUA6zao8ccoGeFmuuF1o1qtI0Nz+4d0MRb9
         NJP0gUd+M62k9zs7qpv6cDUhaWsKeERU7sOOengjGb3hKAXdzaiDmOt1Xlo9u7WyfzQR
         4Nkexn6/Q3PYbz/Oz9XlHE+nBd2q/h8zq306Fn/8ZG9wLyViCNk/LmwZ4CdsVss/uL37
         tuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799361; x=1698404161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XGWCJzM/g94fBfiFjQE9ovQs61u2T9WwU8kHFzzAHc=;
        b=lNbA6kPddhUVM5GZUim/9VwXgqd8hADr1Eizgxrx7plBwAcHIRU8NF9rzgOd4CV586
         aKhzG/8xG3vsamhrDF5YdqIV52CTKrDC4kBL3wqiZemGbcxC7b2EpNDqdzKC1TR21nWB
         T1Lue3j3NW5Qm1xWNx5CNlfTl+pEOlcxtAVE2vpSR/59ebrLwQEb8xi07cQasHg/tD9e
         bjB8eqPrwf2Nd/Kagnr7+kWNAEsdObKu1csh/tE35MwgDzS48++kArK2mUt/ol4AJ/2v
         WCL8ckdsA3MYJLXZG4Rm64yqhYjq770cvI53IelXaD+x2AcNMhBDPyv34cFgzAi/Rvja
         h6Rg==
X-Gm-Message-State: AOJu0YxuKIyGIzFWX1JVUcRJHgDFEb3XknHhUBB5Qr8C0VUT6u7xrWjg
        +4QHZzb26EeSVGW/A0gwcw7BwOrjU+Q6wTGzdxk=
X-Google-Smtp-Source: AGHT+IF/zBmQ81Mh1rYtDuRkhhieFQOEpu3V5wGsAJl2hBmMEcLLeFYjRSUIlN8ifBW+DEk1OXMjww==
X-Received: by 2002:a05:651c:30c:b0:2c0:300a:82ed with SMTP id a12-20020a05651c030c00b002c0300a82edmr910428ljp.7.1697799361095;
        Fri, 20 Oct 2023 03:56:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:00 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] nvmem: patches for v6.7
Date:   Fri, 20 Oct 2023 11:55:39 +0100
Message-Id: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some nvmem patches
- mostly around deprecating old style bindings.
- make qfprom clks optional.
- making use of device_get_match_data()

Can you please queue them up for 6.7

thanks,
Srini


Luca Weiss (1):
  nvmem: qfprom: Mark core clk as optional

Rafał Miłecki (3):
  nvmem: add explicit config option to read old syntax fixed OF cells
  dt-bindings: nvmem: move deprecated cells binding to its own file
  Revert "nvmem: add new config option"

Rob Herring (2):
  dt-bindings: nvmem: u-boot,env: Add missing additionalProperties on
    child node schemas
  nvmem: Use device_get_match_data()

 .../devicetree/bindings/mtd/mtd.yaml          |  7 ++++-
 .../bindings/mtd/partitions/nvmem-cells.yaml  |  1 +
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  1 +
 .../bindings/nvmem/amlogic,meson6-efuse.yaml  |  1 +
 .../bindings/nvmem/apple,efuses.yaml          |  1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  1 +
 .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
 .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |  1 +
 .../nvmem/nvmem-deprecated-cells.yaml         | 28 +++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  9 ------
 .../bindings/nvmem/qcom,qfprom.yaml           |  1 +
 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  1 +
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |  1 +
 .../bindings/nvmem/rockchip,otp.yaml          |  1 +
 .../bindings/nvmem/rockchip-efuse.yaml        |  1 +
 .../nvmem/socionext,uniphier-efuse.yaml       |  1 +
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  1 +
 .../devicetree/bindings/nvmem/u-boot,env.yaml |  2 ++
 .../bindings/rtc/amlogic,meson6-rtc.yaml      |  1 +
 drivers/mtd/mtdcore.c                         |  3 +-
 drivers/nvmem/apple-efuses.c                  |  1 +
 drivers/nvmem/core.c                          | 10 ++++---
 drivers/nvmem/imx-ocotp-scu.c                 |  1 +
 drivers/nvmem/imx-ocotp.c                     |  1 +
 drivers/nvmem/meson-efuse.c                   |  1 +
 drivers/nvmem/meson-mx-efuse.c                |  1 +
 drivers/nvmem/microchip-otpc.c                |  1 +
 drivers/nvmem/mtk-efuse.c                     |  1 +
 drivers/nvmem/mxs-ocotp.c                     | 10 +++----
 drivers/nvmem/qcom-spmi-sdam.c                |  1 +
 drivers/nvmem/qfprom.c                        |  7 +++--
 drivers/nvmem/rave-sp-eeprom.c                |  1 +
 drivers/nvmem/rockchip-efuse.c                |  1 +
 drivers/nvmem/sc27xx-efuse.c                  |  1 +
 drivers/nvmem/sec-qfprom.c                    |  1 +
 drivers/nvmem/sprd-efuse.c                    |  1 +
 drivers/nvmem/stm32-romem.c                   |  8 ++++--
 drivers/nvmem/sunplus-ocotp.c                 |  1 +
 drivers/nvmem/sunxi_sid.c                     |  1 +
 drivers/nvmem/uniphier-efuse.c                |  1 +
 drivers/nvmem/zynqmp_nvmem.c                  |  1 +
 drivers/rtc/nvmem.c                           |  1 +
 drivers/w1/slaves/w1_ds250x.c                 |  1 +
 include/linux/nvmem-provider.h                |  4 +--
 45 files changed, 94 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml

-- 
2.25.1

