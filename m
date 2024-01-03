Return-Path: <linux-kernel+bounces-15600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BB1822EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33C62829E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F11CAA8;
	Wed,  3 Jan 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNkVVTy1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76D1C6A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5563944b3dfso2831036a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289034; x=1704893834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=jNkVVTy1pUwC5PLcjMZiLZUHNzvQywrH7bnD9/M8amUDELvjcMRgU/K7WTw+SoI/PD
         aMnrLWaJeUa3GLaYHZ+djilhpfU9L7UZ9gEE426bcU7AbXfVqxIBQoeuHJ1FJkJBtWVK
         euRE5xhhvW+lqetv/+7H/5ku8Gh4F+7u8AD51QdbLVofpCB+GmwDce0j/weymYsfolqO
         YrL1aSfQn5BjgPkcq8Wj0gQu1VHaYTvD81zH21XsM/0I4F69okJGHmgihvlIjx9Rfjrf
         zx5VfW9VhXZ7iGFLm5L0WuAV3aiVddnDfuYScVr6dKH99ir8EA6rHuFU+NBAj14ZHfZT
         uDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289034; x=1704893834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=gKlxsFhtWBWObakmzCWc3ljgYvNw47s+z6E/g/r9qjwaMbV9xTPJXsOXeH2MXxHljU
         HEJzyf2j+ARimCLYHPrLdSsoym8+AIUkuAhcKkrCSu/dwKcuXcKwTFbx4oCCqmRKzZ3w
         qkw8qCWomy/1OGHs7/Tz0Gt10e0Qej7puVQC4wxru9GcgFYgZgr5TnVPElMlS1aYIpXC
         GO5maJLQZOGiwsol4H+Y9daup/XeT2/KsdXTG0PKWPxiMCDIjzWxQwPXNeImDJcGfdC7
         m6cxEDeMhSklgIOrfzAWjXSEtk4lvX+WvjTzvr6iXucpL48LwgMsM04wqB1js4vO4qDv
         lqqA==
X-Gm-Message-State: AOJu0YwI6W5pPwsfNXPa7fby0yjItO3q7ZsBwLF9H2w3Wh4QsuX37QkR
	iDON9/S1uIjWQIyzW0Xo1wTkuJmJ1Uls2g==
X-Google-Smtp-Source: AGHT+IFDazcmCrVYp6lQ2rvk/GUbOsFxa3D/rgZo7aLaPmsY9V0zaFzS2s/uI6Ck/R39fHgXfhyl3w==
X-Received: by 2002:a17:906:7387:b0:a28:27cd:c1d5 with SMTP id f7-20020a170906738700b00a2827cdc1d5mr1690688ejl.105.1704289034705;
        Wed, 03 Jan 2024 05:37:14 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:37:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 14:36:08 +0100
Subject: [PATCH v5 10/12] arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v5-10-99942e6bf1ba@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=764;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HEE3DdJ4zQzS/Foajh/2RBi9l8ssp2UwDgoH6XqPOSE=;
 b=zKPKX5XuwjH/UsyKzKynP4dN/j/mBdLyAXFRp+ZALR0r+r5bhyiMry3AvpjFCM/4utcE9udMs
 xxbMuFAyatRDG2UYQpDbnRkxBxE8ZqW5sazcwqE5tI4vhVtrUN38nkk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GCC block is mainly powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0911fb08ed63..51b05019ee25 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -647,6 +647,7 @@ gcc: clock-controller@1400000 {
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "sleep_clk";
+			power-domains = <&rpmpd QCM2290_VDDCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


