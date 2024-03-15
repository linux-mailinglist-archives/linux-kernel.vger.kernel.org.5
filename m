Return-Path: <linux-kernel+bounces-104082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627CC87C8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F27D2819A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723514F62;
	Fri, 15 Mar 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcumdBAX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB714AA8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482852; cv=none; b=ok4Wdp+07oGTN07idw9/g82yJRcCnSZnsZEXIOBEaOcFyxMb/c/bVQm2I2/fS7N7jZYtQS7XkB/NbaJPDTgx70fWSIqhNTXWGPnL72RS9aU82VuchENEhil05AreeS9a1qLdBFH53HWGDc0Txt32nwANTWKFEqGc1K+aKMqGCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482852; c=relaxed/simple;
	bh=QbcBc4JXtP8FNrsiFhXtIJGTYDJA6oPqiQ8+qe0RZWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmK0I2S1DQ8JoACx5IHBfI7YihZDVyclc/vyjklhVbD93FfOLcw7/biUgp08SxA/eAPlcVYZE1D+uNW0QvlPZGFNeUBEa5sHZ/daj+MybtkB0X//5eEoD0hVeC71uxf9e9G2jqWr49cLdDza6xM54L7bAvC4f/OAup0Te5QqBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcumdBAX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dedb92e540so10040815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710482851; x=1711087651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=kcumdBAXVMEzL3E601050uPR6yJJOGcscR29onNFO0BPz8mAHg9JIFOmW4MD1lyTkM
         VOElPlt/LUkuz3dkrwBrkZ7ylFnsxAvtKB27/EtA0JtnmnOGN9lFrXobt605JBXUcmhr
         m7slq94cN4xMr3jm8AZI0N1P1oh5il7FVRKUlTDZjY8647WHhAxAuLQXP7ZLatdRLquV
         479ejolLY67SN3trItWIz5saihRnxotYGsQqxMyXlJCKhMGo5rj6zA8cx1EVfOQc+jge
         OZVGGD63uZ91GceVLso0F/NXfIL94f5hJ6IsWJsCiaeYE6cgxJLQlKQB44KrwiSGeasx
         LJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710482851; x=1711087651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=LEsZmAFIA5CIVQq8q3XbJHHCiuBIlDBUZqB9wmYA42BcaUy/dECm29sqjLdgpgbUWz
         2IETLJqZw2jay+n3roxbtnamWkneVfjcu7Tb5ePnNlzVbaXXvugamdW7EhCoCjG5xq0H
         4SZGafiqaqbGauuLne5S+M4gY00XqQfLdXUao4At2KuAc2hJQFDYUCTNjnlRnlzxKOtk
         viaegxvFj3nbFWia8O+ZIvuC9VBm3UcCUo1J+zq/KAYwHg4IYBKUszd2QzVKZM7YaYcI
         MpBVCXGmuiqiGL3FnquCOReSUbAfHqf8P75D8uzxYPxZg/1XZ3IWBrV+qOA8Hu81MeI8
         JrXg==
X-Forwarded-Encrypted: i=1; AJvYcCVmSNVBOew7L8xxODkhvloTTPPmW50ZNnIm4E4xniMHmuacktxqun+aLAy48BCtrJNWSc69wETiQzOfIRsAO28GRAiq6X+NtSIo60gq
X-Gm-Message-State: AOJu0YwNn8IOjCo549R+TY7Z/31WH7XHGKyVHgE7mGsm+a75KdU+zaIV
	z/yjMcP/YdJW+5Bt7XriejZOCM/vZmg0TbeQeKNe76MJh0ss6C3IHW+917GVIjI=
X-Google-Smtp-Source: AGHT+IEm3EmfV9isBbKMpEwODr5FLa9Dnuhgk8Uq2x3rU1u1qfup+Nm/Vo+JetWwc0EMG2u23zlWmQ==
X-Received: by 2002:a17:902:a518:b0:1dc:b323:6f97 with SMTP id s24-20020a170902a51800b001dcb3236f97mr9175623plq.27.1710482850735;
        Thu, 14 Mar 2024 23:07:30 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.73])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170902fb4b00b001dccaafe249sm2852024plb.220.2024.03.14.23.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:07:30 -0700 (PDT)
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
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
Date: Fri, 15 Mar 2024 11:37:06 +0530
Message-Id: <20240315060707.471248-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315060707.471248-1-sumit.garg@linaro.org>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the Schneider Electric HMIBSC IIoT edge box
core board based on the Qualcomm APQ8016E SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..c8c91754fe04 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8016-sbc
+              - schneider,apq8016-hmibsc
           - const: qcom,apq8016
 
       - items:
-- 
2.34.1


