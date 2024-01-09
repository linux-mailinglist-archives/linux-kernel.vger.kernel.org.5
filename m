Return-Path: <linux-kernel+bounces-20705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D388283CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37957B23BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B759364DB;
	Tue,  9 Jan 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="OcYdcY4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6RJT0bNe"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19041364D0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id D30393200A6D;
	Tue,  9 Jan 2024 05:15:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 09 Jan 2024 05:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704795312; x=1704881712; bh=jiFgbsRxbL
	2i/YExxo4L0AnzxDWdv2RQgtBIi3ZydVc=; b=OcYdcY4Pn4pDs10N555cxwsrB5
	7MYlDy4snSnfMqtvvXMpvLCQow0e9nSkV3TdOV7nG1YHetTbGvZXSe/5K1kl0Of6
	FqnEQgxdgt/shl8hQ+6pfJBXKqHpFxHp0XnU3MxJ0sB0MgVPJjGf9bbbHF5wLypE
	Jz8OPv7qUF7BPzy2a02S7DvAHX9ivuD6KX78Q0jPQ40vI82SZoXmhN2/zvj3DfZ2
	9TSqT6v3dzosVpa2s6iwZ7hRh/Dr9D8VEOI3CTl/2umpLmxL2DC9+IJoMCNjb+I0
	t9HnyU0K+LtYfcCocWGz4Sie6cvRNvD7SpJ/fqWChVIpQu4EI6l5JOd2Kv8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704795312; x=1704881712; bh=jiFgbsRxbL2i/YExxo4L0AnzxDWd
	v2RQgtBIi3ZydVc=; b=6RJT0bNeR58ALZuQeTvdJa043vM7vKYalVIuOF7Incqz
	8bf8lB0cKTBzE8K/b1P9tekPJFBiMShwLcc2ax2CNVP95ZFtc1xnUaNzyoiwu3B4
	WJUMrS4fO3c1BEXBA31O798K8iErmZ8NfB9jX+cQHVfVzDkJa6qYJoJY5Ng0Si51
	hWdf1rGYOwwoIrXHXhgE5kk5oO7QqRuOTRCIX+QmCz7FkO8tpPt9oMU6xFcpKJyv
	kjY+V2A5V2vEdnG/mpcnaThmSPmE7QcSVM6IApMj+0SY18TL2g8tUkr3xNhDX88J
	uWaCHOENoNa/fQGmG2t6Vundx+sOKhWebgXMHvMR+g==
X-ME-Sender: <xms:sBydZUYhrFaf-tRPOAGFZrY4QBHYraCElijOTokxQNY0ZHsuH5Nafw>
    <xme:sBydZfYqrTUYjF7PmoJyI-oMZ0B5dlAwRBaibpkK5870EuYuR6PKU1Rqpm4k7VTX-
    gDpO9lv_zLUd8kBmiI>
X-ME-Received: <xmr:sBydZe-mfFVb1-zbj2HOZHRKKE6hSiXC2WpCZG9vwMp6Y9hmtoo9MmCQWH6IXiM_wHyPD-XO3D-UdjatCC9nXkHpJWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeileehheehtdeiveduffdugfdtgfevjeffudfgtefgteff
    udfhhffftedvieeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:sBydZeo5Rc8CWryXx69Q0FneWpq85ePxLSujGxCsnD9H53YMf_zpAQ>
    <xmx:sBydZfqoff7IHgzpbFYlii23-NiAT_70Bjvo68_Hxq_rJT2jgFdSdw>
    <xmx:sBydZcQqsFSdvdpH_dpBG_62x6xXy8YXfW325pPN2myIGArvGocenA>
    <xmx:sBydZW0bE0lKyJZLeC7Cgy_3CeAuWUmPt60xcEbRp5mtL39Rkm-EGA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 05:15:11 -0500 (EST)
References: <20240109033234.570-1-garyrookard@fastmail.org>
 <2024010919-wand-footgear-80cb@gregkh>
User-agent: mu4e 1.10.8; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8192e: rename variable cur_bw_40mhz
Date: Tue, 09 Jan 2024 05:11:31 -0500
In-reply-to: <2024010919-wand-footgear-80cb@gregkh>
Message-ID: <87o7durexp.fsf@fastmail.org>
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

> On Mon, Jan 08, 2024 at 10:32:34PM -0500, Gary Rookard wrote:
>> Changes from v3 include
>> Rename from  millihertz(mhz) Megahertz(MHz)
>> cur_bw_40mhz -> cur_bw_40MHz
>
> This belongs below the --- line, not above it, right?
>
> thanks,
>
> greg k-h
=2D-
Yes, of course.
I'll fix it up and resubmit

Regards,
Gary

=2D-=20
Sent with my mu4e on Void GNU/Linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEE1kC7bOvmQRqDVDSVKPZpkA66T0EFAmWdHKIZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRAo9mmQDrpPQSsTEACNZupylAULNygyC7byjNze
Qa4uJTcz2uo/m4FHbwCmPThmPE9aYd90Qv05HVCT1jMShkOkg6GqfaAOmqWDdrfW
iMoWSPvXFgECzGDgbqQZq4smjifq28mAmOYG8Yje4vZIEz7LXz9ciuWDSgW2Gox0
OT9UDbpzjJv4OZMWrOFK/ah9FzFwjScNvGPrX2kBBCMc4iM4seiIHle2HPEFMwJZ
PIbZ6am24TJgKY3URvbgbfdqKXSnP/j0rFSUsyoYCs/Cd0FYlGpXVEaZ7O8D11kO
/H6luMClIQ11+nf+unFFnezKTGu39srs/Ol7KADMVciXz4SPw1piExiE4UWDGj02
pLCmlu7SanvJtqxyN/1pqe81V8QQ0/nxQE/Eiue5yzpOGYlNgfYHFZEBM0qCsVuf
j9Fi9bvO0011nnuqSmw1b+Q/wmlfLHMuMBa+hMi6pDMYahQnsnZULrrW4XXvAgFl
XtIBars0Xcvou8G7iCA+b6w32DtMOVdC7dvizO7AejE+oIOJpjUMNmWDZqFAuCpx
qb3gOPTrnJw8XWS0UT/AU2QUc+fEe0nUCP977AbC5NeU926fp3+oT0yxVKOZ+UHB
WVacVlsKsY9yAgeSQBkhiUVG2FJSO/iNSG0/jdeyc0qasG08un1p8uNwg0oWMZyE
JCQcdqTCzzk9Q8GTjtvZeA==
=yOPM
-----END PGP SIGNATURE-----
--=-=-=--

