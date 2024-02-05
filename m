Return-Path: <linux-kernel+bounces-52348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8D849702
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E3A1F21BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8413AE0;
	Mon,  5 Feb 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="EED3qQBk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033A12B9E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126707; cv=none; b=C+LF91L7uApzlMhxFVRx/L7RWRJAPx7YbTriW2AVbHUTvL0n4b5USxScTicKXBdPJOtKp/6kKK+SbYtvTKqzA5wH8qwDYo1kC8rt3EtVJeflybiVzmfCdhC8jiuRYiX7+yMY1QiTQSd5YZ+9IudxE6Au/nVBTHHW6Ab1wVCcQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126707; c=relaxed/simple;
	bh=9bGVx9AV/PBRbHF4o3RcG6Ql1qXpfJutE075Jdi21Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptr9+tekCxA7nxlN6eREdrQ9eb8Ull8N9EEHG/PXE0N5VqCB6j58ygYbuAyu9lUckQYvZULmRQBvKTmHzNOPCenm0SUpF2JvB1Vf0DH22NHPyA38vwgj5bMZpdFhhF8GmWdPuBxWgYIquoCBVRGtyceJgsAx6dkw0ZI0qkdpllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=EED3qQBk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd6c24812so8921025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707126704; x=1707731504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHaHZotC246BZzqrce6ngZLliQyoyTygfMXxTOkSCN4=;
        b=EED3qQBkFDhjaHlZjm2D8ZJXfBRWMBpBUqdsxX6CV5ZjiS9lYZxhIo8vKxNR9E8fC7
         kNBcpUIFBPOtWD2oQpXb5vslUNFlNYbGVxuOJ7wIC7bsBqjWvOGyz5KZhRWjoVuV1jHL
         Ku+BNXDmmSJGTM6ygD4v2JNen0Npts04anQCptktkyn0i0n5uYIerfXruo1mSFFkv8hM
         rpwIVhoAccTQaxTaat+YWYIwDF61dh4AjukNzfpM9lDm+oMD975eocFsZiyhj4CxAG4V
         Ri9dxG+HfOAiWOP6w0mVnVnyMvv7xGSaM73cgQ8/44fWp/HzMZyap6NeYXzajdNUV6sY
         42Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126704; x=1707731504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHaHZotC246BZzqrce6ngZLliQyoyTygfMXxTOkSCN4=;
        b=FrMQtSHCmhEfhx21YSLwZQMh1HI8uzUnLgy0jfGC/yDO4fYWGqo/tZiyMZtsn4zEJF
         bpC7R9NAnnqBQ4i+dUAbVuPnu0GOZNIAjT5IaQxRlWDWlB2j+Vi1lg4zMbwri8oWZKLW
         0EU62QoymSdCl95UKqU0ICfWLaJ5sUHhmwGUXIu+BQTyqETKKx2vOnZT41m3tOwafhku
         7NCLpwUDnCapH6Bre5yW8CFE/16G1eCP/KOCUALLXCdcW/73XjsMwhVvqnjvfqsojLgz
         8QJiuqcrG+29GTsF6PJm/Il7/FVA5tKFSR+Jvz1c3T4kJnhyK4EdcCm4/AFHPta1WQth
         MDzA==
X-Gm-Message-State: AOJu0YxABH5zCKBXP4aqMq/IxgmEHzl1mPAiJNdVOX7VCpfwJ9L3vTxp
	8JI3GurWHLvHPhRnLMhYGvIqAETUCENCskR6/tCric2VNAdnJ4m+u8xjZYLhpQ4UL6TM3ou03Gu
	6NyM=
X-Google-Smtp-Source: AGHT+IFpI9sY4oNvXm/hdgb7/0YwVV+MxYnIVZtcbqsvQB5pF8WoUoY/Brppzfu2fxPpfKuSpgl+5Q==
X-Received: by 2002:adf:db47:0:b0:33b:216d:70bc with SMTP id f7-20020adfdb47000000b0033b216d70bcmr5276935wrj.42.1707126704029;
        Mon, 05 Feb 2024 01:51:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVaac0Yl5gzH95FpnSRi+ll8mWpP8bKka43VgBuw3wvCBJzVlRN9fABjAwClnEvSy1kia1G3FnFbuvR4IrCMXCyukl4q/JobVe3RsQhmZHErU1JVspINy4F9DpPuYdjdpmymzC3hvG3Ontwa+nmPpYkKd/KtMsvV9gnjVQZ9mHh6zVTQ2WkDWbIY2B9NQrgIIarj5XMnDD9JsAF5PSkd0k7IDEsPv9t9nQCYcDFr4TpnoMyjf7w0Nb6eqqwEZBruRiYzZBiVZ+XBSFiLsvA+CaWaB5/DzYrTyGvSnEfyaYKCSFdU7oJNEhMa7hVr3QB7bdH7cvk1syvqGHtdCWidMddBC1qnQYyMsHXGrqWilY1bfxVYQv6EQhwQuWTYkDcdRHqDBgJVmItRztKlTClUKALsv2Jz+zu7mbU9ir/21hOnTkIgbQyvuCnNsS8ru3ls+akLwiJNTNa3Ct7ofkhq3uGQ6eDTQ0iQutUwPeuj3srXbtS0EulMjWW8MtZRbnWMGd4qAum7EtjXxeT34VeCOCMiUW+
Received: from otso.luca.vpn.lucaweiss.eu ([2a02:a03f:6aef:6800:2f37:ce90:b91c:e85a])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d400c000000b0033b3c2e73e2sm2278283wrp.113.2024.02.05.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:51:43 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 05 Feb 2024 10:51:39 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: pmi632: Add PBS client and use in
 LPG node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-pmi632-ppg-v1-2-e236c95a2099@fairphone.com>
References: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
In-Reply-To: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

With SDAM + PBS the LPG driver can configure the LED pattern in
hardware.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pmi632.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 4eb79e0ce40a..d2bb49a619d7 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -127,6 +127,11 @@ pmi632_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
+		pmi632_pbs_client3: pbs@7400 {
+			compatible = "qcom,pmi632-pbs", "qcom,pbs";
+			reg = <0x7400>;
+		};
+
 		pmi632_sdam_7: nvram@b600 {
 			compatible = "qcom,spmi-sdam";
 			reg = <0xb600>;
@@ -155,6 +160,10 @@ pmic@3 {
 		pmi632_lpg: pwm {
 			compatible = "qcom,pmi632-lpg";
 
+			nvmem = <&pmi632_sdam_7>;
+			nvmem-names = "lpg_chan_sdam";
+			qcom,pbs = <&pmi632_pbs_client3>;
+
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#pwm-cells = <2>;

-- 
2.43.0


