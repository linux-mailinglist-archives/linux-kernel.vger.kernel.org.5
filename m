Return-Path: <linux-kernel+bounces-15638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC409822F46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EDA284756
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D701A5AC;
	Wed,  3 Jan 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Qe8NoxK+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFD1A72E;
	Wed,  3 Jan 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704291373; x=1704896173; i=markus.elfring@web.de;
	bh=Zn3zvLXLmFb7bnZCSQaHOVJmsR2R8N7zxi5Wct5XHCk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=Qe8NoxK+zIec3T5OKtK+EAj8ioPDL9qEL31kzDY2OvD9eK1/drW5oG9TP3w4y7SA
	 e6s4XY6d9ujpVDAx62rfjS/BmGJPh5HO3Bo6rGSnByLP1DqBTe0AN01rGVh5SXMm8
	 8ZvqdChzQvdaHSJbq85TtfGoUhPBaoMGHGeE/gZN42joQV0adsiiRVv12GGRxjCty
	 wqRyb1Fp986hOcjfHLEJ/KmMelSqvn3wbe5lMyWqmlXyIsF5m4F/CUGKp1jzdJub2
	 eons6mKpRzR62fTbH0C38j5/+lXtiwkGLQ2EUFVO2/4A0EI931alKWYwfGmtJzcLz
	 1O4vZMfoqZMQa9Q3Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1rDuGx0ggQ-013kOF; Wed, 03
 Jan 2024 15:16:13 +0100
Message-ID: <3d62b430-030a-4e85-9d4d-0468d237d371@web.de>
Date: Wed, 3 Jan 2024 15:16:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] net/smc: Adjustments for two function implementations
Content-Language: en-GB
To: Wenjia Zhang <wenjia@linux.ibm.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <41536899-3ca2-4413-b483-3d27ffe0d7f4@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <41536899-3ca2-4413-b483-3d27ffe0d7f4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzcILoEqWzmESYCmwI5ev40sBfETqja0zwynn1iVHYwe9Lm8Tuc
 LRezkZejbT771VWPc+nQ9Dl9LV8zYkcS70XEX9PeMs73aMszk9D7ULy+og/biWIZrWAEIol
 0YXp6icHLC6LD7nFOXi9Tpqt4in4MDl+L4oj9Egz6RzccB0wylG8CqdroYhKxUl8HsC59Fj
 A4dzZkKFxru0LoN9+qZBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/blSR/UhsE=;br9DybMm/k674NvLS5wxXx+po5+
 aVwj+BcI4b0vFYlfB8FkrOPxJ7p1gxmI4O+pLWpKAbrCWF7MFso6QkUY/eLR1DZW4lwbCfvou
 R6YVtuKq8UmT4RSvzhAnrQ0FPhcDAbwcMD5wgZNqV7Soc6TEsyOIPL+xnuDvdvyadvabb+f3m
 +bzf6EycstiWdpnK2Aiz+8pzUH6tnUoaBCR1qpNwxneWPYg9T7C0HAa1bacU9Balnswch3loA
 vZo/KzEweUvIw/XfILVRG/mnB53VYow1CNqk9T54u98NHYDVe114dlvAfWFCpZroZ+Ig/4wLA
 wysBNjFnAcb4vLIUjYjfTiumiNjvbIfVLp6wc0gMB4DkfOM+vX/X59iLe/iD1J51yefC4WkRT
 vAT25qjVzqLaBw98A/0ZWPxWUkEgC/Wt/7KPfOGfsbL7RJJYi71GtSqYtiJ3S2FiK2rO6brjj
 tpb6u3Z7SVga+U2kpUjCnrO6Jp+M3R/XX2gRBsT1542aufOiPRNkbDxepv7GfGA6WQSQ8ULFT
 SSsZqSQ4ailE60sd7A7Mtbd8PvXTbRYnB/2wdI9VICTk+9gT3rZ9pv9Zm7mJNDAcTvpxSDuKf
 Y1/cbhcs4HC7S7yNPtJQdLtRVxI5Im4sAucTVQLhrsO/SsaFKZxUw5iG0g9fnkyt9sYzcA2JJ
 R5XwRoB81ec+XkmlWbzjsDs+/2Ff3wnYTHUa25zow7QooJMLxItQoHd2Ic/xKZuDaHLVaSrCV
 wvC/ggjmWbM4BewAHpNVZUSjxd9T1p6PFRF9h87YgmoOgJeniVSkgHAhcUmd1EN36CN+CkMIn
 LuoEUnUCsww/9rsRO1ZjRtQKQDGh8vt6DjEXYZCrn5AocqQV7htUIyclGEw5NysX9/tEpkoWH
 L3k1Y9r4dF45g/BAZ7isvCQU/SjRgsDh8e5QkY2o7aEFUm8gyjbqrBi4XfKdf61QGkD1ueAjE
 JIa2/CLrJFzAWUTFXLceVatJKGQ=

=E2=80=A6
>> =C2=A0=C2=A0 Return directly after a failed kzalloc() in smc_fill_gid_l=
ist()
>> =C2=A0=C2=A0 Improve exception handling in smc_llc_cli_add_link_invite(=
)
>>
>> =C2=A0 net/smc/af_smc.c=C2=A0 |=C2=A0 2 +-
>> =C2=A0 net/smc/smc_llc.c | 15 +++++++--------
>> =C2=A0 2 files changed, 8 insertions(+), 9 deletions(-)
=E2=80=A6
> However, I'm on the same page with Wen Gu. I could not see the necessity=
 of the patches.
> BTW, if you want to send fix patches,

I obviously propose to adjust specific implementation details.


> please provide the error messages you met,

This development concern does not apply here.


> the procedure of reproducing the issue and the correspoinding commit mes=
sages.

Would you like to extend the usage of source code analysis tools?


> If you want to send feature patches, I'd like to see a well thought-out =
patch or patch series.

I presented some thoughts for special transformation patterns
on several software components.


> E.g. In our component, the kfree(NULL) issue doesn't only occur in the p=
ositions where you mentioned in the patch series, also somewhere else.

Does your feedback indicate that you would support the avoidance of such a=
 special function call
at more places?


> I would be grateful if all of them would be cleaned up, not just some pi=
eces.

Do you find my patch series too small for the mentioned Linux module at th=
e moment?

Regards,
Markus

