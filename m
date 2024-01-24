Return-Path: <linux-kernel+bounces-37352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F272183AEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C16B22FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF77F7CF;
	Wed, 24 Jan 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtmEOujY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9D7CF1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114715; cv=none; b=H+aQjGyC/b3ZfM5xbwKwR7I0az3XYoDD5M40KwK+32rV+9XeFpT2rD8OtPSeYMa/vM9wR3ZL6dazNRxSzyujVIRWnd7FiP4HouMBxf0AjnQuelC8BK9brIrmKvEQiRCHMEIhyZhuxjPN8Yo/cgllYVF9HlZi8gU2zI/lKRU1qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114715; c=relaxed/simple;
	bh=jpcsDAXA1KZo6FHeypWnR2nrsXwXdx1uTU+szPAsXns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rzp6+7scE6lL2IOXL+lcCx8ZKoEDJ1yCZDHpS3R6/bvrOFDo3XN9oJzfS8tf5KYmCu7/3J0Cm8Rpy+9Nu8Jupwkt31rYj5dpHgAVh3YlmxraQmcOwWZjUnUGpMbPnzPXWHglPJUjjCw+yC7Ni3ftbIPnxSUprVpeVz0XqiaZNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RtmEOujY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394ca0c874so862967f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706114712; x=1706719512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma1QQhK11zUQI9f4hz2k25EV0GtpYeqsCa+/7KAoKQo=;
        b=RtmEOujY5veOsJjr1Ih8ThLDzgb78MykZozR/w5AePWJQO8ThlitYILjYCzS+iWfZz
         MDCysTjBbTCCNg7xxNAuXKcFUYcFYMyVDxy86xnKbWW5CuplnS20wdWnTfTLvpM5Y7uB
         qoccCgst41jZK1PspCzAVeYFz4gJ8cuaTxcwD83bCHFbZ+04O7dmaMoMTRr38VQ8ZT+D
         NAPzElpCy8vopzMWVLmhzOHqqcBN9o3nnjqZxar7WaFLFxsroK2sbUVBvXQ4y3BBaEEI
         z8xCYkYKTo06oewVDIT4hmyJ9/RfAmQcA/6mmRAKKUqm0XPMrqh5eUAtPFdVlffcGc3Y
         A2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114712; x=1706719512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma1QQhK11zUQI9f4hz2k25EV0GtpYeqsCa+/7KAoKQo=;
        b=oghAqx90d9KzZ0DgLvlSqMcRAtH2jR+ox+zBH6SvHI//9TmOchTfiepZfv5oqMnz7y
         5dK2rZtD0JZA5k484xFAAfsfZjjcUkvQGpzNv02gTPsHp5abEeRUtk5LsYn4n1eUYKAT
         sCpdCud8q9xFhrQQxz/UzTcDlQ0WESpLaLAJ/YxEJQkoM+kswmQCoLSTLznTg9Xmvd/9
         44jjES+uhZCM0gagPOkJyvuONGuQvd844tHHrlhp5IZQ8yT8QJekWff1jpTO9RdcbdEy
         uDYnJW8WNStKDntXqL9+Gg5Ij4f8uuHUQyp2fkInFSOwOkeVgTPrFRchJ30/lItRUbiv
         hafg==
X-Gm-Message-State: AOJu0Yx5f36lOf/E2oCojVNC0UNqFmpdiuoFmyt67ybnX0JxV9GEuilH
	rDeICXhqTbKJdEpNYPdR8QoZ4/AeNjFAo7eso1ogxxdSRSf37+0jBcqkaY8ci0M=
X-Google-Smtp-Source: AGHT+IGzDIEpUxydzHRjypRSAxJj3nt4qh5Z5VHhh07APhW85LKtlspdKIerOdWzYvhVVp/mhxw6eg==
X-Received: by 2002:adf:e2ce:0:b0:339:2db3:f4e9 with SMTP id d14-20020adfe2ce000000b003392db3f4e9mr770103wrj.32.1706114712445;
        Wed, 24 Jan 2024 08:45:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0033936c34713sm8137883wrd.78.2024.01.24.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:45:12 -0800 (PST)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550-mtp: add correct analogue microphones
Date: Wed, 24 Jan 2024 17:45:05 +0100
Message-Id: <20240124164505.293202-4-krzysztof.kozlowski@linaro.org>
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

Add proper audio routes for onboard analogue microphones AMIC[1345] -
MIC biases and route from TX macro codec to WCD9385 audio codec.

This should bring AMIC1, AMIC2 (headphones), AMIC3, AMIC4 and AMIC5
onboard microphones to work, although was not tested on the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 393702fe61aa..0c94edb8b824 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -105,14 +105,21 @@ sound {
 				"SpkrRight IN", "WSA_SPK2 OUT",
 				"IN1_HPHL", "HPHL_OUT",
 				"IN2_HPHR", "HPHR_OUT",
+				"AMIC1", "MIC BIAS1",
 				"AMIC2", "MIC BIAS2",
+				"AMIC3", "MIC BIAS3",
+				"AMIC4", "MIC BIAS3",
+				"AMIC5", "MIC BIAS4",
 				"VA DMIC0", "MIC BIAS1",
 				"VA DMIC1", "MIC BIAS1",
 				"VA DMIC2", "MIC BIAS3",
 				"TX DMIC0", "MIC BIAS1",
 				"TX DMIC1", "MIC BIAS2",
 				"TX DMIC2", "MIC BIAS3",
-				"TX SWR_ADC1", "ADC2_OUTPUT";
+				"TX SWR_INPUT0", "ADC1_OUTPUT",
+				"TX SWR_INPUT1", "ADC2_OUTPUT",
+				"TX SWR_INPUT0", "ADC3_OUTPUT",
+				"TX SWR_INPUT1", "ADC4_OUTPUT";
 
 		wcd-playback-dai-link {
 			link-name = "WCD Playback";
-- 
2.34.1


