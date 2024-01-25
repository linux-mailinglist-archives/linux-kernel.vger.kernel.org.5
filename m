Return-Path: <linux-kernel+bounces-38472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2583C063
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3737C29D818
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C35B5BE;
	Thu, 25 Jan 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3SnLV4P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBv6uUoT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531B45038;
	Thu, 25 Jan 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180601; cv=none; b=a9S2AJ9+xkIyVjHiRkOF1yf9n7kJ7KQUvlDluNS7gSaMZYzbq+EtCq3hQJk5/FPXWHhPlfkZ5E+tf6k2DGPsaBUI/0ZmUs1EqzMm6+3KUxCZpfqirE2x2D9l2uPKnPqVJScjcJkA6fBkS2JAhMgBfmwqj4bufpe1qTaAuifEPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180601; c=relaxed/simple;
	bh=UGg3yUqQ314SNJxAbWSQJNKui6kWSnV25W5yvKL41k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+6dJ7YIgb/AQwaxWcEpt7AN6Uk7aIslv0E8ZAIBnDZdDvyLTAjyAR0zxcxgaoEC3KHQm8tqdi9fMqInsbi3WGGvY7toia3pRyOCKzKy88WI/abqLYePg5F1MIY2rytmRkX1vDN2KZhBfpYTCMIwy/DSrUIbSFGkXXwdChi/qzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3SnLV4P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBv6uUoT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706180597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGg3yUqQ314SNJxAbWSQJNKui6kWSnV25W5yvKL41k0=;
	b=u3SnLV4PZaCoZGJ3bJ25IlxETtood5AIfwRHarpLIu0DQJKJiE320k6VU1EDkPJ7NBI7Ar
	0D+Pg9k2f6KMRYV8Lff57+Y5aQzINaDvDVTZIbLkp/YzfM69+BgeTEDKiOmFjfMAyEfcUK
	Mjs5UgUYahdJtJsYXpdFYuCX42E5hEjliwPuLNVgAc2mcYbV9Hpku24tAB17brXjx7CkKZ
	MM6c8qD9QNaqQ2gFBcIpNK3Sb8Ti1z0fzUDZ+MM+vwLm+Dp+QEmWLG7lB2YGhHDHvMiepr
	1kIG9HCKfZdAtQeuZp8Rsd55fSrq8vA9XaFT76XXuUSivIUjnyCF4PoNYdBKEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706180597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGg3yUqQ314SNJxAbWSQJNKui6kWSnV25W5yvKL41k0=;
	b=jBv6uUoTeqQ7ZIsiv5KNrixbFEaklvqN2Pjq308Ul+wdRoYBuqemFgZS23br5QDL7WfJ/V
	FloqYx5d/nfnYRDw==
To: Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: stmmac: Time Based Scheduling support for OF
 platforms
In-Reply-To: <b807c2a70dba9711376b265b6da5fb5ff14589aa.1706105494.git.esben@geanix.com>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
 <b807c2a70dba9711376b265b6da5fb5ff14589aa.1706105494.git.esben@geanix.com>
Date: Thu, 25 Jan 2024 12:03:16 +0100
Message-ID: <8734ulekuj.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi,

On Wed Jan 24 2024, Esben Haabendal wrote:
> This allows enabling TBS for TX queues by adding the
> snps,time-based-scheduling property. You should check for support for this
> on your particular controller before enabling. Typically, TX queue 0 does
> not support TBS.

More a general question: Do i see that correctly that Launch Time does
not work for OF platforms (such as an imx93) at the moment, because the
tbs_en property is not configured? Or why are these patches necessary?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJSBAEBCgA8FiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWyP/QeHGt1cnQua2Fu
emVuYmFjaEBsaW51dHJvbml4LmRlAAoJEMGT0fKqRnOCL50QAJcDSvbiM7O1gNCH
paOkpfL04tCHg41ccGCEEDcDNadgMVtdEupNV1xwikf5sNYd44FDXTm6U0ad1J5H
Ub8/GbM+rGdz+5fSFRB+C/XX0r9VIhEHZg9QErNO5pTt2syYko2R4LobCvJMiAF7
sGBskqeV/De7CcOkHwin3pjNYIUxAPluKqUnLKubxK9NEVfn9ZL122+5rqFyUAux
N8S1KBvFC+QJ2iizSHPmf/99qmeJPbzyWVL10jqXsg5Xs+ZsOes7mVHXUe8x+e6I
TVhsP5SO9q4XxHAqiuLoC56svb6MPpg0DOGL/adVOAL0y1YSWfgpLqQ8wjNgpniG
jSDJnRL9rY8+VowQx9EtsExAemH2w8xfD71rjwTISJKSIsJskcc7pDb9wc3ck29D
xlhhOHgrLgDOfAcHhwM2cQT3ebJD7tQU65yeedjC2hU1rKFXvcT2E7+Ia9cAne+k
lxse7NTvbN6joDFwFKlJfCKC2Gs616WhK7tvomnzqzFnqle0bS6psW6ybkyLZvRb
0lDeRdYPcnZj8SpxhV9XFkX1njmNkHNw7gJA5WEMQciLnGE1+IS5aiifXNLlALXA
JbaEaQ3qSSivqh6Pa4kb87hGvh6gDRSo9LD8Uw7ViK9yXeSyrdsy8lEX07TbTj5t
dwZF0yXrFem0vJsm9MBfjxTJpRZ+
=1RFb
-----END PGP SIGNATURE-----
--=-=-=--

