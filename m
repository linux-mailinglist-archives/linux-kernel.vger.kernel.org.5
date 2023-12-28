Return-Path: <linux-kernel+bounces-12713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C782881F939
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A19285B84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51398D51B;
	Thu, 28 Dec 2023 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WMiJWQoC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11DC8C2;
	Thu, 28 Dec 2023 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703774895; x=1704379695; i=markus.elfring@web.de;
	bh=sAIxkAw1lX6VWuCNZrJXiScDwwIsCu14H/IzP/+4ssQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=WMiJWQoCik6eoEyjG2ImslEJdGQjUdTv1hiQkyhXDm0z7wUg9SMM+S+s9syz5hQI
	 r9wpJWRgN09YnC0KjxGDdFaIh0tHW5o1lqmGtKA1ghwpKAAfvtzr5eNJRvcSZhfPG
	 tOG+GdLROn4fufroax0k5XbcYAkAYFltO6eEYcMJhrtyonxBCdUwdQQDh5jg7keFo
	 dK3ElENYT71/XOa5Bmq0r1goGsEKeGlyw6sMr3sinif8QUJK+B0KXdRpBWlokqFhE
	 I6nSvwOt+TvMlhyod1rv8+54Qeh/qTjA8Z01cVhMnaFj3Tc2e7XQsfp2QGIUSKIjz
	 9xqSXa2J/kCcqLshHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUU6E-1rjMmF3diq-00QY9d; Thu, 28
 Dec 2023 15:48:15 +0100
Message-ID: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
Date: Thu, 28 Dec 2023 15:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] scsi: ses: Move a label in ses_enclosure_data_process()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MTGe2OuVnUsneV1nq8KjX7d7xxeZzAl1kJ3kgcc/6gNcqqxti0/
 ixOGUbjp66KOrZKxxcrAkmkGgI9dHOL0emiLb6AMZ5SevW8bFAiGkh3UCWnWx/n4LSDaWzG
 yIEQV59vbjbFECQUZJ/NW1LQuGC9Mki2OtaUC7qQPwK92wc+MJ5l7opEGRtcJJffbk1WWZo
 E3LGc4PoYOz4vp9s3KEfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:266RluJvshA=;zjH5Ja1AxNWNUrQdgP3O215bFxS
 8OCqy2IlVCThSpJPHZ2IQRF5OGUdDoyeC/j48chu+QMTCHtn/dAv5BrlwTLIM99ZluG6sPV5d
 zyxY39E0Kpl1wmFamQVpxp+0j2waenSiV1BkVwgVIPqvrxXSTe4qhxOrIi8GeBp3QUVvasjFL
 5FK41LHmcYHhzDh3/2EiaQUJI3syk4XMyFkAY/u+CxwoICzZGZbyr6VRHQCuJo6wJFqNhfSB1
 WooiFGHyQFUprw4lYNYUtuF/xbDIFtXTMpy7TJraxI2w8+gXQmq+gHp3cHirMgpKRaMLKJtcg
 DDtaomSpB9Lpes3h4rrVVGvFxAtBwC9HGBG7/g7kctt+15kq4xRVu+33HgdwB5Flirxu+fJ7l
 pMEtNgExQnhvPbouKSE0Yrfk/tGO7K0W5O0m3cAbnqXPdn9nGFPxNG5XzaqnKVa7bX/rGKZ5i
 DjpwRRwbLHfLM28sS4P7JS5lyzcLmprEhAY+X5IwBGmDgdli/oZo/kgSpOUDboCvomaE4TlLt
 4lk1hhYPLjoD66GPWM5VIOV+G8qLzQt3aHaOb8neUoAmi7IcE+GfM2ujQFg6rjTAggx+zuk61
 5oTenHClItNJiSnKa1a0d9WPDGD9vSZFIa0vD/wkTBp+9AM9F6obEv/8peWIs/XEYw/pGDUEx
 wNNMM5IO4pOqbzyCE2ibikzCp1ERBY0QKuLGPK93dlNtPGLHFeIuJ9dCfZNLM2e89oCEda+OM
 yrgbWDQZ+H9IGSBOuycaw9xMeqqeXYiPHJiOHSPBqMSYpOaZOhk6zz512EFaVWiBynzlbz4Sf
 7K/UyZYAQxuyjeHPWcZlUbfUxJdVVlHFu94n121+gbJuuNr4h8UOAz83EkJKrOYpkLwHNfSHK
 5iV7SUFJ4IvruniCz2O+EGPmubSUSBQ+eVZJmhQH5UGcvQznWDj3SGm5hgBf6xmURkmYC1FPa
 we1uJA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 15:38:09 +0100

The kfree() function was called in up to three cases by
the ses_enclosure_data_process() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus move the label =E2=80=9Csimple_populate=E2=80=9D behind this kfree(=
) call.

* Delete an initialisation (for the variable =E2=80=9Cbuf=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/ses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index d7d0c35c58b8..e98f47d8206f 100644
=2D-- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -528,7 +528,7 @@ static void ses_enclosure_data_process(struct enclosur=
e_device *edev,
 				       int create)
 {
 	u32 result;
-	unsigned char *buf =3D NULL, *type_ptr, *desc_ptr, *addl_desc_ptr =3D NU=
LL;
+	unsigned char *buf, *type_ptr, *desc_ptr, *addl_desc_ptr =3D NULL;
 	int i, j, page7_len, len, components;
 	struct ses_device *ses_dev =3D edev->scratch;
 	int types =3D ses_dev->page1_num_types;
@@ -552,8 +552,8 @@ static void ses_enclosure_data_process(struct enclosur=
e_device *edev,
 		goto simple_populate;
 	result =3D ses_recv_diag(sdev, 7, buf, len);
 	if (result) {
- simple_populate:
 		kfree(buf);
+simple_populate:
 		buf =3D NULL;
 		desc_ptr =3D NULL;
 		len =3D 0;
=2D-
2.43.0


