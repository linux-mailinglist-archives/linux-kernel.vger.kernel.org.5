Return-Path: <linux-kernel+bounces-72959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931B85BB27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E79B270EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510C67C74;
	Tue, 20 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="4xbaCJOa"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587F67C4E;
	Tue, 20 Feb 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430249; cv=none; b=jml5pmye5EHh7Wg6PTWaQNTyEpWCnVwi07Vc4xJCKrmnAd4ZmO2eCXYqD2ilseE46ITayym16uusv9BXomsA3tkkjQqRGE9yhcGEvesIW1iNij9wbsMCPYVUn0WAeRUIOKEo4qGDEou/5VrhT/u7l2OscGQ4VwMOv5np336Iikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430249; c=relaxed/simple;
	bh=RMDhUfhGZeArDSgF3ihV+uEwJ9e6YTGsJuPN6ZlFYfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g7r1fguv8zfqBlBo31YpZBpj4NMOf1RR8HGDfsHT7qj8i3X4SyHOIO/VyywfM8zr/NJ3NPWyiM/qeYCa1bbwCSRZkpKCFvqsGb6QEzngFAzAxaEmj5TMTcqWbHhz8SD3qky01wv95HWstaKY241/6YVqQjWJnzHCddZa3Bz/vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=4xbaCJOa; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id AA1EF40387;
	Tue, 20 Feb 2024 16:57:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708430238; bh=RMDhUfhGZeArDSgF3ihV+uEwJ9e6YTGsJuPN6ZlFYfo=;
	h=From:Subject:Date:To:Cc:From;
	b=4xbaCJOaovGOd/+tOZYgcpLOjpmu7qofuJpWg/BQ/2OUzYVgDpoGPrTKUeZ3tDhAU
	 0mgybVFk54nlnXw1ivfHPW5jYi3CoFyeQdE46Zn+k+7gDuwqSKvwp6cOhCrKw9vFMI
	 3mVdhWOfrW6LV/gQNQKWrdPEcXap0QH9pjZJzlw/6g/LFfwP6uHh/umJCZvdRKMcGq
	 A+oGcmLQqtCGroRrf2yOjZB7rtmJ2dQDQG4qAjk5tr4IR43AcuZgDZdhF1UE9GkFcb
	 SqaMxJiXnCZqFYBlWaD7JpSgKW8hexV+CIkdp68IC2VVkytTitqgrZYCAjzq9+gn7/
	 oH4gwpEeMcHtA==
From: Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/3] power: supply: Acer Aspire 1 embedded controller
Date: Tue, 20 Feb 2024 16:57:11 +0500
Message-Id: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeT1GUC/1XMQQ6CMBCF4auYWVvTGZQGV97DuBiGUboB0mKjI
 dzdQmLE5XvJ/00QNXiNcN5NEDT56Psuj2K/A2m5e6jxTd5AlgokWxqOgw+KRsWUddGQsCA7ghw
 MQe/+tWLXW96tj2Mf3qudcHm/jNsyCY01NVeKQuSsdZcxpO4QnrAgiTYh0l9IORQ+Vidly47lF
 87z/AFsS4Mh2wAAAA==
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=RMDhUfhGZeArDSgF3ihV+uEwJ9e6YTGsJuPN6ZlFYfo=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl1JOaHlnQv5HkaeWvoA8Eb7/agVmUR11TCkWGZ
 z0AJuWPbAiJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZdSTmgAKCRBDHOzuKBm/
 dSaHD/4vK0CrKhObBMgsUN4WbMEmOT31itMTdjzS9oWl5rROkXvarhv/AKED12zI+CcmOl2pDsS
 iSJREUYk3q0KccBWNna1quTVNBSqiLWwBUENZJprbu3mb9b5qWiPGNkENJsXFpkW2LExTvSO+pW
 T5+C9oQY81iwZ63t34zQS/0ZE9XMUkCP+n/DD3UrwL+6ma0mfRs22GNZG1gsufuWR6UTV79tgfO
 7aWIrzgwtNU2PKRDIn9rWaoWDa7xGnayobdnc8KXck/1fKo42Y0ug3DpODpqsNyfOwO+R289xgv
 pbg2zOXN01FWpEJ5ebhlp+eTMY9cEHvATUOtrr3jVRCkFxApAA92xlQ3OgAr0q7sasGA/g8Megy
 lkQQiCqW3ohfUEcaI1APVT45R+t3agJPOeMLBEP1EI8QVp+LR5xRecRbg7axNxp6qqTnOz+hMMc
 ME0I1UtDGGu4Wr1K4fibi6CVtEyt7t2Z7X3otZxjitJUAjRU6ejEdyYcgmWMPa3Zp9HkkaiCLJg
 ciAVyxxfuvbnht1NBoD+DNaFFnr2cT32ZXv8f3i9ccnMMmaZloIJy65i6NFfvtcZebcZtTebjks
 ltHRpCED+rE9qRGd0GdTiI+rtKyHUEm+gbiK9RvPmv4W0ME1GvhJTwlFuzpMFJJKGTT8YksDYEd
 tvnjjMbJtPzpiFg==
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
Changes in v3:
- Supress warning on few no-op events.
- Invert the fn key behavior (Rob, Conor)
- Link to v2: https://lore.kernel.org/r/20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru

Changes in v2:
- Drop incorrectly allowed reg in the ec connector binding (Krzysztof)
- Minor style changes (Konrad)
- Link to v1: https://lore.kernel.org/r/20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru

---
Nikita Travkin (3):
      dt-bindings: power: supply: Add Acer Aspire 1 EC
      power: supply: Add Acer Aspire 1 embedded controller driver
      arm64: dts: qcom: acer-aspire1: Add embedded controller

 .../bindings/power/supply/acer,aspire1-ec.yaml     |  69 ++++
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  40 +-
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/acer-aspire1-ec.c             | 453 +++++++++++++++++++++
 5 files changed, 576 insertions(+), 1 deletion(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20231206-aspire1-ec-6b3d2cac1a72

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>


