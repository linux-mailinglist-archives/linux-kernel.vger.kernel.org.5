Return-Path: <linux-kernel+bounces-83298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F379A869184
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C6D1F27184
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B413B78A;
	Tue, 27 Feb 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f2BOj/wU"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC213AA47;
	Tue, 27 Feb 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039719; cv=none; b=cahpikHUVSx9ancYIW5eczor9e9giXd/Gln34E1uJmbEjU1wUYXtKobVMCZ91+8JtcCdXcWTANtdqlPrXGtsbjnnIZid/jIZVsc0oFxfjvXr7YtBy8/lY8ddtHqEVfsx4eRTXoAj1Aiv1gmfQ55ON18uWLpnnCdMvKf+nLKbx0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039719; c=relaxed/simple;
	bh=FBp4MDnDC75gzPDqxDP5QxL3po+9KLgHyEoDNJ8jPX0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jHTQSExsQIPmLOYxRt/3bC/sjdMdHcmyI3y1Za+x6lkq2/DqomLfgUoHrSKzx3hNVWRGZfV7oowfjBr6ScAk6LyEvACUGmKMYLWBFnDz44ekozwosdjkODyGuIs5uAHBZ3SEd5ICq1jrLrFM8YN5KhOT49IY7LkPynBaBu0pIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f2BOj/wU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709039695; x=1709644495; i=markus.elfring@web.de;
	bh=FBp4MDnDC75gzPDqxDP5QxL3po+9KLgHyEoDNJ8jPX0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=f2BOj/wUphPDnXxiqUYksZagtn/Jd4Md3BUDukbzbBpXnewv7EXlSUwIOcDVWVHj
	 o63Gvz8DdKEttH1lIaNayIfJuVsTzfPjhUMGmraJQP3pkGj5q81mfpHR8lqKhElK6
	 OUh+RJ5jM+3Al/Vx7dnmvXkR3L2hEDlPtmoCmrviEvCYXdBDRdG4lmZbZe53dPZX+
	 b/jRZSLs/6QpI3TALw1WCO3XpiaQpoBDTmf4/35YCUg52T43Nm/OLN9z0EcGALe9M
	 ZbJsgc/4hce7WDjQ/VCCIaRnP7XHHixMOrRh/BHE8rfEgyyn2Spuvq3JtE6GvcVC+
	 L4xg8PQT6pVfEBPy3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MActo-1rlWsR2EKe-00B2xL; Tue, 27
 Feb 2024 14:14:55 +0100
Message-ID: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
Date: Tue, 27 Feb 2024 14:14:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Paolo Abeni <pabeni@redhat.com>, Sean Anderson <sean.anderson@seco.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: fman: Use common error handling code in dtsec_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZyZ7wALjwGCm5kyUSIblzVfyzZ0lkUpsX745gNqt2IL/1JyiYR
 xKuLS5MHaSaWBKS5JZzmnUt9nZRkdLJiSywPZmJfNLYBmnrhaCuhtYmFUoZoxXbGEUOVVVd
 DT559PhNXUd6W0NwQFRSIkFLTQSM9tNxZlZAg0r6NoZzwBFjSlnO5QTdtUGkrzHcfIVEfI3
 X2Xd6wpKL7tasXzjcVdlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MMHx4LFE7is=;DRqgI+61KeO1S7erGzNs44kiDPH
 VSaTx1zQSD+TWBMa5N3SsnNGpa5Qc+y2x0ZpyHgVo7m0y8hGVom5ru3EWVbXBSYZy02geUb82
 jpGIU+9p22o/I0LK6wvbnrk9xozleo9fLQEVJL+pYkIBkTRHPAE5XlCCtGni1hwdty1QQ+5sU
 kvQX22u9K7s5exwL9rjExyG5F3tD/lL6+rGyOgW4usuN92L4Ss8aGjEhEKY/+B8uy7Zm7cT1d
 UJl+sAOwn63nWxB+x1WNk/MLRgrQ8uArapuVbZu4dBhJe9tfNdHbJDyqFIkFQSO31cgTfsLUS
 7ib0etfM7SK+TesulpXykuqzEXexgXkVc3IjlPBom6h+RoiS/GaCLxaL+vLENRD97G+DuVea0
 d54qKE79zpKM3BcQmSUxVL6CZ+jZGZi43pVJNZe1oUSwpuleK7fiHDTkn7pBuZav/x8BYq42x
 ObHmBUyEj+v0Nk7cyqmvHRkDV4CHO6c1kq2ishjXOMcM19HGud+BrJVGCrHmNBmRbwsPbDYRp
 B3nYWOyyrsZ7TGqoIc7IXe0d3u8KUTzk0HtW0N9Y5oNrXYfnjhV9clC5FWtvQsAJWfZ2O8vFC
 fgsMxjJDudnUI3gyPhbwdRZ+duDbDCoXMlzWkIkoX0ixazNo1UP+hwNCHr/VhLeG9Oir342Fo
 cATnqlDl25tXRPtKN/Z1tkNoE091WZKOZVxNWRNlFoCw+7Xhg9UTPDM4RgNJqy/uaw2moET1w
 //asaFl7VGJjuSaqI2fOjYctRT0LXkk/il1+A0GqWc73/pjma0FO1bH1kY3YnPijgGaO4Vlr3
 gZqTjxAlgGsyqNlEnK1sxN4Jp21vJKwiT9OWmXlWLPSrI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Feb 2024 14:05:25 +0100

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/ne=
t/ethernet/freescale/fman/fman_dtsec.c
index 3088da7adf0f..1de22400fd89 100644
=2D-- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -1279,9 +1279,8 @@ static int dtsec_init(struct fman_mac *dtsec)
 		   dtsec->max_speed, dtsec->addr, dtsec->exceptions,
 		   dtsec->tbidev->addr);
 	if (err) {
-		free_init_resources(dtsec);
 		pr_err("DTSEC version doesn't support this i/f mode\n");
-		return err;
+		goto free_resources;
 	}

 	/* Configure the TBI PHY Control Register */
@@ -1296,23 +1295,21 @@ static int dtsec_init(struct fman_mac *dtsec)
 	err =3D fman_set_mac_max_frame(dtsec->fm, dtsec->mac_id, max_frm_ln);
 	if (err) {
 		pr_err("Setting max frame length failed\n");
-		free_init_resources(dtsec);
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto free_resources;
 	}

 	dtsec->multicast_addr_hash =3D
 	alloc_hash_table(EXTENDED_HASH_TABLE_SIZE);
 	if (!dtsec->multicast_addr_hash) {
-		free_init_resources(dtsec);
 		pr_err("MC hash table is failed\n");
-		return -ENOMEM;
+		goto e_nomem;
 	}

 	dtsec->unicast_addr_hash =3D alloc_hash_table(DTSEC_HASH_TABLE_SIZE);
 	if (!dtsec->unicast_addr_hash) {
-		free_init_resources(dtsec);
 		pr_err("UC hash table is failed\n");
-		return -ENOMEM;
+		goto e_nomem;
 	}

 	/* register err intr handler for dtsec to FPM (err) */
@@ -1326,6 +1323,12 @@ static int dtsec_init(struct fman_mac *dtsec)
 	dtsec->dtsec_drv_param =3D NULL;

 	return 0;
+
+e_nomem:
+	err =3D -ENOMEM;
+free_resources:
+	free_init_resources(dtsec);
+	return err;
 }

 static int dtsec_free(struct fman_mac *dtsec)
=2D-
2.43.2


