Return-Path: <linux-kernel+bounces-126636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B049893ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8271C20DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE222611;
	Mon,  1 Apr 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="s3Ql90Dc"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F6210E9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972300; cv=none; b=nsDmW+RGDJze+reMHDsRVLeMlUZHI9TKYqUA91ddQuZI+FQEkW6oyk7FW+OjHvSrYbHR/8I1RT58mX7ASj6OKM9QQjrSjVWS7Te2lKe5w0Xd5lxTQsgNMnslD/2mVwM3CQaFW1ZelFY25abZYoyYqCVO8kS97r+yhrmY4Y+LMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972300; c=relaxed/simple;
	bh=NZAv+4m6TodZNu5OgNu/28mcBRJfF4GVRwbS3N5AvCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYZPQORPX4zcpwsOUPTna1LvGZh9girFLEVGQKWvqp3AuRIGybwlMDAxUISKrQDW+7zCg2NdV+62FCZYvT0mvUV+F0OsujihC6ELX5IhGWEpFzv/jcAj2XuIOAYTKSp8s/opbfaWTQg6lkQPVrXJ58o/dadogTOJwHJqmZsps70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=s3Ql90Dc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1711972294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NZAv+4m6TodZNu5OgNu/28mcBRJfF4GVRwbS3N5AvCg=;
	b=s3Ql90Dckf2ZBcTitDY4+x3QXGGeOGc9goXZRyQhXIba52d9wqhLFx5Etq9z0fqfHZumKW
	jv/hXSKMMJ89VaFh4MZvbnFnUaJzQFLCzaiwi9jN9IfjURH1oCgEVdMqF/7g6sVCXsagHK
	io12qluPY9rOLXGZPoxR1/lJ+qkGjfa4bMNLQgaHIANEAsIymJLGUObYXDyCbmhqBJsB1Q
	4Hef4VoAiB+YexeiGTXkFuFqJOnvDOlApJHRmAqb1g1LfAAnEh6ttp+7fPPJ8Lgu8DtXGq
	w4zqHvpIifnSE9twy9ZjXS3vc2tf6Pde0HezWcAtkDDgZ3uo9xMxroyuiERIiA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Ian Rogers <irogers@google.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <ukleinek@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] tools lib symbol: Use -D_FORTIFY_SOURCE=2 for non-debug builds
Date: Mon, 01 Apr 2024 13:51:23 +0200
Message-ID: <3441159.KmgsX75shj@bagend>
Organization: Connecting Knowledge
In-Reply-To: <14858d07-abc2-48f9-329a-6d5a4faceeb9@debian.org>
References:
 <20230424102827.58707-1-ukleinek@debian.org>
 <CAP-5=fUOL0FmtMbLQtRx2-_i6uvbsBLsxaAg54x8umT4npT7iA@mail.gmail.com>
 <14858d07-abc2-48f9-329a-6d5a4faceeb9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17652662.Yfa9ksU45e";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart17652662.Yfa9ksU45e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 01 Apr 2024 13:51:23 +0200
Message-ID: <3441159.KmgsX75shj@bagend>
Organization: Connecting Knowledge
In-Reply-To: <14858d07-abc2-48f9-329a-6d5a4faceeb9@debian.org>
MIME-Version: 1.0

On Sunday, 30 April 2023 11:11:26 CEST Uwe Kleine-K=C3=B6nig wrote:
> On 4/29/23 23:05, Ian Rogers wrote:
> > On Apr 24, 2023 at 3:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@debi=
an.org> wrote:
> >> Commit 160be157eaba ("tool lib symbol: Add Makefile/Build") failed to
> >> define _FORTIFY_SOURCE to 2, probabaly this was cut&pasted from other
> >> Makefiles with the same problem.
> >>=20
> >> Fixes: 160be157eaba ("tool lib symbol: Add Makefile/Build")
> >> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>
> >=20
> > Acked-by: Ian Rogers <irogers@google.com>
>=20
> Thanks
>=20
> > Same problem here I think:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/to
> > ols/lib/api/Makefile#n42
> Indeed, and similar patch here:
>=20
> https://lore.kernel.org/all/20230424102049.58338-1-ukleinek@debian.org/

I noticed this (and the other linked) patch haven't been merged yet.
What's needed to move this forward?
--nextPart17652662.Yfa9ksU45e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZgqfuwAKCRDXblvOeH7b
bq/HAQCNOZXVJYt/wMBo4GE+gHTPMMgCHwu1aobdy1Vwgn8PFAD/Wj/8l7op4JsX
HlDrDO2dNbj1Zo23ECeSGLYS7Eybpgs=
=Jzsg
-----END PGP SIGNATURE-----

--nextPart17652662.Yfa9ksU45e--




