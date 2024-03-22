Return-Path: <linux-kernel+bounces-111095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A8D8867D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072C01C237A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F91EA99;
	Fri, 22 Mar 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gGbdWSrH"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780419475
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094515; cv=none; b=Q8VCX6wZVXybw4RMWAh3INi4qCEEuAi3oGazBUZPMohOugp7kFjH/edtGIA0vEK5LbXFq6g1xEdoCQhMQPPITa2iwqUSsOlxeewuwtIbKCue1+1koDsQNHmeY7tV8rBHm1zXLcdJqKLVBis2ARIXnNyKr6gdC5oiFMkZ6/+r22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094515; c=relaxed/simple;
	bh=1MOPT1FDzvrdVxuX7nqt1W0QauAQ9Sdi8rEwG5YPz+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Itcj+C8wSY2dzpszt3Z1g2UjvsMGC9eczAIZZiIY0K/IeQWlpCTHXl46ZFviqIqM7YdzGHFktfFw/d2zW6qRM87dwInZzlB/zzAktT0IoALHLYoM9QY3rwACicE7Tk8N8CEUtzYXpv9Wa4ZHtmxLn+OvXKvO8UPxsA0ntUBm6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gGbdWSrH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bb22ff7baso2042602a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711094511; x=1711699311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGIiCG9uUSZYTiXZoy1kgHnKMJgJXQ5MQQFb+SBtz4I=;
        b=gGbdWSrHBvFbt10i0P7IS3YcfHMgFZ22iqvbPM1bKzprynfhbALYb8pKApd0TrOCw8
         QHdU/J/LK3Cn/nyTlRl63owpMWZilaGzuOkb5w9XRs0Al3S1UTwaLdtqYXxH+AiJoiWz
         l5wc4HcwzGpAfzfYc+kVeLVqGVcPgXVkZpvCW3Ba10L5Zhin82Laf5bU2DznezpLZK2m
         XWxXbCffdqyFwdKJtyZygp6y6IbAxco/TVY/AvY56xu5SQ3C2zHIfNCeDuypQSQGpfrh
         eTK8D960FLMhLXuKT2Fg3HJkbJafhs0rVrTsgTpNJe49W21patTQPM4ictDqOMwDTWdz
         PP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094511; x=1711699311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGIiCG9uUSZYTiXZoy1kgHnKMJgJXQ5MQQFb+SBtz4I=;
        b=WVFVUNYx5tO3QVGidIBA20ZPW6bxW6DRSuHHK0byehSl8xq4yTAzludDfQT9vw83lm
         DXaKqWfYAHM2d1dtbcQEZ5ALcMeQdukLGRjkDNml/8zMye2UQ/XndadMw1NEapzCRw/J
         DGnO830O5urZx3LMJxJMkFBwqUlfR/YHETX0P68HYtKYXZjei9FdWw4aEfsCk3F3RVPX
         u73iu3ua5VriUNqaCGw8T8bDlE673oLtkDhJ+oBECwwaSy0MLh8a8f5XASbrTpm2uVZo
         C50ehsPryCqFVlUa42UBOd+weWwwpy1KQsX57LQdd2Sx9RW4Z65IDa3m3L8dVCvTAlJ6
         lLEw==
X-Forwarded-Encrypted: i=1; AJvYcCWsRDcZwpeKLNWiZZQmhXdx1YObsukhhmFCrbWdwRFJ9/2bWVWJKK21ItHQ5MTXUdXfDXrXg0E/l8/xmXyMScNjy7N7BwCKa1GRhtcW
X-Gm-Message-State: AOJu0YxMt5KeqmKCr8Y7Q1rLLnCxCn0sDXA05NOyfPllujfPfJglsaQe
	49dXLojS18fv0VAPMVwT2PlYG//uL7raUtyI1cm5Brxf8R8HpLguMyYptQUEDK4=
X-Google-Smtp-Source: AGHT+IG+nqdXI1/DerUy6fqVXgv4lX8l13RIVM/mybWFdH566c+9/IDCR+8S/cgY0yZTIa+l3tOfow==
X-Received: by 2002:a50:9318:0:b0:56a:fbe9:80a4 with SMTP id m24-20020a509318000000b0056afbe980a4mr953720eda.1.1711094511149;
        Fri, 22 Mar 2024 01:01:51 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id p29-20020a056402501d00b00568c613570dsm739889eda.79.2024.03.22.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:01:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 22 Mar 2024 09:01:34 +0100
Subject: [PATCH 3/5] arm64: dts: qcom: pm7250b: Add node for PMIC VBUS
 booster
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-fp4-tcpm-v1-3-c5644099d57b@fairphone.com>
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
In-Reply-To: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add the required DTS node for the USB VBUS output regulator, which is
available on PM7250B. This will provide the VBUS source to connected
peripherals.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 3bf7cf5d1700..91a046b3529c 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -45,6 +45,12 @@ pmic@PM7250B_SID {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm7250b_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm7250b-vbus-reg", "qcom,pm8150b-vbus-reg";
+			status = "disabled";
+			reg = <0x1100>;
+		};
+
 		pm7250b_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;

-- 
2.44.0


