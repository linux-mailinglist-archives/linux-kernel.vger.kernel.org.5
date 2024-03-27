Return-Path: <linux-kernel+bounces-120384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC888D690
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67681F2ADD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B942CCDF;
	Wed, 27 Mar 2024 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rX9hFqzA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867628DC1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521468; cv=none; b=Fk3N1UUBD3NMxifUbYjKrGkMBOjaKvf5g4Ni+MKbrge1dV/JYgH/xyxtI7Esp8LzI8GizgJTwCtwtEZZce8RpMOhg3/MGsfuK0qDOAl119NJLeRVfeys29W3a3SVWeYUka1XeJZ9DF2/V+C767gN1MPe7OxR9hMZr1GcvIa2EdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521468; c=relaxed/simple;
	bh=rHzJlIlLylwF2nmSrco5JVWmgNdr4kVMvEWqhj8ugyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsaP70YAS84T7Y83RXaUG6eWcpA9BucSR0MDmihNl6TmyVv3VdsQh5WsHcW4Nv7Xvt1WvE/PvGoK4i5sZnYaL9dELa3MwfDogde+vI7gmYat59XaMr34qR5XDbnTRpWN642xr3uu88MhkDPAaVvSBfHGAHUqs0pE9wducVSINyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rX9hFqzA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4798201a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711521466; x=1712126266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzuMc6uiawWNsZVdxOPIQ004/Qe4UA9WjkrGBwQagnU=;
        b=rX9hFqzA3KNQdqmisJGZjtllNaaYI0q+xqp484gX9uNFIANXH1vEDOOnsJkYWV4w6z
         ws0GWK9vmiwBhMkEPIZjbqWGzJTn8Tne12PmEjrrzwwMIJCykcAkVDKImDb0TGyggxS2
         MSovjVrDuHwlHAvG1+E8U1DlUSahI43XF9aHKV251D5bPQZ3DOC/RPdzJeokwFAssCIo
         MTO4S38D1ryFppuEPHknjnsxN/gnXK9sHStJndYJSR+SxuvoIUsAR9nf/kJdVD6nWYlu
         7g00TptFTvjIlvYBBm6A1i5LWK7dP5JN2ulhEM4u5CLhbnsJspNpttIej9bbGd+Nyf1l
         fPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521466; x=1712126266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzuMc6uiawWNsZVdxOPIQ004/Qe4UA9WjkrGBwQagnU=;
        b=Fe27McsybALhzWkB5wXYQBr5/a9OepxsKw1MsZ+Zu0d/1MYlxS1Cam4zukMOd0kUcM
         aFrmr50eeuyICP71fBXWj+ot8tCZVsc3FOqgjW8822zp0tnXT/jFNFVlQn7Zk89jabGi
         JO83WtRVyPZFxEdlvrJmM8q1ndrDQ+pFWOgf0n8aWHP8H5P89K1ChjC824Vdf95xHH/K
         1P7keOuTYlBN4mq/qmpdj8y7Ik6/5CDeTmlOLtE6Zzua2uk9UguI2zETeYaJIJd6dila
         S/NICvHVMfcYVjNxufe+/a3nGRp0ppGNpZEHFiGIRTNQcnYP2vVkYP017uYQLN2vr4MU
         mR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeVegTxmEPbnPe3CVCzT23jgEHgwJbRkQokhAgLVGBb9x8m0BCKVVrnZ9abLFtuekzaFSoh5SV20VqJHuSmP+6U0ZmsRT9IgrT+Iq3
X-Gm-Message-State: AOJu0YxQj/zkY5s1m0ERbXgGbBKKdiujmPbw95o3lvvhuhPeTKMhfkLh
	w8feQdnIMMXCqUVcxx+gaDMHXnawjMcMzD853px68noJlIWuf3feQ4tQuy87Ris=
X-Google-Smtp-Source: AGHT+IHDZNJIq84rIv9rwKxSPynuDT6jjzNUSdTtzlAokI3z2Kh/GRaTg9R2aeEuG6JCyWM9cRMVHA==
X-Received: by 2002:a05:6a20:7da3:b0:1a3:b642:5fc3 with SMTP id v35-20020a056a207da300b001a3b6425fc3mr393219pzj.41.1711521465737;
        Tue, 26 Mar 2024 23:37:45 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.127])
        by smtp.gmail.com with ESMTPSA id qd5-20020a17090b3cc500b002a02f8d350fsm772765pjb.53.2024.03.26.23.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:37:45 -0700 (PDT)
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
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
Date: Wed, 27 Mar 2024 12:07:31 +0530
Message-Id: <20240327063734.3236117-1-sumit.garg@linaro.org>
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

Changes in v4:
- Dropped IRQ_TYPE_EDGE_FALLING for pm8916_resin given the expectations
  of Linux kernel driver. Instead depend on systemd workaround suggested
  by Caleb to get expected HMIBSC reset behaviour.
- Incorporated further DT coding style comments from Stephen.
- Warnings reported by Rob's DT check bot aren't related to HMIBSC
  board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
  still not converted to YAML format.

Changes in v3:
- Picked up tags.
- Fixed further DT schema warnings.
- Configure resin/power button interrupt as falling edge.
- Incorporate DTS coding style comments from Krzysztof and Konrad.

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
 .../dts/qcom/apq8016-schneider-hmibsc.dts     | 490 ++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts

-- 
2.34.1


