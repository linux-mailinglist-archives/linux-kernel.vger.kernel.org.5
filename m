Return-Path: <linux-kernel+bounces-105767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5287E406
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726321C20DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86E288B0;
	Mon, 18 Mar 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHeZtgPE"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A025763
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746362; cv=none; b=sHyMGrLQHNcjcU7VQz72cQ3X+gtylztJm0ioNCZzrk4OhWoZe0NdRfREnVZnva4PXnfz8C4rskpJ183Glxy7m7icIdr6DzQp06cuKN0+pY+9LFBx5yth5Vra3/cERWfp8A8ArUPatH8o8hARB6Ntv2jHaZ6avGUJ/al3twj4yt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746362; c=relaxed/simple;
	bh=rq/JWeJfwa+47UTE5z66gjbDrTKJLAljsi84x0YRn1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAjvT5NoEOlt+U4Atu1hAqkdASpqbYmPBpowkP9vVhzbs1xUKAvVIzpyNS5ADSEQV8d/3QL4OdtRBrXA5HI9rV6TsrsNf1GFV8t7oDFETPNqBZN6x4mwQQ9UI1mL/ejtaQrPoKxNtG4iW7bHZqqb+rsIP9ns1ic9Gl7y0zXN4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHeZtgPE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd72353d9fso2436374b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710746359; x=1711351159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peDqrf3lDzXyT27A8hkXTSlSS0NQMm0NYY4FTf2ze+I=;
        b=EHeZtgPEE3EiEuSLPsy3uMr0EVavsgo7zuRtpsiH8kZyEMaXnU7DG7QVOW3Y5TuPum
         NZGiPP6xAjSU6GFCdyHH17a0CKDoyDeioSyYMfoFET28RzGAaMoaLaayPOH5NyRTsMVm
         0mUxKqQL3BuYBrJ9gVmFwCII5HMPDEg5kI7VC1rlPLfFTATif/G9KY5ch/d/tAheR1HQ
         TfgKov1KM+J+tSrK5nSkxKPj+hLQ7JonqRkoKB3VuqQfrzdAB655qI9F+DFRGyFbKTFw
         a0vNTqgOVdkj4gnFwe2BxK+zH8J/L14i0+gGgA8VsQU/lhcL3UvH8MxSv5CWfwC7M8ni
         4YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710746359; x=1711351159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peDqrf3lDzXyT27A8hkXTSlSS0NQMm0NYY4FTf2ze+I=;
        b=boysI8S+4cBtxhyXtjxUnhvRr/2JXE15Db/S9BC/7bxHaHvrtFC/Yp2Jsk4gXG736A
         5P7ihHg02Y0kslROeKiyHBgSU4stLN27yt5EqBX3r+D4aa+abF9c+qLddWyHiF4J79ke
         a1psenrVI5MXY3fJI70yMEjCUQSCz3r7eFEhP7iLX4nPMs2Pph9wWpu/yQ6dEEMtoflH
         6OTCsWfLF9H0MmwJJGJfBbd6o2do3zeel9fEx0x6AjF7at3XdBFdN2EuNcjAFlMadJ/H
         bv5lKA07EevD7C3oaqjds6lj5uGc0iI9uytZAhZmq835soX9ALawHMelAG1SUPMfUpZz
         2uSg==
X-Forwarded-Encrypted: i=1; AJvYcCWnPkwRfJPe17fo+R6/VlIlorRj09XlOB4fBjU+zYCaUhLjNTyr0kmUuIWJnMq7j2UpsEN6mCIs9MLPbpnMBi4PMiREZFzDb39sHbKP
X-Gm-Message-State: AOJu0Yzky6WolciHEyf+94cqeseSAKo4z4PTC033oV3+RcR/fxbAbLAJ
	WLSJQltOUe8KOjCXcfRfp4SBdwlu8sQWqsLMVpIsTFHhctRq2lO5bgYzN8htjw==
X-Google-Smtp-Source: AGHT+IHCEXCkkicFHPqzMoJYtv957hUagwd50f9Vz56pVIGqLDE1HWdz5aTIjyYY+wc/RBG4HywTog==
X-Received: by 2002:a05:6808:2e4b:b0:3c3:8830:86fe with SMTP id gp11-20020a0568082e4b00b003c3883086femr3449028oib.12.1710746359276;
        Mon, 18 Mar 2024 00:19:19 -0700 (PDT)
Received: from [127.0.1.1] ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006e66c9bb00dsm7387515pfn.179.2024.03.18.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:19:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 18 Mar 2024 12:49:05 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650: Fix the msi-map entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-pci-bdf-sid-fix-v1-3-acca6c5d9cf1@linaro.org>
References: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
In-Reply-To: <20240318-pci-bdf-sid-fix-v1-0-acca6c5d9cf1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=rq/JWeJfwa+47UTE5z66gjbDrTKJLAljsi84x0YRn1E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl9+rqpS3tSZyn5nT5m8XnYf433vP7qur3M016c
 weAuR6t29WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZffq6gAKCRBVnxHm/pHO
 9Sm0CACbPTZu35ob3v4W4ZENolLAtUV5EG/zM1Pxidibyfa06T/ak/gljL32kJjKT/+kwc+ZAxg
 IXs2VabHIxsQ6rgqmVa2OqMRjU1E8gLzDTpBCmAC/0afS/qdj3fsmIXGpZd9xqp68SzDbthmBLG
 Zr+jVZDmNWSh7sqtyqT6NDJZlPy5KbyBnZ4RU5lnYq5S4guFnl+FB/NvJyIK0ox2T6z/P14fJxU
 4eSgmVm0aZESSDPdHGMUrIL8LUOnC4pZUaBMTtbr8ah1vhRCGln5l+r9xHaWbrbfYVMsq8bepyq
 7QImZZoJeVD2853iiC/klWcHXkUNiMiicYZ/y9OkidjzVfez
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

While adding the GIC ITS MSI support, it was found that the msi-map entries
needed to be swapped to receive MSIs from the endpoint.

But later it was identified that the swapping was needed due to a bug in
the Qualcomm PCIe controller driver. And since the bug is now fixed with
commit bf79e33cdd89 ("PCI: qcom: Enable BDF to SID translation properly"),
let's fix the msi-map entries also to reflect the actual mapping in the
hardware.

Fixes: a33a532b3b1e ("arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..eb117866e59f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2274,9 +2274,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interrupt-map-mask = <0 0 0 0x7>;
 			#interrupt-cells = <1>;
 
-			/* Entries are reversed due to the unusual ITS DeviceID encoding */
-			msi-map = <0x0 &gic_its 0x1401 0x1>,
-				  <0x100 &gic_its 0x1400 0x1>;
+			msi-map = <0x0 &gic_its 0x1400 0x1>,
+				  <0x100 &gic_its 0x1401 0x1>;
 			msi-map-mask = <0xff00>;
 
 			linux,pci-domain = <0>;
@@ -2402,9 +2401,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interrupt-map-mask = <0 0 0 0x7>;
 			#interrupt-cells = <1>;
 
-			/* Entries are reversed due to the unusual ITS DeviceID encoding */
-			msi-map = <0x0 &gic_its 0x1481 0x1>,
-				  <0x100 &gic_its 0x1480 0x1>;
+			msi-map = <0x0 &gic_its 0x1480 0x1>,
+				  <0x100 &gic_its 0x1481 0x1>;
 			msi-map-mask = <0xff00>;
 
 			linux,pci-domain = <1>;

-- 
2.25.1


