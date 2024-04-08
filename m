Return-Path: <linux-kernel+bounces-136021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108489CF02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C041C23C64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE0262BE;
	Mon,  8 Apr 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xJCc8kJJ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA16323C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619662; cv=none; b=JzWt6Xuk9Fkj5BxOxy7EeVmkoDw8o5jSPVaw3P+KFnM+Kz2fbgrv5mNPjnTyIezf+drSGrsMrjfZHhWSKbTSL9mQK29YlHqj9Sd+Y8dy3CydmCHUa/vJjYL7o0WQy316aSZw69Cg52n+5u8aUFfWaGhSHbMX/jzRaNJb9bgw70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619662; c=relaxed/simple;
	bh=jRN1y7EuGFhqPiVG/aPjvG4hENMeZOT9GKfnuePSYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seCSGBKJ5iIYuNLLSygmK5RWztRu2JH/YWg3jShoL2OtYwYdvienQFCN1mlFokXh6x3oQLg3/hFGq7YhKfonpNwBT2RO6kbhrRgYbrw5jEPNLODG+8mdZH69b5XKXw70Nr1rKoGGcV7JchkHWMuZL1qzS1mBx3f/suqMpgAgXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xJCc8kJJ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 585AE2C02B2;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712619652;
	bh=Y4gQ/bDiHCcQRd5crHNQ++wt+WGiiNW7y2vIJknv3X8=;
	h=From:To:Cc:Subject:Date:From;
	b=xJCc8kJJphKhhXmFmIuVzS1tZzGIUE90Q8zC5bHgONLiqi2uA9JgPtnFk/fUr+GfZ
	 JTRpTKJ8yBdnKN6B0LfesNdgCXQNur2UHLa68yQj20PLQrGLrjohAQITm9yz4LimFE
	 h5xkmdk8bU4GmODQFIIbwdXnwE5clww4kghYQ4o5kIk2BCDpaCfG8oIJjmnx7u7ED4
	 7P5mPMYmMmGGTWDLjx8YcKwvU2f+WGuFDNM8cWFLfYfbBhR6COSYgfMzMioQCEP2BU
	 Pn4SEOGjUA4ewB24uKma/jAZCjtxPU6y2x4QQOhpllgM0YzgyOyqo/3uXHf+o+AvIX
	 7ePjnYXev7XDQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B661480840000>; Tue, 09 Apr 2024 11:40:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 30F7C13ED0C;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 2BD3228078B; Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com,
	baolin.wang@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] uio: pdrv_gen_irq and threaded intrerrupts
Date: Tue,  9 Apr 2024 11:40:47 +1200
Message-ID: <20240408234050.2056374-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=AuZN3/9P c=1 sm=1 tr=0 ts=66148084 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=VwQbUJbxAAAA:8 a=IP9_hPQSgtk6KLpm9RAA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

I've combined these two commits submitted separatedly [1][2] into a small
series. They can be applied separately as they are not dependent on each =
other.

[1] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@=
alliedtelesis.co.nz/
[2] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@=
alliedtelesis.co.nz/

Chris Packham (2):
  uio_pdrv_genirq: convert to use device_property APIs
  uio: use threaded interrupts

 drivers/uio/uio.c             | 17 +++++++++++++----
 drivers/uio/uio_pdrv_genirq.c | 10 +++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

--=20
2.43.2


