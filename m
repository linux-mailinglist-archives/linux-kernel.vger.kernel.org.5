Return-Path: <linux-kernel+bounces-107794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4708801BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39F8B236B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA984A53;
	Tue, 19 Mar 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoVgTN7g"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B883CBE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864833; cv=none; b=kLuo8RgkQrQsF85N5/zWxbctKLSrO2SEImNHtMOYysovG6XE9xWsl+TE/R0/lVDO7kw+9Hmj/Jiu2zvP90BjhR1ITj+NJpfvyhyO+orKYcyeDwg/JvRgfbJcv/YWgoRgXHShqKsuWfag/Pt+HLB5xWgxRcWcBe8GM5jWJzdgnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864833; c=relaxed/simple;
	bh=u2xT7Esby1J3RKYeYjNslw3blgBjT8SrllnP1vANh1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W92f2i0T7wBE/KQEfAJPYM7MPgKCftAMY9sfzswFrt0NVV2dFTb04CQARQm4R0ehJmUi5rCDwPPVNzdxXY0E6XwgBnz69my4NfJ/EFhox9fgff+6GszKDYSb+OGUzFkVgY0CDrms2KA/Oq5jtuGM3vn6qSmOcmPh1Xx3yDX1Ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PoVgTN7g; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e6777af4so4509895e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864830; x=1711469630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s72ROV1TY9FQ/rR1vBGeAP8Yy4vPnMBh3DjvW5n6Dc=;
        b=PoVgTN7gLvPTvkmKiGX8HGjMFMT16ZNOqLfHC5SogxN5vRvcElJFfXtfKetMUlhPhR
         HFX8/e1BUsqVHoGrFUBqEWGuZueeWmgsGUnAOHJJeUK9N5/6RoVlQtF1Hy+/LP8CxWWI
         qJRBH6WRd6dXGELE+g+/93nOEDAqOA3OGxr1LGn9b93scTkInp1iCXNcTD50KdvlkXpK
         0kIKwergdnwcPwpEV6v22gxZNZSuEfeD+X0xsUIlnevN+zvajk6pkH2FbEZFmUczkgac
         i+fR0wn6O4u9T5Tp8T9LpHqVool7TdO2JG5UPWMmsR9J9RRo+kELX9msL6BeDeqWVkdD
         iU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864830; x=1711469630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s72ROV1TY9FQ/rR1vBGeAP8Yy4vPnMBh3DjvW5n6Dc=;
        b=cWoDCFVoJyPGO4jjxnijCgbuwnvA9hQzmKMF6FZKm1e/L3nYF2Lg4A/ehJaMMjrWWf
         Pssch88tO8WVHG9sW7JPDvZ2Tm5p2PNFwBq4w5ylL1L89eBUEzO5ZBnrzDQkoaujuyNs
         FcEfJzoyLgB0fUYKPJtzRS6OpQWx1zo8us1y+96tCTcND0qjdFpgbqEt4AxBGN5l9MiX
         HIQqEa/KR5fD6LoMoe5P3pInn8RPS6L7G6W1hUYrJU0bHB+K0CYzVOlhVh3kP3y85MGS
         wFJnmPnEY8XYcpbaO+nOyPVrrOY/cIv1Igw02ZO5vRtPAee2FjVnCWIs+JMP3Es3o+3K
         7c9g==
X-Forwarded-Encrypted: i=1; AJvYcCWtT1AVVC7gv5WTUjBP5z6nuR5uYkwoy5hXRQvDl7npTJUkzYpJ9jxKeWWg0c7VfJou5yDGWkcETlYNQOH3e3WDEav/gGdmkn9oH2Rp
X-Gm-Message-State: AOJu0Yx5YTvTRfjERm8HZqNrSJOXUQtUuWiPO28kdUXgtsXIMwwILdXp
	ejRJri33onQQLZn9ZAjgLIg/1+kglk+nPXuqg9L54/aRmsgttpekJqXmvTTfraw=
X-Google-Smtp-Source: AGHT+IG2XU3dXTL/HMZ0wjyShkm3yq6aj6ltXYMlCGV82MQ6syYCRqDz2EHkP3M7StASoKKBNwcBjQ==
X-Received: by 2002:a19:8c56:0:b0:515:7686:6068 with SMTP id i22-20020a198c56000000b0051576866068mr1917610lfj.55.1710864830033;
        Tue, 19 Mar 2024 09:13:50 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:41 +0100
Subject: [PATCH 11/31] arm64: dts: qcom: pms405: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-11-e0aee1dbcd78@linaro.org>
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 461ad97032f7..afa3bb469870 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -11,9 +11,6 @@
 / {
 	thermal-zones {
 		pms405-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
 			thermal-sensors = <&pms405_temp>;
 
 			trips {

-- 
2.40.1


