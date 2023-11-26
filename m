Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE57F9676
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKZX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZX1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:27:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA1111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:01 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D37493F885
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041279;
        bh=g2nzefL9abJS3V7F5jIo1B7LNOEauW6WFlyZ4XwqLeg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nSJcalq49+OANyoXnUQEc4riU+vnj9J5Pm3EHX51sb2lnOkXUL90U+UgUkWWmnDPT
         tQcuZfJFvkv4SQNWjjh4QSLGKDTwz/UD1tI7Oao9NbdvJ9egrOeDPG3Ewzpmxz5NcP
         zrfHqa8xoxwnrPrRdvMttNqlp2jfzmJrE6EawVv48/FPr7IJPnMu4GG0/h48+FwKo9
         2BEU+xAGKCRZJ/fPrnS2Mq+dKmJ3L6y5E2+RWyZ0GVFXT3Gtm8x+ALp+/bCPNcRBA3
         EwcS9ZOJRPSoEMf7tmDPn8YV616iwGfousmSoFQhNzqXWaTN/LusMGL1KtSFvqCUJo
         xhfAs/kMe2VKA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfd4ef9f06so926205ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041278; x=1701646078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2nzefL9abJS3V7F5jIo1B7LNOEauW6WFlyZ4XwqLeg=;
        b=pb7UIiGwb+/FD0/s3Yim0bkmPbQvE9rhNG457v9Ghfc1vqBlj9jVU5lpS4K0/0XdrZ
         4S22LxJfaUw9LCl4yuo1BOR3tvScqrQqXpQpdas2Nz6YOUK7IrkG7aZ++le+1WrNltbo
         TAXQZiBNljWwvKheUsbRcGBcoEHAnIZdxTTo0hT/nMCQrsgykmjMDB2Vp+Z05IDwVq2Z
         anfacTeKGSDwywBv3N6F8g+szD/bgCqLGbwd7k63aWUgWiyhPGcd6UKXz+c6ndgyATT+
         T0BNgptCOHmApsWaQen6lhRYs4OxwG9p0waIGwCh3h5u2zGLE6CI01GTkmNrd2qU+gfK
         d8iQ==
X-Gm-Message-State: AOJu0YztEeCvJLaH7NntKnXyUwq41whTJ23MhKmthQq3R31oB4wiD6w9
        TICfqr38ze9X1T0OaIj0pvHlcjbmUWUHEmYNkt3njYmk7+v+JJZMnfobgQ63GY1UIkiahB0Z570
        7WHifJACNtPIeCadr2gJuRhsR2fiMTFK/Ou+OOu7peg==
X-Received: by 2002:a17:902:e843:b0:1cf:d24c:7b6c with SMTP id t3-20020a170902e84300b001cfd24c7b6cmr592916plg.59.1701041278372;
        Sun, 26 Nov 2023 15:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH60lQE3aZPaurMVIV4axuHzu18clG+N8+FOTOm8l4AK/mfUHBLQos1lPIK8CEhfQ0hwX19w==
X-Received: by 2002:a17:902:e843:b0:1cf:d24c:7b6c with SMTP id t3-20020a170902e84300b001cfd24c7b6cmr592895plg.59.1701041278076;
        Sun, 26 Nov 2023 15:27:58 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:27:57 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 0/8] Add JH7100 errata and update device tree
Date:   Mon, 27 Nov 2023 00:27:38 +0100
Message-Id: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver for the SiFive cache controller supports manual
flushing as non-standard cache operations[1] we can add an errata option
for the StarFive JH7100 SoC and update the device tree with the cache
controller, dedicated DMA pool and add MMC nodes for the SD-card and
wifi.

This series needs the following commit in [1] to work properly:

0d5701dc9cd6 ("soc: sifive: ccache: Add StarFive JH7100 support")

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-soc-for-next

Emil Renner Berthing (7):
  riscv: errata: Add StarFive JH7100 errata
  riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
  riscv: dts: starfive: Add JH7100 cache controller
  riscv: dts: starfive: Add pool for coherent DMA memory on JH7100
    boards
  riscv: dts: starfive: Add JH7100 MMC nodes
  riscv: dts: starfive: Enable SD-card on JH7100 boards
  riscv: dts: starfive: Enable SDIO wifi on JH7100 boards

Geert Uytterhoeven (1):
  riscv: dts: starfive: Group tuples in interrupt properties

 arch/riscv/Kconfig.errata                     |  17 +++
 .../boot/dts/starfive/jh7100-common.dtsi      | 131 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  48 ++++++-
 3 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.40.1

