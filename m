Return-Path: <linux-kernel+bounces-61395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BB8511D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A04B1F217AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CCB38DDB;
	Mon, 12 Feb 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkCrxh5F"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C628DDE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736113; cv=none; b=QXx+Ygoy8yD6T0d36ht1QZ8lNCiJMq5Dfv6O/8FnIu2PV1v0i17/HyShsew1CXq24SFiBfCanzCp/fG/YdxZfTT65s7e8c6be3vH1BPdqcrqb4MnwPDQ6ZcngN6k9fBZyXOFrCyk1EXVS9BM58WgN70IuAwjqogDhaIoyLNgRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736113; c=relaxed/simple;
	bh=Z4fXPYF+u4xQMADIv1caxo1oAU+Gf9t6WriHQ4dbuR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSeztVX3WX6bX7gN3AJv4zn5Tff8IOsz2HXr04ij+8YF+sJkTWs6B3XZn2xCDB/ZRCmgnw1+f/VZk4Ll82lqn1AeEwp6Sbh4CiVepa7XYxL02m5+WhppXAG90ZQ4Dn2PrMr2nlZdjJg0Vb4eHVLV7v0FzUnucYzeHd0LN/1U3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkCrxh5F; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so42065551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736110; x=1708340910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfTLuqaQQYd2f5mdVnL2DmE1HEJ+HNnrT7PmO4Teuv8=;
        b=BkCrxh5F9SAgnuhSLq3LmWlWvRdeuOrzewcDCobqVJiV5zf8Pix62bp4MnGbJ+LkCN
         xlbNty81OSeq/v1uFDSzmH2CfDpiOzQh5N8YBV/PuKqUY8B6VcMMcLxChZjIfiFHiFuG
         pB2bgzvG8fKleoWKllJHOa7+1/ZgQflS0+dQHH5dUs4LVx2GVDnXopKSZ1nCpf5ZgK39
         aOX929gCfvYA59wT9AEkgJ1jzRxlLaZg7TFdhSB55N4QdTp8lrjnIzg0dwPxWYCtFt4y
         2X2h8zjtFfW5yMi6eFnt2ogAAvMAAMPgNYTKNka6v5xUmK0AXqRVh9kGu0yVVOK/PEzg
         HwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736110; x=1708340910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfTLuqaQQYd2f5mdVnL2DmE1HEJ+HNnrT7PmO4Teuv8=;
        b=lRsQpionerNkiJcHbSVr3FAfmm8/a9okz9yZmp8rWzAjX32pDOQlIJupU+MEDi2laf
         tV8RrE83c5PMXOBRCf8NzhnZj6eGbjYdo0Kq5UXZ5dNdVwVDGCl26bxuy4vewpgOUJ4R
         8wdgZL9HwrF80vgrpT/vfpfikqcsUyIBZeNEaAoPVi8KGL2J7Wh/KEfUtzxbyHsYHf8n
         hb0Z0180t/P48KSPYqjKF9A9vx8hso9zCAh+wNC7Vfe4x747dj+r7PwJvjNa3t5uS9RU
         KFIaFByNOD9bVC9QSgO5LW/16xJyhmgFiAAJFwPycqNVpw0WIL3AMR0FTNkUk4364O6q
         p0NA==
X-Forwarded-Encrypted: i=1; AJvYcCVchPPi/u0rSSMtEA8GQIhy7ovPSYW6Zwy2wnqpBDXKFCI40MJtPIWM5+vBcGaoZrNFkaczq6K9ydLF1KjJM2L+mT1yi0PG5v19Cv9e
X-Gm-Message-State: AOJu0YyAXOw+CT1ylSaAj1aAgC6pq6qtsYHIOhuKnYIZ+NnUpF3jRCBl
	yikyg3hBlMRGbQOoV0upV7htYhGINS55bAmjrib3KfZpHdxqRF0Mr6F6Vam5VR4=
X-Google-Smtp-Source: AGHT+IFrYp7jVbLMON3sX343Qlc4Oqd39mOVmCwr8JosE6dUGQTfF5mDShcbYFnMdBS7etdJs8gtlg==
X-Received: by 2002:a2e:a549:0:b0:2d0:de9d:49a6 with SMTP id e9-20020a2ea549000000b002d0de9d49a6mr4737467ljn.13.1707736110044;
        Mon, 12 Feb 2024 03:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXduac7nelVsj7lCvoOZ0nIQQUNLh9eeIR3+KumAxP9wf2KVzJtNPZDC9yknywycJTH+IwTYXaf1AeDEVWHtrfFM/CsiRhjUnWiiSunxxzmSWdbKgYna3JNRUxsKGsP99NxUf6T+Xps3NiGPDfuPjof4ggeCKRUot1y3x+CxiodlyEnkjm1rehIP0AMhdsJgSFL9ZIdD6qtuKf2sbYPaoUTgmfWEsQE0S5zbkUmDdp237+p9Y6vExH9AI0ro/ueey94yByj7nSMgURoVCHJ03klsqcgG1PK5AQGf5oiQXLzMxnmC2NcyHB0mpxvvsHARrTih5C318Dx
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b0033b87c2725csm846175wrb.104.2024.02.12.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:08:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Compute callbacks can be DMA coherent
Date: Mon, 12 Feb 2024 12:08:27 +0100
Message-Id: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently on Qualcomm SM8550 and SM8650 the FastRPC compute callbacks
are DMA coherent:

  sm8650-qrd.dtb: fastrpc: compute-cb@2: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add missing subject prefix.
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2dc3e245fa5d..c27a8f33d8d7 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -77,6 +77,8 @@ patternProperties:
       reg:
         maxItems: 1
 
+      dma-coherent: true
+
       iommus:
         minItems: 1
         maxItems: 3
-- 
2.34.1


