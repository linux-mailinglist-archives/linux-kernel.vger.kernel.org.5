Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B57944E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbjIFVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:01:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418A1BCA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:01:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007f3d3235so333085e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694034061; x=1694638861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQMwCTpNt+KxTz9xWXAiav+VDadxFYUSFtneEl0FIW0=;
        b=VHvQgDphtOHxOvhgyxW65S6EfDjlM2VMAAAHyLP9H5r9e8U7pHDvj4/VEmLRri8Ltk
         ZP2OG0ZwPHFV8Hn4CxsflQTkw+fXyE5ZMr6+4Q4oTdbtFf3hyA365SUVYZDuhUb0pccJ
         zSor9S64Uh3RIVAoB+dcr5nlOjg+iCt7eurvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694034061; x=1694638861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQMwCTpNt+KxTz9xWXAiav+VDadxFYUSFtneEl0FIW0=;
        b=E0XlQic4lR2XA8acY84JQDP2dzaiCsywv0eUvsLij4rLSiGVUGlRlODid7qgN6bCtS
         9Mm3/stpcmPzLxtZLRLNion98lF9LjfUgaqyf6PDvOp7SMdcXbLuDuS/l+0qxoyNY3Ya
         M1Xx/9VyXI2fy7/qa3+48p0/sJ33aZ3Nda7I2JKHSeE+RTbcsEQvZxTcPttRLO1GF/Cm
         Lw2ySBZdJlFeTCYHDrAoxHPjGN2Gt8mXBDzxzcfxFG26/qGotkBolIo6w70emsU1Y3rq
         auH96d2FJdrSHrbPEwtemJLSYcQV8jYdbHD/PDSjOLzXWtkMOZIR/6jprh24c0NTJF0+
         5Tpw==
X-Gm-Message-State: AOJu0YzHm+5fSfffabCDIQ1Y9Nt8I3Mi9T3roKtA1EN3d0ux0f8CAAu/
        6ixcPr0heEhs8spEOv22+lTiolRESlKniMnUCPA=
X-Google-Smtp-Source: AGHT+IHeTgtdOicfUiKdp9wt20Ia8q1ZZSgP5IF0Pi1bgW7dXG8drWJstw4Edd8pWZczpD3IlxMxMQ==
X-Received: by 2002:a19:5e57:0:b0:4f8:4512:c844 with SMTP id z23-20020a195e57000000b004f84512c844mr2975926lfi.48.1694034061033;
        Wed, 06 Sep 2023 14:01:01 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id t11-20020a05640203cb00b0052a1d98618bsm8981482edw.54.2023.09.06.14.00.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 14:00:59 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31c3726cc45so326913f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:00:58 -0700 (PDT)
X-Received: by 2002:adf:e70a:0:b0:315:8f4f:81b2 with SMTP id
 c10-20020adfe70a000000b003158f4f81b2mr3137778wrm.64.1694034057706; Wed, 06
 Sep 2023 14:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-chicony-v2-1-88335519989d@chromium.org> <20230906134435.GA24846@pendragon.ideasonboard.com>
In-Reply-To: <20230906134435.GA24846@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 6 Sep 2023 23:00:42 +0200
X-Gmail-Original-Message-ID: <CANiDSCv9wFPW32Y8TfxXWnOWyTtURg-D9F-AUmZeeLBfU1=p=A@mail.gmail.com>
Message-ID: <CANiDSCv9wFPW32Y8TfxXWnOWyTtURg-D9F-AUmZeeLBfU1=p=A@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix power line control for a Chicony camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, 6 Sept 2023 at 15:44, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Sep 05, 2023 at 03:29:52PM +0000, Ricardo Ribalda wrote:
> > The device does not implement the control properly.
> >
> > Fixes v4l2-compliance error:
> >
> > info: checking control 'Power Line Frequency' (0x00980918)
> > fail: v4l2-test-controls.cpp(552): could not set valid menu item 3
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> This still applies :-)
>
> I've taken the patch in my tree and will push it for v6.7.

Thanks!
>
> > ---
> > This camera, like other Chicony devices, do not implement properly the
> > Power Line Frequency control.
> >
> > This time, I do not have direct access to the device, just to the
> > report, but since other devices from the same family are showing the
> > same error, it is safe to assume that the same fix will work here.
> > ---
> > Changes in v2:
> > - Fix IntefaceProtocol, the camera is uvc1.5
> > - I managed to write 0 to the control, so the proper quirk is uvc11 not
> >   limited
> > - Changes by Laurent:
> >       - Rename device
> >       - s/v4l/v4l2
> > - Link to v1: https://lore.kernel.org/r/20230817-chicony-v1-1-76bde4d6ff6b@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 08fcd2ffa727..4b5ea3501753 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
> >         .bInterfaceSubClass   = 1,
> >         .bInterfaceProtocol   = 0,
> >         .driver_info          = (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> > +     /* Chicony Electronics Co., Ltd Integrated Camera */
> > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > +       .idVendor             = 0x04f2,
> > +       .idProduct            = 0xb67c,
> > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > +       .bInterfaceSubClass   = 1,
> > +       .bInterfaceProtocol   = UVC_PC_PROTOCOL_15,
> > +       .driver_info          = (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
> >       /* Chicony EasyCamera */
> >       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >                               | USB_DEVICE_ID_MATCH_INT_INFO,
> >
> > ---
> > base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> > change-id: 20230817-chicony-9c35f2046c6f
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
