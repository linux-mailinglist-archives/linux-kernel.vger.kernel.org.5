Return-Path: <linux-kernel+bounces-123919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B590C890FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C1B1C21EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AA2260A;
	Fri, 29 Mar 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoY84kTu"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04117BB2;
	Fri, 29 Mar 2024 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672845; cv=none; b=rTPxeme7+sZbLmqGwhPzNzg6jMZVUmOLDVEzF2lIotzg4oS3l82IJr57yUiTwBx3vyyszfa+FnJniPMs9o/FO41jXIHrIXeOfgbk7YoD7XYtotlXfQyxv9O0GPPTNk1dXWDK3SoJGzwqPCQdeQPLMTi1Y05+0Vg4X8slBIRZs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672845; c=relaxed/simple;
	bh=V55YgCvLSpqkfe7ySR+HVIoEjCLAZ+Tf3byG4H1tlRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSDI8/JhxTXYREbrwX4INVJhdplbRPKN5/NAX4hFqZku4+XLkvygchR93O8kdb8e0CTJWrTiszZk/HgX+/BjIY4elQr/MtTMPhjavrcWzUPWgeU8yEh0uLNW4eDS9lOh5VN5jkewjSE8A/ekOVTqEIV9+CSjfsGT2nPCEXP2dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoY84kTu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341cf28e055so1084910f8f.0;
        Thu, 28 Mar 2024 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672842; x=1712277642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfn3S64P658pp7FgLTURlhXPNN360y6ZzooV24q6Qx4=;
        b=FoY84kTuWo3g507K1L/0BqSPd3FDRjYm1DQEMhUn/3ofRVMeVeDWPWy2zrhbBMio0/
         LZv+R4NlgWvtPZ5xexnZrUu888VpbpnF0bh4Jows02rzvFb+miKLg3cvg06pRN94RDN6
         6V0JD9+2K2zbRK+b8mGbWScwWeoCEE74K6fNnV8Ex1AQpHJAS2qTfZtpTv8ViRUdPQFE
         FkOFjThj+WBROT+7AsJbk7jQBT+kep2YjNMQG8VuJ1hgYZ960J4KSqFhEgNkMn3Il4hB
         RzzbGsyb1rn1qirBSUwx8AWDrflXsFoFPPAr5kSC4lI+As4/6DaWVbftb0DD5s6XMhYm
         3MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672842; x=1712277642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfn3S64P658pp7FgLTURlhXPNN360y6ZzooV24q6Qx4=;
        b=snz9A5mW+xotNAHT+xc87Co9yhbSmsAHn9j1IdrOLv123Zk1kPi8JjQd7xvJpYqsdU
         12InJt1nwu/JBTYsmncgEtAvPIt0BGL/6sKoa7i+6x917tko4ku1Ws7ixbGyvDewdy8P
         9Nl5PfswsQCkrOL5sep49zEWLhQv+PqFBnU0hFlnGUoxjeXR2/QwZmvUdXUVw7geJx5q
         QaYm8aydkTSsgaNKlvWNFNOS59ZYvGuR+uCvSUPC4UfiC8yi/MHHpXtfEVwfnpToApMD
         kaWNtLnm4nREC6rZXzmqjedaEWpaGU6pSG5MUO/ifLo4jL4/fRHmnZ6B/bSotLmYCCO7
         yRLw==
X-Forwarded-Encrypted: i=1; AJvYcCXzofQSpaE6OuIiJRHTqhbachMizq2d5YP0SRBUCTo0cYWr5v7iXK53EoZT8XjAPOIhoJZG2Ynb/geX19HcahmdKOlHGjkf+qYhDnwgORzYOGQQzMBi2rHh+vViByEkf+tiOUqCeBx3YQ==
X-Gm-Message-State: AOJu0Yxezcn9+XkKsmFsS6l9BU4rDio//jlRUlmWQ/eccxRjKTdAPR2f
	SrZCXLpHuR2n+pOOLM2mLuC47CSvBS6tVzjvbsYhnn2nOnr3HowR
X-Google-Smtp-Source: AGHT+IFZm1frbVYStg1yuODYIU74d/4zgKC1XNB6+RkT3EgZWTe1W+u5RM0LiN/WWmVkUwgj0nYJww==
X-Received: by 2002:a05:6000:ec3:b0:33d:b2f8:28fc with SMTP id ea3-20020a0560000ec300b0033db2f828fcmr421452wrb.55.1711672842280;
        Thu, 28 Mar 2024 17:40:42 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:42 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Fri, 29 Mar 2024 00:40:27 +0000
Message-Id: <20240329004030.16153-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-3wire because the device allows to be configured for spi 3-wire
communication.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 07cacc3f6..280ed479e 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,6 +32,8 @@ properties:
 
   spi-cpol: true
 
+  spi-3wire: true
+
   interrupts:
     maxItems: 1
 
-- 
2.25.1


