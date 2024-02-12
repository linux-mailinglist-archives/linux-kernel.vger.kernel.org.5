Return-Path: <linux-kernel+bounces-61528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABB85134C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB24B261B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F033A8C1;
	Mon, 12 Feb 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J4AgM9ro"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25C3A29A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739980; cv=none; b=H/bK27LTsXKA23JebKnU2l01EDUNmGUb8S+DSqzr1WQtZCgcx0oRDJnWuvtiqpVvvINvqoUhA4PhdgyDUmHMaKY4Jil3Iisw8YzZcYlTKxLNvlIfSwAj+8yxNVqqlY3uHFkpXtDWZFfaiAhK30sfOF3VVkswxP976JK03a2XB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739980; c=relaxed/simple;
	bh=JJID6F7jqLHRWeoC4iyAEKo0jO08alUsrFdpbpIKcnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPor8Mb5fjgSoRz508FiwpSb87LeXCkG3v1lDzDQlca+Le2tVgk++e0eI+Ew/mPVmLDkCUht4ZDB0fmmkYxqmwl2pD2PUQ9bBe3tFrFEP4PDsUV/U6bKpwWvZhX0eCriztk6ngmhUbfmJH3Z4Mg32joeRAR6TB9kneJ+7cfggVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J4AgM9ro; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Av+Z
	w72XMMFy5JIv8FNYIcdnZNiuXEaLFUQ4ZS3b3ps=; b=J4AgM9roICuQi7Jkud1m
	0Vg1pK1jOtVGjtPgGxRRNr9ay9CUFHEFBshRvBtvKhrZ3M8926JgceBjAco0H5HH
	rASATTrjjljdBXLUQf8j39d7LJk3Q1KyUYBiZdk91Ai+2VyILrPQ8IdXTr0QRQOL
	W14hW8Vwa7hIZgPe7Jgwx0Ub8dgMsB5Gg7mRVt8rmgBNgZXWWOVyLphvBYM/+QRr
	W/yHcE0P/J88T8mYybhmcjYm2I4N4clOhcNvh8/r8/GboostT2YLHlfzqP1OIULO
	b7TxjKanC3ossl2DUPRGS96Hk+C+CoHQjp3aypAbmJSRBruQ8Ehq2sDRX+oAORJi
	OA==
Received: (qmail 472363 invoked from network); 12 Feb 2024 13:12:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Feb 2024 13:12:48 +0100
X-UD-Smtp-Session: l3s3148p1@BZkmMi4REL0ujnsZ
Date: Mon, 12 Feb 2024 13:12:46 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lee Jones <lee@kernel.org>, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
Message-ID: <ZcoLPnA8TEAgBk8O@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com>
 <20240209132837.GJ689448@google.com>
 <CAPDyKFpho16DU7OorMgXDqiyfFfgM_tWu+DZZOHd0gbjtBw_Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WPOTux91JoqdkWnh"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpho16DU7OorMgXDqiyfFfgM_tWu+DZZOHd0gbjtBw_Cg@mail.gmail.com>


--WPOTux91JoqdkWnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee, Ulf,

> Please add my ack for the mmc related changes.

I prepared v2 of the series: rebased to rc4, acks added, capitalized
first letter... waiting for buildbot now before resending.

Thanks,

   Wolfram


--WPOTux91JoqdkWnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXKCzoACgkQFA3kzBSg
KbbXFA/5Adwpk7uBvG4XZys/soyfhY5STCt46XOyDGvVtx3OOA7yyElFgTX5vLdG
3gSN1ibYROPMSIxKzKIWzWld7qllopX2PXgSbMlZT4sefYSYy7/LrAHSu1yT8wwg
RGMTqxTWG0JuihBlXjSWqaSmf80SROg/Z7FvQmjtTqC+9r4tnMSgU7YiBkrLh4+X
1gkmvyfiejTG9vMCBy9JIUB+Ytgstga9bl34YZVtJcw8ibzXuFoZkipBJeNdSW9i
xh5bD9jXLAI0fflgi40hTvACfPasmPGjaEQL8AmfK0O7J2BWQNBOkfrW8DcdnofC
sqGZU5iZf/JwjtwjNInst1NqmEk+lbg/gkO9gnOsISTTbdX2B5M4A+2OETNHcQTn
5BtssULqamCN/L4Br3+ezOY+WEBAiqKzKe6hAY+omjGmdgNS+ZjAnRHVnJYrl8M5
X1BMDGzmam5d3L9ShLtW2wx4UbXBJtSlKJIIa9Se5G0rE7awSonTVyCwwdYYqKPA
55abvqJw7jyWQWxoXgZLp/Ncax/9sy2UUek3j2QQ7VKLpBjf4KNBL8BjIfoD8/Ib
HKQHNuNkRqw6ThByS0dRD+gSbYePx/H50TKMLnGJcA668vUeUF3EPDrzvC0AnVVw
Ay4novGRFFNxzh+yjzRN499TGr+qipzt1fW6naQ/QbKfsTgXpvs=
=aoMa
-----END PGP SIGNATURE-----

--WPOTux91JoqdkWnh--

