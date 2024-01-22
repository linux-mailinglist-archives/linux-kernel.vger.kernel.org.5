Return-Path: <linux-kernel+bounces-33611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC320836C47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EC71C26C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2915FDB5;
	Mon, 22 Jan 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdS7dzKc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0D47784
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937904; cv=none; b=NTntq38LNUoq2znbzf+WhCW2L+ieqh33yIfxRaQMZrw+2iTqzjWHDH3gfbM8UpPTiW+EDG5sg8xpNy6EUQ3ZN2hMlRzJcUinaBOCM+GbmSAekDHivl9/GMNayCVenYoPKoB2ZbYk4FlJWNt9yO6WW04gG5Ve1iM1Tb+9Of4ZY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937904; c=relaxed/simple;
	bh=JrTlR1yh1kUdkwX7KafITLJvsRjLZG25nzdjxKTbheM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uhf1lOdbaPkvGQhSvXRILk9Nqu+hgjoZ6eEodr9NJOVa4OdB9JEnW5TQiH5yhhJV/UP4wKyjL9BdAqHd2ff42v/4OeAcPuLjIe7QvP704QOHfF3SQMpQnTFBfMmGLraaPkCeCfnezgN6tHfausOvFyR0Oe+Eb265Kia9K2wNf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdS7dzKc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7065b692so36479645e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937901; x=1706542701; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjrEpWeMJdq09/Vth3t/64U8dNgnTEbo+R/yOccaErE=;
        b=HdS7dzKcRiF18BSJIuqaayov2/RNaqOKRLp+sMT0eYiq45sT+r/AxHBXRcm/KaWbL+
         SGDpcuGIOWKA42pfhTZty785ww9UsLRop2TadwxpcUEQA4XXEgXqbuf4KiQ2NBebfDb+
         aedeJOEoL6w9tCI2ktWUoaBt4JB/U3HcSySceib8X9mBU9v7FkSn4AgvWyrEEJxnZnPr
         gS4gahNqWuuu/m+v5tnM9Hh7Q5xjUMhnzTNrKFzBxoO+Yu8406VZl3gMdohjljrfO6+5
         V/FfcZY6JSOVnyur7MkH4dJjtlF4omuYYSz8DS6S/xFhVwEOsmMZQjYbEkCM1swn1uTN
         sxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937901; x=1706542701;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjrEpWeMJdq09/Vth3t/64U8dNgnTEbo+R/yOccaErE=;
        b=nyfK1LpNyfJNTeoFjvWP0agPyJtZSmEn4FUSKYvBlLHvCJ9And25bbezWK1kUdFcY1
         vji8yi9ho9P5C0+h4o7c1UC2gNvMDc3a0cd12C/2UFZWJUOWMvRFySDVcJskEbDqZsN9
         +KvMEXjAym7SGW3Pdl/xDJBYqqLWdgRvOgWXW1mJfU5VClNj/yt3+xEqbhuxE5nkIfrR
         aEKZYZbbRTI+IMrqttZ7TcjC75PVKUpGEHZdFquArN1fg2sgjgatMPtnLklK62RWzVV3
         6KvdebQFf9xb8118DOt/8dM8wJZHPcovyBeXb/7EGmSPSDe8z5u2Gwu8Io7iddyljEXT
         JVcg==
X-Gm-Message-State: AOJu0Yy8bbh4Pq5l+++QTsi20qomY8Be/C/JdQmPawk5LwVrZqgwvgI0
	elznN1rw1tdKml+QrlVn2LS4SKq7/wRhNIRrlZ13tgGyYzmpCuKUHa5y3crHBaw=
X-Google-Smtp-Source: AGHT+IHtTraeTNo/j0x8myQ20pblTIX4ITUkbtxQP7MBf8dxu4qn14b7VISoC/ZpBbAhfDC9W4fc2w==
X-Received: by 2002:a05:600c:3d0e:b0:40e:6272:b5ac with SMTP id bh14-20020a05600c3d0e00b0040e6272b5acmr2456111wmb.99.1705937901536;
        Mon, 22 Jan 2024 07:38:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040e5e21cd7bsm38969066wmo.11.2024.01.22.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 07:38:21 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Jan 2024 16:38:17 +0100
Subject: [PATCH v2] arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and
 PCIe1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-topic-sm8550-upstream-pcie-its-v2-1-b3398d86d1f1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOiLrmUC/42NTQ6CMBBGr0Jm7Zi2AfxZeQ/DojItTCK0mVaiI
 dzdyglcvi9f3lshOWGX4FqtIG7hxGEuYA4V9KOdB4dMhcEoUyttDOYQucc0nZtG4SumLM5OGHs
 uz5xQtb5+tJq8uxAUSRTn+b0H7l3hkVMO8tl7i/6tf6sXjRqt9w0pOlFLdHvybCUcgwzQbdv2B
 T+q/zjNAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5170;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JrTlR1yh1kUdkwX7KafITLJvsRjLZG25nzdjxKTbheM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlrovsPRxor1Hb6gKIHm7/1VE8wAxfG+GPN7tPdRLq
 gi5kiLKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa6L7AAKCRB33NvayMhJ0eNKD/
 0QNbjFpU19ERNfyesK5PgMCelH/N0ULCkVyAa7cNkmn3jifkrCzPpzeEKfw4GAATXqXtI4yUIrOK2f
 bR1dfmFS7t4Ic/7UOxexZvXc3PxDnsNKYMfHy1boBX7L50KMbGltkFBcjmxVl9fzFuqvGCCXs9s45D
 BAeP+LMARQoRwO6ZH9yF1hSuzn1lfKeNp1sewRCOKwqdyaTZewaPLbdta/a5y6A6N7DrBcBK9+Kiv7
 uSLrObdLqqHr1nr8qQv51yIiow8McbTLBei3Dh5zlbPpjlIyz6ke1D5d7fT/b7iz0LsCmp7uchh4Wg
 4/0ouBntvNsRSqcADXrk6iDiM6FRzcU8Cwi9vVOKpVTpgSlK7e5pG+9VrrfkXXN92AJRRQuQdJEjeL
 BwnjApD01zGK8/wmMrPE6GGp77P9BLct3rkWgPCLmMT/q6CxvCkmgp5izblVd7MRYZDC2m9wmOe9Vv
 2dKjrIj97/rExnM3SVuDSQI7fNFx0sa9qlcttEyREDIREulBlo53QbEq7i7QqLjTG8u6MRctarVc2b
 LS9tswl3cGtOVPUwb0BwCZLGGcC76hLeO4mdNbR4wByvDw3nLcm6ixaPWCqKxljyK88IUbrH66dTRM
 /GFJB+0UAI9B5hAOg6x/pGlu8j6av2nxStOpNJ7g8aR3Lji3QrrWvJnrKGZQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
received from endpoint devices to the CPU using GIC-ITS MSI controller.
Add support for it.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

Like SM8450, the IDs are swapped, but works fine on PCIe0 and PCIe1.

WiFi PCIe Device on SM8550-QRD using GIC-ITS:
218:          0          4          0          0          0          0          0          0   ITS-MSI 524288 Edge      bhi
219:          0          0          5          0          0          0          0          0   ITS-MSI 524289 Edge      mhi
220:          0          0          0         33          0          0          0          0   ITS-MSI 524290 Edge      mhi
221:          0          0          0          0          3          0          0          0   ITS-MSI 524291 Edge      ce0
222:          0          0          0          0          0          1          0          0   ITS-MSI 524292 Edge      ce1
223:          0          0          0          0          0          0         38          0   ITS-MSI 524293 Edge      ce2
224:          0          0          0          0          0          0          0         31   ITS-MSI 524294 Edge      ce3
225:          0          0          0          0          0          0          0          0   ITS-MSI 524295 Edge      ce5
226:          0          0          0          0          0          0          0          0   ITS-MSI 524296 Edge      DP_EXT_IRQ
227:          0          0          0          0          0          0          0          0   ITS-MSI 524297 Edge      DP_EXT_IRQ
228:          0          0          0          0          0          0          0          0   ITS-MSI 524298 Edge      DP_EXT_IRQ
229:          0          0          0          0          0          0          0          0   ITS-MSI 524299 Edge      DP_EXT_IRQ
230:          0          0          0          0          0          0          0          0   ITS-MSI 524300 Edge      DP_EXT_IRQ
231:          0          0          0          0          0          0          0          0   ITS-MSI 524301 Edge      DP_EXT_IRQ
232:          0          0          0          0          0          0          0          0   ITS-MSI 524302 Edge      DP_EXT_IRQ

NVMe in SM8550-HDK M.2 Slot using GIC-ITS:
212:          0          0         22          0          0          0          0          0   ITS-MSI 134742016 Edge      nvme0q0
213:     133098          0          0          0          0          0          0          0   ITS-MSI 134742017 Edge      nvme0q1
214:          0     139450          0          0          0          0          0          0   ITS-MSI 134742018 Edge      nvme0q2
215:          0          0     139476          0          0          0          0          0   ITS-MSI 134742019 Edge      nvme0q3
216:          0          0          0      69767          0          0          0          0   ITS-MSI 134742020 Edge      nvme0q4
217:          0          0          0          0      80368          0          0          0   ITS-MSI 134742021 Edge      nvme0q5
218:          0          0          0          0          0      77315          0          0   ITS-MSI 134742022 Edge      nvme0q6
219:          0          0          0          0          0          0      73022          0   ITS-MSI 134742023 Edge      nvme0q7
220:          0          0          0          0          0          0          0     329993   ITS-MSI 134742024 Edge      nvme0q8

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- fixed commit msg
- Link to v1: https://lore.kernel.org/r/20240122-topic-sm8550-upstream-pcie-its-v1-1-aff5d0d7d6dd@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..9860bda3be1d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1742,6 +1742,9 @@ pcie0: pcie@1c00000 {
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
 			interconnect-names = "pcie-mem", "cpu-pcie";
 
+			/* Entries are reversed due to the unusual ITS DeviceID encoding */
+			msi-map = <0x0 &gic_its 0x1401 0x1>,
+				  <0x100 &gic_its 0x1400 0x1>;
 			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
 				    <0x100 &apps_smmu 0x1401 0x1>;
 
@@ -1838,6 +1841,9 @@ pcie1: pcie@1c08000 {
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_1 0>;
 			interconnect-names = "pcie-mem", "cpu-pcie";
 
+			/* Entries are reversed due to the unusual ITS DeviceID encoding */
+			msi-map = <0x0 &gic_its 0x1481 0x1>,
+				  <0x100 &gic_its 0x1480 0x1>;
 			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
 				    <0x100 &apps_smmu 0x1481 0x1>;
 

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-topic-sm8550-upstream-pcie-its-06f4b61dfe9d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


