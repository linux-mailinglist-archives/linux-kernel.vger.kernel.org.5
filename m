Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12FD7EFFBC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjKRNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:11:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662DF127;
        Sat, 18 Nov 2023 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700313067; x=1700917867; i=wahrenst@gmx.net;
        bh=4GHN1I2o8mfnCqibdGh38n79/fp2eZe21rBwxEeuUcM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=nmrhzHE25VsoOqF67ebHXzcV4lJFtO0CAB4pez+TgcEfUkDcyrudHmTTOCWC7op0
         X7hOdpgU4QElx8d0KTQzBmmQyWxZhsdp1q5kG0NA241sHnigDvUkdrHmz5ZsaZj0R
         cC6pMTIxXJjAGZzY4a9yy8AWkJdxYXYXNYZ/wNEv+vYDQeJOZTBsSMHQtR1Sf+mam
         E9kv1iH+w3D3FLRqmOq8YxtUK1+g8SbmRfZAY8L78vbJD+tEVnqiuvq1A/9uslWh2
         CnLyx4sTq0lZ5iR/W0HTCpLitbgjQ5j8OK/9NEjeTFf4gYvxf4LLwnH3mT1itHOT2
         d4BrdveGYgtJhYmTFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1reUjX1MLU-00aSfu; Sat, 18
 Nov 2023 14:11:07 +0100
Message-ID: <6e06ee01-4ccb-4e34-bb6c-1d5fb8ab9e3c@gmx.net>
Date:   Sat, 18 Nov 2023 14:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] media: uapi: v4l2-core: Add ISP statistics
 output V4L2 fourcc type
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-8-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-8-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mok/l9H4EgXzDMAqsEorwz3K0kHDKvDb/+AnL3QpGrYz/nY00hc
 4aCZwPmkXHdl76/Z1rnjIqjrbckT9Rmh2h7dk5j0Peee9TJ2Rj586ed6MB2PV7am6I9R63w
 R1q9p3hmJjeaRNB/d4tQa9vPpWPdo7aNsO92rLfx8DYr+xSfbGBUB794XfKYna3lqZVN2z4
 lg+IG3QDUdR0B5gr7OHcA==
UI-OutboundReport: notjunk:1;M01:P0:j6sNYU9OcmM=;DfliXwKQeoFkn8/f/qSPj3kZOox
 BMy9OSdKXVRRE7EzKOeXkQpm4ePwEbeGqp7sj+t7DtGR44GaK7mYcJ/JYwGtTY4ZTSLKUZL0o
 rjx0kd2igRU9SzjJyhLQ+/TxeM/Bkyv4OhtnvEXjk40lucvxxKRuVZMi01KQ1KdIx7xwDdx2x
 TKGhKrYppQ5OlCXh1eHOsWFFVYPzcAxQAaufZ7GS6u8nvnx6TD5PrqI53NDl1E/mg70VJ4FsV
 B3I5sev1UrEf+Xx1yy9wwODSxPDmvOR6xJj7DYR6YAA8usvjRQ731VN8zTirT8Wxk4ZQC3eke
 7YChuNeLYmKry/GUmxePiAzk3yqPKB2PUVEVgyfwZetGtwnu8yr6baUBgckuwXyTWYvuTOGrL
 Ffda/Bd/4cRp4c+UtlZOjjoN2QCKv8WLiupv2I15z1gbuXXuyfgAtCcBJC1afCrDUuTn6ASL8
 L8qDeZLzwUylcX6pcAPrFRt0U4pS58djjM2Yhn2S5Zdn0YAf+uFimjl4w8JkQVYvha+0iwLwM
 MJ0Cs1Dul52mRmySmkQm0aT7LPznQBOXYPWsGEWZ+KN9IIMJQaUPObCd1w7n3eQtqZyhmIrKF
 GyghlHQgPfNtFTbaJzSmIFF+zxBIBg6ThS2j1wvvOUv/Prx2pBYvYyz1ZP3L2pMqSLUTQ3HXj
 GzrPngqlz1WHZCEK6FkxWSSo+TivyXEHqPBzA3VLauxRUm4iYtlIdYBcOETyIV8k3CuzmXZvc
 qpCQr6/aPxWTGH1WAuCrKpJ3GZQEVXu6CV80CeXxsqO7/Y4EESlIFWC4zd6ZAisO01227tCQh
 p+1lpp+AYXKQeiXWRBtJ/JK7ciU0yn6emrvGZJNezh+MnkrQowlQCPOodSE+QEc8/TwjNOUHR
 GmSZi2Ogdm2Gk08Efoub3kbwALqBfxBUPVcszE1gtggLSVx0/fV7QCWWGDpw7QqRmYvRu+gVJ
 82N9Ag==
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
> From: Naushir Patuck <naush@raspberrypi.com>
>
> Add V4L2_META_FMT_BCM2835_ISP_STATS V4L2 format type.
>
> This new format will be used by the bcm2835-isp device to return
> out ISP statistics for 3A.
>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../userspace-api/media/v4l/meta-formats.rst  |  1 +
>   .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     | 32 +++++++++++++++++++
>   drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>   include/uapi/linux/videodev2.h                |  1 +
>   4 files changed, 35 insertions(+)
>   create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-b=
cm2835-isp-stats.rst
>
> diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Do=
cumentation/userspace-api/media/v4l/meta-formats.rst
> index 919f595576b9..534542f235bc 100644
> --- a/Documentation/userspace-api/media/v4l/meta-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
> @@ -12,6 +12,7 @@ These formats are used for the :ref:`metadata` interfa=
ce only.
>   .. toctree::
>       :maxdepth: 1
>
> +    pixfmt-meta-bcm2835-isp-stats
>       metafmt-d4xx
>       metafmt-intel-ipu3
>       metafmt-rkisp1
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-i=
sp-stats.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-i=
sp-stats.rst
> new file mode 100644
> index 000000000000..2219235e0ecb
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stat=
s.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +.. _v4l2-meta-fmt-bcm2835-isp-stats:
> +
> ++*****************************************
> +V4L2_META_FMT_BCM2835_ISP_STATS  ('BSTA')
> +*****************************************
> +
> +BCM2835 ISP Statistics
> +
> +Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The BCM2835 ISP hardware calculate image statistics for an input Bayer =
frame.
> +These statistics are obtained from the "bcm2835-isp0-capture3" device n=
ode
> +using the :c:type:`v4l2_meta_format` interface. They are formatted as d=
escribed
> +by the :c:type:`bcm2835_isp_stats` structure below.
> +
> +.. code-block:: c
> +
> +       #define DEFAULT_AWB_REGIONS_X 16
> +       #define DEFAULT_AWB_REGIONS_Y 12
> +
> +       #define NUM_HISTOGRAMS 2
> +       #define NUM_HISTOGRAM_BINS 128
> +       #define AWB_REGIONS (DEFAULT_AWB_REGIONS_X * DEFAULT_AWB_REGIONS=
_Y)
> +       #define FLOATING_REGIONS 16
> +       #define AGC_REGIONS 16
> +       #define FOCUS_REGIONS 12
> +
> +.. kernel-doc:: include/uapi/linux/bcm2835-isp.h
> +   :functions: bcm2835_isp_stats_hist bcm2835_isp_stats_region
> +                    bcm2835_isp_stats_focus bcm2835_isp_stats
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-c=
ore/v4l2-ioctl.c
> index 7f29886568b8..6f0f0f6526c9 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1463,6 +1463,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *=
fmt)
>   	case V4L2_META_FMT_GENERIC_CSI2_20:	descr =3D "8b Generic Meta, 20b C=
SI-2"; break;
>   	case V4L2_META_FMT_GENERIC_CSI2_24:	descr =3D "8b Generic Meta, 24b C=
SI-2"; break;
>   	case V4L2_META_FMT_GENERIC_CSI2_2_24:	descr =3D "2x8b Generic Meta, 2=
4b CSI-2"; break;
> +	case V4L2_META_FMT_BCM2835_ISP_STATS: descr =3D "BCM2835 ISP Image Sta=
tistics"; break;

tab instead of space?

>
>   	default:
>   		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videode=
v2.h
> index 85b60199c618..eddaea8598db 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -836,6 +836,7 @@ struct v4l2_pix_format {
>   #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* U=
VC Payload Header metadata */
>   #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D=
4XX Payload Header metadata */
>   #define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid=
 Metadata */
> +#define V4L2_META_FMT_BCM2835_ISP_STATS v4l2_fourcc('B', 'S', 'T', 'A')=
 /* BCM2835 ISP image statistics output */

Shouldn't this go to the vendor specific ones?

>
>   /* Vendor specific - used for RK_ISP1 camera sub-system */
>   #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /=
* Rockchip ISP1 3A Parameters */
