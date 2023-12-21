Return-Path: <linux-kernel+bounces-8443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A781B73A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112631C21A66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D2745CF;
	Thu, 21 Dec 2023 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="si9zh+Df";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8202oWHk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BD73197
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 742153200344;
	Thu, 21 Dec 2023 08:21:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 08:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703164876; x=1703251276; bh=bV++sLoCKQ
	gJ+lj7w4YvC2Lo6bB5KluwR+HnqfYUAU0=; b=si9zh+DfJ4tYBb9C+jEspGf9Fv
	fhov0F2ZJ+6JdN+tGPdez6GdMkFHyLQq26Q8oLNndlH9jkXrUW2yId5o7jma1nO9
	SYehdx9gUjaVXPRaOJ/KXwFAb1W2Dty1/7MkJTXaItPklvtB8l2jBJ6t2SCCb9Q8
	4I38eWgSE71ykLYH/q4in6R8Uuw3atsN2jy8AW5sH0TiGSJM2XQ1FYRSdgdF/4dx
	vsNe4Fa8YyMSwXQuOyaR3LGXCv3vCdDJxMMWBh8B8EIpyRZPtcLw2OmChRZnKoai
	UV6vq5Kwvit+JJVuwrtOyOBFM5gSe0oH15JdkpNkOROLychsT8D3y6PqQJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703164876; x=1703251276; bh=bV++sLoCKQgJ+lj7w4YvC2Lo6bB5
	KluwR+HnqfYUAU0=; b=8202oWHkWr71DV/9U8BVNu487+QC0S8tQG36HJQG4KkO
	FC6bIDAmZG51GvgfeBmvtGcHM3uH17qE7TYkcJd/qz2ki/BFmh2qbOJWPNK45L3U
	jYY2MmN9w15zwK2SQXpPGKfbRcG+SSQw0MJ9ZJVbhE3+eV74k2WKNy/AmW0JVcMT
	2SWbE6QEBaR5xlcbXHINRZFrAS1rWqxYPdk5sNTiwVBZQkMmsiaYls0HK0uLfdER
	fR7+RTYecvz6018mXS9E1UhwhYBJB2aqegX3v6e2+yZkLmvFoEtDkLCYygA5ZDL7
	l13ms/JDuxX+9KsFqQKdaXRzDA+sgWLrE4UcPGV2KQ==
X-ME-Sender: <xms:zDuEZVijIzhsbSNLWZNiYN2SIgf1jKx5p_WhkrqTKaVyM77ILmI3yQ>
    <xme:zDuEZaC4AxnS7liA8-ZCrcaVu09rkB_RVn_pX8VgxKKDPfedyTPMlIsDwVqwdmq1n
    _rflZ6aBfIJ6Yh6sAA>
X-ME-Received: <xmr:zDuEZVG0VelFcR-uIXvI-B-lZxs5bhWO0EWF9GkwZh4Nkh664_8bXeMJtfg1ZoQydlWPTOlJWrP43P2VgeKpNR5MOkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeileehheehtdeiveduffdugfdtgfevjeffudfgtefgteff
    udfhhffftedvieeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:zDuEZaT4DRejBwF2UKGY5EByogHs_fUHtzuPcwRnW6e8-PNpoC6tbw>
    <xmx:zDuEZSz6yQk7xl1ObS99mnsFe7RgLOtbnmOTbIe7Ievk6XCDm7eYWA>
    <xmx:zDuEZQ6pOevWa3YY6ZXh5RUDb6w_b7_WwP1hDsGjES_Rl6aOirPvXw>
    <xmx:zDuEZd-gke77gAOv1FKjd5TWtk7-QEAFMLY8ceJHMs8_K3RqhtuU9Q>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:21:16 -0500 (EST)
References: <20231221031004.14779-1-garyrookard@fastmail.org>
 <2023122137-account-vitality-9a72@gregkh> <875y0rog7j.fsf@fastmail.org>
 <2023122129-underpay-zit-7ec5@gregkh>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: rename variable
 HTInitializeBssDesc and (4) other
Date: Thu, 21 Dec 2023 08:19:55 -0500
In-reply-to: <2023122129-underpay-zit-7ec5@gregkh>
Message-ID: <871qbfofme.fsf@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Dec 21, 2023 at 08:06:13AM -0500, Gary Rookard wrote:
>>=20
>> Greg KH <gregkh@linuxfoundation.org> writes:
>>=20
>> > On Wed, Dec 20, 2023 at 10:09:59PM -0500, Gary Rookard wrote:
>> >> Hi,
>> >>=20
>> >> This patch series renames (5) different variables with
>> >> the checkpatch coding style issue, Avoid CamelCase.
>> >>=20
>> >> Patch 1/5) rename variable HTInitializeBssDesc
>> >> Patch 2/5) rename variable HTResetSelfAndSavePeerSetting
>> >> Patch 3/5) rename variable HTCCheck
>> >> Patch 4/5) rename variable HTSetConnectBwModeCallback
>> >> Patch 5/5) rename variable ePeerHTSpecVer
>> >>=20
>> >> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>> >>=20
>> >> Gary Rookard (5):
>> >>   staging: rtl8192e: rename variable HTInitializeBssDesc
>> >>   staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
>> >>   staging: rtl8192e: rename variable HTCCheck
>> >>   staging: rtl8192e: rename variable HTSetConnectBwModeCallback
>> >>   staging: rtl8192e: rename variable ePeerHTSpecVer
>> >>=20
>> >>  drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
>> >>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>> >>  drivers/staging/rtl8192e/rtllib.h         |  6 +++---
>> >>  drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
>> >>  drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
>> >>  5 files changed, 18 insertions(+), 18 deletions(-)
>> >
>> > I see 2 different patch series here sent to the list, both seeming to =
do
>> > the same thing?
>> >
>> > confused,
>> >
>> > greg k-h
>>=20
>> Sorry that was caused by an address typo
>> so it got resent to linux-staging..
>> new setup on different distro
>
> Please send a v2 of this then.
>
> thanks,
>
> greg k-h

Okay, will do.

Regards,
Gary
=2D-=20
Sent with my mu4e on Void Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE92Mpdr0+Cqw+uCNR5J46Hep3K4QFAmWEO+kZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDknjod6ncrhDVuD/9kUuCyIxj9T6bnUa1ul7jF
SQAHaWX9DRpxAj6aeFbJ8vvPtdBnh5T4V3E/TZEyp3YG+4vpWlV8VNs/6KgeV0iU
g3hdwi2mt+ZsOUGE842MI6qEkysppiHObclehSIgLz7FqL2W+hBrXOyNqWfmr9Qw
aChhDibeM46SEaX5iYrd64qtY6NS6PMAbm4gBn3V5Ne+vrhuA9jgu63EE90kXZ5V
q9aop2I4IhOGwKtp8lPtdPOVAXgm5WIUAQK7a15yGzUj4T1/kJfy2aK8x2lakG3J
osbv1C88CvkJF08WB+lHG0FwS0HFGFv16XUUeNd3ymXqhhnvkPspTJn8JLY7+/8m
Jg5xOrKV4WGeOOlBDogczZDAwqMTeJZ+MJsnpcZMvnHWtqNb+zkfFpD5XMagkGjB
JLGHIbIoi1qxOSSRYslv5JTLUqFUQ50rZTYf6tGQgId7P6Mg6PBigLjwCscIjtxd
M7GBr0FXssNFR8jhYJQC8v8faK53rwQDWWV902Vc/vUDMtOYfLVxWe2i8h4eeoSH
xndgDiSzvqb0vYJLED/tdL4t52SffnCRs1Oqvtpsda57fhvBn8SMyIw9rGDTf1yk
asSOhdvpxAvG2F5E69qy81NcS+HTn1E5D0UnBPmuZPT4XGTSopsCaMtK1PA7+Vl/
Uifu2Xo4PtcWyBvvxBDt5Q==
=L5Nv
-----END PGP SIGNATURE-----
--=-=-=--

