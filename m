Return-Path: <linux-kernel+bounces-83263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C328690FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B26B298A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCD913AA4C;
	Tue, 27 Feb 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4eWfO5e"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150413A258
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038418; cv=none; b=TjpVGTnde/btOcfXOIahK4B1d/U3ec0N0wHzso0IGP9eet1eoxYn9LBfd6oqTWttVpuhththLqO+P4Earp452mOtQFR+FiX9Nx4geC82nuHgq3VT9wZhoJF1TECC0IsvfdLyTHPzT93RZ9DX2QyzLSdd0HLMBwvo7Nk6ARILs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038418; c=relaxed/simple;
	bh=lugX5F4h8/NMtld2zD59gonUAOKUZrpUFx2+QOqsR0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlCwLv77pO0nSvenx/elgStaaDYNev7e0HqedJzTrZFEEGNII6N9CEaLbKwf/JbkUNtLvZIWRNUKbkODOaCZjz92lT3pqVNfQPx2aIrkAKYBVVQetWBJa0HiA1kkOEkekBTuXcw3Ahwvd3iFAGCOMiMVXrxvr5C17+W9nJp100U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4eWfO5e; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so3398798b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709038416; x=1709643216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8WH+QKuLCiKAooO9eGaApqHPwVDB9t7UHH/XROmJSQ=;
        b=e4eWfO5etoXdBdnnrWr3t121+yd/hg6d5Rkk2KnVS4U0quaCFHrycN5mgvoT9IBcVv
         bRaGRD8mRbkJTXmqU4Ms8gYSjEmL8Bdz9OKabJ07BH0925/94aPyYrar5Dvbs76tlHpw
         q4Klu07pkKEhXOxIjkJZf/iGCqTv7EuFkUxliU23ioG33W7lgQFE3LoHdTvckoWJQYaG
         p1Jw9saujYaZyp8axiKUS4WUjthBAp/FSGZLJU2YuChPyoC2jiSX3N7eb3SX7LpF5qGQ
         3axqc1Vgxv5pkwv5t/6i34tsojVhaD6hOwyPleVPo2j38V6qY/FK/c25T19+/7yLSAc5
         O5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038416; x=1709643216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8WH+QKuLCiKAooO9eGaApqHPwVDB9t7UHH/XROmJSQ=;
        b=uE6O7HbhURlq+UVndWz9uoYyrwSzGJgZ8lYcoVvW+GyvuH9TO2DZyMn+Tv/IiwZsmq
         TS/En1CC3W7pkp/NNz/P2CLyWb+4S+VycF343HJ3YNoC9GzlXzQ7LN8m5wV/kQnQjbrG
         H9WAET/6mspgaAzGvW087FQwqiObQoyA4/smJYtKj5OvzuedYCJwwSLyDs9dgDVQnF5y
         +sw4yH5gPbQ/3wlChh0RGaePMFhO9ndaspEL1LHrbz7OUY5BGfx9KnyjOcCIvvbu+n8V
         rST8nCH5c547yJ6Jj8HH4DNssUTpe3fKLeSIZAXAlAPnmx+i/EmWnzA4ZrjF4o7rrCp9
         35gg==
X-Forwarded-Encrypted: i=1; AJvYcCVlzufG21H6rhLzkCKs9NfIRCv8aC1mPSPu7gKC5jC8wDtSunQHxqmr7+lWYtZkhC8J7u9u02+/kqlsIluiRGRMm95Skvvbt95jf7PR
X-Gm-Message-State: AOJu0YxutvcR9zUYgC2yvUchnXzuE8W8sIt+LG8VC59cci9591zRmHH4
	aXNDAnf7HQk3H2bRSY1sh4Tocr8XUV80ubAUNUQAjT1MX4UmQbn9AftgKVV0Wn0=
X-Google-Smtp-Source: AGHT+IF57wEBY//BS0sDsW7thY5o90BHZJ1n5nEUshFNRxLEF1AZFDiyKAMALjfGexJtGmhq6VaKmw==
X-Received: by 2002:a05:6a00:4ba6:b0:6e5:bdf:7df7 with SMTP id kt6-20020a056a004ba600b006e50bdf7df7mr5568352pfb.7.1709038416134;
        Tue, 27 Feb 2024 04:53:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78b87000000b006e48b04d8c0sm5841193pfd.64.2024.02.27.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:53:35 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Feb 2024 13:53:06 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650: add missing
 qcom,non-secure-domain property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-3-15c4c864310f@linaro.org>
References: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
In-Reply-To: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lugX5F4h8/NMtld2zD59gonUAOKUZrpUFx2+QOqsR0o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl3ds2B2CJaQMvWvEIPjVZsxSZhFy8O3ULkkhIYyC4
 Zuz8eGSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZd3bNgAKCRB33NvayMhJ0RrcD/
 oCa28b8Zcv2mDOaSUEQ5dnw93PG+1AbRszXTlk5h4ugGwPmigfby5mZR4K6TTtBSRqbMP0O+wTX2JD
 di5z7yyOKWa6Hh2lAHsZhbLYZC/Zdk+hCtoyWFcDq/U2AK3buMZOUFKk22CvfR1ESHr7I4U5mngWQR
 +B+w8bLvAcObzZtq4SMWac6Aw9dA7NGmJAXJc7nu/dMzyCO3Lm6TytqrVEr91AT1HA+YuYa0Sg5I6X
 JetkKmaB7g+PVY+Nkr66jiUxIfJGbwoLzJTpD9K9clFcpyLE7VvqZhzS7jlOkTBXCvbhMB1etr8kyI
 S7Nc8KZyJRj9OkzDxFciuJf4OXXkj+ev8HdYHiRyHzyLLMQmkukyagSu0H5RvyH2AOtegTxOreJUtY
 O7JojHW1exuRdw2p8/wDw+MChFqdT5lk++1gIuNWOr552IK+n+Heva6sZcFl2nLTs4Ue5SQM9qUitY
 IUXRXCAAylkDHrHktwphl24/jJbOIsb48/1ID553MYm1UNusR4mTZLdsHLSSHWPaj5GxAHuPiBV76N
 MYZPMaLsqyDBlJ8M+O/zwp8Jm/kGeJHJ6u3YDzNpM0rcJkaFwJQlFQw9/74WQirc6k/nvT1ua6sOwz
 X3h6c2o8PHCwqtVAbQmKsjSW8enkj0sZrdQyK14CilvZFUDGvhNoWrobT97A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

By default the DSP domains are non secure, add the missing
qcom,non-secure-domain property to mark them as non-secure.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 12ba839f215e..ca45277b7c47 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4845,6 +4845,8 @@ fastrpc {
 
 					label = "adsp";
 
+					qcom,non-secure-domain;					
+
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -5002,6 +5004,8 @@ fastrpc {
 
 					label = "cdsp";
 
+					qcom,non-secure-domain;					
+
 					#address-cells = <1>;
 					#size-cells = <0>;
 

-- 
2.34.1


