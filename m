Return-Path: <linux-kernel+bounces-13063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563BE81FF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887C21C21792
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D71118F;
	Fri, 29 Dec 2023 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="enI5zDCb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E010A2E;
	Fri, 29 Dec 2023 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703849778; x=1704454578; i=markus.elfring@web.de;
	bh=bT5iUlJtBnPgfkwMqM8aRFxOKOnLJ2N+sHYoEYyh7V4=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=enI5zDCbX5rYVHnR7JDklsELQf8i+V/dpaxEp1oyPuu/dbNGyxNQhk8xl3oMn18U
	 cUHENFPfFnsinQawf4rYMYh9y+5HCl3exIUllB+yushuliX9NHYmivk5VCdDN9Xzl
	 k7gm0gNrFAXwW6hLTK8pcEXk59JnXeDh3e6Gf8QDgnUPKhJ/BcnjQ8vcXjWMbC834
	 3jUDqpHiTue51YApWSEOcWu11epCICRiUxfOfz8S4uUpAlFu3ZpkKawgBi9KtRl8S
	 GTFO0saoG7ElmZfggAdQSYUeSv/rujUUi0WyX248RcSjCOoFGPVjQi9/qAauU68He
	 Ktv3kPE5Lpx7UBMrbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1rMUXm0Er6-00619G; Fri, 29
 Dec 2023 12:36:18 +0100
Message-ID: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
Date: Fri, 29 Dec 2023 12:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] hugetlbfs: Adjustments for two function implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmPL3zuCMseUMikKu19QGDmehHT65Bw9/KBE14p6VW8VcZbbwU9
 kMz+gvKyg0RS7WjualXdj8hhNOBNOtbBozcD6Qv/4N/uLes/2gChUoUk6slayJ33ES9tiCr
 YpUdQmwqcmsAeblm3zwFHm2No9DyuHQu3so+nimsij8aHohnax6FU1gOgggtg8SBmx2i2Ao
 VQlJUXikmtCsv664qyjOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IR5K9XE0/K8=;J6XN6ruCw9rw7+bIfDOaCtu7NSF
 TAgN9EanRBWN0tMe/2bHAc60yNnXHvJR2N094yHmsfL6nG7ZvBxwul0+vW1H2JkJ/T1mVIecv
 lsBEGugr/9+5E/QLFe7oS+hRZUqlEFvkdHZgzq92665iceODLioZNT3tfS7YuTLTI5e9jLSHW
 aHpHZe6WkviUSd+y56dwCrj4LECvsCIB24gag/Qgq2Rq565lVoYj1KY7yxPskC+cQexSGRJIN
 V9XhAiMKxgAUBNTGvEgi7ufVAVKAJXoqm4TMM9yBwUxRtP6Nf17/vrj7U2cRoeb3yk2133gCb
 fxx/dUBFL0KDgzszpnt9QHEXW3nlOLVU3u1nNMZdxk4R/EqV7QAGfEvwOmzP69h3EvEEvDOpW
 eC5faQpJuRXiCFO3q2I55aZWDVynb+F610ZUriol8Zy8zrY6rfxb9MJYDBlV2jEJq1EYB1xbc
 7TkdjV3Bk5Dspa+CCtYkg6vDeejc64nEzCN1gpumHqZ+7BM2Zl3gZs0IigXn1Kprp4S5Z4dNx
 vypKYDH51j04fQQKJCoVyddcyMp1fiulAcmVu5s0gqI3atuXJadiSDMe+D/fOVeHHzFGwMkfZ
 AWLxtQl1dl9tOltzAlUST3uWJTwfbokxvKA8EgB9NEIod0a9x1IHKOeinu1S0VMxU2Y1vfYnj
 1VrjM26kyDxycVa8hE86AE69cP6awrghhkaP2C5QIx+bRCPmuRac084sqRzYWU+UO6e2nnVbH
 0S5ma8LMbvWH5Z1KWbSoySF0t7UgXHockF3kVq5qKCUCDiR4KT5evSv9CSrVXZlM829tggn4b
 7cjq4q/VIfLdQS2NsqNR/rNDdAQH3furkiP0o8ZudPHuDKYyGJoFoMOejYUi2XkYJ2zAHXsXb
 yDd+gppsMCr+QrpriPeuFFB0pOTy7wubea9LnORVXFua7Bk/cgnQRxW7zQD+1pVi1mJiYCMD5
 hUJ20w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 12:32:12 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve a size determination in two functions
  Improve exception handling in hugetlbfs_fill_super()

 fs/hugetlbfs/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

=2D-
2.43.0


