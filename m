Return-Path: <linux-kernel+bounces-135630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303389C8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2015286247
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740011422C4;
	Mon,  8 Apr 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB5uEatS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2821420DA;
	Mon,  8 Apr 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591594; cv=none; b=OWaQmCCqcSb2/wk/tZw/yG3T9+KW+WAzHIhiX46tRstpJyak2ih17e9+N1vhPnEBh7y5FOH/oQIKIJZgvgRnqYe4cSTcgw12tN2WCFcxa+RP77d+NF44MnJR/W24eASWfF9cGPoF5jjbS6OPdV4tJ7WmlmDVCLKP6iaLjtX0+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591594; c=relaxed/simple;
	bh=hBd9i56nvCzyVs8yanPT9S2Cyv5djpJ1RLlYTOAQDRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBI3LThJylbt97vLAy6lzfIV/GpvHxiuUrJW8WYQy8SNQQV5n8t6TVgSqsvOZ+IXzXh+p4o9U1fZD2u+BRhQS8LdY695t/G794QTufqUfQ3yAi849m8O1XZALCjK5Q7yxZ1CA8jK0SscV2Rbp0agtpyU5bZ/6SUFM/H9YkB4hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB5uEatS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a7d4466bso356549766b.2;
        Mon, 08 Apr 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591591; x=1713196391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMMzpPgaja57dJ/QOl1X3xfBEKxBkGZzp3htau/BjRY=;
        b=FB5uEatSgqhZKE1HTzn8QNtp/zwGZ711pWsSfHTTaH7KRNUETIBgg/AF4v3XqbW5N6
         fKjJJlmA7nEP5vujbe/W1nEfetJe86Lp+EBYSX3CagUwElz803TqTiZXuxHNZ8aAT/bb
         9AGp4pWnbUW+QwzYuJA3MVMwghUpo2P/q9E5i2ZD6KkEwMKX47YgEOWcntTTDdIxd6lC
         obAiSGqrM5D+tteTTDWyzS/W5MZkYn1j4oBDUZke5fjBJjNIZaIpXq259hXF/Y4H9/Y3
         2uFP6UL8RVse45YOlG9ZBlHvpsKsCk0bmAQrqSpTSbQu3WhfZtxqCopTueQmtpDLj3eO
         B1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591591; x=1713196391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMMzpPgaja57dJ/QOl1X3xfBEKxBkGZzp3htau/BjRY=;
        b=U9M/2Na7lS4lFcnj0G2pogUSeBT98vXtbW9eOyOZ8vlXjRDSg+MubpnSYyz7VQ2TM2
         YLX4v8D8F3GQQG4tjj/DiXtDrLHCp00vNwYShMaRND3SC9TIUDIC+G3ksGshuoYwdRF9
         9Eqbhk9x8OgqaWl/DkCwDig11Gjj8WNU3gvZinRULZ37dz8sgouAiRY/gnr0XrZTouYr
         MaVQOCUU/yT12BHb3gsCZRZTsVEaafmAWb5ERGBE/JHBn91E+bF7urf8JCsEiJtNkX3C
         SEwycDn9OMwadLp96kqT30uYST2qDdKVgEj4bVWS6SHVMmNMExAaqQDYgQpq+0JyogOI
         801A==
X-Forwarded-Encrypted: i=1; AJvYcCXNAY5DqylBLF15LJMNQTZQ1rCYYUN/++hGdX6nn52hN4/oUhHuObfOZ8Rr5/udKBgxaOoTXJN/R2SPm8UU454SkCoO58dZToP6TCyp6oo5KetRpnLKMj1mWP5T+389hQS3J/uo4DL1QA==
X-Gm-Message-State: AOJu0YyhsDJd/+xP1yF3K+VUOedt2Tb70kqTu4UaP+bKjIEMCDTO15OE
	DI7/CnJ5/1issmMImEU5A42L7uO8YErZsg5RJjTvD7ERnBL8OrU3
X-Google-Smtp-Source: AGHT+IFLOo9Lg9B3qIOklTKOZd0LvNU1njK/wu05Sxkr5yVm3kefeiWUgywKL7V+AzBxsRaFEqHPcg==
X-Received: by 2002:a17:906:b19:b0:a51:d19c:aba8 with SMTP id u25-20020a1709060b1900b00a51d19caba8mr2466641ejg.20.1712591591195;
        Mon, 08 Apr 2024 08:53:11 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:01 +0200
Subject: [PATCH 1/9] dt-bindings: rtc: orion-rtc: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-1-c447542fc362@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1761;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hBd9i56nvCzyVs8yanPT9S2Cyv5djpJ1RLlYTOAQDRk=;
 b=7fLnaSy2d1QTC1X9rDdRmPK4NxyIq/8k0OfRmCyhOdL4+L4l6InroboEy3X1aqCBh1Yh2+xlS
 q5z7AlDDx3nB+S8LjphJkGb7U1aUoHLT6vOelE+aTDV7mVFf8o3lo5A
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This RTC requires a compatible, a reg and a single interrupt,
which makes it suitable for a direct conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/orion-rtc.txt    | 18 ------------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/orion-rtc.txt b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
deleted file mode 100644
index 3bf63ffa5160..000000000000
--- a/Documentation/devicetree/bindings/rtc/orion-rtc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Mvebu Real Time Clock
-
-RTC controller for the Kirkwood, the Dove, the Armada 370 and the
-Armada XP SoCs
-
-Required properties:
-- compatible : Should be "marvell,orion-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: IRQ line for the RTC.
-
-Example:
-
-rtc@10300 {
-        compatible = "marvell,orion-rtc";
-        reg = <0xd0010300 0x20>;
-        interrupts = <50>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index c9e3c5262c21..5e63c8f7f618 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -45,6 +45,8 @@ properties:
       - isil,isl1208
       # Intersil ISL1218 Low Power RTC with Battery Backed SRAM
       - isil,isl1218
+      # Mvebu Real-time Clock
+      - marvell,orion-rtc
       # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
       - maxim,mcp795
       # Real Time Clock Module with I2C-Bus

-- 
2.40.1


