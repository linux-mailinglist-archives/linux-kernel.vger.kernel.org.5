Return-Path: <linux-kernel+bounces-81235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB07C8672E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931B2B38AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AA1EB33;
	Mon, 26 Feb 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVJ7rE4m"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90901CD08;
	Mon, 26 Feb 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945102; cv=none; b=ZuXTAgj8UsqU483tb9oOOWFNSnafSEyU+YqYo6Ne/5FrmcTbvGEhkTEHjHRFS1UJJMigKRwKa9cE/jRlt2887gzR1gVZlfDUtyuWjWcu80+5n2g7gdWcNurSbZXgh/PSmxTEVDZ3XiJmhtIsJ1N0B9ddZwD870mIDfnp97YlfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945102; c=relaxed/simple;
	bh=31a5GEP8D1PpwdN5PyjwuEtq748f/aUOFXdtpk75vgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgLNh2IeiWHPtKpOKjGFLMaUK7d9ztTXEDdfyxmqFa7ppqd7M8Ca6T9HrG85sYdGZ8hQQGTiQ2DlXIxY7jEQb0Ygsz1XyTXCtUltfrSboChnbZAjXpzk8/lJK2xOhyzdDPc0oARpikce7B3VUhPn89eS/DhoN0xUUkKHEHlinEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVJ7rE4m; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso3691154a12.3;
        Mon, 26 Feb 2024 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945099; x=1709549899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=ZVJ7rE4mNVo6NjFAJ9mUqSSeDTKwjDKhZFwMleepIFJ0wqwpVA6mAe/72zRtpU5vI2
         SEtgl6yA/PcTcO7Sj3FwwjtHwq/BLDoxVI8kju9sULKYfdxtC1mlpSYKaEBoDVq/fKu9
         OvD8gVFXqqBgsl6iG9XSCtimRfPX1AvjKDbKkS2FLvvIhrQbRsq8b4HhsSuXRVxl270U
         GOtPSI3yirmcurj3nVtuAg6D/IEsRZk+EoHiWpDKYl6PHA+DwUSsRMG/iftH/37O2iUv
         mGUD8b3rQbWpR1diLZbE75g1tyDiiKLI7+rlzgPRgI31Kx+Mjw15XeQOqTW2rxUMFHsZ
         ut7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945099; x=1709549899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=TCicjiXfgT8bR8UpoOxkY+XV4d0Biztr7XD4spBT3U3qcJe+qg1jgK1DiimLI7jHi2
         xS5F35TDu3zOO/sd6hccYTwPtfW+p1nROrmZg+AU8VSl8gpZZPRm7o1k9TeQH1l04RTO
         QqNUVdhRp7Wa/apg+I0q7CaRm7zgOevPrRm9Uzqd30nq2R1iDQI1QDRU/hJ7HXqyo+F2
         7uVrTELJuho9vSY9j/cABmfOsQnN4IT5tvbwALK/Up78VGtGUuKAzVXH9/9q6Z7KjUow
         dcglvYPgLZGWzI9yfuztyMSme315pUCzhcwdLRP2O+cXklaiTSdoSnMWUEY21x2wOMyE
         KRog==
X-Forwarded-Encrypted: i=1; AJvYcCX7434+wfmFqRUF42R9Zr3E/KwjokmRqxmKXOlnakPcY6Xsw5MiOskSk8LRvp6Z5FvodmHkmEEV7y4eU18OfazOf17xkZ/0Kf0QKHemvOhYUNfQxIEipDXrn5lH79LcqMAAodEnVPHf9cyHjI01oPKTi3Qels/d/pleUUPdLgUAZkgwSkSmJacWZ0x2y2SGyUPiKc43VLYlMtcre1iDjnOY/4Pi
X-Gm-Message-State: AOJu0YzhlD9sAs8ge2CLoAwQtK1dWrx8LF+f8JZEVj6gXXNlT2y+Bw7A
	8X9achQAVC4j7zeIdfvEjIJxoE/1LrgKwz1/H8QvRyOSaSzTwPA7
X-Google-Smtp-Source: AGHT+IGzqOtHqjLiDsEl8WzUqKK2zSVWIx6yPNJ87ooYwr8b50Gw9cKmXCgF/K8pSI/yEBZgak3vHg==
X-Received: by 2002:a17:906:3cd:b0:a43:68b:6a3a with SMTP id c13-20020a17090603cd00b00a43068b6a3amr2822093eja.65.1708945099057;
        Mon, 26 Feb 2024 02:58:19 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id f19-20020a170906085300b00a3fce8c0f99sm2315769ejd.191.2024.02.26.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:58:18 -0800 (PST)
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
Subject: [PATCH 2/3] arm64: dts: qcom: pmi8950: add pwm node
Date: Mon, 26 Feb 2024 11:57:46 +0100
Message-ID: <20240226105747.3547856-2-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226105747.3547856-1-morf3089@gmail.com>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
 <20240226105747.3547856-1-morf3089@gmail.com>
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


