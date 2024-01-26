Return-Path: <linux-kernel+bounces-40119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BC483DA84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F79B2B12B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D01B806;
	Fri, 26 Jan 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Uhbhcg7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12qfUbjT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CE1B599;
	Fri, 26 Jan 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274326; cv=none; b=ZHJ89n3IeIP204bM/0YCA4/cHJnVXAP2c1TdtvaY/sHzttdBk1QAWSNIPhVLt+12k2jqh9APv5Ycknjxtc5iPhYNLKiM7qXqF8uWBUc5NQCo7fL5sJ/yFOUhn9/OSJsUUy5ogwQzB0py0s2pI9he2fI+C3ZOauLsnQbzqB7G1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274326; c=relaxed/simple;
	bh=Nr8QKXIT9eS/FyyD/NH8+PF7e0exuuXWzw58fkOb0Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LfS0P1aPOmAL7MRDtlwww/RHMDOl/kZ96X07slg/3cgYN8FmIQ9w6SUsqyfoFw82O5aJm6z5Lwq5HMdGtDkw0wbTx3Y8SRTi4NXQ9m84SlpcqXjTme7qlQ9B1R/9VWLt6tqJhtEPGqCNOhC0+GPx0frPmSzCx8ntMz2/yjCZuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Uhbhcg7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=12qfUbjT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706274323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr8QKXIT9eS/FyyD/NH8+PF7e0exuuXWzw58fkOb0Tw=;
	b=3Uhbhcg7EaINbhkZZsqTT4dahBwElAFdmYSv4WTRtFnJ2Gk5VEtDVrCXxj5VQC5QU6DICG
	Zk++iotOh+WSjveTl+Rj/zatNPKA49mwawGn0M58UEnTjGv+aarSi+Gj+slsDRdkrUZVdF
	N/dYwYnc72/eNLu01AwWMx4B4Y/Dg26Dw5xao552cBYqE/buzyMOKDiy5yxuH+3GXLeniM
	eoD8AX1hYOR23j72x2yaXVzFg66dfdX98MGM2vCOF4QeHgC6xlTnVXrQfCeprdqmh9nHuY
	0l0BTb+/c7vnGF8a1JpiCzTaWWohqYAJEVmIVffoXr6nOumo/OI1TZxMjHuaVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706274323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr8QKXIT9eS/FyyD/NH8+PF7e0exuuXWzw58fkOb0Tw=;
	b=12qfUbjTTs06WtM/BZ2qEmPP4CDsQDtjCiphcmppyP7CsZPkkOX3VfvQDdmST9wOhYxG8a
	D3WhyJAojGBjHVDw==
To: Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>, "Abhishek Chauhan (ABC)"
 <quic_abchauha@quicinc.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues
 default settings
In-Reply-To: <379f79687ca4a7d0394a04d14fb3890ce257e706.1706256158.git.esben@geanix.com>
References: <cover.1706256158.git.esben@geanix.com>
 <379f79687ca4a7d0394a04d14fb3890ce257e706.1706256158.git.esben@geanix.com>
Date: Fri, 26 Jan 2024 14:05:19 +0100
Message-ID: <87sf2kmei8.fsf@kurt.kurt.home>
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

On Fri Jan 26 2024, Esben Haabendal wrote:
> TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to
> use the first TX queue with TSO and the rest for TBS.
>
> TX queues with TBS can support etf qdisc hw offload.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Thanks for fixing this,

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWzrg8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsR4EACAixCTExVVvJKDoEaA5WUUXJCVboIg
jdMPpZgrqtDW5yPCCZ4KJYSGxhvinkc1aBi3M+SUwHodKYbLHea/0un3H9d4ejJp
Y4ly+Y5bJSquL/Hj53W0RsnNcsFDUN51un1at8EukUfGWBPoYJqsDG97KUvGF9sg
fb1pP0JuXOeUhKp3Mp2+e0sFjAhQwQrfGzSRnHkmRpModiKfysal3sLzynuLc1yV
YuqsHvoJLnlYdKIF9d8Cs6V5vZ0Qhxr59PGD7x/Drf/YLF/JZIKSNzTMpYzuD1zM
Ojed8Tyk5CBjNpb2+zX2Emce8m+bziw5XEUJ0xf/HpXUFBoyUwbYBYSRyFbNZsNP
h7cwZhBtybYzO49wVaaYC+1S/Y38/REMMVgh5sRBo35WFiVPtrVs+R3Q8Y69JXaw
87bA0z0iCQIHNUiId+exblegAj5wn+X1GfUCWoAcbOH9GgyrvEnmU7MxwEEBgPTZ
clROPBVOFdnCh6wenznF92XKJK/mmmDbUXw3me/DkYh4OwnVZ9ROgFDHxWIn2P6O
st/SsoqbfdOZmNTFnRit3EWhUbVozx/Ml8wAitITfbCBuwKl41mN3rR2sWtJHWtK
840sKRtZoGO5qoFk5L7of1cCKWQalUqlpqbBhBrIxlx8qw81Nt4gTvE0Fa80c6Cv
YU+SenSIi7lCxA==
=/9bz
-----END PGP SIGNATURE-----
--=-=-=--

