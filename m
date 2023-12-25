Return-Path: <linux-kernel+bounces-11126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA381E1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEB61C20EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6D52F89;
	Mon, 25 Dec 2023 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bS6K7tca"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049D52F63;
	Mon, 25 Dec 2023 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525537; x=1704130337; i=markus.elfring@web.de;
	bh=Hqsf/W1zTujyJBR8uJaWWv0uhOGXacuRBqoB7Qd6iuY=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=bS6K7tcabbL26CgtnaDpAfS3aG1sywSUJKLX7j0VmMugEsBiJ27VFpZRQu2px3us
	 iujud0mhvAJgCF3ThYWrDiK/ecr65b7t5iccSdnd5NF/ofCT515zKQsCVZv43HTf3
	 A8K6Tz23iZrAB4+YkRXf6cgsSLRAbilk8e+ajmVRD7e/VS6sMUoOchNN1nMEpvuCn
	 J05KCuWNe7tM28lPlru0rXffZQpS784CmmVeARuZ9zQdfG4pi+etJ+U0/EA9pjaat
	 OlyHTdTWvZ3iZlwQ59MuZaDK+j9NfCNhmC/DAnr3Vj5ue9ZirthZXa+0g45iu71ex
	 UOHk9h9BpZYP6HWmpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1rmdMm4BxQ-00Uy7T; Mon, 25
 Dec 2023 18:32:17 +0100
Message-ID: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Date: Mon, 25 Dec 2023 18:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/7] EDAC/amd64: Adjustments for two function implementations
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R/3pPPgsW0Ytss/g9XC6guLy3I5essvBwpZaVoyDkq1UxEW0nYZ
 Vo65W7Z92aWXWfLmG5FmImwYQFDVFxnh37MxQ/pKsrLvyomKJmS6wDznIl2v99C6jg76GB3
 5NZ2Zta0Blhm759eNXJGUpgh2M3/sjiKZmIbu2/06UjlKZKCjRvoMXU5eZKH6+/dcWNclMk
 lLnDhtsj3sd8+zoPGZcoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:du6Y8wJZnYE=;qMoTsZM+U1eao0pQGstHy7uI27M
 Xciq9KrBPc/417A2OjPguJ12q5XIOXcbqDeFJjBZJSoVxg8izKB3tJH8e0J36rzQ75z4Py0lL
 4cekn23R0mQp/jgvY+cUTTpgeF0YCyzAZOE/nzOzdG26ZLGvSshtTmZus3U0E4V3qPscDNdtX
 YTx8ozQ3JRT5PpIGuKLKcrr/nUqHz+aEJmQR6iG+3iitd9WRa7sGWuBDZQrm86ueVuxuBeI/y
 znlGjC6QJXLQ/XQFyf2+Sv4GKyx7NULKtNyhoG6MRzY4wxjuoc+11IY/Ds/mWokxBFwYCI1Y8
 piA26RcEOjbH3HlxvjwxMeUTEOGX99/aGeDmKtRRxRE/aBWeIhPt1xtgGv5NGlCsLcXBkUL2A
 095UPOK3u8HW30Z8i95tNIJY3+G2IS3RDTz3gMA6WyyINUSD1BGbk7bCGv4SnfsXb46iUCCJ7
 GM9u7EzbN4tBDMSsmFoy5mGYLy/PbREB2KMeJIiK13egwHcbb73m+gpswBD2C981j3F8etDjJ
 lpjivtfRlRXLIP4XHlCg/GdHLqrGWHhXwDJdfkdMz/IHEfWKpIazjzcrjmak8fsz9gwZBudBh
 BEJW9pHcx1G6Yer2yWmWuSOYVV0Jb6C2EIgICirCOGsPstvfxLYx88gzlnw/0ZqhtWunAsfAb
 isPaHn8I7oYm6b4cGCq/0QHc6/GbnSRJXbLbZf+uURW5gXvTkfdS6I80hv33VzvKcwsmDHdLK
 vXipTuGQd9JZtYmpbVXmFRgdn2T8Ptt3NZkQCZ4NOyPHEKdmKMZ54z86VLNvrioGhxTyeQJ/N
 qJ6QeCiTlYrxVby2r3sKOWJDTVR+mnqTT4G6AArwNMnuCKYsGl8nV8ads51lsxEyzLH557Lyw
 qsMiUasBGkKPABi+nDwQvXMnIOC9atm3RBdRlfiakh2mLaOn1BDM6cdeuOubqPkesOuF7oXz9
 tfTgIA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 18:19:45 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  Improve error handling in amd64_edac_init()
  Delete an unnecessary variable initialisation in amd64_edac_init()
  Merge two if statements into one in amd64_edac_init()
  Adjust error handling in probe_one_instance()
  Improve two size determinations in probe_one_instance()
  Delete an unnecessary variable initialisation in probe_one_instance()
  Move an assignment for the variable =E2=80=9CF3=E2=80=9D in probe_one_in=
stance()

 drivers/edac/amd64_edac.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

=2D-
2.43.0


