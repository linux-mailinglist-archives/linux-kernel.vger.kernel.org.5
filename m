Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2817D9541
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjJ0K3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0K3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:29:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61461121
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:29:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84c24a810dso1321017276.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1698402567; x=1699007367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZn35aVvF3CpjghTrj9bHg72KmEjxE0DqCJaX7l42PE=;
        b=nGza0flxlzjhcKgbud1O5pKSEQHn41hCTWNZVQUyVORiH9aE2Ok6zbFNzGqZABqDPC
         DnJBpQgBCGCkZsaH/O3F6wxpYzmITh+IzGhQF2eumM7wIBvipt2tb1oTmY7iOlAZLHX6
         TSxRCqjZ7emSdnT9T76JFO9uI2k7nlsJRmrNnh8FgTQzUaKWlF1EuE6TRn8aQu9vXAMV
         gEMOXTGk5LCJsPcUUX8WUkf9bmrrT66i8JnLF1iMBaggogCjni1lzAiug6h7CQKb4l+a
         tUd0Y60odND8OjnZHeYe1otfLhTqTL8zzrT9rv2EMRj6TsvToiiXHkGI42Vo7yhfv609
         P86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698402567; x=1699007367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZn35aVvF3CpjghTrj9bHg72KmEjxE0DqCJaX7l42PE=;
        b=MHHVku8xVmQ1NPucojF3ZTaxcBtCGoPyGJh1da4q8oWWmh0xiZ/qA9Oih8/CMhtbP1
         n5uSMRggsEkAuOxroCU+THLuxKcJCOe9OPKqKPqwGmI5Bf5c0V0Y9TujTCfldvxij36R
         wWck8NWEcobvLoLQ17qiTl0sWZOQ5ebilxZ7xrHdJf6YxHMT26g553AIsKqg9gWYg1vw
         +vbBXp3kZzdHpirMLWjURP/3KoIhe9KCp9i9J67ZrKimU6YNrof/y3iD+eu8YsOAqpeT
         /KwAJBLXL/oresIxlF7tx4TDSWRyYrSqeqCIpqNqviKREtLvdobF2Hm7Ao5jgJbY/tX4
         jtgg==
X-Gm-Message-State: AOJu0YwEHmbBkLGzosNIxIle3kE+/P07+Lova/0V1ThY57ThwjZZANVd
        yV8f0palmmol7xcMtWNTbcqRQlLMSKVqjpXCgO2NBQ==
X-Google-Smtp-Source: AGHT+IH6ieb+syT5dPw1WbBin1rbO2JFj4W2olI8NDRlCgEsq54ZdAk9RzcGRrD0qzoNEIOqZAJnNOEgMa3aY9X8g5M=
X-Received: by 2002:a25:4097:0:b0:d9b:ff50:b100 with SMTP id
 n145-20020a254097000000b00d9bff50b100mr1855215yba.28.1698402567578; Fri, 27
 Oct 2023 03:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-4-b33f1bbd1fcf@apitzsch.eu> <56kgwl7zehsxy2pp7nziwk2gt6joax42qpzs6eywufvcto7qxm@ts4i3ccdokjr>
 <f5475c4f90e52817349e4842984bb3657b1e500d.camel@apitzsch.eu> <3opzxxkqa4p6wxddx7bdf2dixphfuo4xunaaiqibvtppmyz6gr@vjxbtjjqiqvy>
In-Reply-To: <3opzxxkqa4p6wxddx7bdf2dixphfuo4xunaaiqibvtppmyz6gr@vjxbtjjqiqvy>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 27 Oct 2023 11:29:11 +0100
Message-ID: <CAPY8ntC4TNkxuG9S8Lo-fmMcCSF39tCT_W2oO1KHHj5Fg6B0VQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo

On Fri, 27 Oct 2023 at 09:57, Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Andre'
>
> On Wed, Oct 25, 2023 at 11:26:00PM +0200, Andr=C3=A9 Apitzsch wrote:
> > Hi Jacopo,
> >
> > Am Dienstag, dem 24.10.2023 um 09:52 +0200 schrieb Jacopo Mondi:
> > > Hi Andre'
> > >
> > > On Mon, Oct 23, 2023 at 11:47:53PM +0200, Andr=C3=A9 Apitzsch wrote:
> > > > Set effictive and active sensor pixel sizes as shown in product
> > >
> > > s/effictive/effective
> > >
> > > > brief[1].
> > > >
> > > > [1]:
> > > > https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_20150428=
-1289331.pdf
> > > >
> > > > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> > > > ---
> > > >  drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++++--
> > > > -----
> > > >  1 file changed, 32 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/imx214.c
> > > > b/drivers/media/i2c/imx214.c
> > > > index bef8dc36e2d0..a2d441cd8dcd 100644
> > > > --- a/drivers/media/i2c/imx214.c
> > > > +++ b/drivers/media/i2c/imx214.c
> > > > @@ -36,6 +36,14 @@
> > > >  #define IMX214_EXPOSURE_STEP             1
> > > >  #define IMX214_EXPOSURE_DEFAULT          0x0c70
> > > >
> > > > +/* IMX214 native and active pixel array size */
> > > > +#define IMX214_NATIVE_WIDTH              4224U
> > > > +#define IMX214_NATIVE_HEIGHT             3136U
> > > > +#define IMX214_PIXEL_ARRAY_LEFT          8U
> > > > +#define IMX214_PIXEL_ARRAY_TOP           8U
> > > > +#define IMX214_PIXEL_ARRAY_WIDTH 4208U
> > > > +#define IMX214_PIXEL_ARRAY_HEIGHT        3120U
> > > > +
> > >
> > > I do get slightly different numbers from the datasheet version I have
> > >
> > > The sensor is said to have 4224x3208 total pixels of which 4208x3120
> > > are active ones.
> > >
> > > The pixel array diagram shows 64 "OPB" (optically black ?) lines,
> > > followed by 8 dummy lines, followed by 3120 valid lines. There are 8
> > > dummy columns at each side of the 4208 valid ones.
> > >
> > > Now, NATIVE which represents the full pixel array size seems to be
> > > 4224x3208 (other parts of the datasheet only report 3200 lines
> > > though)
> > >
> > > BOUNDS represents the readabale array area, which I presume
> > > corresponds to what is named as 'effective area' by the datasheet. It
> > > excludes the OPB lines at the top of the image and seems to be
> > > represented by (0, 64, 4224, 3160).
> > >
> > > CROP_DEFAULT represents the default crop rectangle which covers the
> > > active pixel area, so it excludes 8 more lines of dummy pixels and 8
> > > dummy columns, which gives a rectangle (8, 72, 4208, 3120)
> > >
> > > Also note that the driver always reports a TGT_CROP rectangle with
> > > top/left points set to 0. If my understanding is correct, V4L2
> > > selection targets are defined from the most external target
> > > (TGT_NATIVE in this case), and the driver should be corrected to
> > > initialize the crop rectangle with a top-left corner at (8, 72).
> > >
> > > Does this make sense ?
> >
> > As far as I understood, only the effective and active sizes of three
> > sizes provided in the datasheet (total, effective and active) matter.
> > By comparing the values used in imx219.c (and imx415.c) with the ones
> > in the corresponding datasheets [1,2] I assume, that "effective"
> > matches "NATIVE_SIZE", "active" matches "CROP_DEFAULT" and "total" is
> > ignored.
>
> imx219 driver indeed does not consider the OPB areas in the definition
> of the rectangles...
>
> Also looking at the X/Y_ADDR_START value assigned in the register tables
> for full resolution mode (3280x2462) they have value of 0, indeed
> meaning the active area is the only readable one.
>
> Then yes, you're right, for imx219
> NATIVE =3D effective
> CROP_DEFAULT =3D BOUND =3D active
>
> > The commit message of 1ed36ecd1459b653cced8929bfb37dba94b64c5d ("media:
> > i2c: imx219: Selection compliance fixes") seems to support me here:
>
> >
> > > The top/left crop coordinates of the TGT_CROP rectangle were set to
> > > (0, 0) instead of (8, 8) which is the offset from the larger physical
> > > pixel array rectangle.
> >
> > This (8, 8) is half the difference between number of effective and
> > active pixels of imx219[1].
> >
> > Together with the 8 dummy lines and 8 dummy columns you mentioned, I
> > still think my values are right. But I've just started working with
> > V4L2, so I might be wrong.
>
> To actually verify if the 'effective area' is readable or not, we
> should know what register controls the X/Y_ADDR_START value, and
> that's an information I don't have in my version of the datasheet.

I happen to have an IMX214 datasheet.
X_ADDR_START is 0x0344/5 (set in multiples of 2)
Y_ADDR_START is 0x0346/7 (set in multiples of 4)
X_ADDR_END is 0x0348/9 (set in multiples of 2)
Y_ADDR_END is 0x034a/b (set in multiples of 4)
X_OUTPUT_SIZE 0x034c/d
Y_OUTPUT_SIZE 0x034e/f

X direction are 13bit values, Y direction are 12 bit.
[12:8] or [11:8] in the low bits of the first register, [7:0] in the
second register.

  Dave

> It's however plausible that it behaves the same as imx219, as the
> driver's register sequences seems to program the crop sizes in
> register 0x034c and 0x034e and there's not programmed top-left corner
> there.
>
> Ok then, let's be consistent and do the same as imx219 as you're doing
> here.
>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
> >
> > Could you share the imx214 datasheet with me?
> >
> > Best regards,
> > Andr=C3=A9
> >
> > [1] https://www.arducam.com/downloads/modules/RaspberryPi_camera/IMX219=
DS.PDF
> > [2] https://www.sony-semicon.com/files/62/pdf/p-12_IMX415-AAQR_AAMR_Fly=
er.pdf
> > >
> > > Thanks
> > >   j
> > >
> > >
> > > >  static const char * const imx214_supply_name[] =3D {
> > > >   "vdda",
> > > >   "vddd",
> > > > @@ -634,14 +642,31 @@ static int imx214_get_selection(struct
> > > > v4l2_subdev *sd,
> > > >  {
> > > >   struct imx214 *imx214 =3D to_imx214(sd);
> > > >
> > > > - if (sel->target !=3D V4L2_SEL_TGT_CROP)
> > > > -         return -EINVAL;
> > > > + switch (sel->target) {
> > > > + case V4L2_SEL_TGT_CROP:
> > > > +         mutex_lock(&imx214->mutex);
> > > > +         sel->r =3D *__imx214_get_pad_crop(imx214, sd_state,
> > > > sel->pad,
> > > > +                                         sel->which);
> > > > +         mutex_unlock(&imx214->mutex);
> > > > +         return 0;
> > > >
> > > > - mutex_lock(&imx214->mutex);
> > > > - sel->r =3D *__imx214_get_pad_crop(imx214, sd_state, sel-
> > > > >pad,
> > > > -                                 sel->which);
> > > > - mutex_unlock(&imx214->mutex);
> > > > - return 0;
> > > > + case V4L2_SEL_TGT_NATIVE_SIZE:
> > > > +         sel->r.top =3D 0;
> > > > +         sel->r.left =3D 0;
> > > > +         sel->r.width =3D IMX214_NATIVE_WIDTH;
> > > > +         sel->r.height =3D IMX214_NATIVE_HEIGHT;
> > > > +         return 0;
> > > > +
> > > > + case V4L2_SEL_TGT_CROP_DEFAULT:
> > > > + case V4L2_SEL_TGT_CROP_BOUNDS:
> > > > +         sel->r.top =3D IMX214_PIXEL_ARRAY_TOP;
> > > > +         sel->r.left =3D IMX214_PIXEL_ARRAY_LEFT;
> > > > +         sel->r.width =3D IMX214_PIXEL_ARRAY_WIDTH;
> > > > +         sel->r.height =3D IMX214_PIXEL_ARRAY_HEIGHT;
> > > > +         return 0;
> > > > + }
> > > > +
> > > > + return -EINVAL;
> > > >  }
> > > >
> > > >  static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,
> > > >
> > > > --
> > > > 2.42.0
> > > >
> >
