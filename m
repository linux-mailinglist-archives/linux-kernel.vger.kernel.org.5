Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4841A7D998E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjJ0NSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:18:20 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EAC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:18:16 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5af5b532d8fso10010597b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1698412696; x=1699017496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIgNvw60oeEsfoSUoIe8lWjvPgDk1w/uAWEIi4AcBPA=;
        b=cHrxg07kga5vqf4vQV3bJWOIz22gYrDCQUw0iG+PElsib31NDnM40xs0+3yl4s/VmE
         zUqKq3YXJFg/DZxPmzCf7hYtBrRbDgEY/AkcJyfXgqCWzwrZhDEc3SalHfrgZWx6LPTF
         NZAokv86uzrNoyIbOaQS7LxjL/AU3ZRcKu2A9LTRtkBzyRXvBh/ufkx1Pcdelx/VT1RK
         Lpxj36ChFZiQ89BIdZYQSmuH8Vwft0s99S4uNDI8/BiK1Acur8CvpN3hSEX/gGzsWT37
         T5Ej+m4jRb94RVes2HH6IwNanRDuJCAUy/dhDzveegiSvCoWgoFr3TzLhMnIy+yK2fJl
         F6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412696; x=1699017496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIgNvw60oeEsfoSUoIe8lWjvPgDk1w/uAWEIi4AcBPA=;
        b=VmyKnE1sV+vZKwfhkJmUmpUXiuQv6xp/7Byfu7on8miIC5FebHeFjypFEq1ka9x/X5
         EqWzRNdQwMWnrYC4Zl/NyoYez+KBAn8PG/O5exQ5dq/mPiYuElfhhZ0IEQQViNHcAXcA
         VAlXi14hnPKyF7Mwtl+mHPru8WRmIlSGbhu8kstkbFcGujFxB1/fNSfwcDyyRBp+8oBU
         VPxEOd5BG2eeJRqA1bIWuuZ0USrWTpWjgeGQzcS9IwRgeeK04iaFLjoVBNzF55zz9DjR
         ifATvpjw2mvg7qx9y3apN5V1Q9PzUUUiSK8VYG8ShKAfVoj1exWieq+CEyZvOfTi6tjG
         pMBg==
X-Gm-Message-State: AOJu0Yy69gjl8i0YrzT3ofZxSogKjFsYYhbSDvCTqxKcwDLilxZ5vEE6
        amArJU3VStMwm4vvOADddrYMGbJpRLenfg/+TIY1MZtUqzja8dDxlnk=
X-Google-Smtp-Source: AGHT+IFUpSieQPfq/ddu+vXmX/G57S5/wkIbZOhNGHuaZs2Zp0+f6Wnqu9Nz/VFwkyAep+9f66teCvVcb97UPE2ui8s=
X-Received: by 2002:a81:e40e:0:b0:5a7:ba54:af02 with SMTP id
 r14-20020a81e40e000000b005a7ba54af02mr2450824ywl.38.1698412696065; Fri, 27
 Oct 2023 06:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-4-b33f1bbd1fcf@apitzsch.eu> <56kgwl7zehsxy2pp7nziwk2gt6joax42qpzs6eywufvcto7qxm@ts4i3ccdokjr>
 <f5475c4f90e52817349e4842984bb3657b1e500d.camel@apitzsch.eu>
 <3opzxxkqa4p6wxddx7bdf2dixphfuo4xunaaiqibvtppmyz6gr@vjxbtjjqiqvy>
 <CAPY8ntC4TNkxuG9S8Lo-fmMcCSF39tCT_W2oO1KHHj5Fg6B0VQ@mail.gmail.com> <san47wekkcw24q34dx2sagph3kkxqaqayxzsd5v6iodp34yc5v@rpkxeirikc4e>
In-Reply-To: <san47wekkcw24q34dx2sagph3kkxqaqayxzsd5v6iodp34yc5v@rpkxeirikc4e>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 27 Oct 2023 14:17:59 +0100
Message-ID: <CAPY8ntA0VWjj2q47sd2AwixjYKrzgP4KddoeDkPyqOepb+4JFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: i2c: imx214: Add sensor's pixel matrix size
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo

On Fri, 27 Oct 2023 at 12:12, Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Dave
>
> On Fri, Oct 27, 2023 at 11:29:11AM +0100, Dave Stevenson wrote:
> > Hi Jacopo
> >
> > On Fri, 27 Oct 2023 at 09:57, Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com> wrote:
> > >
> > > Hi Andre'
> > >
> > > On Wed, Oct 25, 2023 at 11:26:00PM +0200, Andr=C3=A9 Apitzsch wrote:
> > > > Hi Jacopo,
> > > >
> > > > Am Dienstag, dem 24.10.2023 um 09:52 +0200 schrieb Jacopo Mondi:
> > > > > Hi Andre'
> > > > >
> > > > > On Mon, Oct 23, 2023 at 11:47:53PM +0200, Andr=C3=A9 Apitzsch wro=
te:
> > > > > > Set effictive and active sensor pixel sizes as shown in product
> > > > >
> > > > > s/effictive/effective
> > > > >
> > > > > > brief[1].
> > > > > >
> > > > > > [1]:
> > > > > > https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_2015=
0428-1289331.pdf
> > > > > >
> > > > > > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> > > > > > ---
> > > > > >  drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++=
++--
> > > > > > -----
> > > > > >  1 file changed, 32 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/i2c/imx214.c
> > > > > > b/drivers/media/i2c/imx214.c
> > > > > > index bef8dc36e2d0..a2d441cd8dcd 100644
> > > > > > --- a/drivers/media/i2c/imx214.c
> > > > > > +++ b/drivers/media/i2c/imx214.c
> > > > > > @@ -36,6 +36,14 @@
> > > > > >  #define IMX214_EXPOSURE_STEP             1
> > > > > >  #define IMX214_EXPOSURE_DEFAULT          0x0c70
> > > > > >
> > > > > > +/* IMX214 native and active pixel array size */
> > > > > > +#define IMX214_NATIVE_WIDTH              4224U
> > > > > > +#define IMX214_NATIVE_HEIGHT             3136U
> > > > > > +#define IMX214_PIXEL_ARRAY_LEFT          8U
> > > > > > +#define IMX214_PIXEL_ARRAY_TOP           8U
> > > > > > +#define IMX214_PIXEL_ARRAY_WIDTH 4208U
> > > > > > +#define IMX214_PIXEL_ARRAY_HEIGHT        3120U
> > > > > > +
> > > > >
> > > > > I do get slightly different numbers from the datasheet version I =
have
> > > > >
> > > > > The sensor is said to have 4224x3208 total pixels of which 4208x3=
120
> > > > > are active ones.
> > > > >
> > > > > The pixel array diagram shows 64 "OPB" (optically black ?) lines,
> > > > > followed by 8 dummy lines, followed by 3120 valid lines. There ar=
e 8
> > > > > dummy columns at each side of the 4208 valid ones.
> > > > >
> > > > > Now, NATIVE which represents the full pixel array size seems to b=
e
> > > > > 4224x3208 (other parts of the datasheet only report 3200 lines
> > > > > though)
> > > > >
> > > > > BOUNDS represents the readabale array area, which I presume
> > > > > corresponds to what is named as 'effective area' by the datasheet=
. It
> > > > > excludes the OPB lines at the top of the image and seems to be
> > > > > represented by (0, 64, 4224, 3160).
> > > > >
> > > > > CROP_DEFAULT represents the default crop rectangle which covers t=
he
> > > > > active pixel area, so it excludes 8 more lines of dummy pixels an=
d 8
> > > > > dummy columns, which gives a rectangle (8, 72, 4208, 3120)
> > > > >
> > > > > Also note that the driver always reports a TGT_CROP rectangle wit=
h
> > > > > top/left points set to 0. If my understanding is correct, V4L2
> > > > > selection targets are defined from the most external target
> > > > > (TGT_NATIVE in this case), and the driver should be corrected to
> > > > > initialize the crop rectangle with a top-left corner at (8, 72).
> > > > >
> > > > > Does this make sense ?
> > > >
> > > > As far as I understood, only the effective and active sizes of thre=
e
> > > > sizes provided in the datasheet (total, effective and active) matte=
r.
> > > > By comparing the values used in imx219.c (and imx415.c) with the on=
es
> > > > in the corresponding datasheets [1,2] I assume, that "effective"
> > > > matches "NATIVE_SIZE", "active" matches "CROP_DEFAULT" and "total" =
is
> > > > ignored.
> > >
> > > imx219 driver indeed does not consider the OPB areas in the definitio=
n
> > > of the rectangles...
> > >
>
> I know it sounds ridiculous as I've been the one adding selection
> support to imx219, but I presume we discussed it somewhen in the past:
> do you happen to remember why we left the OPB area out from the native
> sizes ? (Does OPB stand for "Optically black" ? )

Yes, OPB is Optical Black. Optically black pixels can be used for
subtracting dark noise from pixels.
OPB lines are often sent on a totally separate CSI-2 data type, so
they will generally not apply to the image buffer that is read out.
See IMX290/462 for an example of that (it uses data type 0x37)
I believe some other sensors use the OPB internally to perform
compensation on-sensor.

I've never fully followed what the full selection API is meant to be
used for beyond determining which parts of the array are cropped out
in particular modes. It's numbers that I extract from the datasheet,
stick in the driver, and the user can do something with them if they
wish.

> > > Also looking at the X/Y_ADDR_START value assigned in the register tab=
les
> > > for full resolution mode (3280x2462) they have value of 0, indeed
> > > meaning the active area is the only readable one.
> > >
> > > Then yes, you're right, for imx219
> > > NATIVE =3D effective
> > > CROP_DEFAULT =3D BOUND =3D active
> > >
>
> I presume you can confirm this, right ?

Sounds about right.

> > > > The commit message of 1ed36ecd1459b653cced8929bfb37dba94b64c5d ("me=
dia:
> > > > i2c: imx219: Selection compliance fixes") seems to support me here:
> > >
> > > >
> > > > > The top/left crop coordinates of the TGT_CROP rectangle were set =
to
> > > > > (0, 0) instead of (8, 8) which is the offset from the larger phys=
ical
> > > > > pixel array rectangle.
> > > >
> > > > This (8, 8) is half the difference between number of effective and
> > > > active pixels of imx219[1].
> > > >
> > > > Together with the 8 dummy lines and 8 dummy columns you mentioned, =
I
> > > > still think my values are right. But I've just started working with
> > > > V4L2, so I might be wrong.
> > >
> > > To actually verify if the 'effective area' is readable or not, we
> > > should know what register controls the X/Y_ADDR_START value, and
> > > that's an information I don't have in my version of the datasheet.
> >
> > I happen to have an IMX214 datasheet.
> > X_ADDR_START is 0x0344/5 (set in multiples of 2)
> > Y_ADDR_START is 0x0346/7 (set in multiples of 4)
> > X_ADDR_END is 0x0348/9 (set in multiples of 2)
> > Y_ADDR_END is 0x034a/b (set in multiples of 4)
> > X_OUTPUT_SIZE 0x034c/d
> > Y_OUTPUT_SIZE 0x034e/f
> >
> > X direction are 13bit values, Y direction are 12 bit.
> > [12:8] or [11:8] in the low bits of the first register, [7:0] in the
> > second register.
>
> AH thanks! Unfortunately the largest imx214 mode is cropped from full
> pixel array it seems, so not that helpful :(

Yup, I noticed that too. Make the selection reflect the register set -
it's all you can do.

I don't know why it got cropped down so much to make a 16:9 full res
mode. Possibly a limit of 4096 on an ISP or receiver somewhere, or
potentially just the use case.
I guess there's nothing stopping an extra mode being added which uses
the full sensor array.

  Dave

> >
> >   Dave
> >
> > > It's however plausible that it behaves the same as imx219, as the
> > > driver's register sequences seems to program the crop sizes in
> > > register 0x034c and 0x034e and there's not programmed top-left corner
> > > there.
> > >
> > > Ok then, let's be consistent and do the same as imx219 as you're doin=
g
> > > here.
> > >
> > > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > >
> > > >
> > > > Could you share the imx214 datasheet with me?
> > > >
> > > > Best regards,
> > > > Andr=C3=A9
> > > >
> > > > [1] https://www.arducam.com/downloads/modules/RaspberryPi_camera/IM=
X219DS.PDF
> > > > [2] https://www.sony-semicon.com/files/62/pdf/p-12_IMX415-AAQR_AAMR=
_Flyer.pdf
> > > > >
> > > > > Thanks
> > > > >   j
> > > > >
> > > > >
> > > > > >  static const char * const imx214_supply_name[] =3D {
> > > > > >   "vdda",
> > > > > >   "vddd",
> > > > > > @@ -634,14 +642,31 @@ static int imx214_get_selection(struct
> > > > > > v4l2_subdev *sd,
> > > > > >  {
> > > > > >   struct imx214 *imx214 =3D to_imx214(sd);
> > > > > >
> > > > > > - if (sel->target !=3D V4L2_SEL_TGT_CROP)
> > > > > > -         return -EINVAL;
> > > > > > + switch (sel->target) {
> > > > > > + case V4L2_SEL_TGT_CROP:
> > > > > > +         mutex_lock(&imx214->mutex);
> > > > > > +         sel->r =3D *__imx214_get_pad_crop(imx214, sd_state,
> > > > > > sel->pad,
> > > > > > +                                         sel->which);
> > > > > > +         mutex_unlock(&imx214->mutex);
> > > > > > +         return 0;
> > > > > >
> > > > > > - mutex_lock(&imx214->mutex);
> > > > > > - sel->r =3D *__imx214_get_pad_crop(imx214, sd_state, sel-
> > > > > > >pad,
> > > > > > -                                 sel->which);
> > > > > > - mutex_unlock(&imx214->mutex);
> > > > > > - return 0;
> > > > > > + case V4L2_SEL_TGT_NATIVE_SIZE:
> > > > > > +         sel->r.top =3D 0;
> > > > > > +         sel->r.left =3D 0;
> > > > > > +         sel->r.width =3D IMX214_NATIVE_WIDTH;
> > > > > > +         sel->r.height =3D IMX214_NATIVE_HEIGHT;
> > > > > > +         return 0;
> > > > > > +
> > > > > > + case V4L2_SEL_TGT_CROP_DEFAULT:
> > > > > > + case V4L2_SEL_TGT_CROP_BOUNDS:
> > > > > > +         sel->r.top =3D IMX214_PIXEL_ARRAY_TOP;
> > > > > > +         sel->r.left =3D IMX214_PIXEL_ARRAY_LEFT;
> > > > > > +         sel->r.width =3D IMX214_PIXEL_ARRAY_WIDTH;
> > > > > > +         sel->r.height =3D IMX214_PIXEL_ARRAY_HEIGHT;
> > > > > > +         return 0;
> > > > > > + }
> > > > > > +
> > > > > > + return -EINVAL;
> > > > > >  }
> > > > > >
> > > > > >  static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,
> > > > > >
> > > > > > --
> > > > > > 2.42.0
> > > > > >
> > > >
