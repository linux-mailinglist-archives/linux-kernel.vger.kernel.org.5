Return-Path: <linux-kernel+bounces-107715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF78800B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E99EB21E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FE82867;
	Tue, 19 Mar 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suoOUA+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B3651B1;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862193; cv=none; b=SOdmJkCGOc6D8BkaBOTlz1V8yIstTemC08XrkKmGkFOEMryEWeSSYzhUwHfBl398yHN2NS3RPngXl0FKcklVe1lkd1EQ1bKHEg/maqrWvjKH6EMjfcP6RyszJr24rLFcjEFR6+9X+pHQP+rcmc+7IUgd3K/1OYwEz61A9ghmKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862193; c=relaxed/simple;
	bh=hMyiu5JK/7MAu6W+diFQKH4vE96KDUmzS3ovObG9hKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrWnKlTgQQoSbbjFk20p2mGo0SrTor7CXKakDYnKVd22iQW+tWZiL4dwkUXKEShusH1lXfeyI65iXxZLRJckL69CrsQjs5nxnsA+JZAlzFOlae/pGuIcJcHm8yX7MaANh+T8JSC84ziLTRob3TEGEV43kRz65AbgKuCcGQq3b7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suoOUA+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA9EC433A6;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862193;
	bh=hMyiu5JK/7MAu6W+diFQKH4vE96KDUmzS3ovObG9hKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suoOUA+ROqkzwuq7B7Wh2oMLPEVi8Dqauv+pedDROEQHjz9v6OxvRCdEyuOq9txaY
	 IO1gre9BzJJanX37PxUbB2mDkqxSAUtd7JfzMOSI/KQX4ZxXyo+s+MMcBjsGYCqHuU
	 3rbD5agXgzM5OEmQ8LpKZb/Z/Sf48CSiCEhzYzfk7n2r1vONn9Rimtbq/70Qmx03Jk
	 n6ATxDRFPFKIt6Qz6NHUVxaTxu/hxRcnV9W6qNp0FyHR28sFpL4S5S4Q4eZvn6O/b6
	 qwIrCsaBbwBvxRp2jvkjgeUncGJpMJwRLei2y11YboJAgdWFt8l9LUMfIMcEdJzvxn
	 jrqi1/emkelEQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbPb-000000000LF-3Dca;
	Tue, 19 Mar 2024 16:29:59 +0100
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
Subject: [PATCH v3 1/5] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
Date: Tue, 19 Mar 2024 16:29:22 +0100
Message-ID: <20240319152926.1288-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319152926.1288-1-johan+linaro@kernel.org>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..e099ef83e7b1 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -94,6 +94,9 @@ properties:
 
   local-bd-address: true
 
+  qcom,local-bd-address-broken: true
+    description: >
+      boot firmware is incorrectly passing the address in big-endian order
 
 required:
   - compatible
-- 
2.43.2


