Return-Path: <linux-kernel+bounces-165654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA98B8F17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7049D1F226AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28E130492;
	Wed,  1 May 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iJMAy+Tz"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580F17C9B;
	Wed,  1 May 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584863; cv=none; b=eZ3RaD36qRbhoDE9z8UqnQ8yCgxIEKvZHhqKHklxijIzPAlLSzVdZCA0uJg2lbJzM424z8eXEKBUTbQBmVweSK+oe5weeUX+o1QkZLSSW3xEQZuiVrtx6TqcKjYYP+UPzEZWdT2f8G5dP0lqjBIomApLaKiCBkCTn2DD+pBvvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584863; c=relaxed/simple;
	bh=yOqewtbEvLvJUxLkGDrjVjmDrRj+y1aLBrnh6oYMjJs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cyaUkpVKvJWeUvq1uUtpXF5kuItWiuwWYvyradSULex7nFuOTpOqmOStSIUb7QnEv5GI4YQbUxPkOI7jugL7dVKB93tzxy6hiuoh3KhQmuVHSnsMXjrJms9ld6ofk5DJRwZ46A0hiYNs+czyjeCKrBDQzBDPLi6bMZvlxhiKYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iJMAy+Tz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714584823; x=1715189623; i=markus.elfring@web.de;
	bh=gO4YnLVa8TvAJ1FCzBqXMrZgFrD5LQKEdYPyOsmQK/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJMAy+TzxT006XpYKO2wp5st01dt40T4i5pLswwAwPKv6RGEI/y/A9m91YMhyLH3
	 jhP8L4FYkaS92Rd3Y1qIBRI41GdJPFLxny1ZQfInnK58p1P+PKq9jO0UCX+kdj5WW
	 anziNI9yiIPwACZdRPkTjyYiDUgNCm+VLBi/kXm/qhoMn35fS8qxvu56FhO5+5ulH
	 h0eRR8cl++sGNIVvYKrhW97GQ77gABWAqFNm6LhILUDA45Husf4JoFQpInqCoWUCR
	 DWC376lhFfDhCZIqRFznkFk4D/twW34pBqLkXFgJat96senvKLStxeq9+MzIXPoGG
	 CrlU5ikr+cEivmWejQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1sLOaD2zUY-00L183; Wed, 01
 May 2024 19:33:43 +0200
Message-ID: <b73a1728-cd92-468f-ba1d-c384de382979@web.de>
Date: Wed, 1 May 2024 19:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?J=C3=B6rg_Reuter?=
 <jreuter@yaina.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, lars@oddbit.com
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q0QhNBaMa5wsLnpEh01pGkGo+xGa7Cmhxz5H6RrtyyM1UCtb266
 MENHUAJ3pjNkyy7z2g0p8IuP6RBVGWJIA/pbToaMAfyjmwna3i46gliOoy9sYp7BEqPikOf
 Owi/C0JaBSl1f2Xv2n9jLOkN8ujhQzNDiDa0JGw93LfvF8uP0+/X/Ojmnr5kz2IpKV8Pf+M
 SCbvIAUuckYK4DHfqnSCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tombYyYfHGc=;q0SvgptX4FfL0yXKTtYa0WBtWaL
 A0PVcly7GxD4W6LEDLzOQrmouOVs+GoOSoMqvFHXz9WjrnD8LVD7qGKkt7kkwaBlVU0tzD6sX
 2zBfGPrzZJ8WlDS+iDQcT2D5pnyR3tPMm+4W1wIq90CC+KbOgCASnDyLfU64DcDfTvRzgxbyf
 KM6t3SLRS0FCbDZXMzXdmsUBEMc+NRZ8mOd7eFsNr5ndYCLwURnKfiOtCll5yU2cW9AibrDcz
 vakM4GBfK5+w+CW+QmDkFNvLhY5WQ8ebRsvFIcYWS2UorylJnQrydy+xJB7APvSDC3rpj6Jki
 dnrBvKvyrMxvPn69mAEuoNl4E6bLxbCUFmCh/jlw+pyt68JZia44FP3lmuy6XRTBjQDK1OCQx
 Gbhl3M2f0FSnQY8DNpttxHaTXmK5WmMRe3x3fVJZPq9fpFHL3/Z7hEOrjVENvNW6tIkQW7aaY
 Eko/oIOG9DceyF3zaTEU4Rmcl6U8CfEgb1NW9+a9BY5hv9j6SpAAv+4vjch4S8W/ub1JPeu/X
 d1H4Ym34Uzow6OjiT9CM2pgs1TTbdn6SMvFsJJwNZrPPLZi1IAlK9PmkYHo3Z2FNdQfXZtZCo
 dR44WvI+U2cwRJN9RDJcVQA4RtUk7iB7SqhYhtLfBrlLyiVM8N5P2eg6ggLbYaL3206UDlSjO
 1+eYdzoX9qCj0P3blbfhxYTUESzW3QSraskFtVVp8jpCQdHhX/1WQXfU9X1JkufMG7GnPvWUn
 d8PsgEz1wuyqGxJstqlB2+/cKtkshFBxAsGVnyyZz9mgY4RQ65WA9In4dQwxJJc3gIiMekNpw
 UKuo+YMTq7c5E30nme3YSe/wUZpEFGXRI1Ki79eTZCaWo=

=E2=80=A6
> In order to mitigate the above issues, only increase
> the refcount of ax25_dev when the ax25_dev is added
> to the ax25_dev_list and decrease the refcount of
> ax25_dev after it is removed from the ax25_dev_list.
=E2=80=A6

* I suggest to use more than 53 characters in lines of such a change descr=
iption.

* Can it be nicer to mention also the term =E2=80=9Creference counting=E2=
=80=9D for
  an improved commit message?

Regards,
Markus

