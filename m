Return-Path: <linux-kernel+bounces-165309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD618B8B09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B7CB21E59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725B12DDB8;
	Wed,  1 May 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8XsvbR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F511DFFB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569547; cv=none; b=rslKrbt/yXxlVaGpL+5r/NIm9Plrg5iSNRlAvT5apC31ED5S//ji8sVK8aPLGQ501ZFw3JveXsanpQXAPIyKxuFzDjcipiRupdGRsYB7qV1SqDtOi4UbEZVtf6VzhA/rpIIM9JnpvPL5eFu42G09kzWwEsjbp8tci8KPWoxgjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569547; c=relaxed/simple;
	bh=AVhnqdGhscmydW3auczmGVEvQdtUwgBxwqKgut16GIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY2z1R4/gdOvhq0Y0psSxWCor//4rSfE6m22KSTYwhrXPCHGMZtsajyXwQc95Z3o2Q8ixmraGAoiVlTFc/ErJTVuZhTwXPuS4FQIC5CpzNTcAxrvQBo2/BqL9fvmsNWeA89MjTXgsK3dwwO2jA7wdXcWwW9LM81BKHGMF8EisZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8XsvbR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B34C113CC;
	Wed,  1 May 2024 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714569546;
	bh=AVhnqdGhscmydW3auczmGVEvQdtUwgBxwqKgut16GIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8XsvbR9imLaKErl7qDzfdcFLQVBCuda+cFlN44UJfUh38Q7yGend8PCrJO/Nw1AV
	 ueWG9WN7Wn7P1c1o36pLnmLcivaBESyfZakP0xk/iFCJ6r83naBmIz0+WO3lyNhsOx
	 tlmTrRPSAee+zxPENUCyNrzQeFcv7B3ybdVg5w72mPHncbGIMcwTKR7i4kHa6Za5Q4
	 IyDD9KOFMN8pcbfxYSkLHmOqjZavazrZl7RpnP5s5C4C+3cTkF3iRXz3ilJldtwxUp
	 EvlFKRvnO208q8twdv8qXpdFGvISdEpcA1NzPmgDQ0MVIlz+Ti6ii3lraQD/yfwuj9
	 TN8cMGlDTqSMw==
Date: Wed, 1 May 2024 14:19:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: sudeep.holla@arm.com, gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2 v3] drivers: introduce automatic cleanup feature
Message-ID: <20240501-ensure-detective-f1c7442d383a@spud>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tZOHu1rnc+PeBHs5"
Content-Disposition: inline
In-Reply-To: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>


--tZOHu1rnc+PeBHs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 11:43:11AM +0200, Vincenzo Mezzela wrote:
> This patch series introduces the automatic cleanup feature using the __fr=
ee
> attribute. With this modification, resources allocated with __free are=20
> automatically released at the end of the scope.

FWIW, I did run this on a system that uses the generic topology code.
Nothing blew up, and the topology seemed to be reported correctly still. I
won't give you any hints as to how since Greg wants you to figure it out
for yourself ;)

b4 handles it fine, but usually new revisions of patchsets are not sent
as replies to earlier ones, so that might be something to change if you
resend to fix the subject lines.

Cheers,
Conor.


--tZOHu1rnc+PeBHs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJBQwAKCRB4tDGHoIJi
0qRFAQDKXTuLUDDOGjyqORybsJM8g+8f8Q2Fe36+7IduwYwvMgEA07DbTTz7yNc8
Idjfh+3LBkZ+0zYl8pTzgbsdzv/jwAQ=
=Ism/
-----END PGP SIGNATURE-----

--tZOHu1rnc+PeBHs5--

