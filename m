Return-Path: <linux-kernel+bounces-51525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15015848C2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6892281D6B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B8614AA5;
	Sun,  4 Feb 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="drVazA+j"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFB14003;
	Sun,  4 Feb 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035501; cv=none; b=lCdwemW/pIKRgGJK6Mf2H87nh93V+8m86qNZvcIAzhg7Y6P5kLalTv1Y19sEtSY13Wxd3jGaFpnChbjCj8l0PAMY9B5oiGASV6qUVipJ5z+pky6IFV/yG2GkJkBaWST4eBImsQPjBbIO5i0SSIV5toGjRmS+KQUA3YKksgWxa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035501; c=relaxed/simple;
	bh=u9+LHPfAZ13cth/hrwDBhd7Qz2h0oIqYNx0hTMM0Nko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFzEK0GaRZHThTlLELPgYmvdiVBbKMcnd5c+ZyHRCXbv2BGn3Yof3WxvYOMUj9YUBRVij0N1KPI1wofnn3RyqmMRV6Ov195Wz5VZlt70QY0EtPZaDawhDPgKpEzuVic7YiF625cPO7078nZGsPpRafuz2+UJnOnIQ9PgBlY7Z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=drVazA+j; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=c7uxM
	1jI1D1xIwEXNqg79GIf4v7VHzmWovvZMLD/Jg8=; b=drVazA+joUoTleI92XNTA
	z927UDhi7DKUqvhlz8xK0ATiS+oY5Z84pX1YO6/O5TlVz4J4tcG5MVpTB68Cg7AI
	Ah3o0DMlQBzlfXjsWWEVcmHWHAoxdi+ibsz7t9vcHzfNeVq09968XGToQBzO0xT0
	zNkfZXYsbg2MdPNuiEOUrY=
Received: from localhost.localdomain (unknown [39.144.137.116])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnM2Y+S79lBerCAg--.45702S2;
	Sun, 04 Feb 2024 16:30:56 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [PATCH RESEND 0/1] Patch Resent: Enabling LED Support for Siemens IPC BX-59A
Date: Sun,  4 Feb 2024 16:30:47 +0800
Message-Id: <20240204083048.2458-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnM2Y+S79lBerCAg--.45702S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzl19UUUUU
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbB0gJ60GWXv4SRBwAAsl

From: Xing Tong Wu <xingtong.wu@siemens.com>

This patch has been resent to incorporate the necessary changes for
enabling LED control on the Siemens IPC BX-59A.

Based on:
 eccc489ef68d70cfdd850ba24933f1febbf2893e

Xing Tong Wu (1):
  leds: simatic-ipc-leds-gpio: add support for module BX-59A

 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
 2 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.25.1


