Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FFF7A6B66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjISTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:20:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE83B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ee895a3cbso394913585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151200; x=1695756000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyh1KouBtG7Iy09LS9HXsGpQo6L9jAzzmaZyqdFSGZk=;
        b=wQENy8GFdhsQiOt1ngnbQNxDbaIvyzEL3MhCXzSgkxo8VSm8JBj0XvGQgZ6EeLg2JM
         pAkeAhs8lmfnrLsVHWU4hZ2scje9lZqNPE2AJQGrg4EKW6Ejb2pDBMLiVnNchmi+liZT
         fcki+wUn7UgMXKfyorjFedsRdkb2q9jLdD70fB9mi2LmmivvirXcWaqgdNvVOFA1O/jJ
         TrTYe4kcbHl39qG0IxKX7imiKZmmRhdzKN/NygsEkoOCgmFR40adnYgKlILoRuty0LOj
         x0rt5G5TCj8l75QR0DTMBkCmFsku6emjqF8RQanOckUYGith1YA1KNO6TIaUWemmR9PT
         wWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151200; x=1695756000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyh1KouBtG7Iy09LS9HXsGpQo6L9jAzzmaZyqdFSGZk=;
        b=vRNHy8UQaOozXeotBiyJIr49kWgfmwtkVvV/Zy/NkFIt4e+IZWk1WTsWRT7osweqbs
         hWzn0xHUpXsNGx+j1H04bUSXEwukqcSh1KLTObN8lX4JOJ7eS4/+WWORT1SKw75ZvKeM
         90XZ4PELWb1e8NjLjhXAD5Kt/69Ym7L2fRyhNvCWYL6EJxFQ6HR+scAfeznDdrdBvja8
         gqBni4K0Hwt0rZIHCrjtB1q/EhWYX2NCawgFigh7O1Mdo5BJRxse1nY+Yk9rPf2F5cZ5
         QQkjbNitlShPxakH3T9HL19KhSC+0FPuAG0aiX3bD7F7eFXf5c5etk1IEfWOqwCreYZY
         8pkg==
X-Gm-Message-State: AOJu0YwsJcu2Dd5bZrGZdImWA+1shlDnxGtfR1rsXEOcmYbsku8GU+xi
        vegyFeucCY0TIXWNRjHZAL6oyg==
X-Google-Smtp-Source: AGHT+IFIzlQgbfEYm0jO/4QPXVzoFCq4BxIA1q1xLtcSRQPlfowW+Ybgvv+50FIj+ScdvLKfPVI38A==
X-Received: by 2002:a05:620a:ec7:b0:76e:fea0:3f40 with SMTP id x7-20020a05620a0ec700b0076efea03f40mr562362qkm.8.1695151200597;
        Tue, 19 Sep 2023 12:20:00 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:00 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/2] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date:   Tue, 19 Sep 2023 12:45:34 -0400
Message-ID: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32 MCUs, Ethernet fails to come up after resume and the following
errors appear in dmesg:

[   17.451148] stm32-dwmac 40028000.ethernet: Failed to reset the dma
[   17.451266] stm32-dwmac 40028000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed

This occurs because clk_rx is never re-enabled during resume. On the
STM32MP1, clk_rx is left running during suspend, and therefore doesn't
need to be enabled during resume, but this code was mistakenly applied
to the STM32 MCUs as well.

The first patch in this series applies a minimal fix for the bug, while
the second refactors the clock configuration to make it easier to spot
such bugs in the future.

I have tested that this series allows Ethernet to come back up correctly
after resuming from s2idle on an STM32F746. I don't have STM32MP1
hardware to test.

Ben Wolsieffer (2):
  net: stmmac: dwmac-stm32: fix resume on STM32 MCU
  net: stmmac: dwmac-stm32: refactor clock config

 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 116 ++++++++----------
 1 file changed, 48 insertions(+), 68 deletions(-)

-- 
2.42.0

