Return-Path: <linux-kernel+bounces-81064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA1866FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C601F26B81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482295B5AB;
	Mon, 26 Feb 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Lwlc1n"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35411EF1C;
	Mon, 26 Feb 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940273; cv=none; b=nZMUU2vFMjYMnjix9pRqCBZaOaAnRjejzlRAQqbx+28aAHbA7PdGx/+G5tp0wTSoFxBpwBlf0HbE2gfjDmALW8oWh/GOjmulTbnI7whUmE+pUmCkIZhkqcdUcxIMx9DUo2x2mBKCLMXMIG5DbrTHlxb86vySJJNtxQxScXbM4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940273; c=relaxed/simple;
	bh=+M/IcrkC4KiqVSgKEfF4MEPWWH07B+P/vlCcnh7YeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgPyfyTUrf4PDlUtoR/y2lJ1K05SZX9xPjyrTV6dLDgQabvjKgPB+uA4saiPJa6itwXB+ABRg5vttBeBN7jRinTEMUcNkb4UgaCZdyrkn+B7hV1+vZUrSzz1AGb6VGDR5LYF0rNwF+8sNcg60OXAGgA4MzT0IjuBoqZB3jssJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Lwlc1n; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2720838a12.3;
        Mon, 26 Feb 2024 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940270; x=1709545070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=f1Lwlc1nJ23KoFpVKfKTBefiJxDqBhxJLy3yztn2bHXbQcz6AA4Lr1/8EZykTn8d51
         omSe/nkP4SAUj+5q+0EnKHOnkM1FUk19dWnm+SANNb2gnOPuD1uWgFlmIvB+zhu5yCwC
         VaR/IBca1owsr15UV9uNZr9XH66ZcDb3vedWfYhuSV/nFSfsBfazgXtFpwJGVw+ts4ZH
         MplEZyDDHsic35Yi4NILEi1nW8bFWi8WogbKs/1l/juLmYc4Oz2cbn6jelf1TNE7Fhk5
         vXgLdLe5vQJq3GL340H5h7FqVvFOYKFacyk94U/X0C6qtwjxfWhQIvgTHLU1fNJadfEy
         ZlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940270; x=1709545070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=JliV5GyzGuinQbX3clhgUl5ToQ2M0N/C3GFkUJy2eaD2h6uEHLx01izaOni/8YfbMj
         Xh95eO8n/yygbk+wxz+7qhYBkLPJH9TBxScICrTr4bh4ewI1rXZwlAFl+efoxe+BSL8V
         jLqWloJflqoinHsqCFcbd+24sFXiXHFJIEfDuIQJNcBTl/3wi6BaHnwcIIAiCXgFNZlh
         tFCjA5Gn6epNB1X+1xHrkTQepHkNJLW14gaukMnPu9yedumasx/7uVLpl6YFl1EH7FBv
         j+P/eB3KS8P+yA6E6YNE+YVGTsqNvFjUWuLs4EA9U1Ungo5PLvUQd6VzirtPvlDGgdyD
         /+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUwv7JZPP5xu+QXwIGte+Gi0cR3qI5GJDRtPuveomu2PPfJ9CDlV5S8EUduJRiz3Edp5MUa7XI1688Qtbbntra2UVsN/hOCoYvq764wpGRR5Gro3IMCd7pHlnaD+7XXNo9zrVXl+V0MjpujxWqfVFCIgqC+cRuk3uoXnpBe7fXHzuoBVZ/xHdgyHzstZiC2u0UHbeomFv3XISMlOrdhKcs5Er9+
X-Gm-Message-State: AOJu0YzObl3bpeVFUMDjtCFQfUudij0I+iSs9EDzuxEk7hTaCuDrTb1D
	aNW2hRimsJWw3w5voLLsdreg8mjCWNAXUut5Vsfn8fPWeP+UJ/Jv
X-Google-Smtp-Source: AGHT+IFpjaJu2T4JoRmMtw8TqqMu8ND9Hg9Vv19TGQBE+b1X9rROjlzEQ5fx+rLOm05RPrsgBI8FWQ==
X-Received: by 2002:aa7:d9c8:0:b0:565:ebf3:e28a with SMTP id v8-20020aa7d9c8000000b00565ebf3e28amr1603276eds.31.1708940270082;
        Mon, 26 Feb 2024 01:37:50 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id fd13-20020a056402388d00b00562d908daf4sm2158595edb.84.2024.02.26.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:37:49 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v2 1/3] leds: qcom-lpg: Add support for PMI8950 PWM
Date: Mon, 26 Feb 2024 10:37:30 +0100
Message-ID: <20240226093732.3478845-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMI8950 PMIC contains 1 PWM channel

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 6bdc5b923f98..9467c796bd04 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1693,6 +1693,13 @@ static const struct lpg_data pm8941_lpg_data = {
 	},
 };
 
+static const struct lpg_data pmi8950_pwm_data = {
+	.num_channels = 1,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb000 },
+	},
+};
+
 static const struct lpg_data pm8994_lpg_data = {
 	.lut_base = 0xb000,
 	.lut_size = 64,
@@ -1819,6 +1826,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
 	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
 	{ .compatible = "qcom,pmi632-lpg", .data = &pmi632_lpg_data },
+	{ .compatible = "qcom,pmi8950-pwm", .data = &pmi8950_pwm_data },
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },
-- 
2.44.0


