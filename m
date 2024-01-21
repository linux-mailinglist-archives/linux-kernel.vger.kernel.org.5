Return-Path: <linux-kernel+bounces-32128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7308356D6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F46281E26
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CB381DB;
	Sun, 21 Jan 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnzOcbFN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F837701;
	Sun, 21 Jan 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856360; cv=none; b=ilmH7Ivpaa5VSLstJWxjC2nqMgHrkC37WsqTsU3ke1PwT3EXjnV9PSAC07Ki1jNzs+dGIoXZxaBRv/4WfL+d+/VqEddZB4PrNRrQUFQQ9vIf3QQGcS+MTUpQNK6a4+hUn+RQzFiWITOhjFV92yEnOXxG3qRxtlUkJwU1Pf5DgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856360; c=relaxed/simple;
	bh=qVaislNuQL0+E4M3fCbQWAEijGl2Fh676slFhuCB5ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+WnA5IQxNscZyceeJgL5wDLGMw2cEuKls/RnDnZwflZj+MHH8qZRJETUvppNWx7oP4FHKRoAQhYizszVu9rFyr4DsFfUZmljyFGHVxo1VNK1s2d4GP/V4yvvUwAI/GfI+qihrfw10DpTTHwSbIQZ30GzwxJPxSdMKnTXjVHyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnzOcbFN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d05b8942so2739649f8f.3;
        Sun, 21 Jan 2024 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856357; x=1706461157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrP9wfCZ2jd6RtCktC65pL13ukk88B3IGZsPZAZd47s=;
        b=KnzOcbFNhV9kyzoFyn2/SXZf7fYmC8Mrdf9pCiyXrIuxXkE/T8ZEAQWQMkOsRt0PqE
         4xOqpgcRkF1jRCF/8Hug5fMYfe0RC7K94hPqG505GapSBHSzyqCxV7mEZLzurjdwISs4
         b5ApOydPm+AU9I40hP3jBDXL892I8LwtXrw4kqk77Ibx2YJbvGHSaWD9QBsyZWOAIrwj
         1niKUsl3YhGtGLe62R7foo4hOforMU2gIydmhPzcDkYTTFPU4DTIIK7GMLmlZeo8EUc3
         8Fx8z82vjBtLUcmovY88QReBx9Lpcwibzd1Gnl0ki/x7Ps3I84RyL3JNEKdb6KiRgfMl
         2pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856357; x=1706461157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrP9wfCZ2jd6RtCktC65pL13ukk88B3IGZsPZAZd47s=;
        b=tahspR8xb55GZC9cmoKELwjbXwRbQYcC+I6L0l7lEaE1Yid+fLlRy96KAIIxFgGZql
         5/s0pwkU16rNPMptEA9SSDMyrASZSS0M/c4CMzZBcEdqyeYtDxDEW7zPkW6Y32QIsAth
         JebKJ6/aGYCmNgiLSKAVc9yKZb9pfq0oSymoqsqk8LfDfuYkZ7TPTJ7mJGPhvlU9wUqT
         SZ14Ky8l2lyCQeYE0AOEowRipcV/CI9wJCZ7cc2A2oizjrrxYHlpzUNLa9KyTF+U4btw
         9NMjYMWwwFuWUj+3U4iNKfNDM5ofHzzcwYLRB2Hp9FFhvB/uwJPzBQDwIZZphr/uWZBM
         WtDw==
X-Gm-Message-State: AOJu0YyYZ80v3kvJ8CFpANmT7Ak76IqoixycEKD6IzZSXq+n/mjiO6+I
	HZzLX5nqZ2Z3X0yMnjSpRlOy6fSiagYoHf2o47Hnwm5fJy9M2FWSvpdnaXR/
X-Google-Smtp-Source: AGHT+IHgwqwfnrwyYx4GELirb4O616sy167S9jUeoBLlOPt8dQcdntaeRd2H0ZUNOYNgKGDoH6RGhA==
X-Received: by 2002:a5d:4909:0:b0:337:c409:7185 with SMTP id x9-20020a5d4909000000b00337c4097185mr1484584wrq.94.1705856356794;
        Sun, 21 Jan 2024 08:59:16 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:16 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:41 +0100
Subject: [PATCH v4 1/8] dt-bindings: crypto: ice: Document SC7180 inline
 crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-1-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=963;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=qVaislNuQL0+E4M3fCbQWAEijGl2Fh676slFhuCB5ls=;
 b=9HTrsSpduIv2mwBjs1XJi1bw5o2OEcQY6lYj8iILvPj6Y+FxFPgzh2qDpXJ5dJGz4yaUFWh/D
 9VxDlSzjpLQBGBZclcODRqlOx0Fse5/u9wppCugvvn63EQVSewF52Bv
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Document the compatible used for the inline crypto engine found on
SC7180.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 09e43157cc71..e91bc7dc6ad3 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,sa8775p-inline-crypto-engine
+          - qcom,sc7180-inline-crypto-engine
           - qcom,sm8450-inline-crypto-engine
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine

-- 
2.43.0


