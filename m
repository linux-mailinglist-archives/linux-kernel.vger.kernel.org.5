Return-Path: <linux-kernel+bounces-71937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCE85ACBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6021F23D89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076C524AC;
	Mon, 19 Feb 2024 20:03:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F241C77
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372994; cv=none; b=FR3Z91jo/6VhaSxxeReoai/+HqgL+WYqz2TNwmlCLod2QwV7xsoU+6gRYMQjKgdYI1bmJ5I7gWMwjHyDbgYnP2kOdJtiRYfEG16S9tKc1B5ASHmFRoipNfhFLUn3haDT9tdORv4mNlJeLBq/lR/hhiZCAtrV0RJotyKibawrSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372994; c=relaxed/simple;
	bh=lo4R7EukS8hXVzNzj60xudhkXfSigbb/6jiL+esCxTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw7J3KcSo0I8kHF7m7jxms8lsR4Rp5b52aNiYedZMYpq0h2b4wNFC3ZiFZiYheHVXSsVAUvplKwGa3cVCFQoWgkJZwoAx3kH2MFWZZAA4YAf60vlbBJH06xhKbMy309X/RX5UIQzUZfa19veSOUbOI1clehEtsZbilS7nX1/kNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rc9qp-0008JX-5k; Mon, 19 Feb 2024 21:02:55 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rc9qo-001i2i-4m; Mon, 19 Feb 2024 21:02:54 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rc9qo-00Fysi-0A;
	Mon, 19 Feb 2024 21:02:54 +0100
Date: Mon, 19 Feb 2024 21:02:54 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <ZdOz7mc-NbiEe2Ei@pengutronix.de>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>
 <2024021757-geography-hacksaw-3022@gregkh>
 <ZdKze80oFj0PRkkZ@pengutronix.de>
 <2024021911-facelift-graveyard-0760@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+zGieLIMQqtXbity"
Content-Disposition: inline
In-Reply-To: <2024021911-facelift-graveyard-0760@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--+zGieLIMQqtXbity
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 09:13:03AM +0100, Greg Kroah-Hartman wrote:
>On Mon, Feb 19, 2024 at 02:48:43AM +0100, Michael Grzeschik wrote:
>> On Sat, Feb 17, 2024 at 04:59:28PM +0100, Greg Kroah-Hartman wrote:
>> > On Fri, Feb 02, 2024 at 01:05:12AM +0100, Michael Grzeschik wrote:
>> > > Add the newly introduced 9pfs transport gadget interface with an new
>> > > multi composed gadget together with acm and eem.
>> > >
>> > > When using this legacy module, it is also possible to
>> > > mount the 9PFS usb dir as root filesystem. Just follow the
>> > > instrucitons from Documentation/filesystems/9p.rst
>> >
>> > Why are we adding new "legacy" gadgets?  What's wrong with the "correc=
t"
>> > api instead?  You need a lot of justification here to add something to
>> > an api we want to one day just delete.
>>
>> Without the legacy gadget there is no real solution to mount
>> the 9pfs via the gadget as rootfs. The "correct" api is configfs
>> which will need the user to have some filesystem to mount it to.
>
>That's what your initramfs is for.  Why can't you just use that?

Because out of convenience and to make it just work as simple as
nfsrootfs. With this we now need to maintain an full initramfs,
that has to come from somewhere.

>> There is the relatively new concept of bootconfig which sounds
>> promising to describe an complete configfs tree from system boot.
>
>Great, but until that happens, again, just use initramfs.

Hmm, okay.

>> However this is some future talk for now, so we would like to
>> stick with the legacy setup to be able to mount the 9pfs rootfs.
>
>I'd prefer to NOT add new legacy gadget drivers, and do everything
>possible to delete them all from the tree "soon".

When you mean this "soon" is in the near future, you are probably right
then.

>> > > +/*
>> > > + * Gadget usb9pfs only needs two bulk endpoints, and will use the u=
sb9pfs usb
>> > > + * transport to mount host filesystem via usb gadget. This driver w=
ill
>> > > + * also add one ACM and NCM interface.
>> >
>> > Why "also"?  What are those interfaces going to be used for and what do
>> > they have to do with 9pfs?
>>
>> They are not necessary to be used with 9pfs. But since we introduce an
>> new legacy module which is fully claiming the UDC, it would make sense
>> to leave the other endpoints unavailable but instead add some common
>> interfaces like ecm and acm.
>
>But if no one needs/wants them, why make this complex?  Again, configfs
>can handle the composition of this if you need it, which is why that
>"new" interface was created.


Okay, What about the rest of the series? Can you just skip this patch
then for? Or do you want me to send the series again without this
legacy driver. There are no dependencies to this in that series.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--+zGieLIMQqtXbity
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXTs+oACgkQC+njFXoe
LGRwLA/+LrNLPbGGYFlAzMGpno4wxMgOLzvDHPdnuBGsFQ0aAzm7SWtjv92xdbJs
iv+j4zQNjpshdqmWXLtwGO6thupVI5zT7A1Upqt3K5SVe0LGnwlfeqYWqa9aHIwS
uwmiBXMR6DtPutwduaFHCJeEMC9j1+MtSe2M6UxMDzQaXujOtQ4K9yHU6/XOyn/H
1L+7IHrW2z40WvbtfHRxjAiySUaoIkHyn1x0q7ui4QD/UTssbrg+2smB0uMtHxZX
bWNyrFbh0iTEeCXPVfd5LcVUSPCFcqtqag8dOwGPqevmCTkOSFiL4RhS4pZKrCrh
kFOdfPW5tfh+dLvfIV5RkMqzKKvlg1wh2mzqh5gyGiJsQsipurTAvo5cnJFujbRc
Gy5wztK56jnnXehPyVDGYmxt4ORJf51PHBi5+adp975RRP2yPq82nSDMAoEN6hkh
IcS9po3h5N59UuA38WcPO1qCBg00QYnJJto0S9nyYicrVwzZnvz6/HScdfVKv+U1
YQ0ChpBj5ijfelb3HHb5jchLvQ449C+/7iZijn5m4g7zE7Jz5VyYiXmLrGOETisQ
4iW6d156+OH18SaWODWRQQZnioVdEmPSv84SMSxgLawqKfLlkziCi7ozqXZE79pO
ZBvK+LDllbO8mZfAOsQSmLy/LXTrjZNaz1Ew3nW4Kd3bd/Ut1pE=
=n31+
-----END PGP SIGNATURE-----

--+zGieLIMQqtXbity--

