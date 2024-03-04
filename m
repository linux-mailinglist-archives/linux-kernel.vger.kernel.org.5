Return-Path: <linux-kernel+bounces-91386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74950871086
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238D1F20B59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68B7C0B5;
	Mon,  4 Mar 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="YRRi/b/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jc+dfT6T"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA37C088;
	Mon,  4 Mar 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593092; cv=none; b=sGsnysHbRzNQjI2rNUi3Jx3v6xIFYU2iBrfaoyiJ9cqLtjOiq5y6zAO/mUdQkLnEWvnTgsYEzM9xVnpxQ5fH1t7W+ZJV1tto7JLHu8/8W6vS7pWUH2qwH33AZY3CeIDZkPJbpBiGjEXt5uVmL+TlOBgWH2fRjaf7ueygTHYbI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593092; c=relaxed/simple;
	bh=KOD4C83w2+dww3yOnJs5mJRxzc8AwkYUy6x4gdoxQZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz5vMQUCf7t0sVtdCZ44bM+2weiFyYTK6unzKYCzCf4CDNlZFvd6r9aRHff74jY3K7ENGjU/3trArpAg6e0wzwFa6ZJOvvb6EzeCF26+qTUEOxIfvcUUqZlTOGEeblp2lZGB98BHcLBh8eygNvhe2HfHPFPPcTvutkdAjPn0tWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=YRRi/b/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jc+dfT6T; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C2EEC5C007F;
	Mon,  4 Mar 2024 17:58:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 17:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709593089;
	 x=1709679489; bh=TG8pyywQ8nLMoE+dLkiL//MwC3A6zrbPd2r/WzUzL+k=; b=
	YRRi/b/FqL1bk1CJ6Wp4/5ZDeIplQvrmGp7J7wSJHgnhOm3e8TIm7vxYMZ4t2IMD
	py0Fw3CisywOpamGmgr69F9TBxhgfUyXWEwcEUWzz2xz890FMe42hwcTF2zxjX3f
	yAWn5mRhxy5myt1HM5lh++Y7PPAs+3jQijs3nY4RH5bLg43Ry9Uq3ankOkFwbwOg
	WS8soV/yJaFgPGeKkFR1eueW0lyjWmB+gRWoMy7er4b+KCpcjlLLDm63fYrZlq5c
	t3ZvQsTFpoFFsHtXq5zhY8PZ1ccJeb1zOg5+S5uqPCMvOSUwN9X3fSQhhF+d383i
	gwSqO72z6xvtG7AFp8da4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709593089; x=1709679489; bh=TG8pyywQ8nLMoE+dLkiL//MwC3A6
	zrbPd2r/WzUzL+k=; b=jc+dfT6Tl3Jv57IZVMYzauUvjcJF/4+nvAEAbIJ2ge5f
	kPmdCuECVq+gt1YCKtm0HqSjm5ZXkDJ8F+JXvztyAkGjfqx4S0yPe1gJHlGuYBva
	Ai6L7XY2s2Vuk/roNzLKm1Isudh9wcPu+OnREhrawRYU4BXi5xt4983qJkRjR8d2
	I8Xc68kud0wP+qVuaVGCfeeVa4xJ0AVVQZVquWcnBLjegphMUjWciYkjwoqQZsCe
	OUX7CX5LHmqgERY/UCkfwiSYNPer9TcDf8AS1g1xc3IYeqxiSy0ksFsqkjQNisN5
	+EAR6bFjGni2NjDREZ2RS7dA5lGoftzarsTIgMRjmw==
X-ME-Sender: <xms:AVLmZax74QjEz-xMHdDdTulAfFGf0iwwpO39YAFRTbh7OqUKPectcQ>
    <xme:AVLmZWRMpM-UMqyqBPNCKS2qhDhnfamt40vOanI24jk-NdJuaFQiDxyOCL3CPjqDT
    fkCJwgUFD_C3s0>
X-ME-Received: <xmr:AVLmZcW2JiGQm_maZvYadXjO3V8q6SH7AhA2PjoUiVnf2mO1llrumh0-GF5KKSzWKo3h5GgY8a8O4XCHK2BIfvQBrnI9UwRL_Y7NcPgtT3G2aANE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffejgeej
    geffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:AVLmZQg8MH4rCt-qCLpWbebYEkafk0kFObiJ5lrfCXsk6iN-kq1iOQ>
    <xmx:AVLmZcCDHJRlvkqZHZaQ5AAOCizhkcsplGPrCmUjTi8Jvn9S4IdWsw>
    <xmx:AVLmZRI1aSSazvytphgOtPGdOeGDZQcWGzmyscaOT-4UIQ1hR4Abdw>
    <xmx:AVLmZfNIDNVGqt_4Vz7xsoliEq_ZhaR9nEREQzl_-CuKteN-EV5idQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:58:09 -0500 (EST)
Date: Mon, 4 Mar 2024 17:58:05 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeZSADZlMGKs3mrz@itl-email>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilsjY3LIWibyEmY7"
Content-Disposition: inline
In-Reply-To: <2024030406-kilogram-raving-33c5@gregkh>


--ilsjY3LIWibyEmY7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 17:58:05 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Mon, Mar 04, 2024 at 09:04:00PM +0000, Greg Kroah-Hartman wrote:
> On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> > Qubes OS users are reporting that MTP doesn't work with USB passthrough.
> > Fastboot (used for flashing a custom OS to an Android device) also
> > doesn't work.  Kernel-mode drivers, such as Bluetooth and USB storage,
> > seem to usually work as expected.  Since MTP and fastboot are both
> > implemented in userspace, it appears that there is some problem with the
> > interaction of usbip, our USB proxy (which is based on USBIP), and
> > userspace programs that interact with USB devices directly.
> >=20
> > The bug report can be found at [1] and the source code for the USB proxy
> > can be found at [2].  The script used on the sending side (the one with
> > the physical USB controller) is at [3] and the script used by the
> > receiving side (the one the device is attached to) is at [4].  All of
> > these links are for the current version as of this email being sent, so
> > that anyone looking at this email in the future doesn't get confused.
> >=20
> > Is this a bug in usbip, or is this due to usbip being used incorrectly?
>=20
> I'm amazed that usbip works with usbfs at all, I didn't think that was a
> thing.

If it isn't a thing, then how would one go about making it be a thing?
usbfs not supporting usbip would certainly explain the behavior we are
seeing, but this also means that usbip is not a complete solution for
our use-case.  I had assumed that usbip simply created a new USB device
that was just as functional as any device implemented in hardware.

> If you have a reproducer, or some error messages somewhere, that might
> be the easiest way forward.

Multiple users have 100% reliable reproducers, and I believe (but am not
certain) that Marek can reproduce this problem too.  Writing a
reproducer that doesn't involve Qubes OS or any USB peripherals would be
quite a bit harder, mostly because I can't think of any way to run into
this bug without either having least two machines (either physical or
virtual) or using usbip from a machine to itself (which would be rather
strange and might throw things off).  It would also be necessary to
somehow emulate the USB device in question.

> In reading the bug report, it looks like
> the "bridge" you all made can't handle the device disconnecting itself
> properly?  But that's just a guess, could be anything.

What is the proper way to deal with disconnections?  It's quite possible
that the shell scripts have a bug somewhere, but I'm not sure what it
is.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ilsjY3LIWibyEmY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmXmUf8ACgkQsoi1X/+c
IsE/2A/9H+G2h93AG01v1CtSfs0PG33pqtVXxaOkYD/6ccY2xyEw30GnX6gUwI7B
3FxdVUdb4GoSqxup+e6ZpRWIjoaBl9vkrWft0mbwP2ImNUGrdBj4E2sZY3q3vL+Z
93YUIusxM45LrSdEzIv0dJGtC4BFTfAcoc9EtZk3LP/Z5qvnDDIqpfeKhnKbKDHs
tV9AkywL0J9ZLRWYACe6yYVw7RvMyqZvAmTcZLaT4XniDt7R0dbrEyBQupND5OZl
sku8xX6MujHPxOGfBB0GuE3E4Oos208LlDN2l8BgnXY+iGY7b3l1MSjYa6RJgxRD
Iy3IxkpvoYfzB3qZGV4RY0bQcVrRBRIPaEiBRpKTVd+JlPccLu+17cRVOeVDSBMU
SpDHr56Op9cOEstYyH0Kfho2ADY8v1H2SX5c5h1uJ6te7NPYKiYkfL+PqbxWsEl6
ehgqUqfGmM9Hk9Hb7R/GAxIvDeOAanDLPf6kJGwa4f8ySxWPFgXutEP02t6k3SKT
MW3oEJex16Cjk2zp4QpCINTgRcJKhGt3HDX4tWJhxllMaCXROrr+tyt/P0eSC06a
raIsvnC1eYaYeZIN/Tk3uXThXF36qWJKO+jQY0neaq5r4QC+QSil2xXJWgjsTcPW
v5Ncczvw8LBrRUoPcn/93WptF4WJDgow2vvHRH6NfXVZHxR9Ns4=
=DPIT
-----END PGP SIGNATURE-----

--ilsjY3LIWibyEmY7--

