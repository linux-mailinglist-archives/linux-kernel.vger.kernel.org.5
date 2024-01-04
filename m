Return-Path: <linux-kernel+bounces-16311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4C823CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F701F266BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757F1F95A;
	Thu,  4 Jan 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hrfzsH+v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92D1EB3E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so210249e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704353054; x=1704957854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=hrfzsH+vwSrcBzMmucik0aZHXRR7Pt4z9rItADrS3PjUV+bqxNH05vGO1DmxWucH1o
         RBszMFCIEtCNxyqizpSgmL7PJcaui+YZPfdJL/GQGlJD9lfsB7FqFIrS4iEny9OUNcZe
         Lf0OduwOYBh4Zx0nDzgFdcpZiR9xACuU3taEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704353054; x=1704957854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=g7+RakxnZvfXF2bp5Jumx1MvP8OQ+n37t7xql5ayXFG+5R3HYaJsnPlH5BIOChH/NI
         cUEP5zW7MHQmMF+lE1411xz4r3xiA8uvGOYX1NtfJNK6PmLODcHumACIlEKWaJeTTy0a
         ZBwO4dBUQZA3q2tO98UD8T3U1/L/0ebmaAWZNL5oxuuZle7DwLlftwUzY33mYUMHk22C
         L+17fky+YMoptsK1hhOJUbCRzD44+WF/4awmigdReo0AfTLPQjUf9CcZH+8dQnf7QtYB
         8fbsHTbmu9e0CssomuwLcQSl7EYa5enqzoDX2PxKrEM4h2Vl235fcV1SfvBHlFD7mRmh
         gPiw==
X-Gm-Message-State: AOJu0Yy25+9kNHZTg4O/nOcVUJ0n3wcu8aD5TGqrB+9KY9PtCUYqvptR
	sZigNsejhkn8ZUQhTK0LNFjdyQxdR3FYADESJEGwlDwdLV4=
X-Google-Smtp-Source: AGHT+IG4i/97hJ8aDZ8aV7oljAPTtFLXwe5GU9eipdE578f3Arlwv9CTDaie3sHsTnqpOAseTOaxdg==
X-Received: by 2002:a05:6512:3c81:b0:50e:aa96:73ed with SMTP id h1-20020a0565123c8100b0050eaa9673edmr145525lfv.136.1704353054338;
        Wed, 03 Jan 2024 23:24:14 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id d3-20020a056402000300b00553772c2968sm18530735edu.82.2024.01.03.23.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:24:13 -0800 (PST)
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
Subject: [PATCH v3 1/8] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Thu,  4 Jan 2024 08:23:37 +0100
Message-ID: <20240104072407.41290-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104072407.41290-1-dario.binacchi@amarulasolutions.com>
References: <20240104072407.41290-1-dario.binacchi@amarulasolutions.com>
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


