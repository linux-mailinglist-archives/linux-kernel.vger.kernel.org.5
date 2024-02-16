Return-Path: <linux-kernel+bounces-68596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FF857CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F1C1C225A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C681292D0;
	Fri, 16 Feb 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="OBnE1toA"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA062CCB4;
	Fri, 16 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087841; cv=none; b=aegjf+3bGz5LqLszOI+gQ23Zw2/AfnHAWZKMIvpO+oDLxM4y02Iw2m8XgwPpvQj7tvcODDOCt0+uM+XbV6xvpyIoWjJVvhxbRaYWz776/FNXwnTzRHzFO0fvIA8dxeDpEqErA5BJx2yISBkk8wa94tAJq36a2qEXDl8ZktRJWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087841; c=relaxed/simple;
	bh=k2fpWlsq3ikrp8PHJJJBcQSXhbD5PcQPjZovIN5SiKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOUw2cvAP9RLs4VoFl+mhaYXC2UWSn2MPNIoYA5HHAUbGUsmuNVTDIjvGJcYFOeifU+UU1KpscOyawEmkVxyfWCfV1lPe3+yro73o9kN1MzoUmZqSpuAuMjC8UUfsX7JpqOhY4gs0FnX4tSqMKyNphUringUxyfSzt7ZxqUTuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=OBnE1toA; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 6DE5418575DEA;
	Fri, 16 Feb 2024 15:40:28 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yTkEI9-BT0By; Fri, 16 Feb 2024 15:40:28 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 3C67A1859D618;
	Fri, 16 Feb 2024 15:40:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 3C67A1859D618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1708087228;
	bh=zgV0ivj/OEUx/r+edsUgWjC2NypknE++yAGJ22q5QGk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=OBnE1toA9i06HkfC7k8Q2ftnCEJ95/C/kobi4hfdtCJuoHST49Uloz9mYnMHED9MF
	 waEdFoQlrN3tADQJsGGiPtHQPmdGISVjRJtGUWGSbq8ALxbA6/a7bSx+X6sgtS3xEi
	 703fzxlXkEe/JEGm55nnwefGh96LMaTnbcRCSuoW84djwwHhTymWArnDiLm3JCmmrs
	 8NJfKcsLFDSU5nxE4GDqylcaLEJwdiohuAaORB5Me5y6RpdlVtgT8WFHdTWplIu4lX
	 RnSYdRiUeBVhSjD+XiNCAxyDvptpS5GxWF2L6Q1EUJ6DHa85MBal/QfiuI1GLbk+m5
	 6GhFh/36hDnzg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W8JxpCQNt1ZG; Fri, 16 Feb 2024 15:40:28 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id EE6151855EE38;
	Fri, 16 Feb 2024 15:40:27 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	Hartmut Hackmann <hartmut.hackmann@t.online.de>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] [media] saa7134: Unchecked i2c_transfer function result fixed
Date: Fri, 16 Feb 2024 15:40:06 +0300
Message-Id: <20240216124006.18896-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return value of function 'i2c_transfer' is not checked that
may cause undefined behaviour.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2cf36ac44730 ("[PATCH] v4l: 656: added support for the following c=
ards")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/media/pci/saa7134/saa7134-dvb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-dvb.c b/drivers/media/pci/=
saa7134/saa7134-dvb.c
index 9c6cfef03331..a66df6adfaad 100644
--- a/drivers/media/pci/saa7134/saa7134-dvb.c
+++ b/drivers/media/pci/saa7134/saa7134-dvb.c
@@ -466,7 +466,9 @@ static int philips_europa_tuner_sleep(struct dvb_fron=
tend *fe)
 	/* switch the board to analog mode */
 	if (fe->ops.i2c_gate_ctrl)
 		fe->ops.i2c_gate_ctrl(fe, 1);
-	i2c_transfer(&dev->i2c_adap, &analog_msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, &analog_msg, 1) !=3D 1)
+		return -EIO;
+
 	return 0;
 }
=20
@@ -1018,7 +1020,9 @@ static int md8800_set_voltage2(struct dvb_frontend =
*fe,
 	else
 		wbuf[1] =3D rbuf & 0xef;
 	msg[0].len =3D 2;
-	i2c_transfer(&dev->i2c_adap, msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, msg, 1) !=3D 1)
+		return -EIO;
+
 	return 0;
 }
=20
--=20
2.25.1


