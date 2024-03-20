Return-Path: <linux-kernel+bounces-108913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B948811D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15D41F22FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8F40845;
	Wed, 20 Mar 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG6a7LD9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E242044;
	Wed, 20 Mar 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938828; cv=none; b=hKw2akhhHjqvPsUQSbUvT3GSz8M+76h6R0XuiCfo22MUR2dN/MACknK6cCkihuv6WP9BAGGiewkSmjmgPSfSD6+sGTOZBSAmWYe/vV9NmjLkOuhyovx2njqPaTh+Z5wkF0gP2gwLkFTExFrdvXfLPVxXigxU0gZyz8ISSCMtUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938828; c=relaxed/simple;
	bh=BIegYTxgCUmL642uUOJmvGfYd2woaDUQMqU7ZtbU4ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIy+ykM9PvvNKPRnL0IPT09x9XTIjEbdvbib8Auw9qLaNrvAl9NhlgmAo5vaXu0MfmzKoZYBok52OyjwUceLDlFwp/bPzVj5Xy9tNkg22BcXk1DVkRSQbn5qC+XzV2hF4Zt4U7IVb7xr6Q+Yk+rDFKOkJzBUFuUuzX3xqXL6MKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG6a7LD9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dddbe47ac1so5929315ad.1;
        Wed, 20 Mar 2024 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710938827; x=1711543627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtrT0ozIVwCHyglNbp+j7sWA5HMQ1d8+p78zxo8eM34=;
        b=kG6a7LD92N7QmPy1qlx+4On2HmfiIG/v+70Kd/1/RYlyF7L38nUiDKOXp1QRw3AFLl
         h4U1GTYRy7ESk8MRyhsbkgCv5c8sVHfpKUbgrEW/pwm1qztLHVVDdXv/jDb/UZQmtQ5h
         Z1MeEduMxcHAo6Yf3bYG1zXakOuEAnA/mJbpHyzZbcxb0Lgix6KX7uI/iOTIql5X1DPz
         PmZqsHkRzYx/YKGM3CEavPUvyFAZsLyY2e0dejhgE+9NUE6Jdge2e1Xt8ku69KYzF4TU
         Jt9089wJS1GH5ewBK72+hQLlw2zt/nT5wKg10xxqFQ6/JGo8gIAgVmqCtjvlL0zclmPH
         hrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938827; x=1711543627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtrT0ozIVwCHyglNbp+j7sWA5HMQ1d8+p78zxo8eM34=;
        b=gtSs0ghFEjnOr2I360azWBalaT81EvGnwQxy3Sbkv7Lm5GWu5ejn3XR8ZrwLBcYitf
         6a1QQwqEVJ8tebRU5x1DxWyB8rzv7hx4tadpVEDtUr2+GIkzSEhxvXfWIMJQMJ7ppIY0
         nxWDj/9IaowEd/YAFFSXHs1ICtq9vON+CL+mg01PW0aUjRWMVgM9T4nQ4kBuoIFQLhcO
         +zNSL6zQBKaNK08neDfpC1Bo/nm2kCXiidQVd+8+9NbZQj/ZjpuV2VDMcwtjIpU/jbsM
         CbZc6Z9Pqjk/R4AV9GGdQZXCqjN/evk6xQMP6zZDHAeISos4HCHp7WuA7lsmGvcuL9dM
         f6FA==
X-Forwarded-Encrypted: i=1; AJvYcCU8oL0sH6jt4lGhItThZT1RIKVutYoBvOam02xwtNjrE0ebAgYLldmxNdymmVd5L3tGfx6XqtsZawHeEkrBG/hDmsPQa651ySt9K6JqCG2+ShleaaV1OKAUbpLmGgRCADFXELPD4dZ5pQ==
X-Gm-Message-State: AOJu0YxFZLSFLhGPT/6EHQKGz8gDK5dfp+hDOPrvDtuCV5QHnNS1dlm3
	CALwf9zK5IXCoCJIh74Xjip4SDt0iHxkeR8HIWK/Gkw6OfqxISWZ
X-Google-Smtp-Source: AGHT+IGPG6oBU+MflgHr+6erRXWLJ2KbmvR5FDzl0LJM/phy3jDFo3G1umGwmn06CX/6RlEEQMuVzQ==
X-Received: by 2002:a17:902:cec6:b0:1df:f859:91b6 with SMTP id d6-20020a170902cec600b001dff85991b6mr3180169plg.34.1710938826621;
        Wed, 20 Mar 2024 05:47:06 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001dda32430b3sm13441004plg.89.2024.03.20.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:47:06 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile network
Date: Wed, 20 Mar 2024 21:43:16 +0900
Message-ID: <20240320124431.221-2-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20240320124431.221-1-musashino.open@gmail.com>
References: <20240320124431.221-1-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LED_FUNCTION_MOBILE for LEDs that indicate status of mobile network
connection.
As an example, "Mobile" LEDs on IIJ SA-W2 indicate status (no signal,
too low, low, good) of mobile network connection via dongle connected
to USB port.

Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 include/dt-bindings/leds/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index ecea167930d9..d4b8498bde7f 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -91,6 +91,7 @@
 #define LED_FUNCTION_LAN "lan"
 #define LED_FUNCTION_MAIL "mail"
 #define LED_FUNCTION_MTD "mtd"
+#define LED_FUNCTION_MOBILE "mobile"
 #define LED_FUNCTION_PANIC "panic"
 #define LED_FUNCTION_PROGRAMMING "programming"
 #define LED_FUNCTION_RX "rx"
-- 
2.25.1


