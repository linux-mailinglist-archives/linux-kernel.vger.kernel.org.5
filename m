Return-Path: <linux-kernel+bounces-144224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A098A4357
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6F281662
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ACF134CE8;
	Sun, 14 Apr 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Dyti9lVC"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7213473B;
	Sun, 14 Apr 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108694; cv=none; b=uoQBgJekNJxZIfrO0lIgYhxHH8wCNSK92bz2GgcqunTL75yjURU1Rf/ItV3fgG9oYRWVwYaiA/yjoDG5RkR2JsqdecJ4qQyCI95Mvc8NAx0hgcgo6wC5O0/0BdFre0goTQYIEHY2yImYHYM/jEOrIKVTcMMpIlIEccNBwB3O2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108694; c=relaxed/simple;
	bh=KCbN3AaRoKVj9vjtbieCSuk6IriODycJBXnS4VDwxFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tc+sPAnh3B7121f0eF88Hw7etK7oQwDFFlGBWibxITeLGDUD8f2ikBhfsctk6mkVjdBYkZz465+fxx26h2qkj8sB8VTI0xmAwUkqR5xQwuAS5GghKyksJN12j8jHNjsfm+O46w1iVUb/POBOfBCgJc3FKaR5nZ1rvrFAsm7t5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Dyti9lVC; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 931B5E21A1;
	Sun, 14 Apr 2024 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713108186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qT61WY3ccUFg/GjjL36acuqJpraSqI5TD4a9LEcwBYY=;
	b=Dyti9lVC+bTG/7cWYHVrB72GeSYwNkx0ZK/wuyyReNyBbvgUO1GQ1qPyjHasZu6pA+toda
	gkfJh0ANqFXzDcNWRjhReZVyy+uMzK3o0HjRSDbuOLNeITG6pGwYLnquz2OvpxpUDH/xBW
	Ymu+nIzEFCADglUlaqj+m1Ciu8bFuNCeNNW77ut0vMpS/mcbkoR+dpuCIRbFGvEItiRGns
	xkc3X0i/DOS6p/sYUDSqAuJi34OM3IfihekYb2xgyjCm4y1YSWjQbYy22TgSYlzN5mukpQ
	Uxhv8rwRB9oMOMNqbmPk8h0fuRej5A1t05A2bPxQcRihpznhFE+BkHmzrFHlZg==
From: David Wronek <david@mainlining.org>
Subject: [PATCH 0/2] Add driver for Raydium RM69380-based DSI panels
Date: Sun, 14 Apr 2024 17:22:29 +0200
Message-Id: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALX0G2YC/x3MMQ6DMAxA0asgz1gKxkqhV0EdoHGKB6ByBCqKu
 DtRxzf8nyGJqSR4VhlMDk26rQVNXcF7HtePoIZiIEfsuGG08Qy6L2iL79vOYTA9xJAfkWjykTg
 KlPhrEvX3Hw+v67oBjbh+B2gAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 David Wronek <david@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713108185; l=1013;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=KCbN3AaRoKVj9vjtbieCSuk6IriODycJBXnS4VDwxFo=;
 b=SO3+/vE1qxF8sxuE4CShhuqNMdm5yxMqzGqrsaCQU11XkTm3wM/ZK2IUa76Oyy0XUaFJ/Fp0J
 itQy7Mk2gstAxDZ6TlGbfRHx4RlYYVEQ2xoDhBYoS5F2CCeWE5B/EZv
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
David Wronek (2):
      dt-bindings: display: panel: Add Raydium RM69380
      drm/panel: Add driver for EDO RM69380 OLED panel

 .../bindings/display/panel/raydium,rm69380.yaml    |  94 +++++
 drivers/gpu/drm/panel/Kconfig                      |  14 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm69380.c      | 378 +++++++++++++++++++++
 4 files changed, 487 insertions(+)
---
base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
change-id: 20240414-raydium-rm69380-driver-47f22b6f24fe

Best regards,
-- 
David Wronek <david@mainlining.org>


