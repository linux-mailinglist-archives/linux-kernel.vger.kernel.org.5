Return-Path: <linux-kernel+bounces-6184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A481958D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833CCB24B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570E42030C;
	Wed, 20 Dec 2023 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTCXYW+0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF31DFF5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso5746551a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703032278; x=1703637078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=iTCXYW+0i4eAV4hQMqN8RjcSA8GqX456kr4QuNfj5Nw+u64ZpB7AcmrxkttHTjOF47
         2foLCdke94OoieAbCN2kfMrpj0QE2xpwe9iGTS1jZrQzVRaDXKQTMqxgy6KqRuhJfz8+
         mQBDGG65XvpXcDwe4LEdcx4J2CXab8LOTLS11Zj0ugqAnTHSKMilFzSeF2hFl9eEkemV
         IFpgO/RJ/T5/JEhkaypQ6hwAXqqhRgVvHcJjWWwZp9/NxtEay1M6L5BIgwwExaZhQ+uy
         WIthHiIHJHtnvyvmbG6RoputmEXyQ5XidEBdYVkSl9S8IyYvjW58JG9h6fGHB+cl2gy1
         Tw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032278; x=1703637078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=JxauC9q7uq8tq5w2qsvop4BdP8qqVtl5iDOiUzPW5POSeuK9hC8tQjt0Pl9nEB+pyX
         CB5O8q+Evnps6G3FNj+pFNTTb4x0vdBXvCtCq6pJyjSuireJmTugJU5HVX3h8+/RTmzo
         N9T7fyOtmKUsX/TfYoSCq3U2vi8/w6+Jr6OeN/ljCKCl1DExlshF4DbT8VlngoYXfAHM
         oMc8FvKitFXNaIzq+6IAiGKpbqugJZiQ37/Xw5AJa1hw9FIbT4D05x0B6QQinX3+aVwn
         2oHC/3L2aiWbpKkjZN3/E/QxyDQxQXEnor3GLBMWut8rN79mM5IvzzXJICYU1JjB2xeJ
         BO5g==
X-Gm-Message-State: AOJu0YySLr+RAoWXHGjvwq3gVQ+eVRAJAh4krlqoTxX2ENuS5xAcXxX0
	GAG6SrwLMLCSN3FONq8G82gUjQ==
X-Google-Smtp-Source: AGHT+IEmuz6Jt47mOpGlL7PwmZ/AhNLJg02iU0S77yqRmiMtDbwYEZOAMDfRbZOWgyDb5ZaZXE2ogg==
X-Received: by 2002:a50:cdcf:0:b0:553:d641:a662 with SMTP id h15-20020a50cdcf000000b00553d641a662mr105787edj.16.1703032278403;
        Tue, 19 Dec 2023 16:31:18 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b00552d03a17acsm4824397edv.61.2023.12.19.16.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:31:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 01:30:56 +0100
Subject: [PATCH v3 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v3-15-3e31bce9c626@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032250; l=911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WDI26IliceRlW0YgN7X8GrPWGyVd7988pOYar0kAAss=;
 b=JT9map2Vij7kDkB2GHwlcrRA/PgAQ2Y58vBqJjsCY549ds81i1UK9SvzTpVTsS1KT9mklzCaf
 C2VYQCp2xkQA0O+Oq6whvZJzd0wz8PLykLRWLo0Ox6UIb6ceFDlhwRP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GPU_CC block is powered by VDD_CX. Link the power domain and
provide a reasonable minimum vote (lowest available on the platform)
to ensure the registers within are accessible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 30b140e1cec0..ec9a74acc69c 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1723,6 +1723,8 @@ gpucc: clock-controller@5990000 {
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			required-opps = <&rpmpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


