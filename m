Return-Path: <linux-kernel+bounces-165575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E08B8E28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD21F21AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995B13049E;
	Wed,  1 May 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iQ7TUAsw"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DE712FF67;
	Wed,  1 May 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580774; cv=none; b=tWsSHCdCseuCQ4d6hDlWAhSILNloKYUqFkBUqbtVvddNLmYnCSNNOd22CL5BxwDq/O5eCu8pPOW2vcmZ+cSY2WQaHvdc1ri17oEo+cDoT+BhVjsGL8JE/zPWc5NWhwUdnn8nhVemmSQ7O1guniMUawDD4qWXO0lRxLFLZXpg+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580774; c=relaxed/simple;
	bh=lzRGZEj9Cwp2HA/pc1N+/ydMiaJGgfFfNX+FdTWmxA0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YKYUJqUEeVLcDRLswCPlajsczKrajt4A9SaNeCAVktrGPWTkaLaYKwy8XX24+iV5iysNBi/oWSx1Bct11479UqOnGp5B3Hbdr5jgunM9YK+GnEYSJYRPnlhUXK8yBwSW6a2/TkM6rs4i8j2iAg0iRrocJFnEPkNysMkiEzE7R9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iQ7TUAsw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714580758; x=1715185558; i=markus.elfring@web.de;
	bh=Yz2vQ8pzkeNI7IfTDAQnX8L3w5ojgahuffZfFwQuwV0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iQ7TUAswltGrgH/s9Dngg1S2ctH2AquXOy2S5LRioXaYkZhLwpzJVJ1h3TIJdut+
	 yw6ypjtAh+2RWii9xJqBOT/djTUrL4Zb3d6zaNGD1JMzoeEZvyWbSHp6WivWXbyQY
	 WjSqVfYwDunkF9y4lwI4ERCsQwAVRSoqFzg1GVPPbxcMsTdpaMVwugiBN/k67GQCy
	 +Y9DQZ72qWVv+yP/G+ITXClDhF1asIFohY2NW0FjY64epFU+BomgqTpo4Nai8KoD9
	 vNL21ApexmrVuOJTnyovuy62zQhkFx1lH4khWoi0O8EwD6K7/dYiil5kQ/O4u1boh
	 XagUK8XzIdkptJ7i9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1skEnF3kY4-00zejV; Wed, 01
 May 2024 18:25:57 +0200
Message-ID: <f5272fc5-8d79-4717-9ad8-c503d8abda87@web.de>
Date: Wed, 1 May 2024 18:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongsu Yoo <yongsuyoo0215@gmail.com>, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hyunwoo Kim <v4bel@theori.io>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240308121021.1732-1-yongsuyoo0215@gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240308121021.1732-1-yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NYP9A02ksDnqr5mO5h7+9Zn5xo9ajjorC+WD0GoLE8b7+uPalRj
 plCOxjqHsTfaCdTS/THOxNWeCKaRw4CqZ/wLF7gBb4mnt36GFSO5OQi6LXWJjY0Yk6NACH6
 /mv0U0F2wZzI4/8b4puJF1bumsSvURp2/00FIxwkvTAKtMGRjglgwXJ0HzPbLVCWRB4Fyjw
 aUnSOAffddmlvVngUzHlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9BKkzP7ZYVc=;QJKRR2TIwnd/Jk/po6j0IxJdlmp
 0c8GZ8fIPad4GL9bCyly3BpILOJKxGizCIWv+uuF9S0i8KVjOWJk+qJwWJB2+l+R0SfQZ7Wpc
 eAQEcge2bE/f+JObz44jRtr+PyAiUwELgmhfRM6j6mkYGromfqbYJzZGXAqX1dm7Fwjqc8lUc
 t9dJzOGKIAnn7i1G6IrDltnlVPFrF4HSRCuohdD2paIIInssYgy4GO0DQFPicKPdEW2uQ2n9t
 yThpcbJtaCPZevsXDsI6k9/LSL4Y8EzF6xz/WcLyXFP34BNjYVEQO3MjFDSNhuOFfR9intw4I
 wuhn02Mxsm2j6uJOOsoKhVhly4UGCGnxAxIdrbqh33jwUG8Se2rP6pl4/b6I5RPktphpXADYv
 IsTzxMAbBvYg2LyEiuX14yr0tR+Iexdw3Ax00eamwN+DCL3yzGx5ec7BO3SPdf+qIPbMaVkBV
 XdF7ln7EIndlat2UjA14lqA3k8XlpyMGfOjPOjGsglfV3f9jeM8V59frItSWgwO8/nPU/HeG9
 5eC0cd852Azkm4ctV29PvkyxcHZRIuBKxJDESQeZCjDESwJXMVKsOS8qWrH/IZ9AXOkTU8KjJ
 6mmcc4ugorbpS5xb2VdVfn6bb3k0vPQt1ChY9tHZCSjoPPWh38xmpjNRhrowBWfU/wCZNa5Ox
 YeL8cCJovEB3P+3Dfgv1NHF0/LLsAx6raQ34qllfrAei7410Nw4QvbeDPfKvlEkLFXyXyV22c
 RDuyf+Ntmt1A7uIVQxO0wCANhpwlDnzNqX02KlflSv+J8JbCvBzKKEEMwGsLrR8yIQPINOzYz
 JwB9JGNUZdKD84PYRC4L8kfc+gkN29sELuvXe7xgbSRh4=

=E2=80=A6
> really connected on TV. This means that the CA_GET_SLOT_INFO ioctl
> does not return right informtion. This is a Bug. We fix this bug.

1. I hope that typos will be avoided for subsequent change descriptions.

2. How do you think about to improve the patch further with a correspondin=
g imperative wording?
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n94

3. Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

Regards,
Markus

