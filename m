Return-Path: <linux-kernel+bounces-108579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B313880C93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E9B2150F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E373B78B;
	Wed, 20 Mar 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi/g16Rm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82B29D05;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921499; cv=none; b=fdGUCds96FTdPXPAx0h/9F58JFlfvdAEiYFeoN04bLLYZ4rbHx35rSmialeZygHXAJJLt/CH57INc5sTAS09E7RVp4T0qxHqnQKsQ14YGYujvvUcwGMQaA1nPbXPzxSkhI3rJbqsIhWouXSIMCnGWdtxJlJOgnqfKRsjDTWDJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921499; c=relaxed/simple;
	bh=yZx/K20JjSPqfrFqUfwkuy4b3Gm7kIvXWo3FmGJp2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwOaIwnh+6PILfrEguW2Py2bdOF1A+KJUiFnDdRo5ecMwEsyr8xm5h60KeoAO5Hbb7RKMtAiYpmG3wv5HBm6hb/EDO9swSejqXZVidDkQOdtIcLhuACCx5qm3/FZajJU8+z67iBzyw8DQ2BiAr3b/FJvMPTg02oedJWxdBR07oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi/g16Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E4C433F1;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710921499;
	bh=yZx/K20JjSPqfrFqUfwkuy4b3Gm7kIvXWo3FmGJp2ck=;
	h=From:To:Cc:Subject:Date:From;
	b=gi/g16Rm+GYdFT7LTMupu97ovAAxMYjApGXVMs4hTL4Uh+800w8LgChiwv9Nw2Sy/
	 rTWPFpRZJASJyNWt+Ud742tI39RnzcFWm2ROsklJBZjKg1WTssYjssfR8QMqVZiwLI
	 WtEJ9gsKPEcqcQenpT3C/IplOUpT7/mU+QRywpClvvGpC2aDn9X3z6mV2RYuTOwix3
	 dZgClgWjciRpyjVpZRT2WaVGN6Cc8O8GtbqSd34d/dC/Jut4esjSHPs+m2q3HZ6elI
	 ytTnv04uwV81EhyAVOYVX0Na6ZSDlZlwxx77O7IZ1q2mf06tj44QvO84EcAPv8e974
	 Raxs+myHg+OKw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmqq8-0000000029K-2Bv6;
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
Subject: [PATCH v4 0/4] Bluetooth: qca: fix device-address endianness
Date: Wed, 20 Mar 2024 08:55:50 +0100
Message-ID: <20240320075554.8178-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm Bluetooth driver is configuring the device address in
reverse order for none-ROME devices, which breaks user space tools like
btmgmt and the 'local-bd-address' devicetree property.

As these Qualcomm controllers lack persistent storage for the device
address, boot firmware can use the 'local-bd-address' devicetree
property to provide a valid address. The property should specify the
address in little endian order but instead some boot firmware has been
reversing the address to match the buggy Qualcomm driver.

This specifically affects some Chromebook devices for which we now need
to maintain compatibility with the current boot firmware. As ChromeOS
updates the kernel and devicetree in lockstep, this can be done by
adding a new 'qcom,local-bd-address-broken' property that can be used to
determine if the firmware passes the address in the wrong byte order.
[1][2]

Note that this series depends on the following revert:

	https://lore.kernel.org/lkml/20240314084412.1127-1-johan+linaro@kernel.org/

Also note that the devicetree patch (patch 2/4) is expected to be merged
through the Qualcomm SoC tree once the other three patches have been
picked up by the Bluetooth maintainers.

An alternative would be if Bjorn could ack the DT patch so that
everything can go in through the Bluetooth tree.

Johan


[1] https://lore.kernel.org/lkml/ZcuWQkmYK4Ax9kam@google.com/
[2] https://lore.kernel.org/lkml/CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com/


Changes in v4
 - add the missing type for the new vendor property to the binding
 - move the Trogdor DT patch after the binding patch and combine the
   endianness fix and Chromium workaround to avoid having any point in
   the series where the address is reversed on those platforms as
   requested by Doug

Changes in v3
 - add a 'qcom,local-bd-address-broken' property instead of deprecating
   the current WCN3991 binding
 - mark the bluetooth address on SC7180 Trogdor Chromebooks as broken

Changes in v2
 - add quirk to handle deprecated devicetree compatibles that expect
   broken address properties
 - deprecate 'qcom,wcn3991-bt' and mark it as broken


Johan Hovold (4):
  dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
  arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
  Bluetooth: add quirk for broken address properties
  Bluetooth: qca: fix device-address endianness

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml     |  4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi           |  2 ++
 drivers/bluetooth/btqca.c                              |  8 ++++++--
 drivers/bluetooth/hci_qca.c                            | 10 ++++++++++
 include/net/bluetooth/hci.h                            |  9 +++++++++
 net/bluetooth/hci_sync.c                               |  5 ++++-
 6 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.43.2


