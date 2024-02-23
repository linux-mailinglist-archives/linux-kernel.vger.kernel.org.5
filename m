Return-Path: <linux-kernel+bounces-79203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA701861EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1805B1C23618
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0214F963;
	Fri, 23 Feb 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pi0TsOEr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8F14EFE0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723326; cv=none; b=E/NwWu71NKlFF3UzBFYnxmruyBmbk+oFP5CqbQeP6F/Ir1TX4pHD+QTBgaGYDPTa1onFuh5xG3H9WVWZ+fdlJGQJQOIZhlkWlfeHNOgPhJnB6yF5afTsvukGwwOG4xpnKYhqPZKE+rnuaUOwF0evx385Kxl2GHBf17dFNIJwfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723326; c=relaxed/simple;
	bh=/vlAxfs5pRi3jedgeW7eSy/wWzvCwowVIaHNbXcWUPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mkw6qf2mmk0DFzoRJA3BXgH+KbDhtwE6609qx4wtfsCfFs+hX2lRiuLIPxjNulSPbvEqQ3/QUF+z5qvX19+CboluQKy3us+YNQubzyH4YlQcZT6HFeu2bUxsZcNY6OMmGTXia/t7U+LkLpF7E7Cbc596UGUIw7/4+yKzMMfM7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pi0TsOEr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso1975092a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723323; x=1709328123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1FkVd0ZOd4HuLhR6rsPDjyD4D3QNLPmtuC+OU6cTVA=;
        b=Pi0TsOErnHXISUgj31PwEukAqrDNBomxahi38SV4kDor6C0K+REWKsTPcjYNdV8GSP
         uEOzz/4amAc0QybviiDDv5rL9+APLj68FXlaVhoafYv7H7FSH/qkdYtD5eQyt9EpTGxt
         afcyfsfcJq4ZgKsLVPMyJ2/zgGGcZsrs7UwFCxqnZQkvtYaL4Re04QVLUcybj0h41ELG
         FSW6CVtauvPTW93rtfNHPpzQ0klfmVpq02QrA6t+pg1Tpo23nFQ1h6taHoKTmjQUs80F
         6XluZN0rXJe6YaK0JsEoePDkXgPp4wOgpMnPbTLlE0cavISD+ScmzVdl9UNLK56jiLXB
         0GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723323; x=1709328123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1FkVd0ZOd4HuLhR6rsPDjyD4D3QNLPmtuC+OU6cTVA=;
        b=dmI16wGzvVkOmgu3pJszelA9pzOyhxQpUodFR59gHPM7h0Ff0J/TIYOd4jO7NzDm7p
         s79a7qjQ/DDl3exUnVo310yeZFfygaax2tcjOKHbvafvp6JxUM4KbPYQljdEj+8RlFMJ
         2yobDBFrOuiPIWXfSK6iL7mGdEC88EowXRR4DdvDO4uhyICAdT9hBdiZMu4Etnn/CHuZ
         ddpJzYhPjbG67rfFkv1H/SoGAlCfrceOSTv863DsETivtDm9qDBIMCXY8pduYmMCUzOT
         l5OZlv2M8wnAyk4DZqDLyganq1jrCEBCBgN9yyBn49V08ZBBIhopzWoaDWFTmacTgbmU
         ejEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYAQhfgmzbZKsYDSGgE9bT0AQrednEFMI+d/dYRTuAs0DwlflracNjF6er5n93bcb4G3KEsCP3xUhndqS+O5QfHC+GPln6ArXIHmWL
X-Gm-Message-State: AOJu0YzEj0SBGNWzc5LWoxyCXO9LEu5Gub4j+eWfYwKlb8lJN8tKsjy6
	o8/dB/dzfHkHNSpkSEfMQl0NKrgygjyiFIoBdCacl+fOR6y83TPI0KH7eYq5HCg=
X-Google-Smtp-Source: AGHT+IGOTeJ72nc86iYe9aCP0RR8+Z6aDoD/m/NIKZ620up7wC2li1nmXfS7jDE9C25SuU9Ep338Kg==
X-Received: by 2002:a17:906:f215:b0:a36:5079:d6cb with SMTP id gt21-20020a170906f21500b00a365079d6cbmr656216ejb.56.1708723322827;
        Fri, 23 Feb 2024 13:22:02 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm4091226ejb.20.2024.02.23.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:22:02 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 23 Feb 2024 22:21:43 +0100
Subject: [PATCH v2 7/7] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v2-7-2d3d6a0db040@linaro.org>
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708723303; l=915;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/vlAxfs5pRi3jedgeW7eSy/wWzvCwowVIaHNbXcWUPw=;
 b=4NlbjUV1GBwZhD/RgzQVAtB0KvTlyLizT1CamJiEGMHqdxMJ9uLicJBWYxiAk+HFlJirPhazp
 Vg14+VV3wZTAdFOGnvbdNKKrCCVqvlFJbUo88fKB1HZyJF7PN0UX4Z8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).

[1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 6e9dd0312adc..c9abca5a7e39 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -199,6 +199,14 @@ &gpi_dma0 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/qcm2290/a702_zap.mbn";
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.43.2


