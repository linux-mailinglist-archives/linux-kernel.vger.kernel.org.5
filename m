Return-Path: <linux-kernel+bounces-150454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B98A9F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887AB1C209FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC916F8ED;
	Thu, 18 Apr 2024 16:06:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF016C456
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456367; cv=none; b=HmSZ9lvoIgzX4BRQwfHy1Yf5oEHtfXoDMXNftP6JnzF05Vr2R+ODTnwoylIM22H8tZuYnPEJ3aePd5OJPFnzdWlp+Piy4OMZU9u60ZHGkZiMFpNK6rVdhTfNFi1ntLO1uvhUJx6MhYdI1kXn+gVqMk3sK2tfC4Ps3gpD8d0d2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456367; c=relaxed/simple;
	bh=K2i9PH1Tjt5ygesnFTera/THUySdqfcQsNtai9oF11E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRQ8Vt+RVO9sjhqyU7CRuGUJNtTFoyPr1B8HOVlr+Gy9DBVjZ3ZC/PGcgw+pxNwjtDNvJpiF1ggDcmgIfUtfEL+dfnc9ep1Bm41FlJTC8wTO8wFH6Q8CFinE+PRoZ95IDo4OFLMr7pduX2GAJ7BC+I60+O2NrXQzGaqBc8UW7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxUGd-0005Td-JP; Thu, 18 Apr 2024 18:05:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxUGb-00D0SL-EP; Thu, 18 Apr 2024 18:05:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxUGb-003Ydn-13;
	Thu, 18 Apr 2024 18:05:41 +0200
Date: Thu, 18 Apr 2024 18:05:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
Message-ID: <jl35q23p7axlxaxxwo7652qke5luft4x6zsz3ldntegdpvmdom@ge6taosuwtnj>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
 <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
 <286945bc-f207-4373-9589-0a9b62df1b36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykmah4osu23j5yfl"
Content-Disposition: inline
In-Reply-To: <286945bc-f207-4373-9589-0a9b62df1b36@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ykmah4osu23j5yfl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexandre,

On Thu, Apr 18, 2024 at 11:46:11AM +0200, Alexandre Mergnat wrote:
> On 17/04/2024 10:06, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 16, 2024 at 05:53:13PM +0200, Alexandre Mergnat wrote:
> > > Add a compatible string for MediaTek Genio 350 MT8365's display PWM
> > > block: this is the same as MT8183.
> > >=20
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> >=20
> > I already asked in reply to v1 what the merge plan is here. There are
> > changes in my pwm tree to the mediatek,pwm-disp binding already. I don't
> > think they conflict with this patch, but maybe it's still easier to take
> > this via pwm?!
>=20
> Sorry, I though the merge strategy wasn't addressed to me because I'm not=
 a maintainer.

Well, you're the canonical person who has an interest to get this series
in, so you can at least have and express an idea. In my experience it's
good to be proactive and suggest a merge plan. Maintainers are triggered
more to reply by a presented plan they don't agree with than with
suggesting a plan themselves. And this way at least there is less
surprise for you as submitter.

> It's fine for me to merge it in the PWM tree.
> IMO, this change [1] shouldn't conflict with this patch.

FTR: [1] is in Linus's tree already now.

> Can you add the "Acked-by: Rob Herring (Arm) <robh@kernel.org>" please if=
 you merge this version ?

I picked the one from your v3 series now where you included Rob's Ack. I
was a bit grumpy because I only spotted your reply here afterwards.
(Everything fine now on my side now.)

Best regards
Uwe

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/c=
ommit/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml?h=3Dpwm/=
for-next&id=3Dfb7c3d8ba039df877886fd457538d8b24ca9c84b

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ykmah4osu23j5yfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYhRNQACgkQj4D7WH0S
/k7izAf/ZH/1sIKEwdV67ngUMbYN2YbYsH4wSHdDVJV5ff1vLlHu+FM6cf1DG8WK
fvW4BiQnriG3n5IIr/dPh+mKVoOqnxMEmynyp3v5tXo0MrwBC5Cf9cgOCq9KqMYq
KQ/8/mMyhMnIKuUIrkcFKPDX84dGIKkH86EMvsif1H6VhV+03jLmfcKg27RqGaIf
31s6IqjCpztCXjkA3menVz7AmxyIx39Vyt6CzVkq/kQfJ0NY/lXq49OhKFwZ/ZbD
bB49IiLJwEM47KX5WrgYRsgLMbSYigkwwhcX350+A0RtLHHhkz6Zmr65uIxsJQ9K
Mm+Tx8Dq7W4/dhAGg9I86+z045CayA==
=Fdj5
-----END PGP SIGNATURE-----

--ykmah4osu23j5yfl--

