Return-Path: <linux-kernel+bounces-149208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B08A8D30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581081F226D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1947A7D;
	Wed, 17 Apr 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wpQ4O3qd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9gGL2wJf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wpQ4O3qd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9gGL2wJf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2143D966;
	Wed, 17 Apr 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386688; cv=none; b=u0QEiTcsfoAUiv/pqmtdY5z0otnZXGoBBJPmnb7XDMHwZWh9jc1NrVyj96ZkM8A8DOW0anWzqMybZwFzVFcBFD3bt66awIYREV32JwlM/3gP5Z6z/npp2qi5XDINOm8yKqixIRaal+0lqcSz68/24bIAODNfY0dZcrUqraaMD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386688; c=relaxed/simple;
	bh=DB9U1UI6R50eyqIz5bih+l8dfU5+Kjtb1/E5iDsSgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llm95zmyBtcunnrYtGiaTY8PJXw3nk9OTl+RpbS+AD20gMHaTFBwOLaaMzoPOMoTyI+SqYWDh3VP2WuiXz5FF+URn19kndaBhQ0zYASFI1KRRVxBQ2YdZWUXO11T6ESbtpCd3NHuE8TMAaKLLpl2yN1IjNFfl+H0Fo9xskk0L/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wpQ4O3qd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9gGL2wJf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wpQ4O3qd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9gGL2wJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C739634226;
	Wed, 17 Apr 2024 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713386683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nVYq95De1VWYnmvf7sSPzt9WZ7Hzjsv8l9u6oT5nDY=;
	b=wpQ4O3qd8vCmXsLxepf9uovKJT19OG5tB4y+WAhQtOLuE8fS8duTmVJvyyFrtxTBqNoJv/
	MWGCD5NiJ3hMDXaf+45ukxlJ90DW/OL97GW0XMnV9lGdwmGFye/daouIbw5wtp279nJjCa
	b8q6Y8K6jwhKzOl752tSuLNSos9jRZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713386683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nVYq95De1VWYnmvf7sSPzt9WZ7Hzjsv8l9u6oT5nDY=;
	b=9gGL2wJfB8yuEQ50RDLZQZ62trOJzdsnZM7k8mg9pEgwbwfvIdBaoR+Wpg8VVDZSJ3T4P5
	Opx5n1Kb+C++BABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713386683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nVYq95De1VWYnmvf7sSPzt9WZ7Hzjsv8l9u6oT5nDY=;
	b=wpQ4O3qd8vCmXsLxepf9uovKJT19OG5tB4y+WAhQtOLuE8fS8duTmVJvyyFrtxTBqNoJv/
	MWGCD5NiJ3hMDXaf+45ukxlJ90DW/OL97GW0XMnV9lGdwmGFye/daouIbw5wtp279nJjCa
	b8q6Y8K6jwhKzOl752tSuLNSos9jRZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713386683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nVYq95De1VWYnmvf7sSPzt9WZ7Hzjsv8l9u6oT5nDY=;
	b=9gGL2wJfB8yuEQ50RDLZQZ62trOJzdsnZM7k8mg9pEgwbwfvIdBaoR+Wpg8VVDZSJ3T4P5
	Opx5n1Kb+C++BABg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B387C20136; Wed, 17 Apr 2024 22:44:43 +0200 (CEST)
Date: Wed, 17 Apr 2024 22:44:43 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next 0/3] ethtool: Introduce PHY listing and
 targetting
Message-ID: <qosybvtpp3bslfflbsmox66a5r3zujfvwwu6o7llsqpdsolu35@2iwaf4z4ilcl>
References: <20240103142950.235888-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2vmzhpu6ekfanvdy"
Content-Disposition: inline
In-Reply-To: <20240103142950.235888-1-maxime.chevallier@bootlin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.29)[90.02%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,bootlin.com,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,lists.infradead.org,csgroup.eu,gmail.com,nxp.com,intel.com,lwn.net,pengutronix.de];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.69
X-Spam-Flag: NO


--2vmzhpu6ekfanvdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 03:29:45PM +0100, Maxime Chevallier wrote:
> Hello everyone,
>=20
> This series implements the ethtool part of the multi-PHY support that was
> recently merged into net-next :
>=20
> https://lore.kernel.org/netdev/20231221180047.1924733-1-maxime.chevallier=
@bootlin.com/
>=20
[...]
> Maxime Chevallier (3):
>   update UAPI header copies
>   ethtool: Allow passing a PHY index for phy-targetting commands
>   ethtool: Introduce a command to list PHYs

As far as I can see, part of the kernel side support has been reverted
and is going to be reworked but that hasn't happened yet. Unless
I missed something, patch 2/3 can be already applied. Should I pick it
now for the 6.9 cycle or would you prefer to resubmit the whole series
once the kernel side code is complete?

Michal

--2vmzhpu6ekfanvdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmYgNLcACgkQ538sG/LR
dpUiaQf/b7sBQs68Qte0MbJIKu+NiISBrZYhTqZD7NAMuLPO3/9eUZ3DpMP7RRZ4
88CHYIjh0DhERMHzV4cDwG724JTfuKYO01P373G0jmIC0VOjr2tl1TL0lgImTzY/
kbRKxj7VLeC+2QyWXv8LrA+PJ4gyd/fp0ljg09/xx1/Fa36Du+IF69JwW0OyHfwF
LMit7fldOGA3eWwIrLnnHV/zB0+G2Ojxheo/9ZoJOp8kuyjmOAMLCLrCp/IOWwqS
6IKYSw5uW+hY/QWaw0BNd7AOytwLJg8BHwjJRpzXVFiKCsJ3d1Ydj46A0diCEybt
I9tXngauT8Z1072wBdJ6GmHgpI4cUg==
=WLta
-----END PGP SIGNATURE-----

--2vmzhpu6ekfanvdy--

