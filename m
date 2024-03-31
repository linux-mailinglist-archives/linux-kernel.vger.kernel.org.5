Return-Path: <linux-kernel+bounces-126377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE38935F8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C071C21066
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0861494D3;
	Sun, 31 Mar 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC+40ww/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607621487DF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711919449; cv=none; b=XuORlNbZPo5P61i7EUYTP5hGommhVwxkQryZ1812+wgvfi+wh1CIRCutTpesldLUoeDZqcSE8+RlKL3xsaUg+Q3byrxVGkdxiQV+Y1IxvVe8HV832/zImOY441TTLgLNe7vVdXwjZ3J20EsKVAH8ni9Ae67czF9Hgcsevg7n32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711919449; c=relaxed/simple;
	bh=+monmzdqaDuGF+91NgZ2OzAyov6DJsof4fu61GAW+E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIESxdZLEioH4AmFSRf/Ue/uGbBvDRaFS86rn7GUuIgKjezRhxYe+q3CxCg3amqdULT4SRw3pV4Be6BdqdV9JleZmgkkafKhZZkv+rZSoSKHclIjo4iJrhUPezjDp3v1j3zo1xD7T1abqCen16UO5ZJ8DMwD+DNuFd0gJ9ay//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SC+40ww/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515a86daf09so4274044e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711919444; x=1712524244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wh00IZ4XaNzJ01D9sGevctvSevNDF/uBs0GVWtGKSA4=;
        b=SC+40ww/QaITJUTw1R6HQl+2cNPNtBddGW4Eyl+PhIfhL5bCotPWD71mE40HoSq+FR
         /D/VoU5UuBf/9/e8Nn4nfn+/JJpjngTm72wt8Zubxzex6VGPRphyqaH0pC4/k5NADX1s
         UrCR6A4N+78C8Zhgc+PzvvlN1Q7eu1GOyJi090rW/zct3WJj/ec0lwIDYXUAEQfPIewn
         S8ngo5YgRfvOs/ER4PBh6F0wN4knzztpg6b5qdTGEe2w+ktiA2NF7CS2e3k7Drt1oBAv
         1P/A07TVFPBwRmr1+kxzllwzIkBNGWcMuSubjhr99bBsQ0nt2coofrYOIElrszmMYm/d
         BHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711919444; x=1712524244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh00IZ4XaNzJ01D9sGevctvSevNDF/uBs0GVWtGKSA4=;
        b=uFtsopg9nz+hpFpp5T9mVrJU8wchkFwJuJjz7lTPGpFUoQQVOgca7Z9yUVchEqNJAX
         2G4LRo9TRu1sx0Kbjp3FmwUaGBcpIx4swETbi64GAipeUuY96kwjmLkKmAgDZeDeNNkM
         w2GOTtF1EUgOMueZzE/HY1las7gOc+BzcKpmorUHVVQky804FQ1oFHjbOy18/MOU/qbF
         GCVQiE1Xk5gkaRfJqoEhTro/wF7jGCsSDhsdNSWvpWhkfWK2HFdKn5Y/+Pc6Z7lp8tUl
         MvgUF64tXvN0Zk5bhu9dOpSYzHqr1Vr9i+a/x2ytm3gXVAxroxPzAab/78IaJeVhqqML
         UwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuRRYMXUCvODa0b7PHtP0PZhi56Cm92RKMae1PrBM9GI0c3OcgmsxlcrJ7ZjXnJXzFkvLeoXyOTwzuuz2woE0MH7izaJSZBXSt+pO3
X-Gm-Message-State: AOJu0YzfvnHY8ZR+pdYMN1R19BV2Sb4MbZnPnHRjr/aDsthkXL2TLqkx
	KDBF8izrD/kXr3STkMb7xq0NnSFkPhL32KAiuBX40ZvbEkTMgtdOx1ghWWozC4k=
X-Google-Smtp-Source: AGHT+IFt8FdYLoAb7m1w/IZp2TCwGPaIlGE+lQIq6cHWMX0LD+g6P261WhyUH/jTgtg6qTcxBkyOeg==
X-Received: by 2002:a19:5e19:0:b0:515:d2f1:1cbc with SMTP id s25-20020a195e19000000b00515d2f11cbcmr5140423lfb.28.1711919444555;
        Sun, 31 Mar 2024 14:10:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i1-20020a0565123e0100b00515cd1d5c99sm1033553lfv.85.2024.03.31.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 14:10:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 00:10:43 +0300
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996: add glink-edge nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-msm8996-remoteproc-v1-2-f02ab47fc728@linaro.org>
References: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
In-Reply-To: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+monmzdqaDuGF+91NgZ2OzAyov6DJsof4fu61GAW+E4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCdFSD/mfhrrDqt+bZbH8YWUTQeVVLed4W/B23
 XdRoMkFiVyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgnRUgAKCRCLPIo+Aiko
 1SSOB/42UABi2MQUOuV1HAREycJq3MYMD+dBv1P72Dr2HbR/A7e9jXDWIEyg4/LaNhuPPXEYHgE
 xslCSuhmi5+bYJVcO/uPhl0UYZJwyrHH7/2aFyV24Et6j6DgKItB3XwldMcbgBc27vIQPwsGFbQ
 UqV1+NBd5oI3ykd2ieXkwXh5fOM+9fSuqBZ8bqp8J1cigzOHZ7pOBA2etR4g7288CylEbwUhvLk
 MZBU03r3fr2mr1Q2RJrVTy/0bLBUXvAP/ddBSnmAh+RAArcRhMBTjKSX1GlLD8OX3kc+gfP5BaL
 g7m40BRPQaI8Pf1dgysWdFGiC+l1eLZIYxBbMWtrx97Q8UiY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

MSM8996 provides limited glink support, so add corresponding device tree
nodes. For example the following interfaces are provided on db820c:

modem:
2080000.remoteproc:glink-edge.LOOPBACK_CTL_MPSS.-1.-1
2080000.remoteproc:glink-edge.glink_ssr.-1.-1
2080000.remoteproc:glink-edge.rpmsg_chrdev.0.0

adsp:
9300000.remoteproc:glink-edge.LOOPBACK_CTL_LPASS.-1.-1
9300000.remoteproc:glink-edge.glink_ssr.-1.-1
9300000.remoteproc:glink-edge.rpmsg_chrdev.0.0

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1601e46549e7..7ae499fa7d91 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2453,6 +2453,13 @@ slpi_pil: remoteproc@1c00000 {
 
 			status = "disabled";
 
+			glink-edge {
+				interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+				label = "dsps";
+				qcom,remote-pid = <3>;
+				mboxes = <&apcs_glb 27>;
+			};
+
 			smd-edge {
 				interrupts = <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>;
 
@@ -2522,6 +2529,13 @@ metadata {
 				memory-region = <&mdata_mem>;
 			};
 
+			glink-edge {
+				interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 15>;
+			};
+
 			smd-edge {
 				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 
@@ -3467,6 +3481,14 @@ adsp_pil: remoteproc@9300000 {
 
 			status = "disabled";
 
+			glink-edge {
+				interrupts = <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apcs_glb 9>;
+			};
+
+
 			smd-edge {
 				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 

-- 
2.39.2


