Return-Path: <linux-kernel+bounces-155538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7088AF3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075D7287A28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E513D24D;
	Tue, 23 Apr 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg4DuW3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427513CF8E;
	Tue, 23 Apr 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888899; cv=none; b=QbGEXPtgFB0CE6XHO3nkSLrJ9mzBEO5LAcjSR4F4mTGBK/eWbKQtmY1I9d7oN+IX+XjptKO2ZNR3aQXYmYdYA3QP0Jop3tVqLQPOevA4KVcROD3By+fW8sb+0HX3pqhDNmMuRZ9h+8ZOyVFu5BzM6702IvHJmrYLMx/T4oz0v6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888899; c=relaxed/simple;
	bh=t7XLkcm58+fVaHmvoGJBrl7ku5VBGktXbbg2zBpZuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsgyxqeNpyFw9i1Lcxz9Ele4DvxDQXUq1tPf5LDMkv3ZofssLXBUebd9UPzRd7ODLEUeYcmYVk4tTsknjZjJr/H+ynJ58rz2ZO2+th5jk0VmpTKSPmuZFglq1g5MX0lmZdRNYppfWriwlcZYvLNVFZ1Lx6Sc/htea4GMO9FxOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg4DuW3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA4DC116B1;
	Tue, 23 Apr 2024 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713888898;
	bh=t7XLkcm58+fVaHmvoGJBrl7ku5VBGktXbbg2zBpZuc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg4DuW3RNJCx0k8isuY+Ww1E+jHZuB8iSnEvLhywPSku0gOCtXY+EiNIimYtjcHyb
	 czaYkSR80eGrk3Gir/VJZw6eLCXDEGuDsfk3hUp/YJQCQoPCgCTixRfd+RCBtvKUy0
	 NVlvAlwVCLOSwJyTxKriGkPfgSZ4xpFvVfIqqnt9cfwkq84eJuxaRdTaHWVxV4WSFM
	 95bmMcyDqNaq0EPKZZgPS9fb+MLJXEGN76oVZeu0ilgwflUtvMhEaWBtVZw0/Z6RX/
	 uWz7868bxHwjmKEmotlqb9vHKR9la8g6bsorfYZA49AkyX2g6DEa/dnzpEa8JBmiyp
	 o0s+c5pz3u0TA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sinan Kaya <okaya@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: dma: Drop unused QCom hidma binding
Date: Tue, 23 Apr 2024 11:14:12 -0500
Message-ID: <20240423161413.481670-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423161413.481670-1-robh@kernel.org>
References: <20240423161413.481670-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QCom hidma binding was used on a defunct QCom server platform which
mainly used ACPI. DT support in the Linux driver has been broken since
2018, so it seems this binding is unused and can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/qcom_hidma_mgmt.txt          | 95 -------------------
 1 file changed, 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
deleted file mode 100644
index 1ae4748730a8..000000000000
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ /dev/null
@@ -1,95 +0,0 @@
-Qualcomm Technologies HIDMA Management interface
-
-Qualcomm Technologies HIDMA is a high speed DMA device. It only supports
-memcpy and memset capabilities. It has been designed for virtualized
-environments.
-
-Each HIDMA HW instance consists of multiple DMA channels. These channels
-share the same bandwidth. The bandwidth utilization can be partitioned
-among channels based on the priority and weight assignments.
-
-There are only two priority levels and 15 weigh assignments possible.
-
-Other parameters here determine how much of the system bus this HIDMA
-instance can use like maximum read/write request and number of bytes to
-read/write in a single burst.
-
-Main node required properties:
-- compatible: "qcom,hidma-mgmt-1.0";
-- reg: Address range for DMA device
-- dma-channels: Number of channels supported by this DMA controller.
-- max-write-burst-bytes: Maximum write burst in bytes that HIDMA can
-  occupy the bus for in a single transaction. A memcpy requested is
-  fragmented to multiples of this amount. This parameter is used while
-  writing into destination memory. Setting this value incorrectly can
-  starve other peripherals in the system.
-- max-read-burst-bytes: Maximum read burst in bytes that HIDMA can
-  occupy the bus for in a single transaction. A memcpy request is
-  fragmented to multiples of this amount. This parameter is used while
-  reading the source memory. Setting this value incorrectly can starve
-  other peripherals in the system.
-- max-write-transactions: This value is how many times a write burst is
-  applied back to back while writing to the destination before yielding
-  the bus.
-- max-read-transactions: This value is how many times a read burst is
-  applied back to back while reading the source before yielding the bus.
-- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
-  Once a reset is applied to the HW, HW starts a timer for reset operation
-  to confirm. If reset is not completed within this time, HW reports reset
-  failure.
-
-Sub-nodes:
-
-HIDMA has one or more DMA channels that are used to move data from one
-memory location to another.
-
-When the OS is not in control of the management interface (i.e. it's a guest),
-the channel nodes appear on their own, not under a management node.
-
-Required properties:
-- compatible: must contain "qcom,hidma-1.0" for initial HW or
-  "qcom,hidma-1.1"/"qcom,hidma-1.2" for MSI capable HW.
-- reg: Addresses for the transfer and event channel
-- interrupts: Should contain the event interrupt
-- desc-count: Number of asynchronous requests this channel can handle
-- iommus: required a iommu node
-
-Optional properties for MSI:
-- msi-parent : See the generic MSI binding described in
- devicetree/bindings/interrupt-controller/msi.txt for a description of the
- msi-parent property.
-
-Example:
-
-Hypervisor OS configuration:
-
-	hidma-mgmt@f9984000 = {
-		compatible = "qcom,hidma-mgmt-1.0";
-		reg = <0xf9984000 0x15000>;
-		dma-channels = <6>;
-		max-write-burst-bytes = <1024>;
-		max-read-burst-bytes = <1024>;
-		max-write-transactions = <31>;
-		max-read-transactions = <31>;
-		channel-reset-timeout-cycles = <0x500>;
-
-		hidma_24: dma-controller@5c050000 {
-			compatible = "qcom,hidma-1.0";
-			reg = <0 0x5c050000 0x0 0x1000>,
-			      <0 0x5c0b0000 0x0 0x1000>;
-			interrupts = <0 389 0>;
-			desc-count = <10>;
-			iommus = <&system_mmu>;
-		};
-	};
-
-Guest OS configuration:
-
-	hidma_24: dma-controller@5c050000 {
-		compatible = "qcom,hidma-1.0";
-		reg = <0 0x5c050000 0x0 0x1000>,
-		      <0 0x5c0b0000 0x0 0x1000>;
-		interrupts = <0 389 0>;
-		desc-count = <10>;
-		iommus = <&system_mmu>;
-	};
-- 
2.43.0


