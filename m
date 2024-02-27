Return-Path: <linux-kernel+bounces-83395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B8869806
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C831C2321D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97749145344;
	Tue, 27 Feb 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCBXkvLk"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5513B2B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044051; cv=none; b=II6Ft8fHMaQQURsbwwOLrXMNPBV9F2gNZondq2PkPUzbryum0YlIGeedEaalWX+ZYgaUAPAx2N+Ikqh44kXd8nq6YM2i4mFq6Yx9EG/BDztkMRABt7CZEz7hai62V6XYm8GKu9duR6nXfqCBrQV3rp0PYVOMjKmSvMM4hu29Lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044051; c=relaxed/simple;
	bh=roGU0rn07H+CN0BM1sUoDiaaO7W9Oh8V2PP/kib7geI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPAkCurOTneD2oYvOEFtw54ZXHXT32X+rxR4GwsMlqPBjCXrSe4eCtHEDf2mBjlryWCUPkajOXscxPxqfpXzqrLc9JZgVXAyunU537x7OU9xQFuncnbLpUK9T0tBGcOmhtnYM+yYZv6tLR5iGtR8wjL/6uI9LU57jmA1jlYniHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fCBXkvLk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so7562046a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709044048; x=1709648848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kD3E49r73xF3oSKYiHLwdSLYHlLARjZJlqpTBrcFb9U=;
        b=fCBXkvLk+hm+MKUbNugqE6LE7woJFLfgTUylpeSfToQcXyiK/F8cYx4+IrS8eSwwws
         pIql7z50wvZ3mLhApQVvDObSRfJIn/A2grnDFxcPVa/rU58Q97L8ZnN8jNvB0XjuVtjj
         slJnH6TvH/GWPi1tvyAXvBNVBQy2bfyJklVnw/vuH5nIpeXYUPM0v/BC0SK6rT8WZYAr
         Q1S5rkNYFwO78J7167TdJj5Y9WbSOBFQcWp/T6QFXjAaud/bE+1D8EC8B8s+SQ3zTKv1
         AuUjQnBi8UjNVH7yPwyNuvMw3pLPmlDK63ruIHOR8GHDZYA/vw0kImlWSPX2FLNHv5mi
         8Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709044048; x=1709648848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kD3E49r73xF3oSKYiHLwdSLYHlLARjZJlqpTBrcFb9U=;
        b=NmeeUAiTwPLoufaZq6hJDrehbvii8O242xPmlwiMEBRM1HTwBy2dhSNZRc6BGxP1lK
         9cQt0Fp9nc5twFvRcyK4Zvfz+wvJvij/lZSB3eUQ7Pzse9ftjd/NkxqPRI8VMvPl7Xr5
         0OCG3k7xwtez4bwSc7NIDQftYN9vNcUEQKI7hbR32MqWcfMy4BzEP0abvS0p6wO4C/3M
         fxSwgCW+ZiQujol2A9g7Iak+2j9twshJkHWhB65Tlkwdv5HYtRkibMSAcBe2QL+VyLg8
         edLGWUUF7ajaIbO21093xaD6HBnAy2JbXZQwGR2qhkyUt6t2SHqdShlwAMbbAOzt8VAF
         Xtfw==
X-Forwarded-Encrypted: i=1; AJvYcCXYTDAs5LH8boXNjS3U6VmqYI73YktqmHTn8x3VP07DHV4+xhIsUqhpkjWx+KYAF/hH+lUOknJ4wJN80lyoRTNRKHEIINm+83/JZWaL
X-Gm-Message-State: AOJu0YwHTy/7cWmMjOFUVI1nM2wDrbrxSv74sb0qIWpa5JpcDWU8/lQ/
	VzSCztLNOIH+o9XuI/jBZnVseVTwiGsDUCUCNnlSkn+zGEfmK6Ky8vy0bLhwF6E=
X-Google-Smtp-Source: AGHT+IH+vbojxEnn+q7wE1Tb1TklvJPquiR1ZswOzPjeIqK3cxgxvqiDg7NnGIz9znnAY9OtFPH/Og==
X-Received: by 2002:a05:6402:448e:b0:566:3d1a:92f with SMTP id er14-20020a056402448e00b005663d1a092fmr1391251edb.16.1709044048533;
        Tue, 27 Feb 2024 06:27:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d550000000b00564c7454bf3sm813689edr.8.2024.02.27.06.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:27:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: x1e80100: correct SWR1 pack mode
Date: Tue, 27 Feb 2024 15:27:23 +0100
Message-Id: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the SWR1 Soundwire controller port block pack mode to match
reference code.  Not sure if this has any impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index c6b025503f4f..be4d2674151a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3430,7 +3430,7 @@ swr1: soundwire@6ad0000 {
 			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0x0f 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
-			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 
-- 
2.34.1


