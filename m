Return-Path: <linux-kernel+bounces-6182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD34819586
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF81C24854
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C01D6BE;
	Wed, 20 Dec 2023 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqFzXxY/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789C18057
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so431357a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703032275; x=1703637075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=RqFzXxY/wPPJxiHgcUVivBBigZA3EB47UMHhvqEsCvzclTty6KzPzkgKwbU6zkqyWu
         8H2NQe8aFe/HLy+lXFNb8xKW5TLCFA+Mm7K3pogOR0nBzJo43MiPirSrihT+AW/RU6ew
         1mGEkAx2DOkJQXCbPcRePrvMuG167iQP9FXQDIDB8p7iB8ZAa2gWvVnF220AV09U4ltR
         tUBm7wn79f9QEYUAbXMlIY5NG3hIgsWJarqeNlmJnjh6jj+RjyycSEkyBEXz3YKorlKA
         sifvr684yZWsCB2Gu9uKjzDEp51ycwERcb25wFkgSoldDUBaBaXeGQRNbSXeHBBqZBI1
         kf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032275; x=1703637075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIS8BVV6xMe2SYH6GmTY+cChP0QmWaX59VMotnHi2Jo=;
        b=NYBtNo/puv/0xBYA/aav0g3BtneFcRGnKvLeFdRxfSQ2+AYRK8KB2QW7kb6a6EsMiy
         c5b7cJW9OWOpK/r0qV8WBfAXF3DaewE4ZwYQU1RSZ6ocuhuB9Dl7xl46cQtw/5Mny4ww
         P8ng3SUrCuqgWSwr3o9w9yKAdD9uo+47zkDxnhbC3KQk6f8LxofS5fjs5ACrkH7sVDXn
         DlEdynjKab/dp+GkUlPQYtGdIfpByTYSu0SCMCn82dyq1BMpF/NfKAuSAfW5iwczUo8z
         a877IXjYvlV3jXQIioxyVTqc2iFVqBNfCtHgVKKKwOBwQRYGgnVFZFsXnK7GelAFhHqf
         KxXw==
X-Gm-Message-State: AOJu0Ywnen96UODkj45aorLyFIGBA6lWsoR8MfMz/kNbX3crWD4hD1e6
	9cyTyU78bNUusfvdXt37WS5DRA==
X-Google-Smtp-Source: AGHT+IEWpt9PiRnHgsw0PPwowNHMfylGdmeaAkubNnZwitz2S0DOwKOpV4wNNQG22g1iz2geaaFRKQ==
X-Received: by 2002:a50:d642:0:b0:551:7f2d:3e43 with SMTP id c2-20020a50d642000000b005517f2d3e43mr2258589edj.33.1703032275565;
        Tue, 19 Dec 2023 16:31:15 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b00552d03a17acsm4824397edv.61.2023.12.19.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:31:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 01:30:54 +0100
Subject: [PATCH v3 13/15] arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v3-13-3e31bce9c626@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032250; l=764;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HEE3DdJ4zQzS/Foajh/2RBi9l8ssp2UwDgoH6XqPOSE=;
 b=6NYp0Uia0eNpkvRteI9GLnVVoBVz7CvNC7YCpuwUsc6QPev7ctbyBxJgygdRVubp6bsfC8Bcn
 9HK1GmtGkNBDolETOVT4YFfY9hHCAEq+LEfzn3OgM8OPhGCqj0qz4fo
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


