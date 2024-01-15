Return-Path: <linux-kernel+bounces-26509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055F82E249
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525A1283ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3601B7E4;
	Mon, 15 Jan 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="s6dkEkB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RI0emmfr"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEA1B298;
	Mon, 15 Jan 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E863C5C0152;
	Mon, 15 Jan 2024 16:44:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Jan 2024 16:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1705355086;
	 x=1705441486; bh=vb32ikTbV8B4PRo6vFNVRXKQ2keG7Fzf7jgqX0XjhAM=; b=
	s6dkEkB4HwhLBAxPKJCvzReQFWAF2T5FV8vTDyR0oqTZCgZKaev8GGy0iwMkZgKa
	OFKRNpAa0QPG+c+Lt44IJy0p+ecYsemt42Ry2Y9u01pAVAe3mkKkI5CHs23A5V08
	+hn8JEVuC/Zes5VhXpBRlb6JiqxzzxBI/LJDfrznRuum/GIYyVYp46MVE08rrqU4
	yWNsI/LpnO6Fw/tdQn30laAgk3p8IqoFrh/n7st8bnWfEkxxIGifAbqW48iXEKqp
	BaHexfBRnGdDMLQryr/RIWG1X6rBN0patSgZEyJc3cUNJu1OTskuuby+IQ+yyQly
	GPdRmH2PVT2VSaRFsYdKgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705355086; x=1705441486; bh=vb32ikTbV8B4PRo6vFNVRXKQ2keG
	7Fzf7jgqX0XjhAM=; b=RI0emmfrv2fKMyS058rhD5vfH07L7khAMDaak6s4utyv
	q7JjhojZhovxRpWhFjqlukC3kj52nTYjy+JnfNVqGZS0zMH/JVlwTIHcED3jsfeL
	KBggXMOLRg52B5Etmwe1Ho3qCfvde8R5krZA8XoTl+eMZnUxLu4hrbmmVNZdNxM3
	eAWuAP1yIQ+NXo4swNx1ugL9YJXPAhb8Y7LbxV6FlxvoWTgneQq+7pUoAM/Q2KJV
	uTaAgvuVC7pZcYAjfOE3LiyjwHt2aA3bQOLIQY1AGr3E422JGGyEcrRGGez/vUjl
	G1Qgg8wgi1Jni8Fy/Dswf8zq1hkj3L6/rPKyexVIEQ==
X-ME-Sender: <xms:TqelZUAOzwlSdTXX3Rx50n5tlEqnvlom_YFoXPJPPIDf1Y8PM1Dfcg>
    <xme:TqelZWit7B4ReXIAcrArwURoRAEEfw1vymzQ48rA0Fb5FrDr1v9RYhccd1VLVCuI6
    JdTWkMAHx664Kw>
X-ME-Received: <xmr:TqelZXmd0dGbCWtydDv8XVa9odAQ_vV7qLFzOH8mKzGBgoPQtPQD9OeN42VrETAy55KPD2zswK7jVTGt8W5W5h6mEQsrMuFZ7nH_DwgNzJ5l_rzl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeuueevleehvedvuedvhfeihfel
    ffdtheeuvdefgfevgeefgfeihfduheevhedtfeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:TqelZawuKgh1rQWQyg5dSN04dB7Vy34V_5TueOWMQz9WmTs3vyM2fA>
    <xmx:TqelZZQruMpt1GEPlpGHVv2CbnX0vooHzdBT1Z06UWnDN4D07xK8ig>
    <xmx:TqelZVYi6Mzdn9PBnHX6ZyNEyIe6GY06FQVUsVVPWpL7W3CQ0_YnfA>
    <xmx:TqelZSIgNqXyxzOi0Q8-yeGKmGAdWfwDMFX33KrHUbwPVcb-ikbmYw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 16:44:46 -0500 (EST)
Date: Mon, 15 Jan 2024 16:44:29 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Martin Wilck <mwilck@suse.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Franck Bui <fbui@suse.com>
Subject: Re: [dm-devel] [PATCH v2 0/4] Diskseq support in device-mapper
Message-ID: <ZaWnTTnCTkElYzQy@itl-email>
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
 <c09985f5efa9f2351f1ca22cbb286eff2b00d3ad.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2sdyWD00hNa60O7L"
Content-Disposition: inline
In-Reply-To: <c09985f5efa9f2351f1ca22cbb286eff2b00d3ad.camel@suse.com>


--2sdyWD00hNa60O7L
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 16:44:29 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Martin Wilck <mwilck@suse.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Franck Bui <fbui@suse.com>
Subject: Re: [dm-devel] [PATCH v2 0/4] Diskseq support in device-mapper

On Mon, Jan 15, 2024 at 06:56:16PM +0100, Martin Wilck wrote:
> On Sat, 2023-06-24 at 19:09 -0400, Demi Marie Obenour wrote:
> > This work aims to allow userspace to create and destroy device-mapper
> > devices in a race-free way.
>=20
> The discussion about this feature seems to have stalled ... will there
> be a v3 of this series any time soon?

I=E2=80=99m still interested in a v3, but it might take a while.  If you are
willing and able to do it first, I recommend that you do so.

> Also, I am wondering what should happen if a device-mapper table is
> changed in a SUSPEND/LOAD/RESUME cycle. Such operations can change the
> content of the device, thus I assume that the diskseq should also
> change. But AFAICS this wasn't part of your patch set.
>=20
> In general, whether the content changes in a reload operation depends
> on the target. The multipath target, for example, reloads frequently
> without changing the content of the dm device. An ever-changing diskseq
> wouldn't make a lot of sense for dm-multipath. But I doubt we want to
> start making distinctions on this level, so I guess that diskseq and
> multipath just won't go well together.

Should this be controlled by userspace?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--2sdyWD00hNa60O7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmWlp0wACgkQsoi1X/+c
IsGsGhAAuE+6qw9jJcY56i383Lhpfzujp4nFd10fd8FLeDywlXNDrj78CGMk+4aL
B0Oh2uiQR7kTjykRlreRUoOWtmKuikCOHKNzsCjmNgw64m5SODsLxv5YZvoA9+Jm
NTHT75vzUqp2jwohs2v2pyPZD5pLmVzRrHywhkRxeR0kUkL/16qX9mqZ+LXYosJH
GVewfh4+QA3ETuZ/z8kb11Iy6aS0ceWvfdeg8Uvb2L9Yf9rRDUvpMCvYHPNCgrYh
cWuiuSMIJVLUq0Khtneyk6mpFCyS1r6Ak3lP7+TIawF7i09N8Ax5woybWzCa5GRX
ZUhD6Alzw/35SvtraVZ1/beRUCvjiM0VhGrogGehcTQrq1o6Ljp8oz5c86JqRBgA
Cv9maN5ShFqtFL1aAy42JxXr1pe+yvfj08MkDnmva177qMxJFsKix2Ww8aNZiKl3
HkNZDiMN2MJWiFI03ZtLTnAbA76s0rAWKzu8tyOCGxAHKv88lrUdzTQXSMEqOvgV
3ey0mfzEmaYNsQ+/5ext0ZIOWpMrp2IreislxJr0MgnZdwt3bh1jfrBkF0R0MuZQ
ux/gVzp4uEOAZBzsu1P04okq+PavziqfWDcLMQMcHSxSZbEagFc0bwhuLGZDp8gs
7Abn8siokY+Ci7c4TmV03/6lDNnQigqPOuqyOpcCMQB4ZB0UWdM=
=6xif
-----END PGP SIGNATURE-----

--2sdyWD00hNa60O7L--

