Return-Path: <linux-kernel+bounces-152654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EB8AC21F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73F1C20ADD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097CD46433;
	Sun, 21 Apr 2024 23:25:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF73CF40
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741946; cv=none; b=BtNxhDGDqFm2FYe5PRsaDAnkzwrx3tjxE9yLlIaV5XYgbVpiIeBA2vkUCCA6QCVBF6quSII08wAoycPo3bVezdJYdKZnEzLrT1t9a+EzZFyLcA84a032KEKKDtisGGUQUnCkVBfBAManA6iECOvW/1DIC3hxLq7nD3GGHl7GUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741946; c=relaxed/simple;
	bh=g02USyEcC1+iNhTXFa90KVmi/4EzyCN+DpO7X/RqC/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SFAd9VR8uudEjMlOLhkc8PdpIVEdGOOwpNxKUfvKkXbJj+bULb1w+Jp2KJWWMULuVqiWDOsJ1/cr5xuQGALjr/GYAISLg+X0ykGqeylkeK9rRB5KG8LB2qK5Op07pbzLVxZ3k6RGzDxfxxJ1dtFLw9JlTewEZgGY2+wqtYXAkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rygYt-0006Ce-W7; Mon, 22 Apr 2024 01:25:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rygYt-00DaWd-Dk; Mon, 22 Apr 2024 01:25:31 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rygYt-006Yvm-0y;
	Mon, 22 Apr 2024 01:25:31 +0200
Date: Mon, 22 Apr 2024 01:25:31 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>,
	Jayant Chowdhary <jchowdhary@google.com>, etalvala@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <ZiWga5Kqno1ICv97@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RVp748n/zLiKJVp9"
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--RVp748n/zLiKJVp9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrote:
>This patch series is improving the size calculation and allocation
>of the uvc requests. Using the currenlty setup frame duration of the
>stream it is possible to calculate the number of requests based on the
>interval length.

The basic concept here is right. But unfortunatly we found out that
together with Patch [1] and the current zero length request pump
mechanism [2] and [3] this is not working as expected.

The conclusion that we can not queue more than one frame at once into
the hw led to [1]. The current implementation of zero length reqeusts
which will be queued while we are waiting for the frame to finish
transferring will enlarge the frame duration. Since every zero-length
request is still taking up at least one frame interval of 125 us.

This longer frameduration of each enqueued will therefor decrease the
absolut framerate.

Therefor to properly make those patches work, we will have to get rid of
the zero length pump mechanism again and make sure that the whole
business logic of what to be queued and when will only be done in the
pump worker. It is possible to let the dwc3 udc run dry, as we are
actively waiting for the frame to finish, the last request in the
prepared and started list will stop the current dwc3 stream and therfor
no underruns will occur with the next ep_queue.

Also keeping the prepared list and doing the preparation in any case
of the pump worker is still a good point we need to keep.

With all these pending patches the whole uvc saga of underruns and
flickering videostreams should come to an end=E2=84=A2.

I already started with this but would be happy to see Avichal and others
to review the patches when they are ready in my eyes.

mgr

[1] https://lore.kernel.org/all/20240324-uvc-gadget-errorcheck-v1-1-5538c57=
bbeba@pengutronix.de/
[2] https://lore.kernel.org/all/99384044-0d14-4ebe-9109-8a5557e64449@google=
=2Ecom/
[3] https://lore.kernel.org/all/20230508231103.1621375-1-arakesh@google.com/

>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>---
>Michael Grzeschik (3):
>      usb: gadget: function: uvc: set req_size once when the vb2 queue is =
calculated
>      usb: gadget: uvc: add g_parm and s_parm for frame interval
>      usb: gadget: uvc: set req_size and n_requests based on the frame int=
erval
>
> drivers/usb/gadget/function/uvc.h       |  1 +
> drivers/usb/gadget/function/uvc_queue.c | 30 ++++++++++++++-----
> drivers/usb/gadget/function/uvc_v4l2.c  | 52 ++++++++++++++++++++++++++++=
+++++
> drivers/usb/gadget/function/uvc_video.c | 17 ++---------
> 4 files changed, 79 insertions(+), 21 deletions(-)
>---
>base-commit: 3295f1b866bfbcabd625511968e8a5c541f9ab32
>change-id: 20240403-uvc_request_length_by_interval-a7efd587d963
>
>Best regards,
>--=20
>Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--RVp748n/zLiKJVp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmYloGYACgkQC+njFXoe
LGTcgxAAzcVaC4p7RcAcVHQyo4iW2vQUTr028TAv07eisV9cgjCvfsPzIYBQiUAU
7ghV3IrtYczqqtH9HkeFFfq250TuhpeFQ29P2dgcCeynyfm5hQIvoM8UGtBjP+Eo
YkmR+3HCHgRJE3ruRnmv++EHrrdEEQ+gAptncb5HOOZvCUrtqoNTYb2Tc2ybkOgn
uVp9wP2Q6kTH1TxgYvqowksRhUF99v+fD9zU1wvU/uvervcsEi7CaIX+1GWnWI91
sx92A9/QvW4eutFoOIhETJupdokrHjT1xOye3CT73Q8fOPYH4GJrQe/g6xDoUE/K
eiTzu6ULp8Gm/7/pCCmpSAHKRUjokGqAx/c3KwwZTlkbVvqkNYHq6LRWxfGGXBJB
dZwKGnHTFnMdV/j3QecElyX8rmrN9RPBGa9q4Kdm3gW9xE0PoPG9TgZF59P0qWAX
fpjXsq29g0VhX0VBH1MoQ+miNQFb9219s5yjXa4OKJP+/ay6izOVd0jBZaK9bjt+
gBgj11zrryeMrBTdeBZLdtAftYuTClEN4eCc+bCgg6ql389rwOQT7EB8HiFbSPzN
zwCd01GrENwaZ/VeKqR80wzSSgc2xsm8Uyus1msAoCXGUFBl1P0pw31Pkqi8k6g4
MBuIqlaW9nnb0mJHM18V2HkJCtA6Z29KrVCSjODIoxSHO/mKlww=
=najE
-----END PGP SIGNATURE-----

--RVp748n/zLiKJVp9--

