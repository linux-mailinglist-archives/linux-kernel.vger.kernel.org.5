Return-Path: <linux-kernel+bounces-147387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC78A733E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD4D1F21B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B61369B1;
	Tue, 16 Apr 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kqKrEHo1"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE21C06;
	Tue, 16 Apr 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292275; cv=none; b=q6/CgW0B5wWSvutx505HAPdoK0j7D65X8h/6ocY5HbWpiBG1h1oYHTTsIwTpBu+w+Bn+BO4qfvtHXKUKEywB9txMhqgSfgksG2uCdr8GqL5B5iUmFozoJY9OefzlP7i24uAeWtw1WlFWHZ3pwyTZProrWcT2MisIFNdBJiBC3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292275; c=relaxed/simple;
	bh=rzC5W1TaCb9OYzxdOKGyAXPykw9cGXSoLeHQch7h958=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ghSHvqigmNB1hHExPRuQo170LxmfsQhVkbhAZ4aompv8Z2vSNYXasEzh1u/ZYGZSFiaUyuUCmIXnlpLeFsTOkw4krUI8sAStxdEuw/udNcDnFcBRv1odPglGaqvVFgN0YAE3fka+1gNR1q3gzfngpZaxTtKXrRKK+Z7EZDBgN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kqKrEHo1; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4063BE20E0;
	Tue, 16 Apr 2024 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713292269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CDEkPdtKTNgd1iLFlJr4m5I7DfTRIEGCJhDqsto7S8E=;
	b=kqKrEHo1pbhQ4q90yt5ppV/kDqBM412ZH23DtnlWM5son7smI/mtbCocuiEd0jAxVkyYtj
	MG2QMeINp4283CTadR7wg6IRgNIUe15YuN/fS9ppYJu2bzC7xLfnDvO9SHJAuisk9hOhPf
	8onesEvjlU4SdYqak1qoGPECcD8U0HPKZ0eaJTAMlMvnYfA4jl55YoOLQNyFyCkaNaDQKj
	AFe5TedYsPVvuEaqInUnymlUjCCJsVL4FD0R0iA1bvQphbp818XopUUW5A0qHDajygaBkT
	fRs8iIevRiT2fo+noUX5xIbof9Q2oEPbDk1f2fvy+WxETp+iEAryLZAEtcGaug==
From: David Wronek <david@mainlining.org>
Subject: [PATCH v3 0/2] Add driver for Raydium RM69380-based DSI panels
Date: Tue, 16 Apr 2024 20:30:47 +0200
Message-Id: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfDHmYC/4XNQQ6CMBCF4auQrq1ph1LBlfcwLkCmMIkUM9VGQ
 ri7hZWJMS7/l8w3swjIhEEcs1kwRgo0+hT5LhPXvvYdSmpTC1BglNFGcj219BwkD7bKSyVbpog
 szcEBNNaBcSjS8Z3R0WuDz5fUPYXHyNP2J+p1/UtGLZUssLRNDaZSTXEaavI38uS7/cidWN0In
 1bx04LVAgPaGqtzZb+sZVne/26T/g0BAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, David Wronek <david@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713292268; l=1909;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=rzC5W1TaCb9OYzxdOKGyAXPykw9cGXSoLeHQch7h958=;
 b=fHVKKYgh2Xauj1zzwwZfD7fVDUSHyQbzzy8cMaSXyu45ThbcnMq9DmCxgd6s4bzXCnISa63oG
 n0+jqf0FGN8D9RP9FYhxxXnkRX8e3/bUqdDQoey/lSkQOotsVK/2sF/
X-Developer-Key: i=david@mainlining.org; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

This patch adds support the 2560x1600@90Hz dual DSI command mode panel by
EDO in combination with a Raydium RM69380 driver IC.

This driver IC can be found in the following devices:
 * Lenovo Xiaoxin Pad Pro 2021 (TB-J716F) with EDO panel
 * Lenovo Tab P11 Pro (TB-J706F) with EDO panel
 * Robo & Kala 2-in-1 Laptop with Sharp panel

Signed-off-by: David Wronek <david@mainlining.org>
---
Changes in v3:
- Removed unneeded curly brackets from some if statments
- Fix error handling code in probe function
- Include video/mipi_display.h and make use of MIPI command definitions
- Removed DRM_MODE_TYPE_PREFERRED
- Dropped 'prepared' bool entirely
- Register second DSI host using mipi_dsi_device_register_full()
- Link to v2: https://lore.kernel.org/r/20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org

Changes in v2:
- Fixed typo in Kconfig
- Removed ctx->prepared = true; in prepare function
- Switched to drm_connector_helper_get_modes_fixed in get_modes function
- Changed dev_notice() to dev_dbg()
- Add description for compatible and reset-gpio in the dt-binding
- Always require 'ports' node in the dt-binding regardless of compatible
- Link to v1: https://lore.kernel.org/r/20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org

---
David Wronek (2):
      dt-bindings: display: panel: Add Raydium RM69380
      drm/panel: Add driver for EDO RM69380 OLED panel

 .../bindings/display/panel/raydium,rm69380.yaml    |  91 +++++
 drivers/gpu/drm/panel/Kconfig                      |  14 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm69380.c      | 367 +++++++++++++++++++++
 4 files changed, 473 insertions(+)
---
base-commit: 66e4190e92ce0e4a50b2f6be0e5f5b2e47e072f4
change-id: 20240414-raydium-rm69380-driver-47f22b6f24fe

Best regards,
-- 
David Wronek <david@mainlining.org>


