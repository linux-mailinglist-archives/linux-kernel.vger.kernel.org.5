Return-Path: <linux-kernel+bounces-2196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F10815935
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6844C1C215A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1D21A1A;
	Sat, 16 Dec 2023 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="bA5S7iFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwaekLBn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B614005
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C99FC5C019C;
	Sat, 16 Dec 2023 08:13:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 16 Dec 2023 08:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702732429; x=1702818829; bh=osWc8dUfiu
	/MCg0dFVlze2I71DWiWnRQfX2ssce+IqM=; b=bA5S7iFPR8aVQ9NCptRFm+aarj
	xpzBYliOXizevajfq0mgize4UGkkXL50rk3AcI2uwZZVrAhOgQtaQp3QSo6AcXiY
	ymZJpqcmKrOKX/dSMipUhYCqnoj7Z7DJmPUe+ovxBgNHttpaqh6aI50z9oWoCNTO
	e8t/D3AlW3zlnGJigbiOfo3TXTqxI5yVFxa77FUtlWatGB7o+wHUbujhbPVj2wFw
	VREJhle2uXup/8LAOXDKjeH3IKfJhJrfKHayJ42w4XGoXEVMMcaKpn1TSX8SNlQP
	FwUlnYC12LfcARatxsnVgz0YQVazFRy2g7MwlhO3D2NVWlpVMfe5GqDOzj0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702732429; x=1702818829; bh=osWc8dUfiu/MCg0dFVlze2I71DWi
	WnRQfX2ssce+IqM=; b=VwaekLBnw3CQglk6CdpRczkBYf6JbNRNeXIyCQvDwmnW
	OGGKiYbi11Vm6sbJ9xYHsbf3ZVsOUKNnCrMOF5KG25PqQMxV2HzLEFY5JJr1FR6e
	yJNGXe/Rmwmofm8oSvZ8H2r+R4eyBs+ckbErkHDpHEVIXlQ53Y34T/FUVTFWLOLM
	BMZp61gU+DkYWFHNK7H95dc3qTihZX6u+i55UboCHy7PkptKWVgBtUTgQhiYyiSg
	i4vLs3OEBNYrutQBTv30ypZGUe42gbh+eqHAZaELAE55W9TNqaQQfNxbJ4rKeFCy
	e2TEh3ql8+JKbD9+VWwsDvxE8n3bNBi3+p9Aco+OSQ==
X-ME-Sender: <xms:jaJ9Zcvz-7OzWqIycpsrki4AEzihphJSTg2gjrncCNvNMLwtg2YUsg>
    <xme:jaJ9ZZdLaRBCxbbJKtNScmZVBFKcncHlta-YEScLo2q5ME_6L35fs0VnhZY-9kRb-
    _eBXLK9W3PGXc3OMkE>
X-ME-Received: <xmr:jaJ9ZXwxUy8g9ldvrRJrf4Va45MNCDmQixHirdJ8u5OHU4Nl0-C0Zr6GqUhVgQJ4qCL7MlhYF1WXOUS0tgqx236037C1f3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeileehheehtdeiveduffdugfdtgfevjeffudfgtefgteff
    udfhhffftedvieeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:jaJ9ZfPlFFCVOSg2A4uSvwwa8sod_HdvQxW8DTNFaZG9UWREAgjZ7A>
    <xmx:jaJ9Zc_-xdFNkCa4UyuzLBynHr85F8ekKnl44b9Dby8rEf6L3GyPJA>
    <xmx:jaJ9ZXUU9h0yoKcZHYsa38gjYWnw8cwHcqUJk62nLlN5z4EOr041Hg>
    <xmx:jaJ9ZeJ2fiXsx3mh-5aIP6XD3M-qkjeI2AzmOqL5pGihiEqTqHyKsQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 08:13:49 -0500 (EST)
References: <20231216010105.9810-1-garyrookard@fastmail.org>
 <2023121627-armless-value-6fd7@gregkh>
User-agent: mu4e 1.10.6; emacs 29.1
From: Gary Rookard <garyrookard@fastmail.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] [Series 4] staging: rtl8192e: rename variable
 pHT and (3) other
Date: Sat, 16 Dec 2023 08:09:50 -0500
In-reply-to: <2023121627-armless-value-6fd7@gregkh>
Message-ID: <87fs02l26z.fsf@fastmail.org>
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

> On Fri, Dec 15, 2023 at 08:01:01PM -0500, Gary Rookard wrote:
>> Hi,
>>=20
>> This patch series renames (4) different variables with
>> the checkpatch coding style issue, Avoid CamelCase.
>>=20
>> (resubmittals)
>
> I see two different copies of this patch set, please send only one as
> now I don't know which one is "real".
>
> Please fix up and send a v3, I've dropped both from my queue.
>
> thanks,
>
> greg k-h

=2D-
Sorry for that, I've resent a v3 however 2 got stuck
together resulting in an extra cover letter...

Regards,
Gary

=2D-=20
Sent with my mu4e on Gentoo GNU/linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEjsrWb+cZk1AuzV9C2li+Bks2LgAFAmV9oqQZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDaWL4GSzYuAGOhEAC2XJt6yG3DlHQ2YZBwwgT6
H1TO12P2grVSelHlfrCNgKgsyk7EPUWm9ak2/xqR/q8MkFLx2YzYg48pTsH+olmL
3Sv1hs5sRY8xUbrnT1sKkuDQi8v2NKcvL67J/5zCbJeIQMCsjYOJAAQu0eBMbyeI
RbdQftxIeNADiTZIQJXuTEmcdV6pP52lYtDI9a50Mq60kf1rlLmH3j2X80JGw2i7
RCl4WTAuRxrMpRuGZYAGVttwgIGrMhuV9P6cyU5n7gNrYB0Lvj0aAEVNOlOTDcoD
TKsuZvclo+DJSnfGBN1q3o3g/WGC7fJRDRRvHH7FIigxOO5xyGBef6N67P0qtKZS
peLqhoK6LO8f+IuTyWeL8UOS+WGOMIi82Nokxp3tzIhGGlAnwSrJPGI7kf8/0GFR
s5X4Cih6l0Mp1WJDh71AZ9PBG8oEQb62+lnyhZEaxCNAiHKNUMUrO3dAc4RSf5d1
OgA4fJw/3eTRc3n9JHrkWPXhvZHmVIZtAanatB1wvCAW5SD8X17XwakRQ7ZXu6s8
EPq+W089I90JpotwRV/zKag19hE7Z798sLnVfNq8/u5VSCUE8Yv/zW2ZYmHqyxIk
187zfWxlyDyw3/Fj+XF7t7sDR3YJtYfOkXxJSwoWaXx3wprHs+7y/SbgUTX1JIOz
zmLtfnYAxvmuH9VnrFta6w==
=4atS
-----END PGP SIGNATURE-----
--=-=-=--

