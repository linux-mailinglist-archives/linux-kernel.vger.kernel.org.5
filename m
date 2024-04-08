Return-Path: <linux-kernel+bounces-136023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC589CF04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EE11C23B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118AC14A096;
	Mon,  8 Apr 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1sHYe6nh"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7D1D699
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619664; cv=none; b=AayadeM/ec0BXmkGqzRchatCdA1RpoKJhnSxx32VKxL3l3m4CIkZtfZ7WEvuz+7qt4Zf05krmzvuwfhDZJqWdNx7Ma6sf3nz7DbHYwy0nIfYJu33KFGO3DJRSVho38vFoGqJMX4gn6i3K6mRfdtZNebCnbruFdt9i/a6mppvzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619664; c=relaxed/simple;
	bh=F6TpPh7NUX2CkBTZYVAkftU4gr3TzKGrTz28G2Ai128=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNuAFtW78qu3h9Z1BRTxDQuqcPKKHpZRAhMjVtGAKiQn28rfqGKYLwSOyh4ZhJSDPgzOMRAyjnn2HOwwS6Jk6MSjUjZp903ib8d9TVC/ED+/QGfoOSiqs80d653wJOEy98rNyClmjWRqXPI9LmjhABFk8np6myDQ8z0ZZNdx/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=1sHYe6nh; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 69E282C03C5;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712619652;
	bh=tG4XBEHYBLX8lfUqr7++s9+IEeYNvdGxMpDJ7zllgQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1sHYe6nhp6iN9nTyFDQ/pWg0Nu765zjY7Od50DI2aVX1EnW6X22jw3CHqSqGOyxR1
	 pcGhuL7OkQiBqZoeftuXRpeH1bTYMpNbH92jguuuf8Qu/V/yp3pFOAjq3u7WqiOhTQ
	 e4neUkCikd1nUIuWpSvA3yb307G46uUcyz68xIe9PnewUNPnjQQ52sm2ngKhg6BLg1
	 38SQmLb2oT0Fafj12VO+nkdD11W6pDaqitWlbaOCJitLcj0c7B4Xsu+pXKc9rkJWni
	 ak5Ar+GSLqBdKRHWBVw/UP9l9b1jlOeeuGk0E98pBxY0zh3YRFeyBbBAYlBNOMN3y2
	 fPMR4TFYPUxOA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B661480840002>; Tue, 09 Apr 2024 11:40:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 371C213ED0C;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 34A2028078B; Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com,
	baolin.wang@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] uio: use threaded interrupts
Date: Tue,  9 Apr 2024 11:40:49 +1200
Message-ID: <20240408234050.2056374-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408234050.2056374-1-chris.packham@alliedtelesis.co.nz>
References: <20240408234050.2056374-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=AuZN3/9P c=1 sm=1 tr=0 ts=66148084 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=J0zaVX0nx6ystpX9sXEA:9 a=3ZKOabzyN94A:10
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
    Changes in v2:
    - None

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


