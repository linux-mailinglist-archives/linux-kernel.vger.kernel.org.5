Return-Path: <linux-kernel+bounces-108581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD4880C91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504D3283CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205C3AC10;
	Wed, 20 Mar 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRYtmJoT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8632BB19;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921499; cv=none; b=J1tWVlR8KfIJZdNgytDKo38pPv+wpLFibIFcuI+WlVlCB5e2JRsubivwbDdnjPnK9fAhs7+n8fBf4Bdhryz+c8EHYpyVgoJBK2nfeQXj97/ccppYJr02rnOz+X6O6cv9xjmgeb+mZdI/IWpIjiZJrZBCtAL4Ah/BoW5vgh5qlwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921499; c=relaxed/simple;
	bh=+dlcEg2uBrLolIuIaoI2lAxqlNTQCPQTLcUqxo2cAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcfn2I1mcPuKbdJx9deT87WnEbARZPjoOJy0qxr+riOIYTEI1mpQuLdfLYa98PvX7+p9GZ+LLnszvZOUyAyi26caOJQaM7nM5QqIrspnk0L6OkWlovfuNiVYHZ0fJuXuCh02x8Sz+Pw8lPoUM+XJIz/5TGeNgDp+RSofc6Yr/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRYtmJoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173DAC43394;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710921499;
	bh=+dlcEg2uBrLolIuIaoI2lAxqlNTQCPQTLcUqxo2cAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRYtmJoTUo0d4GOg2jNXCJa60EBGAiVFeTa6y/xw9sTQ/Qa+uWkYiqDlF+mR1LrWH
	 aLPvv/CM9w03SdmkYYUqBCHQ9Cqe6pB6S1asVKPxqukWYqHcViL0yq2xurZM1KXyqt
	 6wIIslSPHpwRcHQxaBbB+kk0hSL8JbyG0My0p/Si3Q9nowITUisWwvR/To9bKJlZZN
	 kxRzZtlY+gzlIXl+xAsXajnImLf3JiMgRWVxvhUCSUOrFMfBG7s5/L1rq36OHiyn3h
	 1jIjdRfh4MYT97WHD+VXOMRZSQfOoO8vaTSnqAahrAJoFWpKyQRFf7QjgbW8EtKTdd
	 N1hUyeqQlRt6Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmqq9-0000000029O-1k05;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 2/4] arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
Date: Wed, 20 Mar 2024 08:55:52 +0100
Message-ID: <20240320075554.8178-3-johan+linaro@kernel.org>
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

The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
so mark the 'local-bd-address' property as broken to maintain backwards
compatibility with older firmware when fixing the underlying driver bug.

Note that ChromeOS always updates the kernel and devicetree in lockstep
so that there is no need to handle backwards compatibility with older
devicetrees.

Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
Cc: stable@vger.kernel.org      # 5.10
Cc: Rob Clark <robdclark@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba28604..ebe37678102f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -943,6 +943,8 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
+
+		qcom,local-bd-address-broken;
 	};
 };
 
-- 
2.43.2


