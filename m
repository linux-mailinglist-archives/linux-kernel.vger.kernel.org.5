Return-Path: <linux-kernel+bounces-53159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B684A175
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C0AB231FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA164779E;
	Mon,  5 Feb 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUSR+xpv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFD44C94
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155740; cv=none; b=NP9jV0meQ3m4Rokl6dfzJmB/zJwk5VwSuXrOH9wUrey5OZNWK4CehDCbvbLudWVc3REE350JZ/3l9ecsSmo4dnxHanfeXK2t3oWImUVMNtffUuq2dmzQneRxMbk3+28SvEV9W9TMBe0M2ilyten6q3GjICa2B9DFH+Txaoss97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155740; c=relaxed/simple;
	bh=cEHab/mwa03OEYPIDPQQh8jv8KsmGrpTTQWOPDBBUbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hMCuhzMMeFrxCFDA4Kob02G4X9JeNJD8D4NrIGGvS1M+gY6GdkE3HpzwtBbnrLO9JhAbBxgVA89HfHkHSt9SHLA8SWhQmgONmBN/DjW0dR8dRHsQJCkaAq0al1Rg8XyuP5/4mubZ67mHslEDdKKRJ0SwXmj4+Y3d737FhCh7ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUSR+xpv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdb18ffc7so11253905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707155736; x=1707760536; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auT8vI6DnSeCBFA8ktjDqYxEyVyg3kT525A6eVo2vW4=;
        b=DUSR+xpvP5BO3p8KNY7iQ/8OuJb8KYpiqMBVqvhZ0ueCJtCypjws95aI+FY8i4SgL8
         Bkfki2qWy7lDdnsgANq2GM/F0cfS90pOZyvXgJpFmrQ0L8xminQpRWmI88ckK4aS7YMx
         TCdJIV8tPlnlMy+duIQ23+Nppk/hEkDTb2Qc2PZc/6Fj+NnAM/itBqDfyVPclIaT8P0+
         5ovr/CwhqIgbsNqazTGbdLpgv/qrjmXovU007qFZg1/7w+KKkReB7P1jm/mu9G/F3bjE
         /BJtk7scvtVNzkNpdQM1Gftx0V4SMvo2PNBdixOahs4/2QxYc1UNyZFEDt+cO9DmoAiN
         bYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155736; x=1707760536;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auT8vI6DnSeCBFA8ktjDqYxEyVyg3kT525A6eVo2vW4=;
        b=CzBqGdINbrwvzv2pOSXzlbYxcSfxAHfyEUwyg+hD5xtjJUEFSLZG71TnyfZ8R+SDOI
         IQKxTv5mMT92jllkz4/twRkr86ZCnzd6m75kqV3zVxTHPlBC6NniApC82cVaoRE0K3oi
         FytVyoNlU6VzAfWpjwoHnn7XBt9PBsqXMnlRL8l3n6b8KGwZl2yeIp3wNDk1FUXy8b6Q
         ZiGemupcY08oHVumRPteWt+ULJou/Oih5UP1cYuIW2wSye62zpWZZMxpp2KGpzmTvdb1
         CTVbqebU76HQkPWIaeTRAq30xBdm3uD5RI+iSaCzPchfi7EXmx6ucdG7fMdLOjSi4Z5q
         SEjg==
X-Gm-Message-State: AOJu0YzXaWNMcCy+E4vjAP33KCHVA+3N7/bW+1b8jOquSPI+eGgDBv+0
	027Ml9oDEDqg5ish6TW+2MfWE3PgwHWB9OrJMFn1EK0LOoYPYQPnMaUW3xOMr58=
X-Google-Smtp-Source: AGHT+IG/6yFeRtILUi8uQzg/5dW3uIR6uzBqY3zbYnTq/zIlKiV/48WRdX6UaZseV+JWMs5c13xNaw==
X-Received: by 2002:a05:600c:470c:b0:40f:dd76:27ea with SMTP id v12-20020a05600c470c00b0040fdd7627eamr369894wmo.0.1707155736246;
        Mon, 05 Feb 2024 09:55:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtvwgDMILYYx4FYXeAOdEmwLTDL/STgV96ODmFDGMaBI9lOJDB2ZD77u3fmy5KKG13tQ0PxoKwKDDEqzYfnQiD9K3bOzHFLK9mNvk/XCVSDiKpbUk0QcZTpPG/61bUKN4nwY5OudIXBqocZw0h7TsFaaAaqokU1FIBQWS1iYH3OWUsx0azYShVUWwc0n7h2QnE7pE5PMFjuJpCKAiLQgYrw2CA/kBmE7f32F2hfrAf24e480CKOy2Ds4zRG7QewGhtdFqsjGoioI0mGeonRvl+4+nYzCBrOLXQdqJg7AaWnsfAgkECK5QOBY3MR5bbHhjFBhFwr42+bl+NdUDx2kDGqXDVfXgn2o4XNqO2wfvixP25uoo61JoAA5FqT4jc4M88rMMJzQedeluEqqMeIoISw4Uo63YH6TVGEYJWsQ35TUj2P5qr+jcVR//dG1fjqnafaAEbQe3R98/h4t4cKhNuCT9UoAMaYAvkh4op2X9NsO5FoKTygmdM4TiL3EjGKf3O07kTttjESHdI6ZKVbcszad9P4dIpveqenr0ovYzR3RmiOzduIICPz7udweSV73m9Xp5Vp7aksUUPvoZT5NjnpMAJcFw1F1DmE8dGEDZkRRNf7lLhkBq2t+phEcLQFefapYPxXeac6jlcweGO9J9jmAbOL/Rbibbh/xGylIZO1ywhcQvk2EkXCr0LsvlbjsurtJhP0jGktz7z7O6pevzxe7YdjO57cZkrvo86JNUrhA2tRKQek8iDTFeHEQz/7QnV0gwOtVzU9GDYaSAgJjTKlk4ODXi+Bh98lk2iyaTv9BViZfeSONrXX2llkNY=
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ee8765901sm517556wmb.43.2024.02.05.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:55:35 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v10 0/7] drm/meson: add support for MIPI DSI Display
Date: Mon, 05 Feb 2024 18:55:27 +0100
Message-Id: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8hwWUC/5XQu27DMAwF0F8JNFeFROuZqf9RdJBl2hbgRyAlR
 ovA/14mQx/wYo+8w7kk76xgTljY+XRnGZdU0jzRIMXLicU+TB3y1FDAQEAltAQexmHuUuSL4Yr
 fLuWaMYy8KYnH2PIljRWvHWqQFmWrAiOoDgV5ncMUe6Km2zBQeMnYps9n9fsHzX0q1zl/PTdZ1
 CM91LkoLjhoDxE8BjDV25CmkOfXOXfs4S/6uKnJ1AZrG1Sj6aqNaY6bhsy2gRC9U1pZ2Jj213S
 i2mVaMq0BkL6Nuga3Md2PKaXwu0xHppOoAmITpN/+0/8xQe0yPZleA720kZVH889c1/Ubqe1PX
 I8CAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6209;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cEHab/mwa03OEYPIDPQQh8jv8KsmGrpTTQWOPDBBUbA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlwSETcapRBc3LSWb8wFmnAX64XWjRqucf2MzRQapS
 7+em39SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcEhEwAKCRB33NvayMhJ0UouD/
 4n4W1VVrI3Vsh0NRwTu33UacscISjSrdoR2ztg7Ogt/ImBK/ymA/IxHFcVYNAdNG/cRLm5ubHCldHB
 X4QOfL61sMAKdaaIk97E7VE/sYLBQlecMY9Ld7p+x2QDWwXKLMTZ/tY5HYRg8HAr4K3z740zkKGJOw
 6u9gO39lawAeAfDuQ/xNHjBLrn5w8VLJRND+YdjbEIqz4BaMBCqxajPN8oGODtyvqlq0JB5w6ebpNN
 Sr4n05ru4aD7wgSgf8XGvkblRvKXfk9DN16LnStK2CLqf9xM6pL3e8ZxqkDtNN8Qy+RMz5kQ1qpUG9
 zu5LocUZRdGQDgSF0+EQTKbIIIFEFXciBpL7PDFO7T1JPR/duz+gF2t09pERgqICR9PO7kolRMIPov
 p/9Y21yyILw0+xPjyYQvu3bXyZwhpVfKJ8uSu/pmx+hnsSDhn5MAN4CEFFpBw1B069FnoV3dyKQJtw
 ATkAqMfMsHbiJEdpS52eg6Xv34lM4Iw1GWqWWrChjxXpaPSIS33FgXb1ewOUM3H+PB/5TyMSW/Md5s
 SWHIxaQpN2SKAhBHYq6/94yCcoaKTzAMrDbBorPQaqOHXinj1DF2Gx8IkYjV5stfzejqNnskeTI6Xe
 0lqGgJ83s4kgY2eSmZg1jRtMvGmpRa7xsyKF2ZrKXa34D2UKWba1vXzqIpqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
glue on the same Amlogic SoCs.

This is a follow-up of v5  now the DRM patches are applied, the clk & DT changes
remains for a full DSI support on G12A & SM1 platforms.

The DW-MIPI-DSI transceiver + D-PHY are clocked by the GP0 PLL, and the ENCL encoder + VIU
pixel reader by the VCLK2 clock using the HDMI PLL.

The DW-MIPI-DSI transceiver gets this pixel stream as input clocked with the VCLK2 clock.

An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
DW-MIPI-DSI transceiver.

The clock setup has been redesigned to use CCF, a common PLL (GP0) and the VCLK2 clock
path for DSI in preparation of full CCF support and possibly dual display with HDMI.

The change from v5 is that now we use a "VCLK" driver instead of notifier and rely
on CLK_SET_RATE_GATE to ensure the VCLK gate operation are called.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v10:
- Rename regmap_vclk to meson_clk and add _gate for the gate
- Move COMMON_CLK_MESON_VCLK to following patch
- Remove CLK_SET_RATE_PARENT from g12a_vclk2_sel, keep it only on mipi_dsi_pxclk_sel
- Add more info on commit message to specify how clock setup is designed
- Remove forgotten CLK_IGNORE_UNUSED on g12a_vclk2_input
- Remove useless CLK_SET_RATE_PARENT on g12a_vclk2_div to stop propagatting rate _after_ vclk2_div
- Remove invalid CLK_SET_RATE_GATE on g12a_vclk2 since it's not a divider...
- Drop already applied patches
- move Khadas TS050 changes as an overlay
- Link to v9: https://lore.kernel.org/r/20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org

Changes in v9:
- Colledte reviewed-bys
- Fixed patches 2 & 4, commit messages and bindings format
- Link to v8: https://lore.kernel.org/r/20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org

Changes in v8:
- Switch vclk clk driver to parm as requested by Jerome
- Added bindings fixes to amlogic,meson-axg-mipi-pcie-analog & amlogic,g12a-mipi-dphy-analog
- Fixed DT errors in vim3 example and MNT Reform DT
- Rebased on next-20231107, successfully tested on VIM3L
- Link to v7: https://lore.kernel.org/r/20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org

Changes in v7:
- Added review tags
- Fixed patch 5 thanks to George
- Link to v6: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org

Changes in v6:
- dropped applied DRM patches
- dropped clk private prefix patches
- rebased on top of 20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org
- re-ordered/cleaned ENCL patches to match clkid public migration
- Added new "vclk" driver
- uses vclk driver instead of notifier
- cleaned VCLK2 clk flags
- add px_clk gating from DSI driver
- Link to v5: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org

Changes in v5:
- Aded PRIV all the G12 internal clk IDS to simplify public exposing
- Fixed the DSI bindings
- Fixed the DSI HSYNC/VSYNC polarity handling
- Fixed the DSI clock setup
- Fixed the DSI phy timings
- Dropped components for DSI, only keeping it for HDMI
- Added MNT Reform 2 CM4 DT
- Dropped already applied PHY fix
- Link to v4: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org

Changes from v3 at [3]:
- switched all clk setup via CCF
- using single PLL for DSI controller & ENCL encoder
- added ENCL clocks to CCF
- make the VCLK2 clocks configuration by CCF
- fixed probe/bind of DSI controller to work with panels & bridges
- added bit_clk to controller to it can setup the BIT clock aswell
- added fix for components unbind
- added fix for analog phy setup value
- added TS050 timings fix
- dropped previous clk control patch

Changes from v2 at [2]:
- Fixed patch 3
- Added reviews from Jagan
- Rebased on v5.19-rc1

Changes from v1 at [1]:
- fixed DSI host bindings
- add reviewed-by tags for bindings
- moved magic values to defines thanks to Martin's searches
- added proper prefixes to defines
- moved phy_configure to phy_init() dw-mipi-dsi callback
- moved phy_on to a new phy_power_on() dw-mipi-dsi callback
- correctly return phy_init/configure errors to callback returns

[1] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20220120083357.1541262-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20220617072723.1742668-1-narmstrong@baylibre.com

---
Neil Armstrong (7):
      dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
      clk: meson: add vclk driver
      clk: meson: g12a: make VCLK2 and ENCL clock path configurable by CCF
      drm/meson: gate px_clk when setting rate
      arm64: meson: g12-common: add the MIPI DSI nodes
      arm64: meson: khadas-vim3l: add TS050 DSI panel overlay
      arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   4 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  70 ++++
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        | 384 +++++++++++++++++++++
 .../boot/dts/amlogic/meson-khadas-vim3-ts050.dtso  | 108 ++++++
 drivers/clk/meson/Kconfig                          |   5 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           |  72 ++--
 drivers/clk/meson/vclk.c                           | 141 ++++++++
 drivers/clk/meson/vclk.h                           |  51 +++
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c          |   7 +
 11 files changed, 824 insertions(+), 20 deletions(-)
---
base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
change-id: 20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-b8e5217e1f4a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


