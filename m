Return-Path: <linux-kernel+bounces-101491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8989287A7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BC8285331
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38433996;
	Wed, 13 Mar 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xR3PO07V"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39281F958
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334415; cv=none; b=BkJf8WKk5PFFWOJh05ICTNWkiZSaTDgHZ52gyg8q8R/iLjk9Mx5pdTAw5DL3cW/ZA5dkNT8+b7yHrEPlmEevWN1kBdIYe7tunbVaNH2OK8v39ey5z3siScYPFvx9Xi7QOZM1x/7kdGFPzTnMms8jkYGE6J3Q+n5XP4f4ltaOA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334415; c=relaxed/simple;
	bh=YMw6FXUUv+blIKXVMARtF/BZiC35J4VjJ2wII6LwQ1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n0Y+95Jh2N8iRiip8qhNsWvecF4z1vu9Rld+mWK73WWBV+8x6t8hWaWfi3of28HP+9OFZfHEfJHL2K+UNLokpWh/eP2XdNf4XpVf6UN7jeqfg0Mm/Rj2X9evV399vghJvRgzY14VK3lvhOvKiQeS5j+SzWddn7sYDFjSgSsxmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xR3PO07V; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so156332366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1710334411; x=1710939211; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8ViWIka8v0fvl6fi9rfxOWkjF5zhtO+EwXsSRYTTAY=;
        b=xR3PO07VvOpLlimM9PTTDU7rpOilBc8WtFa9zUgljEfKdKCREtGrDKzeR8Hr/AcY+k
         6ap/ULQofv4LclBv5x0KyOIs5xwlg4bz7+6ES7i2D6Qpkb4N/ik2R/12Bea9A1onc1MG
         YmNXf8+mxrrHL8o69rg+U+8HEk+anazBwrupS58jM7jwkaIeQRaZ0q8nTZlnhOvd0lDR
         0aOP+1aT0v+v4OyD6d4Rr2K+1fFfn+Zqv1U8+SXR6HNf8jEg+HA/H3juxojlGFg290sU
         HBuygBjlPa+ygtVEUnQSxtZGLUwWaAfvZNkhqAPaEhOksivOKrWX1tdgDopecT1tvatR
         NvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334411; x=1710939211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8ViWIka8v0fvl6fi9rfxOWkjF5zhtO+EwXsSRYTTAY=;
        b=gO7pAJ6XZihZsYgjVpgf/My3D1X2p7Ul8xSiclIR3aT4YZ4NlKpUZExS9K2o2c74Rd
         m//Pa2jWXjlLYrP1QKk3xpml1hE8fTvtwq9cOZxYtZUjJAsmEASu/krFEsQpxtCInRuP
         sXB91m6cQVvzp/UJ7H13MufVf8scNhDYUYmLOx/czOIVUGCnifv9FugAG//aK507eyB+
         PsuK7GhQaGmOL4uiuviD72WHnxplfI/W8XNZ0hiOdNeJHpUvRC/40+DKYknO9BuBXnT7
         iozIid/8SANQzOtiPGdVdyVEL4JQlSmKLiqiT56TJ6HaoZe2wsYXrdLE69CG4ttBb6PK
         XtFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2wgtyCXp1zSkbD23la9i8Uqicbl3ieUy7T9UgkuxyyZcgMFPRlqFVksniG1N7Fkdqo6Rz5uevLXx6+zj33aIfVJ8bH0DTGyljTe6T
X-Gm-Message-State: AOJu0Yz9lCDE47xOB5suDkGLzMe+S38bnAMtMdzLcQaEtjzUOHZXeokX
	bTROXETaHln218GtgdvPNNjZq7QnFkEjW81hGE9QyMfWqYmki3euZKlZYz2asog=
X-Google-Smtp-Source: AGHT+IEARlJFryEqeY6MQ0xjILbFvD8WfbU2PPjwCmUkH81u0Z36qkT5RKRMbiaOFmE/vvt1bS6N5A==
X-Received: by 2002:a17:907:cb87:b0:a46:13d3:e5e6 with SMTP id un7-20020a170907cb8700b00a4613d3e5e6mr2421588ejc.0.1710334411048;
        Wed, 13 Mar 2024 05:53:31 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm3249098ejb.126.2024.03.13.05.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:53:30 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Add Inline Crypto Engine for SC7280 UFS
Date: Wed, 13 Mar 2024 13:53:13 +0100
Message-Id: <20240313-sc7280-ice-v1-0-3fa089fb7a27@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALmh8WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwML3eJkcyMLA93M5FTdRFNTAzMjs6S0ZANLJaCGgqLUtMwKsGHRsbW
 1AFIEwhpcAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add the required bits to support Inline Crypto Engine on SC7280 SoC with
UFS.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      dt-bindings: crypto: ice: Document sc7280 inline crypto engine
      arm64: dts: qcom: sc7280: Add inline crypto engine

 .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml    | 1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi                             | 9 +++++++++
 2 files changed, 10 insertions(+)
---
base-commit: 5f19977109ce685937fee9feea9b807599dfc925
change-id: 20231208-sc7280-ice-a550626bfc09

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


