Return-Path: <linux-kernel+bounces-109964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F988584B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D4E1F23C98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839958235;
	Thu, 21 Mar 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jax4aJVJ"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260858200
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020341; cv=none; b=kTdEyungOD2IRoCH4/McLeci0EIrFcjqPIVBqanCM7bRjaT9sOcsJ3ojO8scEXwgv90Vb2Wg3llkzitxEsbOQ4wB2lrdZRMDljPiAJCvjSO2F4WFgjVMFopl+WUikax0zoAT80jehtzn+zYrZlFVfl7/PDegMqvcmIMXlrLYUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020341; c=relaxed/simple;
	bh=yWkuUR18jPMmj2reJbrWdgmyzSEUec2EHqek3B1pzRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNySP62VLn47VlBe4gyBGVruqqmA2lJ8+55PklmAHeoVzv1hlb9qWj7wwr/eyjJpF4dNWCiZ+eBGjMdlPjJ3FGpmJ8m/AWXEx5u/pSwxLlpbCkySwqVa7b+CJiri2hUEkVeoR3PI7O7gS+DCTyNMfz17Ys8UXx87RPCOzswG230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jax4aJVJ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a47abe2ff7so447896eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020339; x=1711625139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/SOi9VxHJtNBJHMJ34ByOBUF3g+OERNiKvM82IKoro=;
        b=jax4aJVJCU0imErYMyMMbYTcxblTRQjB9Yt8pcE2Lpd4pQYJkhSZRkrE9SJEuiShwk
         tq3gRR1usKuYLy7rZoQt8rEq5LCuvQO6LzMyxRiw/95d0heM1y96raoOKdNCMw6NZGos
         OMYyY1ahVCxvaVz/dNpLzdJfU0OK82wnuqG5dUNCfKc9VmusaO4UFzc/AH3YBgoSvxNy
         /gwJiW13kEvy5JrcvB2vowtD57vZMbCpLo5XrdRdw3VdYJweWda83YkY6Cu7kx6HkIdD
         ucBJkdy0PXsAezPDIrx+K8vnqIidhRHDaHrNC7636flCA6v8xFv/x+M2zMsrEHUp3j6V
         62Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020339; x=1711625139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/SOi9VxHJtNBJHMJ34ByOBUF3g+OERNiKvM82IKoro=;
        b=i9z2SqTiYL3FxLOCrjbqfMt7ndzvCEv7FEP9L2mOhNwyJ9jEz8YbNLETk7YOs1FN9d
         UPL5iwJiI6FquTUHKFJsGBSkdM7spZsoGfL3SXbvOuv2lJ0+b0x+BAYHy9pRW1DtvmH9
         oHHHsSS3zIzvh2BK9Tf+O33SL7rTXu8FJYswx376Gj/ajLgOHFPMTokq773ntwGBB0iI
         2hN2X31BP//vi/Qo0i+8VO7YigPcN0Xv3qTg7Han5ElOKQFBkSC2pZ2dULoZl2V1647d
         rAT3NG5r3sgqACd8QG/MWxfHqos1u2Me7kXuABZaGMAoZfDhUtGwLP7ilVkBIM3yuHDx
         S7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUSSQ7T19NqeP/bk9Feye+SY8cWFUZM6uAqRwRvk3aNBs4o1HG0WvDR4gzn8tTBNtMji/1bKJTj2E/Fob0lkfxqoyqFlNgf6HFdiOVj
X-Gm-Message-State: AOJu0YzQmWa+HZ1Ruw36nOyUO91LTOwSPl+pLwSqtgpB9xjWwBfTOCIo
	vqJkZRYf8XVGzsLG4S63HJONObz04eh6vQpF1QGUndVQAKn7n4Sf+GkxAlpicyJtMlyGIhjEprc
	=
X-Google-Smtp-Source: AGHT+IGy5wVwYOyJosO7SOl0XicomUu3UswJe58V9mcoFBn4JDeomKaOhMDqKzWMrI6apKRSWcaBVw==
X-Received: by 2002:a05:6a20:b319:b0:1a3:3e4b:ccb4 with SMTP id ef25-20020a056a20b31900b001a33e4bccb4mr3664679pzb.62.1711019873618;
        Thu, 21 Mar 2024 04:17:53 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:38 +0530
Subject: [PATCH v2 18/21] ARM: dts: qcom: ipq4019: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-18-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=yWkuUR18jPMmj2reJbrWdgmyzSEUec2EHqek3B1pzRE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcNMBCAkRq//G1iDfV0LggacNdzW1RMW9BZA
 +2tMfhNK1KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDQAKCRBVnxHm/pHO
 9TDCCACin93VyqWQgdOI9X+cDB33tWn9xCeLW1CUbpPuvh3DGm8/UDwh0TaQTU6OfvKjxnYZYMz
 7UuQJgM7rb4L1l7iMYahEixO95jVIfy9xv5G91A9KJBrxDgbl+pH4asuA+yMghzQwz01fd6pe/Q
 iZSY8hUfvyyw/z+NwjVLW3DFGXcO+tjULJwjuyUM7V3yBhwvWr8+d22CglHhpwYkyC4GImV0Q8W
 dTCxMnKDuo9nDxgiegw7tNUQEVi2Ju3D3SwLObcxWg6lx9fjppwxsdgPkACZy6JKgsCV0aly8wD
 XaCV3+wWSy71VDLA8LeoYLRvXq2viXrpBt7bFYXs6KvOYlws
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 681cb3fc8085..f09c123d9fa2 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -470,6 +470,16 @@ pcie0: pcie@40000000 {
 				      "phy_ahb";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		qpic_bam: dma-controller@7984000 {

-- 
2.25.1


