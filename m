Return-Path: <linux-kernel+bounces-56522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB684CB32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E31F286C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AD77628;
	Wed,  7 Feb 2024 13:10:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB576C93
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311444; cv=none; b=tGGZ9ykRTfyxu5Fb1WcGwrdWtvYvQ5Bpsu891e079Or9rqjOOK53RtzNTo9qlk5LniMEWF+epHws/s4+jYYVNIK2OsTSRORsYfpuaAXXsUS74r55kkjJyq5ip26p9yim1uLjSmvdKjtFAI2PI1GSz4nreDBGRgTTvDsiI2twdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311444; c=relaxed/simple;
	bh=05nj5KPZ2WXw9KJFv2yudeh0K9L1Lz5OeLTn7As2hrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzIZFDIXpGoNPFiKWuqb3gP7m7kp2XAM3PutCghLk+bMhZpQyv9BhGsVV2/Mz6aMwIbLL7sSL6tAK2I23t6ygXV8kM+P8dsoW/MOc+Npv2Op26etyGwp26zqB9EDTRdRgFPld7rW2FAZIqHNmCN/3koteDO4RD527MGz/zUI2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rXhhF-0004Gq-UE; Wed, 07 Feb 2024 14:10:37 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rXhhE-0051xx-Ur; Wed, 07 Feb 2024 14:10:36 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rXhhE-00FiBu-2o;
	Wed, 07 Feb 2024 14:10:36 +0100
Date: Wed, 7 Feb 2024 14:10:36 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: duplicate requests on host side while streaming via uvcvideo
 gadget
Message-ID: <ZcOBTJlr8UnpXN04@pengutronix.de>
References: <ZcFx7P30Su_Mx4AV@pengutronix.de>
 <20240206032301.6e4tmbvmk7vs72gg@synopsys.com>
 <ZcKk6QJXfGGo2DH9@pengutronix.de>
 <170731108881.252503.6282895768429052406@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fSw98v4lfXhwRAkt"
Content-Disposition: inline
In-Reply-To: <170731108881.252503.6282895768429052406@ping.linuxembedded.co.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fSw98v4lfXhwRAkt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 01:04:48PM +0000, Kieran Bingham wrote:
>Hi Michael,
>
>Quoting Michael Grzeschik (2024-02-06 21:30:17)
>> On Tue, Feb 06, 2024 at 03:23:17AM +0000, Thinh Nguyen wrote:
>> >On Tue, Feb 06, 2024, Michael Grzeschik wrote:
>> >> Hi Thinh
>> >>
>> >> I found some strange situation while streaming via uvc-gadget to some
>> >> usb host. It happens when some requests are missed due to higher load=
 on
>> >> the gadget machine. In some cases some requests will reach the host
>> >> twice. In my special case, I added the following changes [1] for the
>> >> host and gadget side.
>> >
>> >Does this only happen to some specific hosts?
>>
>> >Are all the data of the duplicate requests matching or just some bits of
>> >the transfer? Were you able to confirm from some usb analyzer/sniffer
>> >that the data out the wire is actually duplicate?
>>
>> Turns out, this duplicates are just misinterpretations.
>
>I'm glad there's no deeper issue to worry about here.
>
>> The linux uvcvideo driver will parse the uvc header payload twice. (If
>> the FID was incremented inbetween). This led to those double misleading
>> outputs. Although this means that there is a bug in
>> uvc_video_stats_decode for incrementing the error count.
>
>Do you plan/are you able to submit a patch to fix this?  Hopefully that
>would prevent anyone else following the same rabbit-hole.

Sure. For now I came up with this changes. This leaves the errorcounts
in a sane range. However with this compiled kernel I saw some issues
with the host machine to freeze up. I will just ensure that this is not
caused by this particular patch.

Regards,
Michael

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_=
video.c
index 40eafe43d1888..b582698be7f00 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1094,6 +1094,29 @@ static int uvc_video_decode_start(struct uvc_streami=
ng *stream,
                         uvc_video_stats_update(stream);
         }

+       /*
+        * Mark the buffer as done if we're at the beginning of a new frame.
+        * End of frame detection is better implemented by checking the EOF
+        * bit (FID bit toggling is delayed by one frame compared to the EOF
+        * bit), but some devices don't set the bit at end of frame (and the
+        * last payload can be lost anyway). We thus must check if the FID =
has
+        * been toggled.
+        *
+        * stream->last_fid is initialized to -1, so the first isochronous
+        * frame will never trigger an end of frame detection.
+        *
+        * Empty buffers (bytesused =3D=3D 0) don't trigger end of frame de=
tection
+        * as it doesn't make sense to return an empty buffer. This also
+        * avoids detecting end of frame conditions at FID toggling if the
+        * previous payload had the EOF bit set.
+        */
+       if (fid !=3D stream->last_fid && buf->bytesused !=3D 0) {
+               uvc_dbg(stream->dev, FRAME,
+                       "Frame complete (FID bit toggled)\n");
+               buf->state =3D UVC_BUF_STATE_READY;
+               return -EAGAIN;
+       }
+
         uvc_video_clock_decode(stream, buf, data, len);
         uvc_video_stats_decode(stream, data, len);

@@ -1140,29 +1163,6 @@ static int uvc_video_decode_start(struct uvc_streami=
ng *stream,
                 buf->state =3D UVC_BUF_STATE_ACTIVE;
         }

-       /*
-        * Mark the buffer as done if we're at the beginning of a new frame.
-        * End of frame detection is better implemented by checking the EOF
-        * bit (FID bit toggling is delayed by one frame compared to the EOF
-        * bit), but some devices don't set the bit at end of frame (and the
-        * last payload can be lost anyway). We thus must check if the FID =
has
-        * been toggled.
-        *
-        * stream->last_fid is initialized to -1, so the first isochronous
-        * frame will never trigger an end of frame detection.
-        *
-        * Empty buffers (bytesused =3D=3D 0) don't trigger end of frame de=
tection
-        * as it doesn't make sense to return an empty buffer. This also
-        * avoids detecting end of frame conditions at FID toggling if the
-        * previous payload had the EOF bit set.
-        */
-       if (fid !=3D stream->last_fid && buf->bytesused !=3D 0) {
-               uvc_dbg(stream->dev, FRAME,
-                       "Frame complete (FID bit toggled)\n");
-               buf->state =3D UVC_BUF_STATE_READY;
-               return -EAGAIN;
-       }
-
         stream->last_fid =3D fid;

         return data[0];



--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--fSw98v4lfXhwRAkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXDgUgACgkQC+njFXoe
LGRKKA//T7EQK6j8YHX1QWRUd6vBxMCBBeEaZ66Q0pLPouvy+ODPOWy+ZFp1Uqjo
ny07iJBxCupJS6blnVrz8ebl7lfXraxQV7bqaY+kNvepO+Ns05Ztv0g5/VV90sOT
WKhPlPFrXnz8iIs9iGEKG2SCkYncNAJoDMRX3bEsEIRyM4yI5tslA6ARU6+lZDzV
oJnB6RbfGzAoSeYLgAe1aO+p6svsL8yDpdK8HCO6mBf5wt1B8h9+0ooYEA3BHgND
NH3lR4HsO8Nxtwunvmjhwwp1xF6wG2v5RWA20QScQv5XIhlcoidN00HbVogdAXy1
a4VTY4jV7CbZlxHDTl7KS4q3P1dBmoLgN9ELo3HvzKDWmn7XtRSZ3dfamkUBkzJk
162kpAwqttcO3YMMdvZeRw52a2KmEDRZHrzHBhBob2A+7BJj+hGLwJ7DX0Vkb4wK
2icfnFMatAoAIlxZPj+MqgeM1VWvwwAPQGpgK7zaVBNkrcEJId4DJ41htg6JTPF7
gtprPlRUHqczuqHgwoNSfNuvo/M5WTXu186kySM3ZVGUuW8mLsFFiReP4SpR8RpM
nBIOjnUepMIpx9DyavIHB4hpOr0Wr8v8XM5SnN8v4uA3Rc/pG4g4MgCX9uDEa4ws
WI2tpJPNFYX16gPWSw4A7ReO+l9iDnuZ9JCUmNiNFwHaoyPziR8=
=VVLM
-----END PGP SIGNATURE-----

--fSw98v4lfXhwRAkt--

