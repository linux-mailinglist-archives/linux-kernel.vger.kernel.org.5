Return-Path: <linux-kernel+bounces-102359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FEB87B122
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86FC2885E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2173180;
	Wed, 13 Mar 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK8SShW5"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BD73161;
	Wed, 13 Mar 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354353; cv=none; b=dwdutuaovhkDe0edM7zaDuieVe3GONDbEkB/cTlgD5sVnExhs5XAs8NpIx/ew6Z/IRYw0TMquVf3xYhX3xZYu62I54Fqj/U2eB8aOeJad4+ybntQtmQQBHcQG1hP83zaCksR0/5WahUpqq9IVppnn15Hw9BRTs2ZfdC1B6FcKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354353; c=relaxed/simple;
	bh=R2eHK0/OA+aZRstAwhYnNpHMANgG1VYJgw/zHVMzVQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeZE4Gve0mNoI1naHIleLYQQIdxgqurNqFW3RVn/uQlwsYk9wrzg5cICD9duUVWsjv2ziIf5nn5R21KMdudgUjMQTFtHtNkCoD7S2RJpetMDfm6TMRa0W0w3EdAgFBOIhLSpJC1WvBucOs5FQvuzOly3Qs2li2Uj8WzLL9Lzhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK8SShW5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so1073221fa.3;
        Wed, 13 Mar 2024 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710354350; x=1710959150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nwqyPRCW3yWvHdFzrC5zmEkEMgb5FIziYioyJcdA80=;
        b=QK8SShW5mbiuUUjt/tDkCyhdyltGXBar3CkdT2D4YV+KTw999T0s5YXK1NBB4ghc0I
         9D9LkZU/OBifWgUCrEq7OIsmN8gNXbCGuIv7PBrtTtItF/6VjHsDaWtcpYJ9D7NjXnPD
         YqZ4tGWy5+VWizftpHNz2nOVMvKXAPRcqJF4x6n35MHpX9DTycXmG9OFq5kD28ZNej8I
         fY6LcmehG3kcrJLT1awDSUPVEI1JnYdnwkFQzgs1PlO3+yCMfiPU6EePF38ESnzYxuJ5
         H/MnWCr2wyrHAFxDdsaAfyoCf/FR+u2kkGj1YRHHZgqEIUpx9pgz2t+7mBWhGL1l4Zv3
         Oc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354350; x=1710959150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nwqyPRCW3yWvHdFzrC5zmEkEMgb5FIziYioyJcdA80=;
        b=IHEeKKNh7LOC6OSGSWsRK/fPhWgOE3uIORteftAmkjzeN+h+M0DbcwVFkp4zatEN0T
         yt2szMsrx5Y1cB/ZX4LHXkbhvqpGhclGueYPML3qrJgy/ffR1Uw73vbX/hRY/XxsBRbV
         sD8U6OaQnHSzj8q0FgTOzADqMi4FZ0oLMgAf9zFAcN5f0KVahDRrgTovOh1h2JeHRcke
         YHBcduD8Fh4roy01fz+PvwaR3A6cFVGb28Oqocp/mMDm4Q5QSvnOsdiuA94xqLj4HiPp
         i+7fpXgjzqeldPGPl2CTHvzkejOdRLCxE6Gd7n2Mu/M8xpcn3orhzn7AitNto0mmids7
         aHQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/cARlZyOU24v3YRWfDC+9bwwjvZnr0dSKWsjV650mCF/Sq7Dj8o9aHSHSrj2BbQKYzHD6egWfyvBXfPllNBlfPRvyz7n034MLjsmz+CBo39uaL0dfLwYGUGibhVRdQzSKtE9JsnVgdg==
X-Gm-Message-State: AOJu0Yxt9bRvSTMVJmtXejknU8frNUFX+BFFVyecxBLqyWghWPZD6ZTy
	5s7Q4seIGgl9GkBA5MtUfuTQLm76Ex9pCA0wLCRsUj3E8ocU+LVO
X-Google-Smtp-Source: AGHT+IH+J9CelZ6bJSRu7H8DRsRUWgSFQ7ZcblYUxIppSK4BPULb4HpACyvuRCOtBJ4x8Fl7ov4vuw==
X-Received: by 2002:a2e:b8ce:0:b0:2d4:3cf8:1843 with SMTP id s14-20020a2eb8ce000000b002d43cf81843mr7963407ljp.6.1710354349618;
        Wed, 13 Mar 2024 11:25:49 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id k15-20020aa7c04f000000b0056864cde14dsm2827390edo.68.2024.03.13.11.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:25:49 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 13 Mar 2024 19:25:39 +0100
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-archer-ax55-v1-v3-1-cd9402efab59@gmail.com>
References: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
In-Reply-To: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
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
2.44.0


