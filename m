Return-Path: <linux-kernel+bounces-37350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1583AE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A613281CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C187E584;
	Wed, 24 Jan 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIdTJ0Qh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE037E566
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114713; cv=none; b=AjmscEafC2+OABgDq8oTrOpUCXsrxyr/jF6skgbmpMI0JFa3DK5VVmrqd+giyxunoLb+CAPdEziGZ4wkj4UvYCH8aimwWnB4SQg0C/G2XW6hL5DdTNeo0HAK7MosOAIvji1OYCq/vx35WkPnrT7+Xmh/nvSf2pDIErY9VKyikB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114713; c=relaxed/simple;
	bh=E+aaTHP1EQCGKPF4sY/gl8ZHttpb6ZuIBiAWmRwhXeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzsFFjNY3zQjBF6+UG4TImNP0v+RREddhT2dRR0gzcDrVrcXDyWR0WoQLDf+Km3TIT2W5a6sE6YVEKnRbQsFMHE4QAqCbHlPkdvReX/U65AInujsn4tt/BOT3M15esqXU1Rex2YIYr/c5Fzv+9M2ovv31+dPQ5KKFDX0J13gf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIdTJ0Qh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-338aca547d9so4544226f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706114710; x=1706719510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hzo6WKveS1liHas2hVtDlxK0UP0Owk1EJiEVtLHIxQM=;
        b=MIdTJ0QhqGFFs/j6z/f4IjPKdkK5+riRNX6VW34BEKHbhu16cR0Ytki9EdmFsrWQvB
         13iMGtyLXhtJG88nM5KuBMAIofZ1MqkYUZiRJbZEzNFzwUpLRdJSDO3G4gpw9TFRjdHK
         NLPGCnA4O49iSzF7bLb5RWRPTPvbGdwzAZ16EOPVC53TIoYo73dafrNSzNqM3FFD5OLq
         PaMmZ2A5FwUO/pkpJ60fzzfj+hILNQ40+fu36PyKAeMpYCd1F6Rey20/gHxkuFdh3q4s
         +ibSKqEhU6QxciOJxiPC4KGkZlc2PaR8zZhF6/GbRWlNVQELdCBGzoW8266uRA9tYiC3
         4NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114710; x=1706719510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hzo6WKveS1liHas2hVtDlxK0UP0Owk1EJiEVtLHIxQM=;
        b=NE39woavT+g+5O0mwESe0d+Ln16/+rOa6yw62YCfj12AEzE6wHGBMJSxEWHWoyFWYf
         oxv1mOvX15RBY8U177XktwNcjw/PNXjMHXxleIV7pP9pPBY90c6fpNjeYYU9r2BR2aM7
         Qqi8mtCFXhgPBtXKeyfp0+bmC0GmdIDYBUE0s7R4CgPChpx0xZeoyp92lLW8iSP3VHPK
         TQEASw6GVsNPW6HL8cSZGHdd3h5LSexVz6Azej1sm0bALwxld/L4ECS+jrWELq2Mvy1E
         SO6rR+4e9UR+VURe/pB2Wnf/w9Qr7qQxG8EQpMhzlUT4VoeC5y+80xBeOy/sIwcilqfP
         i53g==
X-Gm-Message-State: AOJu0Yyc1HhQxMYZ/sk3s/jqxg0BoQYCBV8SdOS/m8l1gcgSXvXqK1BO
	jxQ9FVxmDMgts6Hd6j5wmfQfji3nHeW5RHKuepc3eUs8dhplJn1ibmWRL0YydfM=
X-Google-Smtp-Source: AGHT+IHCfYchFFMkHPuuY3FNlwCEIH4fu0jwnyNx1EwWK5404gkqqdtj7YrMjpNHa1C7fcJEfLIh1A==
X-Received: by 2002:a05:6000:1c3:b0:337:b9bf:762 with SMTP id t3-20020a05600001c300b00337b9bf0762mr368556wrx.240.1706114709904;
        Wed, 24 Jan 2024 08:45:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0033936c34713sm8137883wrd.78.2024.01.24.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:45:09 -0800 (PST)
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
Subject: [PATCH 2/4] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping
Date: Wed, 24 Jan 2024 17:45:03 +0100
Message-Id: <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
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

The change is based on QRD8550 and should be correct here as well, but
was not tested on MTP8550.

Cc: <stable@vger.kernel.org>
Fixes: a541667c86a9 ("arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index c2847fd3c209..393702fe61aa 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -745,7 +745,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
-- 
2.34.1


