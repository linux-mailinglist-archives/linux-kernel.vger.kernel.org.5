Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C27D9A06
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbjJ0NfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbjJ0Ner (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:34:47 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C3D6A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:34:41 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023102713343928edf4b813931b9d5e
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 15:34:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YkPFdNGNdT5cVutTk9C1dmnrIFJ2F0FJa9j2a+FDVEk=;
 b=PrUtF3O3pZebpkjzl+XyyjbTcEHL8Qo8ETtlcSJ5I4VboRekrm1B6cWzm+/BhRO5Cq31c+
 MQOsEEvzod1Co0bbnb/fByFl7dmKCdmhGSZaMM1b440qTDxmqErqUX2mY+Ry85qwpfZHYDbX
 5ICrzlQ+8Twh8iY6Bag02l8cmqpC8=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH 0/7] arm64: dts: iot2050: DT fixes, cleanups and enhancements
Date:   Fri, 27 Oct 2023 15:34:31 +0200
Message-Id: <cover.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the lost aliases for the IOT2050 series, fixes mini PCIe card
hangs,, drops an unused device node, brings runtime pinmuxing for the
Arduino connector via debugfs as well as spidev. Finally, it enables
PRU-based Ethernet on PG2/M.2 device variants (depends on [1]). PG1
devices still need changes to the TI driver to enable them as well.

Jan

[1] https://lore.kernel.org/lkml/35a3c4c9-5c1b-4891-9ea2-e3f648a9afe0@ti.com/

Benedikt Niedermayr (1):
  arm64: dts: ti: iot2050: Definitions for runtime pinmuxing

Jan Kiszka (5):
  arm64: dts: ti: iot2050: Re-add aliases
  arm64: dts: ti: iot2050: Drop unused ecap0 PWM
  dt-bindings: trivial-devices: Add IOT2050 Arduino SPI connector
  arm64: dts: ti: iot2050: Add node for SPI devices on Arduino connector
  arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices

Su Bao Cheng (1):
  arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  10 +-
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   4 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 834 +++++++++++++++++-
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  12 +-
 5 files changed, 802 insertions(+), 60 deletions(-)

-- 
2.35.3

