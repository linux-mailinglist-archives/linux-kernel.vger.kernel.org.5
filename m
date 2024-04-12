Return-Path: <linux-kernel+bounces-141943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD38A2563
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050BE1C21D87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FC17731;
	Fri, 12 Apr 2024 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LDVpgWUU"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9479FD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897754; cv=none; b=f/D1Pj/BSzW0XoJoSuppnXGmkn9ZMt0wq4eu8jSS7Wxxobb41ZeoBcsiyKZSViZndTVoXph+S05ttYYIyDVdXT6V5anfOF7fHeblPi/j1heN4lXvu+emFeJBa7xzVvJq3HcyhoMTiyH//gIt5EaH3bAYDcu0DcyiAYK10hzCaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897754; c=relaxed/simple;
	bh=AUfdzv1k13JkE38CeCc4a9fZZNanAWqrrGB2FdAPRHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QN6R/FODfGiy3/NlVOxQ0lGRQq3CA46rbG/eO2GVZ3781JDpJaxHIsJpxAoxbk5NIiz1iQI3H9wCl9CoxrcXkCbfsY7MrhKROMIYxyFm1VBfGX2zOrYaA8G7HUioxhorVqfYqmUnmOUd/jUusZiLEU32DDOe/FnZitSVQ81zVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=LDVpgWUU; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 82F762C030C;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712897744;
	bh=//qX/oeim/TCu5yJZ4OoAQiSnVIlzDT1AYRWHCfEfAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDVpgWUUwCdRPXOrSPYooNz1GWexEb2pYzDGULj65T71qXYMz61lR663UTTCewOPl
	 37FBnxnoYqVuK/okj+rKQzDpwe1Rvlm2npY/VicHF6bN6uBURNLUXJ6HqWrKfZRO1j
	 UnUO8pBmvSWRLafHJ6B3uUF/R8qJdISFHg962vZisYBIJJXVzO9fdsVdfyWZ/rJNr2
	 DO5ugc/R+t6NijxrLbbMLV4Z+VlLYbu9IfDtNcrMRQcEuopTerTr9eyolreaqjDlYH
	 JhJrS/T3oTyZvHflX+gVv0z0WZhzecwhtcOtG48a/qx0VeNz1gspgYTI1yceF0B85x
	 tmLEWiEnWS1eQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6618bed00002>; Fri, 12 Apr 2024 16:55:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3C9AF13EE83;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 3AF4C280AE2; Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] uio: use threaded interrupts
Date: Fri, 12 Apr 2024 16:55:36 +1200
Message-ID: <20240412045536.1909897-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
References: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6618bed0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=J0zaVX0nx6ystpX9sXEA:9 a=3ZKOabzyN94A:10
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
   =20
    Changes in v3:
    - Update kerneldoc comment for uio_interrupt_handler()
    - Add kerneldoc comment for uio_interrupt_thread()
    Changes in v2:
    - None

 drivers/uio/uio.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bb77de6fa067..b424f004404f 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -438,22 +438,36 @@ void uio_event_notify(struct uio_info *info)
 EXPORT_SYMBOL_GPL(uio_event_notify);
=20
 /**
- * uio_interrupt - hardware interrupt handler
+ * uio_interrupt_handler - hardware interrupt handler
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
+/**
+ * uio_interrupt_thread - irq thread handler
+ * @irq: IRQ number
+ * @dev_id: Pointer to the devices uio_device structure
+ */
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
@@ -1024,8 +1038,8 @@ int __uio_register_device(struct module *owner,
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


