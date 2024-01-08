Return-Path: <linux-kernel+bounces-20075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF8827904
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C021C22C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F455C16;
	Mon,  8 Jan 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SUjFAHn2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BB5576E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so2435949e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704744983; x=1705349783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=SUjFAHn2HsxKld7VVYckh+g3Tli4loAyO7StFjqFQZ9/M80TNvSOc221qkbJkYN1Dk
         3UfRsCXfViiCi4fpCDyz56IBaiS1kyBgahWhVSjlasdzzQ6sqJcbC8+40FvpOTJ63GxN
         /wZ8E0qeMl8SmBwao5kr1ZE7+MATZ54lw727g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744983; x=1705349783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=gc1Q8CIG3winz6Suj0DXR1Fqc+qD/P/B1llj6QUSbEet37+81K/tg8XvNTxaIw3DCc
         FRlD1xhxxIujKUv+sT/INyWnlMoedn1e1F6NZ91Btn94IAJdJwiUpzqK6oK+sfnhshXB
         8YpFEP/0fV1tpbkQwgmcNl+Ggngs/Myf8NNFDw69tb84CCXDXYjWPprjLWLZODJsM0Se
         /xEVy9jtrH6vLMZ1Tg97CKMCuUrkJ4JpCgg+Qgj2KNdp1NBaZWkOreEHpUnI0+YakUrF
         +V9hibH3W6uI7S3qMEJhop9H9Q7rwVNFOqXRka8QCfrxEpBZy+OLIBGFAQVS5KGZOGkV
         iOgA==
X-Gm-Message-State: AOJu0Yw0Bh/g6gIdt0f6Fr3nkcpl+gpYe1dPPTUtj51YxiHj33VQwE5M
	Qi7ey3PGS0puFcZwaC+u43ekO67P4jboCDv1sZXTcGC+OeU=
X-Google-Smtp-Source: AGHT+IG+bnMS+c8tiYQ5DRcgpg4/in0j4YpErDzhA91O3wWg4FpcIE3GXCuL7kfF9HOWzE4sOP3CtA==
X-Received: by 2002:a05:6512:3f01:b0:50e:73b8:e8b5 with SMTP id y1-20020a0565123f0100b0050e73b8e8b5mr1890614lfa.74.1704744983333;
        Mon, 08 Jan 2024 12:16:23 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-2-38-81.retail.telecomitalia.it. [87.2.38.81])
        by smtp.gmail.com with ESMTPSA id by26-20020a0564021b1a00b00555fd008741sm173699edb.95.2024.01.08.12.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:16:22 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 1/8] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Mon,  8 Jan 2024 21:15:46 +0100
Message-ID: <20240108201618.2798649-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding definition for MIPI DSI Host controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

Changes in v2:
- Add Acked-by tag of Conor Dooley

 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index 8d73a9c51e2b..a4e4f9271395 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -108,6 +108,7 @@
 #define STM32F7_RCC_APB2_SAI1		22
 #define STM32F7_RCC_APB2_SAI2		23
 #define STM32F7_RCC_APB2_LTDC		26
+#define STM32F7_RCC_APB2_DSI		27
 
 #define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
 #define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)
-- 
2.43.0


