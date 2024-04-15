Return-Path: <linux-kernel+bounces-145427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262918A5608
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6480284E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFE78C6B;
	Mon, 15 Apr 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SBLSGHmK"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C471B3B;
	Mon, 15 Apr 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193657; cv=none; b=BbmsrImOm/ClJntHsvcQ0I/E5E64SvpDsVrFAhYVvOEaX1Quj0VrKWnMYrh/n/9GFH959wlL4tPjuPC9Nli4KfdZdAkxY9jC08sNwmhj6dJSQhURGu9/Gs50oKDhT1a9Uw/3/GLpYPG7dnBHgkA0yfZluGUC5F3DjpYU1KYfFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193657; c=relaxed/simple;
	bh=emgz6QBKDimwdJBAJ7LQ7441HPWa2vqJvQcWuqrELQ8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TSYTAVOdg9H5qO6Jf+Zt0tAd3wrqP9OKMr0EBR8CXF8ikmq2Hy4AEd+cbGpD4oAFKxhjaod3xOXeCcl8WugfGJ2k+9b0RcyhyPoAlS/F9/2p0GO7fLaZVeN324u0zw/fIoo+jx9M4I+WFJOKDUxCfpr5/qkCmBL/DRJ4GkhVGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SBLSGHmK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713193633; x=1713798433; i=markus.elfring@web.de;
	bh=emgz6QBKDimwdJBAJ7LQ7441HPWa2vqJvQcWuqrELQ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SBLSGHmKz2ARTmGyMPUv4aNk6Kv2dQPqVUSD6nmGNGP92hbXvHuf1dVZrK8essQj
	 lBz+ZDBxOngb73DhFMzdiBREU1/+B3XtSR4vzRm7jsM21I83TANUjKRwGNbU9CBUt
	 Bbk7wq4SFiAnMpVNRI0i5VxmskObA2lM2CNYsiWXSmdRie59zd/toQWE6L5oHi6Ki
	 G/bFj30z99qqFBFwRByd0q+mRlbPGaWaQLGjPO75qvkP8Qo3/Qe2YchGG7rAw/VKz
	 0i3iLRWr/L9NhOqVtHqTIvP5XPTBo/0s/hExvZbICpX4wrRmi8Tfhsn6RVzUky4BF
	 B2LCYvfmjM/i1KcWTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1s5Dc10XuC-0095eM; Mon, 15
 Apr 2024 17:07:13 +0200
Message-ID: <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
Date: Mon, 15 Apr 2024 17:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenchao Hao <haowenchao2@huawei.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Hongxiang Lou <louhongxiang@huawei.com>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
Subject: Re: [PATCH v4 0/3] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240307144311.73735-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:izUBwOSRW+Fblv0kjxF4VBtGny4pVfwwEQZR41GrApqty52fkLo
 pcNE+Hm7fo738bynpdceUAqqSpZEg6WAANQkO3/tC3hKfWYgjPHt7G9S6oUc7kz5febtJj7
 DvnfhYX+RB4XdOnZZpB5fDdBmJb1prTXYbUTI40wDCF9TtpMpRda/QUIJeT2BEFvKk9HJmx
 o7c0aSaaHUMVmKT03me6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GG8nbAqW1m4=;6W/vM4M4GzDaZ9VGuYjUyRMcB8a
 1tu+Fm6SOAXcUPhDr+Phf3kvdIcY+uoAUkMGtmKI7gAREQ5Q2tTa0pxTdsRE4wox1cuZdV0VU
 W1JOqc1f1snWTNHiQHAAYZ+0OyUMFukAB2XJ1UFvR0YV7OFaQgatjYjBm3VC9OG2dpIgm94vS
 utp3NC9Q0yVxQnN3smCfGookJjxHjlsn0QfyEiktTsWfX4bSmS6Yovl+UIWC59ZYeppduMNY/
 YcBJ0BbEikdFCXovRKDDB2rhkwdk6TxW8vL24mrRuvWAvFAcr2H2amUqel74KXg0kWK+VuxHO
 XyOd2TVO9vDjzYFzC0pzQvmz/JOTGZ5jbpxa5f8o9wmfmpdPOoT6s7HXeDiU38ua5caj72SD5
 TSLxWNeiOUtKGf9E51IEGVmKlsrGTER3jKtkusXOj6VY7PbWiROZuqZl7O90mY1Ul2LC6TuYb
 kfEM7r8aWHrXCZBZ2RAcOG38y+D970FmQ/8h+Auo4hhcbv8m2++84up7DhegQZHrrQmWeZhfr
 UaQtCp+8/0T3EefoYP1XK25FY4jXVvYkqIFCPobFvMbjcAJ+68mgMs7ccM2uzTX0mrQ/AGvut
 lyLiXXr24BQWxufdbFfLw7xQqEOFH61LW/kvtWqzhbTesj+B8Vv6DabiPvwi2rfUlPk5BSyGs
 VjyfNBpCUIzkUY9VUGta284VdY4NjOte3uYjl+20U+nNF/hBIQRjrUI9aQRzaxnzXqsMTVgSD
 eVWU7GgzRS5n0qVUvAP9y8ba/aeSsO8jkN3gdZoW8nyg8Lh9LwbsNbu0oJ5GyAnxxV034w/ta
 brRlFv85TyvzUwjquphj+c30WAVN8AX2a0aKksvaIXRpI=

=E2=80=A6
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().
=E2=80=A6

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D to any of yo=
ur patches?

Regards,
Markus

