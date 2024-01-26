Return-Path: <linux-kernel+bounces-39978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670A83D804
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F691C2F2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7560868;
	Fri, 26 Jan 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFCATLBQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029A604B6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263251; cv=none; b=VV4PGdThY7gQVpk6Q65KKRbWyWhVpo31CSlG6hqEKaH8fUn1Px5/+qvtAWrRnIj0gtTjiyCJ0+egN2BrTEmue7Moy4RXPGMhiZq3Fm7+/USOpzwWgpuecsZEKNKi+MoUrevF5fDDGneSmkZTcQXjY1DSaVU6/yaluCrV7hsvlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263251; c=relaxed/simple;
	bh=MAe7tKW2o5NmhX/EToIcX2pFwZbjxHgt/coTrFipYAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcxMxd9RFygVbkkl6jWRXnXio39YH/5m3RrSfTGKhr8A1T+Xo8Teslzvmv0ZocdTUWUd421liTLDJdVAp2iXfSl7UYxcej5HR2n4vmGc84eSmMbhb9f0JOcM/UvOleK9BAEIX2CxMX/wm0moNguitNCS2nb7xWEdcYCQX8fXuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yFCATLBQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso188096e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706263248; x=1706868048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LloJ96MTPtfEA9aMbD8AKrSCBSBCtvDbDb6GMMRvUs=;
        b=yFCATLBQiAq32LXUuCCsZ++SyMOSTEb+gCm/6epn/Xj/FN7Zcy/jJ1z2gXdS0t53bT
         JE8CCXPzeHKkthXVVOKcJSWtuUUfyCmPDJg7Bov2q3fYaDstmQsSpDIqyww8mYv9ycj8
         lSRKYaP4PXakJRBnSV/peMrUEmZkzBl9Lv5vf1zuvqnmBhaFgyomqrg+RR9z0inPOTX4
         7TRwExzMoXSWeTGuQgcDcafLjKJKWP60lwYp+5IwQvYFwJIRuG3Q/3UNo59sSNG8hdWF
         xCIrtrbtQygh06jrY/65rj9oor32EDNGIM0xqasr0sKdJs7E1sN7+X7o8L7h+yazXghx
         o4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263248; x=1706868048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LloJ96MTPtfEA9aMbD8AKrSCBSBCtvDbDb6GMMRvUs=;
        b=ovB3gtm9WEqG+SIYA67byiY2/lnMBU8ghoMQdmID/i+9I8FsEVZNxQuVbeMEpUUGKP
         roFzJLtx+4ViTsStE3YobuvDnw81W4moXHC2CKNcOGElH/LhpMfEyKuQ5Il4EFLYL8kz
         2ULQItWI2aWgVjTIytf1v5veHT2xhV6mlZHo4xcRwHWaftllRw7zvzWlgLEAMxx7Azrk
         NviMnWMyQuOd14DgESGjDJh/h1nyzuQbv1S9ujwuNlFzYEVkzyz2EndY4BrA5q/B4KbZ
         iDo2SB3rT1a79uU/RF5exYYrCpQjoFc+T8d+MLtQbIU3EhAYXn4b7oitLmYT0x3DbhV+
         7YWw==
X-Gm-Message-State: AOJu0YzXHecbodxRo5nM6AFAqcUqvJAYlWbZnf1Za2w4bxw1nd8e1glq
	idVT1rLcmQ1CIjyypxe9AN72CNogrn2PC1ttzeBfWp9IWZ6dAuzPM7HAwTCUkpQ=
X-Google-Smtp-Source: AGHT+IHIC5hRclS0207cMJ0Qc5Jf0tDD8roSNv/SlzZAZiaXKhdJZr+PKRul8b259K+iPIHCr7WpxA==
X-Received: by 2002:a2e:80c8:0:b0:2cf:3037:2a3a with SMTP id r8-20020a2e80c8000000b002cf30372a3amr611092ljg.18.1706263248085;
        Fri, 26 Jan 2024 02:00:48 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ox27-20020a170907101b00b00a3221b95ce8sm448494ejb.77.2024.01.26.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:00:47 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 26 Jan 2024 12:00:22 +0200
Subject: [PATCH v5 11/11] arm64: dts: qcom: x1e80100-qcp: Fix supplies for
 LDOs 3E and 2J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-x1e80100-dts-missing-nodes-v5-11-3bb716fb2af9@linaro.org>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MAe7tKW2o5NmhX/EToIcX2pFwZbjxHgt/coTrFipYAE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBls4LAf5TSalEJKQwpC9rsMT5vCFZJFRr/ZXjz9
 yggapqpNw+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbOCwAAKCRAbX0TJAJUV
 VoYmD/9dBQh+7ZuG++cQXckQWo0NttFLdeFWB7qmjG/rSfOb3H+OOhXFebKb203AReoHz008jBi
 MrNm1XlVHlWIacF0keaCu9f07eapuwsSeNh1s7JWcYUvJEAEsfhaoZqneJWGLzLE67BoHZnonkD
 lyssAGS4o4tBjBeL06poGm4h9v9NwLK6EGP+hbluXLJZZOpIm1dKb5EjwEPfAjyIwRQHf5LBuHa
 IJZ9ecSGWjHMElwPrbB5dxC2bf1czLW7z4/mCtZ8DMqWujyowXDrtYek11MSW7qq3lKdYPd52fU
 4TLR8EJJjicUgFgjE+jNkP+JZlT3iv0pj8qj/lQ0iZlTYLUotMc8KRkm8VvSTS5Xb6Pj678nvUe
 UW5hw0lkZtW/1tRhQrCVifiQn82DuzvQiP3hhR6JUvsU3+5CYFfwFwlZ75KsOWjCXb5xZdS/RgG
 RYucaj7RHRLb0wXybUMdeGFNaI8GMFGaVLYwQfDpQEAMECJ0n0qr1fZLVsgmFGJ9eiGGmmQo5MJ
 k51nrs9bV4TRBbS8UkLHGGQHkO52ZTIIx8z1WWlSj6lz1dNUQKGr4Eupco61bWn8PfieaL+VpJj
 FQ6YVeLRF4kUNSXawIXkMbJZqeSdS7HTFfTzeKRTOkMpQUuUnxn4+/EzK1LRD5WnRS37Vov920I
 TadMiDTgmYM4ubQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The LDOs 3E and 2J are actually supplied by SMPS 5J. Fix accordingly.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 8dbf6d0eaac3..e76d29053d79 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -261,7 +261,7 @@ regulators-3 {
 		qcom,pmic-id = "e";
 
 		vdd-l2-supply = <&vreg_s1f_0p7>;
-		vdd-l3-supply = <&vph_pwr>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
 
 		vreg_l2e_0p8: ldo2 {
 			regulator-name = "vreg_l2e_0p8";
@@ -367,7 +367,7 @@ regulators-7 {
 		qcom,pmic-id = "j";
 
 		vdd-l1-supply = <&vreg_s1f_0p7>;
-		vdd-l2-supply = <&vph_pwr>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
 		vdd-l3-supply = <&vreg_s1f_0p7>;
 		vdd-s5-supply = <&vph_pwr>;
 

-- 
2.34.1


