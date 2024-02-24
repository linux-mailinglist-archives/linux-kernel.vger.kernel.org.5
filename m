Return-Path: <linux-kernel+bounces-79896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060F862810
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85870B21524
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A94F5F8;
	Sat, 24 Feb 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a87XncPO"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C34D11B;
	Sat, 24 Feb 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815011; cv=none; b=mAo86svu2Plre85IRVR9Xz3l5pKMDDEdkYLRVTLanG3uq5WBQaGw1r3wXLoajskFurI7OfzhL8oj/P9ZuizL5kOhiGdid2aSIsU67ZnEmxewLs951/n0DovJH9nL6oHnIBo5TxrwTDLSzvAHkNwdR1VqkmIgrjtZNN8I2AVZBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815011; c=relaxed/simple;
	bh=31a5GEP8D1PpwdN5PyjwuEtq748f/aUOFXdtpk75vgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVQeDHBjm3Ix8P4SmgOMwXR7jPNta7f5RYESRQb+hCG2uJGoz4dIoAPQo/LnV+ZBr3RUEEX0Do95wksrIOH+RnuAOGT0M3W38bRsaD3RhVMeywGfHZe1y9YOgPyTiHQ1ItFm+xg41o2pq0FOEvwGS7FrIx44s+2hGhbhYQERm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a87XncPO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512ab55fde6so2124567e87.2;
        Sat, 24 Feb 2024 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708815008; x=1709419808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=a87XncPOeIjS02wB1SfpkarJoHcWvJWzmLVBNaCFTwrjNLXbEAKsrJ3Udqrd4SBDov
         aMLC3cAkOjQkE62NxQjonMO1hRyIvV0o+yRqpANZ5Dg6kQVrFefQXG1OWVLHkjGXOr9D
         jg1H8IFOfy6n+wx/Z4mSgOV2h8qmxQu/EYbkgsPXlZ/ubDXlqC4SqHdILSFq/kPD4ncw
         W5dSWZzckEmP4rO/cJ/q2ZtwzLWZnT24NijVNva6+wmTkO6FrxgHVSX8sZDVPifxnbSI
         C2+gajytSLgn36mcJnC+lnYoIBeALHu98V8KkzQhZ4eT1cpv9BN7onDXCfHOi9TT3BGT
         PnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708815008; x=1709419808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=v3P1n5Yv2AnkmG2QBY5UVCq7eUklR8o1TMris58x7NjOdsXMyCqYmiPp7kLArCo+Nd
         XrVMDIGlo2NCXY/ZvQ49BugiksBc55y41srVwrsO7/SBNwI1SmMOivhXAflkjPo+dnAf
         GcGtPxQV0m/A50vfe0zl3HorttfzNGrCnPXGo7wBVdkzq/lwLzgFa9acErBvc19WQdUc
         nu1vDfoXhABFOKbaYp1p6fLHJ3kkbaCljOUU7ABeYOwrctlxsOsXtBTGeZbASyapCq/N
         dxXuDR7Vn3pWG9K7fkSiGZKddwijG81Oe1VEUVKjrlNjrult9keyEJTCtCprS2kOKXYh
         aKVw==
X-Forwarded-Encrypted: i=1; AJvYcCUz/sWyle/YdrifmFHuqgsChcYcqJb9N7nQKOWiYSYtwYSlDAnhr1SELVM+oKeYOsIZNBweJlqbYYiPvSJYxERvvXyDP5irCgU+MRr8f9TwbS0o9UE0uMAOrxZMeIUd6cq2kXS05js/AiWsPzfIQVUuZ3LyKaJ7rb2xO2nGcbSz7PW3tHIyDZrYsy019aw6ue9iGrIBNsY3hd6SVn07+QptCThQ
X-Gm-Message-State: AOJu0YyuWs395pK9M/9C64l2vNFN7IimUX0dqCrcoPbnU02XgUWkFhUc
	aYdpCSZvEpBv1s+McXuBpZqCTJ629QhRCHs8r1+7Vah5EeLhU093
X-Google-Smtp-Source: AGHT+IHBzJLfQOY8i0MtTP644KdtkaI5a50DFXrhplfFOgTK/AsvwDWJYYu79HZD5D/Y98ywV4OcGA==
X-Received: by 2002:a05:6512:2210:b0:512:d81f:c22e with SMTP id h16-20020a056512221000b00512d81fc22emr2323567lfu.59.1708815007566;
        Sat, 24 Feb 2024 14:50:07 -0800 (PST)
Received: from unknown.netbird.cloud ([37.161.229.181])
        by smtp.googlemail.com with ESMTPSA id ti6-20020a170907c20600b00a431cc4bd3dsm145672ejc.182.2024.02.24.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:50:07 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: pmi8950: add pwm node
Date: Sat, 24 Feb 2024 23:49:51 +0100
Message-ID: <20240224224951.1357644-3-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224224951.1357644-1-morf3089@gmail.com>
References: <20240224224951.1357644-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This node is actually found on some msm8953 devices (xiaomi-mido) and
allows irled enablement

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 1029f3b1bb9a..b4822cb17a37 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -84,6 +84,14 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8950_pwm: pwm@b000 {
+			compatible = "qcom,pmi8950-pwm";
+			reg = <0xb000 0x100>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pmi8950_wled: leds@d800 {
 			compatible = "qcom,pmi8950-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.44.0


