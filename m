Return-Path: <linux-kernel+bounces-22104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94777829943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243D3B256DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8947F44;
	Wed, 10 Jan 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Mt803ouA"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C547A6B;
	Wed, 10 Jan 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704886825; x=1705491625; i=markus.elfring@web.de;
	bh=P0anna4JWOhnimdjUk13w2sXj1/SrIEjxwjDEaNWyfs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Mt803ouApvmmTNV+/x+Xs0i4q28VuBqjoQJ7NlE98lZpkFr2clisHXsXJG4L8M4f
	 jOigLiSkpA2TeueJuBKVx2pqGOw5LAnjgkwYMEbUObx64L/QmwDbcxnrMsxXP4GHV
	 mi4oZ7SvLjupx5VIbTj7zU2vjWVWbQfeK7IAb+Mr6BmTtrARayn5kLoTOgJdg2Z6A
	 SuRJU+1dOXCxn5n4kq6My49R2m+UvZijQptKdtWW0ZD/aNtou2AW3A2oTXwQUygLQ
	 UBfBUdDm145AD0jlafNkOZGcG6rszcTBXvDg4PVYOdX/w/s4Xh8Q/teEbDcV9UtBV
	 ViTO1ONS9i9MH9pghg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZnj-1qlBWG2STd-00cvO5; Wed, 10
 Jan 2024 12:40:25 +0100
Message-ID: <71cd2c67-99a4-4173-8f0f-065fd864f8ba@web.de>
Date: Wed, 10 Jan 2024 12:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lru_cache: Adjustments for lc_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FvN7dPgcDHXfSNpzcQS0P6dIUa4iuJ1O5Ux14a/Vy6slkXstFSm
 i2fGgA9VGN+mDIJF7soCccsr07aCTRytpI+mT+ILc4ZFWP5nL0tdRHb3Ul2KW2Zd+hfjOtH
 IpDqfB15AUfmtd/igJQglrWxLmNEQLvnSGUJqJHzWA7Mfb24Rbio61GqZpatuYycuhXdXSA
 XTbqo72jfhnC/+4BCZppQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7RIVCUYl0p0=;SSQc0/FUdDIxV0DAh9oktJT4ZRb
 wuG7UNJDKzrRhXRBuRofdUk+85zgZRDDbdUxbNHU9qvML9hFZ+g0fdM4Agdv1jv96peWx3RFB
 fA0aogvIy5WKlRiNQUuxrNLQ7Kem7jEntm6cFO10Z/rpjBWmXZW4zS6iG/SVDDA68tlMCYBeL
 mNdkc0YF77F8v0cGwucyQ2UuLmEAOk56sIqFovavS7uvz0KrXBhHIvxzqcbFWEJ+WizjcsWGR
 y/4xdtsxCuJ+qIYOx5SZmkmp1cKwwingGbaQJS37jVLI5atqRGObgtnSekAPDl/ZB+jpQTDIA
 2eWdKdFES8ThJflrdBsyE9BtrkRsoaj4Qez89N71pEEy4UadOWiFYS2FNKwvexDm6Xkff7YlV
 V7OSQCK3D1mIcuACYjC3x+cOPDALag1/MmakhDxx7/X6aEzCgZ11YXyeXDaa+Fuf/hLNaN0tB
 eYH9Ti9/jDU6EUzoaE2YLIavTt5Tdb6EXoDI+GejSrAEXXEJ5BE1+T+TLa885rvukHqhS9o53
 O7jELk+A7WJyQBSaxfxj1OIJzFdQLJ83VDaG4dlPyUuX0LYetnXL6prCsQmQpwnLmGMdlEY0S
 80/btsDwSuy5U7eKv87SckRoiJ9rOQAcITknRmKWjVOMvWTOX2y6kimsRqiUNqFXJVGQXnm4I
 ad/GIv3mWXfpr9YPT/Ec90boBxSnmaz0WR165C/eQIXQljuNhbVBsN2vjYciap/vuWDBYZphy
 gDMPomTIJaXvYKmS/3KT9beixW/wVNzynPdwb5LrIKkiICxUI/XcGG6bUbk2vszzEoh+ITuh5
 f3KcwY0BhE2rptaFGZ2wCTvkugdYNbVFojuK0GeB/cpxo68eqjUULPIbvp5U3cSMcU5nfS4tr
 x3NaM2mj+Q8+lwI+2n52HJMALzhdkCG4g+PBPOUF6M9wBUljEXLW+QSKJfDh/Gsld4kuX2zt/
 4eszRg==

> Date: Wed, 29 Mar 2023 15:30:23 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (3):
>   Return directly after a failed kzalloc()
>   Improve two size determinations
>   Improve exception handling
>
>  lib/lru_cache.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)


Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/33226beb-4fe2-3da5-5d69-a33e683dec57@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00110.html

Regards,
Markus

