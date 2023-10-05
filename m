Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70F7BA2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjJEPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJEPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D971726
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:14:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoLN6-00020h-L2; Thu, 05 Oct 2023 12:14:20 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoLN5-00BFAl-U2; Thu, 05 Oct 2023 12:14:19 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoLN5-00F94W-KY; Thu, 05 Oct 2023 12:14:19 +0200
Date:   Thu, 5 Oct 2023 12:14:19 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Avichal Rakesh <arakesh@google.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
Message-ID: <ZR6Me5WsAbjvc2hk@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <ZRv2UnKztgyqk2pt@pengutronix.de>
 <20231005082327.GC13853@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6taxRm4yga2KkIgQ"
Content-Disposition: inline
In-Reply-To: <20231005082327.GC13853@pendragon.ideasonboard.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6taxRm4yga2KkIgQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent

On Thu, Oct 05, 2023 at 11:23:27AM +0300, Laurent Pinchart wrote:
>On Tue, Oct 03, 2023 at 01:09:06PM +0200, Michael Grzeschik wrote:
>> On Sat, Sep 30, 2023 at 11:48:18AM -0700, Avichal Rakesh wrote:
>> > We have been seeing two main stability issues that uvc gadget driver
>> > runs into when stopping streams:
>> >  1. Attempting to queue usb_requests to a disabled usb_ep
>> >  2. use-after-free issue for inflight usb_requests
>> >
>> > The three patches below fix the two issues above. Patch 1/3 fixes the
>> > first issue, and Patch 2/3 and 3/3 fix the second issue.
>> >
>> > Avichal Rakesh (3):
>> >   usb: gadget: uvc: prevent use of disabled endpoint
>> >   usb: gadget: uvc: Allocate uvc_requests one at a time
>> >   usb: gadget: uvc: Fix use-after-free for inflight usb_requests
>> >
>> > drivers/usb/gadget/function/f_uvc.c     |  11 +-
>> > drivers/usb/gadget/function/f_uvc.h     |   2 +-
>> > drivers/usb/gadget/function/uvc.h       |   6 +-
>> > drivers/usb/gadget/function/uvc_v4l2.c  |  21 ++-
>> > drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-------
>> > 5 files changed, 164 insertions(+), 65 deletions(-)
>>
>> These patches are not applying on gregkh/usb-testing since
>> Greg did take my patches first. I have already rebased them.
>
>I think they got merged too soon :-( We could fix things on top, but
>there's very little time to do so for v6.7.

Agreed. I was jumping from one workaround to another one, since this
is not easy to fix in a proper way. And still after this long discussion
with Avichal I don't think we are there yet.


So far the first two patches from Avichal look legit. But the overall
Use-After-Free fix is yet to be done properly.

The "abondoned" method he suggested is really bad to follow and will
add too much complexity and will be hard to debug.

IMHO it should be possible to introduce two cleanup pathes.

One path would be in the uvc_cleanup_requests that will cleanup the
requests that are actually not used in the controller and are registered
in the req_free list.

The second path would be the complete functions that are being run
=66rom the controller and will ensure that the cleanup will really free
the requests from the controller after they were consumed.

What do you think?

Regards,
Michael

>> In the updated version I the stack runs into the
>> following error, when enabling lockdep. Could you
>> try your version with lockdep enabled?
>>
>> [   41.278520] configfs-gadget.vz gadget.0: uvc: reset UVC
>> [   47.156261] configfs-gadget.vz gadget.0: uvc: uvc_function_set_alt(2,=
 0)
>> [   47.169177]
>> [   47.170903] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   47.176857] WARNING: possible recursive locking detected
>> [   47.182798] 6.5.0-20230919-1+ #19 Tainted: G         C
>> [   47.189323] --------------------------------------------
>> [   47.195256] vzuvcd/412 is trying to acquire lock:
>> [   47.200511] ffffff8009560928 (&video->req_lock){....}-{3:3}, at: uvc_=
video_complete+0x44/0x2e0
>> [   47.210172]
>> [   47.210172] but task is already holding lock:
>> [   47.216687] ffffff8009560928 (&video->req_lock){....}-{3:3}, at: uvcg=
_video_enable+0x2d0/0x5c0
>> [   47.226333]
>> [   47.226333] other info that might help us debug this:
>> [   47.233625]  Possible unsafe locking scenario:
>> [   47.233625]
>> [   47.240242]        CPU0
>> [   47.242974]        ----
>> [   47.245709]   lock(&video->req_lock);
>> [   47.249802]   lock(&video->req_lock);
>> [   47.253897]
>> [   47.253897]  *** DEADLOCK ***
>> [   47.253897]
>> [   47.260511]  May be due to missing lock nesting notation
>> [   47.260511]
>
>--=20
>Regards,
>
>Laurent Pinchart
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6taxRm4yga2KkIgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUejHYACgkQC+njFXoe
LGS/tBAAv1d9NLfHCEL7BNkWB2otAjRuMI7KIE8WzOULuaSJ5nqHEhPm8f/N4qvt
Lax5AMpP3XpcSnSDbpSrjJXS6zYGRKsDLOkLzzu1SzSmKXzH1KnWUzOogBKyK2Yw
/lwoETzqXtmezr26YhIE3hAgvLGnKwvTOFW7IQmhnkJs6QXhKG0mEyMWp9GSHOA9
GHSoc4hOh8RQkVeZjaOu6NnAniSmS08ieak95ZjkA3KieDzOaYMnLIKDPkFxf068
FC9/M+C6yWX1l3f8fSiiL7eGQ8gDYHZX205B1zuIHDM9xBIpujXXKvd/7LpISNml
nCFRrDTiiCnm9Fv7lALnmAnryw2PRUnpKApVRr6xGyg6U///i+UcIKNCYO9G/EJ4
3OflX7g4JvYf9clNpUmMvpDUE/B1kIE8wt/yO9XsULct15c/T5Jhgv9wZ2KzCxqJ
e8s9DAg746OymRIu0IM/+rJJ469NXOv+SPEP6xyJX6nU2MaD82i5jpcAQNQVBU05
QQ+414nz88gT+RNMLA1TcRcD33hFOj+D6bvUGwF1qvBIEN23NPTFAMGLUJIkZX6R
pJl2SHmMh4ClLim5HqTTO+F0ZMd6SjUc+o5NzsWWQBPBkZmqU+h8vspd1C1ddykO
h1OQK8/b/HtElFEWFJnRzgK9Z05e7UrX2uiOyN2DRLnNNy5DONc=
=y9yp
-----END PGP SIGNATURE-----

--6taxRm4yga2KkIgQ--
