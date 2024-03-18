Return-Path: <linux-kernel+bounces-106038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2887E834
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E61C216DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAA38397;
	Mon, 18 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi7e7brN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086B36114;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760139; cv=none; b=lPvXuQRmjA20J5j9QuJKvopDni8PE88KGISic82vc73M1ElJscwYfKC7JTdFjEf79BZt9v3G2lniF9BC7nkKh8t921fmev4FqhmlmYqrJ8+IM2xR5KkSdwC9OMzaUBSA1DeJxCR2hB8zwcyP3Z9C2fo8Dh6G/wDDw5CNVnW6UU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760139; c=relaxed/simple;
	bh=mhjPnTXDAKyCh4F3clJIfOplQLZbUUDvGVo1tP8zjxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PiV43lYB57KoBRkfwqCpv0dH6SC+zY+W+uxV6zINAdUMGEXclJOEv72lGPuJfHovpbDBDTCGUDAMM6PMk7zUX2aq1SBk3L7quTzGRXyM7g/xn55IJXuCm4YhUAIKeCDkZR5VMkJa6hd/Ioz6Gg5doubve14wnjdDcWAw7tCxX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi7e7brN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30265C43394;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760139;
	bh=mhjPnTXDAKyCh4F3clJIfOplQLZbUUDvGVo1tP8zjxM=;
	h=From:To:Cc:Subject:Date:From;
	b=gi7e7brNpeEEiGqha31+CSP1NEQEc9QkpM03FLGL30p4CLY/jWtCpbp4zmN25K2ZO
	 vJtMTj6pycCbkJqhK7bsS0OXjhaqH3E2GqBx5f2fbjLwKJ9S+lw+E+cPOrGqNswjV8
	 8B0jcTsJ3UHdq742LkN+2z+dh0xZwlNmctsFr7UQ8mUbkCf8DUyK0TGq2cX17+u1H2
	 2PC/hbjbF2uT4d5EzO1mggLZjoRmywPN3xhwen8Jfonrj3Rlh72i9iDqY/sM0Px5TZ
	 VBNus7xmewN+a+aO20Pdlb8cZqZ6GLxLKZ+07HzwYW5akc08VrQn9WarniSS7kbN/5
	 SNAeCcZX8c3kA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmArX-000000008Jj-3tpk;
	Mon, 18 Mar 2024 12:09:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] Bluetooth: qca: fix device-address endianness
Date: Mon, 18 Mar 2024 12:08:51 +0100
Message-ID: <20240318110855.31954-1-johan+linaro@kernel.org>
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
address in little endian order, but instead some boot firmware has been
reversing the address to match the buggy Qualcomm driver.

This specifically affects some Chromebook devices for which we now need
to maintain compatibility by deprecating the affected compatible string,
marking the corresponding devicetree properties as broken, and reversing
the addresses after parsing them. Fortunately, only 'qcom,wcn3991-bt' is
impacted and needs to be deprecated this way according to the Chromium
team [1].

Note that this series depends on the following revert:

	https://lore.kernel.org/lkml/20240314084412.1127-1-johan+linaro@kernel.org/

Johan


[1] https://lore.kernel.org/lkml/ZcuWQkmYK4Ax9kam@google.com/


Changes in v2
 - add quirk to handle deprecated devicetree compatibles that expect
   broken address properties
 - deprecate 'qcom,wcn3991-bt' and mark it as broken


Johan Hovold (4):
  dt-bindings: bluetooth: add new wcn3991 compatible to fix bd_addr
  Bluetooth: add quirk for broken address properties
  Bluetooth: qca: fix device-address endianness
  Bluetooth: qca: fix wcn3991 'local-bd-address' endianness

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 29 +++++++++++--------
 drivers/bluetooth/btqca.c                     |  8 +++--
 drivers/bluetooth/hci_qca.c                   | 11 +++++++
 include/net/bluetooth/hci.h                   | 10 +++++++
 net/bluetooth/hci_sync.c                      |  5 +++-
 5 files changed, 48 insertions(+), 15 deletions(-)

-- 
2.43.2


