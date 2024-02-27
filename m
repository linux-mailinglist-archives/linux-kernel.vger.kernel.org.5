Return-Path: <linux-kernel+bounces-83252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2A8690D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66389B2222F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330B13A878;
	Tue, 27 Feb 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFTA2AQb"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3A1386CF;
	Tue, 27 Feb 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037929; cv=none; b=awDRM3B+NIK0cMNqzt5Z0t6zM3M5FzsMfZQeourrTwOOFC5n/hkIvmYfvHUDnYJgk75T8FGN3ZjCRCrAbvYjLpVshbaCkAqgby6pXf/vHmmals4QzuZNsvN7eC2TkqYqiwuYQ3UIWLkrDT7pP7Unbnh4zGgVO8pB/3vPd/Nj/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037929; c=relaxed/simple;
	bh=UhhVT5HMBqTp4XDQsF3OYV8ifqz8EU4ufs6XGJuvv/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mogTKZ51sZq8v4e8vXmYeBo/zi0CN6kMQ8X4PwTHn9ypRWauU/IR/HpAfKFJxkkUvRRlIckNtMXfygV8FZR7DNMVh7gvXieaLdCuh3V6UQExay3J/SREd+sHlpJCWBo4RRHIwZlbBR6qr5ai5YKzTGKYIpVCQ83ZXRm6ej9aHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFTA2AQb; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1a2f7e302so864223b6e.0;
        Tue, 27 Feb 2024 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709037927; x=1709642727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeb1RFSrcrszyxWv7zLI8PbVAOHNlKGOhvyvkPGpY8E=;
        b=gFTA2AQbXhZTnBHIJqzSBuy6TKtG/rgP0YHxA7p+qo8ArjFitM/bb5bhLYOSQ/XnAI
         Rw+D3TPsgmGooMYvIFK8KKVG0JALI6M5rdxTTMbAp5sTCIdQCv6Oy4sgPnV+hoeTNv2t
         fAYNhju5vBZnZ8llC2E14DrHhiLWUqhJzeVbuO3yONMun5VFSapUL2eVdVOAAYeZAg/T
         Bd/BKpbuVH6JE6F8NngwvG/nj0HbhLq7AIqVXu755yQ5Kc9DgcPWABnb0P891/LJlc0r
         PyGZWJqXQ03IJXYgm9XCukcj8VeVFsxT7kLnqJCsnlPTJb/e8rCRxTIxqy0KrIO4f0/k
         uZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037927; x=1709642727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeb1RFSrcrszyxWv7zLI8PbVAOHNlKGOhvyvkPGpY8E=;
        b=EqCgIH8eABnpBgUskSTVBuE/0JGk+JGI3E/tgqO9rjQ1cIkhJGGPN4jZr7MiTOg9zV
         DU619vvexi8T96z01ar6DxM0YjZc4iO8tXuTYUlQ/ee7zcafzKRQCNuC5/TZNBI/p9pz
         0HEtORsaSCDHxalrYm69/S9wGWN7f9p2l+mV2/gcbJSuEn7hZud5lTLQAQNaF7ZvONOf
         iD8oj6+2BVULV+j2VLe1LVQJqMUc3Xxdo4zWUIrilKDkAqBecgfFtMPA0Ufb76judMLv
         kRy/oIKo25tBycofJ4U9fdm/Aj/3e7FZ2ZFiacflAwBk5wLMZgmZIJnMYUmpB9k9cZ03
         VbzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7anUCpHaPj5Br3/KtWtSgtCyzVg1oqiDY+7l8vXeAbEfOFHFX+von+LnDTvp0X0fCdIAopiEabo5dRqsFjNpdJXa3WcEWvF/HP7xdlZwQ5+uZnP7HaiR/i7CFO3ngiVSwgVMMkyACTQ==
X-Gm-Message-State: AOJu0Yyfs6x1aNcevNrbHP4Mv4I9h46zw6tiNcS7ruydPJmjk024XtLY
	gFYWxcVs0erSccDKj2fNvMV3yJo7Jwjfc8wzIWcWTnunuhZ8S0W0
X-Google-Smtp-Source: AGHT+IENhtjubyryxOXbYYwylLHx78DhpdBE6X1ojR8wdI6kn9s/YaTwQp9Pm2hWM9iXXDtp24LDxA==
X-Received: by 2002:a05:6808:1387:b0:3c1:add9:5a3a with SMTP id c7-20020a056808138700b003c1add95a3amr1856384oiw.32.1709037927119;
        Tue, 27 Feb 2024 04:45:27 -0800 (PST)
Received: from localhost.localdomain ([103.149.249.227])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b006e0fc1ed2b7sm5827842pfq.134.2024.02.27.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:45:26 -0800 (PST)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation support
Date: Tue, 27 Feb 2024 20:45:29 +0800
Message-ID: <20240227124529.12926-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usb pd negotiation, but charging is controlled by pm8150b pmic,
so it can only charge battery with 5W,

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 6f54f50a70b0..ed103b90f4e6 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -636,7 +636,8 @@ &pm8150b_typec {
 	connector {
 		compatible = "usb-c-connector";
 
-		power-role = "source";
+		op-sink-microwatt = <10000000>;
+		power-role = "dual";
 		data-role = "dual";
 		self-powered;
 
@@ -645,6 +646,12 @@ PDO_FIXED_DUAL_ROLE |
 					 PDO_FIXED_USB_COMM |
 					 PDO_FIXED_DATA_SWAP)>;
 
+		sink-pdos = <PDO_FIXED(5000, 3000,
+					 PDO_FIXED_DUAL_ROLE |
+					 PDO_FIXED_USB_COMM |
+					 PDO_FIXED_DATA_SWAP)
+					 PDO_VAR(5000, 12000, 5000)>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.43.2


