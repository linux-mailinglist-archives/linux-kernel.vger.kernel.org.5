Return-Path: <linux-kernel+bounces-12812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819081FA52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8DA1C21328
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28187FBFB;
	Thu, 28 Dec 2023 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Vi3h62jX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC3F51F;
	Thu, 28 Dec 2023 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703784367; x=1704389167; i=markus.elfring@web.de;
	bh=nENeSFE2OfbA9iTcUIGri8Kr4fNiIopTSZGwGt/7Yhg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Vi3h62jXDDODEK0LqbLIQ49NCjBR5R3NC2GdjFiEliruaVRytDLr6CSWT2Bz+haB
	 U0zyGF5Im2U1ccAlr/GoNxyTlx3iMGp04pGErrlF936iMDvUwmtLH09PYqKkx6+T4
	 Q0KwfaoKQ5KDif+2L3zi00iRTquJT7QKGP+m84Aoe8PS7gFOFHQg18N/4RXep5DpI
	 5xDmWdkYKt8phqwRO6F0u+WH5KAKOA+mGih2m9iB82NFUlFM3cIYzrA40u6PlAnJX
	 vJ9F5UD0ggqXDP0DNhNcHwWTEYiSxcALCV5v7FQY2qSzBPRBVt4J/d40ull90jQ5Y
	 MbXYUxaU8oRVqlPr+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP3CA-1rbg152Vzg-00Pkmx; Thu, 28
 Dec 2023 18:26:07 +0100
Message-ID: <8007263d-fe17-454e-92f3-cde218b7ed4f@web.de>
Date: Thu, 28 Dec 2023 18:26:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] scsi: lpfc: Delete an unnecessary return statement in
 lpfc_sli_read_link_ste()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 James Smart <james.smart@broadcom.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
In-Reply-To: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LDGrC+vqHWIocEGPv0lD4hzzP1mq5REoUWT0LydrdmXSQuolF8h
 cqwB1fOHHm19gObqS/eG0H5PdmvJm+/zyZTzrg+haOR9R39wBU+0qY1a5byXl3nHxUsjXB+
 /lC+QedabMdUv0S/EaZ2PjeFSXGJDBSOyfqg/fTE2CHprAl3xzSClwnoJtnhTaKr2eq57XN
 eHhB9L/t6Es1aqCwtLDkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:slsbpT8E4KY=;5AKxhEkof4r2xFb7LF3LQMHrzyO
 5kjWrd6r+vEvsq3MZV/P14SyUprcw5EX5jvnil9JKPd0c5LD+YWT7kwd/Q/CqgQtUZsjAzYOD
 i1WEfRR7gsdeOvcvrDKJ81tVeEV//lDHKB2n8G+/mGcsssl/Yp+Myj/68GQQT1WgBvMWWmkeL
 Ntp01nArKiD19atcLdHh5zjwVi8BIatGafsI5Rj8Hax9Ht9BaLW5FNJCC52AXsodMQZqhW8FA
 oN1OHl93PlYJRLLyYkaF5kaXJaPSYeu8NcNU8ZSDGAKmwl8U+K1gYxBgKztK6Z6FBzuk8rUQp
 OC7OoCaLnmIcAme5JzU6gvBJl1voAKztWmJX/AKp4VAEeNdlLiLWLvOyVwBLWPFt6t6ABtLxi
 AKegdAsw0r3x/0kQEd1WkdwyDYnt0znmbHR5w2gK/uVwuwK7zFB9yETVhEfDsT2UyrQ8sc5xV
 1E/2wrJejoil5omf3+pEVdW7kAKM4uXE3kC7bj2GNS8md1sCEOhTY4GqRL4U4yH57ZwtzUFec
 J3SWxj600iQi76+uqN/fOfr+PchTOGtPkR9wa6ex3EI+PshnGuwDITBZlS8NlE0faeRn6ABZk
 scmoD41IA8+LyCzkYFGq48ey4xXBWdPeTUrRdd5DvnPTnBP9ZdiR/77U8Idk3LT3DNJJGlgvJ
 Ifx5zuskHKK6QEINPnGuVUIOQLfpbuN+7YjmPBzFhbumy+7kL/k9oi468ZP3GZ6Ji3Qr0h28J
 NTCcI26W51ExMbaJOPYB3TNAVstGIpeFGpO4yldWooqRaRkxIfQYFX8dc3IJyB5GCstk0WsIi
 BtPIMfNNMHz6aLFtr5VC33oSMah+nG90VXWstMsqr6uvTjKWD4hVZtWWE3VrhZXAry3q96Uxz
 TpPfv64RFPLgec6JXuknFOf/ALzCkpwy3xyIqKUDtpAnYmOEDqNA0St06ER1ATwbgRSW1g7rD
 TUPLDg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 17:45:29 +0100

The script =E2=80=9Ccheckpatch.pl=E2=80=9D pointed information out like th=
e following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/lpfc/lpfc_sli.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 93339425ce3c..8de598c9e03b 100644
=2D-- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20778,7 +20778,6 @@ lpfc_sli_read_link_ste(struct lpfc_hba *phba)

 out:
 	kfree(rgn23_data);
-	return;
 }

 /**
=2D-
2.43.0


