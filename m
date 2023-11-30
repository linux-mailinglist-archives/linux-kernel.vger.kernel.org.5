Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7628E7FE661
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjK3BtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:49:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE0BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so4845135ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701308953; x=1701913753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUhuNFsiAvrHYnZLi2Em140Y4QPJessaIPRDZmEdsMw=;
        b=UUT8xRU1/h3OfozHgDK9/fLnnLIan24y38vlqRqgN5hGBT2MJLnX1EGZi/A5AE58aM
         Jj7IDF+jqXt3yEQh6MexLL74COkFUTGq//78TqAE1nhNzKBULwdC7EZUwC1EAaZVlKHy
         lBBBrRmjaDuQihlFU/RYuAklCrYqNK3zw/jqZEKSLYpN6tvzTypLiu6/V9qMFM52DnYI
         d3gpWM60Jde1i3vx6wTykSAprMDlClGrv12IoVMta2VpTuZC+DXvBDIUMceL/2tylSac
         Xx2TMBS67OkknBZSX/SMTvdW/dXDn+uN50r4itdNnPMEHHaJdYF37bk1vEgz8mqKT+54
         lcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308953; x=1701913753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUhuNFsiAvrHYnZLi2Em140Y4QPJessaIPRDZmEdsMw=;
        b=eIE8/PAtfiWHOTkVHEq8Ltb4TMy7X2a2BJeQIUgGapxC1zFbJIzmHGN8/XKDgJ1Qw7
         18Tf4ZXxmTva6M2rIY+rmlOcCiqjlVTS4Ao/IPzTZplCaz0c8t4zMlXYilO2SNYJ1zfS
         6/Xc9HcjYvWuGwWZ8Fgh+WwipOuqx+EPXFcLhynVYmOl51wLX9Ur2gamBEEHwhld+Ute
         Rjz3CF7vte9K0GA1qDSB3J0HeKfOqxkR6IRcSlf4J+sCWIK002wExvl9GJPXRLQChlEv
         vNrIjZWDbKi7Tn2nZLDY7DcUZV0tfL3dAbFtCqUotCtH8sbyWd74L1723NKGtDs7sRib
         kffQ==
X-Gm-Message-State: AOJu0YxDjlVThF5HGAaeYUBK0/yJ1tuKm+0c8W95TAmIvagj15SizAQU
        DGppez+EK547zlcaFrim0VW5qA==
X-Google-Smtp-Source: AGHT+IFrYiRFrGzs3Y1CBEPL2phpj1QNKQPDTXXYUtfO5eBxcLlNdgmRNSs2XIEy08Ji+Bq43Zrniw==
X-Received: by 2002:a17:903:246:b0:1cf:b29d:3e8e with SMTP id j6-20020a170903024600b001cfb29d3e8emr16912003plh.58.1701308952800;
        Wed, 29 Nov 2023 17:49:12 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:9707:1e8c:3166:6a23])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001d00b0bd306sm24455plb.251.2023.11.29.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:49:12 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 29 Nov 2023 17:48:47 -0800
Subject: [PATCH v7 1/4] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-th1520_mmc_dts-v7-1-c77fc19caa6f@baylibre.com>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
In-Reply-To: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701308949; l=951;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=4RIHUzQaxou3jWGQo/iOBjqUj+fsmX35ctdJCieIZQA=;
 b=lABD+i37ZsVjKTem2rwlrtlpGSvWvZfxV4ATEPFLVk0KhDOrnCghqvXJAuoDLcgASHkByc7EJ
 piiI2bt8FWGCRfYuwkatOQAxcEt9VJHtEoGTUvCKvmAswq+uFD2jxKc
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 905881282a7c..e635dc9d1997 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -214,6 +214,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_STARFIVE=y
@@ -223,6 +224,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_RZ_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y

-- 
2.34.1

