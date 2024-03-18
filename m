Return-Path: <linux-kernel+bounces-105765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7C87E400
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98429281211
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3123775;
	Mon, 18 Mar 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFkWht3e"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A622EFD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746355; cv=none; b=cL0EFBHC8q6Hl0z+tFS/N+YPOZYNYACAnIg7BVIHK+rbWlR9fNiC0y0pCD6pVHHIcKPe5lTFbLB9lkjzKbEInFC50RsAhLrME0kF55AHl4Ip8HJ9rAtzPUnqfqPDqQdDaYNZH8IzKdLfohMisKmXZGPWF80nS88Ub4sjPMQwMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746355; c=relaxed/simple;
	bh=1v1aQLIYP8b+mI95hKqjB4PDKnC2GI6VXXU3JQllGfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3l04j8JbHOtFlVNqTEqHyswuJNb1GMm+NWeHVyK43CFYPHlWRSa8+310smbrEOmf+NWzhrHiuLLuyFtq0FI9sn4QSzWcQp9m6J5ni+1VAgAoaBD1MOudTztNcAtX8hU4D7qAhLfWTQUmgAJ1H6uu/inLgd/RyS0zUVB1PINwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NFkWht3e; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so3770960b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710746353; x=1711351153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq5Dos6DoYH4j6IedoqEyUOn4weuKjM4Z19kQDTr6Y0=;
        b=NFkWht3eQAH7ntsZchDqrXm7b+aU3x2abErjZN1B2hjh6Dj5F0/lNefQLmsEG3PsJC
         EIEiZNsW+H6uIWrC7irhlk48bTz6HIae7mzPhCDHh70VCztxxM/zXpBhcSMJdhmhqwmv
         l8DQ/5qz2lXCFPR+zG+OMTnQaT9NSto0RXGtjuB/8ifeN3luKeFMYO8I8St8mt4dGyHG
         O+pCeSCB6NrhYwzhonjvYYB2yg0npp1IpSJL1Y1qne9um1LXfJRDW80jQPA6zq7m7LsF
         duzYWQhvghyh6NxIms9HxB7wKij90B0PNIsnFjUN/TnLJ9aM8JDfJot+HvLoXdvI7CT+
         /cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710746353; x=1711351153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq5Dos6DoYH4j6IedoqEyUOn4weuKjM4Z19kQDTr6Y0=;
        b=h4F5s2OZlTGWyibbQ8nDPmHNfcGhOh5YHfphOtI9Qb6NDh/1Nx9gEAZrcuDHQzwnvj
         bJQnnWFzm1eewZvrHIOkAhLvcteUgrnSlQB9BEG9emO91GNgOBGwss+HJNj08KfS99HA
         mkJiK4L3iMDuc2iVuoizI0g/LicMmTJehJxNApavfQQbRbpAnENeWptVMR6PZHn9zevd
         71WijyHlWXGbJxma5nTpflBGIpmdtTK9U4wMZHKzB7OLdlJT0ARM9B80VaAW/lkJqrLC
         ll8BIxdErOtbobKh48YPCKcxQhWRNMH3cLor2a49PS0JHiMsXvPUMKzOfIncf1tMEJM+
         vh5A==
X-Forwarded-Encrypted: i=1; AJvYcCVLspGFZBrruuS4lx0ZRy1wL4UPCzA467JsThrrVMGsFwJufhqe4b3sHyBAqsU6eolFIEfzigjRnE2M+yBtpdjze7uJArFg1xcqTEBN
X-Gm-Message-State: AOJu0YzVry9o791Dby80SnOPZiUlhZDWq3Tq1KAaWhnK2iUEJ21PGyXY
	6vvKJ9TIFTZaPj/Lq1UORuLNg/ppKrP1rSstwVyiRLpjV8roYUK6YrbH/vid0A==
X-Google-Smtp-Source: AGHT+IFSMGfgI9ewcyB/Piyi5+UjAAibSDaWTk/5HkiYLVv/0ABTPRS3zbdmrJt1hEWYLIHu2wy2aQ==
X-Received: by 2002:a05:6a00:2387:b0:6e6:a0de:563a with SMTP id f7-20020a056a00238700b006e6a0de563amr13811975pfc.15.1710746352955;
        Mon, 18 Mar 2024 00:19:12 -0700 (PDT)
Received: from [127.0.1.1] ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006e66c9bb00dsm7387515pfn.179.2024.03.18.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:19:12 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 18 Mar 2024 12:49:03 +0530
Subject: [PATCH 1/3] arm64: dts: qcom: sm8450: Fix the msi-map entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-pci-bdf-sid-fix-v1-1-acca6c5d9cf1@linaro.org>
References: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
In-Reply-To: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=1v1aQLIYP8b+mI95hKqjB4PDKnC2GI6VXXU3JQllGfA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl9+rpsZJOD5LdQA2yEn0WyWcaDrhLmj04RjjXG
 pK/74qvqrSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZffq6QAKCRBVnxHm/pHO
 9S3KB/42QV76nv/mS1H0u1J7geOMOVeURxPRrCxDsTk47fvKgH/rXwLsRQb0ZmpAhlX+4wtI1i3
 rzTYnJr+CZGzVYIWktiszpGZ+V2/CH7igul/6ekvW7QUKOa3xLUKRObTi/K8+MDNxQs8x0olJ6v
 JWKyOZ1JyWvQrGZB2+zIhAKKlURRRK0V/yfHzOktZQLH3DZXsHUOaBthHOPxDVIAXLDaqdPgBQv
 VzvW7ZBYviiTHCnUXHcrSFpIeo1o2qRpV28hL0FFdyB8OGyMgyGAfNDXFHqlV5GOQ3nhyQCSlOJ
 WxC8S2xcnpDAQISj7XlJGE3jaZxbpJ5Giu8m+KgVpXBKFzUn
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

While adding the GIC ITS MSI support, it was found that the msi-map entries
needed to be swapped to receive MSIs from the endpoint.

But later it was identified that the swapping was needed due to a bug in
the Qualcomm PCIe controller driver. And since the bug is now fixed with
commit bf79e33cdd89 ("PCI: qcom: Enable BDF to SID translation properly"),
let's fix the msi-map entries also to reflect the actual mapping in the
hardware.

Cc: <stable@vger.kernel.org> # 6.3: bf79e33cdd89 ("PCI: qcom: Enable BDF to SID translation properly")
Fixes: ff384ab56f16 ("arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..024d2653cc30 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1777,12 +1777,8 @@ pcie0: pcie@1c00000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 
-			/*
-			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
-			 * Hence, the IDs are swapped.
-			 */
-			msi-map = <0x0 &gic_its 0x5981 0x1>,
-				  <0x100 &gic_its 0x5980 0x1>;
+			msi-map = <0x0 &gic_its 0x5980 0x1>,
+				  <0x100 &gic_its 0x5981 0x1>;
 			msi-map-mask = <0xff00>;
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
@@ -1900,12 +1896,8 @@ pcie1: pcie@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			/*
-			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
-			 * Hence, the IDs are swapped.
-			 */
-			msi-map = <0x0 &gic_its 0x5a01 0x1>,
-				  <0x100 &gic_its 0x5a00 0x1>;
+			msi-map = <0x0 &gic_its 0x5a00 0x1>,
+				  <0x100 &gic_its 0x5a01 0x1>;
 			msi-map-mask = <0xff00>;
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1


