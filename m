Return-Path: <linux-kernel+bounces-166354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD388B9980
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8773A28817B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA35FB9C;
	Thu,  2 May 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIrOzg5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D85E091;
	Thu,  2 May 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647424; cv=none; b=iuYIHZs37/uNAF0+xuxNw82YVbxou4cap2U6HPNnAjp+Xol80t8Z5cPcL+KvdbQUmJ4V0iqpPjg0IHlSXiC/N+pYq4Cxp+kbNdvQVeliNjUt57FrInlHg4WgBnAQwi5FtigxWgsQ0r6R9PxBFzDp3rUFBl72sZaGYq6pt36hPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647424; c=relaxed/simple;
	bh=GjJ6YPDCURvgqRp0kcZpR8S7PNcGHx6ACJsFfmIkVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DA/XX4D3lBVfsYI0UMpmKkTRMysCLaK9P6oVUyD3DXay2GMYpofIzMzduQukMDJDuDDNbeLlq1FfvKMrQitjrp1694nrW71L+DjODPpCNFAB6WAg1o7COjQACTCD+GOuZXEKwSQ4c95pc7lee7Nh4XCMJZhFF9Yj+2XJS4lrNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIrOzg5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66221C113CC;
	Thu,  2 May 2024 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714647424;
	bh=GjJ6YPDCURvgqRp0kcZpR8S7PNcGHx6ACJsFfmIkVFU=;
	h=Date:From:To:Cc:Subject:From;
	b=pIrOzg5lVuQgx7K0RpgqKVe9iRRkUjmWtvBs7ic7sPKfZegD7zPDdd7wxhIXBmDTG
	 wVLTD8n7ZJ1YTtPBxmg4eTRzaAogeXXk1LwHuMwYA6GBGypAOFZcrSLgvp/DTCehyc
	 flaawFhJZkUGQO/XkYh3wKXiOdZmrtqLf703LsSUQ/ZpK6Grtj5zIp10ZXTzYnTwl9
	 A3tCO1a6UVpsDgAgzghPTy3zAHD1iLisZ9NauAFVw4VF1hurFbn7kHZUzGBDsrKLyl
	 j/64HLhybBd5kLpUQ81cbIBUR6oR2ekVj8yVmEDL6zHbiFiQXOPs5B7GUjEuKNzIKj
	 I7FMt7yArLFig==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2U7Y-000000003uu-3ByM;
	Thu, 02 May 2024 12:57:01 +0200
Date: Thu, 2 May 2024 12:57:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>, Tim Jiang <quic_tjiang@quicinc.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: QCA NVM file for the X13s (WCN6855)
Message-ID: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zijun and Tim,

I noticed that you have both submitted firmware and NVM files for
QCA2066 to linux-firmware. [1][2]

I'm working on Linux support for the Lenovo ThinkPad X13s (Windows on
Arm, Snapdragon), which has the related WCN6855 controller that uses the
same firmware (hpbtfw21.tlv).

The current Linux driver is using the generic NVM file (hpnv21.bin) for
WCN6855, but connectivity is quite bad and I only get 2-3 meters of
range.

Switching to the board-specific NVM configuration (hpnv21b.b8c) that
came with the Windows driver make all issues go away and the range is
really good, but I'm not sure if that file is fully compatible with the
firmware used by the Linux driver.

Could you help us submit an NVM configuration file for the controller
with board id 0x008c to linux-firmware?

	Bluetooth: hci0: setting up wcn6855
	Bluetooth: hci0: QCA Product ID   :0x00000013
	Bluetooth: hci0: QCA SOC Version  :0x400c1211
	Bluetooth: hci0: QCA ROM Version  :0x00000201
	Bluetooth: hci0: QCA Patch Version:0x000038e6
	Bluetooth: hci0: QCA controller version 0x12110201
	Bluetooth: hci0: QCA Downloading qca/hpbtfw21.tlv
	Bluetooth: hci0: qca_read_fw_board_id: bid = 8c
	Bluetooth: hci0: QCA Downloading qca/hpnv21.bin

It looks like the NVM files should be updated in lockstep with the
firmware so if you could include that board in any future firmware
updates too that would be really helpful.

Johan


[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qca?id=2ba1beaae0c649ce8a50baecc8df9e81cd524e65
[2] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qca?id=598f5bd22361d7e92eebe8452d1f8013a1d35b9a

