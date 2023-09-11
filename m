Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426979A438
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjIKHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjIKHNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:13:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B005CD3;
        Mon, 11 Sep 2023 00:13:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B7Cr7S055040;
        Mon, 11 Sep 2023 02:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694416373;
        bh=YsYh75UED2G1QnFln6YkCVw6QzBDHRr28paphEHwHpo=;
        h=From:To:CC:Subject:Date;
        b=Y8n6XMuPmh7cZ4Qb6Ibl23e1Bp/QMerPOndfB8g2DnwFcbcFaX+r6ReGJiLYF6vVF
         7CsHM6zYHByKA+X/0YjFM3ZwqQF3tRP99S8kJKiT9nliUpfJ5Z6z2d4u9BhdPGjWXK
         T/G+HYPe/lU0podOQIGHyix9x87OOdMD1ZwHxEL4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B7CrJL016533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 02:12:53 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 02:12:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 02:12:53 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B7CqXp008856;
        Mon, 11 Sep 2023 02:12:52 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38B7CqjU013887;
        Mon, 11 Sep 2023 02:12:52 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 0/3] Add AM65x ICSSG Ethernet support
Date:   Mon, 11 Sep 2023 12:42:42 +0530
Message-ID: <20230911071245.2173520-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds support for ICSSG ethernet on AM65x SR2.0. This series
is based on the latest next-20230911 linux-next.

MD Danish Anwar (3):
  arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
  arm64: dts: ti: am654-base-board: add ICSSG2 Ethernet support
  arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports

 arch/arm64/boot/dts/ti/Makefile               |   2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  36 +++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 123 ++++++++
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso      | 296 ++++++++++++++++++
 4 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-idk.dtso


base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
-- 
2.34.1

