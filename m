Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C016A7A8381
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjITNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjITNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:35:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE1D9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:34:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB99C433CD;
        Wed, 20 Sep 2023 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216899;
        bh=chV3GRCWr5Lml55DQwoEGOZDvAsEUjg7gojzo9cDXBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lA/25alJIqhzZtBEaJdB5MCje9dmmQga3PK2pwJKeKqZMBztBfXD2qWZpyoQCZ5PN
         J7uRAtAeF4/rRv3QYmJIe++z0Ba+CYkiDR064Gv4TmEuSz4isu3Bgu/3wbpnwctpS8
         ETvYvReFG0d0G06040t7pc9z4hCslnHvhI2YwSTnp3L0tPTmdKiTSJsjTW/WxzYofm
         JnWKS9OIPnem5+fT3INP676YVAarIqbfSCIiJAKYTTaGDPjicUsG96kWowbPPSoOxM
         Pm7IMr6MXqZWbq1uJ4HTKf7NFBqa7QKiB1g+KoAFxZ5+fULulw5kDUnnzwnvuHyAJZ
         1meIt8EqDMwhg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: Enable support for overlays for relevant boards
Date:   Wed, 20 Sep 2023 16:34:49 +0300
Message-Id: <20230920133450.54226-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920133450.54226-1-rogerq@kernel.org>
References: <20230920133450.54226-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable __symbols__ in board DT files for which we expect
overlays to be supported.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e7b8e2e7f083..06d6f264f292 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -72,8 +72,16 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
+DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
+DTC_FLAGS_k3-am62a7-sk += -@
+DTC_FLAGS_k3-am642-evm += -@
+DTC_FLAGS_k3-am654-base-board += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-am68-sk-base-board += -@
+DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
+DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
+DTC_FLAGS_k3-j784s4-evm += -@
-- 
2.34.1

