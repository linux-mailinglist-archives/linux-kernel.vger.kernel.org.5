Return-Path: <linux-kernel+bounces-25309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41582CD48
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E2E284090
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517418E25;
	Sat, 13 Jan 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBic1Hpy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380B18AFA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so85260715e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705157475; x=1705762275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm7vsf6UZKbMh6cnZmrwv/W/K4dUYmjWU07UgTkkSLk=;
        b=sBic1HpyIgN2on8PLFxEjUGNl693vFoM0TIBCvuoLdhpqD1vRyp60GI0iW8awk1a45
         RFhVwL1hRvwsY6ROvesmSvvlG37BxBJSri/NqBuLvWOPMsPDr6MIcG2U9rEp/3LO6cLJ
         buuIaxBJLWthGY+3lyK4Ex+knfQMs/R4LYADDLJKdMh6h8rjUVgNjdpfWLrjkmFusy38
         6/z+lQ6pjj6LOOy99vm2E/iMehfNoGx+9+FuhP6HEFvZ7+Excgu7lz7ZgeuC0IA9Xbq/
         Z/YRAgN8Ix1jixp6MGqBhS6wwR/w6oLfNJl1ypFQF1BskIf7rzeh1WEkyQAl1K5HCpKd
         XU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705157475; x=1705762275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm7vsf6UZKbMh6cnZmrwv/W/K4dUYmjWU07UgTkkSLk=;
        b=vjvE/wHT4REbOxsajsNo+BjoaBg6NFj8BF20D7r7ax4OIX7C1L31nci4uTeM72tqJb
         OY6LQZwZkONYxUGzu/B2Y04jrsm4f8DflGY+DGYUcwRyHmGOuT887BruyKqvh0NgSe2s
         a49wLi2FW6GcFAaPzu9wAcN/HrVoDH/4qeXr4QqGNz6JLNvmr6ELYwixYo3XlHPDQylx
         3reNxYWutZ1zMFgfbIIgZi8Yn+WgjaDU7yv5BB9rxg/H+JKO5uWkA1ZnLN7RC2orOde8
         qZpgJEgCEHcmz4u31heZBCuUmBGpzCdStknkmjc8I23HnKm0q8XkkhG2eul/tMvUO1GJ
         GEqw==
X-Gm-Message-State: AOJu0Ywwjfb4sHD17EhF+8LudFC0yA4JmApotZc6GEehCRnSxJdNPrUF
	+HPp8+yTh+UiMwS4kMIfZ6QGqJanGSkC3+WFDigMUYAtMZU=
X-Google-Smtp-Source: AGHT+IEpYOKZRZpChUhrhMpu7k911R5aockRo+r3s32gqMdG3CL5hFueLl6AcHkaWl7ldfH53yo8Gg==
X-Received: by 2002:a05:600c:d7:b0:40e:498d:91d2 with SMTP id u23-20020a05600c00d700b0040e498d91d2mr1079390wmm.185.1705157475077;
        Sat, 13 Jan 2024 06:51:15 -0800 (PST)
Received: from [10.167.154.1] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm3014593edb.27.2024.01.13.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:51:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 13 Jan 2024 15:51:00 +0100
Subject: [PATCH v6 11/12] arm64: dts: qcom: sm6115: Add VDD_CX to GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v6-11-46d136a4e8d0@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705157455; l=758;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=L7WLthXykOxwSCjhfTNvX8JtR2g4GIz2oFPri6fp1uU=;
 b=9YnjNkc73g4vw24D5TH8RrweyjC2rmeKm7e9SMxa7AqPeFTKrpGm8fAIS9P64amRdSDVudf7u
 1oGH3d7+FqNDstnBsI+NnOZTiFKLsgSO4xOlIp2+9oWTHfBysBCBHqg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GCC block is mainly powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 160e098f1075..30b140e1cec0 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -807,6 +807,7 @@ gcc: clock-controller@1400000 {
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "sleep_clk";
+			power-domains = <&rpmpd SM6115_VDDCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


