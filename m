Return-Path: <linux-kernel+bounces-88533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A739886E2FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57841C212F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7676F065;
	Fri,  1 Mar 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IqosRX5u"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A96D1A4;
	Fri,  1 Mar 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302085; cv=none; b=IyXMf/1M7J0AeOLMwbbX7WRj3YEzUp7fhD0tSslI68PrRGjbFhTD8eD3hBMGaWclIfhnQCbS1FNFe4jK4hzstfyDhwGIAiyQpxnJYIAz9LHZ2FzdDT0zvi8t+B9V4bAVvU88HbNKUyfFXSiwhhLMiT6pb9sYQKBt+xs6efItGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302085; c=relaxed/simple;
	bh=bCnomT+2ED4Jkxxq+pu6nRP6pi+vAEgaQ1rqoBBay6g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QLY0X4OojeClxVPGfg/E+wCgiARYMQs+TqG5z0T0STbkfhzhB33Yrt8MpIkJ0OAE8t3+Wnj7cNbQZHjcjfqUvXQ3UP2pGDXmiy9iFVQCphv2zkFiDUiCPc0H62V3QpdxYFKcwDMeGKR1jYmaTcU+zAtpZ6JCFtCIVitfYWoCssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IqosRX5u; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709302072; x=1709906872; i=markus.elfring@web.de;
	bh=bCnomT+2ED4Jkxxq+pu6nRP6pi+vAEgaQ1rqoBBay6g=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=IqosRX5up0YUpcgwldV00Fw7nQDhh3bvWhQ+GfxDrLjI+idbP/2SFIK55bVAEQQu
	 GinRhCCqSmKUtQFeZaF4QaSpsy1CJzWIB0bvEM7fA91KFkRpMONncM3pAHqdOq3Dr
	 T/J2ulB4FlRDRUJxaNZCtu1SqDHzyD7ygd0GGTC75Yuk4fTgbniRD9JR2qibmM7eH
	 tfre5vDgyUqOj3avidDuy6NBb7QZc+wF6G2XmKCBWm2iDIUOyCYyWeJaX8BsU+SDT
	 RCDCVmsN8wbM8y6jdeEI/Ih2NkHqhOaAzx7fZJHzxJMd/Iceis6Ebgugti0UFZ+py
	 xiir5cRN/EoT/68dDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Voj-1qkMRq3it7-014X8n; Fri, 01
 Mar 2024 15:07:51 +0100
Message-ID: <9d0511cd-1fb2-4612-9b21-196a43ad0397@web.de>
Date: Fri, 1 Mar 2024 15:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: v4l2-fwnode: Improve exception handling in
 v4l2_fwnode_connector_add_link()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LEUQBvFdHCVfm2kd8AqCv/C4/RsI5ff027Mb70htNk95PRhrmAi
 S6bqeuQusfUOLnwqELcas6C/4RHZpcoq22ihwSmvU0+PpuZIo8ozvdOF7XJnKqUrmg9pxQd
 NGLDsz1VDgRF9NiCHcT3ckachFA6P/1t+gATTePTGrBlmmEMrNorRO3yNWaq3QQGiP/LCtz
 +vDFUm4xbplB6ASaiRspg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zHaLcXrErqM=;EsjKksCa4tH2THJlPAtiPwkKJLl
 8Xfagu/ewpVajhuLFC9xitMc7JQ62+eG2NMDNWY9Tk7r97HzxnbEd13pFYzrDwZcMFBF8Jr01
 rEXAGhvjPpuMmr/Pux6jGIH0xj1yceiv41H6sdB79uZ0Sb8eWjllDz4bHx9fBeMsbo6hJDTeJ
 mHb3EvH9Zf2FDEkEzbqN7rFJlv1Wzg1QTcrZiw7zzPLe2nCJWeo8QtFyOfJs6QY69hpWl9ajr
 dc66RBjTb0roQBPVp6JFwoCzAQZHSVzZ4mALV4WfvboMwoUomDBmIUpqHqt5IRDML+wuOs+hl
 O4gtBJRVAXH/s8/HvZ1PsZ7BxOI3/3T6JacIE8WsGzQrc7nWDxMhv3q4UrLnSY1274vEEwByB
 qDcAv8YtRNcgREzW9PfvKjG/diodpJms342NzBbYtYmzGV8aiHepXW8a2nxKuHPapT5gXrfva
 u+4qSK1qj8eXV278GNfKu4k0aLVgOzec+SyxxckRJgVXhUz0s5J5NABdX1g1ss0P4/bpIc2/b
 4T4QsDLJOAGqhLxX3tA7Tnh/YGDDThpGVqqAORR3FEsNoRgH7o2YXq4mrbFwVSyn7jxVbSFqt
 DNweJ+O9x4S/NsrwOzMhjNRlfn60JodKmYl6RzZJ1Ai7qMVyvNp8PRzAaK1pnt3KcorjEX542
 ktbdJr5RQ+bUX5hXq+ROLYzeqadUfSN9GV5A9rY0ufdajFfWrt6OOJ0Ro1kCml2dvONEWfL+Q
 jpIa/QfBY0DKah9NrvWiqwKV0jT8nQuYFFmTnxNyvyctVEdT0s7dkfD1e3GDBU5S5hs/msJTg
 LkEuGY0/6SC1phYZIqeHLy05gcupVQCKfV3IuRwmxFG0M=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 15:02:09 +0100

The kfree() function was called in one case by
the v4l2_fwnode_connector_add_link() function during error handling
even if the passed variable contained a null pointer.
Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/v4l2-core/v4l2-fwnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-co=
re/v4l2-fwnode.c
index 89c7192148df..dc6daf3a9a51 100644
=2D-- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -744,7 +744,7 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handl=
e *fwnode,
 	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link) {
 		err =3D -ENOMEM;
-		goto err;
+		goto put_fwnode_ep;
 	}

 	err =3D v4l2_fwnode_parse_link(connector_ep, &link->fwnode_link);
@@ -760,6 +760,7 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handl=
e *fwnode,

 err:
 	kfree(link);
+put_fwnode_ep:
 	fwnode_handle_put(connector_ep);

 	return err;
=2D-
2.44.0


