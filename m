Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484037A5D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjISJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjISJS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:18:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEA100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:18:20 -0700 (PDT)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qiWrw-0008AB-7P; Tue, 19 Sep 2023 11:18:08 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qiWru-009c0Q-E5; Tue, 19 Sep 2023 11:18:06 +0200
Date:   Tue, 19 Sep 2023 11:18:06 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Jeff Vanhoof <jdv1029@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Vacura <w36195@motorola.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Message-ID: <ZQlnTsLriLGvZPfo@pengutronix.de>
References: <20221018215044.765044-1-w36195@motorola.com>
 <20221018215044.765044-3-w36195@motorola.com>
 <Y1PUjO99fcgaN0tc@kroah.com>
 <20221022133541.GA26431@qjv001-XeonWs>
 <20221024224748.3aao6cox5y4ptmob@synopsys.com>
 <ZQlln94I7MPlX0ff@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sr2zawqPPoJoClMC"
Content-Disposition: inline
In-Reply-To: <ZQlln94I7MPlX0ff@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:2:b01:1d::c5
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v4 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.whiteo.stw.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sr2zawqPPoJoClMC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:10:55AM +0200, Michael Grzeschik wrote:
>On Mon, Oct 24, 2022 at 10:47:53PM +0000, Thinh Nguyen wrote:
>>On Sat, Oct 22, 2022, Jeff Vanhoof wrote:
>>>Hi Greg,
>>>
>>>On Sat, Oct 22, 2022 at 01:31:24PM +0200, Greg Kroah-Hartman wrote:
>>>> On Tue, Oct 18, 2022 at 04:50:38PM -0500, Dan Vacura wrote:
>>>> > From: Jeff Vanhoof <qjv001@motorola.com>
>>>> >
>>>> > arm-smmu related crashes seen after a Missed ISOC interrupt when
>>>> > no_interrupt=3D1 is used. This can happen if the hardware is still u=
sing
>>>> > the data associated with a TRB after the usb_request's ->complete ca=
ll
>>>> > has been made.  Instead of immediately releasing a request when a Mi=
ssed
>>>> > ISOC interrupt has occurred, this change will add logic to cancel the
>>>> > request instead where it will eventually be released when the
>>>> > END_TRANSFER command has completed. This logic is similar to some of=
 the
>>>> > cleanup done in dwc3_gadget_ep_dequeue.
>>>> >
>>>> > Fixes: 6d8a019614f3 ("usb: dwc3: gadget: check for Missed Isoc from =
event status")
>>>> > Cc: <stable@vger.kernel.org>
>>>> > Signed-off-by: Jeff Vanhoof <qjv001@motorola.com>
>>>> > Co-developed-by: Dan Vacura <w36195@motorola.com>
>>>> > Signed-off-by: Dan Vacura <w36195@motorola.com>
>>>> > ---
>>>> > V1 -> V3:
>>>> > - no change, new patch in series
>>>> > V3 -> V4:
>>>> > - no change
>>>>
>>>> I need an ack from the dwc3 maintainer before I can take this one.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>>Thinh has rejected this version of the patch. He has provided an alterna=
tive
>>>implementation which has been testing well for us so far. Either Thinh o=
r Dan
>>>will formalize this patch within the next few days.
>>>The latest proposed changes are:
>>>
>>>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>index dfaf9ac24c4f..50287437d6de 100644
>>>--- a/drivers/usb/dwc3/gadget.c
>>>+++ b/drivers/usb/dwc3/gadget.c
>>>@@ -3195,6 +3195,9 @@ static int dwc3_gadget_ep_reclaim_completed_trb(st=
ruct dwc3_ep *dep,
>>>        if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>>                return 1;
>>>
>>>+       if (DWC3_TRB_SIZE_TRBSTS(trb->size) =3D=3D DWC3_TRBSTS_MISSED_IS=
OC && !chain)
>>>+               return 1;
>>>+
>>>        if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
>>>            (trb->ctrl & DWC3_TRB_CTRL_LST))
>>>                return 1;
>>>@@ -3211,6 +3214,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dw=
c3_ep *dep,
>>>        struct scatterlist *s;
>>>        unsigned int num_queued =3D req->num_queued_sgs;
>>>        unsigned int i;
>>>+       bool missed_isoc =3D false;
>>>        int ret =3D 0;
>>>
>>>        for_each_sg(sg, s, num_queued, i) {
>>>@@ -3219,12 +3223,18 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct =
dwc3_ep *dep,
>>>                req->sg =3D sg_next(s);
>>>                req->num_queued_sgs--;
>>>
>>>+               if (DWC3_TRB_SIZE_TRBSTS(trb->size) =3D=3D DWC3_TRBSTS_M=
ISSED_ISOC)
>>>+                       missed_isoc =3D true;
>>>+
>>>                ret =3D dwc3_gadget_ep_reclaim_completed_trb(dep, req,
>>>                                trb, event, status, true);
>>>                if (ret)
>>>                        break;
>>>        }
>>>
>>>+       if (missed_isoc)
>>>+               ret =3D 1;
>>>+
>>>        return ret;
>>> }
>>>
>>>
>>
>>That's just a debug patch. I'll send out proper fix patches.
>
>Ping!
>
>While digging out this thread, I did not find any followup patch
>for this suggestion. Did it hit the mailinglist anywhere?
>
>If not, will you send one?

Nevermind, I think I found the hunk in a variated version in this series.

https://lore.kernel.org/linux-usb/cover.1666735451.git.Thinh.Nguyen@synopsy=
s.com/

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--sr2zawqPPoJoClMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUJZ0gACgkQC+njFXoe
LGSIIBAAhZlRUqMeCB683Wh9mhpH9TldcDgLVwYvLrbgjA369sDRvnp0Bq/UHunS
Y6GxMg6NU2hZCF21Fo5KT7KOJcaBzU5oKmMsuaEGIpPEKekdglBmhtzNzWwZ6b3w
kC+D+AaG3dF1QZDc1Wr2FK7uV2y4qHRqecTXFfKNJYAl/hRNSzz/lsNsbiW3Rcu/
8j5C7FnlW8AB1SB6MNrQkYhMlJpS54pcnvJGSTj66Unotet1Qjc5VALiDnJlvBlw
M0BdZy+vhOXyjpNshOe+vwujXKwIYz3gLcg8F4SyCY2p22BoiWGMrq/b5oviBuwT
CwfjO0R/W0V5A11TEHeqd480M/3EUHhiwPVzepxHCBeplCSL8xMAmvPc/aaWdlov
F3YbEeEe7m1WRGbiyiFvJyZQJrsLHwJEdcGwNrbjCgYBQlAlIpG8rH0VLgxavDg+
8/8vOgCxbU1wFXy8z5gL3j1bilnuYH80DrBC/x8+/Or5NpmjiRCLGl1OpRtlS04l
sgb9HJBn1poXrhrT7/gheQba7NszcUVlZlhMolo5KJ6xdceAYESsGw0rUo8r2DfG
UxId9xPb9FlPbsV9e78Rukiri3Zzj5n27okY24RmcLOLR5m2a+Ha0D0qH7sbcbrR
tqqH3uRag5Z02JPbNzOUTqPQpt/5ezXdygoAZi49IrZSajPQUA4=
=bEGO
-----END PGP SIGNATURE-----

--sr2zawqPPoJoClMC--
