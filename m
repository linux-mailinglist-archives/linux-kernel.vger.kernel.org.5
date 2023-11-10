Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE557E7FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjKJR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjKJR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFA29506;
        Fri, 10 Nov 2023 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699612349; x=1700217149; i=wahrenst@gmx.net;
        bh=VYUzFbtyLV0OMmDyZppluwpgFsQNDPwwwtizFu1yQGo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=fyqg58EofYlVvDHn84ZHH/jKJUR5U3PBJpB0a4V1rMEbYquFoswA+JWyFS7LnUHv
         mzc0RkN+0wdJ2EI+DCCzmYiUwRR7tzIbeQJcCTd9DcRJo8kfrMReOmYTa6sE5U5wv
         jp5A6n0rnpw4sfB+K94bIRTbVWyRkrFFXtB3qfqkMAio/j4NgvW44oQ8sgl9STpwC
         6HSVxhrbdsftwsTxNd/PkvlHzaGiWZ3CwTzhk8mc/5DRFtzkslOikPzje7YOsVdDO
         B3/Nnu1mCtCjxnQ8OpRZZPW9mRhEYZmYnh1VaXLU2n6sVT5usbIFV3Z4rG/0YqGSt
         2nAUNYYNLc6P2lPSzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1rdEf741BB-00gDAP; Fri, 10
 Nov 2023 11:32:29 +0100
Message-ID: <aec3897e-3ff6-4256-aaef-0cc1d5e7822a@gmx.net>
Date:   Fri, 10 Nov 2023 11:32:27 +0100
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
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IzaixV3E2I0i5t1/yCRO/F7ZOx4f22jelDHFErmexGp2So76fLm
 qGchW9n6Y7n4VcfVnzYZ9Q76G0it4uyBXRiskwszPHlafupQec5SaTifLZ6JM53IqXtUcm0
 mlvsfupldha0QGm1xUGTlXvyY1jADADgDEhorj2kJAbsRe4fNDEuk15Z0zyZS6dZdnjxgNr
 QMOsoDKCibG7m8582HQJg==
UI-OutboundReport: notjunk:1;M01:P0:KPsVdoqBSyc=;OYScNlUkAb5HvB19yahEro5NCPV
 KB4eXrPpk4Z6dou+rwTFoRLcU2ADdro155R9RjTQBfPGTIrQ2kpGdX0tHWU/h3VSrUox/VAnD
 82jg4CDk/ayNCc6gFyrcFATqn1eZc6nzVqlBX0ZfAXyXf3+x7pCzSUU7Kzm+wnKVXg9AG7Oeo
 T7DMjZDilgPdJZ2jm6IZ302jyddUM99iyGGE2JO1XsLYzKai1OHXl8LKOgWaNFpurUJL1OUXu
 qKXfmz+3guGevKD5Vu+6AM6s92j9CVA58qLEnd/lwU57JZ4DRLMTwG9T60f/XVaJsb+ew2JeY
 5w0ru73KJD8G7Q3zZ/kaLeLWb7t5Eftej3g0VY7hsyGmRfWELi5QZKxCExGAuI/QFcdrek/q7
 Em1pG5mZQQC8Cgn7Yv/EUe82cWyqAZ1e23cG3YVvW/KnWMhZbUbqTSKEdznAtAKDuO+XKmlYH
 Y+uWQ4B6txSNY97EGJ0ssLII92NV+ajVM+PdIBQuwxKuHMtshD0hsRXd3SblIjwCqEfJA2e1I
 +MjBE7xhBAZClh3P+s+grJXjXO5vL12a3PUMQr7CvY5ob6dt4Y2mdWviB9Cxd3WkAFByBwxIv
 Y0ANgej9laXnoE/bF0y0/3NgzTzmgLvkjyI7ccdnRNH8U1EsI/YRdN2UD3wQnRAMZ/UIzweUJ
 0bCm9APHG9JxhN8J4IQJIzOh1A3juTUQ0CA9HxtvyJCPe/6yAdWa7fliQq+d9kKzpZLO6qVrN
 5cNl9dEwr6HUVqVsYNIIivkDUKN9lrJ1jyDK87NXps86/1H3LWR6eC2IhcNkjo4TbjtInQUC6
 VBr7XStA3fe4qWAi/SwMg2FUfAztUdE4Ri8GIC8vmZd+3yZjvIJlT0YYAm2IYDlU9XMvTlSPH
 wiBh5r3aSaLe19C39tgUxEY/DmJmIeJ8mUD6IdbOcfCe7fZpZDXozFsnmM2axkKKREunLSNJv
 QHpTEA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:02 schrieb Umang Jain:
> This series aims to upport bcm2835-isp from the RPi kernel.
> It is developed on top of staging-next which comprises many
> VC04 changes for it's de-staging. Hence, the merge of this
> driver is targeted when VC04 is de-staged completely (which I
> have been pushing), but it can be helped getting reviewed meanwhile.
> Hence, the reason for posting the series.
>
> Patch (01-02)/15  adds a new driver named vc-sm-cma to handle memory sha=
ring
> with the VC4 VPU.
>
> Patch 03/15 adds a small extension to videobuf2 to allow exporting as a
> dma_buf instead of a file-descriptor.
>
> Patch (04-05)/15 adds a couple of improvements/support for
> bcm2835-isp(event callback and zero-copy) to vchiq-mmal.
>
> Patch (06-10)/15 adds the core bcm2835-isp driver along with headers
> and format defintions. 09/15 is a standalone patch which can be merged
> independently I believe.
>
> Patch (11-12)/15 deals with the colorspace support.
>
> Patch 13/15 allows multiple instances of the ISP.
>
> Patch 14/15 adds a admin-guide document on bcm2835-isp.
>
> Patch 15/15 deals with driver registeration.

since this is V2, i couldn't find a changelog? The first one was one
year ago, so it's very hard to remember. In such a case a link to the
last version is also helpful.

Recently i saw you have a Github account. For such a complex series it's
also very helpful to provide a link to a working test branch with this
series applied. It's not a must, but appreciated.

Best regards

>
> Dave Stevenson (6):
>    staging: vc04_services: Add new vc-sm-cma driver
>    media: videobuf2: Allow exporting of a struct dmabuf
>    staging: mmal-vchiq: Add support for event callbacks
>    staging: mmal-vchiq: Use vc-sm-cma to support zero copy
>    staging: mmal_vchiq: Add image formats to be used by bcm2835-isp
>    uapi: bcm2835-isp: Add bcm2835-isp uapi header file
>
> David Plowman (2):
>    vc04_services: bcm2835-isp: Allow formats with different colour space=
s
>    vc04_services: bcm2835-isp: Permit all sRGB colour spaces on ISP
>      outputs
>
> Naushir Patuck (4):
>    media: uapi: v4l2-core: Add ISP statistics output V4L2 fourcc type
>    staging: vc04_services: bcm2835-isp: Add a more complex ISP processin=
g
>      component
>    staging: vc04_services: bcm2835_isp: Allow multiple users
>    docs: admin-guide: media: bcm2835-isp: Add documentation for
>      bcm2835-isp
>
> Umang Jain (3):
>    staging: vc04_services: vchiq_arm: Register vcsm-cma driver
>    staging: vc04_services: Add helpers for vchiq driver data
>    staging: vc04_services: vchiq: Register bcm2835-isp
>
>   .../admin-guide/media/bcm2835-isp.rst         |  127 ++
>   .../userspace-api/media/drivers/index.rst     |    1 +
>   .../userspace-api/media/v4l/meta-formats.rst  |    1 +
>   .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     |   32 +
>   MAINTAINERS                                   |    9 +
>   .../media/common/videobuf2/videobuf2-core.c   |   36 +-
>   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>   drivers/staging/vc04_services/Kconfig         |    4 +
>   drivers/staging/vc04_services/Makefile        |    3 +-
>   .../staging/vc04_services/bcm2835-isp/Kconfig |   14 +
>   .../vc04_services/bcm2835-isp/Makefile        |    4 +
>   .../bcm2835-isp/bcm2835-isp-ctrls.h           |   72 +
>   .../bcm2835-isp/bcm2835-isp-fmts.h            |  559 +++++
>   .../bcm2835-isp/bcm2835-v4l2-isp.c            | 1822 +++++++++++++++++
>   .../interface/vchiq_arm/vchiq_arm.c           |    6 +
>   .../interface/vchiq_arm/vchiq_bus.h           |   10 +
>   .../staging/vc04_services/vc-sm-cma/Kconfig   |   10 +
>   .../staging/vc04_services/vc-sm-cma/Makefile  |    4 +
>   .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  817 ++++++++
>   .../staging/vc04_services/vc-sm-cma/vc_sm.h   |   54 +
>   .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  507 +++++
>   .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |   63 +
>   .../vc04_services/vc-sm-cma/vc_sm_defs.h      |  187 ++
>   .../vc04_services/vc-sm-cma/vc_sm_knl.h       |   28 +
>   .../staging/vc04_services/vchiq-mmal/Kconfig  |    1 +
>   .../vc04_services/vchiq-mmal/mmal-common.h    |    5 +
>   .../vc04_services/vchiq-mmal/mmal-encodings.h |   66 +
>   .../vc04_services/vchiq-mmal/mmal-msg.h       |   35 +
>   .../vchiq-mmal/mmal-parameters.h              |  165 +-
>   .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  253 ++-
>   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |    5 +
>   include/media/videobuf2-core.h                |   15 +
>   include/uapi/linux/bcm2835-isp.h              |  347 ++++
>   include/uapi/linux/v4l2-controls.h            |    5 +
>   include/uapi/linux/videodev2.h                |    1 +
>   35 files changed, 5235 insertions(+), 34 deletions(-)
>   create mode 100644 Documentation/admin-guide/media/bcm2835-isp.rst
>   create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-b=
cm2835-isp-stats.rst
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kconfig
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Makefile
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-i=
sp-ctrls.h
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-i=
sp-fmts.h
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-v=
4l2-isp.c
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Kconfig
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Makefile
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_v=
chi.c
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_v=
chi.h
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.=
h
>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
>   create mode 100644 include/uapi/linux/bcm2835-isp.h
>
