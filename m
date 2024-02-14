Return-Path: <linux-kernel+bounces-65299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F50854ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E825F1C21426
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF554BE8;
	Wed, 14 Feb 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWD99O0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064554672;
	Wed, 14 Feb 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918949; cv=none; b=QZfv4ciXuxaG2DReY0inHLJIMpb1/+q6b0gDGf7hoKSZdzDB3hj2/wBkXxANmsxE+H3GiHFEISshemjr6VTgdqQqoijSCQmUqvWunFc9lRIuVWU+ECipHasmAsH7O7ndnAT3dM26bwBlt2oOiR8BdUA+xR3lSJsCyi1gLO+Yw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918949; c=relaxed/simple;
	bh=qI2tJMMzDpXYgZHx5MTPR1dpfKLeuqq+4zoZm9vaui4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSFmTaP2Aue84bhVaG1ZsJXK7q7rdkuqBJrwk2JMSbrWmJOERWYWjchpM+96VWCkvQ2kjoWwa7h8KYFkMQhNSu5Ucqiag2Nw3VSlcyisssdRzDZf+3Zdxp94M/Pd1qA5mUey5VnHkiNkkLAjZb4QjGBoCt8c9ITYSDa4IT8AGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWD99O0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA7C433C7;
	Wed, 14 Feb 2024 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707918948;
	bh=qI2tJMMzDpXYgZHx5MTPR1dpfKLeuqq+4zoZm9vaui4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWD99O0PEakppypKxvK91Rpan0CBLQL/xhsYtL0cdRZ4f9rHAZK/eYOAp4ebcSbO0
	 QLp5iZbo/wZXrqHl02C6cVwdOQloWkBvb7XCY0F+fj+3k9LD5Idfl+Y+v5gUY25exv
	 da3EIl/vh3uiyehtM+yai0S5BvGy2QVxw4rN2qF3E/5E/WrUTyavMLpjcFD9O2fyI/
	 15XbNAibghTsCgAdVxawsWKBKExnM+DCHi7yeXY9GULs1tzeZzFfgkPe4CHMTIpcPz
	 5eO5qobFrurldeox0u3XFWbP7OBri/9/CI/PrPAYHsWG5+FnrdD2vUMdJ0HLpznbbb
	 TTVghhTsk61FQ==
Date: Wed, 14 Feb 2024 13:55:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AXBKRWmsqPkKDAl1"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
X-Cookie: Available while quantities last.


--AXBKRWmsqPkKDAl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:43:48PM +0100, Jiri Kosina wrote:
> On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:

> > +No CVEs will be automatically assigned for unfixed security issues in
> > +the Linux kernel; assignment will only automatically happen after a fix
> > +is available and applied to a stable kernel tree, and it will be track=
ed
> > +that way by the git commit id of the original fix.=20

> I think this needs way more clarification .. how exactly is this going to=
=20
> work?

> Do I read this correctly that *everything* that lands in -stable will=20
> automatically get CVE assigned? If so, that's just plain crazy. Just took=
=20
> a random peek on the topmost -stable changelog ...

> 	ASoC: codecs: wsa883x: fix PA volume control
> 	ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> 	ASoC: codecs: wcd938x: fix headphones volume controls
> 	ASoC: qcom: sc8280xp: limit speaker volumes
> 	drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

> Only the last one can *potentially* be considered a CVE candidate, but=20
> someone would actually have to take a *deep* look. Most likely it'll be a=
=20
> functional issue, but not a security issue by any measures.

Not addressing your point in general but the speaker volume limiting is
security relevant, that change prevents physical damage to the system.
There's an argument for many headphone volume related fixes too since
excessively large volumes can cause substantial distress and potential
injury to users (I can't remember if that fix would be relevant to that
issue).

--AXBKRWmsqPkKDAl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXMxl4ACgkQJNaLcl1U
h9DEfQf+PbkEjGAWySRbxuiEeylTjA9fJBzJfA0chUILiLEswQQrvLToO7+Rpr/Z
nETZcr81xD0Vk+iMcpzXC9HkI/qvyu939uugOetuG21/y+Ap8bw4RZy4AeDD+ewY
aBXkZOS+QK99etoToKRXdYFlsIElBu2q+SiWI67V6maOemBjGXRcNUedT37BNUgw
itl1h6Ep1vO40bYsZ86J9SNir9e4PESUPYsZMLmSAI0SOZmDWBjwGywYo5FsoBCq
JhbDrXYANC15d0JtrF2lZjYeijRC4Y1bHvc9sxRTP2zowzY4uM+5VKa4VF/6U8Zz
Lgh0R1Hth7pczSqoE+HW58TGN/1TKg==
=l7qe
-----END PGP SIGNATURE-----

--AXBKRWmsqPkKDAl1--

