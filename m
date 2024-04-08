Return-Path: <linux-kernel+bounces-135634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4A89C8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275D81C21CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C7142E73;
	Mon,  8 Apr 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIVSv8E+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0BB1428E4;
	Mon,  8 Apr 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591601; cv=none; b=F1mdGt34e2Ag5/4oNQDUk2p0bdORQM8MC/+Xnc17XVU0xgPFe1i+oNf7frhVwgXvsciA6BaMlpN8eeMDhimELqkA1C+WkmmN8pI+Sau5o0C+Woqa3ipXlNIHLK4xKx3a+E+qDjCvLFBuPKwAS4lJT5wkXe1AJYqnmi3FV1xj3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591601; c=relaxed/simple;
	bh=zOZomgntzrvpzwsWCTBIKhRP00SpDrEpbkluseuFse8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqrkgxQ1uRKAvze3KPmXQ6Cyr9nTUyoVxeRG+FlfTB3E6+9BBsiOivSACZXLIxB50rCbadpvXDqnCw1n8bGRaSgDOk6orOqCAuSCK0gPYc7MXINk0oVHNFRNIXELWuURKGQqU/9It95Gw4DyosJokKpDn3zQdPvSwar7wdBBSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIVSv8E+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51c6e91793so268157966b.0;
        Mon, 08 Apr 2024 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591597; x=1713196397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSuQkBcadOBIFzAv5VWT53mPgt24650g8Yc46Jnu+po=;
        b=QIVSv8E+fijgfp+I7k3s31NcgFtuQCEj9b/p/n1ijJkb+dpyjKs3d5um586sTpalr/
         mAxh8799Gu54oKIvqiME3eMwR09H6AFp6KlB0uUPfr7i7LxcHNl4syijOl+MqLlxbz97
         tjKl9faPBIsW4wCJ4jwXwvTyaikJZqFvk6I/VgbafPdoSkV0ZwvaOuJK2FiIqub0zo4v
         hHUzfN6BRgJAvM5yCbIEX6vIvO73iNBTwsqwoW0FYTQn7dF1+MQf7YoNfL/vB1ZdUdut
         rcQB8RvNpSrVgA6JkE18/wbI6zhhZkYdet0aLhVQebPu+/4R0xp4MwPSXM2ZrxobhjQz
         2muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591597; x=1713196397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSuQkBcadOBIFzAv5VWT53mPgt24650g8Yc46Jnu+po=;
        b=mfG3IaYpQVgyIf0ZR0NE7ScW9Hq3M68Rr4ROra/UrChLGqTw05pbDhE1WjU4Fyxa0g
         1P99hODo+d1S7dwipWb4m+hfHbdPc7OG/atds7bh3/kaZD02gb4FwzKjLahqYdt7A44z
         tTIlcezlnMdmDEmpB2rjciVHPvriNrK4Ssv6+dANbG6KaBZ2IjOhIP1ewS3Eya3UjKJa
         lAWEXUw7BYet0yI0gy7C2pwrdH1nDRM65HhA3XxraPhWNs+iEzUyYXf9ihDdKLfjmISN
         FIFTh4DCi+crwifbDY4njo92lOgn08t/L/wwxT1pM1QKro+ZjRW5dM1tHRANitSLb5jm
         KjHA==
X-Forwarded-Encrypted: i=1; AJvYcCUTseK8Eloi8CzyYwD/DwL0AAJ11DND6OLLc1sPUuqoWlXflGT1d7+ik/SWYo5sUg0eLER94hOhYlfaTVgKlsm5v2gd6CMMQKdPiaKpSicq7jUXhSc49ewzsMYa160Do2UiZTTXMKPh8w==
X-Gm-Message-State: AOJu0Yxc7pG0QFyhjwQeLNnR9fU075FtQNsviKttLEo+UnR+Z8oo0Uej
	RSG+gDUmX4ozsqrvRmMhDauaBtqzTDKPO8BciO/vQWlLeogK6b5u
X-Google-Smtp-Source: AGHT+IG+xooPJVfqxdhFca/m9VCSLYMJBFoaSR9jS3Fdk4ttcukr9i773eeoHIdSGYXmNnF/nymuPQ==
X-Received: by 2002:a17:906:fd8d:b0:a51:e188:bced with SMTP id xa13-20020a170906fd8d00b00a51e188bcedmr48379ejb.37.1712591596913;
        Mon, 08 Apr 2024 08:53:16 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:04 +0200
Subject: [PATCH 4/9] dt-bindings: rtc: maxim,ds1742: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-4-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1594;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=zOZomgntzrvpzwsWCTBIKhRP00SpDrEpbkluseuFse8=;
 b=VG/4RZspITvXhEWAGam4EeebdbdnRgZkL5lRkdQjPLh+WlxRCuzFnJI7lPUjmco9VoyuOiVXq
 akjKl/hvaUaBliOoiWRR9Z/+c9DEfQXxUVCqUVbp5NFNzefeTmLd4wH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This RTC only requires the compatible a reg and properties,
which makes it suitable for a direct conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/maxim,ds1742.txt | 12 ------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt b/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
deleted file mode 100644
index d0f937c355b5..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* Maxim (Dallas) DS1742/DS1743 Real Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,ds1742".
-- reg: Physical base address of the RTC and length of memory
-  mapped region.
-
-Example:
-	rtc: rtc@10000000 {
-		compatible = "maxim,ds1742";
-		reg = <0x10000000 0x800>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d6ce7ac29033..710b096fe6f7 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -49,6 +49,8 @@ properties:
       - isil,isl1218
       # Mvebu Real-time Clock
       - marvell,orion-rtc
+      # Maxim DS1742/DS1743 Real-time Clock
+      - maxim,ds1742
       # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
       - maxim,mcp795
       # Real Time Clock Module with I2C-Bus

-- 
2.40.1


