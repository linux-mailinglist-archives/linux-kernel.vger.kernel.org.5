Return-Path: <linux-kernel+bounces-112253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1D887779
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1901F21D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C511183;
	Sat, 23 Mar 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLXBOeed"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D7FC15;
	Sat, 23 Mar 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711179877; cv=none; b=sdIwsSiokVFyh6Zeb+5P8tSESfFFk0g/5gyAc2iMCAwQn8ZI+uA6tilqPJ5RjT3d0q0C92xfMEaNj0iRDOBD+HiCyEkBQHfVHiItERkxe0V1EJiHCJhPoPIzP/7F4WPUHqZHZBo6utQcOhWHxvrC++ROymaLpr9wDjdosfNaw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711179877; c=relaxed/simple;
	bh=J6ORwki9sE6Fwu6kxTbKnijZCWru3bbSvkADbOc4ncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlUkBhC3ZPsCRW4w9b9rJmJPh4z9MJm/U7HfA7Oq2l+H69T0aJEfrf/84WqNJh/6U7Aa25QAJCEP8F2mgw+5eWInLrB0HXS3bks+Potn1j9T1HciS10wPBP7a9hcvKvZC3m9Oi/uo8fL5wuTD+bm5bm8bQYRWnS0ZA2FlYO0FW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLXBOeed; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e036b76725so20979325ad.1;
        Sat, 23 Mar 2024 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711179876; x=1711784676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hra+geuyvcxhPcwVOOCGooQH+Il9Z7Z3baHD814SLOI=;
        b=nLXBOeedMWFblSf49Vf/0CgLbTfyA+VLYkcCUky2piK0BY0eT4ap1lZviSxo28UxRJ
         apaQR3kPrawTOied+kAp18WpLs95xuxK108AEJpSJHm8lJRddBMyIon3OKKdSAlOsVXY
         yjLmUmFnshdULFVDCfejU4qNIHLP5X3sLRJ262criS3LG8NVi7T3MfYYawPZ89CR5Qmv
         KdI6TzXFdbR19WBIPe5LfbKhf00IyWuVWiBMhFYM/yzmEJa+KTCLZVu1tRW+QdZP0df5
         Su0ejI06wcWUXArdfusC0gHO4ToTaxKPq0qmCQsi0iUVQxEG87qswgaK0coIYSGC0WN4
         C/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711179876; x=1711784676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hra+geuyvcxhPcwVOOCGooQH+Il9Z7Z3baHD814SLOI=;
        b=kNH3FmWpRZ7p6hMK/JN5zgs0gznyhKciIUNrjnF+XTZJrjlv8pOEuKA0YK3cnQGTVk
         f9pcXa07uHIui1FPUvshAYTvNFNyjzGEUq80478f54YnUDVME5xjWMuFfgK50/YvScUJ
         rEg0ITbmJ1mjuDBB1E86iQlYKYE3PLNwB3VRoGvgOwWtCNsK3FzWXNPRxHUur8X/OAW4
         QrpuI2ywIDs1sg/XN+pWLYK2GFmzA1G6RwOj2UQrocn1jCNXve72mL83HNUWhAACFRGB
         HOz6ISGsp6tYzMBX21NROGfDkFEap8so090llHqj0kTIS39rUVUL8IuDxxz7TAeM7Jhp
         dJqA==
X-Forwarded-Encrypted: i=1; AJvYcCW2GlgsbDIbYv3k8ctqc0iOIbq6ZXEjBqyXOGUVpxWdlN6gDoz7q3vz9/AMMT9EQ6ztHlEzxv+3ojpsAwvZLpgnlTTUvx3Ycs4upqjywhFQ55fnm/shSpVnyi7Bsgm8Y2tNvAiDOaGFrQ==
X-Gm-Message-State: AOJu0YymXYM/J2uQtveiiVGtLrioHenijzCALTfK8hPMn71tq1BnHg0C
	kGaFkLtRtEg/bQAkyeGgwONdcP6NMSpquDiPHf/PQy0+wFgJrpO9
X-Google-Smtp-Source: AGHT+IFO2hWKOd7wO0tfAdxoFVMOzh2z9N87YGY6I7qxPnUXbcwpDNuftNICbcGT0W8xKyIslw7oTw==
X-Received: by 2002:a17:902:f70b:b0:1e0:2b2d:53aa with SMTP id h11-20020a170902f70b00b001e02b2d53aamr2012238plo.53.1711179875781;
        Sat, 23 Mar 2024 00:44:35 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001e0410bfccasm976825pll.126.2024.03.23.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 00:44:35 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: leds: add LED_FUNCTION_SPEED_* for link speed on LAN/WAN
Date: Sat, 23 Mar 2024 16:36:10 +0900
Message-ID: <20240323074326.1428-3-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20240323074326.1428-1-musashino.open@gmail.com>
References: <20240323074326.1428-1-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LED_FUNCTION_SPEED_LAN and LED_FUNCTION_SPEED_WAN for LEDs that
indicate link speed of ethernet ports on LAN/WAN. This is useful to
distinguish those LEDs from LEDs that indicate link status (up/down).

example:

Fortinet FortiGate 30E/50E have LEDs that indicate link speed on each
of the ethernet ports in addition to LEDs that indicate link status
(up/down).

- 1000 Mbps: green:speed-(lan|wan)-N
-  100 Mbps: amber:speed-(lan|wan)-N
-   10 Mbps: (none, turned off)

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
v1 -> v2

  (no changes)

 include/dt-bindings/leds/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 6216ecdb06c7..82a5769725ce 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -96,6 +96,8 @@
 #define LED_FUNCTION_PROGRAMMING "programming"
 #define LED_FUNCTION_RX "rx"
 #define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SPEED_LAN "speed-lan"
+#define LED_FUNCTION_SPEED_WAN "speed-wan"
 #define LED_FUNCTION_STANDBY "standby"
 #define LED_FUNCTION_TORCH "torch"
 #define LED_FUNCTION_TX "tx"
-- 
2.25.1


