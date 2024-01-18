Return-Path: <linux-kernel+bounces-30478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C557831F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFED71C21C98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB12D791;
	Thu, 18 Jan 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1tN/aj+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F482D797;
	Thu, 18 Jan 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603029; cv=none; b=R0qseoOojybk3E8qn5EbYDJrjn99cw+/qpvQzDQkRHjyy4lmr/XdFRVmeZ64avq3XY2h7duI/kUZa1F2f4B3/Xhs1ZSWFL6Utr/1r56J4mwxOjWCe632hUNLOPr6BQjUql71kE6yUHFOa67Zwu7nXL/mvrxTlSpAKed1x74w+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603029; c=relaxed/simple;
	bh=B12x5CU3LJAATEvwezybaFPvAgE1iCNB0PAo3tZON0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gpTGdWjtM6DU3iT/v53Krqfzr6RI2nu7xSyyRWkDVOE2XMPsKr0hjYFp69MNaZjRCedJszuBjJuO4HmFeIYXy9wtYz8OybCp0o4Hijsp3OawNksIERJxgdPjCouMuEnv3S55skp8I+vlr0Yk0wvZu5SgL3M3mjIfY0IiVfcwHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1tN/aj+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705603026;
	bh=B12x5CU3LJAATEvwezybaFPvAgE1iCNB0PAo3tZON0Y=;
	h=Date:From:To:Cc:Subject:From;
	b=T1tN/aj+jOtqsSFJBIUGFabkBd+Gj6AIapWW+uI7ctwXpcFOY3P9CrOYWSsAWR0wQ
	 rAgdU8RV7LFieTsYwb5lhSKh64lF8XybTXPoepaFemc4CBuvwgPh7Xg/ROd3IDKcdK
	 vkHOhW46eH4DXdOBCX3DRgjKckb7VYvaYfQcXYi+cJ4MMrC3fWnuMakG2MB9XF8x0Q
	 fKx0fK2REDa0nGx2arEVJjLNAUqpAMpl6YUTVx6FE+2sbLOngGffeCWasFLlJdls9x
	 bKqXovIjuuw9l1E/+w5Ow7Bc0mB9xHlGWyHATrTZ92aJ2oGav87yvE66XP6FpJTgur
	 Hh3/ytjo04XHw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EFFA83782079;
	Thu, 18 Jan 2024 18:37:02 +0000 (UTC)
Date: Thu, 18 Jan 2024 15:36:30 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
Message-ID: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

KernelCI has identified a failure in the probe of one of the USB controllers on
the MT8195-Tomato Chromebook [1]:

[   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
[   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
[   16.337093] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
[   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
[   16.357119] xhci-mtk 11290000.usb: can't setup: -110
[   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
[   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110

A previous message [2] suggests that a force-mode phy property that has been
merged might help with addressing the issue, however it's not clear to me how,
given that the controller at 1129000 uses a USB2 phy and the phy driver patch
only looks for the property on USB3 phys.

Worth noting that the issue doesn't always happen. For instance the test did
pass for next-20240110 and then failed again on today's next [3]. But it does
seem that the issue was introduced, or at least became much more likely, between
next-20231221 and next-20240103, given that it never happened out of 10 runs
before, and after that has happened 5 out of 7 times.

Note: On the Tomato Chromebook specifically this USB controller is not connected
to anything.

[1] https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/
[2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
[3] https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/

Thanks,
Nícolas

