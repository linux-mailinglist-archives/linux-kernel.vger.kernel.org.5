Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7A7BCFE3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjJHTsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbjJHTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:48:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A16CB3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:48:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qpZl3-0007Qy-QW; Sun, 08 Oct 2023 21:48:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qpZl3-000ExZ-8h; Sun, 08 Oct 2023 21:48:09 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qpZl2-0029AG-VV; Sun, 08 Oct 2023 21:48:08 +0200
Date:   Sun, 8 Oct 2023 21:48:08 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
Message-ID: <ZSMHeH6jNtXMRR2K@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <ZRv2UnKztgyqk2pt@pengutronix.de>
 <20231005082327.GC13853@pendragon.ideasonboard.com>
 <ZR6Me5WsAbjvc2hk@pengutronix.de>
 <53300d24-b558-428d-b52f-316b2e456313@google.com>
 <ZR8zKHQv1dkyLosv@pengutronix.de>
 <50f92131-3e41-49a8-834d-8ae3ae36f565@google.com>
 <ZSCP0clqb1Nn/Ft3@pengutronix.de>
 <b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gr8oh/LpJnL2T3Nd"
Content-Disposition: inline
In-Reply-To: <b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com>
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


--Gr8oh/LpJnL2T3Nd
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 04:48:19PM -0700, Avichal Rakesh wrote:
>On 10/6/23 15:53, Michael Grzeschik wrote:
>> On Fri, Oct 06, 2023 at 10:00:11AM -0700, Avichal Rakesh wrote:
>>>
>>>
>>> On 10/5/23 15:05, Michael Grzeschik wrote:
>>>> Hi Avichal,
>>>>
>>>> On Thu, Oct 05, 2023 at 11:30:32AM -0700, Avichal Rakesh wrote:
>>>>> On 10/5/23 03:14, Michael Grzeschik wrote:
>>>>>> On Thu, Oct 05, 2023 at 11:23:27AM +0300, Laurent Pinchart wrote:
>>>>>>> On Tue, Oct 03, 2023 at 01:09:06PM +0200, Michael Grzeschik wrote:
>>>>>>>> On Sat, Sep 30, 2023 at 11:48:18AM -0700, Avichal Rakesh wrote:
>>>>>>>> > We have been seeing two main stability issues that uvc gadget dr=
iver
>>>>>>>> > runs into when stopping streams:
>>>>>>>> >=A0 1. Attempting to queue usb_requests to a disabled usb_ep
>>>>>>>> >=A0 2. use-after-free issue for inflight usb_requests
>>>>>>>> >
>>>>>>>> > The three patches below fix the two issues above. Patch 1/3 fixe=
s the
>>>>>>>> > first issue, and Patch 2/3 and 3/3 fix the second issue.
>>>>>>>> >
>>>>>>>> > Avichal Rakesh (3):
>>>>>>>> >=A0=A0 usb: gadget: uvc: prevent use of disabled endpoint
>>>>>>>> >=A0=A0 usb: gadget: uvc: Allocate uvc_requests one at a time
>>>>>>>> >=A0=A0 usb: gadget: uvc: Fix use-after-free for inflight usb_requ=
ests
>>>>>>>> >
>>>>>>>> > drivers/usb/gadget/function/f_uvc.c=A0=A0=A0=A0 |=A0 11 +-
>>>>>>>> > drivers/usb/gadget/function/f_uvc.h=A0=A0=A0=A0 |=A0=A0 2 +-
>>>>>>>> > drivers/usb/gadget/function/uvc.h=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +-
>>>>>>>> > drivers/usb/gadget/function/uvc_v4l2.c=A0 |=A0 21 ++-
>>>>>>>> > drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-=
------
>>>>>>>> > 5 files changed, 164 insertions(+), 65 deletions(-)
>>>>>>>>
>>>>>>>> These patches are not applying on gregkh/usb-testing since
>>>>>>>> Greg did take my patches first. I have already rebased them.
>>>>>>>
>>>>>>> I think they got merged too soon :-( We could fix things on top, but
>>>>>>> there's very little time to do so for v6.7.
>>>>>>
>>>>>> Agreed. I was jumping from one workaround to another one, since this
>>>>>> is not easy to fix in a proper way. And still after this long discus=
sion
>>>>>> with Avichal I don't think we are there yet.
>>>>>>
>>>>>>
>>>>>> So far the first two patches from Avichal look legit. But the overall
>>>>>> Use-After-Free fix is yet to be done properly.
>>>>>>
>>>>>> The "abondoned" method he suggested is really bad to follow and will
>>>>>> add too much complexity and will be hard to debug.
>>>>>>
>>>>>> IMHO it should be possible to introduce two cleanup pathes.
>>>>>>
>>>>>> One path would be in the uvc_cleanup_requests that will cleanup the
>>>>>> requests that are actually not used in the controller and are regist=
ered
>>>>>> in the req_free list.
>>>>>>
>>>>>> The second path would be the complete functions that are being run
>>>>>> from the controller and will ensure that the cleanup will really free
>>>>>> the requests from the controller after they were consumed.
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> I am not sure I follow. Patch 3/3 does exactly what you say here.
>>>>
>>>> Yes, it was just to summ up what the latest state of the idea was,
>>>> so Laurent does not read the whole thread in detail. Sorry for not
>>>> being clear enough about that.
>>>
>>> Whoops! Sorry about the misunderstanding!
>>>
>>>>
>>>>> There are two cleanup paths:
>>>>> =A01. uvcg_video_disable cleans up only the requests in req_free, and
>>>>> =A02. complete handler cleans up the in-flight requests.
>>>>>
>>>>> The "abandoned" flag is simply to let the completion handler know
>>>>> which requests to clean up and which ones to re-queue back to
>>>>> the gadget driver.
>>>>
>>>> What I don't get is, why in the case of shutdown there needs to
>>>> be something re-queued back to the gadget driver. There should not
>>>> need to be any sort of barrier flag for the requests. Just the
>>>> complete handler running past a barrier where it knows that the
>>>> whole device is stopped. So every call on complete should then clean
>>>> that exact request it is touching currently.
>>>>
>>>> I don't know where the extra complexity comes from.
>>>
>>> A lot of this complexity comes from assuming a back to back
>>> STREAMOFF -> STREAMON sequence is possible where the gadget driver
>>> doesn't have the time to clean up all in-flight usb_requests.
>>> However, looking through the usb gadget APIs again, and it
>>> looks like=A0 usb_ep_disable enforces that all requests will
>>> be sent back to the gadget driver before it returns.
>>
>> Great!
>
>Uhh...apologies, I will have to take this back. I've been
>trying to use uvc->state as the condition for when completion
>handler should clean up usb_requests, and I cannot figure
>out a way to do so cleanly.
>
>The fundamental problem with using uvc->state is that it is
>not protected by any locks. So there is no real way to
>assert that its value has not changed between reading
>uvc->state and acting on it.
>
>Naively we can write something like the following in the
>completion handler:
>
>void uvc_video_complete(...) {
>    if (uvc->state !=3D UVC_EVENT_STREAMING) {
>        usb_ep_free_request(....);
>    } else {
>        // handle usb_request normally
>    }
>}
>
>But without any locks, there are no guarantees that
>uvc->state didn't mutate immediately after the if
>condition was checked, and the complete handler is
>handling a request that it should've freed instead
>or vice-versa. This argument would hold for any logic
>we guard with uvc->state, making uvc->state effectively
>useless as a check for freeing memory.

Yes, this makes total sense. Since the above condition was also part of
the wait_event patch you created in the first place, I bet this issue
was there aswell and was probably causing the issues I saw while testing
it.


>We can work around it by either
>1. Locking uvc->state with some driver level lock
>   to ensure that we can trust the value of uvc->state
>   at least for a little while, or
>2. Using some other barrier condition that is protected by
>   another lock
>
>If we go with (1), we'd have to add a lock around every
>and every write to uvc->state, which isn't terrible, but
>would require more testing to ensure that it doesn't
>create any new deadlocks.
>
>For (2), with the realization that usb_ep_disable flushes
>all requests, we can add a barrier in uvc_video, protected by
>req_lock. That should simplify the logic a little bit and
>will hopefully be easier to reason about.
>
>I could of course be missing a simpler solution here,
>and am happy to be wrong. So please let me know if you
>have any other ideas on how to guarantee such a check.

For now, I have no better Idea. Idea (2) sounds like
a good compromise. But I will have to review that code
to really judge.

Thanks for the work!

Michael


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Gr8oh/LpJnL2T3Nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUjB3AACgkQC+njFXoe
LGQ32Q//Yn/jBOubcOrhlN4vmXxNuP7zr4WQufqoL5NqWJcR3HGkg7NvKuQ8gex1
8PXTwLVPaHe0h/qAL6moBv5uYsC7+LaJrdLWXSeAQ9We/8FhaxE48w6ByNyJM6S8
PuEGDy3BE13HCtCOLhtdJwUQad7AlUQTCv+0pSFyvNYVCOnDfi54H6jLW9nr2JYG
hSfQrlFa3I3Bohbc6DZGRUo/Frzwms2fKHby9pSYPVkO64pbYfIW12OuXe528BYX
98bhzWOJWXIepwaT3aUZtHZSPxZ0HOGbhKDz0JpYRHRURdBBXN8Gc6V8cnHtyXk7
ub4J3qwdLe3Yw8b/ddvFvovgw4fmhYxZHZOcxVgOPjnKR118R7tCt6B8rG/7ZOtw
mUfaehI2JgpscI5PV6ZnKrDrlHrWWezbYDk+sk4D3VPr4UYxoVOLyj+ffNMK5d/H
PqWVqIQQTyFra1U1fHxgXtRpK4e0DW2g6njYlEmZ8BgYxL8nU7lFM2MKFgEQfXL0
17NqimEwymWNXOhglG3builKwUAv9tDQO4xEu1THPzPoACEXX0MQHEDz+e7enjND
WYUnyPpuTK27d8mYmXDyYq6sXuvSjwGdTJDY6t4OV/lJrPtSpp27nYJc66ySCorh
5pU3N1L1RAlXljuiiuJ9gQlXYPtF5YjiziWcQwk1aZiMyD4w7ik=
=OFCu
-----END PGP SIGNATURE-----

--Gr8oh/LpJnL2T3Nd--
