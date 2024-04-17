Return-Path: <linux-kernel+bounces-148472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C48A8312
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396931F2449F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669013D293;
	Wed, 17 Apr 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="PqG9xg3J"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AC13CF87;
	Wed, 17 Apr 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356661; cv=none; b=U5b9lWT6AL0q3UVSqS4WcF0475Qdtq0zkgbkr5V3DPCmeqcFF/PEzuZSXnNpNbI5P0UGBwBF+H9tq3X089POtGkLwVC44VYsPy50499SSz9EMOIvi6pKPf+P9ePsBCGHkyMCBgpeUI89KA0p/yvGipV+2P2Y3cb9+aiqKeyxD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356661; c=relaxed/simple;
	bh=gBNNnlmORzpHW6xq9PwyOtjdy5heFzroyMx3ew5toI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le6FH4x543P/zZkmcwsCb19L+SCg2zV9cxxGblTvn9GuGUjovwD++5nQPG39kZJBwsOQn6SBu7XKL+3wBZVa62p9lDAVmId+YI5NcvG9L2sS7PRcRrh10CwfBD7tGoEsyWhPUOgY546zjxRvBzyHKhtHygZOuvRVKxwhO5n2SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=PqG9xg3J; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713356654; x=1713961454; i=parker@finest.io;
	bh=RSgA5ZypIHr9ZAVZVoPEvyLi5ROWgRxVAWumsOOJSP8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PqG9xg3JpUZRVsU2chWUwB84RE0FxnaA6C/8E4I3Fb1vrBAPtwTXKJ5AqaBhURGQ
	 6VeNxY/DipiIg6kqq4yMw59aICxgZciED6o+nsbZhW/+DAbsvcnMC4yKW0kUxPK1B
	 tRPJHbKE7hFxOECOP43Fq1LYckR32XPBI3eHq7qit8JxOYb0pl/G9nkpOLBtYMRGa
	 t/eTTGqRs0SAxSg9K85b0RX3HiTFdsQVDAdB4eP/6tiBMwspfZLXYUqJCdB2qds7/
	 +E3Dn0XW13KB37LC9gqpbMEYGsNmK6my3814eNimOwE2wSJ6uetRRJwMbcPR9VwiW
	 uFtpjyQ3a5IdBiw1Ww==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N1xEj-1su4rX1ofx-012G2L; Wed, 17 Apr 2024 14:24:14 +0200
Date: Wed, 17 Apr 2024 08:24:13 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 8/8] serial: exar: fix: fix crash during shutdown if
 setup fails
Message-ID: <20240417082413.70397ccf@SWDEV2.connecttech.local>
In-Reply-To: <2024041746-galvanize-satchel-09a4@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
	<1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>
	<2024041746-galvanize-satchel-09a4@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7o47FeSUWwTROTViXEZ0td1cN1a5aTVyViFUE0FwTEiKCVSvn+Q
 OZrDzSz20AubuTDKq4JgsKnkjzh55NFCCi6KTi4DGzWRzdYks+Q3cMr/1HlSUpqYHCVwFXu
 vDdoLGPq78X/ss2jq+BnjJb8nVvGN6W9d5r3WjzKUy5xJJ+lnyBNZy2SfLTaDx08MUlsugK
 uT7RQ0X/fRoc9wis20QbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+3HOV8EW1BQ=;ioE1hwDgtA+gqJt8whatZf64T4K
 mZciRq5URD4Ikumb7t+4R+cfArP0BNgmAJyFW22WF/8oet6LOm6nTgtmT7/+i1gFy6StMV0K6
 FnvAhM+c6f7ieVTqwmtyuXXbkpei98QQw+Bbs4dJ5QF11/rCoXsfx/8Rqw0IfxV5w3wPb2Myt
 d4ckL0JDc0k0qk82UTvWU3VD2IqnptiicVFZs8ZRevA8qO695LEML7kEM/qfrkEKg9Syj0uW/
 yTciZwYNc70+j8pDy3ykD76AeOczc1la5P0cv/HSh84YP6Kw4TA140Uq/8mkiCJLV1uOUWWEh
 VcxxCjlA+hH2ldM4XSrcOsn7l8Hu6EzNdIuOf8/jIxG0MXZ2ZQ3jJlrA2PQY9oAzu6IeqWqu2
 NAy3TnYUtEdMX07VaM9MSLgAwgydZMXzDLn1HHJPzRSbHyL2RYIc4pVCUmPj5bSUJnXM0mHGG
 34zc/Ab1guU1jXUVF5Uz81tQpn/uGTDDuErF0Ac9J5k086NQZU5myh+cAU7poBM9zjKHXGnkd
 qK09xYMhScsJCv4j06vb7BFSrx4FzXoeTzN9YD1Zxy8ipMjLrsvSauPr1bVgRin9Myo/hqHNQ
 WtKy45jDGE33KV8bXJ5gwOr21QJLMajJe2BwoTdPK2UqVBzyuogUm1zeKAmJjJiFrbhkcwqNg
 5hv9mGM1icI5msMXZMLvfghh1yEyI/PIEsZ6UTiLM6pOmFBHALkrQ/S7gqUGsqKx1BlzcKdOi
 uKOjWvd96nLk9l8TmRNLya7Z9HqX92lDfaByqKLiE1dLAHY3yHnHhI=

On Wed, 17 Apr 2024 13:19:07 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 16, 2024 at 08:55:35AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > If a port fails to register with serial8250_register_8250_port() the
> > kernel can crash when shutting down or module removal.
> >
> > This is because "priv->line[i]" will be set to a negative error code
> > and in the exar_pci_remove() function serial8250_unregister_port() is
> > called without checking if the "priv->line[i]" value is valid.
> >
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/=
8250/8250_exar.c
> > index 501b9f3e9c89..f5a395ed69d1 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -1671,7 +1671,8 @@ static void exar_pci_remove(struct pci_dev *pcid=
ev)
> >  	unsigned int i;
> >
> >  	for (i =3D 0; i < priv->nr; i++)
> > -		serial8250_unregister_port(priv->line[i]);
> > +		if (priv->line[i] >=3D 0)
> > +			serial8250_unregister_port(priv->line[i]);
>
> Is this a bug in the current driver?  If so, can you resend it on its
> own so we can get it merged now?
>

Yes it is, I can split this one out and send it on its own.
Thanks,
Parker

> thanks,
>
> greg k-h


