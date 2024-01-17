Return-Path: <linux-kernel+bounces-29147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03C830997
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8181C20D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C2219FA;
	Wed, 17 Jan 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZctXygLk"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A321347;
	Wed, 17 Jan 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504745; cv=none; b=QAnI63jOIITZwXP8RYggoagFHX0p267N6Jo6c8SptaqtNnEGPcfjhvzmyNj1YhcTzORlqwVdZVmbkonqL6AjmVgNcHbw9xcATOPYNwEBwz27Ma3hhU3koeEe1ZrLzXO7JXdRh3Rh5+X/Aj/X0mVcx2ISQb6mSVfn59w1368jbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504745; c=relaxed/simple;
	bh=KyZXDKWNuRRoPHXrRo+4nANz93Wq08Z7zMiVJ62yT0Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=ifjtpPsp6K3ZV2t/R1UlaIoo5OpoMvRD1p4JWTmFtsd+b/x7cU5wOdpTdrZwt2taCoodWssY8yHQ3w0VrYpQ0mVnPUobGDs/Qf7u+r4hYLK93tUycnmHc1GmxlYI9zrSAgmsIOz8FkDUE4Rhy8rOsPSNGjqkYm9JBzyAowiNoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZctXygLk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so24626051fa.0;
        Wed, 17 Jan 2024 07:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705504740; x=1706109540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NI2TRURHEDTtYWB0/8Y4wbV5zMEfj3l8z/jgy/adY2o=;
        b=ZctXygLkkz5nVG7o4oS8gHoCurFzh3NPllMqGDABI+aJAL8Umo+cWNHJ25uW5SF362
         fDz5Xuf3MlhO/lcx1reD/YwLhrPca/0Na3IyCehHBM9/dmDEu1/V9sx4nmHVkzXyexRe
         cJvZPkoG7kSqcuJNQ+giCJ+RCoZI0di1njtCvBdLXTEzOpIwXjpVOv54TsWQnUxu45Zp
         KzHQGseC8WEZti9ueCsW7larw8h8TR5UjbqVerAd3Xi2+A/y0DLqe/ug6MTK2pbE7wf6
         VA0pZyvYXbc+qPUOoZ72XsJhzb6OuyDY2O/KzE3aFmwMvN5OdCUaYzodpFK2Pcsu2O7q
         F1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504740; x=1706109540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI2TRURHEDTtYWB0/8Y4wbV5zMEfj3l8z/jgy/adY2o=;
        b=oAyJnbk6xl9KtnK/O+ygJ9NyA9lgS+ZrWghw329jc0raISq4/BGKQAmMkjaNGW1Wgp
         dhaKd+R4MSsN12ss4TVgfny/y8dnUB8PrAQLex+LWumLrLYzuF131/oNSZvp5PO1YrjW
         7qmVzxQ0byseq8rPINcqVFuKjvL94oRlM8uE+U6iSruRy7qcNivXbes/Pu4TqceF+Boj
         vpLSs8kOld1frKWU28CSVFLeFov+UnkOTqV05aA4QNGxcQOrbypTacjGC+uuzwQ7DHs2
         riAZOXEbzt7cGRIqRJyhkk7RrxfKaCxCHTzkQYm/1ZQg4e0xlB6kUu9WPgxCnQKjp71X
         thkQ==
X-Gm-Message-State: AOJu0YxXNUj1q43p9KuUGlfjP5xC1VNtbRSKwVwqW54BaSHsHVesEDvs
	8aBRkmR7C7BJpNb4ktMnj9w=
X-Google-Smtp-Source: AGHT+IEQf5mn1yllvoIUzZxLwROSNDmg7T98wZtcxwYbQxh+HoJTP3v9GzRSw4id8gNmMd9VdLrf/g==
X-Received: by 2002:a05:6512:695:b0:50e:e66c:4d8 with SMTP id t21-20020a056512069500b0050ee66c04d8mr2409468lfe.30.1705504739778;
        Wed, 17 Jan 2024 07:18:59 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709063e8500b00a28badcf367sm7884118ejj.54.2024.01.17.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:18:59 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openwrt-devel@lists.openwrt.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: leds: add FUNCTION defines for per-band WLANs
Date: Wed, 17 Jan 2024 16:17:36 +0100
Message-Id: <20240117151736.27440-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Most wireless routers and access points can operate in multiple bands
simultaneously. Vendors often equip their devices with per-band LEDs.

Add defines for those very common functions to allow cleaner & clearer
bindings.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 include/dt-bindings/leds/common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 9a0d33d027ff..c56785bb9c9c 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -101,6 +101,9 @@
 #define LED_FUNCTION_USB "usb"
 #define LED_FUNCTION_WAN "wan"
 #define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WLAN_2GHZ "wlan-2ghz"
+#define LED_FUNCTION_WLAN_5GHZ "wlan-5ghz"
+#define LED_FUNCTION_WLAN_6GHZ "wlan-6ghz"
 #define LED_FUNCTION_WPS "wps"
 
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.35.3


