Return-Path: <linux-kernel+bounces-96191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6A875850
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C02820B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBB13A88C;
	Thu,  7 Mar 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7zKGP3L"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AD139586
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843202; cv=none; b=axgUrZNqX4RH6EKGcgySBfiGbR6mYzD5pxVK7CuFlyOPfeOVGViZLOHnHDfxpcSBlpGSSLV2aeJhGMr1mr90BswTkTAt4P9r1h0h1ow/vWdH0OiCw2TXFvTTKWyTQJax37UCpeaWFddRkp6RTLLCtk/OdbA8Hbw6E3zIHMJA9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843202; c=relaxed/simple;
	bh=X88G2FAej3PmBxt17XiJ31e6Y+NzBpD9H6c5ItuxDfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfZSNq4xI6bx5y6hwURyB5Zm2ttTWhGvN0+Ms1m4haqwW4Bo0D0ZioD27Xsg8COUUxf9CpOibfIgB9aAh6pZAz63PkBgDw2T/wpvEGWQYxgH/oK4WAIU9rsUfNbPkoj78CX+rkso+4txSWOtj3CSeM7TMKpFDx6ie5KCmoUSaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7zKGP3L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51326436876so1684293e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709843198; x=1710447998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0TmD/+bSNy0i2UXEWLDDUBW107WaHdsG6ntcrYPB/o=;
        b=W7zKGP3LC9G69hKkd/7kuI6jz51k+/9db5BGRXp6Y+ypdQLjNeCzaN7HMr7trFMCon
         A7e2PyKsqCVoYN1iYlnAycKv+GWZ3cG/6nsEL3YHB6WBHUhDJW13jUZKDIIU1GfqUXCY
         SR+Til0b2L6jFHPlClTruir53KvpjTdM8lJh2YqVJ7hanDOcicoOZ79CwyCYD4XSbybd
         xDDFCzbVFYMYkN6P3o6KNxCF4hq3gxDuYGRsUm5N4zuWACV64yPL6Wc9S1HZaKxU51rA
         ifKRmMQpS6d6EPPKhZb+dxVWUwF2S7PTnbaUVg99OA5tH00cyT4xujDic0HWy0XHnJgD
         9x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843198; x=1710447998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0TmD/+bSNy0i2UXEWLDDUBW107WaHdsG6ntcrYPB/o=;
        b=Da73aVh3xOFB4XU6B8gybRv43gSUQ7n1IUWjQcxc74nKV1sXDQOYeVnL4UAdp+EWhv
         oNtecVCzjRQxdpsud2kLo/dalR7+rh4WDZX9Ij1k5XESHmXrkR4Wtlab/yR8q/vnx7yJ
         Z9HjTlzBiAA1ROnUv+JmtOVD03b0F2gXKrot2q8WU4wRA6vtaFSPL9I9VcgXduc/LbP5
         csZRnJmxeWc8S5Gk73x/mKg7ELA7ZABO2QZ8ptI5EQWrQpSl31GPKw9v4cfDpwvmOfZk
         tExSwSYQZh57hXjbV8DP2eaFqZnaKLCC9IrhPe1B4RGtakXHbxEOBAbTaSk7Js67M5kv
         d74Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGdbNMf6ALfFV88nF4PJGrAujgWoNxzVvt+8WhPWaKLmwREhg1u0X+bfFtUE+Iaebt+0AiUj5ZnYS6DDwvHTz3G6nNjPaMNoU2v6BL
X-Gm-Message-State: AOJu0YzDa9BFCig8+Q4udiokMOL8nIiA8pOt6zNVf0xjHoZrNVL6bPNv
	5AsCCZnNagjY+6tKMk01JofeE54Asg4o+Kj7wswyraeoIilUTcCLthYmQk5aOyAyVID8GWhcQE+
	I4Rc=
X-Google-Smtp-Source: AGHT+IFINYOtVbitN2J3giG8Mx1gVJS/NaU4sqF7A7hzGW4ucQRrUCd9XIEIiyCE+MA0IkaSmGz/PA==
X-Received: by 2002:a19:8c08:0:b0:512:dfa1:6a1c with SMTP id o8-20020a198c08000000b00512dfa16a1cmr2167169lfd.10.1709843198424;
        Thu, 07 Mar 2024 12:26:38 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id dw20-20020a0565122c9400b005132bf9f8dcsm2957606lfb.303.2024.03.07.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:26:37 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 07 Mar 2024 21:25:56 +0100
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Add PS_HOLD restart
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-topic-8280_nodes-v1-3-4eba20e08902@linaro.org>
References: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
In-Reply-To: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

Killing the platform with a single write and no firmware involvement is
pretty cool, add support for it.

Note that due to restart notifier priority settings, PSCI reset will
be used instead, unless:

a) PSCI is not exposed by the firmware (e.g. because the fw was replaced)
or
b) PSCI restart fails for some reason

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a3725d917bef..44c8d543eb67 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4460,6 +4460,11 @@ tsens0: thermal-sensor@c263000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		restart@c264000 {
+			compatible = "qcom,pshold";
+			reg = <0 0x0c264000 0 0x4>;
+		};
+
 		tsens1: thermal-sensor@c265000 {
 			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */

-- 
2.40.1


