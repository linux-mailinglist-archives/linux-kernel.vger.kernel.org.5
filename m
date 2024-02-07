Return-Path: <linux-kernel+bounces-56283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB484C84A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB8A1C24D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2A24A19;
	Wed,  7 Feb 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5FymLmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245C25551;
	Wed,  7 Feb 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300469; cv=none; b=FzyRXkS43AN5GBoYeoQTik5A2PH+ZkozXL78TLDWwolBIbw0imZL758mUzURx5iHCI3qw6nnpRCFDxqYp2lPmN0/YcnkSeEvVtvQxLtVOWmLSwuM+PG7sqIDDgXGP99skNA2KfBfOfPRTE0yV0BcfHc/HZR2Er5ROVKjkYnwS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300469; c=relaxed/simple;
	bh=EkwACTzf00Vm/obOE2SzPEMWc5wOta4JYj23H9ozjA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+47mYqq/TzDElOn8hGi3p6I90p45ewIDi+Od7FnfbUv9jK8cv6+FBn7xiJkYMGHQoiwdSLhHoeXra5gZUq+R8esh07cb6QduHuqQS7A3GWl28F2IVPdjK9CyOU/mmf1TYhQhl/VW9WFM4hD+GIZPWP9DXf2cRskKZOiig/7Ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5FymLmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D45EC433F1;
	Wed,  7 Feb 2024 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707300469;
	bh=EkwACTzf00Vm/obOE2SzPEMWc5wOta4JYj23H9ozjA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5FymLmtm1UGv7rkSJUzFy/XqjAr+KzKn+Z4vBg0y6VPeeIs7oUzRGtyzVC1MUOm5
	 yAldIueXVQy2srgXS/Vfzr1az3K/exwAYfoHlitZlVVGtSHJFLn811wQlvjOpdSw74
	 xR2c36tsRYw1WoEC9F8wi6LGmVFIOxk0HepkyAmTP1Oi7yWm76dSrotGLw+LFRqjHQ
	 QQdz8jQG0Gr3UCirtOjW8LcsBb8SpY46QTm8EVOjJ+1FAlad+bJ7NxEcG66OMXMFUd
	 oQxOtsGkMWRT/uyG12NiSCf99MePyJwoKAD1lsjdsaAp19vYfmZi23BE5TuyU6NuN6
	 82d1BXiTgN/Zg==
Date: Wed, 7 Feb 2024 10:07:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: tas2781: remove unused acpi_subysystem_id
Message-ID: <ZcNWcqYEmUjtusfe@finisterre.sirena.org.uk>
References: <df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>
 <7f056a4148fec176812ff6cc490860bf565b161c.1707255917.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dXz+AyCXtdSYrj6n"
Content-Disposition: inline
In-Reply-To: <7f056a4148fec176812ff6cc490860bf565b161c.1707255917.git.soyer@irl.hu>
X-Cookie: You might have mail.


--dXz+AyCXtdSYrj6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 10:49:29PM +0100, Gergo Koteles wrote:
> The acpi_subysystem_id is only written and freed, not read, so
> unnecessary.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--dXz+AyCXtdSYrj6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDVnIACgkQJNaLcl1U
h9DhAggAgjqcZPJB5AA1yAgHmEW8VHnic9bdCPfZ3NDI5u1TWV2Hm76K2lDfH8/2
Y+2/GH/XZpEKdIiTSGlYvG0fTERM2Z80deweBmYSZ2TcavogndomZNdIiYGn6wqk
7QN0z7xR6O4lQJ6DZDecwcyLGD0BS5RSJDN4LNuKxK6liQfh/vRvxw7kviUoPxz1
H55nlOVs2+wuz1O/0+wvshJAwaHXNnBe0cjLkQD6iCz5mh9ldGx6T9dD28auycxw
IKKfGs5CWvJWz34oZZOgCMLEIZCvlZzlR3WVeHf3Ez6iGGdhFwIN3JVVbw3bPYOE
x5lnK1d3s4s9NNStBoAIqZzWoCnWLg==
=UT7t
-----END PGP SIGNATURE-----

--dXz+AyCXtdSYrj6n--

