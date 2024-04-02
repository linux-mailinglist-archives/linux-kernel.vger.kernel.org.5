Return-Path: <linux-kernel+bounces-127946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6489532A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A74B25EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFD83CAA;
	Tue,  2 Apr 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh2fcw13"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEC7FBA2;
	Tue,  2 Apr 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061353; cv=none; b=FtCHVFLBR8kWEA05wn9OE9UzSK868QkwOVw1EbU5YW5LxzWFO6216YQzm8a4nY8kFd+pYJOOwQHOtDH0Y7NqXc1iQ94kwlHPzfSKDxioUsBJo5+P05vkOmMXRYq8tQ3zyjprOZOmh0ecXuHm9S+Y14R8MlkzqJHfKQYHSlJVX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061353; c=relaxed/simple;
	bh=0jbdH9Ql8R+qEmAML7a+oHlBemMnLwfohAf/hI8LVqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVnCQEn8trTP2Pwyc0m6dw8Z5wEcHWhnFvtjuagHVUsteY3uSXFfTet7LTexWH2CNJyT6G40GE3Z7FFWpDB9bizAyflxwu9+qWRNhOz+L2cpeUP9+z1Jl2/I6NcuLZrquWq+KOL+JRZqxLwpbXP/w38HdK6qOETyJQ63mOtyHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh2fcw13; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a467d8efe78so637819166b.3;
        Tue, 02 Apr 2024 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061349; x=1712666149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/OZIOuCLTiXHJRPdAWFFRE3oTV8ohlKbGpa2Nuwerk=;
        b=bh2fcw13HJtUQg8184CUg4qmAjQmXg1AINTDoAY+XeJuv5HIvtydDb/LM9dL7v/Uhw
         2atb2I10hkWCLmBGfaEtj2fneAiVzH8xPon4hUFBv5m4MB0vNsif7DxXaSUlztMJwzsZ
         +tFv35d2lBOTYNpD+Jx4/+nPiLjH+qftwQxTzjq0UJhBz3mL1MIlyJubdFUbnvI1g95K
         7on+xsoWnSL5TmwWyIec9XXVxb1b2zBkA1hMrTEypuIe4sO3086TqzYL/3R/35vNy9oF
         zilU2j3Kk0XjB/m7Aw7ffKA2ai18AaCPjU8UqD7oM+gh2hbCHzbxnIx9IayXMlxgwzRR
         NusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061349; x=1712666149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/OZIOuCLTiXHJRPdAWFFRE3oTV8ohlKbGpa2Nuwerk=;
        b=XelCNUmgVSaX0qHWR4Osupyp0cKCLGmZvWdPmuYMrjRp6xLz4nKwp2sMSygnuSTGMs
         pIeko4rJ6awvYeeYniIMWMMbCb0JFJiVWcyXY6U9eUBEMQ91rOw9upT2FK/FfT9BhaJG
         ppI4bZ3pV48DZIcrRN1x3sSmkbsYH0+DgOW3+tIZm0taBFQ7F4uGSS8c4lqBYHT9987k
         AR7wNp2cNjURpFXekxhRmacjaQORDlguuucXtoMdKLG4hQfW6LTQoF5v7j4Jc/AvslqK
         GlOkhEdCvqxWi43ASIEQEtnmNrZwSLebSN9Q1Rlc53nFjD3+Cviy/X6p0v+KwKHU5VLN
         d3aw==
X-Forwarded-Encrypted: i=1; AJvYcCWNM7zep1LZR0NGFrcsTf7Wye3Ir5Lq4TBvxht8F/uU4+zhQYy8uh5aFvqH0mHFYl7faZK64WOa+gWzNKEt12v3j9kHrNJg/HGBlgsTGaxvYpe4rAfi/zfnMrjqVqm7lam60/g7EYCHlB2KXm3isdnxv9VvACNCzGREBp125su9vG/aozfAzV4=
X-Gm-Message-State: AOJu0YzPOUiyk0VhGPjJU4PtmHxQlc3A9YXVaXW2ggFJHqoEW4Vlzh5p
	sYKXhrR9oB8JeWWde0M473F5N2dRJq41JD1vBLLIEak1CysTiVwUr1NK57iw1e4=
X-Google-Smtp-Source: AGHT+IEUx18FgFtdiG0vOzXYtX/Rvj7Twi9ZPhnHktWmHFqEKskrY9ehX60f+5raORGsrBpxCJTKsg==
X-Received: by 2002:a17:906:b2d4:b0:a4e:8875:71bf with SMTP id cf20-20020a170906b2d400b00a4e887571bfmr1507026ejb.70.1712061348878;
        Tue, 02 Apr 2024 05:35:48 -0700 (PDT)
Received: from [127.0.0.1] (net-93-65-126-18.cust.vodafonedsl.it. [93.65.126.18])
        by smtp.googlemail.com with ESMTPSA id x18-20020a1709060a5200b00a46ab3adea5sm6467506ejf.113.2024.04.02.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:35:48 -0700 (PDT)
From: Gianluca Boiano <morf3089@gmail.com>
Date: Tue, 02 Apr 2024 14:35:43 +0200
Subject: [PATCH 2/3] arm64: dts: qcom: pmi8950: add pwm node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pmi8950-pwm-support-v1-2-1a66899eeeb3@gmail.com>
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
In-Reply-To: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Gianluca Boiano <morf3089@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712061344; l=819;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=0jbdH9Ql8R+qEmAML7a+oHlBemMnLwfohAf/hI8LVqM=;
 b=AZ+8QRj5tCUMSQLxuNn8VVFhtVKNeHZVrNlTEuPAc9+7hbeRk7G5/L/IOmQCtnfYZPAYyD6xu
 wqN6NXu5+UuCXSFs5Mdtp7X1ON/rVozw8oT/gomQnNl6Z5s2/nZF+vq
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

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


