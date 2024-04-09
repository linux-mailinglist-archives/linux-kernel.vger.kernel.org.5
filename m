Return-Path: <linux-kernel+bounces-137088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D989DC3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD40B277AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB30130AC9;
	Tue,  9 Apr 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b00NEVLk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CC12FF6D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672898; cv=none; b=rHxIzw61WQ80nA6Ggjs9yzoo8Ucvbr+bSqUyo0Dub2QkUr8nLfhJ7GM3oo1HnhXPqJs3FAtTEE/7kpsdJmD9PCj4dtov99Eb4FMSsSF7byGGv1o2t0xPqIx7ydAdrB+zPFJVfVGhZlT1y0XLW2WecXynP8NQdlWAJjR0XmnXAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672898; c=relaxed/simple;
	bh=ACDX9UzrbGqFhCF5KLJs22fVKRsQhdGkigM5kxbDOXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbIdPEemYT0FAQVPKrhO6j9bpkY94Ww3Dr5kd47qcJsk78yU3+QE7hYX3ewMJdzCiYEZ4MRYRv8guOnkSokSSSqn27U6cmkEgZYIvmkUgwlbC6rj2K2rHBMckxyFoZ2sK8JtFDALqmZsWoO5XoQqOis1S+ZgHN2XKgzZ9RCoXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b00NEVLk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d6898bebso4579660e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712672895; x=1713277695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8fT6Gbci0qUXzI+tVhQnGd6IaJYXtCzzGcVOEtNpI0=;
        b=b00NEVLkoTIZXqUybZvAhG+dGeOYvNhKMbH0TtEiSl53o++fnz0f+l7FeI4GSr/Tin
         P3eDRRdwAdpgDvaLY6covNFIHSYwInk8yxyzfpdhUcVSoZGzXkP8WOXiZPNJ9gL81t+C
         s76bh4v0ji77iX8lFm+8L+Zy6ULv64iqYkdSRkqsSG7TyGjnMadf5vIMA6ocLVtozBhH
         MMRap2T3DivoInEyegNXn0IpNDKubSEoK6oTsPZ5kk47bY3aiFNWPPTOmZBEK1Baeeqt
         aRvemSeWDAzKH5uhFWHM2TcU6yxIUgxPQuNY6kAQv8S9us3udN06BeK/EVBta5mSygCM
         Q7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672895; x=1713277695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8fT6Gbci0qUXzI+tVhQnGd6IaJYXtCzzGcVOEtNpI0=;
        b=Myg2lVhIHHNkK5/sPCxKgwK/ugMvlTQE+IGdYyHaBYt2g7T26gUjcVp/92Z5O4uRT6
         wD/jzZrEKiFAV6A5mLSoi7JIhxehuGaG8rqoAKtVY19XsWV9gLj5tk4UwdnFVDQzjgka
         CpU0/NqzHHwH7u3ayTX+YcZeTvLcJ+ialEByEE2DbTZ4wqM+Xrzw7r2/4a2vLDjeg6RV
         J4aAWWdXV2CdKz4L7U0aVvptxj8342YuiTww+6DKfh5I89IvPG5ca+8E0lE4uO0DfAMR
         5sWBiimM3oYb0EO7nlkm03V7hNe8N+fVSO/U5cu9cKrIO4VK5QQm42dyLTRZxunaaPsr
         d6WA==
X-Forwarded-Encrypted: i=1; AJvYcCWbENXoGuikZ9I++p+BqtpTRzc7RL2xyX8GNZvbMs/tIQM/8CvaNw8rmHmC8unM4VEsGcQRCKAt0oyW7dvz9v52swY5FJAvDZOLlRdh
X-Gm-Message-State: AOJu0YwrJ7crRXw5pum1Ztt5QiBntIZ+r+aUHeCwcwUl7P8e3iOqVCSn
	qqjR0ox3a8et+Yxx7wu+i3EYaft3mROSBQJfeMSdgrm/f8hWs9UjG1usBGj+CrD4HHRkCfGB2Jm
	A
X-Google-Smtp-Source: AGHT+IGITIwImEW2zltg6RTXxolJ2rtoEuVPzoBWkiSPl89rR2v/kj6uF2HvIdbwn3nbkNn7zhovZg==
X-Received: by 2002:a05:6512:285:b0:516:d18b:eaea with SMTP id j5-20020a056512028500b00516d18beaeamr7983546lfp.33.1712672894899;
        Tue, 09 Apr 2024 07:28:14 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d9-20020ac25ec9000000b00515d2ee5b38sm1556445lfq.48.2024.04.09.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:28:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 09 Apr 2024 17:28:12 +0300
Subject: [PATCH v2 2/5] arm64: dts: qcom: sm8350-hdk: add USB-C orientation
 GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-hdk-orientation-gpios-v2-2-658efd993987@linaro.org>
References: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
In-Reply-To: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ACDX9UzrbGqFhCF5KLJs22fVKRsQhdGkigM5kxbDOXk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmFVB7LGeXYvrK8yYmSPjaIGLwuhFfCw7FVXIL+
 cMNdx6kSWaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhVQewAKCRCLPIo+Aiko
 1ayzCACyrw2N7/mf9JOXuNP8ytbCVF+e8OpkkKq0CfXVElwFE/jYRl15DsgLAqsCQqyL6lq1olI
 lzOI9mN1MDvm68tCfvl4/GXM68dXiRxxKBAEuPR8XStIQ8Yfp0Joxa+3ml5TpvgNe+214lkB6oh
 hM52PisZYvflOh32UQ3VTuUBDFJnItPpggecVLUbS58P/cJgbMY7Uc6ZbnbyD9h9kWKiwVefCDr
 jFDurdRqoGMzAS34RidseiOlyvn9wx3FpKYP0FCmEBVTVNIu52NAG/Qlk9Zc5Mqh+rwxnSEm+lB
 8wIEMeuwWCQ6f9Wb616EnwQrl7dVxQxplJn4X7/uFXbvyVgf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define the USB-C orientation GPIO so that the USB-C port orientation is
known without having to resort to the altmode notifications.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index b43d264ed42b..4c25ab2f5670 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -42,6 +42,7 @@ pmic-glink {
 		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";

-- 
2.39.2


