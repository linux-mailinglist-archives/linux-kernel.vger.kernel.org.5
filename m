Return-Path: <linux-kernel+bounces-36956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA883A97D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44A31C21C99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2A6310F;
	Wed, 24 Jan 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfJv5NNq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5360BAC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098743; cv=none; b=WtcUrz6pNcepKw/uThhj/xmNzRq+3dvb+WsJE5UYrQEHkZCKRzZlPx9QkPZ2dAoQoxYqe3ryahOEdWIjMTEYnKiwTzgCd7iCRVfCvYTV6jNZFdBOYbj6Tf/u+oD9w/U92xKpOIzmzCjFu4+rzFGXpjND7otZ7u5emWD4RtkFr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098743; c=relaxed/simple;
	bh=Y3qoJUP7/9l5Q7/HB4lgNbSYXukSY3os/nqfvZZ+iPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTbXCgGHM9RY84QWJfCj534ZG4MI5XYLMhc7hpGLDuvg9ctO5a6/wVUuM0bv2w7uMkebB9ZMZ9Iw9j7Mib4vOPlL9vj769rUqeRYomeokAA4PA5mNN74A/EgUiEv0gExwDLs2hk6S0Y1C5JtEfLeUlZvUbIoofOsHDOtMcs6kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfJv5NNq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so58191966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706098740; x=1706703540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNUo9fmppzhxqCOCweksWJMOKUUrwtvtpbWK33yZ9uo=;
        b=bfJv5NNqB1Fhwo9pCl8ei+TGKTGEbiSLHRTc/sj42H/Qkb1Ie+YHTLLUR/vUr7HMXO
         TNfCXnQ3i9qemPsak9L6/Ketc89NQGac+jxhBTyvzNSiA+OSBsLtg15chi6phm5GZq5C
         ARbLF8KDiF7MgS87fs5zM1T7o5um+tFy+HajvsHKdUbDdkfb4VZAHnljybXx1x9GI/We
         QaYFh8B0RZnxBKjuPO6BtgaLPgADQ6kfX2hJdO3lFcJKeI4X1mtFb3uJNYChmiQ4vjLf
         gFQZHq66dHKUuXdG8FpAhMB+7yhY+hfovCJauERy1GlGsoifBmJY2nF07ymt5Mlt8Yi6
         GZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098740; x=1706703540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNUo9fmppzhxqCOCweksWJMOKUUrwtvtpbWK33yZ9uo=;
        b=PPlk6ppzhldQ3mVNQafN/VwKffzg/uzpwYbM8mkvZ/cE8DIY8pXVf28OHCELfnsLc/
         mOdjW69oGL8C0Lf7Dgo2AtvKo9TnDrJBLzYGZC/bYOWwcFOapi5i7BnUX1gR2ZBPDrgX
         aIRsJqkS/Bdj4QyF7AYK0cz+RLGzsRH4PmNMP74AcKODnMAOV1VxOJQK5oVtOd1G0DKJ
         lfZzs7zDoAccFqg91nV2OX/m59gcF9IGM04VxrXUSX+vmZf+qYby4g+0Qe1s0QoN0AGq
         W8PuFA+YAXpcJnmZ2gEw8u+SPITt0/ZA1J8iOKzR0W5DKzt407WcAUr67/Zyl0M3CtQA
         OJQw==
X-Gm-Message-State: AOJu0YxE4LVQ58IQptWfMwKgTOi2ZtEx1CU/Du28GdJrlBuragkBbgyo
	7BbcjYtE7q9GvjEHnDfR0swxIS6wJI06u2Q1edXTTwXOsL6CctIdaxfo5hSNWow=
X-Google-Smtp-Source: AGHT+IGutv6smOAh1NvhP1U3c/lfJJ63Zxfnv2IpC+XBS2mcIy2gWO/d5LHR/Cnf8MIDha7DdfijTw==
X-Received: by 2002:a17:906:5919:b0:a30:cdf2:376c with SMTP id h25-20020a170906591900b00a30cdf2376cmr734189ejq.55.1706098740259;
        Wed, 24 Jan 2024 04:19:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id k16-20020a170906129000b00a274f3396a0sm15582415ejb.145.2024.01.24.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:18:59 -0800 (PST)
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
Subject: [PATCH] arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones
Date: Wed, 24 Jan 2024 13:18:55 +0100
Message-Id: <20240124121855.162730-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to lack of documentation the AMIC4 and AMIC5 analogue microphones
were never actually working, so the audio routing for them was added
hoping it is correct.  It turned out not correct - their routing should
point to SWR_INPUT0 (so audio mixer TX SMIC MUX0 = SWR_MIC0) and
SWR_INPUT1 (so audio mixer TX SMIC MUX0 = SWR_MIC1), respectively.  With
proper mixer settings and fixed LPASS TX macr codec TX SMIC MUXn
widgets, this makes all microphones working on HDK8450.

Cc: <stable@vger.kernel.org>
Fixes: f20cf2bc3f77 ("arm64: dts: qcom: sm8450-hdk: add other analogue microphones")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 03fad2e698af..ce398927beb9 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -931,8 +931,8 @@ &sound {
 			"TX DMIC3", "MIC BIAS1",
 			"TX SWR_INPUT0", "ADC1_OUTPUT",
 			"TX SWR_INPUT1", "ADC2_OUTPUT",
-			"TX SWR_INPUT2", "ADC3_OUTPUT",
-			"TX SWR_INPUT3", "ADC4_OUTPUT";
+			"TX SWR_INPUT0", "ADC3_OUTPUT",
+			"TX SWR_INPUT1", "ADC4_OUTPUT";
 
 	wcd-playback-dai-link {
 		link-name = "WCD Playback";
-- 
2.34.1


