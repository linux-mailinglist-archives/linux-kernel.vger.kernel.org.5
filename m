Return-Path: <linux-kernel+bounces-14107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6C8217EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33671C2152B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F5211A;
	Tue,  2 Jan 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oU7/h1Ts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAD1FBC;
	Tue,  2 Jan 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704179423; x=1704784223; i=markus.elfring@web.de;
	bh=+oOe7aQXVFDEA8GxbsOClVRjPhvOe9G1UBb6+O2NWYw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=oU7/h1TspkEFOW8+Hod9XKSOJtApfMPSHOv7GUHOkpswCKJk+VsJ8jaKFepDxDlU
	 1hoUzei7YYIaMtE+xhGXfjjT34Leps4XjAzsM2I+a0ujb3vKvp565S4Tj93T4lynD
	 8JXBL178Brqh4ULtsXlzO3+ghtCoJ4uHxFwkUGEsyXnqZ2kGftR+kC0D+Pawa46q0
	 s07FWRmsC7kHCBJWJM8xZlnHrAEE5xiybogUxIdSbSHYdH1azOdYI6WEemEXWloeu
	 9sSFAv3vUGJgjYKn5Cl0885SJ9G7xhvNXafx8j/K+tDS+UMFegi/3He0VLQDn7sYb
	 WmOnBhPZBq59D30GSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1qpqP22139-00o628; Tue, 02
 Jan 2024 08:10:23 +0100
Message-ID: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
Date: Tue, 2 Jan 2024 08:10:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] batman-adv: Adjustments for two function implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pe43pbVj+FZe008alYHs/UTidvEHq4TOe9TdlOrp0SDV1gHoWHb
 gHcT9bU34jYd9R6LGyABnsvrY7utTKEw58pCebzS56R39SLef1N53v8wJIFe1XdbOrqVgc0
 MF513B13BaPakCYUjoAbH6kuLoo3lPzUYOgWzd9Oyc30a6uX+4kBeNpPbZrHeodQE2OwT4G
 PQtprNkYACrrAAU9wQ1xQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4i8QK8fmuMA=;hwwufTI10zuOfk9lJDHrRPRXSdi
 FnD4xoPtN1iznXnnhKx5qjz1NfwC6xqnBId3wNs5tpC6XzpAMTU7KAu9z+gb1sE4C4vwK5QIP
 JVv+Brqo29wsLW9w+tw0Y289llLAzuUhGfmNblyTOjCv9hFgpWpliAYlweZPBq1Chg6i8Y6I0
 dUt0aPeZC4O88OK5mI0p3DH5klcCaoApA7ZxWwFOIxUA6q2016gJq5rbRJC3xSZ/lHRs/4fM+
 uoSTWMUR8wkdF9Op1aF1IYRR0inZxgCTdOQC9z9T/J5hd2E6MkwlYeVxjjflZYxKqd9yYdVva
 luZ1fZLPFMUCWb6zk1HrQD/kRdaqZ7IH9OTwGEZDFpeJo3uMCTkBAlINIx0Vogq+YQztBO/fm
 PwWgi/mRpAR+jwBW8auPXdL6u5QQc9vT8SsYSa4fMJtLSdpK+ONdXcZSex3FGTivJ3MOt4SCK
 h9BKL5exM0d2MNSelmnRSuOGfMREoZCt7Ht8rttKf1JgyLEUp3+be37UMoYDd+qcffEzooA9P
 Q65OOuKs8IwZ3G1c0fx68gVsMP7rR9Yz+tGlRp8+9qjQIBOavAqW1FGzpkV9QfP6NNegewkVS
 exc3mDJjYf6oL4/35Fn/7hZf66/ZUZ/L6EBPepioYI4bFrYRTv6sUfN1IarPB7qoinX3QxwBN
 LYHiYjYhHcKe6j/K9QWN7UBMAWwt1v2p4EV7YqEKPDzH72/bVjxJrg3UuiyYyM3wOwnaEAkLi
 3OJ1mNlHmfclWJ1Da3MwsIgPHmR3s/OGDBBG0iL6UKJeaakzF4DdjjZXoCgskRe+H6H2DBnE2
 c0M6rd6C02YCmCjdvx87rCfrAPJhZnROUHmX8gvX0GqE35ptBiX9a4j3UoYDlOgZCaImh6eHJ
 0kAB3uJLh63aQJlNOTPyi5V6Q4wC0Pnpta0aP9hOB4wQCB43Kj2ZV+XeLdhnhDlBV1PiVKB3f
 saAdRQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2024 08:02:01 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed batadv_dat_select_candidates()
    in batadv_dat_forward_data()
  Improve exception handling in batadv_throw_uevent()

 net/batman-adv/distributed-arp-table.c |  3 +--
 net/batman-adv/main.c                  | 14 ++++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

=2D-
2.43.0


