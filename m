Return-Path: <linux-kernel+bounces-42575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7C84034A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739321F22351
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB95A795;
	Mon, 29 Jan 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ij/fcDFH"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0403CF77
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525764; cv=none; b=RplIDrDSm/KcOHBGzAf7tI/UhrjtJHiKRgGON0f9cRRWrU4KRrBQ/RY+tn3+zsgaFiSFlKnEosGnbInTv+MUOsIM97nH4rOVHV6NiAYPXgk9Z8v95LBKowKz4vUrh3cpH3cmwxcvu6O05qdWOG5ltAtFj5RUAZJKzZOIaT+dfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525764; c=relaxed/simple;
	bh=gQ+bkqp1o7w6DpXGvLyO3qBfZJBn2zhyUnneYg5MOUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTseFpuvmk4ObG3O64GiMEQz46bBDR5G2HPOqXEyZMeeNF5xYI3sinz9LAxbosw/fGh4xEa/ZsIzfkqhL+2TgVKd+NPN0NJhTKta3Ka6/VKpYXjal+apPW/oG08djg+dqLbC8dm06c6CjrZMqoOGOf4yrEumRitmuQ1cQzeN29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ij/fcDFH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8Vds
	N256lqT0aql6yEsOs12eHyuM7++ETK7rDRF3YI4=; b=ij/fcDFHetOFQcKrVOvV
	0Qn79z/rMW7AOAtzX2mbgv68+NVz+4T0FZVtEYr+NCB6t/O3986dv6PPzJUm1zFL
	1wro4VX0UNSyiL19hyjy6zDiLjs/OyW3ELPkuEHYN4rReSI+dD+Wy9+IzOmI0BYq
	Z/+2AJqeSEf3EyV4cjIqOQ1XyabCHr0avzqcnkRSkPBiNAOT0FhEb2jSTFKmhC+y
	egulRm47zDeqYzDvQpl+94qqRRhAdHKug8wXDRmH1yTrUsAPiLJHnAVxhlCdfdbO
	/qvatcved4g9oD8KKiBwzX5LBb0hduw83gOBmP8cE3m/T6aKq++BdTaRc/CifAun
	+g==
Received: (qmail 2447710 invoked from network); 29 Jan 2024 11:55:59 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2024 11:55:59 +0100
X-UD-Smtp-Session: l3s3148p1@Ym6qfRMQYuRehhtJ
Date: Mon, 29 Jan 2024 11:55:58 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, takeshi.saito.xv@renesas.com,
	masaharu.hayakawa.ry@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZbeEPg1jc5qWJa5m@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HF6yaJEjzgKGpRxK"
Content-Disposition: inline
In-Reply-To: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>


--HF6yaJEjzgKGpRxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

but one thing I can ask already:

> Investigating it on RZ/G3S lead to the conclusion that every time the issue
> is reproduced all the probed TAPs are OK. According to datasheet, when this
> happens the change point of data need to be considered for tuning.

Yes, "considered" means here it should be *avoided*.

> Previous code considered the change point of data happens when the content
> of the SMPCMP register is zero. According to RZ/V2M hardware manual,

When SMPCMP is zero, there is *no* change point. Which is good.

> chapter "Change Point of the Input Data" (as this is the most clear
> description that I've found about change point of the input data and all
> RZ hardware manual are similar on this chapter),

I also have a chapter named like this. If you check the diagram, change
point is between TAP2 and 3, so the suggested TAP to use is 6 or 7. As
far away as possible from the change point.

> at the time of tuning,
> data is captured by the previous and next TAPs and the result is stored in
> the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
> If there is a mismatch b/w the previous and the next TAPs, it indicates
> that there is a change point of the input data.

This is correct.

> To comply with this, the code checks if this mismatch is present and
> updates the priv->smpcmp mask.

That means you select the "change point" instead of avoiding it?

> This change has been checked on the devices with the following DTSes by
> doing 50 consecutive reboots and checking for the tuning failure message:

Okay, you might not have a failure message, but you might have selected
the worst TAP. Or?

> +			if (cmpngu_data != cmpngd_data)
> +				set_bit(i, priv->smpcmp);

Really looks like you select the change point instead of avoiding it.

However, with some SD cards, I also see the EIO error you see. So, there
might be room to improve TAP selection when all TAPs are good. I need to
check if this is really is the same case for the SD cards in question.

Happy hacking,

   Wolfram


--HF6yaJEjzgKGpRxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW3hD4ACgkQFA3kzBSg
Kbb8Dg/8DrowMh5CLHCBUWs2/pcKYYF4sJe4baRaxs4GocwbmVVc1hMMdKJ6BY1V
beHVjZES8O4NnMzQqkmkMGWJEkd/M7XdKeZLT+R+SnupO3AtFcS3mBFyDSWF+wA7
bAc5EuIyIZ4pPkrNf3f1a0xa7Dq1wpX2qGGud69e0ckprXn8xLh0f5L1Oy469L7s
uj7xEsUxf4kgCsPtdIksFiubebBrf8GJ534R9d4byOMZap6BRNEBgrbFfRJeldkV
U/9CH+WngENnRi+COcOjGQmPXc+9Kk/S5O4GeVS0V496Z1zMujUtQAK0S7akvLpo
y+J1D34OyKBGcs6xf6LK6hXEPLxTrbTjV/CVope5PcO0XiEp2HsZ1SPcWT0r8OOZ
cZe51zQWxms04J35ggkILJPAmbvvSpQLjDCANP2UvyAh63d7tXmUAdrA0qQqfbMZ
OXREgvHNw6/+S0PkqdnS7U5vC5+PrvzS/rwM4QUCxBE5yHDZ+QPA4OXu7vNiciwL
OZjwOxcuRXlOJf8oxgpHdFoInHVwy7SNG0716yTCEgVxpLsVCOdCzKJXet/2BWH3
q5XspwgKQLIl/8eu78wcK81cZ4r6R6bmwrn3yV6urUzxdy0IWZVQmbY0HSaMzI6L
q9qoNKj34IftkZVt0aTcZDy2F1jC2P33biFcYxQWzUxrJ6YT4UI=
=jnUv
-----END PGP SIGNATURE-----

--HF6yaJEjzgKGpRxK--

