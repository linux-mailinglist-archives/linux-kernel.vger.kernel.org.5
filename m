Return-Path: <linux-kernel+bounces-109437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1288192A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3392842A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0485C55;
	Wed, 20 Mar 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6WEZKGi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361838F96;
	Wed, 20 Mar 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970437; cv=none; b=ZXaWxcF03oBqsBDzx3PwjqWrATrYLH2MI0PkCxsCHFEd33ZQEbbm2pxzbn/23Hph96Cmw9ftbC6WgZtTJe8d/mQK62Oa79bFRoLde82n/hGVjnPhF1vjhrWr8zvSMvl40Cs+z8QtJtc0DNJSWYpcO0A75/pI9VMKaTjXLjXmfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970437; c=relaxed/simple;
	bh=9po42VtNCWVTAdVKwkrdxiRN/cLeeuxRg1UjTd9aWEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lGSplyps4tZWCi49pgsNTH5o1vIF65qALOBHTz6qing/E4nWkBnhHqWX3SSy/RecQoWTVO6NjkFygCNbMSKGZsOzoKphEvSn4x3w1GPusn8bVqQDzK16JVlTs3laxKL+35q9QN29EAo8inEFsM6oUdJAekUgsA/UH3pD4+NqTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6WEZKGi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4146fe16a1aso2332805e9.1;
        Wed, 20 Mar 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710970434; x=1711575234; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpG5/QJ7+7xCTiH5bZDPq7O3h3XOgm2ds8JyykvemFs=;
        b=N6WEZKGiVbNB0MDFGOgy3naqGhTvinBRYbcd5P/6zxRQaIkBVC9hw2BXSZBEpPSosu
         kL018LXHZzUFSGHazu1aJ91NfOmcUcoXbDvutqlfL2/ysrq36AEogTN4XR0VxFAwkrwW
         RkoN0pQeexYzOjZFtk5cvzQ+ZycQFBZozYXdbGRnpQ3W8uHhYgsB2iGnJgpRPH/jISxL
         Clir8eW2vExc3VxhFnn/UfAUu5hjhel6jzVFvmwXP0tlatj6boFRdf6av+OgnX37MJrs
         R7W+FLDRU3OHeh5Z6WFrfL8qLYqm2fo0QM8MazsH1Qg6ImaddcSFuFWjJ3XwslHjpxv3
         R0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970434; x=1711575234;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpG5/QJ7+7xCTiH5bZDPq7O3h3XOgm2ds8JyykvemFs=;
        b=gm8baI2r2flnXMPV7r2d1I6Uo29H6h735hctNgYqIr8WereUMuhiYUV3J7zUfnKEFk
         gEfbLDV0VDOVui+iSSj2iO9j4JC8WHVErGIrEnV482Zgz4Wgx0n64f7OxAXto0cnPmy5
         VzUDx8fedAlvUH834hOmviWm4aEUxYE2o0JKQoLOOaOSWzWS7duXZXV8pC6rqRLIUqSd
         ypxI5xnzIl8gWUi+g9qTCSRAqqtNHczuu9EO5qFNiyuhnWAKZG4NR3cG4hc0q1vJelEU
         loWKFXFyNLwJ5lsNy2yNjk8B/sNTTS4TU7QEWtIgo9cZNKe4scj2aaNIx2fWGsQIT/DC
         ZhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZApGQm0PA4t4ks50z2ifU698n2fPLe9KuDcTUIW0WdzGbwO3RYrEX9/4mlNZYrGRrX8wA2Tf4yeoFyixoMmvrtNNX2chXPuEaDTvrkfLFxk8lacNQznpvE/GTegSGnAwMXQr+XSyV+w==
X-Gm-Message-State: AOJu0YyHnGSpUsl/V/wJD4MILIX472r6ieEZJl8fTMn9MBicvoaP/1Nd
	bXJe/umZZ215K2n5C7l4vI4do7SAYhYTqVxkVSPdcTT8gbanvMVeLRTpqgbh3d0=
X-Google-Smtp-Source: AGHT+IFqti5ujR7izI6EPODMNsE+CcVGLz8/Sy9EupnoDTQlcmoQlIEmGAk1SrNIwgECdX0USwoRiw==
X-Received: by 2002:a05:600c:1c19:b0:414:63c6:8665 with SMTP id j25-20020a05600c1c1900b0041463c68665mr5470547wms.2.1710970433959;
        Wed, 20 Mar 2024 14:33:53 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b00414688af147sm3416429wmo.20.2024.03.20.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:33:53 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v3 0/2] Update st,stih407-thermal device
Date: Wed, 20 Mar 2024 22:33:47 +0100
Message-Id: <20240320-thermal-v3-0-700296694c4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtW+2UC/02MzQ6CMBAGX4X0bE27pYKefA/joS0LNOEvLWk0h
 Hd3IVE8zu43s7CIwWNkt2xhAZOPfhwI1CljrjVDg9xXxAwE5AJA87nF0JuOl64S1hR1rsEyWk8
 Ba//aS48ncevjPIb3Hk5yu34bl18jSS54aYXS5RUdFure9MZ3Zzf2bGskODwl5OEBedIqKDT9S
 P331nX9ANOgGMrWAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

Those two patches update the thermal device by converting the deprecated
txt documentation file to DT schema, and adding a required property in
the device tree where it is needed.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v3:
- [1/2] Specify const value for '#thermal-sensor-cells'
- [1/2] Add 'maxItems' for 'interrupts' property
- [1/2] Change commit log accordingly
- Did not add Krzysztof's r-b since patch [1/2] was modified

Changes in v2:
- [1/2] Change commit log to use imperative
- [1/2] Drop description
- [1/2] Drop 'clocks' description
- [1/2] Add 'reg' property
- [1/2] Add '#thermal-sensor-cells'
- [1/2] Make node name generic in example
- [1/2] Fix YAML style

---
Raphael Gallais-Pou (2):
      dt-bindings: thermal: convert st,stih407-thermal to DT schema
      ARM: dts: st: add thermal property on stih410.dtsi and stih418.dtsi

 .../bindings/thermal/st,stih407-thermal.yaml       | 58 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
 arch/arm/boot/dts/st/stih410.dtsi                  |  1 +
 arch/arm/boot/dts/st/stih418.dtsi                  |  1 +
 4 files changed, 60 insertions(+), 32 deletions(-)
---
base-commit: b6d69282db550689ab5980e06eedd23b64584a73
change-id: 20240225-thermal-8cd0ba7f452b

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


