Return-Path: <linux-kernel+bounces-119850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0088CDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04EB2E5B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E613D284;
	Tue, 26 Mar 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ek8XSzD3"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE513D265
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483182; cv=none; b=UaPqdBM2HfL+3VPrtYXoaylKuff2wjOsMDa1QShRUoqJYkJwbwlseVkX27Du2jOXD9Z6JxyAtv3G9kq/FgyeIKMa4jNEMbGrzvHNmkRgN8VQzRL8WgJEP2aswd2cgYqBMI+2S+TmEYJpClrtnku+RAC/wDL/MUotbyeB/HtnlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483182; c=relaxed/simple;
	bh=uSY/5yUXpFhF37jtWsUF8uCAWH6WjFmsLCA3CUa7tYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTbtYWKOVmu4xdxZSJn6Xo764spQNQ0g/3hjieqRUhwb4+AVKJ5K+5TzTU0ocoKVT1OVzfVr+nWO1QL8QPl7T3cg8V5mXjjNrJMZ/wgZJcrf8rpkLj3AcINPUfY8RmLck4ot8weAY4UNLawBKn6SE/CmFFgBoZMDEnWF6G2z8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ek8XSzD3; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 260CE2C02AF;
	Wed, 27 Mar 2024 08:59:30 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1711483170;
	bh=iGTSsX93dvRHkGyPXPVZGiSgM6ztYpSq86uvj2mmT7M=;
	h=From:To:Cc:Subject:Date:From;
	b=ek8XSzD3sbFT0pHnnuCVZMALK6ahKcLXLYTX9VOxHAE4zwWqxP7UAK+f32bfTJU3h
	 GunD0fPAf9mmtbH76wqKw+U4flXHWHLyV3W1zumQXeaQR/aLT7LFZ343YFKnjUZGyh
	 9UsH/q9IHPHK5kI54N+gD6dKrGoTKU208nJcNsp7KiYHa/QUwGGHd6IRqikaF18dA5
	 FAfvaSPr4ycZ4Y8JG7jfRrKw2grXekDTMTQZYynxKzDYX16gFixAp3nURQPJaWvdWd
	 5p8sbr4NSlXnySgiDDixlb+Zn78vGBBXeSv3Uw8k6DcLd8+tU/OgpP5GemKMJU0Ujn
	 UW6YPgbR5ouEA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B660329210000>; Wed, 27 Mar 2024 08:59:29 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id DAFFD13ED7B;
	Wed, 27 Mar 2024 08:59:29 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id D437E280A3F; Wed, 27 Mar 2024 08:59:29 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] uio: use threaded interrupts
Date: Wed, 27 Mar 2024 08:59:27 +1300
Message-ID: <20240326195927.3265297-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=66032921 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=J0zaVX0nx6ystpX9sXEA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Split the existing uio_interrupt into a hardirq handler and a thread
function. The hardirq handler deals with the interrupt source in
hardware, the thread function notifies userspace that there is an event
to be handled.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I find myself needing to have a UIO interrupt associated with an
    interrupt pin on a PCA9539 (yes I know, it's a terrible chip but HW
    engineers love it because it's cheap).
   =20
    Prior to this the UIO registration fails with:
   =20
      [    6.484699] uio_pdrv_genirq detect-gpio-9: unable to register ui=
o device
      [    6.484722] uio_pdrv_genirq detect-gpio-9: probe with driver uio=
_pdrv_genirq failed with error -22
   =20
    The -EINVAL ultimately comes from __setup_irq() where it knows the
    interrupt descriptor is nested but we haven't provided a thread_fn.

 drivers/uio/uio.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bb77de6fa067..a86cf2e4f200 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -442,18 +442,27 @@ EXPORT_SYMBOL_GPL(uio_event_notify);
  * @irq: IRQ number, can be UIO_IRQ_CYCLIC for cyclic timer
  * @dev_id: Pointer to the devices uio_device structure
  */
-static irqreturn_t uio_interrupt(int irq, void *dev_id)
+static irqreturn_t uio_interrupt_handler(int irq, void *dev_id)
 {
 	struct uio_device *idev =3D (struct uio_device *)dev_id;
 	irqreturn_t ret;
=20
 	ret =3D idev->info->handler(irq, idev->info);
 	if (ret =3D=3D IRQ_HANDLED)
-		uio_event_notify(idev->info);
+		ret =3D IRQ_WAKE_THREAD;
=20
 	return ret;
 }
=20
+static irqreturn_t uio_interrupt_thread(int irq, void *dev_id)
+{
+	struct uio_device *idev =3D (struct uio_device *)dev_id;
+
+	uio_event_notify(idev->info);
+
+	return IRQ_HANDLED;
+}
+
 struct uio_listener {
 	struct uio_device *dev;
 	s32 event_count;
@@ -1024,8 +1033,8 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret =3D request_irq(info->irq, uio_interrupt,
-				  info->irq_flags, info->name, idev);
+		ret =3D request_threaded_irq(info->irq, uio_interrupt_handler, uio_int=
errupt_thread,
+					   info->irq_flags, info->name, idev);
 		if (ret) {
 			info->uio_dev =3D NULL;
 			goto err_request_irq;
--=20
2.43.2


