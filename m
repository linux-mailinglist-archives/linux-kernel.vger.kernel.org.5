Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758737D76EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJYVkm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjJYVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:40:40 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4EB133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:40:37 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qvlc9-0007xU-37;
        Wed, 25 Oct 2023 23:40:34 +0200
Message-ID: <23fcdaea6267ce2aa547094e3f578ae8d245b3cb.camel@apitzsch.eu>
Subject: Re: [PATCH 1/4] media: i2c: imx214: Explain some magic numbers
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Wed, 25 Oct 2023 23:40:32 +0200
In-Reply-To: <169815197462.630990.3330310524563366908@ping.linuxembedded.co.uk>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
         <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu>
         <169810104910.2245571.16606813523946813634@ping.linuxembedded.co.uk>
         <9117e551a4a4dd0e94a1395817d89cb18ac11b24.camel@apitzsch.eu>
         <169815197462.630990.3330310524563366908@ping.linuxembedded.co.uk>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 24.10.2023 um 13:52 +0100 schrieb Kieran Bingham:
> Quoting André Apitzsch (2023-10-24 08:30:01)
> > Am Montag, dem 23.10.2023 um 23:44 +0100 schrieb Kieran Bingham:
> > > Quoting André Apitzsch (2023-10-23 22:47:50)
> > > > Code refinement, no functional changes.
> > > > 
> > > > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > > > ---
> > > >  drivers/media/i2c/imx214.c | 24 +++++++++++++++++++-----
> > > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/i2c/imx214.c
> > > > b/drivers/media/i2c/imx214.c
> > > > index 4f77ea02cc27..9218c149d4c8 100644
> > > > --- a/drivers/media/i2c/imx214.c
> > > > +++ b/drivers/media/i2c/imx214.c
> > > > @@ -19,12 +19,23 @@
> > > >  #include <media/v4l2-fwnode.h>
> > > >  #include <media/v4l2-subdev.h>
> > > >  
> > > > +#define IMX214_REG_MODE_SELECT         0x0100
> > > > +#define IMX214_MODE_STANDBY            0x00
> > > > +#define IMX214_MODE_STREAMING          0x01
> > > > +
> > > >  #define IMX214_DEFAULT_CLK_FREQ        24000000
> > > >  #define IMX214_DEFAULT_LINK_FREQ 480000000
> > > >  #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ *
> > > > 8LL) / 10)
> > > >  #define IMX214_FPS 30
> > > >  #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
> > > >  
> > > > +/* Exposure control */
> > > > +#define IMX214_REG_EXPOSURE            0x0202
> > > > +#define IMX214_EXPOSURE_MIN            0
> > > > +#define IMX214_EXPOSURE_MAX            3184
> > > > +#define IMX214_EXPOSURE_STEP           1
> > > > +#define IMX214_EXPOSURE_DEFAULT                0x0c70
> > > 
> > > I like this change, and I see that 0x0c70 was directly moved here
> > > from
> > > the code below. But could we replace 0xc70 here with 3184 please
> > > so
> > > that
> > > it's /far/ clearer that the Exposure Default == Exposure Max
> > > which is
> > > otherwise hidden?
> > > 
> > Hi Kieran,
> > 
> > I can do that. But I propose to replace 3184 with 0x0c70 instead.
> > Because that matches the entries used in the reg_8 lists
> > mode_4096x2304[] and mode_1920x1080[].
> > 
> >         {0x0202, 0x0C},
> >         {0x0203, 0x70}, 
> > 
> > What do you think?
> 
> I think exposure values are easier to read as integers than hex
> values.
Okay, integer it is.

> 
> This is the 'Coarse Integration Time' register with a unit of
> 'lines'.
> 
> If you have lots of time, or wish to delve deeper - we could talk
> about splitting out those register tables to use CCI and/or more
> readable functions ;-)

I will consider it.

> 
> Do you have the datasheet for this sensor - or are you just working
> from the information within this driver?

I don't have the datasheet, yet (maybe somebody could provide it), so I
have to work with the information within this driver and downstream
implementations, like the one by nvidia [1].

> 
> What device are you using to test this driver?
> 
The sensor is part of my mobile, BQ Aquaris M5 (Longcheer L9100).

Best regards,
André

[1] https://github.com/InES-HPMM/linux-l4t/blob/9150157d2b1f73aefe01e9a07e3b062a45d57247/drivers/media/i2c/imx214_mode_tbls.h

> --
> Kieran
> 
> > Regards,
> > André

