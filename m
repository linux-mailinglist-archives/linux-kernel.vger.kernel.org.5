Return-Path: <linux-kernel+bounces-37349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F683AE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80341C2109F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5E7CF3D;
	Wed, 24 Jan 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrOCAIH2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317037E561
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114712; cv=none; b=FpoXyNCtSeeYKzMdrfPa9KPrJPv1eC4DivnmeqJzKkrRyj3NAyrtfNahl04roMVk4dKEoqQwIzGnsWuwk/iRItsf1po72ZMsDcGHAo/KQtenZYs/PWh7MlJCysuUEyYRBL+n8ol++edev8KYECWCh6hz1KLM0S6p9GLSl/2pQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114712; c=relaxed/simple;
	bh=3rZvPqvCnI5w/SpkzoxzJYPXRXQwQmMIpGF4DlHAUZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyM+XNjIS2pZv84pYAHlH935Q3Qq79utaWULkUzpx3L0PGXbcRdnFs8mr9y6uveNqngOm7ETK6FJPqRCtZPcxKIAmKYomAlR19H8vrOe4GqFoY3472FjuuvjTUi9LGMulxjkNi48CavRJSAFmegxjjDM5lf9mk2oL9ArbUh4kXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrOCAIH2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392b15ca41so2564795f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706114708; x=1706719508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pvoYaI2BKa7cNMRECEuAWo8+54tJ7nx26haCoL0CnlU=;
        b=NrOCAIH2mhyBjQXpAQ83pGqdzD2oPjwFte9Qj12ptfLf+MWKX62dDdBovU8xwGGnEY
         7WQnEYCrqhablATOsvh+Qio2UHQHLcSaYLtCTzBhhVCECL8tHuisT1zSLVR0//D2hrQC
         Jugoh2GQQ7vr+tDeg/kNnbdSnvMsyzAusfjxrgB0q53MxM8+XNsCU4ctHiBuvKwPk1Fv
         ruepGZXAw+TVumufpwUvjnTp+DruZLlDkbj7AYLqMfUUhgCYHUufsKDDtBwkYv10Spr+
         4G2ARxkz8IMGzu5nYFIFkoVdvGmyrhjBDUnooJX5EIMlVhWAk1Ld4vFA7g45MWjxXBss
         CtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114708; x=1706719508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvoYaI2BKa7cNMRECEuAWo8+54tJ7nx26haCoL0CnlU=;
        b=IvCwPMZ7GpAMKuEfIILPYDXOshJOqxTHHNb8XdNAKsmgh76zToPQDmFdf/y/o85Nci
         4QK5P5Fgr004sN/8QMD/lc7dSiRRQGoLBnz09zyg7AYpfV3EJijtTvO7GE9hnGjz020J
         ShaZM5BkwJDGM18LvGcrXEhZHWWXYwhiDqP7C3m/Zm8Fo+d6SED3uOdQwLW3W9HlZoDk
         BxtCTCb1pVy+lr7OFLPkWWYZxF9kz8bAVr9guFLKNppB8gth0VLE0Bhk/LNguZKJkUtT
         EFi56wxxU7ROwHJTLKNXbmoPd9/Tr4PsxPkT2+LI68CG21wH0nAnRlS/HnQuNnjLXm1B
         IRyA==
X-Gm-Message-State: AOJu0Yw8plEHPWVkKgwxLsNZ1whXsNwi8iWedXrdkzC2k2sC2quhchVB
	QzsnYfbLkuE0X2ElDAtCS/i9yby9HpdDaPWF/SlBwoqfZraaKbSH4jn8yGECvJI=
X-Google-Smtp-Source: AGHT+IGcYUmkCTRpG/I8E3chXDc/GJE+/1YMGUO7gtkFGBajwWIAW9NHntpMktgjfMEXg8YdZCuTNw==
X-Received: by 2002:a5d:4a87:0:b0:337:d8a5:32d6 with SMTP id o7-20020a5d4a87000000b00337d8a532d6mr629718wrq.9.1706114708361;
        Wed, 24 Jan 2024 08:45:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0033936c34713sm8137883wrd.78.2024.01.24.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:45:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping
Date: Wed, 24 Jan 2024 17:45:02 +0100
Message-Id: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
it is offset by one.  Correct it to fix recording via analogue
microphones.

Cc: <stable@vger.kernel.org>
Fixes: 83fae950c992 ("arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 6c8e206080d2..76e9ca954093 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -842,7 +842,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
-- 
2.34.1


