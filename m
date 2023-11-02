Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DB7DEAEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjKBCt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjKBCtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:49:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A4128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:49:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc4f777ab9so3771375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698893356; x=1699498156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=yFqza9ow6X1Tvg1ZQLHn2KqDCf34wnL5eBDwE1hLT3N4IcDeuH/7cN0j2Bqbdgxhuz
         Qrwt0ZDwWMgSRM706XgDnIDA88dNNpipaYOVgb28dFitCSvYhJMpyNtWoVTE6GSYUCqs
         UNYZAGWnSoGILV/sKvVE/9Ai8WenebvOkmvo8CbivmH5ZUiooIUaD9hD27BmXE+5Q0DU
         76DQlFejGcI7KXa0e8yyoGUubbICl2Dnz6ufX9QiQReM6Aps4QGjx+B6ti5FiMZkpP6J
         SYMvYsHdx2UMPJzNZIcu69T6lyO1bH9VJ/Ri1+wiRSg+44EHXlmucze8hE26z8sT7I/H
         is6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698893356; x=1699498156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=SHmynOqIclocKpJc/Ph+OnZUmnTAPOOalEC+01ESUAxprvqsKGYIGkQYF8U/0lnwFW
         QiUF4j2O2//2Af7j5Pr3bepNZ37excTvjmw/y9HsfTbLcW1hNEnsIkyZFC0pew11xVgC
         ghn1KftlIwzeTb/B1sH3OMm9rXTAMUhtNydwkecW3SS+qWAspCu7CmHbxBB2DKblIgdK
         FBBhjajh+U4zs4H02W5OyhXtkbfPHkP32nLvyfYOFyRRMqWKXG6aHjwFXuO6uk5QhUuo
         E4jjNLCbqdB+L07153+X3Dc0B0rTa8ndb427BHD7Y/323WqZXkRmrLivOyS3EeDqgWjM
         Cu6g==
X-Gm-Message-State: AOJu0YzW1c5P3Ne4H6ZMA76q4hI8jxiaeQ4V34OlZkmJjwjBujkUXBS4
        kU7qon0w/tAvcN+rAUR7RVL0cA==
X-Google-Smtp-Source: AGHT+IGIkak0BWPmf96vSjrzvsdLE6FSIqQnE69o81x6bAW2NsVUROi7m+yImFnuEBD3qfEnlgNLMA==
X-Received: by 2002:a17:902:904a:b0:1ca:a290:4c0c with SMTP id w10-20020a170902904a00b001caa2904c0cmr14004681plz.16.1698893356673;
        Wed, 01 Nov 2023 19:49:16 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:7e4c:4d4e:6943:bc0f])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001b850c9d7b3sm1925787plf.249.2023.11.01.19.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 19:49:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 01 Nov 2023 19:48:55 -0700
Subject: [PATCH v4 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-th1520-mmc-v4-4-86e0216b5994@baylibre.com>
References: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
In-Reply-To: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698893345; l=915;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=ht5Rt9iMCRM1t5yThjxoCTbuOVz3OXmRTAYLzzfd3/s=;
 b=FZMIpbOF3eXJOg41M+jpGkm0JMPaPS1i+Fh/DURCDFJ6QTIV6xnD4KSvnKvDKTZm/Q5C4u02O
 XJ40YVrYjkqDC8JNiTK4WMQXC8RJvH5O3/cEe7X9+tCNDrDxEPQ8ITa
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the mmc controller driver and dma controller driver needed for
T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
boot from eMMC storage.

Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..c5a8583236d0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -168,12 +168,14 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.34.1

