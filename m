Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418D7DA6A7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjJ1LKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1LKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:10:44 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C13CE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:10:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwhD6-0003DP-FG; Sat, 28 Oct 2023 13:10:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwhD4-004qpF-Qf; Sat, 28 Oct 2023 13:10:30 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwhD4-00DGx5-H7; Sat, 28 Oct 2023 13:10:30 +0200
Date:   Sat, 28 Oct 2023 13:10:30 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jayant Chowdhary <jchowdhary@google.com>,
        Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <ZTzsJo1/NPVTLCnY@pengutronix.de>
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
 <20231027075117.GJ26306@pendragon.ideasonboard.com>
 <ZTuanepgXLXRoSMW@pengutronix.de>
 <20231027114752.GB12144@pendragon.ideasonboard.com>
 <ZTu9oEw1QEOxbHCf@pengutronix.de>
 <7c30f943-aaad-47dd-9ae3-02f1ca57e49b@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yfFlOpHlyGVJvKC0"
Content-Disposition: inline
In-Reply-To: <7c30f943-aaad-47dd-9ae3-02f1ca57e49b@rowland.harvard.edu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfFlOpHlyGVJvKC0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:58:11AM -0400, Alan Stern wrote:
>On Fri, Oct 27, 2023 at 03:39:44PM +0200, Michael Grzeschik wrote:
>> On Fri, Oct 27, 2023 at 02:47:52PM +0300, Laurent Pinchart wrote:
>> > On Fri, Oct 27, 2023 at 01:10:21PM +0200, Michael Grzeschik wrote:
>> > > On Fri, Oct 27, 2023 at 10:51:17AM +0300, Laurent Pinchart wrote:
>> > > > On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
>> > > >> This patch is based on top of
>> > > >> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh=
@google.com/T/#t:
>> > > >>
>> > > >> When we use an async work queue to perform the function of pumping
>> > > >> usb requests to the usb controller, it is possible that thread sc=
heduling
>> > > >> affects at what cadence we're able to pump requests. This could m=
ean usb
>> > > >> requests miss their uframes - resulting in video stream flickers =
on the host
>> > > >> device.
>> > > >>
>> > > >> In this patch, we move the pumping of usb requests to
>> > > >> 1) uvcg_video_complete() complete handler for both isoc + bulk
>> > > >>    endpoints. We still send 0 length requests when there is no uv=
c buffer
>> > > >>    available to encode.
>> > > >
>> > > > This means you will end up copying large amounts of data in interr=
upt
>> > > > context. The work queue was there to avoid exactly that, as it will
>> > > > introduce delays that can affect other parts of the system. I thin=
k this
>> > > > is a problem.
>> > >
>> > > Regarding Thin's argument about possible scheduling latency that is =
already
>> > > introducing real errors, this seemed like a good solution.
>> > >
>> > > But sure, this potential latency introduced in the interrupt context=
 can
>> > > trigger other side effects.
>> > >
>> > > However I think we need some compromise since both arguments are ver=
y valid.
>> >
>> > Agreed.
>> >
>> > > Any ideas, how to solve this?
>> >
>> > I'm afraid not.
>>
>> We discussed this and came to the conclusion that we could make use of
>> kthread_create and sched_setattr with an attr->sched_policy =3D SCHED_DE=
ADLINE
>> here instead of the workqueue. This way we would ensure that the worker
>> would be triggered with hard definitions.
>>
>> Since the SG case is not that heavy on the completion handler, we could
>> also make this kthread conditionaly to the memcpy case.
>
>If you don't mind a naive suggestion from someone who knows nothing
>about the driver...
>
>An attractive possibility is to have the work queue (or kthread) do the
>time-consuming copying, but leave the submission up to the completion
>handler.  If the data isn't ready (or there's no data to send) when the
>handler runs, then queue a 0-length request.
>
>That will give you the best of both worlds: low latency while in
>interrupt context and a steady, constant flow of USB transfers at all
>times.  The question of how to schedule the work queue or kthread is a
>separate matter, not directly relevant to this design decision.

That's it. This is probably the best way to tackle the overall problem.

So we leave the call of the encode callback to the worker, that will
probably still can be a workqueue. The complete callback is calling
the explicit uvcg_video_ep_queue when prepared requests are available
and if there is nothing pending it will just enqueue zero requests.

Thank you Alan, this makes so much sense!

Jayant, Laurent: Do you agree?
If yes, Jayant will you change the patch accordingly?

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--yfFlOpHlyGVJvKC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmU87CMACgkQC+njFXoe
LGRoCA/+PcBaIiaI6W358Cq6K6VRpLwqjM61/4QAOhPVk2ZDh2FaERuOu+dBudkn
/74Gt5JP6x91HRNHiuq8I58rOTaxJPFu89nN2pOnuHr2/0BFE2UavYxbzRDmaXDt
2G8dg0Ak5vtZq1JYa546WigQaEDnwkBVzvG2zqwGvAqb8YK/beojbwWivjFYUPLe
cYSP/75aORzfSu6Vhqv1gWh/5alqzXEunbpucGKE4XfmGfNRT6d5Yd9hQbLJttZ1
PH4eaTMAj7b+sb4Nmevwg/lKPPA/3ca/btrgjS+mmFGXHodr480ScehkdKCE59FQ
ISrFHT8jljBLsO0uKGU3be6LiNjECbONGkCB/1E/rgJutwRBfhyoAuQNzu7k6/f7
KrEd0hN2h4N1XICt/oFVF4kKuOmoEnrdrxE5v7PwML9KRhJ8z9cPu/Qeo9Et8N0F
tUM63AIkUveHT5FMFuJlhcFAr7hxIf0XcPF2ML6Cxby089sOL9UOi3ME2Y8gNsD3
+p/+eZuqURHqj64gtOZQA+yzuLmt9VE0dNn6WfppigYkyjH50UHO81sZEG8cGPvw
gq4bM6tur2KaNEEqbbDZ68p44btabC6vTop7x5ERaPWDJSKYM5QcI5awrWoW8a6F
mkPgjVhYv5Rgtr8adEOIqjvJtFZRs/xvhZ6v0eSk42izRqJXLUQ=
=D4gP
-----END PGP SIGNATURE-----

--yfFlOpHlyGVJvKC0--
