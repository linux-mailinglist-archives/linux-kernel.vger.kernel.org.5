Return-Path: <linux-kernel+bounces-13895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9482145D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B3F281A21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436948BF8;
	Mon,  1 Jan 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Cs/jOpjt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551963A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2335d81693so1502165766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704125769; x=1704730569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyS2KeYOl/WGbPcbzpxJ7ikencveX5QceRVMiCrFg1s=;
        b=Cs/jOpjtdN4ENRSDgXwlmI/4u3atTRproGeLKoG3hG2OuDgWZetGFk9LUzHjF2F7qH
         bAA3JY+ifYnIbpNdk4i2MvBsDXMueUxOw+URjBdDgUtGoPE1noYBj5mw4KzceiHvq4xI
         Cc4DGKDsU33LflMxLij6rvxKoPF6PfQetobvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704125769; x=1704730569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyS2KeYOl/WGbPcbzpxJ7ikencveX5QceRVMiCrFg1s=;
        b=g1QG5a8caOQGnknFJyaMaKsd6X/HqohLO4yRA9tz2JqokFPFAKxA9NR6Prs+WeUouC
         yJB6w6fMqLu9cYBLsvBreJM8s4OxrJNVtWTSnefs78IOZVcBQwxMyeU0kbcgP2F9QTBH
         OZuk36VcG9ZsZMh+DDiv0hrMJl6+Va0NscoN4VU/bPb1qxJvcGbLt18jXtBQZ5PZeg4X
         Zh1ut96dWQlPJL9BLoZciZWQSJ+bFDEDlb93l50M5RXkKnVHQNnDX36HdfunFvZ0s6wH
         4JNzrzUQd1uIbqWJeRutwlRrx5+O/qe1JOrk0grSRtTeVAcJg6ODhK3QbhIEZwB4pm9i
         Te5w==
X-Gm-Message-State: AOJu0Yw6HieCxdU51rWO02v805nYKmCmLozcyPVaF4MHPO27DcDSGvx6
	47R9oRstsa/Xeta9KGyoFw22FxbATZaNYdX0sKD8zpWk3s8=
X-Google-Smtp-Source: AGHT+IGOZyuwSgxZuo92l15nHbn+chqMjAocBeDlr3/i+QUnPeNN4cNOy6nmgJlZB2iHT6AHgnsrLg==
X-Received: by 2002:a17:907:c9a1:b0:a23:3653:832a with SMTP id uj33-20020a170907c9a100b00a233653832amr12536261ejc.17.1704125769083;
        Mon, 01 Jan 2024 08:16:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-48-44-179.retail.telecomitalia.it. [82.48.44.179])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b00a27d5e9b3ebsm1897857ejc.105.2024.01.01.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 08:16:08 -0800 (PST)
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
Subject: [PATCH v2 1/8] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Mon,  1 Jan 2024 17:15:44 +0100
Message-ID: <20240101161601.2232247-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
References: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
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


