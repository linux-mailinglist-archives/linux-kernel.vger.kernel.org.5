Return-Path: <linux-kernel+bounces-139916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F698A091D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93A6282D85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E513DDC3;
	Thu, 11 Apr 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vfw7bfqh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F013DDDB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819177; cv=none; b=aCtyfc5B7jrcmUIgmPcMeTzuZMxfXhxPPtWy0430LLGr9lp5kS3zjitA07ojH/hIWbHUU1UQOs+DK5u9tyelM6MnD7xalgtVpH3MC0knp2WrXQJB3ewXHWLidPtraIkXvElE/fGTnccwOJanWTTHNEBGcHblMKCVLfNgBnloRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819177; c=relaxed/simple;
	bh=+o7I+daoENcP8Ct9wXBNksspsxmRSv7JiVNJMZWs3cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J4P++qdJBH5mcCUlmuId1BNWbx7nockZD2h9cVt1UefucrfmCEfDpLG+o4Kz3LXlTEixOVKZsUCMbWZBvFHccLcDlldhPAyydb3oNXHDZgvvrdFhv3m00AieS1GrfgkP3v/bMe0U0PK21Umon9fdrszAxfUH+WCflkwcNIj299c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vfw7bfqh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a52140ea1b5so157545266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712819174; x=1713423974; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPHgQp5i5ObZBE7aupcoMPs0PyMl+eJyHyekbE5zlXs=;
        b=vfw7bfqhq2me01f9pYWrujssM0ZpdqY2OyNMTHWnZ0602bCm7OXPJKfa+i9quNpHx+
         ndSMFzW9qXDgd9oBU7FO+WWBsRfv8uVr8Pdrq9/R61rPf7sa61iH3hon1qeKA93U6i8W
         UstI8UQvbLAQUu34OrBWYDi8Djs2CU06MHVTfODGEPa6YsjZ9W6c5ydDX3n2SxHqH29E
         Pz1SO2Uurev7cyiNbtqGeGXWGCBS83l53y0WDfLZfU+9CkcETX1W8nBll8pz+WqbRh4i
         NAeidYSVWmgXy3kx6EHugal5bU7TXZO47mbZDsjv/RNVAA0G383+vabVEdrGFfpPZmFM
         VAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819174; x=1713423974;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPHgQp5i5ObZBE7aupcoMPs0PyMl+eJyHyekbE5zlXs=;
        b=bmamqZYxYunfddMtD6182htS22yulvni6KnPpvUKkPpjVQ37INsktOSLrLDrGoMeI9
         SiiLfF/3iGnVEO2cxqoJX+S8XuBSUHMJFFby3591ezOJzCM/WfKydX+Xv7hDGiXendIt
         B2b8wBlF6NubLT1BispTG9GdYa0fc3ymcUOQfr0Cs+kKn1T9jDii1m/Y3gPbDR4f1Kmi
         Zl1ZGUF0GU9HE5l1jJnl8kTlB01BXji6/Cw4s2iRDnvlWbBxECL4erZyEfED42/uDuLE
         +CGJXmZmuGVEZ8elwG4exQBqz/CcZT/JbR0opZ91emQ+AbsNVlgvkaJ2Oe9UB/0vnHzZ
         CqmA==
X-Forwarded-Encrypted: i=1; AJvYcCVqQEnkPdr/NwwGPhh/83AdMGimR7dbOGEwqeDrmS1mHVBk9DFViyJDe3bMW5l33yv7wRkHrNEX3I4Mr2QLVfke1OgyZbC5YSyYXM27
X-Gm-Message-State: AOJu0YzE28lWdNwmyIidPpHTDfULe0CcmGexRkRGoD2Oqp1+lxlzSTBn
	oen5Byyv0Kcij3K/jjVUDXxV7R9ZZGizlgHV8+5y0dPu3KI81l/B4wzRuA/UtKE=
X-Google-Smtp-Source: AGHT+IFwO1V0PB5oOIQfGSzjLElMTnZJSoZTIjXmfOa0FvKysbniFvJxcp6z+3c0bN4piGw2hz2Bbw==
X-Received: by 2002:a17:906:ee87:b0:a51:962d:cf0d with SMTP id wt7-20020a170906ee8700b00a51962dcf0dmr3622218ejb.12.1712819174137;
        Thu, 11 Apr 2024 00:06:14 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170907940500b00a518b14d6cesm461397ejc.172.2024.04.11.00.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 11 Apr 2024 09:06:11 +0200
Subject: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add USB-C
 orientation GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-fp5-usb-c-gpio-v1-1-78f11deb940a@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAOKLF2YC/x3MQQqAIBBA0avErBtQMYKuEi1MR5uNilIE4t2Tl
 m/xf4NKhanCNjUo9HDlFAfkPIG9TAyE7IZBCaWFlhJ9XvCuJ1oMmRMa75RatTTOOhhRLuT5/Yf
 70fsHiFICB2AAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Define the USB-C orientation GPIOs so that the USB-C ports orientation
is known without having to resort to the altmode notifications.

On PCB level this is the signal from PM7250B (pin CC_OUT) which is
called USB_PHY_PS.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Depends on (for bindings): https://lore.kernel.org/linux-arm-msm/20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org/
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 4ff9fc24e50e..f3432701945f 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -77,6 +77,8 @@ pmic-glink {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		orientation-gpios = <&tlmm 140 GPIO_ACTIVE_HIGH>;
+
 		connector@0 {
 			compatible = "usb-c-connector";
 			reg = <0>;

---
base-commit: 65b0418f6e86eef0f62fc053fb3622fbaa3e506e
change-id: 20240411-fp5-usb-c-gpio-afd22741adcd

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


