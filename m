Return-Path: <linux-kernel+bounces-119225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E155888C5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB31F36AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55C13C831;
	Tue, 26 Mar 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLp/MQJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D613C803;
	Tue, 26 Mar 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464768; cv=none; b=Mvo3t0hjmh5gg/qRbMLmSQMMnB7N50aU5VdXapCWwtzqAnkyhy1DjdKN2q3Nawqk3NXLTtueHNEclsTtysjf6Sv7w6fB1bpQcj/DajUnrd0pvhMhksg8vh4MxtIPFGSQYBlTVw6rj54IsYpwNuUZxkFy4LTfDgiB38ohi93dsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464768; c=relaxed/simple;
	bh=HILMYs4h1rG96WDgtx+Icxzw5/JMxRKEsNJrNbbnvBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6vX12/9pkI9qqZH1mQMd0U//7b2LVjt5BpLx/HjUQCK010YkR3spU2hSGYZktdaObgJMJy5ZC0Nuz6djewKo6CIioqlKpyWqnLBw59D2W3ob38h1K2kOLgS0N87ZjmkyZ4si1LwOsOEZhQXG30X8mejdEsGtBCXfdsZ6xGnZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcLp/MQJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341cf28dff6so1403329f8f.1;
        Tue, 26 Mar 2024 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464765; x=1712069565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc+1G2bhD6w4OGXAuo+s/Og1oRCDF2l5PcGTFXXgzA0=;
        b=NcLp/MQJbihIXo4OgUHcpJA8UeIZYv1SAP7baz6hPK9D4o+a9umBsgcLXA2CKgQmGy
         ZT/a848eiXLN0ceXXCwZSyfuAP//6wJ7xG7KFbVJwL4paOe48yaonTNAAXRM/FeSX3HC
         UkxV4atTC/6OREFkqDZZ6LMRe7rAJ52sUOF4qZ6OJW+FFrnHEoMfmipbAzMMjUEYPifw
         YAv8PgKCDsT6Xli39sWeM1GXh/e/Zf5DJvXViAUD9pZ3JLVnt1X190dAecu0L4L/OpVL
         uuqHEwylq2ROV5cl+TquKK3nNxCZc60oKmSGcTYbvAYl3xwVH5Y4mis1vmIietpdpuLs
         xf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464765; x=1712069565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc+1G2bhD6w4OGXAuo+s/Og1oRCDF2l5PcGTFXXgzA0=;
        b=U3LU0fW+UHz4DqV7kaz/TeDGiBBNPZ8xFxv3DF6Xf8tLhmR/ss+J2U2fXUoR435AAk
         vxnhjphHXk7E15YeHnWN8n5swfg6fv75jliuQDOCkHRG1vUCOjpwrf+4njShbjoYxKYI
         GmX2GlF5ucmxiMcoQrSuIHaxWxAbBikLxGFzlwxjFH5CzW4XFmvoXiryPoHTKMcvP6Ak
         x0GPnINn6ggiUnzSDRTLT0wM1AfTp4JUy5/a2KDUyqeg2TMs12PM+xsqSMGYsaa6xBT2
         juaEm/uaLXxAOPs9NcWUKSbu6SDeps5rwTNiU3ROUyGj17Lj33+lbKsdGAUV8YntS2eS
         PYQA==
X-Forwarded-Encrypted: i=1; AJvYcCVG4U/U/jtOKKyENfRAB20C0F+TfwbiqLO87CiW70PsgJmkMsWDRGfKYINUYGdVYj/NwtBLgUWQGRAjzvXMsHtWgoPDbVVCzS+FFqo9EwCcepb0xiDd55nsYgQ1mICmH/IEBMEp4Qvzvw==
X-Gm-Message-State: AOJu0YyoWs7GItWpyj8VnyYUQCIXxQS1ST6UQnV4E3fxJEs1du8dJc4W
	zxRlTx8ea8Ixv/U22p9bDlZLqw7H/v680Kr5HkqK9DdMsXQTWacpMaZb9lb81e8=
X-Google-Smtp-Source: AGHT+IFAbb3toug+LlHxILdSemZdXmh/tEpE8tbtxIGaYlfIoXByRtWq6tGDYoxjMNFGQP8uq9qxlA==
X-Received: by 2002:a5d:47c1:0:b0:33e:c522:e3b9 with SMTP id o1-20020a5d47c1000000b0033ec522e3b9mr2361880wrc.36.1711464764497;
        Tue, 26 Mar 2024 07:52:44 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id h8-20020a05600004c800b0033b66c2d61esm12281738wri.48.2024.03.26.07.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:52:44 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 15:52:27 +0100
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-archer-ax55-v1-v4-1-dc5b54a4bb00@gmail.com>
References: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
In-Reply-To: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

Document the TP-Link Archer AX55 v1 which is a dual-band
WiFi router based on the IPQ5018 SoC.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
  - rebase on top of v6.8
  - Link to v2: https://lore.kernel.org/r/20240226-archer-ax55-v1-v2-1-3776eb61f432@gmail.com
Changes in v2:
  - add 'Acked-by' tag from Conor
  - Link to v1: https://lore.kernel.org/all/20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1dc..c05b4183b7781 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -315,6 +315,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-rdp432-c2
+              - tplink,archer-ax55-v1
           - const: qcom,ipq5018
 
       - items:

-- 
2.44.0


