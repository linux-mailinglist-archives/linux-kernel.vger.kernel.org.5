Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF47F384C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjKUVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjKUVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:30:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418719E;
        Tue, 21 Nov 2023 13:30:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce675e45f9so24703295ad.3;
        Tue, 21 Nov 2023 13:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602207; x=1701207007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYftztaNvPp9AiycXxFsDD/pusJZO5VD4GKLxnNaenc=;
        b=LUIjMDrOzR+Yp53XK+6vS3UXU9xRwxbM8v7A8b8bgESRmhnDgRkibOlQIXbCJcBJrz
         CgUaB49A0JSvHwlWzAVx+subHk3HcIT1WpIC8ZnMagnDbK1QLMwKUntQ69Yp1+nKQKpg
         XA3gjgtTPRngqs2/Q2pxzn8JGm6SBDJoIdfAZ+R57HfTCfLStKdlCb8cEgNprcfzxrY9
         q0ivEyAyqCbutiq3NTqZg0HxIZmZIPbbW40b7T+aK1YIZE4swfKKgTIg3d9BjZzrs0iQ
         ABY4HW/A44KHL1+KFzhAj2u/TQxG4dsZ9b0XtTJjuOyGilKMLizZ3TT0J0ioqfroXTM4
         2bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602207; x=1701207007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYftztaNvPp9AiycXxFsDD/pusJZO5VD4GKLxnNaenc=;
        b=ABDSwhKxWAYl7DUwKuKgOPtYuFwKm0qNwglFQH7uRKq1TqzgssUXAf1g56HgpdTT+W
         UFzQb7IeiZpFdbvP6ELfi9VnRgXJ59N37s4e+AAPA/HDKzV7kwPfK9tN1E5sPF9/wzxn
         ON33S5rdbAWE+3CDTDIV4RiuH9JEYKvmzwLrSsg4SntwgxaV2oaLG/twxpvV5hJ0FN9T
         iWSCWiLurFavxFf9xBBLVIMyt/AhjOnmpqAVKQfu2EUWqYHn8yRiPqrsLS3+VD9w4Wpi
         OOaHwd0A/C2saUL2GatMpfpCHUOez79/EQxY7q5RbivmTW01m2YR6nvi7p/orCizT+CK
         Sq+A==
X-Gm-Message-State: AOJu0Yxhij8Hx7a3GyY0PIHfPcBKSBvJCuXMVvY6scbdjjDxCnujvx9U
        i6K4xaxy7B3w+zb3VmY+HAA=
X-Google-Smtp-Source: AGHT+IG0k767577DEtl9DqETp58uM/MD4C4W6mI4eHWwOiQmbjfCmcbOeVYtVXSVgRTFvKchqFGWeQ==
X-Received: by 2002:a17:902:ecc6:b0:1cf:6bb1:fcce with SMTP id a6-20020a170902ecc600b001cf6bb1fccemr437108plh.46.1700602207395;
        Tue, 21 Nov 2023 13:30:07 -0800 (PST)
Received: from localhost.localdomain (static-198-54-134-172.cust.tzulo.com. [198.54.134.172])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d71400b001c726147a45sm8355317ply.190.2023.11.21.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:30:06 -0800 (PST)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Fix eMMC Data Strobe PD
Date:   Tue, 21 Nov 2023 13:29:41 -0800
Message-ID: <20231121212941.53873-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121212941.53873-1-CFSworks@gmail.com>
References: <20231121212941.53873-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
currently used only in HS400 mode, as a device->host clock signal that
"is used only in read operation. The Data Strobe is always High-Z (not
driven by the device and pulled down by RDS) or Driven Low in write
operation, except during CRC status response." RDS is a pull-down
resistor specified in the 10K-100K ohm range. Thus per the standard, the
Data Strobe is always pulled to ground (by the eMMC and/or RDS) during
write operations.

Evidently, the eMMC host controller in the RK3588 considers an active
voltage on the eMMC-DS line during a write to be an error.

The default (i.e. hardware reset, and Rockchip BSP) behavior for the
RK3588 is to activate the eMMC-DS pin's builtin pull-down. As a result,
many RK3588 board designers do not bother adding a dedicated RDS
resistor, instead relying on the RK3588's internal bias. The current
devicetree, however, disables this bias (`pcfg_pull_none`), breaking
HS400-mode writes for boards without a dedicated RDS, but with an eMMC
chip that chooses to High-Z (instead of drive-low) the eMMC-DS line.
(The Turing RK1 is one such board.)

Fix this by changing the bias in the (common) emmc_data_strobe case to
reflect the expected hardware/BSP behavior. This is unlikely to cause
regressions elsewhere: the pull-down is only relevant for High-Z eMMCs,
and if this is redundant with a (dedicated) RDS resistor, the effective
result is only a lower resistance to ground -- where the range of
tolerance is quite high. If it does, it's better fixed in the specific
devicetrees.

Fixes: d85f8a5c798d5 ("arm64: dts: rockchip: Add rk3588 pinctrl data")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
index 63151d9d2377..30db12c4fc82 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
@@ -369,7 +369,7 @@ emmc_cmd: emmc-cmd {
 		emmc_data_strobe: emmc-data-strobe {
 			rockchip,pins =
 				/* emmc_data_strobe */
-				<2 RK_PA2 1 &pcfg_pull_none>;
+				<2 RK_PA2 1 &pcfg_pull_down>;
 		};
 	};
 
-- 
2.41.0

