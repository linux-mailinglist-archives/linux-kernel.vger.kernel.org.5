Return-Path: <linux-kernel+bounces-149879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8F8A9746
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E401F236AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878015E207;
	Thu, 18 Apr 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExejG7bE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC715CD5C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435762; cv=none; b=s3y1kf9R2UmgXR+UfenlbjbitkXrfgMmVQ6PBIB3SKRKw19JnwyOVsIzZ+6wnKCVQzEhWlOBfoskJnTWSDQDGLsiS8k4jZO6LbtzYK3oOzcLXY20CDh97Pk04eBAamqqJwLwV+7jOZn0q+HCzmnEqthW3TleVai9vy8T1bNRpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435762; c=relaxed/simple;
	bh=dgXaFVCZUNOSaiEzpM+oe+2Km03Satk8qLpTLDPPQeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cy09cgnXl9Y0egmtgzWo6jCHQOSUtrRj/+yYeiIqL1o+w6OHstpVMzJNMYq9+nlXicB2WT9g5NRNsotYmZQsa5YWq5+OH68Jox/NmY0hKpKO82DBkP4AhWlj0j2NntitByLV9/aiL+jlo5uxbfHECnkfW869TWWlU0Xvz0TszqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExejG7bE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-344047ac7e4so1143007f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713435758; x=1714040558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUCOuzFoK3H2WNAxEZb/hSYPJ6SKruO0EdmYB+3KyoA=;
        b=ExejG7bEf9QGu+mkFwd48ytUKVdWV+aYZsgZV3lap5sDyY0T95+4mcc9doE7poOgFZ
         y4QR6q4sry+8tOil0yUFTBgr4+0QGTkJmJEmnhD8N2skRDWlbDMEFe4aPPnWNI782CwY
         EmQWLIGGOI859cso28H3MabCvFXRs1859FSQ22+d3RXC08zwl4JdprpGOuJHid2oVGYV
         RqaFHKQnst6U1CpE/NWUNn3JLlyPN6lFlnvoZQw7rh+KtWLD2ljWszFxBBSeoPZWpj/h
         kJ5I1dVoGXQBWDN9Ozvw3fhJCr1J6jYi5U3qDKo+u7QGQI+lAa7uMmGojsnBygtHbAX6
         2BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435758; x=1714040558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUCOuzFoK3H2WNAxEZb/hSYPJ6SKruO0EdmYB+3KyoA=;
        b=X4pi2/qM+nVqbcXHni8pvMLkH0IUtt3ytNxuH8VT/TVxnxKZkmBs6eoq8dG7vRm4Xz
         jIcNus0cFXNT1UZv4yMsJoombzH2AopSmxaRex8nTgQF/B1zYlpp/IwbwTuj1W2x6h5z
         knfuN0SXFb931yYbGjMA63YmjlnLrrWxcwuBbojcjwFhnq+eYZhKcWOhnROCm5HB/RLn
         ThpCtTvbjqC6MwuDLawOOogbtHJXXgAuYGUiaElvCxOvtsjWlHoPM3kT1ymrdA93N/Ay
         1lHla/cKnFoyBS5Hc7E/9xNpOn/ex0ugJvPh1vY9fQ4EY04IatniYEXzodtu9nJTzXMK
         n9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVha5v+FzLIy+Xft+iqTGtQaAE64a4k7f/WzULHsgBROOiEp1W1f/pc1g6FfDwAYT7c0d4FzYlkA90NTvtZC1Q71ZkBfz0nbxIXzgYU
X-Gm-Message-State: AOJu0Yz0nQN+/giVpzI1Y0s9U4Khs/wE29+qzZYdvBXNSSVEE/2ulB+B
	NH/oIuh8IhNiFA9yATRwE4MX9Jc/mXvAyt9Y/wql2JNSzrpre4PaNgKt5MTRajA=
X-Google-Smtp-Source: AGHT+IEHfbtsiLVXgG7oA6/S2au304f6pvUMm7mRl9Fdccj4F5xVo/dSK740RhWmop5onDHyNr6F7w==
X-Received: by 2002:a5d:4ec4:0:b0:348:cd2c:d2fe with SMTP id s4-20020a5d4ec4000000b00348cd2cd2femr1449572wrv.13.1713435757997;
        Thu, 18 Apr 2024 03:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b0033ec9ddc638sm1472731wri.31.2024.04.18.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:22:37 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 18 Apr 2024 13:22:19 +0300
Subject: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: Add data-lanes and
 link-frequencies to DP3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-x1e80100-dts-fix-mdss-dp3-v1-2-9f8420e395d4@linaro.org>
References: <20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org>
In-Reply-To: <20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dgXaFVCZUNOSaiEzpM+oe+2Km03Satk8qLpTLDPPQeg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmIPRoggOwnpLqjXc6+Q/PjG7evbu0CzpfO1ygK
 G05bChs2qiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZiD0aAAKCRAbX0TJAJUV
 VuwKD/9qd/b02DSfltRC3P23i6ttWWMv0s5+FINY+eukMg4LOEql2xON1XDyv5tDZdPhe+njzqM
 o/7JH91ZfiaOU45qVrRckX7lxwZ92Q+Z4WzoF7Pi8VRgDjRdmboaIDp0VJBSw3FXAInAriMwFR1
 eAKsNrNqwawybge/1/ensDmp2+tG/GAe225UUxqGh1ExGd2OqWDD03QAsosw3Fgg97ri/sjgUgb
 LbnxCIqFVXqjq+wFE6XvaHQIq4GxLNC1WecD9NnWk1gobCuye0/k7N637jmEtkQI/RE/Y4ucyAp
 fHtz62gYA5eLXwkitqH9ciModWLZ1ZjALDb9G7qobahdRoUYfid4dztpzQP+VfY8LKF/ISE25dh
 C/AuzVr2kvUG2O7+40Eqldmm6TCheW1zol2Y3oZeBKzvioM7iEGlwYqUK0A5xYX+HTTobtyEwfO
 67+9Vtof9fqcljxBk7ThR8nbVUW+UfiwqGj+FA7zCgPIHW3SCUyJnTng0QkwsxWxj4e+LdTUL01
 asqEdwzNrvfa7/3wuOc6yh1tcLZbkIYFt+1arQezyZU7IpYUMUiwTJbf4zN7Vqdy7x3xWK5QmGk
 BsnalYLWlYJIaCVP8tSOXSuAusFBBOIs6n55aifEzbwaM2+S8iXhfV4mPgXedZ50cjYekYn4d6B
 bqcDDQ5427xU7pQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The data-lanes are a property of the out remote endpoint, so move them
from mdss_dp3 to the mdss_dp3_out. Also add the link-frequencies to
mdss_dp3_out and make sure to include all frequencies.

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index d4198fa204fd..c5c2895b37c7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -599,8 +599,6 @@ &mdss_dp3 {
 	compatible = "qcom,x1e80100-dp";
 	/delete-property/ #sound-dai-cells;
 
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 
 	aux-bus {
@@ -620,6 +618,9 @@ ports {
 		port@1 {
 			reg = <1>;
 			mdss_dp3_out: endpoint {
+				data-lanes = <0 1 2 3>;
+				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
 				remote-endpoint = <&edp_panel_in>;
 			};
 		};

-- 
2.34.1


