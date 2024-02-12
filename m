Return-Path: <linux-kernel+bounces-62092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D1851B50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B511F214EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21540BEA;
	Mon, 12 Feb 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwGMujkn"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B623FB07
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758627; cv=none; b=HzSoS/fgj+CJJy0aN/OAKc0riSUQI2fI5AaL9jAbu93+9+eiRawXsKv5epD9ljzpIHgMz3DRJY3lufC/PPVOlKzAOt7Qvm8n8MmYesE77u5hxeAfvvWTvnsORGFZIdyxPQ/FUxpv9d6peC4kCekFNRCmEq60CS3U7sO6jEGxUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758627; c=relaxed/simple;
	bh=y5v/GKRCDOtq0Cq7pd0as4nEJcazLe3h8zQVOd2huF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZAYMCaekFHhMv2tLLEu5KxgpoWlcxk5Po0HXW2O4+f+r+bsQEwT1EWQvmwngFD3G9ai9hwtce7l2ul3UxnH4mOHPQyyUUCPCk2jGBXtlUmp7Q2JqC4zRaRCocf/eGhDmOhWp0iYP09DZy7urSc40vlnRyauJR7g3/uwLQzyCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwGMujkn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso1466882e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758624; x=1708363424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edPAwyx6FoUzQLz6DUqB8wXwXw3VXUqF9Lsag+seSSI=;
        b=LwGMujknKmVpmql8GZqBm61TFP2JmTRObJmmhafJnnXyjLVfXhwELoakbJhTUQxsl+
         3V3YCVUUeCunghKsMmi31+J8EPj76xpS4fekMlZ9uaypBej+izOZKct7q1WK0fSJ9akZ
         niJjEpnK3e9uT3rLN0AXx53MfdGJOwkZYLir+0+T4kquxXAmPmu7wx1i9LKBdCs3eZXN
         ja7GCV21H/HT+GAT6Eb9sLAiTVyPvqKpcdtzO5oGkU6KlpYGU/ip8sCLkCfe8D9B6b4Q
         gbM178Wnu5XsBg0vg7T0UZWrPjowNmjzqA2Y9wOX3eqD3dNXv/YKi5ViemK4ulcgsyQe
         eXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758624; x=1708363424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edPAwyx6FoUzQLz6DUqB8wXwXw3VXUqF9Lsag+seSSI=;
        b=LA8V3tfZhTmgF5kHEoimd2QQ6Iu1nuiF9PfBh0UaHe2bMAVxhjP/IQ3g+uYwDmC5Rl
         YTTo3pxn9jXIvjQO7l1k5Wr+lUAZ3rYdJJrwsq0D2XHz78CAsBTiP/pV+e1lkfqWGGNe
         Bi0QsLHD174c+Yvk5yOQcuC8zGDOdxHx63nfk8GySZK9lTwV4PkvIDuqILpiGY/fRIIS
         lYGz3pcjWW/OBnF9U1rhIb4oBmgWUIqZnOzWDMcgzATH5xgnPswPhXPShE4ANPJRx4Tj
         ohiHRyVh05hsWX4Wr+T5p8AATa7SH/uhZp30McrJOgPEOsYOsy/NM/dhayFDoT6yo9gY
         SZIQ==
X-Gm-Message-State: AOJu0YxxqLHR+/YG+gNcVJjvPad636CyAIGB7zW4RMohMGPQe7mzyx48
	MfZagEDVGJj7EojG+bPZKuhNRCQ2NEf5JtKB2ZylNVBdRuFgsuERNj2t4PFVVCw=
X-Google-Smtp-Source: AGHT+IFLWaPQ4RyK08FxgGLyqhlcfY8q2KEDh5YUUzAJ1CWTfElZsL29uVRtcKvEIE+3+eaWuPENhA==
X-Received: by 2002:a05:6512:4892:b0:511:8cd7:e017 with SMTP id eq18-20020a056512489200b005118cd7e017mr2529367lfb.22.1707758623725;
        Mon, 12 Feb 2024 09:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgUSu6CMUVLubv89M2Q1F+0q62fsg4eMi90TSRlNR7pwwWWo5DnhlbGXnB8AsJCvBjEJuKTGLbeOpG/U1ZbqC2irftGpgPgPtmOdo7Nm77Bp46tzSRCLayj5GpVJsNOdRyvELhStXr0ypH6jAJ4ofClAABqCkbuazihmaGjy05wakNuicZ04pHrGZiDq6pEW0aCxoh/NBIIrOn92HFNF1Iy0LD+QoMD8hUjTRdb9fxGs6zjPkx1oMehJ5CVoi9GtO07jmq1UETxXSn
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00411a595d56bsm954051wms.14.2024.02.12.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:23:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] arm64: dts: x1e80100: correct DMIC2 and DMIC3 pin config node names
Date: Mon, 12 Feb 2024 18:23:35 +0100
Message-Id: <20240212172335.124845-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
References: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index c90c32f082d3..71cdc45db667 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3483,7 +3483,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.34.1


