Return-Path: <linux-kernel+bounces-74036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2185CF23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8AD1C222DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99F3A1C9;
	Wed, 21 Feb 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzwVZNu4"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABC3A1BE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487003; cv=none; b=ImWJkcVaeY4ua19NkvBuSR+JvCEX4fmcJ0inj1NCXLKKPJ+fGI8xQ7vkF3j1YnP+Lx1BS9V2bdNrUg7RH8GdfChcuEAWvmFI5JF8jk8zbcccouDEW60Kc8KiSxcyebSzIagLL2V0YMNs5gBpY8rZxDAsAzcRp6aNhzFsRiYFd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487003; c=relaxed/simple;
	bh=A1U2AhFSylFEoWUJauK5UZCee1hBlTSyFV6uA0M2qLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXWfNpUSS9uBWyXySITkA535tr3XhttVsFy1tba6fAYQ4wqDR+7hejaBVoXOBz6B+ewpljjQS+MAcQXk8UEBUu/UfNfz4W7p6W2zbWGpUw7J0u5s6jI3lbawOb6UnN/mbsMOWnROaR4hoTDvXuvkcup5GRgBlyo9x1QWhnsD9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzwVZNu4; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c15bef14c3so1950729b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708487000; x=1709091800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TcGD0vYzqY744qhG+3tpLJcU6jq9OWgwS9pK6BYGt0=;
        b=zzwVZNu4a/L32m6yDGkRU6kXO/6nNMkEseKa8biMqrWrvgzh4OMwvPhbD3Ta2+hgX8
         63qq6X+Ww8OOqo8SjiIBc0aziVkuK78YECG9jIsbfQOp5GfCf+J5IHw81c3lsVS8A5am
         QkKz1+9SKhmiNkC6hxRCp/uIHeAwpdWSL/Xoco3+ukh5JMJQZyp4XBO/kWHgHFu4z4RN
         uQo0l6RYdU4X8M3XQGc4ld8Bni7oYDeJhSeWIbKOOZ/jvoNhUlYvclLCWzfPiiNNdqw0
         phsofR7X4LRFlXEhPYi7v5dnV4iNNUYFrXAQMpSE7qoLZSwIjJi6z5uyKrjw/sH20d7G
         dCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708487000; x=1709091800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TcGD0vYzqY744qhG+3tpLJcU6jq9OWgwS9pK6BYGt0=;
        b=SFTeJZVgl/DQdFZU1XNAt6JovPjFCGiM9mvvALeYb/0JiCjuQOchCEnwrP5HQiLiEE
         SLXwCreSmu2xPMHG10aVjL9yh14t2TpSusCj/gIk5xdm7OuU+jGae9+Zw4nT17pBKgkT
         jKAYIBwfqi9GWnNQ4a1pbfB38eMTr8fpnFAtm3qWqUkJ7Q/q1lKqD0iNJZ7P0469peDp
         HT3qHnNojRZXXcDYoDkR85eRi5hRIK5DetCSfFlyeyXKLsdUuBT2ILBqfjtFIpXz4Elc
         1/K9V/jX30tGgv+oTDgnh7CxAGlVU+0LQbDY2SHem3cjY1RhlCZISFtq/ucICKyeqNFl
         qXJg==
X-Forwarded-Encrypted: i=1; AJvYcCUvrOjeT3ZfMS/zSXuXvvr5Fuvp9nWdQ95+4SP7BWSuUiDvOe0e3fySs4D2ekC67wE7uEVZw0RDvoDX9VC88Od8nebST3tbce1HajRq
X-Gm-Message-State: AOJu0YzYuwnINqrWlVPBFkwlYgOJ3QA++yYwpa49B8PZa22XyorlCXHB
	lsfQLL8UTrN3EUhCvebQOLjN+Lh5HB4wKS8euIv9Uf6gF354NbnMMZLzOJVeXBJw0xgqcXd3eak
	=
X-Google-Smtp-Source: AGHT+IGh0VRHakYBLfpQxyEw//q97OJGZlL2MMOYTb+lFbU6Qr3vHRhVfnVdfzEW5Zoqq4N4oxfu2A==
X-Received: by 2002:a05:6808:21a5:b0:3c1:35de:bdb6 with SMTP id be37-20020a05680821a500b003c135debdb6mr19959345oib.6.1708487000712;
        Tue, 20 Feb 2024 19:43:20 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:20 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:07 +0530
Subject: [PATCH 21/21] arm64: dts: qcom: sm8650: Use "pcie" as the node
 name instead of "pci"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-21-6c6df0f9450d@linaro.org>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
In-Reply-To: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=A1U2AhFSylFEoWUJauK5UZCee1hBlTSyFV6uA0M2qLc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEJ3o0L4dHDQjbMepOhZ1jZsMoVqyLsW6pH/
 fn/qiMCsn+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCQAKCRBVnxHm/pHO
 9bo3B/wOKFCwu5EF2RDsdLQq8H7yjzWtnlJ+uU9SY929BX3KiBjk3O5vHXIx3VKz7pCgTF7BnUE
 LQoNqjY7Ya3Iw2KLY/wU4D8KVcqmXEn/QKiNc4/GR0wBFfob3+o2cJJfAtxrMVd8eJ+jL15+0ul
 +Bxa2V4gBI6m8XV9uFrqcEin/3TcRni3RId/aQqrzNQ0d1zcSFM4lEAqDubCAXRTEsLOfUFpU+h
 x/OagTT1bC7iXRec28qAiKmQhQwcU96Eirqqev7EA0sRXr3kG4Snf2H/mmXh7+/+LYpIpVpavS3
 5v+Trxc/b6ZTcPbtQ1rxGL4yghjg62v8wBkR+phcDsCo4d5D
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Qcom SoCs doesn't support legacy PCI, but only PCIe. So use the correct
node name for the controller instances.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 57a1ea84aa59..1b226499175a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2203,7 +2203,7 @@ rng: rng@10c3000 {
 			reg = <0 0x010c3000 0 0x1000>;
 		};
 
-		pcie0: pci@1c00000 {
+		pcie0: pcie@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8650", "qcom,pcie-sm8550";
 			reg = <0 0x01c00000 0 0x3000>,
@@ -2313,7 +2313,7 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 		};
 
-		pcie1: pci@1c08000 {
+		pcie1: pcie@1c08000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8650", "qcom,pcie-sm8550";
 			reg = <0 0x01c08000 0 0x3000>,

-- 
2.25.1


