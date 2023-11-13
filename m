Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847B7E9F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjKMPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:10:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8615D4D;
        Mon, 13 Nov 2023 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699888199; x=1700492999; i=wahrenst@gmx.net;
        bh=FwjxaZrgxOoTaK9kKWvFnGEJ/pUoIhUMNnNjFbYMrVg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=lQ72t7bF854+qE0YEAOWd5hcXXf+0CcX3ibYvu51YUzF8c4gkacPL1n2o0jfKbBy
         k38+ppYTxAG4BwxBQf5pyCB3MB/ZKnuB1ErfNUkz1KbkIK73rRB8+Y6cxYXQthFZe
         qi9sFHn/GlN5jZgrbQE55vcm2OsK8ZGU9ij0rAecF/udCmCw3ALBWCAxfUCxtbaOt
         KX806J1u17xbe1KjwfvfvqCV6J9ELERvqnW+ICnSiLwb8zyO9OmiVHjvRXI6GX1zL
         S6oALpd6ZL11EMdMqpJ60SShCvoDBB0iJGsbEjiOSI6yfg0XcMcAQG0k7E8a59wl7
         yRUsE3AIZbWQkBGPqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1r19fU2Rup-008Wgs; Mon, 13
 Nov 2023 16:09:59 +0100
Message-ID: <db3ec8ed-35d3-495c-b701-370fe614693d@gmx.net>
Date:   Mon, 13 Nov 2023 16:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] staging: vc04_services: bcm2835-isp support
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <aec3897e-3ff6-4256-aaef-0cc1d5e7822a@gmx.net>
 <f93c6c32-1dea-95e8-aafc-0893c66f6b03@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <f93c6c32-1dea-95e8-aafc-0893c66f6b03@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DrL9EyfJ0Gu+8iYStwzIF5+IwPmHlHSOPxpALWF2crMNV8hMNY
 FPQ8sdkrnkMGKiOk/pkbkqtOSy5W8yyNPQAXdJjB/sUz7aywHJN44DbUh/Vngg5XfVRAQgM
 ErMtOy10i0D7nJciD5hQ5YpBvFw6Mdfg/7sPGRGGlFItn+WULUJ2l03EKarABygnVYa4Wd/
 FFUfUduFY1IekmUtUkUgA==
UI-OutboundReport: notjunk:1;M01:P0:1GkoQ+G5DKw=;2rMGYeIEXcz4JdB2AlN5j311eC2
 Tkiz21PrVW336AVbKuuZEbEWtFuS3G5k+nYQV1MFQ74wKliyVni5JB79xwJfT+tTXdlo4TyPW
 6eJ6CXveOX/pOpKFg4lH+4U9z+DoEftq+EoJcUEjAwIrO0w2H0C0Rlh5Ufm4THyNyT4hi5SCK
 4Nq2v4LWQDeSWwO6lHp8ALzFlpNiv7Tdkra8EQxooP5M3CnOH9ugU0WNwifFreVKtzKj69S+2
 6IzBYi2X8fMjBbqy9sG8t6Jojnqd/xGYzISGvV+5NPSayDbA1h/FRfZCwfG2CvvGwDJbUXFqm
 WiNbWHpZ0g3mBMN4SxAGSV5B8oqYk4chq/BkddVyuTApZJBp9sFb+qBH2sV/WkgjJwSaUMOtJ
 P2A1zfuNWuvNdv/Od9JWXPkIsq4Jzu5b/Eznm4GCXN9kJWNe+/kmgV9Qm9gUhqnph0s0vxHMs
 UB/gzkwrk4h2LrCw4WintXuloWq/EFEjxNsU179XxodkN1kM1ca+s4rh0CStpf3aQlWpIUX3N
 0mjiD0heKpmppzEH4ptJWlRR76KP9OBOX5wcwB2Q/JIH+Mzpv5jXz4zzUaiDiMJuKlv7HSHdb
 Zc2kSU5PiWT7VZNUuCL3vAgXKZfZl2YMfPFNwO/PgtKaCRFsppvVxBtn8w6LL5qIaqB0WU/aP
 KPdhvknw1zC+8mWs/gHeSORYzOkC4cDbXVWjDV56vxLgCAWPOEQkSXlGbxVdGD/3S7ZHyhmrH
 Im2szUbgK3Exr89KR0PsXeyPLWNYd+x8kwn/nU84LU8XV2D5FoLOqSFMn64dJ68o1Zm+5cIMH
 n2vfYmcDzRtCEGvxf9s9ytKxYezVp/dmPioTYF2mF+MiiGzR8igo0R8v0v0fkAFXSxNurdfFG
 fPOIRTbChYVcDD+7q+MdpsiuHDBMQV1yY8nDU5/92jZz2TMBchlp+OF5LR+r3yYgASmRN5SDB
 J7cdl0+Hm0NnB6B1BbBvrL6pknQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 13.11.23 um 14:38 schrieb Umang Jain:
> Hi Stefan,
>
> On 11/10/23 4:02 PM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 09.11.23 um 22:02 schrieb Umang Jain:
>>> This series aims to upport bcm2835-isp from the RPi kernel.
>>> It is developed on top of staging-next which comprises many
>>> VC04 changes for it's de-staging. Hence, the merge of this
>>> driver is targeted when VC04 is de-staged completely (which I
>>> have been pushing), but it can be helped getting reviewed meanwhile.
>>> Hence, the reason for posting the series.
>>>
>>> Patch (01-02)/15=C2=A0 adds a new driver named vc-sm-cma to handle mem=
ory
>>> sharing
>>> with the VC4 VPU.
>>>
>>> Patch 03/15 adds a small extension to videobuf2 to allow exporting as =
a
>>> dma_buf instead of a file-descriptor.
>>>
>>> Patch (04-05)/15 adds a couple of improvements/support for
>>> bcm2835-isp(event callback and zero-copy) to vchiq-mmal.
>>>
>>> Patch (06-10)/15 adds the core bcm2835-isp driver along with headers
>>> and format defintions. 09/15 is a standalone patch which can be merged
>>> independently I believe.
>>>
>>> Patch (11-12)/15 deals with the colorspace support.
>>>
>>> Patch 13/15 allows multiple instances of the ISP.
>>>
>>> Patch 14/15 adds a admin-guide document on bcm2835-isp.
>>>
>>> Patch 15/15 deals with driver registeration.
>>
>> since this is V2, i couldn't find a changelog? The first one was one
>> year ago, so it's very hard to remember. In such a case a link to the
>> last version is also helpful.
>
> I am in your same situation. The changelog won't help here since the I
> have too have lost count of the iterations.
>
> In brief, I would say, the patches have further cleaned up and
> aligned, rebased over the latest staging-next branch.
> That majorly includes work I did for VC04 in general for de-staging.
since this version
https://lore.kernel.org/lkml/910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonb=
oard.com/T/#mca165d5dcb1ba9f3ff3bf91ca2bc6ec2d3ae1c29

there were some feedback from other people like Laurent. I think it's
necessary to know if all the comments has been addressed or not. I think
there is no need to list every single change.

>
>>
>> Recently i saw you have a Github account. For such a complex series it'=
s
>> also very helpful to provide a link to a working test branch with this
>> series applied. It's not a must, but appreciated.
>
> I actually was going to send test branch but at the last minute I
> screwed up my .git repo because of a failed branch checkout.
>
> I had to recreate the branches over the weekend and here they are:
>
> I have tested these branches:
>
> On RPi-3-b 32-bit:
> Git branch:
> https://git.uk.ideasonboard.com/uajain/linux/commits/branch/uajain/rpi3/=
staging-next/isp
>
> On RPi-4-b 64-bit:
> Git branch:
> https://git.uk.ideasonboard.com/uajain/linux/commits/branch/uajain/rpi4/=
staging-next/isp
>
> Both these branches have been tested with IMX219 sensor (there is a DT
> overlay included) and libcamera. These branches have bcm2835-unicam
> with streams support (which is handled by Laurent Pinchart as I
> believe) and on top sits bcm2835-isp (this series).
> You'll find DT and kernel configs I have tested with, in the
> respective branches.
>
> As far as libcamera branch goes (it requires a special branch due to
> streams support):
> https://git.uk.ideasonboard.com/uajain/libcamera/commits/branch/pinchart=
l/rpi/streams
>
>
> Let me know how you get on if you are testing. I am happy to
> answer/help if you decide to test this.
This is great, i don't know when i've the time to test, but it also give
others the chance to do tests.

Regards
>>
>> Best regards
>>
>>>
>>> Dave Stevenson (6):
>>> =C2=A0=C2=A0 staging: vc04_services: Add new vc-sm-cma driver
>>> =C2=A0=C2=A0 media: videobuf2: Allow exporting of a struct dmabuf
>>> =C2=A0=C2=A0 staging: mmal-vchiq: Add support for event callbacks
>>> =C2=A0=C2=A0 staging: mmal-vchiq: Use vc-sm-cma to support zero copy
>>> =C2=A0=C2=A0 staging: mmal_vchiq: Add image formats to be used by bcm2=
835-isp
>>> =C2=A0=C2=A0 uapi: bcm2835-isp: Add bcm2835-isp uapi header file
>>>
>>> David Plowman (2):
>>> =C2=A0=C2=A0 vc04_services: bcm2835-isp: Allow formats with different =
colour
>>> spaces
>>> =C2=A0=C2=A0 vc04_services: bcm2835-isp: Permit all sRGB colour spaces=
 on ISP
>>> =C2=A0=C2=A0=C2=A0=C2=A0 outputs
>>>
>>> Naushir Patuck (4):
>>> =C2=A0=C2=A0 media: uapi: v4l2-core: Add ISP statistics output V4L2 fo=
urcc type
>>> =C2=A0=C2=A0 staging: vc04_services: bcm2835-isp: Add a more complex I=
SP
>>> processing
>>> =C2=A0=C2=A0=C2=A0=C2=A0 component
>>> =C2=A0=C2=A0 staging: vc04_services: bcm2835_isp: Allow multiple users
>>> =C2=A0=C2=A0 docs: admin-guide: media: bcm2835-isp: Add documentation =
for
>>> =C2=A0=C2=A0=C2=A0=C2=A0 bcm2835-isp
>>>
>>> Umang Jain (3):
>>> =C2=A0=C2=A0 staging: vc04_services: vchiq_arm: Register vcsm-cma driv=
er
>>> =C2=A0=C2=A0 staging: vc04_services: Add helpers for vchiq driver data
>>> =C2=A0=C2=A0 staging: vc04_services: vchiq: Register bcm2835-isp
>>>
>>> =C2=A0 .../admin-guide/media/bcm2835-isp.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 127 ++
>>> =C2=A0 .../userspace-api/media/drivers/index.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 .../userspace-api/media/v4l/meta-formats.rst=C2=A0 |=C2=A0=C2=
=A0=C2=A0 1 +
>>> =C2=A0 .../v4l/pixfmt-meta-bcm2835-isp-stats.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 32 +
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 9 +
>>> =C2=A0 .../media/common/videobuf2/videobuf2-core.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 36 +-
>>> =C2=A0 drivers/media/v4l2-core/v4l2-ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 drivers/staging/vc04_services/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +
>>> =C2=A0 drivers/staging/vc04_services/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +-
>>> =C2=A0 .../staging/vc04_services/bcm2835-isp/Kconfig |=C2=A0=C2=A0 14 =
+
>>> =C2=A0 .../vc04_services/bcm2835-isp/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +
>>> =C2=A0 .../bcm2835-isp/bcm2835-isp-ctrls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 72 +
>>> =C2=A0 .../bcm2835-isp/bcm2835-isp-fmts.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 559 +++++
>>> =C2=A0 .../bcm2835-isp/bcm2835-v4l2-isp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1822
>>> +++++++++++++++++
>>> =C2=A0 .../interface/vchiq_arm/vchiq_arm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
>>> =C2=A0 .../interface/vchiq_arm/vchiq_bus.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 10 +
>>> =C2=A0 .../staging/vc04_services/vc-sm-cma/Kconfig=C2=A0=C2=A0 |=C2=A0=
=C2=A0 10 +
>>> =C2=A0 .../staging/vc04_services/vc-sm-cma/Makefile=C2=A0 |=C2=A0=C2=
=A0=C2=A0 4 +
>>> =C2=A0 .../staging/vc04_services/vc-sm-cma/vc_sm.c=C2=A0=C2=A0 |=C2=A0=
 817 ++++++++
>>> =C2=A0 .../staging/vc04_services/vc-sm-cma/vc_sm.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 54 +
>>> =C2=A0 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c=C2=A0 |=C2=A0 507 =
+++++
>>> =C2=A0 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h=C2=A0 |=C2=A0=C2=
=A0 63 +
>>> =C2=A0 .../vc04_services/vc-sm-cma/vc_sm_defs.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 187 ++
>>> =C2=A0 .../vc04_services/vc-sm-cma/vc_sm_knl.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 28 +
>>> =C2=A0 .../staging/vc04_services/vchiq-mmal/Kconfig=C2=A0 |=C2=A0=C2=
=A0=C2=A0 1 +
>>> =C2=A0 .../vc04_services/vchiq-mmal/mmal-common.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 5 +
>>> =C2=A0 .../vc04_services/vchiq-mmal/mmal-encodings.h |=C2=A0=C2=A0 66 =
+
>>> =C2=A0 .../vc04_services/vchiq-mmal/mmal-msg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 35 +
>>> =C2=A0 .../vchiq-mmal/mmal-parameters.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 165 +-
>>> =C2=A0 .../vc04_services/vchiq-mmal/mmal-vchiq.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 253 ++-
>>> =C2=A0 .../vc04_services/vchiq-mmal/mmal-vchiq.h=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 5 +
>>> =C2=A0 include/media/videobuf2-core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15=
 +
>>> =C2=A0 include/uapi/linux/bcm2835-isp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 347 ++++
>>> =C2=A0 include/uapi/linux/v4l2-controls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
>>> =C2=A0 include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 1 +
>>> =C2=A0 35 files changed, 5235 insertions(+), 34 deletions(-)
>>> =C2=A0 create mode 100644 Documentation/admin-guide/media/bcm2835-isp.=
rst
>>> =C2=A0 create mode 100644
>>> Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rs=
t
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kc=
onfig
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Ma=
kefile
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-ctrls.h
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Kcon=
fig
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Make=
file
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_s=
m.c
>>> =C2=A0 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_s=
m.h
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
>>> =C2=A0 create mode 100644
>>> drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
>>> =C2=A0 create mode 100644 include/uapi/linux/bcm2835-isp.h
>>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

