Return-Path: <linux-kernel+bounces-105964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBD87E6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4706D28315E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B294364AE;
	Mon, 18 Mar 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hxi4sIDe"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372731A76
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756595; cv=none; b=PKDfQkeWZ1PsjSCZ8hEa4gF8DUq8Sf8kcPVboaau4zW6HfFOtw42TaOSzi5B2UcMmteKazLkCt3QwyXkeNxSQ8jRRHuOZnhK/Xhm7B0UnXvJotqS6VlhLw5b9Fj+aDo3ystMd0w59HqoMq1nz5w5hkCjkCX9aq23XBmtIlOjgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756595; c=relaxed/simple;
	bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JE51ql6PueyqJuB0zeek53Zww3nzCNHvXy+uvmpo0XoTuAVA2j9mz5zN6iepP/34b4eqIY6opjCco57RJJ2K8JQQvGbi+k8djrjXSVcEsgsZBmkL7d9rxT9hIVDGUW/5pe87rwxTSaaJkGy0XiSQ+Qmpyxxf/snGvGw5z8/dLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hxi4sIDe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33fd8a2a3e6so924789f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710756591; x=1711361391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=Hxi4sIDeKHdS/I8AWM3bCW1IoG6Tg+SqyzhwnUy0UeFhU54es8Am2ZgHF3J8p8U6x+
         fftlGcppMsyBO2QnkIXZFllJVFz4WowRoUoQ6W1xj8KTTp70mgykp1QVuK6FjQGUe29X
         R4bp3LzHJtcVpSUPOt8kvAjGc2KFBlrwtbafJdHfsyAC2qvetPn0yCxevFTOoyMZvLDb
         Qz4gA3hz8AMRHrXGvNURimDhW34tcZkiuWWwyVfdHro1MSyp0rcCFeL+dJM4CLdoFVWG
         T7ZfmkqZt8kstrel7+EWiDatzMTe05O3DuS3bcrNp+vYNitou6fzSOhJAzo8xYt7kFzt
         y4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756591; x=1711361391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=pY1oaGTsZJFqDsAa/FS5WcEYcVzoA4FF3XmhkD7R3t10kovwZaf9NqtbDuo1+wpIfK
         lw6P+m6u19deISGbrGeFQrAZW1i0otaDVDlB0B+8k0ieu2KGC+gWgdkaLEbJ1zuxlONw
         +d/biwJrfLRENd/1cplWKypd+EOTdakwbrbN2fJnx6qgRdAbKX3mZsYTjGT2T42+Y1PD
         wvJZR8rViAp7T/+BXSif3WuuK34+WTh9XnfOGa4ZTHUedRxbEYsy7yTdf/gyX59TuC90
         ao+UyrUh3LiwYZyajt7qbe/Mc42l+nf+EPsehoFFdB6gbQJpJYsfQVzXMmpfNwbshRFX
         RXFw==
X-Forwarded-Encrypted: i=1; AJvYcCX1vjhmB5OjT1aPiJ9GX+fNqh5rjS1UM8C5rQuvByMgHF5d4e7wKPv3f9y3d0xwRehWTW4r8KEw2ZFgbsziH5OxG5cKiIalrClxc+Ee
X-Gm-Message-State: AOJu0YyV+EmtLyy8ftyceLyRNTtXDTJpMbp1NJSHiVndYG9TyW6YiXid
	yeNk70YdrpM9JKKtPTnsx/Rs36gSOAR9yN6IryW6UXme2Q2HBcuUcx/1UFGSDpE=
X-Google-Smtp-Source: AGHT+IFCyCzRpCnxE7N5sF4cdqkpTbibc9ps0WEJVl/7ziltu91YghxjzVjw7HMewa6M+W8hS0wlZg==
X-Received: by 2002:a5d:670f:0:b0:33e:7e86:1ade with SMTP id o15-20020a5d670f000000b0033e7e861ademr7862602wru.10.1710756591154;
        Mon, 18 Mar 2024 03:09:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b0033e3c4e600asm9533734wrq.7.2024.03.18.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:09:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Mar 2024 11:09:46 +0100
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm8650-qrd: enable GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-topic-sm8650-gpu-v4-2-206eb0d31694@linaro.org>
References: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org>
In-Reply-To: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+BLs+Sd6v5m2+92/UMXeUJDe1bqVLyBmTLqxC/vp
 Ql8I/sOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfgS7AAKCRB33NvayMhJ0XH9D/
 0SCVG5q2xl80Q/LqtIQ1Ot4Yzg0mMk5gLmUYyripDcRNWJ7JYjLU/v7SkUuUrMC064LFN0QlAOsijE
 6XmkDZ6saJMLBoHIXWuZ3W9R8LIlqUnjPdO6X4/Uk/0juGpfsMF3fwS3NUifBrSWeUWBytU2p21226
 yilQIKC9suAJqKFXXEWQPihbcAnFcyK4NAxDePS1x4dfSEwsgJhfwI/dtVnOyXEhsYq1LoNDvSrfcZ
 S5BaaAFJ1m+ktxuo8N3E+0FaPmce3pqpmY0MSpsas96/bixRoNotCDuFDh21wloOfre4V+wu5b6ebo
 /Vxb2CwIV8+Qgx6S3Mo7oxwD2vhvW+xhfk7LbDUvb4eCV+h8Dtu7QwrlC7py1OxnDZW82v068UI4dt
 xNptkGsWdHqzluLOHyPX9jc17XOOIIoVBlV7CgX/Q1iw5CwtgDA7ZTjW39eP0cJg5s1lscTS3w1Cj2
 Dr/clKlh1OfPN41XYF6ijUgyAr/HgXa5+pACsh3NK8O/1au2IfMpHJfSYQ2pevnngjf/PMEIwiIvAK
 Oh5UiXLft63Lxo1dO7LrOAZfdy5uP7ZFaNuoCiPjgGaC3gnEMaAJTat4AGSuF27ezIAir9/CGXu/6k
 aBbQu5kDmZC5I6fhnaHy3RULReY0LvY5o3Q8s3TPaEpJ/MPt0CD30kvyayqA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add path of the GPU firmware for the SM8650-QRD board

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b07cac2e5bc8..dc91f0bf4b8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -766,6 +766,14 @@ &ipa {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8650/gen70900_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio21";

-- 
2.34.1


