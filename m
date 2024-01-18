Return-Path: <linux-kernel+bounces-30183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9A831B17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FEBB25CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D69D25770;
	Thu, 18 Jan 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XC6tRtmu"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAB28DA0;
	Thu, 18 Jan 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586859; cv=none; b=nRJbj6ZtNMubqhVBf6LYF2jwb6a5jBUKNcquyi3lFPfkGeOiV/71GsCl2nMitGISW3ivXlND4btzB+/oEfPiuMGI82HHxF8XvgH3iMOMo5ScvnfSJ3iQyuQt6K5tj98Zw06PyPWGLwoVDa/W7WcKCqLC9reyub6e70ZlZBmmPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586859; c=relaxed/simple;
	bh=z/2Bwgab96DZ5PKg8s3ghLC/ddBRjyNUGU5ig9YwyrQ=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=Gy8vlPDWh+kkprwJr3npdGwaamUM8LROFuD6GnXzI2Bbgeh5wMfy7KHJxvAK+h2bo5nMJRV+yR+/wTwKH0o4d9RFlNFL0U5a/aq0dsSZs2A4DA7jS3SMQWQzJkpMZ2hpRKzR4AQALRzHNRbZrXsEhEsDguqLpQPF2vcX3zE48C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XC6tRtmu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705586827; x=1706191627; i=markus.elfring@web.de;
	bh=z/2Bwgab96DZ5PKg8s3ghLC/ddBRjyNUGU5ig9YwyrQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=XC6tRtmunKwtM100D+Ewfm+CP19mBGN08XuDCnaMsEymoQGu+u7vI9noGUs/48rY
	 37lO6G0Z7s4rxiJBdFOdWpHLXgkm6MWomCvWn1LAVRJh6RTBnLjbBsp+1AaW3QKca
	 j39hinGd9YSL8oQLtAEux1AKzZ6XzkIratnfA+VOGaeDJ3mSzq/V0QrVB03p346JB
	 5SD9TFL8tmm5r82DQ9X3KVoFC0LUBcu/NyxZb5gklB1tOY4jsp5oUy4KkN4+UfVZG
	 PWBL4HPpTsukMlZanE0H7VNrkc0VzEDJMNv4a86cxO6WM4nxKJYlhdm4HitY7iLQq
	 o7iKj5i5hC7nnlrpzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUXu-1qsVjz2Us8-00aRKh; Thu, 18
 Jan 2024 15:07:07 +0100
Message-ID: <14171fc4-8157-4919-86b8-bdec0493197d@web.de>
Date: Thu, 18 Jan 2024 15:06:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pstore/ram_core: Improve exception handling in
 persistent_ram_new()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q1rClzpMoW580z9Pvdi2Z3ZRHk52p2E2Q6XVLqRrNKlPpyakmvP
 WdtYc8MLDxlgfuZiuPwGEHQI/kjaJnFeixYPqtoMPMyJoqoY6e8MtQV2fEre9niN1hh7or4
 s8Nr82P4exdDLiTP+N0qKILv0/L4zk7aThKqlkzvZRNByhS/hQzzihNIIIt0uYBXfUk1GlZ
 L2br0gqeFgTPu1dbLfm8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y1tJt7FpCs4=;72+dE2IeuiHLVRsnwrXAscXo/3+
 lvUW7Cwig10uWMNkk8VoZsjoGTxhO8UkBuBLgmhNJbQQWUF4MZhVLvjFe+O45x6d8XsykU/+t
 Zajbvk0S9m5vDTZDvONSCr+BSAbeYmZqEJijzswUGv+BNHWchFEAo7wiUULf3sCC/NBgs5u2b
 MAq729vxCM+AA+uW3vRSEVD+epSW40GANRTa3ASQUuYI/P4ulMciw1Um5GwO7T/DLUPzQXwri
 3jFe6WGOiXNHrck3PozMnN2DtgFGgdHs8bUN0LN1hSBhTdPWbu7w8QE8Hpd3YSbMBVe0RIXk4
 WJqosgBJkZlZvitPC0bbUZuwlbQ2R0P0gmx+JDjMmB8inYk/ACtrIfuv7WAEDR34/OxzcTnWh
 xXan8ZTp3CYVvR81IFTH/2ze3HtRME4f5vZgCrf8SYacxEWMTcfudBmj4dE92NteLTFYo0UKs
 Ydz8njlWcFwb4RhD2/wosXv5Bx6nJcp1dTO3debhxvVIROfRLYsrNOCF/DKPCW8NKCmsOzHJ5
 HasbMgzopiHBANof97ShXv4O86FG7MgE1au11CCDvWsRRz/koRr36At3moaZwScQfYeYY2Q/l
 ByqJXMBADHYdsAf5vE4L6yp35o5syjIQRJW5omsvy/9VqffBtOfcv+2poKy0Y/JSES9zg/2iY
 DDhMPPsYzMFhJhc2MPGirACcfowJfOpYHuDGdrR0bSA7pcujnsOYNMOpcfsxu+kcFxRsCkjy1
 v3xUKTfv1iD9gXNTsan/jNxruyGuh7K+WUWfxMeLa93S3oBkVuUXAmqQnSv8/A+Nf/aIDziaR
 w4rjbwWwrDmE1EhVBvC6w/MIC1woQH2EcKIYlE2+n7fa/98AJbwa1Q/eNK1maP6+naBUZ71aq
 6CF8to4q7Z/arkn+R5WnPIU5ZZ4WKgKiiBkCNYwRIbkZr//5yHJra6Jw10d+9YzmtjxNzL6tU
 EzlcPw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 18 Jan 2024 14:57:21 +0100

* Omit an initialisation (for the variable =E2=80=9Cret=E2=80=9D)
  which became unnecessary with this refactoring
  because a memory allocation failure will be directly indicated
  by a corresponding return statement in an if branch.

* Move a call of the function =E2=80=9Ckstrdup=E2=80=9D before two other s=
tatements.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/pstore/ram_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..5047a8502e17 100644
=2D-- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -586,21 +586,23 @@ struct persistent_ram_zone *persistent_ram_new(phys_=
addr_t start, size_t size,
 			unsigned int memtype, u32 flags, char *label)
 {
 	struct persistent_ram_zone *prz;
-	int ret =3D -ENOMEM;
+	int ret;

 	prz =3D kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
 	if (!prz) {
 		pr_err("failed to allocate persistent ram zone\n");
-		goto err;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	prz->label =3D kstrdup(label, GFP_KERNEL);
+	if (!prz->label) {
+		kfree(prz);
+		return ERR_PTR(-ENOMEM);
 	}

 	/* Initialize general buffer state. */
 	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags =3D flags;
-	prz->label =3D kstrdup(label, GFP_KERNEL);
-	if (!prz->label)
-		goto err;
-
 	ret =3D persistent_ram_buffer_map(start, size, prz, memtype);
 	if (ret)
 		goto err;
=2D-
2.43.0


