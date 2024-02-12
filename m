Return-Path: <linux-kernel+bounces-61611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3116851445
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321A5B22DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CC3C495;
	Mon, 12 Feb 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcoCKyix"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E23C468
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743435; cv=none; b=rvDPkclFd/KMdFE5z4Aithw00swIMJKlalqn/khZpOQriOSI0EsaZce37C9G1aGN/V3F3D+AVcouSNPTvI0p+L+Hrfz4QNyZHHlA6M2R9BwYCmanjHF0VCgqCEKkto8jBRz1lEDW1TafOwIyrA0CKMxzMr0RtNN4drm6YlnP9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743435; c=relaxed/simple;
	bh=MgGMsg8PJAMVkpQQ8WXu4KK3GFUd7QqW2NVKRDqIWlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoVNeOOBfgIfFxDZucj+Ca0lLmRQ2+5OwU4jc2vVHTLREm7eNnEzQN+2z0mUPylyQXP/Ye4HHfFpCPk0vYcv+u/UVdQOtf4ADJg1dC4NFDBJdrvmgEhZleuryOv1aPlQv5lnbE6i/HMoIEMYfjXUOcocJHxXAMtWu3Dg6Y7SGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcoCKyix; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so423761766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743432; x=1708348232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoA+yBVNdi1njW3vF3aXzPCABd0kr7iht4u+fgdDNYw=;
        b=fcoCKyixc5VHWurchwY1IOtBycX9lO6b8uBhOqpcwiCdtjLJnjRfDyTeD95qoaTbz/
         cgxBiHlMmI9JWu+OjGh+1b7qc0cQow1YfRqD2eesG7KzhNBOsei5dgYjIPbS6pELTV8G
         QcAmzv/8K6CktBY1VRmjuwh4+7HjKTVMSMs6K5nRQgow0F0ZQ5UsbykAN/VN/epzMJkg
         0JIRitCthVBkQSR4eR4eKAe29ekYzKjre5j5k/zNbVUZRgb8iMIMtqtpZ8nZnWtuvSHA
         0a3N2Gzn0sqMgTUmn2fLlYARZoNgJjJGkyPQcu0VCmZq2GhJa8lq/7kfG4JBALVi9bJs
         0TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743432; x=1708348232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoA+yBVNdi1njW3vF3aXzPCABd0kr7iht4u+fgdDNYw=;
        b=uzK5xX35sig+QLql4zYaknGH2UGiUcCGC2zCw87DEClr85hDAbDxWu4BoyziAxduhY
         FAI5/u7KpntqQIdDqeG0BMTCP/CO/97CtoVvPtoJJDryQ7l+Y/WErTOCycUiKykpQ/yJ
         oDnLJAUgwADFM3P/xl198gJN2+U+KyLzepV0Ng8YRQzBRiZzvFEOsbk7kyloOzKdDNA9
         4MjrofUxOS7m+6Y/4CkKZtL6KHNyWdqcdH+KcyBqZ60VjWtWFzdYXhJlx2mw1GZrYpfZ
         nowbKYbw38APYrj4qEiIEJMpUUEi6+RtP90ImYkgvab/M/pkQKw9wuVWBdwz6lMiYPyX
         WrNw==
X-Gm-Message-State: AOJu0Yxg4wLuC+9h2z/JSpqt5amn/Rdrgm816s2DbNLqgnIOkTVN9vJW
	wXsS7ns+Pa9tKdgizxWnDEt5pagF9cUhwnNVfgd5pmp/MnLeOpfB29K77vS3RcG3YmGk3VNQPf2
	I
X-Google-Smtp-Source: AGHT+IF1L5yNVoQli8PRuWJoFBDUTQ1JqNuxwlnuj7G3XoPbpS0jCyR+DCXueJcfOK/lSlltkTON0A==
X-Received: by 2002:a17:906:b42:b0:a38:984e:2e5a with SMTP id v2-20020a1709060b4200b00a38984e2e5amr4389737ejg.33.1707743432301;
        Mon, 12 Feb 2024 05:10:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLku8sUVcaZo8prr0iSAHJOY+x+SrSpO2++Y8v1BMcWJwS5CMz5Oe0BnKEcb/ySFjHO7S3GcHY+b2TBA3TwzN/0m3wlj6MjLzGx3TdgaQwt64FytU462QI1ADlz0k+aXEDwXskXxrBXm+oMg7e59SGeHS4ObHkmZ+zdWY/ysHKc3NObC0DPJnBkTFEqkxfl6vchytzVStKteVjZGvvwPmQRP+9uKqDcbNLu2JRdy5n6koiZMSLFlecf31B8JzIqKA3HzzoAPFhf/UcBxkACwkkeJWYZTMm7dGEsgiMw5klgkRTSn3OYHmuaSzOnjI7c0TyrRRbOv6X6adizw+GBPHkMm4OouTdJilI9N/I80fvLmXechj0LD0plGi860uBjagoxrpkpnA+4ZIqy1YZCcFxwuoFUzg72hIrnrUTwtuiQq3gUnKIKK57K8UQ4GiiyG3jN8u8SWGLTXR5dfpJre3VC1Ny+d2gl6AjYVexQnMdGz4iQxVbjRxH1+Zjx5Uym2JvmiMmeN+UIO6pIZ+uhw50qnUEBXLrYj4QJaqBqKWFkZFdyTSW5Sy+xRSW27NCa2tXEqDizD7HhXxkz7KRRU45kJQO9IlXAhtFidL+qACjXmCfnw3+4TlWKDPdNzL2cljWkHFC6mEgEOuA+sfM0XbVBMbRZrBDwLqqbaj38Co06E7paGG7aJEnVdGxWf8qjE7OCKyw5hwXWAesQw6CdP1S4P+v9ZrrhvP+Wv3miRAGsdOLPFXq0ii0NpsXEsn8wCvz4JGcOELmPh8ekPnOMd1s7zlSySku8lhraveqNhHBzpoNs2EGnoDQCns2zXU9MIYKoYIZMCN/Ge4OxSAkHd0vnBLb
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 14:10:14 +0100
Subject: [PATCH 6/7] arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-1v-v1-6-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=756;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MgGMsg8PJAMVkpQQ8WXu4KK3GFUd7QqW2NVKRDqIWlU=;
 b=omHcjQyuLjkm+7U15GBNGZL8yj2dbtXdzfMhbPh1XOM6zq40Am+Hcqlnla6o2fLA7Ae+BdUTV
 XcSScpA7kLEBoOeZwRrM+CkmUYtkSr6XbmwfRW86Q1Xy29GfuKwNj77
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In a fairly new development, Qualcomm somehow made the DWC3 block
cache-coherent. Annotate that.

Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 925e56317fb0..e845c8814fb9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3207,6 +3207,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,usb2-lpm-disable;
 				snps,has-lpm-erratum;
 				tx-fifo-resize;
+				dma-coherent;
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.1


