Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC67E0E64
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKDIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKDIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:52:28 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD48D42
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 01:52:22 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231104085220c9c068e7d8957a3397
        for <linux-kernel@vger.kernel.org>;
        Sat, 04 Nov 2023 09:52:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=HmS5Y/la7bNVqCjQ0TeU3mjYGyvPihCzmz+hhz5x+1k=;
 b=hFWCjCFuI0nB8A+h0WdsQrqoZ85fjhm/uKKCHbKV1H0pJ7iKxqZ4izYaNxs3DHQb5cp8hg
 70nsjeI4SzOG/auortrmY+ebRIQ01iklk5tunn0jYCc629iM0/nvZ3DXbHN5HKpJJGM8YQmx
 87/wQgD0NlrlSZFlB619yx/VB5cqY=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH v4 0/5] arm64: dts: iot2050: DT fixes, cleanups and enhancements
Date:   Sat,  4 Nov 2023 09:52:14 +0100
Message-Id: <cover.1699087938.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the lost aliases for the IOT2050 series, fixes mini PCIe card
hangs, drops an unused device node, brings runtime pinmuxing for the
Arduino connector via debugfs. Finally, it enables PRU-based Ethernet on
PG2/M.2 device variants. PG1 devices still need changes to the TI driver
to enable them as well (work in progress).

Changes in v4:
 - fix dtbs_check findings

Changes in v3:
 - remove some SR1.0 bits in the SR2.0-only icssg-prueth nodes

Changes in v2:
 - dropped spidev enabling - still looking for flexible and acceptable
   solution
 - added some missing signed-offs

Jan

Benedikt Niedermayr (1):
  arm64: dts: ti: iot2050: Definitions for runtime pinmuxing

Jan Kiszka (3):
  arm64: dts: ti: iot2050: Re-add aliases
  arm64: dts: ti: iot2050: Drop unused ecap0 PWM
  arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices

Su Bao Cheng (1):
  arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin

 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  10 +-
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   4 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 824 +++++++++++++++++-
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  12 +-
 4 files changed, 790 insertions(+), 60 deletions(-)

-- 
2.35.3

