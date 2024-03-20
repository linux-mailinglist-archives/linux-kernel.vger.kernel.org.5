Return-Path: <linux-kernel+bounces-108580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215E880C92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373BA283CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDE3B1AB;
	Wed, 20 Mar 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qweS+dAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8952BD01;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921499; cv=none; b=YiUaEl3bTfh3HdK7cYJLifATQ95tSXP5mbGsn2e96RLKQePWbwkC5FCeAGXoO9jBNMAwDhtjR1i8V97pg0rXG1r7/6Z1vZ+4c7SdWcXZEvjcSWVAXVxhWe5kZU3Dj92j4Uf6N/1ggE/hwMXGeOX/pYheE2MKTeefyw8onF+zunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921499; c=relaxed/simple;
	bh=Vmdh+vWcv9Qh7j4Gv87DPTe0KSHtausnDIvXv9rreDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNPHFemXfdAizBsUKRgcUDOvt/fa7nWjOwjZTKKX1EEZEkMK/Nzn2X1QyISb7P0jHbLbw9h00g/oyuUArpohYhSLMsG/bEtzCIRRlKisLF4ypHFjTN/xq7AdfoWMoYijM0vGSc1lpCGvfqI1hHgp28N06e3SFErR6tlnUgN7hp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qweS+dAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B31FC433B2;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710921499;
	bh=Vmdh+vWcv9Qh7j4Gv87DPTe0KSHtausnDIvXv9rreDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qweS+dAdyHfejLbT6tXXJbz5wveNirqZQNYgMtRMEsBJdFzJy91qJN9ZN0IA3L+dt
	 aooGZgm/1ZWXVPE/YA6+6wY2H/Qa73rcj/ZGXiD2uzBIcyYxTBilDXUMugQ1wojMLz
	 iiEK01ChERPXt9EphpqqFfDREeMLMbodoTioIuQadHKErR0Pt0weGQ/ugQ7rEeNY8m
	 iiK1j1/o38TXyJiuVNfRRNLwWc0//zxn2jCWiafYcNxuhqqKj9qCAw4xXg7Zsottqm
	 zg/Kt+0wiNPs6XU0PinoCQeNvACWwc5a5CJ73RRR4wwvk8Eiz27Sc8SQa9UFcy1Aq3
	 9YfZyz4Kh+Erw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmqq9-0000000029M-1Pp1;
	Wed, 20 Mar 2024 08:58:25 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
Date: Wed, 20 Mar 2024 08:55:51 +0100
Message-ID: <20240320075554.8178-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320075554.8178-1-johan+linaro@kernel.org>
References: <20240320075554.8178-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several Qualcomm Bluetooth controllers lack persistent storage for the
device address and instead one can be provided by the boot firmware
using the 'local-bd-address' devicetree property.

The Bluetooth bindings clearly states that the address should be
specified in little-endian order, but due to a long-standing bug in the
Qualcomm driver which reversed the address some boot firmware has been
providing the address in big-endian order instead.

The only device out there that should be affected by this is the WCN3991
used in some Chromebooks.

Add a 'qcom,local-bd-address-broken' property which can be set on these
platforms to indicate that the boot firmware is using the wrong byte
order.

Note that ChromeOS always updates the kernel and devicetree in lockstep
so that there is no need to handle backwards compatibility with older
devicetrees.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..fdaea08e7442 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -94,6 +94,10 @@ properties:
 
   local-bd-address: true
 
+  qcom,local-bd-address-broken:
+    type: boolean
+    description:
+      boot firmware is incorrectly passing the address in big-endian order
 
 required:
   - compatible
-- 
2.43.2


