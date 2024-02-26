Return-Path: <linux-kernel+bounces-81765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05C8679E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02E11C2B459
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3A130AE8;
	Mon, 26 Feb 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNaYGvka";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBsTalFN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNaYGvka";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBsTalFN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB6130AD7;
	Mon, 26 Feb 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960252; cv=none; b=tuTagVdbHtl3q1yvEqDeu7dLr3SpIYb5W8dETHdN5D5uX13qKAp9MafVxWK5SGw4u5XiE0xycBAEBeH5lqM+Mpo/P0eMvonYOdiAOWWaIiNqvOPu/w5W8P9EJQHIGIk/XZu+Dq8dAXARwelULwDj+5Z3g7OhfRQPgiPGVe+Y/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960252; c=relaxed/simple;
	bh=xn/pH+vPtBtele+UeKPThfWaFBEQ5GmIN19lX7//sGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBQU2yHpYRSHG9jMtS7ca9GIXVsvS69r7nxwImXEK5sYOaRyfpAt58rEegniyPIJoWg9evoJdXEtXK+vSGmG1klXi8/abvNpBXXF6lIUrFdglt/YL7/NVkAOwCEukGx1S31Lskuh1FoiJhSQem9Cewhjg+CpyU1D3uVMnPlQ3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNaYGvka; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MBsTalFN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNaYGvka; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MBsTalFN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74DBD225BD;
	Mon, 26 Feb 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708960248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn/pH+vPtBtele+UeKPThfWaFBEQ5GmIN19lX7//sGo=;
	b=QNaYGvka84rY7kBmWN/fZ+2Asnbtis4MDIzfJn5B8kWUzItQ72eHvTyMsxr3wB5FwJ6DwK
	m6JvF6FqAiMY7jEY/UUFsdRah4+3YI5xUMcJqpV6RGCs4achuEidUJuqNSf86NHRWNAJ+N
	yjKNXP0C6ITi3aPIMl6Lo78utYgoOkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708960248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn/pH+vPtBtele+UeKPThfWaFBEQ5GmIN19lX7//sGo=;
	b=MBsTalFNrWDr4rg2OQ6C2R5zQEBx56oWvq12h98aEV/A5NWE0/U1DhOpKxX6s7kp0dTirO
	tKqdAc5kUkFq6gCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708960248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn/pH+vPtBtele+UeKPThfWaFBEQ5GmIN19lX7//sGo=;
	b=QNaYGvka84rY7kBmWN/fZ+2Asnbtis4MDIzfJn5B8kWUzItQ72eHvTyMsxr3wB5FwJ6DwK
	m6JvF6FqAiMY7jEY/UUFsdRah4+3YI5xUMcJqpV6RGCs4achuEidUJuqNSf86NHRWNAJ+N
	yjKNXP0C6ITi3aPIMl6Lo78utYgoOkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708960248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn/pH+vPtBtele+UeKPThfWaFBEQ5GmIN19lX7//sGo=;
	b=MBsTalFNrWDr4rg2OQ6C2R5zQEBx56oWvq12h98aEV/A5NWE0/U1DhOpKxX6s7kp0dTirO
	tKqdAc5kUkFq6gCg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 61D0D20147; Mon, 26 Feb 2024 16:10:48 +0100 (CET)
Date: Mon, 26 Feb 2024 16:10:48 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Lennart Franzen <lennart@lfdomain.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] net: ethernet: adi: move PHYLIB from vendor to driver
 symbol
Message-ID: <20240226151048.avr3qaxdxwactoxn@lion.mk-sys.cz>
References: <20240226074820.29250-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="owllcezk7bkfsbh6"
Content-Disposition: inline
In-Reply-To: <20240226074820.29250-1-rdunlap@infradead.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.20 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.00)[43.59%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.20


--owllcezk7bkfsbh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:48:20PM -0800, Randy Dunlap wrote:
> In a previous patch I added "select PHYLIB" at the wrong place for the
> ADIN1110 driver symbol, so move it to its correct place under the
> ADIN1110 kconfig symbol.
>=20
> Fixes: a9f80df4f514 ("net: ethernet: adi: requires PHYLIB support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Closes: https://lore.kernel.org/lkml/77012b38-4b49-47f4-9a88-d773d52909ad=
@infradead.org/T/#m8ba397484738711edc0ad607b2c63ca02244e3c3
> Cc: Lennart Franzen <lennart@lfdomain.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: Nuno Sa <nuno.sa@analog.com>

Thank you for the quick update, now the dependencies work as expected.

Tested-by: Michal Kubecek <mkubecek@suse.cz>

--owllcezk7bkfsbh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXcqfMACgkQ538sG/LR
dpUgpAf/Vi0RzVEjPg5VK1CXIo1F4djgYRitLryRYpAd08//OsnLFxPy0y/kG1CE
9YGxN4RsR91bgEKQ1+e6ViM2FT98XoHSuvcjFLNwNg2r9RSsTY7GrME42Y6qle5h
lDD2myLgMPRH3Q6yjbNp5NAz4T6Jh5bu7dVLWm5VbWx1mV5YRD3sGDgNvgJQ3hzp
j2w2xj3XecBo9jXNvNyycMR6gtV5OUdl8wMkCguzYTUcJSHf1zI5ZmN8zXnLcMwT
SioQj+13pAIcfh9ZkPqNUJmWM4/1rUQ2n+3HO2sr+LutAFoRDmP4gmCtLz5W87bb
UTJGlP2hO1dC7ka0zZvHaZRleTk+8g==
=feKe
-----END PGP SIGNATURE-----

--owllcezk7bkfsbh6--

