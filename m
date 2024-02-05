Return-Path: <linux-kernel+bounces-54100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0F84AABB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F27B20F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C7F4EB29;
	Mon,  5 Feb 2024 23:40:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE34C3DE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176435; cv=none; b=dCOBA/PBFOkEhnC3n/ABnrXgom5Pi/D7y0XJkJMcrYX/q8CvB03R+/kTBRD1E0j7K/BJxF+PT5VbnnK1KjCcbjn9mtElgTijiexng0LleUclmESy5Sbg2H2LqgsbGfrx0NxC03Xodssp6CS7mtI03zMsVGC1qqNund5aveAHrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176435; c=relaxed/simple;
	bh=xPE7313tGa36WXt8zAWU+JWd3UaGL/fTkOi3lRYG8Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YUu0Ubu1UNDQ0o3Auc6b/U0Drf+BBzRx4/O2/MQLlG3LB9HY2zI26+AxVffV47Ck+DCj08ixXaFerqXeJY1ieF2kAPuQGMTBiFuE9Y2WKLSLhwW/XjDYWNIwBKtaLSxdi3crRRGPS0erHjYu2fl2mDy/njoxya8Rr6f4Q/pw2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rX8Zh-00082y-3L; Tue, 06 Feb 2024 00:40:29 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rX8Zg-004ifQ-7E; Tue, 06 Feb 2024 00:40:28 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rX8Zg-00CtLW-0R;
	Tue, 06 Feb 2024 00:40:28 +0100
Date: Tue, 6 Feb 2024 00:40:28 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: duplicate requests on host side while streaming via uvcvideo gadget
Message-ID: <ZcFx7P30Su_Mx4AV@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DBDd8WemaKPkFy1h"
Content-Disposition: inline
X-URL: http://www.pengutronix.de/
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--DBDd8WemaKPkFy1h
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thinh

I found some strange situation while streaming via uvc-gadget to some
usb host. It happens when some requests are missed due to higher load on
the gadget machine. In some cases some requests will reach the host
twice. In my special case, I added the following changes [1] for the
host and gadget side.

When applying the patches you will find all requests marked as errors on
the host and gadget side reported. However, the odd thing is that the
error counter on the host side will rise higher than the number of
requests we have actually marked as errornous on the gadget side. You
check the number of errors found on the host by looking in the
statistics and compare it with the numer of requests that are actually
marked with UVC_STREAM_ERR.

[1] applied hunks:

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functio=
n/uvc.h
index 6bdcf3bdd62a9..63515fc949880 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -91,6 +91,8 @@ struct uvc_video {
         struct work_struct pump;
         struct workqueue_struct *async_wq;

+       int errorcount;
+
         /* Frame parameters */
         u8 bpp;
         u32 fcc;

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/f=
unction/uvc_video.c
index eb1f7cee4a0af..f45dd53fde7ef 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -35,6 +35,12 @@ uvc_video_encode_header(struct uvc_video *video, struct =
uvc_buffer *buf,

         data[1] =3D UVC_STREAM_EOH | video->fid;

+       if (video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
+               video->errorcount++;
+               printk("dropping frame! %d\n", video->errorcount);
+               data[1] |=3D UVC_STREAM_ERR;
+       }
+
         if (video->queue.buf_used =3D=3D 0 && ts.tv_sec) {
                 /* dwClockFrequency is 48 MHz */
                 u32 pts =3D ((u64)ts.tv_sec * USEC_PER_SEC + ts.tv_nsec / =
NSEC_PER_USEC) * 48;

@@ -47,6 +47,8 @@ uvc_video_encode_header(struct uvc_video *video, struct u=
vc_buffer *buf,
 =20
                 data[1] |=3D UVC_STREAM_PTS;
                 put_unaligned_le32(pts, &data[pos]);
+               if (data[1] & UVC_STREAM_ERR)
+                       trace_printk("PTS: %u\n", data[pos]);
                 pos +=3D 4;
         }
 =20
@@ -60,6 +62,10 @@ uvc_video_encode_header(struct uvc_video *video, struct =
uvc_buffer *buf,
                 data[1] |=3D UVC_STREAM_SCR;
                 put_unaligned_le32(stc, &data[pos]);
                 put_unaligned_le16(sof, &data[pos+4]);
+               if (data[1] & UVC_STREAM_ERR) {
+                       trace_printk("SCR: %u\n", data[pos]);
+                       trace_printk("SCR: %hu\n", data[pos+4]);
+               }
                 pos +=3D 6;
         }
 =20

@@ -731,6 +734,7 @@ int uvcg_video_enable(struct uvc_video *video)
         struct usb_gadget *gadget =3D cdev->gadget;
         int ret;

+       video->errorcount =3D 0;
         if (video->ep =3D=3D NULL) {
                 uvcg_info(&video->uvc->func,
                           "Video enable failed, device is uninitialized.\n=
");

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_=
video.c
index 28dde08ec6c5d..40eafe43d1888 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -916,8 +916,24 @@ static void uvc_video_stats_decode(struct uvc_streamin=
g *stream,
         if (len <=3D header_size)
                 stream->stats.frame.nb_empty++;

-       if (data[1] & UVC_STREAM_ERR)
+       if (data[1] & UVC_STREAM_ERR) {
                 stream->stats.frame.nb_errors++;
+               printk("error on uvc package!\n");
+               if (data[1] & UVC_STREAM_PTS) {
+                       printk("PTS: %u\n", data[2]);
+                       if (data[1] & UVC_STREAM_SCR) {
+                               printk("SCR: %u\n", data[6]);
+                               printk("SCR: %hu\n", data[10]);
+                       }
+               } else {
+                       if (data[1] & UVC_STREAM_SCR) {
+                               printk("SCR: %u\n", data[2]);
+                               printk("SCR: %hu\n", data[6]);
+                       }
+               }
+
+
+       }
  }

-- Host:

[ 1769.213387] error on uvc package!
[ 1769.213396] PTS: 16
[ 1769.213400] SCR: 64
[ 1769.213402] SCR: 229

[ 1769.461386] error on uvc package!
[ 1769.461394] PTS: 96
[ 1769.461398] SCR: 80
[ 1769.461401] SCR: 33

[ 1769.461405] error on uvc package! <- duplicate
[ 1769.461408] PTS: 96
[ 1769.461410] SCR: 80
[ 1769.461413] SCR: 33

[ 1769.657405] error on uvc package!
[ 1769.657442] PTS: 224
[ 1769.657449] SCR: 64
[ 1769.657453] SCR: 81

[ 1769.657460] error on uvc package! <- duplicate
[ 1769.657465] PTS: 224
[ 1769.657470] SCR: 64
[ 1769.657476] SCR: 81

[ 1779.525368] error on uvc package!
[ 1779.525374] PTS: 128
[ 1779.525378] SCR: 224
[ 1779.525380] SCR: 157

[ 1784.637359] error on uvc package!
[ 1784.637367] PTS: 0
[ 1784.637371] SCR: 208
[ 1784.637374] SCR: 89

[ 1784.825357] error on uvc package!
[ 1784.825394] PTS: 224
[ 1784.825401] SCR: 192
[ 1784.825406] SCR: 63

[ 1784.841362] error on uvc package!
[ 1784.841394] PTS: 144
[ 1784.841403] SCR: 48
[ 1784.841410] SCR: 186

[ 1784.841418] error on uvc package! <- duplicate
[ 1784.841424] PTS: 144
[ 1784.841430] SCR: 48
[ 1784.841436] SCR: 186

host$ grep errors /sys/kernel/debug/usb/uvcvideo/*/stats
/sys/kernel/debug/usb/uvcvideo/4-81-1/stats:errors:  10


-- Gadget:

[=A0 126.826517] dropping frame! 1
[=A0 126.829658] PTS: 16
[=A0 126.831761] SCR: 64
[=A0 126.833858] SCR: 229

[=A0 127.090069] dropping frame! 2
[=A0 127.093059] PTS: 96
[=A0 127.095164] SCR: 80
[=A0 127.097261] SCR: 33

[=A0 127.288045] dropping frame! 3
[=A0 127.291041] PTS: 224
[=A0 127.293233] SCR: 64
[=A0 127.295330] SCR: 81

[=A0 137.153499] dropping frame! 4
[=A0 137.156494] PTS: 128
[=A0 137.158687] SCR: 224
[=A0 137.160871] SCR: 157

[=A0 142.265135] dropping frame! 5
[=A0 142.268131] PTS: 0
[=A0 142.270148] SCR: 208
[=A0 142.272332] SCR: 89

[=A0 142.453636] dropping frame! 6
[=A0 142.456634] PTS: 224
[=A0 142.458825] SCR: 192
[=A0 142.461009] SCR: 63

[=A0 142.469131] dropping frame! 7
[=A0 142.472118] PTS: 144
[=A0 142.474310] SCR: 48
[=A0 142.476407] SCR: 186

Now I am totally unsure what could cause such error, but would expect
the issue to be somewhere in the gadget driver and the mapped trb memory
content. For the uvc_video layer, I compared and tested the enqueued
request list for duplicates but could not find any. I also reverted all
recent patches that changed request handling in the past year. I still
find these request duplicates on the host side show up.

Any Ideas?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--DBDd8WemaKPkFy1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXBcewACgkQC+njFXoe
LGTcoQ/8CH+HMxAw3N8p4z+XyEEb0Z4OnD7ICOQE/1EoFoi5MY83gfzS+vDVEb0k
yqCYcLTLZfzAciPQpFWmvwaQeNy8A9yjFbcQ6d5vzWE2NdPuctcgfynZenCCx7pF
QyWcOlJRS72esk/mk++gHuS297piTAUDofTJGfzkrNb6iYTppA/IFEgpPcx+kjuU
S/3MwuTK3VdlK42SDtrT0HfTYLrvMXyMfa38ya/DC2HSdjUiBj7IQFHWQJNJAIiY
eeHYlYubiMWfZktIF+/Vj9UdtFcKR4WYGJePPj62YvUX1Xokgve5GiwJRllU7Q9g
zMYuUZTmIHOa7+f9kCw0NLh6qhWGyiARJyld5x+IsK9MiV8OPK12Eudko2iqNWvU
5z6IYh0ohWZXlGtdGosJZz1roENfTBq0R768C1heD0Gkga77k4pxONXzagbZNM/i
E+GIWzOZ1rA3kjLoW7heOF+yRVFmDPG0rhIEg2QZqHHAtp9S2U1P2XftA7hgJgKM
6E6/r8w/xwGrixJg2SOHMy74hvlwIhF4mnr+ENfNk8OIhU+ayzQscWQPz7ENRdJl
rMKb9RtJdXHREtzQSOotnlr1kJlQd9GmBt4VjUksux3yclY13dxWDdcKjBEESKlz
OYGUOoeVCa7ahldUSt2oesH9L/Yt9sRsaIu/Qh0ekwrhBcgCrRI=
=5xjG
-----END PGP SIGNATURE-----

--DBDd8WemaKPkFy1h--

