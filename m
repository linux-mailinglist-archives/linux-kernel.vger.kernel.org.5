Return-Path: <linux-kernel+bounces-13002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7B81FE45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD05B21489
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8B8821;
	Fri, 29 Dec 2023 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="mAp70h98"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BEF8468
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so2170340a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703839908; x=1704444708; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vxxjHljzHw79UeoeShimfw5lVgwMA49xYVwTmdi+Fs=;
        b=mAp70h98qaQOIBdvqkBTMryWcMePgk/++AsPLI5tsFf2a2W4HVXz0ugojC4MJuOaxh
         HkipEWsPNZIDZvM3+p6bG78RbIFfaOGlmSLrSlgnOgIsnnoIjfZQsazyRtst7fZt+PS4
         wNWycxuIbfHNGq48niTJVdpMtycP0+Joegio2IMueVqxrjxsgllIevCKEYVCvRKF9rNa
         GD+F3CF9CTB4LCoZ/R8uRSQ+B3Xh15RXukvLgZk7URRw3241vOMjAZb0IPe0kBZJ/Z56
         fqDN+xJoS2FNeqeUBCO8d6pAB37QhnuvCahN9kCWisAADpj9+mGiHjoDXgLA4/6MGxwv
         vBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703839908; x=1704444708;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vxxjHljzHw79UeoeShimfw5lVgwMA49xYVwTmdi+Fs=;
        b=MBuayrCcV+LVU2eUljhrPYkhjWyT57JxDVj4QD2aAV3MXtJHYsejiHkvWKviMs0Yg5
         YhLzRmZwHnX0+fsq+aGjuFD3m+COsjX/GBeS1/EIPzV7v0WFNyBO1qC7xBG/k59/kky4
         SWWUU6ywSoA7qA9A7Y07zx+4XRPngM5KMy9AQhDPGJYmqRxMgu3AL8SILcivcnZtQs88
         xV8aRqJoI7lACeYS3O9/MechzE9AEazJs9HHJT/smcCqZGz9mDTJA0H9KX6jFB1NNC57
         4nJpflAHeR6bq4v1UkCuy4are3PzlrWMCUqzRBWfShaVIrC4FD5sC3VGNOUH/za1Vp8W
         lPOw==
X-Gm-Message-State: AOJu0YwpyIIxQ1LzJnPZrZsAAqI603LnPB17EqR9/cq/c2hpd9kN3kow
	w48HDLdrc69gi+sitDmurjpjCJoG2GhvWw==
X-Google-Smtp-Source: AGHT+IGdxVGc+QRqdXHlhORbQSpn/f89OXkU2cgZzotKb7JtqTFfrXmYf0Qh6gocv58KX+ewgvloUg==
X-Received: by 2002:a17:907:b9c4:b0:a27:97bb:4ecd with SMTP id xa4-20020a170907b9c400b00a2797bb4ecdmr257290ejc.59.1703839908507;
        Fri, 29 Dec 2023 00:51:48 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kb6-20020a170907924600b00a27a32e6502sm112774ejb.117.2023.12.29.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 00:51:47 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 29 Dec 2023 09:51:37 +0100
Subject: [PATCH] arm64: dts: qcom: sc7280: Add static properties to
 cryptobam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231229-sc7280-cryptobam-fixup-v1-1-bd8f68589b80@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAJiIjmUC/x2Myw5AMBAAf0X2bBOWxuNXxKFqyx7QtAgR/65xn
 ExmHgjshQO0yQOeTwmyrRHyNAEz63VilDEyUEZFTtRgMBXVGRp/u30b9IJWrsOhHZRtSq1URRZ
 i7DxH8Y+7/n0//c9Cl2gAAAA=
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>, 
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

When the properties num-channels & qcom,num-ees are not specified, the
driver tries to read the values from registers, but this read fails and
resets the device if the interconnect from the qcom,qce node is not
already active when that happens.

Add the static properties to not touch any registers during probe, the
rest of the time when the BAM is used by QCE then the interconnect will
be active already.

Fixes: d488f903a860 ("arm64: dts: qcom: sc7280: add QCrypto nodes")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
See also:
https://lore.kernel.org/linux-arm-msm/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/

Alternatively you could add interconnect property (copied from &crypto)
and add interconnect support to the BAM driver, then during probe we can
read the registers without crashing the device.
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 83b5b76ba179..ce0d24ee7eed 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2345,6 +2345,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x4e6 0x0011>;
 			qcom,ee = <0>;
 			qcom,controlled-remotely;
+			num-channels = <16>;
+			qcom,num-ees = <4>;
 		};
 
 		crypto: crypto@1dfa000 {

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231229-sc7280-cryptobam-fixup-fb5f94a5572f

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


