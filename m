Return-Path: <linux-kernel+bounces-99973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A733B879010
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E65283F18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18F78265;
	Tue, 12 Mar 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="FapqdML2"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFD77F07;
	Tue, 12 Mar 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233549; cv=none; b=DVIf2wldrCvCmdQqjBRFBmQdLWeCfCV9GVG1ae6VBr06od7OJy7NXurBOOLnO5zoTQh/GMGFE7cnAKol5E+qU835IuuS3FJhmqPJLE5XDEZFlUlVyw9UjWhKroBNPjC6+EZ6vTuQgDjouJFq24vWaC0At0JYAKRKRPa57e6dHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233549; c=relaxed/simple;
	bh=slL5bRycpHhI2+Y7J6KNxlIBy/lluYrU3g56qphs/Tw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=swL55mjBfOG5wFPtbSgu5yv6Fr3Y1IJtJnu7Nabb1nvnkQSnfqrGLybFXVL7IunFH7BQ/fIKU77bfHSM50gBc9IESBQ9jjP8EibqX28nRcv35iHTL/lN+rbdXzg9ecrijmeOyaaVNzD2zkewuJ/AGAEmXJ9WtlDNjlwjb7PzY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=FapqdML2; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id E6630400F9;
	Tue, 12 Mar 2024 13:42:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710232941; bh=slL5bRycpHhI2+Y7J6KNxlIBy/lluYrU3g56qphs/Tw=;
	h=From:Subject:Date:To:Cc:From;
	b=FapqdML2C4/6AC9fAy5pBSc7KVObiY7aABWf24FdWul2S9QlDKemBiErH4YP0VjEM
	 VfN/8mnBsqSyPWw7csIC3PJcEbVvAKoNv6XgOJbNmAPHPvv+t4msbAl37ggeG5LMSz
	 GTIoRsSb6xrzKPxhI1ruMkGDJIF2hEFtOjEyWfovFbzMaoHyMmtIwpyfZc1HdipCOr
	 XjCY8Mbm5keZQOTVM4LCWU+yGKBvBllmMzIfC/DL/kWlk6ueV/FZrRJNRvpSFJy78m
	 u/3mulPJ5QFEVRi4AhKQtQqGvMcrn9CZSQeoJ/iUJkNkO0rU93vKsAus43fzo4iJ6M
	 hlBZLc3uo2gFw==
From: Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 0/4] platform: arm64: Acer Aspire 1 embedded controller
Date: Tue, 12 Mar 2024 13:42:06 +0500
Message-Id: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4V8GUC/1XMQQ6CMBCF4auQrq2ZmSINrryHcTGUUbtB0mKjI
 dzdQkKE5XvJ948qSvAS1bkYVZDko391eZSHQrkndw/Rvs1bEZBBgkpz7H0Q1OJ01ZiWHDtkSyq
 DPsjdf5bY9Zb308fhFb5LO+H8rhm7zSTUoBuuBR2RBbCXIaTuGN5qjiTaQKQdpAwdl/VJGNiy2
 0OzwhKIYAdNhkCuQVNnbvAPp2n6AUpcigsUAQAA
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=slL5bRycpHhI2+Y7J6KNxlIBy/lluYrU3g56qphs/Tw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl8BVoNtD/XcPJO4FKbwDVc2v3P0F8OnfolTAbY
 Vi5SvGn5lyJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfAVaAAKCRBDHOzuKBm/
 dTXqD/9mLhyNTyI0MH6CWQDuTVLVYqpnYMOOCYwoWd2zSovWgp6HSI67FmmCHt/neu48iFk9o1f
 5xNcN+KSj7Y8X16eZFfWf1bAtO3ZmJdJa5qctNftmh3xN7fQ4Tiiz+/gMSfQYhB9dnXDKZgQT28
 /16c528q0nnFqV57FrOsq0aQjG4SamUJwzRKtsFJkLEGmnO7+9Xp7b393XCbwMZwpAUkWp4I5Pc
 0p91Or8ds9B0cXDaMcJJwoJmKz7/kq9V7H7kTRURBw7bqtSoFF3xQb8sHFXWphWdnaSUNd6dLvz
 UHi4jlonmJWXRSWn3j77I5q+A1y1vbiGidYz60lXyZ6ptb2LVVBT+aEPq9vr67dB0aVhn/+T7mS
 2GDrD0l1Ws7B46Vztz+46EgncHgHwA0kobex6WwYtktBsxgHJJ3LF/mR97kfw7ckoOUsbLuX1xK
 aREfsfDZLMfOz46um2V/B4WzvgQdauiukbZN3BmFFOQBVkFOE79n/O9+KsAMJQtVqn4zNo0xCr1
 D0uJUulbAp3gT/vKlVtuYWKZxNT0CIHEzworVdJ/OqmCUK/fFtFsby6ahluFWsIXXNh+z3z/uVf
 Ce2QTFOuUxkRpWx8RY8xFgg5vILwq653Evf2R8QkmOHIJFwsdX43xwA+aOF2c0F/vgmuf+Dv0II
 jTY8p8xLc0BRFBg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Unfortunately, while all this functionality is implemented in ACPI, it's
currently not possible to use ACPI to boot Linux on such Qualcomm
devices. Thus this series implements and enables a new driver that
provides support for the EC features.

The EC would be one of the last pieces to get almost full support for the
Acer Aspire 1 laptop in the upstream Linux kernel.

This series is similar to the EC driver for Lenovo Yoga C630, proposed
in [1] but seemingly never followed up...

[1] https://lore.kernel.org/all/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v4:
- Move to platform/arm64 (Sebastian, Hans)
- Drop fn mode dt property (Rob)
- Add fn_lock attribute in sysfs (Rob)
- Report psy present correctly (Sebastian)
- Link to v3: https://lore.kernel.org/r/20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru

Changes in v3:
- Supress warning on few no-op events.
- Invert the fn key behavior (Rob, Conor)
- Link to v2: https://lore.kernel.org/r/20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru

Changes in v2:
- Drop incorrectly allowed reg in the ec connector binding (Krzysztof)
- Minor style changes (Konrad)
- Link to v1: https://lore.kernel.org/r/20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru

---
Nikita Travkin (4):
      dt-bindings: platform: Add Acer Aspire 1 EC
      platform: Add ARM64 platform directory
      platform: arm64: Add Acer Aspire 1 embedded controller driver
      arm64: dts: qcom: acer-aspire1: Add embedded controller

 .../bindings/platform/acer,aspire1-ec.yaml         |  60 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  40 +-
 drivers/platform/Kconfig                           |   2 +
 drivers/platform/Makefile                          |   1 +
 drivers/platform/arm64/Kconfig                     |  35 ++
 drivers/platform/arm64/Makefile                    |   8 +
 drivers/platform/arm64/acer-aspire1-ec.c           | 555 +++++++++++++++++++++
 8 files changed, 709 insertions(+), 1 deletion(-)
---
base-commit: a1184cae56bcb96b86df3ee0377cec507a3f56e0
change-id: 20231206-aspire1-ec-6b3d2cac1a72

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>


