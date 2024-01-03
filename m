Return-Path: <linux-kernel+bounces-15964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F014823661
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BCA1C23C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A420310;
	Wed,  3 Jan 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wN/8VzZI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EA1F94D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5569472f775so2329910a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704312961; x=1704917761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsVDDOKbbcbcVH/q5yPVUfnBtFtphc4WlPKZOWq+eRk=;
        b=wN/8VzZIyd809Z/kBBBYZEZHZfAUXZitd5Vy4oH/DrwzxGoUGPi3rzS8jDvoFzvljy
         w1mlPSKPzIrz+YRppdunMVEihFcRF8nHnj4ae4wJTF7YKiFGwxHQ3iWcU9T+lGzvGHej
         ucNFHr9pqxip502r4TomjOjCbrcUvt4lgMSfrai/CYyIrx5LJbDrBmzU87TCADvGTjLd
         k9oHS9rlxsDE1EezXQDBGfROHrGJxTa5a91xG4G+dBhrWr5fEuh3sKijH7a8KRBRXZCd
         b/fgp96NOCB88Uz0GWVeWivvb4orDXelcwB/4FPuiVDCMuRndDYHscHcfHt/TfRT5oIG
         UEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312961; x=1704917761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsVDDOKbbcbcVH/q5yPVUfnBtFtphc4WlPKZOWq+eRk=;
        b=TMVTtvIC/SSXm8GEOHvIzOYXl5bm/9VdJo5FoZoA1vhBTgZ1qmll6d+lo0ZtMb5d51
         sT02q3lvrDrDhU9R+IlmRaiPEpj3wskIby3ObCk0+kBB8YMOPRqBAMAujGUcxS55n8a8
         ZRex5WmD+hCoYUAbQpkTCJwEJlH9fxkGorm8RBiek4g5bHNxN3pbNb+gu+CYWecwCW6b
         DHehybH6+IeZSpkJnisPntdCETEpdqlULBdtM9/y/6aalqBuJYiIjENngVmwoWioZpqZ
         pgZhigl84Gr79arikEC18GDXla9D54hvAyrQK0Me9MBQqy1MX+0977TVOE/ltzQhn0N9
         iURw==
X-Gm-Message-State: AOJu0Yx90QWHExsRa9l1oURkuzPlaCrU6pjEYFPq6fNlJ5+FHKxIb1gu
	Dw39I0h/dTnXut1cZaDjXaKyv417s9NOAQ==
X-Google-Smtp-Source: AGHT+IFwXGfx9V/fM2mIkflGRTIoBmR8LHL0J3DrV6BBIx5R47IcyH1v8+lE2bhbV+83jom3f3eLIg==
X-Received: by 2002:a50:c21a:0:b0:555:5259:956e with SMTP id n26-20020a50c21a000000b005555259956emr6606293edf.20.1704312961685;
        Wed, 03 Jan 2024 12:16:01 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id fg9-20020a056402548900b00552691fc7f9sm17549670edb.66.2024.01.03.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:16:01 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 21:15:38 +0100
Subject: [PATCH v3 8/9] arm64: dts: qcom: msm8996: Remove AGGRE2 clock from
 SLPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v3-8-a66e698932e3@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v3-0-a66e698932e3@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v3-0-a66e698932e3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704312946; l=853;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HHArVul1RHFFQ6r2bVO5FLrY8PkiyEDVDWk91JfzQ5w=;
 b=vBPyfWgMfR5o5L1Rfy+7PloGMzFVW/bj/nam1vYaO9GqVWnZ/eFmERwC0iC+MHqQZ8NUCtJTU
 erdzs3CaAnJClw7EVgK/WdnQSCrXwXOHcCfAYPmd/YgE5j541COiSbm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4f465ac573f5..174eb410824b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2467,9 +2467,8 @@ slpi_pil: remoteproc@1c00000 {
 					  "handover",
 					  "stop-ack";
 
-			clocks = <&xo_board>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "xo", "aggre2";
+			clocks = <&xo_board>;
+			clock-names = "xo";
 
 			memory-region = <&slpi_mem>;
 

-- 
2.43.0


