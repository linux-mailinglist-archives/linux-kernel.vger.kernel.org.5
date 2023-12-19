Return-Path: <linux-kernel+bounces-5488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97449818B43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE0285F53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EA1CA91;
	Tue, 19 Dec 2023 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G8rGQsvO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B311CA82;
	Tue, 19 Dec 2023 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702999844; x=1703604644; i=markus.elfring@web.de;
	bh=SqIfd9piziXw3rDdw09M/Qh7y3a+TKlJcVDEhj0X7LE=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=G8rGQsvO3ka2I0WSCmF6TMOUJIdC0z1HpW7dfo6cfX3j3H5QFWWXoAN+IiA8Rt0B
	 ZLesoWxR3eaAC5rvZUUXoe1U10oygNn8RCTQWtrkDPjqF1xvS8cmWRSBdipxPAIsE
	 pq8XUAP83s8wqKrIZQWiPBPlG1iru+hsBCD1+X+xRS//QC/YuVu15aCos4wP6x58X
	 9NrmH1fjM6cYhwqeKkiuh4C/EuKWRjaasrbK/73uFzIfbM4kVM4iGwHkINMJbDlZT
	 90Qic0ppevvPCTF3sgiOdxnIQHX9yzTad0z9lAIkPe/1L0xc9IyNe8Fc8Jc2lymke
	 iIAKxo1mA2gOrowN2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1roHQg0D1C-00Ynli; Tue, 19
 Dec 2023 16:30:44 +0100
Message-ID: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Date: Tue, 19 Dec 2023 16:30:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] kobject: Adjustments for kobject_uevent_env()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzjrw9R8tcsGtcdkiR1zTWKOG/6PCCnBcQo0xtGgnuFaxTVJnwM
 b0hCCtkeaeVYfa0iHrKgIjXE+LmwpwWvv0TlYxGcy34jmoYkgSWhi2VInXh+DWhZM82KraS
 txTHt24MMDToWtq2bImy7ZKfluZtWo8P1G65ykLw3n3X3RsGEv10/qvBroijVkaSqRT4LPe
 YNVd8CaTZUyiNNeiveGtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xVo22E71VfU=;cSt9rlzBYBXQmohzOXCHz8vONQ+
 ZBYr6njgREwgl1/kqjB0U5HtuINaFkSYGF3++B8IDVPmoOenMQUM9+n3GulYTafevuZOYwGn3
 fJPSjBG0ENNNbtJOVmVjcubmf2J6gCZdlhmevKuW6hcKxd3uksWulwRuYDE0zKQsa1GJndfTW
 PQXHwCDwZ84gzQQHBLZFEiq7Oikpf6Ba1C4o06bpatE+SGpIdE+z4zq+IYBoJB6txv22oMA71
 JE7K4o1zkFOHIMwGIWpDqOukpIQa3uPzlajjGROSIIaLUOn0Iitv6kvAe5exd2Y6+TQym4+Sj
 Z6UyGYBfx9B+Gr9AySBRkfPeOorr66T43uMbyy9bNcOXw6Kufi7HY58sLi8zD+cFbnxAKlV4J
 iyp2e1QgCzB3+A03aWtBYQf1P80fYUiF3WG3dMt/Ohjvqb3duQ8iukBCTxjMAlH9e63TtDiwY
 jG9doKUNid4SJTsS1Vchzz/hwrm3iJ+s3dMGCNIDtMSmNxsLStNJOR2owVtShGZ4jnPWgkFpp
 8RIWYainggBw2LcSPovWDudQeELRsfF0PyfrpbVJUOnzhUTq7cAHHwZY1D0yntDEMI81LK9rv
 LJm7XThHp3P/OVROAAWbfL1N4z8jdmK2urC611LtY3PRBNQDcR9dPI+xC36T/XnKKa3gllMzA
 RZmnu62i9SyCz5LnPxgPe4Fz5g3+vytdEvBz2X+biSSWFsyaY9pLHux9IB0lvc6eB9smsVEdc
 T5G4YcHEv1t5TFSy0EQTwsGwfnkEfK/lVKVdU5yfd/pA+zT4HPv+IxJeIAtIaM5FplNBWZp23
 LStrEd62w460d223tLb+E0J6CWDAxZyub0ttoRzOSX2aupoND+sRhV6k1SnR9F87N8bQ1nncX
 YRNNA6oGNHFuOttMiUAjnIDwXDOSno6QjJjG1x7yiruohcr7pu+5e6GrH3W/V5a93iGL+sV7c
 e4bWyQ+b1N28VmgZj7ET1OemY4Q=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:22:33 +0100

A few update suggestions were taken into account
from source code analysis.

Markus Elfring (3):
  Add a jump label
  Improve a size determination
  Delete an unnecessary variable initialisation

 lib/kobject_uevent.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

=2D-
2.43.0


