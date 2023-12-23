Return-Path: <linux-kernel+bounces-10561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CE81D63C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9A4282DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759314F7A;
	Sat, 23 Dec 2023 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="P1amz+2q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA912E47;
	Sat, 23 Dec 2023 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703358994; x=1703963794; i=markus.elfring@web.de;
	bh=wZCbHnDCjJnEvDzsimFepIu5Oz2VW9fSNRNdT/39XCg=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=P1amz+2qHaMJlKq3fWNGX+30JNQyuwtPp04XEaigBsc5pqEBKW8UNGJgZ+XeduDY
	 +Gvv5mnPqf620FjIKmVYx8I/tKjPbbNE4C9gdSywBOfyfjjRcLvzWsfMr+bA5gXYY
	 BLRVJ9szsmhzhObWQTq2ob1PcvOdArYM7ckkhuItd5NN6eo4MZ87lvt1HVZ2mO0fo
	 He2eDpQTv/uOtHe3MiDeO0Kh+RUuOhkDCPxlU4j0h8rc3sJhbc5bsJT4tvB0Q+Pm4
	 8T96nKTe9ZcYSJJXDSpkb+C+OID1eYHVgSabMHGD3U8WUGX/PsIzg6nVZwpRm3rOv
	 D+OcjXmxgQy7DrpuNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPZd-1rctcp2beT-00MD18; Sat, 23
 Dec 2023 20:16:34 +0100
Message-ID: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Date: Sat, 23 Dec 2023 20:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SSNGOMyB9De3VAUo1rhXHF89mRJ2KEVJ3ChkKr892h5SNGxCeeg
 6J+BiPBDqKSqZOQJSI7/6dasGH93mG6rOKPO3ScMqM8AviJ+KPiZc5PmobjTqW69T/kXuCD
 ZniowXIJDCCGOU5569t6BzLCctJHry+HWycsWnfBuTKzd2+LjL2Khh75fYznYTx94/LLCTy
 tmJl2Eeq6ym/8IPcW4dcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dIsGslChmVo=;KIl2DQJ0SaaZilMKU2uek53scDv
 SLQAJykWPeahwM0XyCndzpqtiQk2TVJp12xeYPl8r1rvzn+7ZWsmWtAoWqrOKvcGW5To1537V
 4zP/4iTxfr8GyAsBFKYhS6FmckbvlX3JNO/fGj3COvL3hoqFzU8m1KBZIcNp9lhpT0l9NpXzi
 u3u+O1Cc+uN4CjIKQgZ3Fdtd5n8DqOylrREkgAXnpB4xoXdlXhmBMYZsC5oFGwvURvRcg0IbR
 xgbDKv3Iu32RJPlY1YKIeldc2Ur8NbjqJVMODnyWaAjLz9M2tttS4s4SylDu69os3GBrCIWNK
 /TEa8o4bbppkZF1Iy/QsKMWzeHwenT4FQEd6Q3X3BKDQi5QGaL70jwFhh4tp2xTihbV3btMLb
 Ekrmf+S/a0Cj6kjFrjvKb0T5PCQiovrBiNFKFiNZgB+PnOt2goTgoHw5IblToHx5lNcVghXGh
 t6glnBYvRIgssCVbSGS45MmpYkdjuxVVwljyfZY4Kybd8Nr3Crc2K14dyvVOC+Iq2JSJHIebJ
 ShR67nqcO3MTbhikdL/q/VwHn6i8vim34hm+ngfuHzH1mQ6tn+kBqpq7VahOsYdlfl8JkWDaJ
 WfW/tDV6N/HWh/E/hbzi5K9KcQigBdKO+Ytsuf5QRj2UBOPnaa5TViM0d3aObYQQyjB3CFNPv
 u56kKApX1vkrymOK99vIHfNo7vOcgn83j0SZ6XykbOftSDifCpPMrQFhEi93io7qSN1jlvB//
 +WAkhlYlnggZKPyel3wZCWTMLRrAesOmZpYGfBInzLKe+4s4irqVc33JvfdXWWJKSzwOHgByd
 9dYOngzIFrHLrhFtWL3nt+PF5FYskIDqIX06aOztsIWBiS1r0Et1W/tQ6hKLtuwCZA+SVd7Ni
 9AgUYlfL405+kC/IED6lpse0IFlz1SVHw6mK6JJjylfENGDwxtt5gJBjG4IanOqVMz2vFpVNf
 nJbyUg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 20:02:02 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less in vas_window_alloc() after error detection
  Return directly after a failed kasprintf() in map_paste_region()

 arch/powerpc/platforms/powernv/vas-window.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-
2.43.0


