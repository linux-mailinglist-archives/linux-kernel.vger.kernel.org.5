Return-Path: <linux-kernel+bounces-41840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B783F872
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6582C1C20B30
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AB2D058;
	Sun, 28 Jan 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JTzbCmuQ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062414288;
	Sun, 28 Jan 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461796; cv=none; b=jZ1F8mRII7oJtOSFdS2t7nRyoqI9cpWqiOnFiT+HwLhG/HxTG7sAvKux8Gm+gub5DJlb2co53lkmD8ZSDPf0+7GgIxWlPtnOOs2XTwBavSbW1nDzkRuIIxxPVW4mNkz9X7DymmWnwpRPQ0p6phdMhXufMk2Vq1dSylbaVA5g6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461796; c=relaxed/simple;
	bh=skl6m8d4+uXGtWa5IbVdYrFKC3oF+ITHrCIEfSyrSJw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=akl62nDcqNJLnRggusSOGjuE2gasNy+IlAa9NSE6Jdu9OyIGwR44n1Q9lhROS7JtxVFjUMnHbZw+bDORq+macetdHDFnP08+wb8e28X5L1LmXRP8seAVL5lLq0nRDyLFQVtTQenurzD+U3t1UQnpXtJg4rpJ//rgos+URDb5VMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JTzbCmuQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706461774; x=1707066574; i=markus.elfring@web.de;
	bh=skl6m8d4+uXGtWa5IbVdYrFKC3oF+ITHrCIEfSyrSJw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=JTzbCmuQAOJ1kPZq5j1qaYAsHcjBkpcnu2qhErvAN2LpefDUUeM8b2YxSueGD71B
	 j3eef9Aa7lTg7dMClGwevaaI/naVIePVANvgwvsxllGUm2u4KQBiBZpEHsN3Ge9ET
	 /olSkTUN96PGcHvaKkcFYx3KkJXJx/ggDHvxAy2e0PpH0dgdZ4koTAtljuvqJIqJD
	 I95lUgxOg94U1tQgmlZ0bc5OwJ57nktLwYazqriKFh6Ef/EBYKc2zFaKNOnos3iVR
	 K/J/lW4DLGoS6zIj6opNVr9FEH4OAba3LSfjiW4G6hk871iGmBZHEC0Kp5XTe6oqA
	 BY/3ZEr14c52yJwQug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1rDqKJ2XxF-00uach; Sun, 28
 Jan 2024 18:09:34 +0100
Message-ID: <41e333f7-1f3a-41b6-a121-a3c0ae54e36f@web.de>
Date: Sun, 28 Jan 2024 18:09:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xen-devel@lists.xenproject.org, kernel-janitors@vger.kernel.org,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] xen/privcmd: Use memdup_array_user() in alloc_ioreq()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7yhNhlRvw29pkPL2ElLfqurRFvlr5JJnJHUrCA7cARjU+fJm2cn
 3ujTOQNviQlobkUnrNwknyt+XzrmHGGoXkQ4NrRjmuViRPoSvBYWkVfI3o9bqxr9CK9PxHo
 DF+/WB0T4smezgtgZs2nDtVFzun5IFBJdLTaFJKZ7V3FEOVV6NN3keRdYqGfzR/fGr7aePR
 BEM+3ALcJia7TLbSBgNMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K4Ht/mjTrr0=;HvmWwv7eLngddWj6ev5tcIOfD/L
 fuWb7rfhHAnB5LpBTTNR4OiesAjJUwwhF3MgQbNIdh+LbcEt98tGW9hBMFrE4T9+ZOwwh7dNM
 Px5t7eSuh2tc0vc5ehXthTGamsAK27FgVmIET5sZ0xX53ynF5qk+KANhqwFS9J4KaytBdiyzg
 5MecokBmUjUMZRyto8m/3sEMeyJdiro2ayMQRmUPeig2dp1b9Lk1hleCypE54v/xYr06s5tT1
 fHhppLdShkYf+MkmlTvSThJgBKbvbVKNrVKlk3UG/G9hNvKOgc/uOs7YO8CVEzOxVAUdqO+8J
 aTvGFwWoReQVtnpBTCv8i/tTZ6IBMvROCP+P9Z8aa85abNLVwxN++gm2uIFa1mXSZlzTZz3R5
 TzlCcJJWnEwiKHLB9F32pv+12mWVOGknoyV8AFJgGkrnJZ1RHDMpzTC3Alkf2rTh7hjw24O2X
 xqopT23zNzYz0rm6dpeNS8RQC2XaGBv42mGl0eplnas0/1ULxR3knkays35S5ZDW4McERbseK
 RnA6KkFawxQnVWLubFpKwQXSI22Q+wu6Uin9GEX7xhQhvjYNEuz8VGuIWZcHAuSBhCVgyMlZv
 90XQm4cXaT1TkJQrX0sllUEyVXNlImxf9PyYOLXoXib/kmHFCzOh7hU8EwFul1A4Lk3ZeLFiF
 qtoGJcHiZaRJm/tdCNNYdEf3OYMmQPYAwZWDZ1o8QfgIKpOu3Ke8Mr1czn0PdHKFzTNcVGcON
 m3wEZkY3VCt8/7W5e/fNnNX2fng1WzGrkFxEo7ARFoInHcrawQWU2Pig5connBaeO2Eo4ekbb
 GMzlFi2hhJmlwBpDmvIlTtNDIk1owuaHJrM8VyKxNS3hd8JFvIL3wmurSeo5XBIEAM9HRfrUD
 ZpFSaYxoZAGCDIySsAXMoO0QCuC7WYH1v10S3OYTwozdNHejdJEHqWYrh3/b438sDAwKqfdv4
 3J8eOg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Jan 2024 17:50:43 +0100

* The function =E2=80=9Cmemdup_array_user=E2=80=9D was added with the
  commit 313ebe47d75558511aa1237b6e35c663b5c0ec6f ("string.h: add
  array-wrappers for (v)memdup_user()").
  Thus use it accordingly.

  This issue was detected by using the Coccinelle software.

* Delete a label which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/xen/privcmd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 35b6e306026a..2c8f6d047c11 100644
=2D-- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1223,18 +1223,13 @@ struct privcmd_kernel_ioreq *alloc_ioreq(struct pr=
ivcmd_ioeventfd *ioeventfd)
 	kioreq->ioreq =3D (struct ioreq *)(page_to_virt(pages[0]));
 	mmap_write_unlock(mm);

-	size =3D sizeof(*ports) * kioreq->vcpus;
-	ports =3D kzalloc(size, GFP_KERNEL);
-	if (!ports) {
-		ret =3D -ENOMEM;
+	ports =3D memdup_array_user(u64_to_user_ptr(ioeventfd->ports),
+				  kioreq->vcpus, sizeof(*ports));
+	if (IS_ERR(ports) {
+		ret =3D PTR_ERR(ports);
 		goto error_kfree;
 	}

-	if (copy_from_user(ports, u64_to_user_ptr(ioeventfd->ports), size)) {
-		ret =3D -EFAULT;
-		goto error_kfree_ports;
-	}
-
 	for (i =3D 0; i < kioreq->vcpus; i++) {
 		kioreq->ports[i].vcpu =3D i;
 		kioreq->ports[i].port =3D ports[i];
@@ -1256,7 +1251,7 @@ struct privcmd_kernel_ioreq *alloc_ioreq(struct priv=
cmd_ioeventfd *ioeventfd)
 error_unbind:
 	while (--i >=3D 0)
 		unbind_from_irqhandler(irq_from_evtchn(ports[i]), &kioreq->ports[i]);
-error_kfree_ports:
+
 	kfree(ports);
 error_kfree:
 	kfree(kioreq);
=2D-
2.43.0


