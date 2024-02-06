Return-Path: <linux-kernel+bounces-54750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEB84B32F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8DE1C241AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FC130E59;
	Tue,  6 Feb 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uH8brE24";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpmpijBp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uH8brE24";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpmpijBp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1212F5A7;
	Tue,  6 Feb 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217749; cv=none; b=PgE4XQTpaQQZFkUGytM7xA1TL0zAWYnx0juu8KzzaZd24JCzrRp9XReR2K315pGdeJ9+vcak1C2xGcUHLkPCI6j+R9Fg2ea9TxVV3vOsiu0r7VKLYFlUU1uGH6x31Jd4N5PYIYXCumd+1oru1Q+/zm5XUueP3KKmyTQocyW2Sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217749; c=relaxed/simple;
	bh=JobQ2CoI/T2II61TjDEzXR1IyAwC4J3VElbAVa6K1nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS0e1jXlLpyk9QNYHpBRQOgpdWyh1DmYJuyqQT710toJkbZfBb+Z2batJp2czDAt/soZlKBrgySFCd5KO3cg4bGF6siKZJwaXNjbh5XIOsOhJu+zDgSxx/O/qnYuXVWfnzUfOpQ7FBREmETwvMDPKAjoY/KTKcSCOQd33YUZwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uH8brE24; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpmpijBp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uH8brE24; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpmpijBp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66EA5220E4;
	Tue,  6 Feb 2024 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707217745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6OT4WYVPWB8v21SxhnQOwkhxXC/BXklZ/lKe1YRVr9A=;
	b=uH8brE24jrrN27ewLBBwxFEoWwm8k+2jtNJdZ3iGI5JqIoSbYyDY2tWJgBllFNX6+yNDiA
	dVVQw32FtJ+MxF1+n3boiMNXBQpzDSiVhpLYoR6sUG9Gkikn2csf8Ig+SGbumpZMQjJ1aT
	1jX4w/a52YA3ACPS6sC0BrpaPHYjA0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707217745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6OT4WYVPWB8v21SxhnQOwkhxXC/BXklZ/lKe1YRVr9A=;
	b=lpmpijBpuVV0Nb/HzsCBUOKupzpkFp5k1j6sPiWaXNYEVj0gDKQr4o9W5Dam6K9r0+o0oc
	M3vWhxeb/NQ3h2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707217745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6OT4WYVPWB8v21SxhnQOwkhxXC/BXklZ/lKe1YRVr9A=;
	b=uH8brE24jrrN27ewLBBwxFEoWwm8k+2jtNJdZ3iGI5JqIoSbYyDY2tWJgBllFNX6+yNDiA
	dVVQw32FtJ+MxF1+n3boiMNXBQpzDSiVhpLYoR6sUG9Gkikn2csf8Ig+SGbumpZMQjJ1aT
	1jX4w/a52YA3ACPS6sC0BrpaPHYjA0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707217745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6OT4WYVPWB8v21SxhnQOwkhxXC/BXklZ/lKe1YRVr9A=;
	b=lpmpijBpuVV0Nb/HzsCBUOKupzpkFp5k1j6sPiWaXNYEVj0gDKQr4o9W5Dam6K9r0+o0oc
	M3vWhxeb/NQ3h2BA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 4B1C220147; Tue,  6 Feb 2024 12:09:05 +0100 (CET)
Date: Tue, 6 Feb 2024 12:09:05 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, andrea.mattiazzo@suse.com
Subject: Re: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <20240206110905.ydxjbhiciiyuoq3m@lion.mk-sys.cz>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20240206104336.ctigqpkunom2ufmn@lion.mk-sys.cz>
 <032e2c72-c2a1-4b8b-96da-b0da73473648@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ezp3d6y6tx5uysi"
Content-Disposition: inline
In-Reply-To: <032e2c72-c2a1-4b8b-96da-b0da73473648@moroto.mountain>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.37 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.17)[69.99%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.37


--7ezp3d6y6tx5uysi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:04:10PM +0300, Dan Carpenter wrote:
> On Tue, Feb 06, 2024 at 11:43:36AM +0100, Michal Kubecek wrote:
> >=20
> > I stumbled upon this when the issue got a CVE id (sigh) and I share
> > Andrea's (Cc-ed) concern that the fix is incomplete. While the fix,
> > commit c301f0981fdd ("netfilter: nf_tables: fix pointer math issue in
> > nft_byteorder_eval()") now, fixes the destination side, src is still
> > a pointer to u32, i.e. we are reading 64-bit values with relative
> > offsets which are multiples of 32 bits.
> >=20
> > Shouldn't we fix this as well, e.g. like indicated below?
> >=20
>=20
> Yep.  You're right.  Could you send that as a patch.

Thank you for checking. I'll send a patch in a moment.

Michal

--7ezp3d6y6tx5uysi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXCE00ACgkQ538sG/LR
dpXa3Qf9EFBC4n7Zbu8vkttkV1PhDpvlxZbiBTX2d4ss2GthPDKjJhOjVXmgc0v6
2ctb+Aglx15NnbMm4bGL9G7XWSIpS+8XkmW0jNJN2b944SdGSjEngAZTSiXRC3Ee
QZqzbgmkimjv/ZQtFVIIEbAhOfUlxoCKcgHLog5i8SlQGnpgMLSGRzU+Fd+Ef+TE
qTI2U5hNvxBoBki9Z7UYGcReFz6oP8IfEzQnv7Qk+l6cmQJnmVBPTRfA7/LMXJS6
aMW/C7rkq4+0cZntN+WDM/EBHW1+ymiL+sHAflA7dmDesRHyH8FVWdlnAowW7uMw
XXjB3y1kSE6pPnkcXCRM8hRfVRKDig==
=iE/Q
-----END PGP SIGNATURE-----

--7ezp3d6y6tx5uysi--

