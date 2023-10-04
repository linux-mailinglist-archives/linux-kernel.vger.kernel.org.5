Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF87B9882
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjJDXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjJDXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:02:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242EEC6;
        Wed,  4 Oct 2023 16:02:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35164833a21so4621715ab.0;
        Wed, 04 Oct 2023 16:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696460543; x=1697065343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyDFBdDSwc/aV3pCxDfoJRjaHTCxVHMOU9DnJAZzdz8=;
        b=lElSiQs6ZEeOMBX5KtJW+/ZyM5+fcqMNt1ZBPfaCmSw9H2RIMXo+uWUXB/zvj6pP29
         29h//POEqe2Uzz47c012iazFBIDyDJcVyHpgxVl+L01DEagUVXBabWq2sZYqoX560a2/
         WOXfJmHqoDsXZiSMd9UYg6XSF0fAe0s8mSgVJhVNHCiYtfud44NWM6YPjtgFXPQ/cNxT
         7w5v1MHrKNnei+sgC1+1ve0oLO2Vn58T4zUoHbrCpHYcvoIiP2Wu1ynMZFac7lTWkNBj
         l3J5RW/hJDyUjlHvh0WRI5z52ZB6H9LpsaHKzPNuNiwjxztB04U1cP9m1G2LFzWRNw/r
         Qlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696460543; x=1697065343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyDFBdDSwc/aV3pCxDfoJRjaHTCxVHMOU9DnJAZzdz8=;
        b=HnqBuMnsWeple3aBTUXugBGHnmz6vGVgAJoIIBnOhVDJzeHpIzdRAYqgBXgW2cD8mC
         BLuy4pWZOPXs9iCFkidIFzC0wJa3CzJ3mJ3G1PM1b9MEtGvXyaxIZZS+KHt6ML5756Ea
         fqAYvY4C08F4sL2JaDoH096TgLIHgg45CrRargBPbc5HRZ3aPSN9i1oAl4d3prziN8Ek
         vZ13we35jY+1rvJx9Y3j6W8UsT2Fdasf3jWZ/LqzoJqFyfH4/Swy4NmLJgkZKkbmhGi5
         y/JAL/ycqTrO3qHnvvTLk1O26Tz8BQdW5jA0q9CJ3MSCTvJEvg3DvBekRVOoeWehBP9x
         auvg==
X-Gm-Message-State: AOJu0YyeXq2o48CFf9bRyZGV+iHStoba+DECk3/j9r/z3JaoAtDMlGNB
        yKW6BZCfbTvnk90rzTLoP2I=
X-Google-Smtp-Source: AGHT+IF5ij7AhHKXM8NjXvBBLvKUZF7LOnAmU3Rqi/H9ksvyKTtjoqgx0dXROpuMn7MY9aoW4svEjQ==
X-Received: by 2002:a05:6e02:1d96:b0:34f:20d9:74a9 with SMTP id h22-20020a056e021d9600b0034f20d974a9mr793445ila.11.1696460542962;
        Wed, 04 Oct 2023 16:02:22 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id u25-20020a02cbd9000000b0042b3bb542aesm82688jaq.168.2023.10.04.16.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:02:22 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mm: Add sound-dai-cells to micfil node
Date:   Wed,  4 Oct 2023 18:01:58 -0500
Message-Id: <20231004230159.33527-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the DT bindings, the micfil node should have a sound-dai-cells
entry.

Fixes: 3bd0788c43d9 ("arm64: dts: imx8mm: Add support for micfil")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 236fe44f779d..738024baaa57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -399,6 +399,7 @@ micfil: audio-controller@30080000 {
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
-- 
2.40.1

