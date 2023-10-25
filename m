Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453EE7D67A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjJYJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJYJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:54:34 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00F111;
        Wed, 25 Oct 2023 02:54:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C86CE40007;
        Wed, 25 Oct 2023 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698227669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ue9fksc6JsU6rXn/oUi3QGX/JVmnoh6QcrIM7P8TVhA=;
        b=Y52fu9RnEPBBo8uvIPN8hebEcoTp/3oe+PqAiJm+NyBQ36JnHrYWCdLHOQFlOCme0itRSn
        5Kk+vKskSKzJxkAhll8b2geIK6m10ws0rHvJ+3updaNW9hQ/wD3xM1QPVL7jJjDV7+IsuN
        +YWTtLq0n4GUfGXEOaOhkYs7a85YJUUo9PF+qpMZnnQZksRHph/oM6HA3ZYgwWuAx1bVZw
        KjnIaJdo6M33ERPoUTxw6tpcnh8WbnGzix43lG1Ka/+sdQtIlhmpDhZSypOTy6g5sNpwde
        kKwqyJdi4AqE76Nm1+JJyXsrJc4DWBWx9aM83KYm1kKZv00fF1IrRI51cti/oA==
Date:   Wed, 25 Oct 2023 11:54:27 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v8 0/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZTjl0xJMTqZfO2Xf@aptenodytes>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <ZTFMR7PlcQXpeoQO@aptenodytes>
 <11cccad3-e665-41dc-89c2-5ddc22b1e2fe@wolfvision.net>
 <ZTjVOAPnXEj9LgOE@aptenodytes>
 <5438a194-7349-4a20-84d0-efe88b7ab396@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tk2Boi110X16vYew"
Content-Disposition: inline
In-Reply-To: <5438a194-7349-4a20-84d0-efe88b7ab396@wolfvision.net>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URI_HEX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tk2Boi110X16vYew
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael,

On Wed 25 Oct 23, 11:17, Michael Riesch wrote:
> Hi Paul,
>=20
> On 10/25/23 10:43, Paul Kocialkowski wrote:
> > [...]
> >>> Here is the detail of my research on the concerned chips. The + at th=
e beginning
> >>> of the line indicate support in Rockchip's 4.4 tree:
> >>>
> >>> - RK3566/RK3568 (2020): CIF pins + VICAP terminology
> >>> + RK1808 (2019): CIF pins + VIP registers + VIP_MIPI registers
> >>> + PX30 (2017): VIP pins + VIP registers
> >>> + RK3328 (2017): CIF pins + VIP terminology
> >>> - RK3326 (2017): CIF pins + VIP terminology
> >>> - RK3399 (2016): CIF pins
> >>> - RK3368 (2015): CIF pins
> >>> - PX2 (2014-11): CIF pins + CIF registers
> >>> + RK3126/RK3128 (2014-10): CIF pins + registers
> >>> + RK3288 (2014-05): CIF pins + VIP terminology
> >>> - RK3026 (2013): CIF pins + CIF registers
> >>> - RK3168/RK3188/PX3 (2012): CIF pins + CIF registers
> >>> - RK3066 (2012): CIF pins + CIF registers
> >>>
> >>> Note that there are a few variations over time (added/removed registe=
rs), but
> >>> the offsets of crucial registers are always the same, so we can safely
> >>> assume this is the same unit in different generations.
> >>>
> >>> Since the RK3066 is the first model starting the RK30 lineup I think =
we can
> >>> safely use that for the "base" compatible to be used for e.g. the bin=
dings
> >>> document, instead of px30 which is just one of the many SoCs that use=
 this unit.
> >>
> >> Once the name of the driver is defined and adjusted in v9, I can try to
> >> give the series a shot on my RK3568 board. First attempts to do so
> >> basing on Maxime's v5 showed that with a few modifications the DVP
> >> feature works fine. In a subsequent step, we could discuss the inclusi=
on
> >> of the MIPI CSI-2 things in order to keep the driver sufficiently gene=
ral.
> >=20
> > Nice! I guess there will be a need to introduce a variant structure ass=
ociated
> > to each compatible to express the differences betweens these different
> > generations.
>=20
> Indeed. If Mehdi and you suggest something, I'd be happy to review.

Well the be honest the scope of work on our side is really centered on PX30
and merging this first version.

> Otherwise, I'll try to come up with something reasonable. IMHO it would
> make sense (as a first step) to have the clocks and the resets in this
> structure, as well as a sub-structure that describes the DVP. The latter
> consists of registers mainly, but maybe supported input/output formats
> and other things should go in there as well. Also, downstream code has a
> significant number of
>     if (some condition including chip_id) A; else B;
> things that we should probably get rid of with this variant structure.

Indeed I think we want to try avoid that. Another common option is to define
capability flags to represent differences between generations in a more
practical and clean way than explicitly checking chip ids or so.

> As next step, a sub-structure for MIPI CSI-2 could be defined. RK356X
> will have one of those, RK3588 will feature even six of them. So we
> should add a const array to the variant structure.
>=20
> > Note that we will also probably need to convert the driver over to a MC=
-centric
> > approach, but this is of course outside of the scope of this series.
>=20
> That would absolutely make sense. What is missing, though? (I was
> wondering that the driver calls media_device_(un)register but no
> /dev/mediaX device pops up.)

Switching from video node-centric to MC-centric is more of a semantic chang=
e.
In the first case we expect that subdevs are configured by the video device
driver and userspace is not expected to change anything in the media topolo=
gy
or to configure media entities explicitly.

In the latter case it's the opposite : the driver should never try to push
configuration to a subdev and should instead validate that the current
configuration makes sense.

Still, I believe should be a media device registered and visible to userspa=
ce.
Mehdi could you take a look at this? Do you see a media device in `media-ct=
l -p`
and /dev/mediaX?

Cheers,

Paul

> Best regards,
> Michael
>=20
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
> >> @Mehdi: If you could Cc: me when you send out v9 it'd be much apprecia=
ted.
> >>
> >> Best regards,
> >> Michael
> >>
> >> [0]
> >> https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/med=
ia/platform/rockchip/cif/hw.c#L968
> >>
> >>>
> >>>> This version of the driver supports ONLY the parallel interface BT656
> >>>> and was tested/implemented using an SDTV video decoder
> >>>>
> >>>> media_tree, base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235
> >>>>
> >>>> V7 =3D> V8:
> >>>> vip/capture.c:
> >>>> - fixed a warning: unused variable reported by the kernel test robot
> >>>>
> >>>> V6 =3D> V7:
> >>>> vip/capture.c vip/dev.c vip/dev.h
> >>>> - renamed all struct rk_vip_dev dev =3D> struct rk_vip_dev vip_dev
> >>>> - added some error when rk_vip_get_buffer() returns NULL
> >>>> - removed a WARN_ON
> >>>> - made the irq NOT shared
> >>>> - dropped of_match_ptr
> >>>> - added the rk_vip_get_resource() function
> >>>>
> >>>> rockchip,px30-vip.yaml:
> >>>> - changed filename to match the compatible
> >>>> - dropped the mention of the other rockchip SoC in the dt-binding
> >>>>   description and added a more detailed description of VIP
> >>>> - removed unused labels in the example
> >>>>
> >>>>
> >>>> V5 [1] =3D> V6:
> >>>> vip/capture.c vip/dev.c vip/dev.h
> >>>> - added a video g_input_status subdev call, V4L2_IN_CAP_STD and the
> >>>>   supported stds in rk_vip_enum_input callback
> >>>> - added rk_vip_g_std, rk_vip_s_std and rk_vip_querystd callbacks
> >>>> - added the supported video_device->tvnorms
> >>>> - s_std will now update the format as this depends on the standard
> >>>>   NTSC/PAL (as suggested by Hans in [1])
> >>>> - removed STD_ATSC
> >>>> - moved the colorimetry information to come from the subdev
> >>>> - removed the core s_power subdev calls
> >>>> - dropped cropping in rk_vip_stream struct
> >>>>
> >>>> rockchip-vip.yaml:
> >>>> - fixed a mistake in the name of third clock plckin -> plck
> >>>> - changed the reg maxItems 2 -> 1
> >>>>
> >>>> [1] https://lore.kernel.org/linux-media/20201229161724.511102-1-maxi=
me.chevallier@bootlin.com/
> >>>>
> >>>> I used v4l-utils with HEAD: commit 1ee258e5bb91a12df378e19eb255c5219=
d6bc36b
> >>>>
> >>>> # v4l2-compliance=20
> >>>> v4l2-compliance 1.25.0, 64 bits, 64-bit time_t
> >>>>
> >>>> Compliance test for rk_vip device /dev/video0:
> >>>>
> >>>> Driver Info:
> >>>>         Driver name      : rk_vip
> >>>>         Card type        : rk_vip
> >>>>         Bus info         : platform:ff490000.vip
> >>>>         Driver version   : 6.6.0
> >>>>         Capabilities     : 0x84201000
> >>>>                 Video Capture Multiplanar
> >>>>                 Streaming
> >>>>                 Extended Pix Format
> >>>>                 Device Capabilities
> >>>>         Device Caps      : 0x04201000
> >>>>                 Video Capture Multiplanar
> >>>>                 Streaming
> >>>>                 Extended Pix Format
> >>>> Media Driver Info:
> >>>>         Driver name      : rk_vip
> >>>>         Model            : rk_vip
> >>>>         Serial           :=20
> >>>>         Bus info         : platform:ff490000.vip
> >>>>         Media version    : 6.6.0
> >>>>         Hardware revision: 0x00000000 (0)
> >>>>         Driver version   : 6.6.0
> >>>> Interface Info:
> >>>>         ID               : 0x03000002
> >>>>         Type             : V4L Video
> >>>> Entity Info:
> >>>>         ID               : 0x00000001 (1)
> >>>>         Name             : video_rkvip
> >>>>         Function         : V4L2 I/O
> >>>>         Pad 0x01000004   : 0: Sink
> >>>>           Link 0x02000009: from remote pad 0x1000006 of entity 'tw99=
00 2-0044' (Digital Video Decoder): Data, Enabled
> >>>>
> >>>> Required ioctls:
> >>>>         test MC information (see 'Media Driver Info' above): OK
> >>>>         test VIDIOC_QUERYCAP: OK
> >>>>         test invalid ioctls: OK
> >>>>
> >>>> Allow for multiple opens:
> >>>>         test second /dev/video0 open: OK
> >>>>         test VIDIOC_QUERYCAP: OK
> >>>>         test VIDIOC_G/S_PRIORITY: OK
> >>>>         test for unlimited opens: OK
> >>>>
> >>>> Debug ioctls:
> >>>>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >>>>         test VIDIOC_LOG_STATUS: OK (Not Supported)
> >>>>
> >>>> Input ioctls:
> >>>>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>>>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >>>>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >>>>         test VIDIOC_G/S/ENUMINPUT: OK
> >>>>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >>>>         Inputs: 1 Audio Inputs: 0 Tuners: 0
> >>>>
> >>>> Output ioctls:
> >>>>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>>>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >>>>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >>>>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >>>>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> >>>>
> >>>> Input/Output configuration ioctls:
> >>>>         test VIDIOC_ENUM/G/S/QUERY_STD: OK
> >>>>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >>>>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >>>>         test VIDIOC_G/S_EDID: OK (Not Supported)
> >>>>
> >>>> Control ioctls (Input 0):
> >>>>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
> >>>>         test VIDIOC_QUERYCTRL: OK (Not Supported)
> >>>>         test VIDIOC_G/S_CTRL: OK (Not Supported)
> >>>>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
> >>>>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
> >>>>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >>>>         Standard Controls: 0 Private Controls: 0
> >>>>
> >>>> Format ioctls (Input 0):
> >>>>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >>>>         test VIDIOC_G/S_PARM: OK (Not Supported)
> >>>>         test VIDIOC_G_FBUF: OK (Not Supported)
> >>>>         test VIDIOC_G_FMT: OK
> >>>>         test VIDIOC_TRY_FMT: OK
> >>>>         test VIDIOC_S_FMT: OK
> >>>>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >>>>         test Cropping: OK (Not Supported)
> >>>>         test Composing: OK (Not Supported)
> >>>>         test Scaling: OK (Not Supported)
> >>>>
> >>>> Codec ioctls (Input 0):
> >>>>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> >>>>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >>>>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> >>>>
> >>>> Buffer ioctls (Input 0):
> >>>>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >>>>         test VIDIOC_EXPBUF: OK
> >>>>         test Requests: OK (Not Supported)
> >>>>
> >>>> Total for rk_vip device /dev/video0: 46, Succeeded: 46, Failed: 0, W=
arnings: 0
> >>>>
> >>>> Mehdi Djait (3):
> >>>>   media: dt-bindings: media: add bindings for Rockchip VIP
> >>>>   media: rockchip: Add a driver for Rockhip's camera interface
> >>>>   arm64: dts: rockchip: Add the camera interface
> >>>>
> >>>>  .../bindings/media/rockchip,px30-vip.yaml     |   93 ++
> >>>>  arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
> >>>>  drivers/media/platform/rockchip/Kconfig       |    1 +
> >>>>  drivers/media/platform/rockchip/Makefile      |    1 +
> >>>>  drivers/media/platform/rockchip/vip/Kconfig   |   14 +
> >>>>  drivers/media/platform/rockchip/vip/Makefile  |    3 +
> >>>>  drivers/media/platform/rockchip/vip/capture.c | 1210 ++++++++++++++=
+++
> >>>>  drivers/media/platform/rockchip/vip/dev.c     |  346 +++++
> >>>>  drivers/media/platform/rockchip/vip/dev.h     |  163 +++
> >>>>  drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
> >>>>  10 files changed, 2103 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/media/rockchip=
,px30-vip.yaml
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/Kconfig
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/Makefile
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/capture.c
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.c
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.h
> >>>>  create mode 100644 drivers/media/platform/rockchip/vip/regs.h
> >>>>
> >>>> --=20
> >>>> 2.41.0
> >>>>
> >>>
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Tk2Boi110X16vYew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmU45dMACgkQ3cLmz3+f
v9FKMwf+MU+Rv/Pn3i87jNJbb0dUu//jVymcgDV3RC9dKXQk0/fBsVi/EcUo1C2C
40AjG+OHAdvIOhRwUGDPc8rCXBNAkoJmlhfsvjt5XbOAsJMAY9Cb7vEXRxRZjTqz
QQ/GV55dCYS/t4umCkpNMELtYtiAT/PEQYr6Xlb6G1wwgpD//cogsa5/g3tS7Ej6
5VjUlU1RtoKh4tAxX+HlS+Of7Uc+o0oy2TmivNHHxiEQU//yn/79V2yPztaMcmwK
fHHkNj+IB0p9kBD9Jy95Cd0Xe/ea5LJdM1w+3y0TUPOwdM+WREEARyvBW5xrZatH
VGBXP/x6jrvgvtOKvr5BoUl9KFDwjQ==
=R7H9
-----END PGP SIGNATURE-----

--Tk2Boi110X16vYew--
