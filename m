Return-Path: <linux-kernel+bounces-42711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048D840567
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38401C224A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF5D6167C;
	Mon, 29 Jan 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB8E5N/K"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15964CC5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532375; cv=none; b=LlTsuL8/6L8BodGz1wCWSbzjpOCN2CZzJye3EssNc/asrDN4s4Lt7hIvMNawW6n0OHLTIZuo8UJeb+eGAvfENAIaK/sIRbUJzL/rr56tAZCpQf+2q7BSiCgGRi4tvYgMPbI17SKa5cEPyKb9Fm9G2ulCw+6JzvDNWybHzsyApQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532375; c=relaxed/simple;
	bh=MAe7tKW2o5NmhX/EToIcX2pFwZbjxHgt/coTrFipYAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4Eyxk5gGAPVd0W11RglX9957qfcrM2MHCZg6VlLK95ksTokWPCRWmqH3uzAM7NE52CHclCEoPjYllPMOg2vn9pKG14temeisXF5Iw0wKfFAbnm8QqPAnIU2xWtu7PS2osxd59ZNYtrRT2kwov9dBqw9DrK49tTIV+gQQdVRZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CB8E5N/K; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso2557960a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532371; x=1707137171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LloJ96MTPtfEA9aMbD8AKrSCBSBCtvDbDb6GMMRvUs=;
        b=CB8E5N/KnemrzwDRN3yUlwZiB2Eq8rcKiZGugYYq1xNhJ/ESJrwHEO3JI7vv2EOFCB
         ZrNRzAJ9BRwc7p/qxabgw7rOrehPrRlklBNt02RITgoVbq9bQ5vsNDv/FJRPco6/2iBv
         nK7DeyC4xumEePbDRuYts84H0qvcixNz91k0uHbkbEa0h4KZL69VJRmCAQg+qbc2s5Dn
         8ZtELqXcwwcey/NAUgph9R0DCbWzhzyZkz0vlJxlisHX9RkKud/icLSAdTyD67eEqVur
         MtbjJ22SwKBiV47akIYyis4tTlASmCh+2XN+uAc4/YIz0gwPqKQCN4U3fZ7ubu9e/A+B
         zsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532371; x=1707137171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LloJ96MTPtfEA9aMbD8AKrSCBSBCtvDbDb6GMMRvUs=;
        b=eXhv33OeMHjhtOFWPCafF6E80KpDWlV4h5TXbuLK38lKa3Aa9/PEsNG6AewFp1diTO
         8HQ1kOybU8D4lh29+7osau9gzPeZMq4yppU/gUerSiQRpQblI4VrXHuOni9AvnGV4B2u
         nqJ/HgHf87j9a80F6ZJHViJZHRg65mUYPyso3F3liyJtLRw3Htg0CSW7PrNCJls7PVkO
         +AWRUjD7uEPxVg7GtIvumVYC+MS7o42BsVmmp5v8sQPh77qESgBtXRJ5f+yzb4bYiVzS
         7+cI1ZncnXg+CICiZ+xE8l2llUWcOa2k2CzrTdRlLyXEOgWDJgbwCAeIzjdKBAUCm86Z
         Gwpg==
X-Gm-Message-State: AOJu0Yxg9HX+QtUNWF26gvHMoAqSRQIvQGKd52pYGMTDe9rgD6i9eRvw
	UO4pbPRCqt8tBNe4b3JJaWSaVqPyY6yZHaKyB5/1rg9pM85QXW6W1gSfpNbYkfI=
X-Google-Smtp-Source: AGHT+IFxpuarcz5O461GLpYVYLGNuN08ZejCo0QBuHVdmdKHyPC6exkr/2tTFiWNUG3gze3/xFPDvA==
X-Received: by 2002:a17:906:b47:b0:a29:852c:dd21 with SMTP id v7-20020a1709060b4700b00a29852cdd21mr4267964ejg.10.1706532371779;
        Mon, 29 Jan 2024 04:46:11 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:46:11 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:43 +0200
Subject: [PATCH v6 11/11] arm64: dts: qcom: x1e80100-qcp: Fix supplies for
 LDOs 3E and 2J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-11-2c0e691cfa3b@linaro.org>
References: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
In-Reply-To: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
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
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt54EGZoPqe2ZIMskaZlX05Hjr6aH4J76PVUs7
 0PU5xc7P7WJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbeeBAAKCRAbX0TJAJUV
 VnkmD/4hIV6aynt6Y0v3MUsv1Bl2G2OS7cCj2dk6eEFtv+0EflGBu+WOef/lgWwxlKeO07Af7Ew
 7Tr4CQtN60wluCIgw1eiuZNaohXaPwv2qRvpF8/PmrlOB3eV3QlaDL5EEuDcSPb/qWLUItjtIGc
 EDtohEjpL816T/wpeEVqDpoffSzld1KEU8wx+mpP5GkNHGgnHmBdhAHbuwZWhPtqJ/Ti9F535Ya
 X1Z1j3IE98cI4VYYfQ9QxFFxz2yqeuBwpnoxD80ZtVccwcZR8FrEZoBQdbPuL38ixc52Go32Si8
 3P1JsJUUn4BdgixYv58vMdhhlyoxtJOay5n/NDTXif29jXHgWKS9T8a0wJwzCo0p+d7sLZEQN5s
 Uf1OVZqPW18C+q2yHkyZA6aCuyd9zlGgIoeZZufoF3XJ3WfYj2SfYL1CG6fPmQwbx9iuhKHmYso
 qVBc//OcFhmvNxLk4qeyKyCkra2PpAWw2Ggc06PdecLiO1tFq0yjnX73MHvFt0MBVQGv2FiFFJ/
 E8/noLL5n/Ki/Z8qsbQO4S7Hgx8GPUKxLtWCgVGfSR+n12Gsim/spfmXwb3PDFZuiWKqBMtquWY
 7sniaJGdUoPYZrPtOlpuPf7aruLcuHX2A6R26eRBic2aGaQOoOC9TpxUDuuGHj/SMp7iF30hB8j
 DJKTga+ZpoNZE5w==
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


