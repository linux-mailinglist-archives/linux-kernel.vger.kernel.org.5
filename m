Return-Path: <linux-kernel+bounces-101474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF5987A799
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8559B22854
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F84416;
	Wed, 13 Mar 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyAALFgm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A04320C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333038; cv=none; b=ZnhN6SesaZx0Zus3mm42jIoUmm/KXKTj9/CG81Qtx9lV/pDoguffWFxVZ4AMHpwf6IdbakwpPhHH49jfrXQtluR+yh/EyXOwzRMf7WX4em/z0HDov+P5efQ8FO4vMeJe/MyPRFPFu/W/mtVRkIN3RNh+Zz1LT0Xlyjn/9xJ7Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333038; c=relaxed/simple;
	bh=sT0L9BckKHqkmWiQ1TJy+0lLYaGXwKSKGzRkk37Dgrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nufmgf3s66mOhDFb5/f8Pg/Obj9iVKA7+vaKGoPPNBxfUnq4J8e203P4VIJm/TvUq2NWeW2yg/+isRbCVUSrgUSjvRnLsSpRZa0tl12vbQxljqbZN6rkTJmyE8zakDcwBDE2Nr72fF/8GSPDnaO3wudyzNICyfpKEtE513nifV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZyAALFgm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b729669bso534860b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710333036; x=1710937836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NRtRnaHcWjxg3gWXRI9Vo8KmpG1UcPzmI7IQB6C9Io=;
        b=ZyAALFgmMzvr+GWTbmiQsFmoXl5bIk3SvWH4O04wWfEtQau9zcOsMMb5EABGMmb+hV
         MJN+a16aoKu0TO9S11SXs6Y+JCW6OCQw8JmNgD/S++5NPSdDOHiGCh8lO+On/FrhSV4h
         C8gQSzDpxubwIHJ1Cjowhi0HShRgemicyLDWr57Gmtqo9m6uU2/GQYcT16/7CbIYt8GE
         GS/mXGluPD4Z+51hnjER6Cc516sVp6KvhAYy7BPvbVRnNOYR0jRORL542RzCXXmyzi37
         1eeBMZFX5pWAKtD1s7QBXK8Bo/fDRQfI5lPS1/ytnvscq7LWiDUPI0zpfq0Hhmmviq7E
         GfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333036; x=1710937836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NRtRnaHcWjxg3gWXRI9Vo8KmpG1UcPzmI7IQB6C9Io=;
        b=jNPWZsi3LU1YTuE8AR5TaXuqIlwDn52X12QImjmAXdaVKltcIgru6n54q5Ii5E86PP
         hXunnN4NiKpUM7Sh0CUYnuSCyy5l6YpSQdWaywgYpnOTS8h3Qpz9C4fHKGOXkos2ocg3
         t3Xv2QqRgSnHKjaeuB+o2LTlAW5zU1JeOsvOD3CxwuI8C5e39+M/gFoMuWbbTzDTKndt
         G6ha01gvXQDWDMx/vAdgl7nd6122qVHi3L+it4tvys4rtBhjfhYF9Ncj+wnhkj/hUhyO
         sgI8V33l4APG6D0e/IZHQLNLPy/SboqyeGoB/7sd8JXUxWhV6X7MeJK3Qa1+xgPHkDiS
         Sodg==
X-Forwarded-Encrypted: i=1; AJvYcCXpy6S9y5AAsXbpipkforGpscox2NRD/yEnBjAB9nUZR2UsA4HUsuPsh/3SqhYmlT/eB4He8ZQTT1ZupaFaMwPHNiVqpYzwOZGqv2rz
X-Gm-Message-State: AOJu0YzbPaVNp5BCoKUgvQQJY42OeX5ulGJf1JzR1Pj80E+F0cr/SvyS
	MDmque5dbQwzCullphS2JMRP+S5PnSUzbClUaQzXliLdYlojBkeLukbscOkTGCc=
X-Google-Smtp-Source: AGHT+IFohoQfuxnsD/a6RyD2P2W/gjzack35QOqiIe14CT93AeglweEgHyADZlK6T2bJc7gBeKL4kQ==
X-Received: by 2002:a05:6a20:3552:b0:1a0:56c9:608e with SMTP id f18-20020a056a20355200b001a056c9608emr9963160pze.61.1710333035927;
        Wed, 13 Mar 2024 05:30:35 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.36])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b006e6150a5392sm7797307pff.155.2024.03.13.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:30:35 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
Date: Wed, 13 Mar 2024 18:00:14 +0530
Message-Id: <20240313123017.362570-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
Box Core board based on the Qualcomm APQ8016E SoC. For more information
refer to the product page [1].

One of the major difference from db410c is serial port where HMIBSC board
uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
configured via gpio99 and gpio100).

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 1GiB RAM
- 8GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI
- USB ethernet adaptors (soldered)

This series is a v2 since v1 of this DTS file has been reviewed on the
U-Boot mailing list [2].

Changes in v2:
- Fix DT schema warnings.
- Incorporate suggestions from Stephan.
- Document UART1 mode GPIOs based mux.

[1] https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20240311111027.44577-6-sumit.garg@linaro.org/

Sumit Garg (3):
  dt-bindings: vendor-prefixes: Add Schneider Electric
  dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
  arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/apq8016-schneider-hmibsc.dts     | 519 ++++++++++++++++++
 4 files changed, 523 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts

-- 
2.34.1


