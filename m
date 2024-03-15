Return-Path: <linux-kernel+bounces-104467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E539D87CE58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201F31C21863
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C165381A0;
	Fri, 15 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="OXjMap49"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012E2CCD3;
	Fri, 15 Mar 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510718; cv=none; b=u52+6o4jbbYgxBualcZNO4hExq2rB73ZKhTnx8cRBkkFR+V/NKi5Utc1Cf0gdumNHfLWVFK9rZ9Zp1n9PN1+z5t/fEFRL8xEwGKeAU7LPL3wXjakAhByQY1yiZBZX6l/6xCxBngUgkTjMtG0L5DZcQF1+sBy2q7bkI3FHXHyPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510718; c=relaxed/simple;
	bh=uGoPq4Lf85uKEfAzB8xxk9zWPd3pSWdJbpTAl7yAUrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EudAYEIGBbNIHWW4vjNBHxJAPkehHIKh8c6Ss7N+sDErNKeGf8aGFTTA+JrWybAa5dg4/bpr7Bw3+roV95r7TAO5SkyDwglEVrrrPv9dkoonFd/FgeYWhke7DUAP4DK3KP9nEhoo2orS2aUGGLwMxhrQ3csBNp3lWzNsrK4XA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=OXjMap49; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 4906341DD5;
	Fri, 15 Mar 2024 18:51:34 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710510695; bh=uGoPq4Lf85uKEfAzB8xxk9zWPd3pSWdJbpTAl7yAUrg=;
	h=From:Subject:Date:To:Cc:From;
	b=OXjMap49spoJcRB3dzyVrDybyiR7NERozfq6yrdtP19I3NGN7qr6/wBJR7xvpuera
	 I6JfjNZF4YXqX3YrZrrgehQ0Y49+6y+Olfn4P7aOaKV71AWxh45t3qILUTdn0jVHnh
	 t1JCoIlpeCRWUw4GHDp3LlPxyfw5pFKXqZ2rXUEyJG2grD5gwfOkUfg1g0DFRjdrqn
	 b0ITCKY5g/r1gtBgWkahCXKZdqpE9vMAx0/+FNGSiLZP3J4+ij9t1kpzCzWMzif+NC
	 NdU2kkHS734IKnC73ZeMgIsrkkrQnrhMx/7GmeLBkv4Qv2iGSXJxMzPY4HpR/X0V4g
	 tKHXXWUJhyL6w==
From: Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v5 0/4] platform: arm64: Acer Aspire 1 embedded controller
Date: Fri, 15 Mar 2024 18:51:14 +0500
Message-Id: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJS9GUC/13OQQ6CMBCF4auYrq2ZmQIVV97DuBjKqN2gabXRG
 O5uISGAy9fk+ztfFSV4ieqw+aogyUd/7/IotxvlbtxdRfs2b0VABgkqzfHhg6AWp6vGtOTYIVt
 SGTyCXPx7jJ3Oed98fN7DZ2wnHF6njF1mEmrQDdeCjsgC2OMzpG4XXmqIJFpApBWkDB0XdSkMb
 NmtoZlgAUSwgiZDINegqTM3uIbFDM3fj8VwarsXI8L5mssM+77/AekGzBxNAQAA
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=uGoPq4Lf85uKEfAzB8xxk9zWPd3pSWdJbpTAl7yAUrg=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl9FJiRaeXOTyjLMezkAVJzcxIuMN6Gtx9AbBpm
 GqMsPPDys2JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfRSYgAKCRBDHOzuKBm/
 dSmlEACBYiTVFRcFAL6rqEAM4cPXAfwQ8h6wt628Wk4S299uN3blayxYAjIjfPpmcuvXjjmHS/y
 ks/ruGOIxY1F7rGfll8fiFckI2gBkxZ57JH17Fnh0B1PTWwlxPYnDy3+7fHQ5UXDZRTt5l2htll
 2PauxmG44DaLhxqI+08odWQcFxaUxz6xyMSeIadaDWi9gXvvJGRgOp6MDgBZWaq1iAqyH45nQZI
 sePYWYTUSD8ifcsX2tPejVAGBG+6Bd77U5OFHFsQwLyj3CsprwCve03G1oBzVVbffvGMDjgz9CO
 dVPL7cvzvzhB3WBR6zMLNxEZbH4T7p5LQqTzcpyG0IkO84zexf7UpQDd7pLchH9wj56ij5H3nE6
 dOB0qeB8zFFQT65UCZnAVCmL9H3fGOpMpKAPdrC0RI+r6k6vfpmbHXt/SmTFBc8rZh1kHos313O
 IKSFGuSxkV/K+Uc8MoFCwSwR0omMFFVGhU4y4rQJedaBTHoV8Jfm/w2xRfbR8Ikuzz6+BzYGwmf
 aTV7Tj25ScV4AD2bQ5xlDhRHVPR+GsGU4nGUHUcDR28rCyOb+7py08gBo0weLi6zwMdpcd4NRvp
 XLiLrYafelAyf3AbFJ1NQhfCwYi213zpjnI2iR0hH79HKJbIX1r0HbVytXEzmL6n32xw+ivVxT2
 7l+TELQDWGkHXfQ==
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
Changes in v5:
- Various cleanups (Bryan, Ilpo)
- Add Bryan as Reviewer for platform/arm64 (Bryan, Ilpo)
- Link to v4: https://lore.kernel.org/r/20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru

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
 MAINTAINERS                                        |  16 +
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  40 +-
 drivers/platform/Kconfig                           |   2 +
 drivers/platform/Makefile                          |   1 +
 drivers/platform/arm64/Kconfig                     |  35 ++
 drivers/platform/arm64/Makefile                    |   8 +
 drivers/platform/arm64/acer-aspire1-ec.c           | 562 +++++++++++++++++++++
 8 files changed, 723 insertions(+), 1 deletion(-)
---
base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
change-id: 20231206-aspire1-ec-6b3d2cac1a72

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>


