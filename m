Return-Path: <linux-kernel+bounces-144410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0588A4596
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D135B21371
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE63137748;
	Sun, 14 Apr 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vl784qHd"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75E3D0D9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713131551; cv=none; b=TKs491AUrMtcOUZW1sLU7MIVoHGS5qGfw4OtC/8oUIwXv0KtBDP3umvWX7HopfgrEErYJ1aBBstFNNmfwtGtBViuxaEsxe4PyTmSyETsFIJTzk7PZW8n/6IQb6DulLCkHgn4QWj7JHnMeG+6FoViQLPpytHI6zG6yIkUhIku30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713131551; c=relaxed/simple;
	bh=m9ApZ3+YwKPqWqGzqSQWC9iFcitqRqjMwKy6dREA624=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpqKGaw4z+y1izXTKJbTYbuou/eWrUoMfmXYq4tdnbo9O+ox6E7kg94DYbkJjTw/+sxbOBPrU7EolNds+/6Q3W4OUkd3ornBZcYCM3m8wrw1amAAnEy4atE+s2Sl80SDC3NP34NeIUCNBMLo/PBEol4Wkezv3+Y80l8nG84bx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vl784qHd; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 267002C0220;
	Mon, 15 Apr 2024 09:52:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713131546;
	bh=JE7Kni/Vb7C25UqzixXbmWfdlaYeZzcHYWvxVaA4K2A=;
	h=From:To:Cc:Subject:Date:From;
	b=vl784qHdzKOX8FLAsVlDhulWIp2wpQdoj9eVpSv5qbtjbs3ofn2saNalc2FZ0sPLg
	 SeK9cyjebAnCM9to+rZOH8Q1Y2jGDiVY5wrxX9ogeo1mZAsrFwNMOePCL0+6dpap4W
	 wyWbK0cvkiiisV8Rdk+OcHIlsfy3kfVKckIFo3iBR/b0Ns2L/WgB7PC2HCtVQJ7DMH
	 0wdTdnUmp0zL8NAKUD9tSvxQFNNv8AJEYEx+t5v1LYIRsGrlukUmTCU+tQhL9IVIrL
	 4qmdVgJatpPH2eNBu3As0HDfbocpsb6z7PrZzAo9NLgFETVoZyEQOcCMvmsffupaWl
	 Gwmi4MeChS7Ng==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B661c50190000>; Mon, 15 Apr 2024 09:52:25 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 988CD13ED0C;
	Mon, 15 Apr 2024 09:52:25 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 944E2280D63; Mon, 15 Apr 2024 09:52:25 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] uio: update kerneldoc comments for interrupt functions
Date: Mon, 15 Apr 2024 09:52:20 +1200
Message-ID: <20240414215220.2424597-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=661c5019 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=jt7KwZv4RvLptmtufP0A:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Update the kerneldoc comment for uio_interrupt_handler and add one for
uio_interrupt_thread.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404112227.mIATKoTb-lkp@i=
ntel.com/
Fixes: f8a27dfa4b82 ("uio: use threaded interrupts")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/uio/uio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index e815856eb46c..5ce429286ab0 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -438,7 +438,7 @@ void uio_event_notify(struct uio_info *info)
 EXPORT_SYMBOL_GPL(uio_event_notify);
=20
 /**
- * uio_interrupt - hardware interrupt handler
+ * uio_interrupt_handler - hardware interrupt handler
  * @irq: IRQ number, can be UIO_IRQ_CYCLIC for cyclic timer
  * @dev_id: Pointer to the devices uio_device structure
  */
@@ -454,6 +454,11 @@ static irqreturn_t uio_interrupt_handler(int irq, vo=
id *dev_id)
 	return ret;
 }
=20
+/**
+ * uio_interrupt_thread - irq thread handler
+ * @irq: IRQ number
+ * @dev_id: Pointer to the devices uio_device structure
+ */
 static irqreturn_t uio_interrupt_thread(int irq, void *dev_id)
 {
 	struct uio_device *idev =3D (struct uio_device *)dev_id;
--=20
2.43.2


