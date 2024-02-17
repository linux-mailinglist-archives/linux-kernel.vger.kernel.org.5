Return-Path: <linux-kernel+bounces-69854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FA858F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B91F22D24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8F47A73E;
	Sat, 17 Feb 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZxgyw5z"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2367A72E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174819; cv=none; b=UHlG4ym+9rW0ErHCAGA3FU/Bl5HE7M+Ex/ieYIPNgFBO0k5s6svWJBqie+ITzdy+l7FdzhSIcjZ4mPn2BeCOS2qosQssj4eLT6gesxEZJvjPxQS6i+EXtfEnSOQ4S9nUaS0WtSS/V7VH8nHo170VsY8bCKuo/zq5+ccnLm/mljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174819; c=relaxed/simple;
	bh=I4t+NyC+xXswLrJ6H9tnVexduaTvPcO5BsOp3W3R+6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=REgtXjmCCJLiMYJujSw9IugBup2ZXjLirrMd3FLS08f8oSHl3eF4EkCa3xd7jo8Wn4d/QfVw3dUVHo8qd8PGiBSq7PgWlNzGZksNgLg9lf4EVH8nAIWM5jUPwuz2sA75wmMr/j+W3QD1ksCWWkL5HKYnuJqCOkH6oz5y+pH1SL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZxgyw5z; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so21815631fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708174816; x=1708779616; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZsF5Cn+TEuUEZcXkl6xjZPNAK30CgZ7B3oXv0UIX7Q=;
        b=kZxgyw5zZ07X93HZhZ/pMvvQ8erC3nuNSRXNO42+40PyU7f4i02Ylt4BZwZpT91lUQ
         1Sm7Ej17iNpATVfvFE88Ium3Pjw8oZqzsfblL+4WzDcwzcds81VkUKzLx8AEwD3goo01
         hUypNd9ISvMBBF7Wr0c5qAU9yVaHle620jPUBVTyGuR1sm7XmbvfT3t5ymFqpKhmc6IS
         ak3kAMBIIZeteIoo5mWVPODBWciyutqUn5yy8byA58DRxxt7qHsTaghV6+Fl+oHwXbmn
         E2En1ObwsWhOdEhvRhEHD1O8sqIejRneCX4DXlDrhk3gErNFK6YOTA1bEhYB/PR8bOxu
         pPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708174816; x=1708779616;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZsF5Cn+TEuUEZcXkl6xjZPNAK30CgZ7B3oXv0UIX7Q=;
        b=Ucl73b8pLEvvSRd96SBpfQdlpx71XvDyCIpACuT86OMgQD5SorzbTRCcTlmhYWdps8
         jQSDgvizEeyryIdVSGfC9jvjT7x1N8gyOPpaqc2Rl25y2OV3AxruxMwnN01IqeihCi+7
         yz20yGCMvmMd1/xvMdYza3wRa56sp7Kr6NXsg7IAjtoW8WNFLyxrnosOuWrc2IGHUEqQ
         YRsoks0mx7C4NL1aQzvwg2qhPGC+rb32O4J8yqbC8Wv8tbx3ozuqXP3rJm0e2IDRzpZW
         o51FNukmsmIYfHwVMkjK/QyBiveCamFVrNMxoj33GZh8LmoVyJNVTgJnUjkvxw6bJcyS
         6rxA==
X-Forwarded-Encrypted: i=1; AJvYcCXD7OnxbOFizQEN9FKY26d72qFS5QUry1/cYBmOa59dTLZGmAN1L4eB1eiABqfKCAvElur9ci4+/Cbeyw5B0rznuGWhyO3ChTdKH012
X-Gm-Message-State: AOJu0YyS3QqktushYgsvDU7xfwo6W5owv0LAkbviuj7xMkY98KnluHr9
	V+86sfdvOfKOLWbZ83nGr1/0y1gQHYMPIdKo+LGJ1QOFVfrZJ5GyHObqsxQlSoU=
X-Google-Smtp-Source: AGHT+IG37EhLEIyJMkUfK9Ia6jLZhpBV3S2Mby/k+T0USdu+atu0qv+dEOg0H1CwLyNgGBnxHGtscw==
X-Received: by 2002:ac2:53b5:0:b0:511:a02b:8223 with SMTP id j21-20020ac253b5000000b00511a02b8223mr4881369lfh.58.1708174815887;
        Sat, 17 Feb 2024 05:00:15 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3dd52e758bsm959608ejc.100.2024.02.17.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 05:00:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 17 Feb 2024 14:00:07 +0100
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Add missing LMH interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-topic-8280_lmh-v1-1-d72dd4fedfb8@linaro.org>
X-B4-Tracking: v=1; b=H4sIANat0GUC/x2NQQqDMBAAvyJ7diEJUlO/IlJiumkW0iiJFUH8u
 0uPMzDMCZUKU4WhOaHQzpWXLKDbBnx0+UPIb2EwynTK6B63ZWWP1lj1St+Imh5PRcGH3lmQaHa
 VcC4u+yhZ/qUkci0U+Phfxum6bu9rPW91AAAA
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174813; l=1550;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=I4t+NyC+xXswLrJ6H9tnVexduaTvPcO5BsOp3W3R+6E=;
 b=9YCoAlhGNMlVbiCVW+pj/ZJgvAw86IYa6Cw1GZ33sZxrhjKOIDzeVKKaX7OZm0QCYrcJ9DlSy
 3Au95oZyu2mDm5hmExnnPV2RfzET5f8Bf5HeZHl6DJBOkE5CQxkUsg5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Hook up the interrupts that signal the Limits Management Hardware has
started some sort of throttling action.

In testing, you may notice the A78C cluster throttle IRQ fire count stays
at zero. After an hour of painful experiments on an X13s, I was able to
get that cluster to heat up near 90 degC, after which the IRQ has indeed
fired. So it stands to reason that the heat output difference between the
A78C and X1C clusters is so massive that LMH rarely decides to throttle
the "little" one based on its power metrics.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a5b194813079..daaf054efca3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4966,6 +4966,11 @@ cpufreq_hw: cpufreq@18591000 {
 			      <0 0x18592000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1";
 
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 

---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240217-topic-8280_lmh-1e690efcf7a8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


