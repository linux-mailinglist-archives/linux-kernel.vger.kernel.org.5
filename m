Return-Path: <linux-kernel+bounces-147690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6828A77C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C871C22697
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83484FA7;
	Tue, 16 Apr 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="dzl3c9AJ"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF80C14;
	Tue, 16 Apr 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306572; cv=none; b=X4FO8TgBPVKqSoJo9c4oQWRH01LfAPgBxrVnR2mOUyLzkB8JggpCTM+tDJWd6rG8/R0UXkmuvP0ua9DBrd1Nr+K3MkzRpKaOQO6Xf+vqF1DJEU7eYx6a6tVELYbLmVdW7xTcpnj9rxxYDHf8+T1ED6+qcorAGGcijv8IlZHhNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306572; c=relaxed/simple;
	bh=LYFidti7kQ+3adHtZzCFLp1lsptKVrIjzJ2QN66PGSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9FYYU/EGyQLAZSVv3sRL+LcM+9w6c0BVg18WEfEx+ZNLF5fFJBLqkGqXMpoUh6oBktAg5QJ8gmNBugQkYM1y8u1/BYSZhIUP3Q72xJBEkta/qpzPrwkMZIZrReMgaOG1Ip0xHeTQ/tu54qMr4j71f3RmKk3MoT/xLHZsSEciRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=dzl3c9AJ; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1713306548; x=1713911348; i=christian@heusel.eu;
	bh=6ZuMU0XovAW0umCv+YpdexPnFfz2IsuCOBAjTp3FJ2o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dzl3c9AJZ7GcdIopbTeRuoq56m93I8Yt1xokGjGIWv1YJSsgnfR64QMLSt+6Ak90
	 JGYqy2BB7Wx0eP7aPanOfZVK/ipYjPlCdjHdrNgxwoVUfezV6jghmpIsNYRsSf9s1
	 28lza0Vob4VoH2ahG6heOudRZhLRLBy3XYH7uQhSO+Kq9W/2eM526jguwwDCK+8U/
	 T2DfL7C7AjSYdiSLDA9SrbWRm93AA/W9Wrp9effGG1vhP5tD1kFmsnuZWWcYgEqA5
	 UZmTlkBQFjHr/f6oxVA9gP6ecmTw7D5/bm6oEPoUuhTAS6EuAMyv0iORCG1+Q80t6
	 67f2d3BSLWfwS0aw/g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N63JO-1spaXL3iUS-016L9Z; Wed, 17
 Apr 2024 00:29:07 +0200
Date: Wed, 17 Apr 2024 00:29:06 +0200
From: Christian Heusel <christian@heusel.eu>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <u4tzik2yfdn4eqtb2xc7ssmqsfozjblduu4znwuhlptivcfhza@wkvjsi73dtqt>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5czpi4g6eex7fcrz"
Content-Disposition: inline
In-Reply-To: <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
X-Provags-ID: V03:K1:gmC2JZMi3s3whUDW28Kj0ii/4DWoP1EWJUCNF7CPhIPfhADmGNy
 l1YW7zdala2X7vNZ8m9Jtb4u3L0KIOyFmdY7KyGOkHdxfr0iV9ncw9KjVyL5JYxtOjPuAVi
 0xb4YzLb45wkOe8VAPFE5x7Y1D+dryhGyuuWyPtmG3enOd5uyb/6UV8UcR6oS2Y2YFoaV0V
 su1Si6zeJVIKmD4M0QwGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JTJsWm0H3nw=;IIKW3gMDzvjWMZIDGn60yl7s01D
 I14nwLf8N7tGNLzIdX0A1JO0saZSf9wo0TDOH2ObsXKMmg4ycreuaajIwWD3EXXkFRhC6RY4U
 EA7obFuyu4qd4pfPeT7iN3CZY3KfLTDgljXI1qIWEq3QW8+rRpdaPq1wF4VE2HVp9/BOSX6RK
 3lIMYMZOX2E39ZlA1/PKhGWXvP4STHjigazOraT7B63NHgP005XprzjIa7eJg+iCynj+kdFA7
 dPI9ANlCYVnrZck7iQ9BbxdRuL/t/hiR2qu7FNxmTxmtqhgXcE9zHE3XCfcBmke7Gte+Zx3/Y
 uvrBY1SAviLT1I+ZavRSrEz5rGQqHw6j9D7/ZJStLkMPgcr+7tcIu/rxeT8aNJQ23fenvqAjP
 NWZMoAFjtT2plfoVYiAHJwQnwCXYVJOSclqbYpjCcwc+U5Aux1FuCMbNAOD6j25nlJ0kbXxkf
 BgmD7/r6DbJ4pmVe7jiGEFM+yTNEuo52gZQrH6QY1WJlG33IMHXM8BjGo/yjuxmzT+TJYpE0Y
 +zi4+4o5TcuE7RvFwZKLbBnlvXXEq4+3YnuayOgCJNw/7IsgyVM0IolFGxF6haSwn/UvrCh4I
 j4LX2LpgGqU0tGYxtWX5JNfdx41x/m+S4bh4t6VSj0U66Dju3eBf3WQgGfUUR2C+eAgT/Z2l/
 UNeW/pBx5duKBgR24I2J1dlV3ij+XS6aIYrv/aq1uKynHDCGJQTyw8LeF/W7tz461RQB4QfZr
 0ZK2VV+Xg2G3eZA/Bod807sqdkyosJAup3oqSd10e9wi6nnwjlZTHY=


--5czpi4g6eex7fcrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/04/16 03:14PM, Nhat Pham wrote:
> Is this one of the kernel versions that was broken? That looks a bit
> odd, as zswap shrinker landed on 6.8...

Yes that is the build at commit b5ba474f3f51 ("zswap: shrink zswap pool
based on memory pressure") which is one of the kernel versions that is
broken, although the version string seems a bit confusing. This is due
to the build script invoking "make -s kernelrelease" which gives the
following:

  $ git checkout b5ba474f3f51
  [...]
  $ make -s kernelrelease
  6.7.0-rc4-00158-gb5ba474f3f51

The commit is contained in v6.8+ only as you say, so its just confusing
in the version string:

  $ git tag --contains b5ba474f3f51 | grep -v next
  v6.8
  v6.8-rc1
  v6.8-rc2
  v6.8-rc3
  v6.8-rc4
  v6.8-rc5
  v6.8-rc6
  v6.8-rc7
  v6.9-rc1
  v6.9-rc2
  v6.9-rc3
  v6.9-rc4

Please see my initial report for the detailed bisection results and the
link there to the bisection log.

Cheers and thanks for looking into this!
Christian

--5czpi4g6eex7fcrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmYe+7IACgkQwEfU8yi1
JYWS8RAAgarbioWmeY1qe9WCWZ+xmvQgbhyrqN5NNM2/hlM/Wv1K5bcdpNC0VZM8
YNnmmc8vQuXupu47pMKpMGFwCr6v8ztGgBs2A1kr/8Q4ESTFx0owXrgsgWOqcUsm
PBVg/t8vwpHv1fWKM2Mf3/3tyJorggozCMluDArAsNyz5kFlMcsRVBkfVOVtqASW
OR2kXl7B55YavHMgM7IPfQO0/Dr4/67NzWt2TCJMm1Mi+0GnJAglKt6wQUf4567g
K2NPsuvbuwOGSKoEUQqfGYFadVtTac3RlDQ+4gw0HWR2Hs1/XBpdHOyLsOWhip9g
KomaPpcJr305uXZAzQCediwPzrULHnvAZ+5o8SzNGOSqz3GMo6YaUuRuf5TWE9Wl
Jp8yLkbOdIPDcQ7g+reEfwLXqyc4jMWzoeINImN7BbPcLq/oj8fqQXuVFoF4jajo
/Qpl8U14ZLwsk/6VxwOy0VPRf4wkfC0njZNR19auU4090Q3ZLS9oY3IwzULOH57o
6yrQFUv1Jpjk+lf6cddwiCK0LCdvS3/ugtMv2H1HUdmdeqqQ2mUFPDunW06WuUns
C69ojDexsqdATdr0dmC+7OK7qs+IQUzd6Izi8510CGhE8CzM7DGH3iNcNDU0VL4h
ED27FWmDBlJ0neF5uCSCyuCdPyVKCA+XQ6rQCtFescGuZC9cSTI=
=xoCM
-----END PGP SIGNATURE-----

--5czpi4g6eex7fcrz--

