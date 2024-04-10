Return-Path: <linux-kernel+bounces-138651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1889F8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0E71F23A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752B16E874;
	Wed, 10 Apr 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KYHzQ4Pk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B916D9D4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756467; cv=none; b=i0pXh+IXArI4MxBBuFvHG394Xk1UbCxdHwq5Rp5km1P0Xa7aEpgIwoTOh77kbY6Epcc4Bp7/wzWyDX33NvSNk1O69fDjosIe4Pqlww8Est1LFXKbbSBPBXI3urC5ijVa++H9HvloIR3gGRDaD0XfWqbE4hV5/yf2m4SWQScELQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756467; c=relaxed/simple;
	bh=w1yxUr+e94JNiQhyApXQzG14kOfbhJO7Nrggm3f4iz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmFNOH7E0rxDL19oBpHDuEFYt6XES0vjn7w7cP5lxpAITg0auLBfZX7e54f5PkJZkfNE+RnzCgJMLtoEou8sQPsIRn68sUKyWb/ZprolI1qbNatVuP4iZBl5niB4NOvWAfaeACFxsXwn0yQAcTIu4dnGBHUSBg11LQ64YLnKS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KYHzQ4Pk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417c5aa361cso923245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756463; x=1713361263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgPnM0yPd3XkLtMCMzEU9ADT5EI0Xg/1xBhNwZOIrjI=;
        b=KYHzQ4PkeM3/nE08Z8ZT2FFaH2PPHn5tnP8IID0p9+ZBAIrMBGIObzHw/nCycwlxdd
         IEkaLWP4wuadKxJR33cZOp/Y9UwOhAQ4kfTCTNsTZElyuvTbBWGi0gmwb4VnHkCVa7qD
         dGhSImrZCP+/CtSkZVG3KSsIpcD1hbC0ZiSFDqzdpPpQQF71NcZR/6bYibqkwNh0VzXX
         wRpO/TwKFAmJFrvrglmLBUe+Zi8AcayguNlFkydZovPZzhFZtbT1Q1wjADKVfLQUVs1L
         q0bH/O5pESqyW55VbchWyTtJ1nrheynA8igjWJ3sT2gqJzeLWOpqe3YjetICeRMBqulO
         RBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756463; x=1713361263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgPnM0yPd3XkLtMCMzEU9ADT5EI0Xg/1xBhNwZOIrjI=;
        b=c8IKLYcCs0vgOOgYiWA7nIZQiQjcEPyqsn9u1ak4urHyktEkf1WekUmU0vf7U5rmqw
         nEGJxK4vtn9URcj+xCcSowiyXh4/s7uvOfCX2wX4TPV4YfzPwPQko+PU9tEYqzmw4XcT
         2rs0WSSveTgMsxuXK4sWu9ZQYY1FVFpUbeVdlBXps8L2s8WQLzmn6HWtkmsesxkmM6i9
         VPHPu5QQn189dgRmj/2elGyr3yFYedYJ0bi3teFu9bg92k+haJLpqysm/iTXrsReiRr5
         Y7/KdyMtq6zcCTGl0tIEnV0oTdIX91ZO1YuSZJ81fN7i2Fm4OejevWiSQT3JIKtmR2k7
         oeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTVg75XP3FuA4rnPyXbd9VuauH4lqVf+mh7QEu3GFoVxBaOtL0tENvzsNdchF8Yz6R8l6XRM36pqxmm+UwdCI1NC/OxSP/qYSakU7J
X-Gm-Message-State: AOJu0YyHSRMVKRme7ww+gq0XObLGs2uSTWuKV0QDQ9/TgfWn04gRh0gR
	alcuLEhmhMvU8cthmZeLVs0IqE/Urml8fSz7lRkdnK0Fe2Sc+ZKp92RoJL9SfnM=
X-Google-Smtp-Source: AGHT+IH6UhzKqls5jFfJx0V6zACCsECFizHKBE462Q3yuyDJDifrfACAWokgDHsk+oJkkHbGFJL4Xg==
X-Received: by 2002:a05:600c:3b9c:b0:416:b099:7878 with SMTP id n28-20020a05600c3b9c00b00416b0997878mr1854806wms.4.1712756463431;
        Wed, 10 Apr 2024 06:41:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RESEND v8 00/10] watchdog: rzg2l_wdt: Add support for RZ/G3S
Date: Wed, 10 Apr 2024 16:40:34 +0300
Message-Id: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds watchdog support for Renesas RZ/G3S (R9A08G045) SoC.

Patches do the following:
- patch 1/10 makes the driver depend on ARCH_RZG2L || ARCH_R9A09G011
- patch 2/10 makes the driver depend on PM
- patches 3-7/10 adds fixes and cleanups for the watchdog driver
- patch 8/10 adds suspend to RAM to the watchdog driver (to be used by
  RZ/G3S)
- patch 9/10 adapt for power domain support
- patch 10/10 documents the RZ/G3S support

Thank you,
Claudiu Beznea

Changes in v8:
- added patch 9
- collected tags

Changes in v7:
- updated the dependency on patch 2/9

Changes in v6:
- update patch 2/9 description
- fixed the dependency on COMPILE_TEST previously introduced in patch
  2/9

Changes in v5:
- updated description of patch 2/9
- simplify the code in patch 2/9 by using on a new line:
  depends on PM || COMPILE_TEST

Changes in v4:
- added patch "watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and
  ARCH_R9A09G011"
- collected tags

Changes in v3:
- make driver depend on PM not select it
- drop patches already accepted (patches 1, 10, 11 from v2)
- re-arranged the tags in patch 8/8 as they were messed by b4 am/shazam

Changes in v2:
- added patch "watchdog: rzg2l_wdt: Select PM"
- propagate the return status of rzg2l_wdt_start() to it's callers
  in patch "watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()" 
- propagate the return status of rzg2l_wdt_stop() to it's callers
  in patch "watchdog: rzg2l_wdt: Check return status of pm_runtime_put()" 
- removed pm_ptr() from patch "watchdog: rzg2l_wdt: Add suspend/resume support"
- s/G2UL/G2L in patch "dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support"
- collected tags

Claudiu Beznea (10):
  watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and
    ARCH_R9A09G011
  watchdog: rzg2l_wdt: Make the driver depend on PM
  watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
  watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
  watchdog: rzg2l_wdt: Remove reset de-assert from probe
  watchdog: rzg2l_wdt: Remove comparison with zero
  watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
  watchdog: rzg2l_wdt: Add suspend/resume support
  watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()
  dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support

 .../bindings/watchdog/renesas,wdt.yaml        |   1 +
 drivers/watchdog/Kconfig                      |   3 +-
 drivers/watchdog/rzg2l_wdt.c                  | 123 +++++++++++-------
 3 files changed, 76 insertions(+), 51 deletions(-)

-- 
2.39.2


