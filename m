Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFC7D76AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjJYV0S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJYV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:26:14 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6E186;
        Wed, 25 Oct 2023 14:26:10 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qvlOA-0004pg-2F;
        Wed, 25 Oct 2023 23:26:06 +0200
Message-ID: <f5475c4f90e52817349e4842984bb3657b1e500d.camel@apitzsch.eu>
Subject: Re: [PATCH 4/4] media: i2c: imx214: Add sensor's pixel matrix size
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Wed, 25 Oct 2023 23:26:00 +0200
In-Reply-To: <56kgwl7zehsxy2pp7nziwk2gt6joax42qpzs6eywufvcto7qxm@ts4i3ccdokjr>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
         <20231023-imx214-v1-4-b33f1bbd1fcf@apitzsch.eu>
         <56kgwl7zehsxy2pp7nziwk2gt6joax42qpzs6eywufvcto7qxm@ts4i3ccdokjr>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Am Dienstag, dem 24.10.2023 um 09:52 +0200 schrieb Jacopo Mondi:
> Hi Andre'
> 
> On Mon, Oct 23, 2023 at 11:47:53PM +0200, André Apitzsch wrote:
> > Set effictive and active sensor pixel sizes as shown in product
> 
> s/effictive/effective
> 
> > brief[1].
> > 
> > [1]:
> > https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_20150428-1289331.pdf
> > 
> > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > ---
> >  drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++++--
> > -----
> >  1 file changed, 32 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/imx214.c
> > b/drivers/media/i2c/imx214.c
> > index bef8dc36e2d0..a2d441cd8dcd 100644
> > --- a/drivers/media/i2c/imx214.c
> > +++ b/drivers/media/i2c/imx214.c
> > @@ -36,6 +36,14 @@
> >  #define IMX214_EXPOSURE_STEP		1
> >  #define IMX214_EXPOSURE_DEFAULT		0x0c70
> > 
> > +/* IMX214 native and active pixel array size */
> > +#define IMX214_NATIVE_WIDTH		4224U
> > +#define IMX214_NATIVE_HEIGHT		3136U
> > +#define IMX214_PIXEL_ARRAY_LEFT		8U
> > +#define IMX214_PIXEL_ARRAY_TOP		8U
> > +#define IMX214_PIXEL_ARRAY_WIDTH	4208U
> > +#define IMX214_PIXEL_ARRAY_HEIGHT	3120U
> > +
> 
> I do get slightly different numbers from the datasheet version I have
> 
> The sensor is said to have 4224x3208 total pixels of which 4208x3120
> are active ones.
> 
> The pixel array diagram shows 64 "OPB" (optically black ?) lines,
> followed by 8 dummy lines, followed by 3120 valid lines. There are 8
> dummy columns at each side of the 4208 valid ones.
> 
> Now, NATIVE which represents the full pixel array size seems to be
> 4224x3208 (other parts of the datasheet only report 3200 lines
> though)
> 
> BOUNDS represents the readabale array area, which I presume
> corresponds to what is named as 'effective area' by the datasheet. It
> excludes the OPB lines at the top of the image and seems to be
> represented by (0, 64, 4224, 3160).
> 
> CROP_DEFAULT represents the default crop rectangle which covers the
> active pixel area, so it excludes 8 more lines of dummy pixels and 8
> dummy columns, which gives a rectangle (8, 72, 4208, 3120)
> 
> Also note that the driver always reports a TGT_CROP rectangle with
> top/left points set to 0. If my understanding is correct, V4L2
> selection targets are defined from the most external target
> (TGT_NATIVE in this case), and the driver should be corrected to
> initialize the crop rectangle with a top-left corner at (8, 72).
> 
> Does this make sense ?

As far as I understood, only the effective and active sizes of three
sizes provided in the datasheet (total, effective and active) matter.
By comparing the values used in imx219.c (and imx415.c) with the ones
in the corresponding datasheets [1,2] I assume, that "effective"
matches "NATIVE_SIZE", "active" matches "CROP_DEFAULT" and "total" is
ignored.
The commit message of 1ed36ecd1459b653cced8929bfb37dba94b64c5d ("media:
i2c: imx219: Selection compliance fixes") seems to support me here:

> The top/left crop coordinates of the TGT_CROP rectangle were set to
> (0, 0) instead of (8, 8) which is the offset from the larger physical
> pixel array rectangle.

This (8, 8) is half the difference between number of effective and
active pixels of imx219[1].

Together with the 8 dummy lines and 8 dummy columns you mentioned, I
still think my values are right. But I've just started working with
V4L2, so I might be wrong. 

Could you share the imx214 datasheet with me?

Best regards,
André

[1] https://www.arducam.com/downloads/modules/RaspberryPi_camera/IMX219DS.PDF
[2] https://www.sony-semicon.com/files/62/pdf/p-12_IMX415-AAQR_AAMR_Flyer.pdf
> 
> Thanks
>   j
> 
> 
> >  static const char * const imx214_supply_name[] = {
> >  	"vdda",
> >  	"vddd",
> > @@ -634,14 +642,31 @@ static int imx214_get_selection(struct
> > v4l2_subdev *sd,
> >  {
> >  	struct imx214 *imx214 = to_imx214(sd);
> > 
> > -	if (sel->target != V4L2_SEL_TGT_CROP)
> > -		return -EINVAL;
> > +	switch (sel->target) {
> > +	case V4L2_SEL_TGT_CROP:
> > +		mutex_lock(&imx214->mutex);
> > +		sel->r = *__imx214_get_pad_crop(imx214, sd_state,
> > sel->pad,
> > +						sel->which);
> > +		mutex_unlock(&imx214->mutex);
> > +		return 0;
> > 
> > -	mutex_lock(&imx214->mutex);
> > -	sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel-
> > >pad,
> > -					sel->which);
> > -	mutex_unlock(&imx214->mutex);
> > -	return 0;
> > +	case V4L2_SEL_TGT_NATIVE_SIZE:
> > +		sel->r.top = 0;
> > +		sel->r.left = 0;
> > +		sel->r.width = IMX214_NATIVE_WIDTH;
> > +		sel->r.height = IMX214_NATIVE_HEIGHT;
> > +		return 0;
> > +
> > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > +		sel->r.top = IMX214_PIXEL_ARRAY_TOP;
> > +		sel->r.left = IMX214_PIXEL_ARRAY_LEFT;
> > +		sel->r.width = IMX214_PIXEL_ARRAY_WIDTH;
> > +		sel->r.height = IMX214_PIXEL_ARRAY_HEIGHT;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> >  }
> > 
> >  static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,
> > 
> > --
> > 2.42.0
> > 

