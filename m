Return-Path: <linux-kernel+bounces-14034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C3821735
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD69282173
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19ADF61;
	Tue,  2 Jan 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQxyMkdo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B93D7F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so6900913e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172652; x=1704777452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvxKHQ7yTMefDm/HiqFwrhRsyS9CpyvAYzuZoPzniBQ=;
        b=HQxyMkdoQgdmpUUwzkc6OUTLWskg8PWdGpx6KzpNejPkhib1xYQ3W4yIQmj5VFYRog
         Y6iW3y3ycp0u888YP3BYqzFOQiFFGS4nzs4lk7AQGEQWxfCliQkclyJOLRrh+5H0KfLS
         XpPB7teSVHKJuFc8lVUc306X8HT2fZnHK5YFm+sJd3u52G4AqJFj0Ho73OLKwm2g4rC3
         VWzzuwQHsWFMiYv/bxQyGtiHP82Jmz8kkT5aA5CAyy+Z6YYJiGircXkz42XPgKmS1RcT
         q7dQhJASNmRmEg7rr1fmUQYeoqonptekhPZtHvzAv1RcRvWLYoGXpzRosYJ8lUkv88qE
         BuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172652; x=1704777452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvxKHQ7yTMefDm/HiqFwrhRsyS9CpyvAYzuZoPzniBQ=;
        b=aDY2SeZCOtCpgPXAj3gqMK1Up94tLHD0Zhy4D8LDQ14i4sSpvyW9+8EbVmvW/SgS8n
         jAEWSWZwB9T1+gLIpHzysK23gFVdXjU9+D3WPTpNC64LqCMhGXMXi+dmxvholABPtSg2
         dDQRO9s7F3/w/YvEQy5CjMaeChQWvnS4aPopo5ABzLXW4+WZ2lEf9n33Ahcugbx7leif
         YCJcmbWC1UQpeGkGnVT81pIzm1h8dc7Owk+/aRCu5uElY7dDyUI8nB1qCu242zK3FKWz
         uN3er7CVH9BdyAkpEjraDTBSjmn5d9+oCIXD5nvuqUzNk5f8rMtAqUwCExuTySUqS38I
         uCug==
X-Gm-Message-State: AOJu0YzY6UysJt7AEXKaGOAYnAQsNs184nRRp2jjixrLG4wkpXaJlG4h
	0FJePtbzZMa26EqYdDj63Ocubno2yedlMw==
X-Google-Smtp-Source: AGHT+IE0MAaDmAUfIpozSDGED6dvvgDQvsW1NnsylxUiX13Nomm3Fjel4MtBeQWcob3qWGwzI7WGqw==
X-Received: by 2002:a05:6512:618:b0:50e:7726:b6fc with SMTP id b24-20020a056512061800b0050e7726b6fcmr5930928lfe.26.1704172652557;
        Mon, 01 Jan 2024 21:17:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:27 +0200
Subject: [PATCH v7 07/22] ARM: dts: qcom: msm8974: use new compat string
 for L2 SAW2 unit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-7-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=803;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pmIu5TYOl3IwC9gUW2kxosa786wiXd+/rlhe+KqO8e4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xkwid7GSuPth3cnNTJqkzYx/GuVnWx6AIFC
 bVT32AkF3KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZAAKCRCLPIo+Aiko
 1V2OB/0Rai3tIFjdeHCvo1KFqH8foCCgy01J0Y2GdcOwXSEqJsoN1YLsHcd+ogkuIGcvOhDRWKA
 7tu/w/0FWHCOeNHt+hOsFud3qQCwq6iAO+SLsVJSNgFP7gCsM+Ow1JNk6+FS7OTzu+ANDmMTvvu
 uX5AtNQE8zCGQ82Es5955bV+hXz7U+3g4XtGUWhCH8Lw0UL35urLWuq9rat8agbCcEMcZohG3+s
 lGc2hVVq5GrhNHcfdC/eEs/Py/q1QQ2g27Beiql+tGRoXgZhBYRMB488WSLS7fUE+81ZXrn0Vv2
 LOCVYjtxWq72AISgMxdwIyLGMO0xyW25eSB7IU6pL4AegJ2z
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add SoC-specific compatibility strings to the L2 SAW2 unit. This is is
to distinguish the SAW2 units related to L2 cache and the CPU cores.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index b1413983787c..16ee0baac27c 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -347,7 +347,7 @@ apcs: syscon@f9011000 {
 		};
 
 		saw_l2: power-controller@f9012000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,msm8974-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
 		};

-- 
2.39.2


