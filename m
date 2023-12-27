Return-Path: <linux-kernel+bounces-11946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CF81EE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ECE2837B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411692CCD1;
	Wed, 27 Dec 2023 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nzD+b5Td"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A32D787;
	Wed, 27 Dec 2023 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671610; x=1704276410; i=markus.elfring@web.de;
	bh=jn1IbyEVOZrfvN7XBCt9j+uuHZsv/fW9fsgamye8t/8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nzD+b5TdpN+n+8NxtQNY4AU5fCw+GUxGO+l30gVKS2BB8EQS/oIGaanY0qd1le67
	 z5ONw168vZxrvn5SQUI6/jy4XFBEECPLA8z7KB4J193PprPn8nDnKlMhPyBqskpaH
	 e9UFE4MD16FpGve+SIHiCYc4j+USRnTTPRHijmRnAtVf12cI7EfnxPNqFIL6ag8O0
	 U88kXehW0ybP7ZZGpJ1Xkg2c83OhMvMIPmvhCRHQK2DP2JKOqJT2QlREWVnIwjaib
	 Bj/rSJ7HVtJ8cOJXihsZQSe8DPFDGogQL6jsb89dI37j8lpHv2ElejRJXi8y6tdSs
	 c1xaKXfPTidhkNd19g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rGmeK2Ir0-004HkY; Wed, 27
 Dec 2023 11:06:50 +0100
Message-ID: <3c6ebb2b-b3d5-4698-aa89-9960872cbb4c@web.de>
Date: Wed, 27 Dec 2023 11:06:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_2/2=5D_scsi=3A_message=3A_fusion=3A_Move_an_assi?=
 =?UTF-8?Q?gnment_for_the_variable_=E2=80=9Cphy=5Finfo=E2=80=9D_in_mptsas=5F?=
 =?UTF-8?B?ZmluZF9waHlpbmZvX2J5X3BoeXNfZGlza19udW0oKQ==?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
In-Reply-To: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gkazMb/O4l2GzERn48IcvpwT5y8HvZR1g45mK2lRunaPBwbiMdd
 TRJ8HoTpw/tsxHi5+rASq8Op6y7D41VS3CrLChjltMjsYIdfY6ToXfF/i6HBQJIDjWI1QOm
 nk/r6J69+UBrf8TjzIotfhmZXVBDkUhT1qrJg825ztHtHcjo+22VfAY/w9w3cYl0qu8Ppf9
 VnDUk9T3JCK+TeziBuCTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xMCx7VgZ08M=;IAkFRS512RJ3iuU4GJ7SK9fOEKu
 Gqy65n38ZJpJYi7mBsUhtWPhM1vMlT4lg9/7Bp0uOp7L1AiDvG9j7aS5UWbEWuSKlVrNTyegO
 lq+T3Wjul3GOBU2d0zJZaob9emJIfVEuvmJbU03JHlJG4ILhiSrZr7YCvpvaiINtbLktpOLOh
 ujB9RXqwLmda1sQ6cAWJYpWRL7n3R4y1pcnBd0SO7lqydhngJv2K8E09gndhxFfT1GqA+wWWu
 V1gzqW52bxzYykEaIb3kMpXpzz6Lm4oslsGpxBWD2JotW9FI29Vkt3x09PvVTaNgb9e3E7lTS
 bpDr5bZlWRCqi94mqGR6vY3P4ARWPtWh2xQpbTiVNxFl/mEavOU+Egg7spifMEPhSLUpFiwZX
 xg+YJvVb5yEQI8N05KE/y7syNkvXrqvNWqFmpID466PrsCz3Vmt1xHLE6B4IHMGyx5cP04E1h
 NcOdSNOhsCnbpiOJNJOdN/vJdACLZXenyZrtmMLabYisyl9blyCb1KB3z3SPuxJ//RNFCKgQK
 WzvVtHuKtStfguYEV5rETXTXDO+o8QfbpnxDz6elU9OEV1J+bdSUdjdh+0COSPQQ58sFow+4E
 OuPU5E4QWmBXReDnJsjQKwxpMSEm9WjA74T3bgZIHqdTyOazFUFmzgZVtIL+/T9M9+qnrgaQL
 x0TTwLD8BNVRMx3I1ysaWy6WkwreHuKegXI4tVjU5Ar0Qb0bn1G1sZIWlnrvRIBBtgsMkDKde
 ehn5uCf2E+R0QRBNNPc9Z/uhwFkc9F5yjmguiwXTqSGnFOHc4riSIN0M5EN/Z8odwOeLhLwCJ
 wGHtQmJOqPFIvpXpxx6aawibzxXg0JVqs/A6UMRAuFz7xF0dbfxpyCZWi8YWouMeh3DfbYV4w
 8hKAAKcW1NdDth4mthohG30ypbyeCQLEYWh9RABBpfpYJKTSLtegW+conJQy1Vdk185yY751Z
 ifBF9Jttev8m7ncWCL47erxIwR8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:42:03 +0100

Move one assignment for the variable =E2=80=9Cphy_info=E2=80=9D closer to =
the place
where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptsas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 452635a50c4c..02f7d11fd828 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4169,14 +4169,13 @@ static struct mptsas_phyinfo *
 mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *ioc, u8 phys_disk_num,
 	u8 channel, u8 id)
 {
-	struct mptsas_phyinfo *phy_info =3D NULL;
+	struct mptsas_phyinfo *phy_info;
 	struct mptsas_portinfo *port_info;
 	RaidPhysDiskPage1_t *phys_disk;
 	int num_paths;
 	u64 sas_address =3D 0;
 	int i;

-	phy_info =3D NULL;
 	if (!ioc->raid_data.pIocPg3)
 		return NULL;
 	/* dual port support */
@@ -4190,6 +4189,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 		goto lock_mutex;

 	mpt_raid_phys_disk_pg1(ioc, phys_disk_num, phys_disk);
+	phy_info =3D NULL;
 	for (i =3D 0; i < num_paths; i++) {
 		if ((phys_disk->Path[i].Flags & 1) !=3D 0)
 			/* entry no longer valid */
=2D-
2.43.0


