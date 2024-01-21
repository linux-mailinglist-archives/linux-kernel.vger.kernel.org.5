Return-Path: <linux-kernel+bounces-32165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFEC835789
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336F4281BA6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754C38DE2;
	Sun, 21 Jan 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXg9saqs"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199938381;
	Sun, 21 Jan 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866362; cv=none; b=n/PYVDMPfe4OmR1QrTMvWUsByXgzjvf7C+PAXDNiwZ6qCgVivyHuW8FWqTA9jSo2kHbDWSmObV6JMZ+AxcSdk6kilIUoUoKDyAk+53XsQPgiDs0pJ/EfbpomMKiUcNowaf9LAFcpVyYqYkuv4B4pMZnDyD+iG+09dZ6Vt/91pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866362; c=relaxed/simple;
	bh=D7vo3Je/ku3YAGxGGEqJYOJM64U+z7ByohhxKjrFtxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnbQOIYpwuyU13q3IlSzPq0IukNnXtaVp78qW1jU/JUXQyPVxCktX6UI3nTy7J6xFmNaZ4y9SKZj/JH39RDPbH/4Q964cqGoJWDUBIjeIpvJGFqL6hrsYS5styqzMIlvEqpslBOdNqXfSuRlY7MJxSMKWf8v26jfu7AQEANkC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXg9saqs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so526607a12.1;
        Sun, 21 Jan 2024 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866359; x=1706471159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2y3IKPyLzXC4v8koqDaasKaIIQSzzqRF+g1mhrKMn4=;
        b=EXg9saqsoWyQw0qI2MLpO1Z3kN3BHz/SYqx2uzVwUu+2RJOiTF23o71Abad4O3fIAJ
         YSE4xVV0cfFoOZ6Vty+DrzBm9e7NJDmybPavl6BSdXQixNWQtyTK1wwChHEoKilKwLVf
         oAeMvnDa5pESPkDzXqJKDYx2+UD5D/JptmkCagEK5Ts2sVeb05rvsmrRCtztIcQaOHaI
         wpKSbO8MTL5SMP2QZpfSmww2yMANg+ciezR6+2kMPXHhuJ/CwycARNb5Byl49lyvBIyW
         z/+sHhtzmsBBPpTmD2u75JKbH+ImwDx4qr1WG+dWvERJAwpgyg61B5WAYgBAacXdc3xu
         mRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866359; x=1706471159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2y3IKPyLzXC4v8koqDaasKaIIQSzzqRF+g1mhrKMn4=;
        b=pAR8iZlcOIuC0j+EYyLKaovbKxFnWlTWGZg0Y7/dg666O8tH+5J6hqAhsfg4zw5Dxr
         rDk6zXekg+Px1rtezdlwhbfFcsIf0HjCBGeyx4T3ArHF4h5AYeURhIAY+oyetEwhFLvB
         uqp7B2oSC7cceHx1DW8zKBfSeJsYGdDnT0B0oxcqVaBjzbFjYN+UAnDZja0/1gGzIAhF
         qYhGvDUtO0BKLezhxzQUqD1dQDLgnv3FuqOR6s91sodo9Xpdebw/5DJsi21tIYg/Do6w
         7uRpKfHXEUjIUVKltKu/zWXDSjwEzeSMehMBUUEZzAHJ1pNXTvaIcFZNWnFc8mu5PJzT
         3Y7Q==
X-Gm-Message-State: AOJu0YwQUKH/LxQ+nNoNRvjZ81NWwMSDCYvGQy2Dv7FIXKpsjEbEjN+z
	I1xYeHBxZPTvXZukYvHYggqtNLeddRFCvpZJJw6hbvTAEviv7xOcvGmjo/sehYM=
X-Google-Smtp-Source: AGHT+IHh8/TU/0VUDooBERyQGy+VFyA6oUokYFyCSTIbUVuzbfxUdGklOUSWy9+BZiEdMA8CJd9+DA==
X-Received: by 2002:a17:907:c088:b0:a2e:7db2:8f1e with SMTP id st8-20020a170907c08800b00a2e7db28f1emr1593296ejc.79.1705866359290;
        Sun, 21 Jan 2024 11:45:59 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:45:58 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: msm8976: Declare and wire SDC pins
Date: Sun, 21 Jan 2024 20:41:05 +0100
Message-Id: <20240121194221.13513-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare pinctrls for SDC pins and wire them to consumers.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 100 ++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 765c90ac14cb..5a7be93a0115 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -771,6 +771,96 @@ blsp2_i2c4_sleep: blsp2-i2c4-sleep-state {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			sdc1_default: sdc1-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_sleep: sdc1-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -1246,6 +1336,11 @@ sdhc_1: mmc@7824900 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
+
+			pinctrl-0 = <&sdc1_default>;
+			pinctrl-1 = <&sdc1_sleep>;
+			pinctrl-names = "default", "sleep";
+
 			status = "disabled";
 		};
 
@@ -1262,6 +1357,11 @@ sdhc_2: mmc@7864900 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
+
+			pinctrl-0 = <&sdc2_default>;
+			pinctrl-1 = <&sdc2_sleep>;
+			pinctrl-names = "default", "sleep";
+
 			status = "disabled";
 		};
 
-- 
2.43.0


