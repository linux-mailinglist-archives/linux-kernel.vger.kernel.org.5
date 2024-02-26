Return-Path: <linux-kernel+bounces-82033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A491867E01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6BC1F2C7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CB13249F;
	Mon, 26 Feb 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfss5x4s"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1513246E;
	Mon, 26 Feb 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967579; cv=none; b=pd40v17qIKTjt43+D4p3gDvhKK2Ij6nica0Vd1Suax/qZFnCseVeEPuF5EHiw/qEVuLww8QGb+AMM41/yiJPxPwFTxT8RQZVVdJEYoPqGehGhdeSZvOHDgSMV3Iy0BodpfnIduHy9bRsgUmEPt+oc3YeidopJUFr4++Wfbf4DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967579; c=relaxed/simple;
	bh=1TNgDSRAcERP7E9GYUoHG2Dxre7haCNQ0AUODR+HYT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQrdsf0XDdZbXQaYHj++eX93bUaevY2ofMr4L5rRGwsbFDSnXTLVmnxzNp04AwAl5b5y2vYpedvYRcaR1dqmSNEU4hkByxk/zBnqqyM2nimogmGJnC7N/78kVKGkXueVBvocoXFaAEahfk+Rxcu3HCXeU1V6UHK0U+GUj/DHeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfss5x4s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so469571466b.2;
        Mon, 26 Feb 2024 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967576; x=1709572376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7HLagkjp2P/OuiohNJhV3DwRlbaPh7+iztUkh7BcyI=;
        b=Mfss5x4sJkJiEOPXE5oMy/Qzil6+LTlvpRuBgzbjkAaaWiW2yg/kTdAO2z+Shlz5YL
         5SitvkRibrjItzRiZvMGc5NIyQrH4mOsc4j8Z7dA+z2GchIYG276yQYrcjHcAJ7MF7v+
         DPXH671lmAowmMhdX0GnBIUewHLcTdN/jCyOleAxoEWvnpsJ6WQISNsWVFSF0Pw6yayU
         KTbVMvXBhUy4xZ4bVxHuJyi7UlzHoQtXDcxIEe/ajnoVp9kuLnMaRTUpAyIaANehorAd
         GKbcw18muD2eblhFpIp3VjJAyK6Ivp0AdJLgMFBjClu/BWtzf+JEtsdyK4YjpurFDFsx
         R8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967576; x=1709572376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7HLagkjp2P/OuiohNJhV3DwRlbaPh7+iztUkh7BcyI=;
        b=q0AydxvAb3mEgOv45cmGBNI28tloBy3FkROawOxInT6QYHf5f1hg/r7R2yJvJap+Mm
         x5ZCsUUX5/+FezY2Ngm/DPcAgjVocx7v87vdTIW1Ls8BacnGS/kcYUgiMpoRuKfzkz/B
         8kJwWRpDvIQNemTq7f65EO4EU5peJH1VzTXPRQsB00mvAwLVgMmDadJULQ89wCaGRsqH
         zZ0ibM6Sb3tmRxd57A4DSWxs8lsrMys4zBLnH7A3WRFPQmfVlzCti88y95GBBzkjnGB7
         xZ1ooCY7q13z042EqBtwhZF3FuuwvS5eXeTHqO0B/7IjchSD2+xpI7h3uOGPLU1QTHWg
         2gkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSJWQTtQq8RnB46ezKg2s2N8yzBOCYjy29L4JgscV+6hW55jDasZ3Ueg+i77VXDMbv6N3GqEoBD66EbNiqBufscspiBDYmTSlu6JXxMQgusKpz55z4jrAYVdAscLCLvhJlOTptfMXS6Q==
X-Gm-Message-State: AOJu0YyJOp2lU09UNNgFRd0FzxdpOvJtIhYPjSeOxzEg9kTxQMDUOQI6
	ceQgqAye7PzRwgbKJL/u422DS2KD/8iFvvpEFGrCOYbEt2Vy1VSp
X-Google-Smtp-Source: AGHT+IFlKjXsHKUpkAekYQ8/c2mGt55QDmyztrUh44EytB8ljOO0SzR/YzSTySvuiE2vCNDqsmqG4A==
X-Received: by 2002:a17:906:bc93:b0:a3e:c5c3:cb68 with SMTP id lv19-20020a170906bc9300b00a3ec5c3cb68mr4855715ejb.8.1708967575594;
        Mon, 26 Feb 2024 09:12:55 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id ss3-20020a170907c00300b00a4396e930bdsm98989ejc.79.2024.02.26.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:12:55 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 26 Feb 2024 18:12:39 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-archer-ax55-v1-v2-1-3776eb61f432@gmail.com>
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
In-Reply-To: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3

Document the TP-Link Archer AX55 v1 which is a dual-band
WiFi router based on the IPQ5018 SoC.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
  - add 'Acked-by' tag from Conor
  - Link to v1: https://lore.kernel.org/all/20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a4440..ff0a3b64f37a5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -351,6 +351,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-rdp432-c2
+              - tplink,archer-ax55-v1
           - const: qcom,ipq5018
 
       - items:

-- 
2.43.2


