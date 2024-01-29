Return-Path: <linux-kernel+bounces-42701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227E840547
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941FE1F2303D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15528627EB;
	Mon, 29 Jan 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f89HCGaE"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513461680
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532363; cv=none; b=EKjiyp8kwfXaiChlhQ4bSjJIEoGQrDteP3Ytbpu34Fo8lb82GqCzYr9G0eOpBseWNA9Ht7h1tJ7ecPYo3X3LPeMFjJxlGaPvWSvtyeSb5mwxMDF5aojs08X4xyIEXa6uwHLwbayxFw0HXZ1xj+6iSXBz11FMaCL0b5rev67q5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532363; c=relaxed/simple;
	bh=hGwGcRNAY6z3nEOXAcPO/GTMblUWuls97b52uwcWv44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewXU+m+ak7bDNgq0ffeiq2EMp0yjdanLkPkeyQQLmOMlxxKSbwz3OjqcbLQeHtGNAxViVVdEdlriaiagQaX0F5Y8Mdi6p7RpaWz75TsOajIPRdCTvZhmMLtId4A/79PEXzs6ZhFz7XAOnSRRDCWWoWHDRz/kKvuamMnBX9bumjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f89HCGaE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a358ec50b7cso195464566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532359; x=1707137159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpWk+gUI1kF8qhFNhkLXzIkhTvjq9VbD2XVbc33Jwiw=;
        b=f89HCGaENbIPFUYHtFrySjruB2PS8oDgaOX4P4pIk0ny47ahTjXa8vUKK40kxwc0fc
         V+4jh6Z3PaWH4jt8Vtq5jHLkxJeCMF1MBoP6Vpj0jYg8rJN+3hfF2uRnZqVlXeMG6pjP
         VQC8o6wn6js8unYMhUBdwSfsQScMwwbRn0LHRKpuTrkhgPGnsjHGhyCUZ9nczKQtpcQ0
         3hK8oZIog7ggVv1WXESVWlwkWlCLkyv7G8W1BIiLYakYfzFawZOWRVjqLoXEKfANJFNh
         MwnaGN0byIiurnBq+rnTiFQbie7UuI64pZIK1mH5JTV3sidE0KvplE4rAKFJIlDIXZOe
         LUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532359; x=1707137159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpWk+gUI1kF8qhFNhkLXzIkhTvjq9VbD2XVbc33Jwiw=;
        b=jQ8pwCqBix3Giua5CYV2QDeelloUYARn7Pcxmyl+lT+eigBXy9AyqpsiB35g0emJks
         1XGyUX0um5Zxu0bd5SVLtp8d0VUMtlFhFzPWCfs3ROgl6nEEp3fRs+kQkABFSbvnvzM5
         9TQMG0H3s3oJagIWkBjyV01sKOrHj5czH7V33Jbxj1FVXoEC/1ECOQZtNsLY9MBMPuEw
         /MX/t9MJbmh84gbvc/i8yjEQ5Y177U6JmNT8842Yuqpa2P3kfCiQVZzzT2Tyw6TH+uUV
         dOqJKFfQgKp69eH9oHUNxg9erFx9LqJTbGRJhbbfHuqdLQbx9pt3JA1lk2Wz/o+lprw6
         d+bg==
X-Gm-Message-State: AOJu0YwVX4Ws0xO8woSPFSoYILfcHJHZIhTMgAgZvJUC7EycQwfomZUU
	nAuPBJ1w7jinpa3NIorSSs8Vz9tY5FkmQoZLcdy4Aejp/mTcKR/gh+2xeUX2Nao=
X-Google-Smtp-Source: AGHT+IEFdLHbIWA1lCyeH070PYYC1qOxOggYd61GoNaeLfLeTWzt43j9myrHAEBHenolYV8OPlG1hw==
X-Received: by 2002:a17:907:1608:b0:a31:1a10:3b1d with SMTP id cw8-20020a170907160800b00a311a103b1dmr7244889ejd.7.1706532359604;
        Mon, 29 Jan 2024 04:45:59 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:45:59 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:33 +0200
Subject: [PATCH v6 01/11] arm64: dts: qcom: x1e80100: Add IPCC node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-1-2c0e691cfa3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=E0uYI6lqGwCrH+pcr7C1xTC5esqpTyDE5ExbYCu6A1E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt534TEuZymAVak3DFDwaveHhLMUkHZMt5etYU
 GlvT26lP2GJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbed+AAKCRAbX0TJAJUV
 VlxkD/0ZQ6lJ8q7QUTgeH29F7Mg7VoB5rxZCMtj9FhGRV2BMjlQCi/ms4HztnraBzCukQpRwakS
 pX7AjlY5aQ0SN7X0SF/UTzx32dvTjv6fxM0SeM/IZdERVC8A4VvDAug3bWSqYDlOwe0m3HFH8HG
 MT0IYRf3Bp6P7EB7y2m2ac2FXgwgo+U5Tac4Byzk1VmYAA/xOyZSa7+GlfsAljH1Gz2zRnRvY5P
 +NzVPceKoIKLh8ao4iF9QsvZzfN2oed/ZUisPH0+ZhXbm7iMtByl5kqJKgDyMQ7lQAYKEpv4Rj+
 yLpB+0R355iuFxfo9Sy/GkC1ffJkR9UYXgJIWbJv/hA1aIoqHiFSh/yOK4VFD74jEa7jdiL5JnM
 WbvKWmVwcYqsBe4WjeOqFY5S+NGBC3yG9tcV8t9kpS02R7sb2pWPAslXUk44E+880sZJfpAYYG1
 fbZUyLnz2J/lFIPEJCwh4qWdlVKSNMe8NIeUNUpNlnqcDaoYHiujl30KLpZYvw1mkX4l8ZiADNt
 KN1tde77GUZfoSjqdXduZdqIEBgAGnmbdCuGo2AI3OD5JKM4bzJl4cjDkrl/osmbQhJhX0YnLN0
 7StaGuiFHMlS3JyixqjvZ1ujxRDMiJw+IVV/04fDizn1bY17HwjvAqKPN3nptCXoo5Fa6659ueY
 7J487YlPXTnocbQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

Add the IPCC node, used to send and receive IPC signals with
remoteprocs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6f75fc342ceb..954f2bd9b1de 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -691,6 +691,17 @@ gcc: clock-controller@100000 {
 			#power-domain-cells = <1>;
 		};
 
+		ipcc: mailbox@408000 {
+			compatible = "qcom,x1e80100-ipcc", "qcom,ipcc";
+			reg = <0 0x00408000 0 0x1000>;
+
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			#mbox-cells = <2>;
+		};
+
 		gpi_dma2: dma-controller@800000 {
 			compatible = "qcom,x1e80100-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;

-- 
2.34.1


