Return-Path: <linux-kernel+bounces-12633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966E81F806
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E98B237EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C17489;
	Thu, 28 Dec 2023 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kCvCpeAv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409B6FD6;
	Thu, 28 Dec 2023 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703765116; x=1704369916; i=markus.elfring@web.de;
	bh=cJQqD6vC6OovsIlVnJsS/+nszJU8beuDfrI1RA2WO5k=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=kCvCpeAvjnFFioX1WSSvuToAGgUBbmrqXmC2XYSGG8qaPAXOjLV7zKEpwxa59QWr
	 eXvVjdoYHhur48csz82wkTw26WHVpXkdk1wLo8JJ6ARjsWHq27eyDyhwFdtcwFDYE
	 eyh0hM8LubG1phOjo7w87gKkXCGWJGGBJ6TNhEbiCQSMDdVzB+v3K52VcqT2zpevK
	 IbXePELkZagsw8T/CySKBroltU6vSuCbIzTpDsr1Ac8HOTPI9YlHYWCVzuGODPZss
	 hzyqA0dTX8vYKq/UOgKI+GYyLAQD2xY7wEY/zMOEBW0gelMBDaIkGTACv6z+joeJd
	 wvT56P+jmEAb7Vkq/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KNf-1rIY9d2Ma1-000Wmj; Thu, 28
 Dec 2023 13:05:16 +0100
Message-ID: <ba1c555a-6ddd-455f-862c-f1cb21e4ef8f@web.de>
Date: Thu, 28 Dec 2023 13:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] scsi: fcoe: Return directly after a failed kzalloc() in
 fcoe_sysfs_fcf_add()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3oW30yzy361TbC4+2QAbRA0LJ/v3WPMXWZWSmvY8JpYpKGXJno
 ZbXXovZQz99Twcvyef0K4T1kjA0mU/+PB9Ax2EfvtfQYmWQ72jmD55Oo7w8Ja/k3p7jNkOx
 0rhEnDSLbgRDNKLCn4E9WObD1Y/g162+QamJ73gSSJsdDEAL0C1alxH4wxmb6W4jQijteHD
 0rHTUpGFHe2LQE+gaVHzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/rqUFD75ncM=;ZZr4t6L050dgCyjGKaZolwWcJC1
 AC0UIpOhL1u/KwKhAMG4rkwkc62JvMdJAemPy6r0WrFfF2+DHL1H7zr9sjpmKsGgjwzIxv//2
 UHwh+GlkV58XhJuLRO40hRTx/e4HSGhyP7jtRL4K4+ini0Ebg2YwUhUGcv9LmWGQQ/Ap+MZWU
 8aOxIbQ5fK+HBbfLPg1bs7iJWrPM87POY4hb0KUo1tp4SCsBG15u7RJfu4LKyqP1oeobAZKAh
 4pLoSOPUFdQelKN9DLrVVyd62M6nL/8sHrwa+0e7td0Xs/opEDhtwKCe/rwdlyA9RyHEk7VO5
 TCJH/hhNOn6UoP+qO2+EBqToLqelZx9GvmOs+nrdAZxt0Oz+2WZVafCVx1tIsthnk/nDuCrjA
 kYsgaanFRAGQwtqJc6Pr5At6U9WkWhvOmSbXFDXdJWhylFpIoifSI2ql2ChruOFz4q71qjOG9
 9PmQGiIDmcmYaluCetMvrJb1jH9yjRXUqihSt/7oRH7VH6hp/IkYG+lXnQ6eWVCfsGw1D3TvE
 abitNxwfPiTLS8VsADeb2NdLrlhWTlJD4+XCHhMJOSibxKZWG1RqC60W+B4JAZWM/caBHHVsb
 kBgXcjgzrN8rOZNU08JdW9HW8q4Jrxxho2qz+U0zwnWZlBMdDlmdaWbv24GBNPXdlV2QELfm5
 Yf+up0THQwHh6IAbsKiu4jaIXRDKE8tcD/Q+flBWNpIXwvJB8Tv8hCzVeDrOcynP51M/r9aWU
 bQGyyhAgwEt+NHxTqA3W8rMBmZxZ3Drzu7e/YOziPq/mkdSISD4shfAT7yOnKWnlow3r2KG5F
 qYaWc7zp2QY2i3oKLSShqql01wS/DUSpLUTr8skoEffdAwlZzE5/w5uKXBavyBSrwmydZNagN
 F9k5r7x4M2Z5yL0nL63CqQO/fvW1fFFk2QVFso7kCqX2fJM5+vljKaMUku4cckOylIzzA3Rtj
 Pb7qpw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 12:34:41 +0100

The kfree() function was called in one case by
the fcoe_sysfs_fcf_add() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
  at the beginning.

* Delete an initialisation for the variable =E2=80=9Crc=E2=80=9D
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/fcoe/fcoe_ctlr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 19eee108db02..df7c8f68596e 100644
=2D-- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -163,14 +163,14 @@ static int fcoe_sysfs_fcf_add(struct fcoe_fcf *new)
 	struct fcoe_ctlr *fip =3D new->fip;
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct fcoe_fcf_device *temp, *fcf_dev;
-	int rc =3D -ENOMEM;
+	int rc;

 	LIBFCOE_FIP_DBG(fip, "New FCF fab %16.16llx mac %pM\n",
 			new->fabric_name, new->fcf_mac);

 	temp =3D kzalloc(sizeof(*temp), GFP_KERNEL);
 	if (!temp)
-		goto out;
+		return -ENOMEM;

 	temp->fabric_name =3D new->fabric_name;
 	temp->switch_name =3D new->switch_name;
=2D-
2.43.0


