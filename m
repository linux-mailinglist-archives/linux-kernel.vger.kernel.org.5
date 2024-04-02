Return-Path: <linux-kernel+bounces-127515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B85894CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BB81C216A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451A3CF72;
	Tue,  2 Apr 2024 07:45:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514523B788
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043948; cv=none; b=Epoly+x3P3XSzupbX8ul9btWMxskZP/PE2uAFoQetmdMhoGFldVa5GaVmfRbJ7F+Mvme/g2+tijGI2EpWWekYRkkYbgHCv5Uq6ryhRwZV9HxrOwvAlgMYQTIz3aocy02Yz7qgdhJoY+00TY6lh6Uf3X/I/fzGfNsGDxH/hqMQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043948; c=relaxed/simple;
	bh=02Np2Unu6MKBlZRtrWjjygleS60SrXcYakfvNlObZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDlYHeU71TKZW8oCbxM+3nYFkrVPbBvpgqdroghMH1yuKQ8UsC9MlIkFFGegjiSi1EMPQjwvnemuACJBUvu9o4CwmNnvvwG/jC8QDwQ3OIHareQ51uYY1cH0AertkHpNUHwTaob6+xqbvXjBlfogSRfuehbxj3WI2OgAP2WIlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrYpz-0007gk-Gk; Tue, 02 Apr 2024 09:45:43 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrYpz-009wE5-1g; Tue, 02 Apr 2024 09:45:43 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrYpy-00Ak1T-39;
	Tue, 02 Apr 2024 09:45:42 +0200
Date: Tue, 2 Apr 2024 09:45:42 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Improve error checking and tagging
Message-ID: <Zgu3pkbaQztXxrmc@pengutronix.de>
References: <20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de>
 <2024032622-canine-fragility-39db@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2JtGlwc2haZV7U3k"
Content-Disposition: inline
In-Reply-To: <2024032622-canine-fragility-39db@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--2JtGlwc2haZV7U3k
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:32:48AM +0100, Greg Kroah-Hartman wrote:
>On Mon, Mar 25, 2024 at 12:32:30AM +0100, Michael Grzeschik wrote:
>> Right now after one transfer was completed with EXDEV the currently
>> encoded frame will get the UVC_STREAM_ERR tag attached. Since the
>> complete and encode path are handling separate requests from different
>> threads, there is no direct correspondence between the missed transfer
>> of one request and the currently encoded request which might already
>> belong to an completely different frame.
>>
>> When queueing requests into the hardware by calling ep_queue the
>> underlying ringbuffer of the usb driver will be filled. However when
>> one of these requests will have some issue while transfer the hardware
>> will trigger an interrupt but will continue transferring the pending
>> requests in the ringbuffer. This interrupt-latency will make it
>> impossible to react in time to tag the fully enqueued frame with the
>> UVC_STREAM_ERR in the header.
>>
>> This patch is also addressing this particular issue by delaying the
>> transmit of the EOF/ERR tagged header by waiting for the last enqueued
>> buffer of the frame to be completed. This way it is possible to react to
>> send the EOF/ERR tag depending on the whole frame transfer status.
>>
>> As this is patch is adding latency to the enqueuing path of the frames
>> we make this errorcheck optional by adding an extra module parameter.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> ---
>>  drivers/usb/gadget/function/f_uvc.c     |  4 ++
>>  drivers/usb/gadget/function/uvc.h       |  3 ++
>>  drivers/usb/gadget/function/uvc_video.c | 69 ++++++++++++++++++++++++++=
+++----
>>  3 files changed, 68 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/fu=
nction/f_uvc.c
>> index 929666805bd23..6a7ca8ccaf360 100644
>> --- a/drivers/usb/gadget/function/f_uvc.c
>> +++ b/drivers/usb/gadget/function/f_uvc.c
>> @@ -33,6 +33,10 @@ unsigned int uvc_gadget_trace_param;
>>  module_param_named(trace, uvc_gadget_trace_param, uint, 0644);
>>  MODULE_PARM_DESC(trace, "Trace level bitmask");
>>
>> +bool uvc_gadget_errorcheck_param =3D true;
>> +module_param_named(errorcheck, uvc_gadget_errorcheck_param, bool, 0644);
>> +MODULE_PARM_DESC(errorcheck, "Check and mark errors in the transfer of =
a frame");
>
>I really really really really hate adding new module parameters as they
>do not scale nor work properly for multiple devices and really, it's not
>the 1990's anymore.
>
>Any way to make this debugging thing part of a debugfs interface or
>worst case, a sysfs entry instead?
>
>Or why not just make it a tracing thing instead?
>
>But wait, you are fixing a real issue here, why is it an option at all?
>Shouldn't this always be the case and the driver should always recover
>in this way?  Why would you not want this to be the default and only way
>it operates?

Yes and no. I added the thange to be optional, since it is changing
the amount of frames we will be able to transfer at once. However
I have another set of changes in the queue, that is also taking
the expected size and fps into the account of requst_size and
therefor the real amount of bandwidth. That will indirectly will have
the same result.

So this makes the option obsolete anyway. I will remove it in v2.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2JtGlwc2haZV7U3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmYLt6AACgkQC+njFXoe
LGQDFA//ZEzkUt+XkbeH5Ka2jUMzVXYUzU9ravHwPbjN4Bd588pR8IF8robmvILh
OZxabh6CRTejfuEi5CwO9QwsFvKe9ijdVWUI7e+ddXShJYk9sLB3ti0euEJnGCz3
LB5hM1mVPt7hEiJ545P+Lo4ouO6yQ4ZPQ3+ft8gF6Evvy9F+XQLJtrHjdFr6+cfd
n5bOR/T2W9pTdNUYhCv/W4T2OmD6VNcIukIDdflOyLuwuowcjD4RiPVouLVO9Zei
xKUlcGeET7hEgtZCzuTBo+0w4nBqb3Sun4NviswI0HcgjGhjwKP9tSsHx3nsWqos
FqddhmEcrVvH4ULvqVeaxECcQu/vlSEuUT/44zsq728qBD/7lWa0ihVP4XZIdYjc
GePtRHoKVUytdUAX6ngt/fc4ghv6bPPsIRN7FdeUjiTY2h1TzXaY1Ci6etX3mXMn
Ym42njbPP1UnDFQbnnaun1WF6n03gUzucn14ootLNBJXO43rN0FqoYH0YC9TQxBl
kU0z0mgtritE5FeY9makA18BtfmaSnWsaqRVGp1RqezDsP6V6XuW79BlwEtxONZX
a3GQIPiayR9ltvWN5Glpe9i3XQ94G+7HpnDeeorUh50iEmfNHNRTqs+nBw1PSrKr
ShE5fhujLVdG0u5DpM0Tvb7LqyZZdNIsGVOF/BWqMgk43kaMQXI=
=6ApB
-----END PGP SIGNATURE-----

--2JtGlwc2haZV7U3k--

