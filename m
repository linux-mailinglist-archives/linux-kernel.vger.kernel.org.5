Return-Path: <linux-kernel+bounces-13941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE682154D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A501C20ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEDBDF6E;
	Mon,  1 Jan 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qRQWbEo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9745DF43;
	Mon,  1 Jan 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704142598; x=1704747398; i=markus.elfring@web.de;
	bh=uQ72KmkEiCY1K2+lxFladD8w67DLPeNf77Y7kouAhuc=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=qRQWbEo7Uj0bycJsCGl3WQaRCiA+viKLFFojXA92z8kVy9Xr/aI+/mMAvi26nfZj
	 KSWLKveWMYq1KZ3rlH7OigD71+/imEs/bDQVGWSTAEgnibH7qhlS9UJMXGP2yNfMx
	 2XfKz0vZfAJX+Hz/H1lTACb+2HkztmNwpHNHcuDNWsS0XY2KGjR9D5KYXv7Xg/iju
	 YlIXtbz2YCTy43dW3cGVYwDXBscAuruTGmcfdakVZRJDEskBWfXgVkC25L/2ejBh4
	 uEW8MZWalGMZ2EEyZl3qp6LIn2dxX8S2+V67Plp1lFn0aXKzAypKEhOI39kmTUXGV
	 Yf3EznOb4allV+ixxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1qvUej3HMh-00kqgO; Mon, 01
 Jan 2024 21:56:38 +0100
Message-ID: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
Date: Mon, 1 Jan 2024 21:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] net/iucv: Adjustments for iucv_enable()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:blsZ30Nj59LtPTmw09zo9JUQSYZGKjLUYX5rqMaLMMICqxD2Fna
 8i0n2D5jG2kO6DPrF/Nj6NR0IVV708OtVrOHSN6IxYK4lqX80cUFjHexyXjdbhshNBrye0J
 inrPFXON6UQ3hkicL+yxEAPUqA3y5YiEgZgw9sEv2VdURToGur0R/X97KqtlNJAY+mtW16w
 9mKTuqVu5idWhZznP5p2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8M1iMyIHr4k=;r4Qw8+G82S1zfQWRkw6jKEhbXMN
 9KB9OfIWaxurHgVjJ6JkjH5mim1sbP3uhi/7kj3qbtLPb7jvsas65mpEzuOysC0e9ePiJ6r2d
 SuFFQdv+QSfna8dH00ZkC0WyfTpM0JCqJpBywKnqnUfxIy0jAI1NzUsfhQwxjft1DQtNapswS
 mQRvJzwFplPS6HhNciKDWFT3MJgd1AYlAJSxNr1Ic6hcJN3GGr8SnjxZnNOycJU03CD+8uoVr
 8QPxY0+/bVNPC8h2F5LnsUxDFd7Gp7868GjIp3nnWECEvspPxppzBTKiYftP5uE3zdCJ8ePME
 tstvYSqKisdcSdIldBMyWPBr6yKRFLipkLHxygyGeL47ES+vnBo9tpGrw+yXrxl44DHAsmp/B
 VuyFvP8uJmzvYTRc2YieBpFCOcWsq03e5CwnIJD4su52YraNZrNCTLVF+2ubmVwJJWuTeRSGh
 1okgus6Wi6h/vUviIG0dipoZqD7BnX73AisVY9AzeiBioM0E6BIIDRhe7eihBpBHc6MvpcLjM
 NBxUlFH5u5A/w63u35LVE9JmYJ65rC6T1NwmidxveuLhn2N8oLZ3JuOgSCJ5PP+/vSFyaIL+F
 OkmPoP3qcoTTH4HL2P7At+BHLFlgyI65JylAJ3xoru+JJvS9yRtvlh2uOQt5RZep4ME0iEMQf
 1Nxno0HAjfkP9t2gJ4gAJf1b2tQexHaOcf9bg9SOaMNcrsJt6GvIwEgefqNW1P9X3TxjJOfUz
 DCy9jowZSgaZTlnQNavfupyn7+XITGHMa5MA8QJR3GAQe2iSDJLRBYOXJGJjPoLfrOjSlbqIG
 r//qRivnSnb+yxywEWjfme7BaLfqjmNg/EKmhmOmCz7hXQ2hDzLKQGMGyJ0zBZNnxWyRW6aza
 LYiu6mu3pAdviWGQ2jfglQYxoqDYJB8SvPjpuXhZNgo1NVA2IZHJ1ZfnH7Rmj+EXSh8HbKWyq
 sCpcFA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2024 21:52:12 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve unlocking
  Improve error handling

 net/iucv/iucv.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

=2D-
2.43.0


