Return-Path: <linux-kernel+bounces-140742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C68A18CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39F5B294F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD242182B3;
	Thu, 11 Apr 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b="069+bgEC"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA517C7C;
	Thu, 11 Apr 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848977; cv=none; b=OqabqelkyRmbTDn8woKAXKcbAhHotmbrj5Hx8J0sV6yUjjgXi1nt/1iRbvOwGxlxVCNZgS9hl0KsiVsdsEQ/FEpb9vlOsPOtKNYu51KFd2qo8xFG+b3TzTbkUc/ys+zxYJK5xgN3PyQodaDzbugQEkOBZv9kuM0dC8AWByXI+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848977; c=relaxed/simple;
	bh=GA/EpIVJhg4UwhBlutCAi1ERwtVhQc+L+Av7WARSGa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnNxtyc3YRkFseu4apQR1BHipyWaN278xu9RoGf/EdUKI/4O96BnSxuwZG3j3ojFWabs1wdy1v9Fv30eg/pYAkY7QzZ3saadJuJiRAUr9OdwIlPXZ20Hk/eK8Usi+jNC9IA7aYX533x3zepx5ELGVw/8FI/7puNrpTBpVoIqazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io; spf=pass smtp.mailfrom=sylv.io; dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b=069+bgEC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sylv.io
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VFk3H6nCdz9stD;
	Thu, 11 Apr 2024 17:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
	t=1712848971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amXjS7ISzkPiYpAuOxGm5Oj5qH9FcCS+4Rp1Y2la0yk=;
	b=069+bgECrr4UjYsUMHQiI8kUAVroyfAL+yfoUqXFrBqbuZV1OgC8l8yeg3qYoZtHLOTFye
	dqL0UE6OPcMFo1Phg81iyg9WpYw/tGKZ7MfIEiVxmfx9A7isZ1JJdvKrJ84E5eXZqG6Qnk
	jXi3TOF1maw0rrX8Jip3+Gh/p3P/HAb9rXOncE8XT0Hz5mJHZga7HQq4NNwGOlr31x7df4
	jZ/xI+OXFSKhnd0HO3GIVklL1rC6xFs4vXcX6YXCdiJN8neQrEi1YYoaMDDmRMIMofVdKA
	5Tn9MuDR0sDYq2IBvwCF5R4p0oPF9Z4ax5MFS+ePEbpjG1BduASkPodKA7ESzg==
From: Marcello Sylvester Bauer <sylv@sylv.io>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	Matthias Stoeckl <matthias.stoeckl@secunet.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 2/2] usb: gadget: dummy_hcd: Set transfer interval to 1 microframe
Date: Thu, 11 Apr 2024 17:22:11 +0200
Message-ID: <6295dbb84ca76884551df9eb157cce569377a22c.1712843963.git.sylv@sylv.io>
In-Reply-To: <cover.1712843963.git.sylv@sylv.io>
References: <cover.1712843963.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the transfer polling interval is set to 1ms, which is the
frame rate of full-speed and low-speed USB. The USB 2.0 specification
introduces microframes (125 microseconds) to improve the timing
precision of data transfers.

Reducing the transfer interval to 1 microframe increases data throughput
for high-speed and super-speed USB communication

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index dab559d8ee8c..f37b0d8386c1 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -50,6 +50,8 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
+#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
+
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
 
@@ -1302,7 +1304,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1993,7 +1995,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
-- 
2.44.0


