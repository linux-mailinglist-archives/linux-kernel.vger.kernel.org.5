Return-Path: <linux-kernel+bounces-112283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E560E8877E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47936B21622
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8310788;
	Sat, 23 Mar 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKz05Y6f"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B242C80;
	Sat, 23 Mar 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711188297; cv=none; b=SAJh/BraoioIo5r5DwWbL+GxXVgzaiL7o8hqHuTj6p+d79kXALBMrTxqDL7JvVwB5TxBYq2IxlPMT9lFjfhiZNaY+EDf7+EHrmJ2bFLCC+vG8LZD8OB5zRI76EvXZaY80P2Hu+oNyMuSSsbfbvkG05PQ0dtVLwOS4XlSEaSI1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711188297; c=relaxed/simple;
	bh=mYKDpuTZ3EY3JPjM1cY2bRM/CW/Ophp7wIDj7iCnfZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjitlbCRftu2UrIojtzB0fi/73dabrHW5K3BT07tHaBbRKSVZdmCmYFNvZO+3e8oTPFxwtDn+WlxkGZYBy9cnPBIYM7YEulXv1Lp0sIFKKNnwN+9jw6v30x8UcjNR6k6XnreSzd6pDu6fNQvv8s/Vu6masRzSHhvXF5JpyYhE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKz05Y6f; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so2161350a91.2;
        Sat, 23 Mar 2024 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711188295; x=1711793095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VddLd/wi/hh0VChb93jRd8h5amxI6kZmImE+BpCXwms=;
        b=cKz05Y6fp9gFkrJ+saZiz0ajbC+IIpWEnXvaJVwnEQ1Tu48U4gDRxeghuUJCAPXojC
         LPv2Pbb9G9atDn3TFuUZX/PDKp9uheygZEDyVcveyFIN/Sb3KrYryA7cbNauWQQguubf
         r98Kirrd0DE6FaSgY80JVcxuT2iQR5cuGADXCFpo3r48tKDmogyY2MBwMbryhcXB93Rx
         dD6i3gpgpdQwfnTPqxIsKvJPCsM4qDZaWnt43Z79cGy2ZOFV1Bh5Xa8YrX50xiJlGQee
         5KuXYVD9E3Djh75j/C1ZYq+qaCmvCo20TJGzR6RtNFMHUTB6qB6QKWg0FJMLbQm3nO7F
         uSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711188295; x=1711793095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VddLd/wi/hh0VChb93jRd8h5amxI6kZmImE+BpCXwms=;
        b=JyV4o9HMPWqu0V8BvhdtxV4oSEUI8jk/1iNY8QLMAkCqnbYe4RxKX+dfBelUrqjyGp
         25d9A4q77T1FHwCFZHgUjQ4XWD1zT+cxhkF7Y5lBS25qR8h7e98DMCLv3B+V6/9lY0f3
         H4nLPw0o1atkDA85mu5V8g3fBjKyaH9aItCFm9uJe36XYZC2RdL1MHk0uUPUV+IDxret
         43yPT8puO0HQ9eVYljn2CSJn9I7QltJo+tSng8S7DzYQcRDxXOW4oa+H76U242zhn/7b
         YSGBTqi/7HXy6TfL+a5RhXfUIYmOskSjarVwOO/foafKvJfL5AnS5bY7VbJEYHhGBic2
         zXYw==
X-Forwarded-Encrypted: i=1; AJvYcCUNv4r5IqC7L0+cBh9WUuKrEje4Y0C0wA34vAhJ/T5DCDh3Ap9vO8qUR0PEaY3CyHZgkmGsy1WQiqwmf/0Z9t38YlfkfwqXkHX1B2dnh7phTkxqOrfR3uyDKn/Ot3KVrBYFirNwA/sIiA==
X-Gm-Message-State: AOJu0YwafdoJtLpvdjYtRUyW9hdHGXImQbXE6o1eUKSRIZ5KKX5D3F3o
	5SnPJpaF84T/rmxmuUKasTsr7/AkPLgw86VT8xLEeKRBjkI+T1htDN+W67Je9LY=
X-Google-Smtp-Source: AGHT+IHHapQvAw6lAaSMn3aBbi50gvCb3gNUuuZzwFhRwPdbTfyMRZyMRM9i28QJTkhWoZ4LMaUtmw==
X-Received: by 2002:a17:90b:806:b0:2a0:4bc9:a4e0 with SMTP id bk6-20020a17090b080600b002a04bc9a4e0mr1625304pjb.4.1711188295173;
        Sat, 23 Mar 2024 03:04:55 -0700 (PDT)
Received: from localhost.localdomain ([103.149.249.231])
        by smtp.gmail.com with ESMTPSA id sl3-20020a17090b2e0300b002a0304e158bsm2352931pjb.41.2024.03.23.03.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:04:54 -0700 (PDT)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Jianhua Lu <lujianhua000@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus regulator-min-microamp and regulator-max-microamp
Date: Sat, 23 Mar 2024 18:04:43 +0800
Message-ID: <20240323100443.2478-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the dtb check warnings:
  sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-min-microamp' is a required property
  sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-max-microamp' is a required property

Fixes: 69652787279d ("arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and enable usb otg")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 2042020eb0dd..41f117474872 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -668,6 +668,8 @@ pm8150b_role_switch_in: endpoint {
 };
 
 &pm8150b_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <3000000>;
 	status = "okay";
 };
 
-- 
2.44.0


