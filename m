Return-Path: <linux-kernel+bounces-14035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5DA821734
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F20C1C211D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42EDF58;
	Tue,  2 Jan 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNUS3XLL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148853AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6254721e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172653; x=1704777453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRqt3ZzIel64XE8zlPb5w62A2IcZcIlXsUrklYtxqag=;
        b=pNUS3XLLiHh+03Ate4wPvBp+u4Iz5EvQegfQxew+DNMg9oOAD3oDt5WhYrgc/wpzuW
         e7NFbtO2A3iQwkohUnPu8AupeM14kO7nNDczr8WRD64KHjANp7tkIoOGHbDZj3FDy4Xo
         LUKc1wZmpxjd0NAJACa8VyxyT4MA41KvwsiYjGhjH9EVxpwxNg+UafCfX26VM3FjgA3a
         QQSjmpR9FND+RFA4FheDYCbPqsMSAy/744fKsEm3d/DQCHE6l5J4ZlOBIIeUDTI7UgML
         CdzmZUlLObeaSn9fOI04abl+pBqVCZY45k9j2MeqYEzkD6vNmQj3ZPu3TB2+Pjv6Jtvi
         s4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172653; x=1704777453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRqt3ZzIel64XE8zlPb5w62A2IcZcIlXsUrklYtxqag=;
        b=w58GUlfu/aYgwA3y5vrxDOVIPkZmTt8/3EjRC70FBbOyfXDq1drillj9DFOGZcPBYY
         Xc9c7pXiAtE84U1pO2uH+c6VPF+E8nXuFhwAupfuiNaxxsB8v1PO/nuhC5piGdOx5CiA
         qUL64bv6GWzQ5r8poxX/T9FkCkcckKMdBfPhMN36pkNekgoddHjvpv4rNO91PoTddahj
         zRN3b/2jWm4KYJHHIu8q2EYHnFyxUjjbMSfBojmDMBwzOSuFSiM+I1GwX20z+3ORrIkM
         ggsXddoBMHR3Jrgz6rlJIy0D8gCQarbyCbsHHi2DKWEl3oM7YMXFj36Qc8vg2BRfdZSL
         Rucw==
X-Gm-Message-State: AOJu0YwzQS2jFe71027R8d9zyKX2IbL0m6lobfAzU0vzS37PsCWX3HGp
	Dz2qHtMXTqgU9qOaQi/f8bsvtxhhvDds9A==
X-Google-Smtp-Source: AGHT+IF8QKsrOuPXdlU1F2iwn1E6ijdlCbufKNCxRYX745NBE1GkRSHF3QajJrzS0oVZX5BU6znRNw==
X-Received: by 2002:a05:6512:2352:b0:50e:80d3:b559 with SMTP id p18-20020a056512235200b0050e80d3b559mr4413633lfu.45.1704172653130;
        Mon, 01 Jan 2024 21:17:33 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:28 +0200
Subject: [PATCH v7 08/22] ARM: dts: qcom: msm8960: use SoC-specific
 compatibles for SAW2 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-8-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=E/5jXH5aENk4VUb+Qa3GlUcJJdi0cLtkCh52Lv9dMs8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+rkOSnFPMc2m8iuvN348aWWbeRyn39fenW/unwWLjyp4
 9VVPyO5k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT6bVm/x8yNT+PKy3c95yy
 d7vM/QPCcb5hU99Z1waJLTet68oyFNsvskvuWnr57keOrFnpLv1dzJPVg+v33ayY+2NrQzNjppj
 cP15r5lyNdY3JW16vv7myYdH2P882rYhdMoXRoPeHjZaD3ysvj5+LtSd1RZTN5Z0695LgjoLJzh
 vu+XALPORX7fQS7Qh49G3e081pVxW+hNVM8+avllbZ+PzE3QsbHnOfsbhy90hsxovIu54fk/fP/
 hK3WfdXrfSqdXfEjZextUp71Eg6J/lObuTRuJf97pmY9n9NhhvG6SoCQdkci970CqnueCDwha1I
 oDigPynS7PaijZ8Kn7DGL3adxrPwcylLDYP9rXthrl+LAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no such thing as a generic 'SAW2' device. Use device-specific
compatible strings to describe the SAW2 devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index f420740e068e..5099a161f7f9 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -221,13 +221,13 @@ acc1: clock-controller@2098000 {
 		};
 
 		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,msm8960-saw2-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
 		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,msm8960-saw2-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};

-- 
2.39.2


