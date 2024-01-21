Return-Path: <linux-kernel+bounces-32135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301518356FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ED01C216A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0439FEB;
	Sun, 21 Jan 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kedyQlzD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73C39879;
	Sun, 21 Jan 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856367; cv=none; b=m6Mf3zJdZodOLCPPaQvHDXseNs1YA3mv/ioDWJbgKpZ+MPai+K8RNdwJE1AY7z5kvGQa1KX64pCl07gsnXNkrVo3hUBVJJpKWN81GDIzYQXpB4VOH+ErwVBCL6NykxQB18fHzfjZvp5hbqvvhhK2jXt9saxtuavZzlGED1ksO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856367; c=relaxed/simple;
	bh=qd6aa7QiaWspQR3ZEJA6WWRFbT5cIeORtS7lzfdU0Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNP4oL3CPX3b17qlN/2jcOUcr1STd32XFpi5CO3bBuVwz6dBB5Et9r9PxKktrErz3seA/xLQkCR3hiADLB2J5A/tbh/YtbJAapn4GCPty27hTkE08x3AY90nQzeFLmjFZVl8f/Ggz3j+9iJyF0UPgpbqnW4U31kJPgzBdVtZg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kedyQlzD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e8801221cso24261045e9.1;
        Sun, 21 Jan 2024 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856364; x=1706461164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gK5nK5PwrUn57SfZW8dbKzVdKzftzCnA6l6yN9PxC7A=;
        b=kedyQlzDRde5ZC9i3GxBdTnCx4tccoqBnBdcuk5iEjkrnoMCYRL2U+rWmhJpyNXM3h
         h96zsy4+rz1+SS30fXFBHTghBsz3ZR5PfnB9LXbeEkISiPKiBZFVJD3oqYpskhWgCTl0
         1TCCOKl6OV69X7biy2QXO54k5u/etEXWlRYTm9yTZ2ll+rooloOwfY+mfLGzmyQy5MiO
         W/3pdryJZA6CNbeUzolrRXSkNyOmfT6x1HxdHXw9QCXILC+dlgz8vvCJxnCn91gDWp/r
         ySJpa01DDDbFG4IuS+I4mAvWlloHcwX9xZeReyJBjjvAqqVO92wrp2MlcoLPRZtFT8yL
         Prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856364; x=1706461164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK5nK5PwrUn57SfZW8dbKzVdKzftzCnA6l6yN9PxC7A=;
        b=HAdNLtnoKHwD59fuq2pYlOMcMEh3Sq66Z0oFtw+nUw8zWWyP87zQo0wL+MIcwbnWtY
         VgASpNRQEnGklFDGQmCsffWwdUilGbzDR1elhfo6pA8j70IcN50vpMnztsfgYqS/nU9T
         Mp3r2FZE6KpKN6glvQHIGosE7QHJRfnCNNDJuN8AzvjRuG4YF/ElaqyW5LlwaxZiWYH3
         oEdu6jwFDYe7FXg7R04rEuoe4baOSHy2pHaJck5RymKUddsPtcvsmxBWOUh1OArR3/2I
         4/mmBANEy/jIZw+T10PLHC90loG3S0XyOo1SW4oX4nAW+D7D2dfdWQMWix1zncnWm7ZM
         Jf8g==
X-Gm-Message-State: AOJu0Yx/kbt/nN+8mMR6yqHXtzxj6/tVipqveWCQR8x48ikjwEgGRVWU
	9Rg0qksWnw1B9kbriKuJkRp9ddpER9/lbpqSahzk1WN4ul3StyE5Z7COsS6W
X-Google-Smtp-Source: AGHT+IFsVH6k6ajfNQ3Ngf6ihWQLiw+5zO5HU7ToHaJReIYrKn3JxVQHaGOVUIXkWbhe2r1Bm4y/AA==
X-Received: by 2002:adf:e58d:0:b0:337:c4d0:3ce9 with SMTP id l13-20020adfe58d000000b00337c4d03ce9mr1889216wrm.87.1705856363900;
        Sun, 21 Jan 2024 08:59:23 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:23 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:48 +0100
Subject: [PATCH v4 8/8] arm64: dts: qcom: Add support for Xiaomi Redmi Note
 9S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-8-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>, 
 Joe Mason <buddyjojo06@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=1769;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=sSzRKjO93UpTlJ8GvJQsTstGtWQctFuueHqgHmEaLmI=;
 b=KrhjqRs6MaRVLwt8z7GQUu3O8KHdE2udwZmCwSHa9BL7BkdLOzrrS2oaMXY4HjKggisfo+hCq
 zVjPjqKqSTMCv+Zem4h0Jtp8mBbAA6H2PjTlO1wTwkBIfA2u1sKOQjF
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

From: Joe Mason <buddyjojo06@outlook.com>

Add a device tree for the Xiaomi Redmi Note 9S (curtana) phone, based on
sm7125-xiaomi-common.dtsi.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e12..2e6984bbbb83 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -210,6 +210,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
new file mode 100644
index 000000000000..12f517a8492c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Joe Mason <buddyjojo06@outlook.com>
+ */
+
+/dts-v1/;
+
+#include "sm7125-xiaomi-common.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 9S";
+	compatible = "xiaomi,curtana", "qcom,sm7125";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0x20022 1>;
+};

-- 
2.43.0


