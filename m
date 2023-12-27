Return-Path: <linux-kernel+bounces-12055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41B81EF81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FAE1F2207A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F04594B;
	Wed, 27 Dec 2023 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fImLcrjO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE934502C;
	Wed, 27 Dec 2023 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703688187; x=1704292987; i=markus.elfring@web.de;
	bh=qJhNb+kflSF1W8E0uefEQKaq7Lmn3gr9mOpVQlydGAM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=fImLcrjOQv1M2gBUJ9+AmQ7HgWVkmqfCT+qA2E0bzmefyQ1fc0RDrY6btGR6wAmj
	 XQDgLCeEAbUZ0XjZ3yrMtCWIxn8grVwBpOzEs+OZwzVcycVJV5pwjC247+913WwlR
	 GjW9CNOvKox5pkXuyOP7QloxefEqcNj0GiNaiRwrAoigKZVfEwTWnY/vjPrru0hs1
	 WZF29NqLX2V+D6dnH4ADubzW9BhoVDErIaZpZZ7SB5rVy3Dlt6AFB9Q7HFSKViH1v
	 4jN4TlQwZgSEbblJkRnwHfL8XnDNzylPZ1bXseUINk99OmoGgvb/DcT4GNYvfzWS3
	 UezFww1+5QauPMe2fA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1rgk433024-00T993; Wed, 27
 Dec 2023 15:43:07 +0100
Message-ID: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
Date: Wed, 27 Dec 2023 15:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] mtd: ssfdc: Adjustments for ssfdcr_add_mtd()
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HyvYsn29WwCEI9xxdv9RQGBTPB/DqqDr8z3qCvI7bVdjZ4jHkC3
 G/wKAnFyAhII39qmEr7wJVgY8mbhx2o8NQUlZg9VZTJ+8K/W7J1cjSj15ih7EUUP8/Ef9Bw
 EJ5lrihMreoB6jRMk86Qwdu4o5BtYc4+6Rbdb79usx+U3HWsK1bKfI2khRJh/NB0dezmFc1
 SunLP6mSJ4DVppCx803NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1fr8eEQ0tJU=;pBK/5erE819ePtx/PcpEJfmbBdC
 200Muo8GOIF0KMNeeBy/acJwSq4RAVKjmjqpewB5sjoLYfJ1mGaBiZfd7xHIrLKCrii8bve9z
 GQjPWrJzv5mAKEqkiq5E1w8G7K+GTF3224TeasdccPY7Op9SGXYa3wHIF2DRWPHrtjux6p5eI
 D8OUupxkvGkA7cJKTiBJyLvYy+gAfT5f7uALSKJPDeaISaAPP1YSf5dlC/k9/uZBKmeCaV58j
 hh0dlhV3SwyNlNVdFQM6oO3Nzq6+w0uIH2rbAJbEidGIzRsnHjZVXieMCGWuEZo3qW7Wv1DLB
 tFVG29Ch422AIH8ar4RdY3k0MdHuY8f7CgVY+YV18h+4O5iCqkqZolIB/zImNtbUuk93I7r/Z
 DxPUKEocaCFK3yzQ5ytc8gmua8vD6bkgccjrNEXTI4UUlhEHQ8YV82F0WZh+WnFdX+x0RrleA
 MZOUonFJnmXsVY6dLcz80YCMKB4mKkPqUCaxtxEODQjgyhLnNv/zEbsqWGHE0dzmvmfXEjXzh
 /LUd3+ngayatFTYSfrzp9vXZ+gvpnFZyRJQ1YSS7kC8lTAJFkXh3qGcYlexO24FfSb4arFyKA
 gPJKpJW29MA4uWygLgjZnXL1EbVpTtrpFo2+TfjvoLD90uKF8o89DZDTZlTPU14+L+uE6R+Fv
 T756oa1ZqbIBUtlB6wmpYBDb028VvNGjWxzjMiu2KZMKYhS50rnllD79BnPiJK6BmpYDDffTm
 dKrhlOAwjdKImggd5MDPQAgAl+L5HdDy+dI0IZ7fkJPMeMftMK9ReJFnlw8hGPiB2MPYyS9Pl
 adWtq6/Pedqu65yG7Soll2sVODuh0HyPR+MIu/u2+vUroJv8cNGi0g4vja8KI6uNaxZpAGd8h
 f7NG7z7DFxmzgV+XsCasXFSdVTeft9xP1Zw7xVdI7mNbTwixjpeUcWDT+SRE0JBzzkW3BPpw9
 +HKOPw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 15:38:42 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  One function call less after error detection
  Fix indentation
  Improve a size determination

 drivers/mtd/ssfdc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

=2D-
2.43.0


