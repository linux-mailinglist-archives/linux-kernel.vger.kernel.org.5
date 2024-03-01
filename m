Return-Path: <linux-kernel+bounces-88384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF286E0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3C62871EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7126D517;
	Fri,  1 Mar 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHCYASL7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2706BFA2;
	Fri,  1 Mar 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294881; cv=none; b=em/AZMBzvvJSeqWzYhp2FUzTsgEN5c8YUGoocBvTXhPQ/MCIu4PR78bkORZ6t8/G6mn1af76B4XfAK6BEyiuw/KPQO3QevcFTTstq50f7uHU2+0DWt4ywewQ+AXPqGKdZFsEG9HapP0M767HQyInRefvsrb/q006K7bMd5PM0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294881; c=relaxed/simple;
	bh=VA+iVDD2Ca70H9ARB9QVeSue8qcseEowf1MU8vSJ40I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+acEy9Vf3llldZEP4gnV7Kx1RywKS8YbekYMZjjILLyVvqLx0S89waWqAw9bzT+sN0lpzP30dMLetJ1Sk4EBTxV+rCcJkoYvasiPqna/x/y3pa4Q6Ic9t95pMNDRVr7FwOi/HEetMC6BlXjgHhLMgsl+YJx9KJohqL+sgJ3FRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHCYASL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC398C433C7;
	Fri,  1 Mar 2024 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709294880;
	bh=VA+iVDD2Ca70H9ARB9QVeSue8qcseEowf1MU8vSJ40I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHCYASL7KF5D3SEQIKuTF4jGSjm90NfLA9tbYCZMlIjTwzpiWy1sfsTFFBdu/5on2
	 8dGg8CASaBg9klhZ0A+H5N3aKg3d41mZ4TgxLXo/ZEiSsBBCPzHQ7K5OTudl5RQcm9
	 GZVpGG4cl1Y+mT5UB0vxSFlw4pRbfbR21zGD8Zh9d11cTDrd+y/pdFqbvaQDvAAkQH
	 LYm8+avH+GxcPtZFg1bWTXIFBzhzm9U1p4Gv/z5ru34it0onabVTB9h0QrW5aAJTww
	 o3Y2S9q0lF04lrOllk29/7npo668sAr60L66q80MPgAG2D5hq7dWzB291cXwjJJRxk
	 tYiJQxTjOGm3w==
Date: Fri, 1 Mar 2024 12:07:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [broonie-ci:regmap-test-format] [regmap]  af560701e3:
 RIP:__regmap_init
Message-ID: <53c9f248-84d3-4b85-bf25-59055db7eb54@sirena.org.uk>
References: <202402292329.a1c8a83f-lkp@intel.com>
 <2d5fdeda-868d-457f-b462-8d5552a7fe1b@sirena.org.uk>
 <ZeExUW2XjKjuzd5p@xsang-OptiPlex-9020>
 <ZeFLxcfz5PvHutU/@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feeHdGAruMinPZx+"
Content-Disposition: inline
In-Reply-To: <ZeFLxcfz5PvHutU/@xsang-OptiPlex-9020>
X-Cookie: Schizophrenia beats being alone.


--feeHdGAruMinPZx+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 11:30:13AM +0800, Oliver Sang wrote:
> On Fri, Mar 01, 2024 at 09:37:21AM +0800, Oliver Sang wrote:
> > On Thu, Feb 29, 2024 at 03:47:33PM +0000, Mark Brown wrote:
> > > On Thu, Feb 29, 2024 at 11:43:55PM +0800, kernel test robot wrote:

> > and we noticed there is changes in __regmap_init(), we also noticed the=
 issue
> > seems happen before the test even starts to run. not sure if the detail=
 dmesg in

The patch adds a callback but nothing yet provides that callback, it is
very difficult to see how that might be an issue.

> > https://download.01.org/0day-ci/archive/20240229/202402292329.a1c8a83f-=
lkp@intel.com/dmesg.xz
> > could supply more information?

> > if you still think this is a wrong report, or you want us to test any p=
atch,
> > please just let us know. it's always our great pleasure. Thanks!

> we checked this issue more, and found it could be platform specific.
>=20
> we just try a simple boot with af560701e3 on below machine which we made =
origial
> report and reproduced the issue (dmesg is attached).
>=20
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz=
 (Kaby Lake) with 32G memory

My best guess would be that this has somehow managed to trigger a
preexisting issue which happens to manifest on whatever platform you're
running.  I can't from the backtrace alone tell where that might be,
there's not enough information about where regmap_init() is being called
=66rom.

--feeHdGAruMinPZx+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXhxRwACgkQJNaLcl1U
h9CqJAf/fMk4J4sgDE26Fl4b7oT0hlhuY0YFTG2QQJ+wpiowxrzTQ2saQ/3ppXmr
jf43FRhc+TByyFm5qufb8BtAuH7zP8sQIdCxZQY2CkdgwfSUGOjH9m/8zIbMKhnH
cZhoS9HvvJFloGYKYnYfnCr4KeNLDf4iF7HE8YqQTn1741pNd7W0C3g8IBkDXtnq
nYjczD8hIROXntE8MPsSOo8gHGsHB1H+IAnrlVrgJj1+u6t8KKFsRH1MK3n+olkz
7CwZLzAxCe0hboDSv0uHkPMVX/1TZcc5wZ5NnH8NovO8Jqx3a2VFolCLzoTy3byY
bBQOf1l4yJ/biWbbMqA49Y91Yy2M0Q==
=A/0C
-----END PGP SIGNATURE-----

--feeHdGAruMinPZx+--

