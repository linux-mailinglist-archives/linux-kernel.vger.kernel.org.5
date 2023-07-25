Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494B7623C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGYUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjGYUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:42:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6B10F7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:42:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40540a8a3bbso20411cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690317736; x=1690922536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XL511l+W17uTebJKh0g4VcvkrGXuZA7ErAH+O9O5/Z8=;
        b=Z7hRSFFW6ZskSHwcUMeLGYqKdsWuL1OArSwmRRJsmdDB9rpFA/WQhsl+5/u4S5wBtO
         gAsnlr2Oiv8vlsRnOTpZwcfXHLi8G4kxQpGRRxFGX1n8AMY+vCbHcKOuYfhk/IDZSMtg
         wPU7ghN1uEo9FHaE0rTiOQs8InbVbEubuq6i1x3yClvmEhlBc+l0S7AkglV41+0adazi
         uo1+vHhw3twZSVlRaynUtDvoR1fxIFmHoiV4w9eQSif/+egfBfJ9YGO1U6DwMmpmuhup
         Tr1GFvmJ6t84oBEWLiyzOyt60NJezs5muvRiIl9Qj1SxifbHTJDXPhq8FSGW+pJZT/5N
         GIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317736; x=1690922536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL511l+W17uTebJKh0g4VcvkrGXuZA7ErAH+O9O5/Z8=;
        b=DnM3FWSObNRxCxyTJ5nqDX6RjydAqt6RjTuczdxwSkkj3XKts9oUHQcqDf0AE9VhLX
         er5kyocgPptrmOfBOI+8s5/x9aJo5UDwUD0ngO2xsRiGbf8wbbruX+kkQJ037VL6XaLw
         7QGw9dChvlo1gNXTlxqV8txRpJkJBw1u0K0A/bRgWkLecOSCm/gniAuk5xj+gQk4HEPc
         3sSZwNNkpNG6LM8x4ehznNg38yB8UWlOPdnB3zHsic12j0LraqcxtQ73IxU8IxibzZO8
         ww0416QQinyu1dGrjedRU6jRTrrzr3x7mLgBL6Nv23FfsLJLpZrqgqAdy6IEaGSKPCTI
         7VNQ==
X-Gm-Message-State: ABy/qLYEBE9sOpHM0suQd1/sAGLtnCkeOBex6bHFnSwADKwvGJOBSaAh
        lqj3xS3myvA7qAfImG790wTsP+oNmQRdvdrbJLuJmA==
X-Google-Smtp-Source: APBJJlGTgdnUKsbem9lF61GJ5EqqKdJKVjQ14i6rSeLt8JgdkCGgRaRuOyse3jKLPSVHfVnTyToB2TVKNHGfArPXKRI=
X-Received: by 2002:ac8:7d89:0:b0:403:eb3c:37af with SMTP id
 c9-20020ac87d89000000b00403eb3c37afmr317296qtd.26.1690317735452; Tue, 25 Jul
 2023 13:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
 <0000000000007fc04d06011e274f@google.com> <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
In-Reply-To: <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 25 Jul 2023 13:42:01 -0700
Message-ID: <CACGdZYL_dPFp-yHWHGC3vxyv4R4dYtSJe5GPcN0NjG2qaz+xmg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000386bc7060155c468"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000386bc7060155c468
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:26=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Sat, Jul 22, 2023 at 07:21:23PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >
> > Reported-and-tested-by: syzbot+18996170f8096c6174d0@syzkaller.appspotma=
il.com
>
> Here's a revised version of the patch, with some mistakes fixed.  If
> this works, I'll split it into three parts and submit them.
>
> Alan Stern
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/ v6.5-rc3
>
> Index: usb-devel/drivers/usb/core/hub.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/hub.c
> +++ usb-devel/drivers/usb/core/hub.c
> @@ -2671,12 +2671,17 @@ int usb_authorize_device(struct usb_devi
>         }
>
>         if (usb_dev->wusb) {
> -               result =3D usb_get_device_descriptor(usb_dev, sizeof(usb_=
dev->descriptor));
> -               if (result < 0) {
> +               struct usb_device_descriptor *descr;
> +
> +               descr =3D usb_get_device_descriptor(usb_dev);
> +               if (IS_ERR(descr)) {
> +                       result =3D PTR_ERR(descr);
>                         dev_err(&usb_dev->dev, "can't re-read device desc=
riptor for "
>                                 "authorization: %d\n", result);
>                         goto error_device_descriptor;
>                 }
> +               usb_dev->descriptor =3D *descr;
Hmm, in your first patch you rejected diffs to the descriptor here,
which might be necessary - since we don't re-initialize the device so
can get a similar issue if the bad usb device decides to change
bNumConfigurations to cause a buffer overrun. (This also stuck out to
me as an exception to the "descriptors should be immutable" comment
later in the patch.
> +               kfree(descr);
>         }
>
>         usb_dev->authorized =3D 1;
> @@ -4718,6 +4723,67 @@ static int hub_enable_device(struct usb_
>         return hcd->driver->enable_device(hcd, udev);
>  }
>
> +/*
> + * Get the bMaxPacketSize0 value during initialization by reading the
> + * device's device descriptor.  Since we don't already know this value,
> + * the transfer is unsafe and it ignores I/O errors, only testing for
> + * reasonable received values.
> + *
> + * For "old scheme" initialization size will be 8, so we read just the
> + * start of the device descriptor, which should work okay regardless of
> + * the actual bMaxPacketSize0 value.  For "new scheme" initialization,
> + * size will be 64 (and buf will point to a sufficiently large buffer),
> + * which might not be kosher according to the USB spec but it's what
> + * Windows does and what many devices expect.
> + *
> + * Returns bMaxPacketSize0 or a negative error code.
> + */
> +static int get_bMaxPacketSize0(struct usb_device *udev,
> +               struct usb_device_descriptor *buf, int size, bool first_t=
ime)
> +{
> +       int i, rc;
> +
> +       /*
> +        * Retry on all errors; some devices are flakey.
> +        * 255 is for WUSB devices, we actually need to use
> +        * 512 (WUSB1.0[4.8.1]).
> +        */
> +       for (i =3D 0; i < GET_MAXPACKET0_TRIES; ++i) {
> +               /* Start with invalid values in case the transfer fails *=
/
> +               buf->bDescriptorType =3D buf->bMaxPacketSize0 =3D 0;
> +               rc =3D usb_control_msg(udev, usb_rcvaddr0pipe(),
> +                               USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> +                               USB_DT_DEVICE << 8, 0,
> +                               buf, size,
> +                               initial_descriptor_timeout);
> +               switch (buf->bMaxPacketSize0) {
> +               case 8: case 16: case 32: case 64: case 255:
> +                       if (buf->bDescriptorType =3D=3D USB_DT_DEVICE) {
> +                               rc =3D buf->bMaxPacketSize0;
> +                               break;
> +                       }
> +                       fallthrough;
> +               default:
> +                       if (rc >=3D 0)
> +                               rc =3D -EPROTO;
> +                       break;
> +               }
> +
> +               /*
> +                * Some devices time out if they are powered on
> +                * when already connected. They need a second
> +                * reset, so return early. But only on the first
> +                * attempt, lest we get into a time-out/reset loop.
> +                */
> +               if (rc > 0 || (rc =3D=3D -ETIMEDOUT && first_time &&
> +                               udev->speed > USB_SPEED_FULL))
> +                       break;
> +       }
> +       return rc;
> +}
> +
> +#define GET_DESCRIPTOR_BUFSIZE 64
> +
>  /* Reset device, (re)assign address, get device descriptor.
>   * Device connection must be stable, no more debouncing needed.
>   * Returns device in USB_STATE_ADDRESS, except on error.
> @@ -4727,10 +4793,17 @@ static int hub_enable_device(struct usb_
>   * the port lock.  For a newly detected device that is not accessible
>   * through any global pointers, it's not necessary to lock the device,
>   * but it is still necessary to lock the port.
> + *
> + * For a newly detected device, @dev_descr must be NULL.  The device
> + * descriptor retrieved from the device will then be stored in
> + * @udev->descriptor.  For an already existing device, @dev_descr
> + * must be non-NULL.  The device descriptor will be stored there,
> + * not in @udev->descriptor, because descriptors for registered
> + * devices are meant to be immutable.
>   */
>  static int
>  hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> -               int retry_counter)
> +               int retry_counter, struct usb_device_descriptor *dev_desc=
r)
>  {
>         struct usb_device       *hdev =3D hub->hdev;
>         struct usb_hcd          *hcd =3D bus_to_hcd(hdev->bus);
> @@ -4742,6 +4815,13 @@ hub_port_init(struct usb_hub *hub, struc
>         int                     devnum =3D udev->devnum;
>         const char              *driver_name;
>         bool                    do_new_scheme;
> +       const bool              initial =3D !dev_descr;
> +       int                     maxp0;
> +       struct usb_device_descriptor    *buf, *descr;
> +
> +       buf =3D kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
> +       if (!buf)
> +               return -ENOMEM;
>
>         /* root hub ports have a slightly longer reset period
>          * (from USB 2.0 spec, section 7.1.7.5)
> @@ -4774,32 +4854,34 @@ hub_port_init(struct usb_hub *hub, struc
>         }
>         oldspeed =3D udev->speed;
>
> -       /* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> -        * it's fixed size except for full speed devices.
> -        * For Wireless USB devices, ep0 max packet is always 512 (tho
> -        * reported as 0xff in the device descriptor). WUSB1.0[4.8.1].
> -        */
> -       switch (udev->speed) {
> -       case USB_SPEED_SUPER_PLUS:
> -       case USB_SPEED_SUPER:
> -       case USB_SPEED_WIRELESS:        /* fixed at 512 */
> -               udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(512);
> -               break;
> -       case USB_SPEED_HIGH:            /* fixed at 64 */
> -               udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(64);
> -               break;
> -       case USB_SPEED_FULL:            /* 8, 16, 32, or 64 */
> -               /* to determine the ep0 maxpacket size, try to read
> -                * the device descriptor to get bMaxPacketSize0 and
> -                * then correct our initial guess.
> -                */
> -               udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(64);
> -               break;
> -       case USB_SPEED_LOW:             /* fixed at 8 */
> -               udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(8);
> -               break;
> -       default:
> -               goto fail;
> +       if (initial) {
> +               /* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> +                * it's fixed size except for full speed devices.
> +                * For Wireless USB devices, ep0 max packet is always 512=
 (tho
> +                * reported as 0xff in the device descriptor). WUSB1.0[4.=
8.1].
> +                */
> +               switch (udev->speed) {
> +               case USB_SPEED_SUPER_PLUS:
> +               case USB_SPEED_SUPER:
> +               case USB_SPEED_WIRELESS:        /* fixed at 512 */
> +                       udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(512=
);
> +                       break;
> +               case USB_SPEED_HIGH:            /* fixed at 64 */
> +                       udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(64)=
;
> +                       break;
> +               case USB_SPEED_FULL:            /* 8, 16, 32, or 64 */
> +                       /* to determine the ep0 maxpacket size, try to re=
ad
> +                        * the device descriptor to get bMaxPacketSize0 a=
nd
> +                        * then correct our initial guess.
> +                        */
> +                       udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(64)=
;
> +                       break;
> +               case USB_SPEED_LOW:             /* fixed at 8 */
> +                       udev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(8);
> +                       break;
> +               default:
> +                       goto fail;
> +               }
>         }
>
>         if (udev->speed =3D=3D USB_SPEED_WIRELESS)
> @@ -4822,22 +4904,24 @@ hub_port_init(struct usb_hub *hub, struc
>         if (udev->speed < USB_SPEED_SUPER)
>                 dev_info(&udev->dev,
>                                 "%s %s USB device number %d using %s\n",
> -                               (udev->config) ? "reset" : "new", speed,
> +                               (initial ? "new" : "reset"), speed,
>                                 devnum, driver_name);
>
> -       /* Set up TT records, if needed  */
> -       if (hdev->tt) {
> -               udev->tt =3D hdev->tt;
> -               udev->ttport =3D hdev->ttport;
> -       } else if (udev->speed !=3D USB_SPEED_HIGH
> -                       && hdev->speed =3D=3D USB_SPEED_HIGH) {
> -               if (!hub->tt.hub) {
> -                       dev_err(&udev->dev, "parent hub has no TT\n");
> -                       retval =3D -EINVAL;
> -                       goto fail;
> +       if (initial) {
> +               /* Set up TT records, if needed  */
> +               if (hdev->tt) {
> +                       udev->tt =3D hdev->tt;
> +                       udev->ttport =3D hdev->ttport;
> +               } else if (udev->speed !=3D USB_SPEED_HIGH
> +                               && hdev->speed =3D=3D USB_SPEED_HIGH) {
> +                       if (!hub->tt.hub) {
> +                               dev_err(&udev->dev, "parent hub has no TT=
\n");
> +                               retval =3D -EINVAL;
> +                               goto fail;
> +                       }
> +                       udev->tt =3D &hub->tt;
> +                       udev->ttport =3D port1;
>                 }
> -               udev->tt =3D &hub->tt;
> -               udev->ttport =3D port1;
>         }
>
>         /* Why interleave GET_DESCRIPTOR and SET_ADDRESS this way?
> @@ -4861,9 +4945,6 @@ hub_port_init(struct usb_hub *hub, struc
>                 }
>
>                 if (do_new_scheme) {
> -                       struct usb_device_descriptor *buf;
> -                       int r =3D 0;
> -
>                         retval =3D hub_enable_device(udev);
>                         if (retval < 0) {
>                                 dev_err(&udev->dev,
> @@ -4872,52 +4953,14 @@ hub_port_init(struct usb_hub *hub, struc
>                                 goto fail;
>                         }
>
> -#define GET_DESCRIPTOR_BUFSIZE 64
> -                       buf =3D kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO)=
;
> -                       if (!buf) {
> -                               retval =3D -ENOMEM;
> -                               continue;
> -                       }
> -
> -                       /* Retry on all errors; some devices are flakey.
> -                        * 255 is for WUSB devices, we actually need to u=
se
> -                        * 512 (WUSB1.0[4.8.1]).
> -                        */
> -                       for (operations =3D 0; operations < GET_MAXPACKET=
0_TRIES;
> -                                       ++operations) {
> -                               buf->bMaxPacketSize0 =3D 0;
> -                               r =3D usb_control_msg(udev, usb_rcvaddr0p=
ipe(),
> -                                       USB_REQ_GET_DESCRIPTOR, USB_DIR_I=
N,
> -                                       USB_DT_DEVICE << 8, 0,
> -                                       buf, GET_DESCRIPTOR_BUFSIZE,
> -                                       initial_descriptor_timeout);
> -                               switch (buf->bMaxPacketSize0) {
> -                               case 8: case 16: case 32: case 64: case 2=
55:
> -                                       if (buf->bDescriptorType =3D=3D
> -                                                       USB_DT_DEVICE) {
> -                                               r =3D 0;
> -                                               break;
> -                                       }
> -                                       fallthrough;
> -                               default:
> -                                       if (r =3D=3D 0)
> -                                               r =3D -EPROTO;
> -                                       break;
> -                               }
> -                               /*
> -                                * Some devices time out if they are powe=
red on
> -                                * when already connected. They need a se=
cond
> -                                * reset. But only on the first attempt,
> -                                * lest we get into a time out/reset loop
> -                                */
> -                               if (r =3D=3D 0 || (r =3D=3D -ETIMEDOUT &&
> -                                               retries =3D=3D 0 &&
> -                                               udev->speed > USB_SPEED_F=
ULL))
> -                                       break;
> +                       maxp0 =3D get_bMaxPacketSize0(udev, buf,
> +                                       GET_DESCRIPTOR_BUFSIZE, retries =
=3D=3D 0);
> +                       if (maxp0 > 0 && !initial &&
> +                                       maxp0 !=3D udev->descriptor.bMaxP=
acketSize0) {
> +                               dev_err(&udev->dev, "device reset changed=
 ep0 maxpacket size!\n");
> +                               retval =3D -ENODEV;
> +                               goto fail;
>                         }
> -                       udev->descriptor.bMaxPacketSize0 =3D
> -                                       buf->bMaxPacketSize0;
> -                       kfree(buf);
>
>                         retval =3D hub_port_reset(hub, port1, udev, delay=
, false);
>                         if (retval < 0)         /* error or disconnect */
> @@ -4928,14 +4971,13 @@ hub_port_init(struct usb_hub *hub, struc
>                                 retval =3D -ENODEV;
>                                 goto fail;
>                         }
> -                       if (r) {
> -                               if (r !=3D -ENODEV)
> +                       if (maxp0 < 0) {
> +                               if (maxp0 !=3D -ENODEV)
>                                         dev_err(&udev->dev, "device descr=
iptor read/64, error %d\n",
> -                                                       r);
> -                               retval =3D -EMSGSIZE;
> +                                                       maxp0);
> +                               retval =3D maxp0;
>                                 continue;
>                         }
> -#undef GET_DESCRIPTOR_BUFSIZE
>                 }
>
>                 /*
> @@ -4981,18 +5023,22 @@ hub_port_init(struct usb_hub *hub, struc
>                                 break;
>                 }
>
> -               retval =3D usb_get_device_descriptor(udev, 8);
> -               if (retval < 8) {
> +               /* !do_new_scheme || wusb */
> +               maxp0 =3D get_bMaxPacketSize0(udev, buf, 8, retries =3D=
=3D 0);
> +               if (maxp0 < 0) {
> +                       retval =3D maxp0;
>                         if (retval !=3D -ENODEV)
>                                 dev_err(&udev->dev,
>                                         "device descriptor read/8, error =
%d\n",
>                                         retval);
> -                       if (retval >=3D 0)
> -                               retval =3D -EMSGSIZE;
>                 } else {
>                         u32 delay;
>
> -                       retval =3D 0;
> +                       if (!initial && maxp0 !=3D udev->descriptor.bMaxP=
acketSize0) {
> +                               dev_err(&udev->dev, "device reset changed=
 ep0 maxpacket size!\n");
> +                               retval =3D -ENODEV;
> +                               goto fail;
> +                       }
>
>                         delay =3D udev->parent->hub_delay;
>                         udev->hub_delay =3D min_t(u32, delay,
> @@ -5010,27 +5056,10 @@ hub_port_init(struct usb_hub *hub, struc
>         if (retval)
>                 goto fail;
>
> -       /*
> -        * Some superspeed devices have finished the link training proces=
s
> -        * and attached to a superspeed hub port, but the device descript=
or
> -        * got from those devices show they aren't superspeed devices. Wa=
rm
> -        * reset the port attached by the devices can fix them.
> -        */
> -       if ((udev->speed >=3D USB_SPEED_SUPER) &&
> -                       (le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) =
{
> -               dev_err(&udev->dev, "got a wrong device descriptor, "
> -                               "warm reset device\n");
> -               hub_port_reset(hub, port1, udev,
> -                               HUB_BH_RESET_TIME, true);
> -               retval =3D -EINVAL;
> -               goto fail;
> -       }
> -
> -       if (udev->descriptor.bMaxPacketSize0 =3D=3D 0xff ||
> -                       udev->speed >=3D USB_SPEED_SUPER)
> +       if (maxp0 =3D=3D 0xff || udev->speed >=3D USB_SPEED_SUPER)
>                 i =3D 512;
>         else
> -               i =3D udev->descriptor.bMaxPacketSize0;
> +               i =3D maxp0;
>         if (usb_endpoint_maxp(&udev->ep0.desc) !=3D i) {
>                 if (udev->speed =3D=3D USB_SPEED_LOW ||
>                                 !(i =3D=3D 8 || i =3D=3D 16 || i =3D=3D 3=
2 || i =3D=3D 64)) {
> @@ -5046,13 +5075,33 @@ hub_port_init(struct usb_hub *hub, struc
>                 usb_ep0_reinit(udev);
>         }
>
> -       retval =3D usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
> -       if (retval < (signed)sizeof(udev->descriptor)) {
> +       descr =3D usb_get_device_descriptor(udev);
> +       if (IS_ERR(descr)) {
> +               retval =3D PTR_ERR(descr);
>                 if (retval !=3D -ENODEV)
>                         dev_err(&udev->dev, "device descriptor read/all, =
error %d\n",
>                                         retval);
> -               if (retval >=3D 0)
> -                       retval =3D -ENOMSG;
> +               goto fail;
> +       }
> +       if (initial)
> +               udev->descriptor =3D *descr;
> +       else
> +               *dev_descr =3D *descr;
> +       kfree(descr);
> +
> +       /*
> +        * Some superspeed devices have finished the link training proces=
s
> +        * and attached to a superspeed hub port, but the device descript=
or
> +        * got from those devices show they aren't superspeed devices. Wa=
rm
> +        * reset the port attached by the devices can fix them.
> +        */
> +       if ((udev->speed >=3D USB_SPEED_SUPER) &&
> +                       (le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) =
{
> +               dev_err(&udev->dev, "got a wrong device descriptor, "
> +                               "warm reset device\n");
> +               hub_port_reset(hub, port1, udev,
> +                               HUB_BH_RESET_TIME, true);
> +               retval =3D -EINVAL;
>                 goto fail;
>         }
>
> @@ -5078,6 +5127,7 @@ fail:
>                 hub_port_disable(hub, port1, 0);
>                 update_devnum(udev, devnum);    /* for disconnect process=
ing */
>         }
> +       kfree(buf);
>         return retval;
>  }
>
> @@ -5158,7 +5208,7 @@ hub_power_remaining(struct usb_hub *hub)
>
>
>  static int descriptors_changed(struct usb_device *udev,
> -               struct usb_device_descriptor *old_device_descriptor,
> +               struct usb_device_descriptor *new_device_descriptor,
>                 struct usb_host_bos *old_bos)
>  {
>         int             changed =3D 0;
> @@ -5169,8 +5219,8 @@ static int descriptors_changed(struct us
>         int             length;
>         char            *buf;
>
> -       if (memcmp(&udev->descriptor, old_device_descriptor,
> -                       sizeof(*old_device_descriptor)) !=3D 0)
> +       if (memcmp(&udev->descriptor, new_device_descriptor,
> +                       sizeof(*new_device_descriptor)) !=3D 0)
>                 return 1;
>
>         if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
> @@ -5348,7 +5398,7 @@ static void hub_port_connect(struct usb_
>                 }
>
>                 /* reset (non-USB 3.0 devices) and get descriptor */
> -               status =3D hub_port_init(hub, udev, port1, i);
> +               status =3D hub_port_init(hub, udev, port1, i, NULL);
>                 if (status < 0)
>                         goto loop;
>
> @@ -5495,9 +5545,8 @@ static void hub_port_connect_change(stru
>  {
>         struct usb_port *port_dev =3D hub->ports[port1 - 1];
>         struct usb_device *udev =3D port_dev->child;
> -       struct usb_device_descriptor descriptor;
> +       struct usb_device_descriptor *descr;
>         int status =3D -ENODEV;
> -       int retval;
>
>         dev_dbg(&port_dev->dev, "status %04x, change %04x, %s\n", portsta=
tus,
>                         portchange, portspeed(hub, portstatus));
> @@ -5524,23 +5573,20 @@ static void hub_port_connect_change(stru
>                          * changed device descriptors before resuscitatin=
g the
>                          * device.
>                          */
> -                       descriptor =3D udev->descriptor;
> -                       retval =3D usb_get_device_descriptor(udev,
> -                                       sizeof(udev->descriptor));
> -                       if (retval < 0) {
> +                       descr =3D usb_get_device_descriptor(udev);
> +                       if (IS_ERR(descr)) {
>                                 dev_dbg(&udev->dev,
> -                                               "can't read device descri=
ptor %d\n",
> -                                               retval);
> +                                               "can't read device descri=
ptor %ld\n",
> +                                               PTR_ERR(descr));
>                         } else {
> -                               if (descriptors_changed(udev, &descriptor=
,
> +                               if (descriptors_changed(udev, descr,
>                                                 udev->bos)) {
>                                         dev_dbg(&udev->dev,
>                                                         "device descripto=
r has changed\n");
> -                                       /* for disconnect() calls */
> -                                       udev->descriptor =3D descriptor;
>                                 } else {
>                                         status =3D 0; /* Nothing to do */
>                                 }
> +                               kfree(descr);
>                         }
>  #ifdef CONFIG_PM
>                 } else if (udev->state =3D=3D USB_STATE_SUSPENDED &&
> @@ -5982,7 +6028,7 @@ static int usb_reset_and_verify_device(s
>         struct usb_device               *parent_hdev =3D udev->parent;
>         struct usb_hub                  *parent_hub;
>         struct usb_hcd                  *hcd =3D bus_to_hcd(udev->bus);
> -       struct usb_device_descriptor    descriptor =3D udev->descriptor;
> +       struct usb_device_descriptor    descriptor;
>         struct usb_host_bos             *bos;
>         int                             i, j, ret =3D 0;
>         int                             port1 =3D udev->portnum;
> @@ -6018,7 +6064,7 @@ static int usb_reset_and_verify_device(s
>                 /* ep0 maxpacket size may change; let the HCD know about =
it.
>                  * Other endpoints will be handled by re-enumeration. */
>                 usb_ep0_reinit(udev);
> -               ret =3D hub_port_init(parent_hub, udev, port1, i);
> +               ret =3D hub_port_init(parent_hub, udev, port1, i, &descri=
ptor);
Looks like this is the only caller that passes &descriptor, and it
just checks that it didn't change. Would it make sense to put the
enitre descriptors_changed stanza in hub_port_init, for the re-init
case?


>                 if (ret >=3D 0 || ret =3D=3D -ENOTCONN || ret =3D=3D -ENO=
DEV)
>                         break;
>         }
> @@ -6030,7 +6076,6 @@ static int usb_reset_and_verify_device(s
>         /* Device might have changed firmware (DFU or similar) */
>         if (descriptors_changed(udev, &descriptor, bos)) {
>                 dev_info(&udev->dev, "device firmware changed\n");
> -               udev->descriptor =3D descriptor;  /* for disconnect() cal=
ls */
>                 goto re_enumerate;
>         }
>
> Index: usb-devel/drivers/usb/core/hcd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/hcd.c
> +++ usb-devel/drivers/usb/core/hcd.c
> @@ -983,6 +983,7 @@ static int register_root_hub(struct usb_
>  {
>         struct device *parent_dev =3D hcd->self.controller;
>         struct usb_device *usb_dev =3D hcd->self.root_hub;
> +       struct usb_device_descriptor *descr;
>         const int devnum =3D 1;
>         int retval;
>
> @@ -994,13 +995,16 @@ static int register_root_hub(struct usb_
>         mutex_lock(&usb_bus_idr_lock);
>
>         usb_dev->ep0.desc.wMaxPacketSize =3D cpu_to_le16(64);
> -       retval =3D usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE)=
;
> -       if (retval !=3D sizeof usb_dev->descriptor) {
> +       descr =3D usb_get_device_descriptor(usb_dev);
> +       if (IS_ERR(descr)) {
> +               retval =3D PTR_ERR(descr);
>                 mutex_unlock(&usb_bus_idr_lock);
>                 dev_dbg (parent_dev, "can't read %s device descriptor %d\=
n",
>                                 dev_name(&usb_dev->dev), retval);
> -               return (retval < 0) ? retval : -EMSGSIZE;
> +               return retval;
>         }
> +       usb_dev->descriptor =3D *descr;
> +       kfree(descr);
>
>         if (le16_to_cpu(usb_dev->descriptor.bcdUSB) >=3D 0x0201) {
>                 retval =3D usb_get_bos_descriptor(usb_dev);
> Index: usb-devel/drivers/usb/core/message.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/message.c
> +++ usb-devel/drivers/usb/core/message.c
> @@ -1040,40 +1040,35 @@ char *usb_cache_string(struct usb_device
>  EXPORT_SYMBOL_GPL(usb_cache_string);
>
>  /*
> - * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
> - * @dev: the device whose device descriptor is being updated
> - * @size: how much of the descriptor to read
> + * usb_get_device_descriptor - read the device descriptor
> + * @udev: the device whose device descriptor should be read
>   *
>   * Context: task context, might sleep.
>   *
> - * Updates the copy of the device descriptor stored in the device struct=
ure,
> - * which dedicates space for this purpose.
> - *
>   * Not exported, only for use by the core.  If drivers really want to re=
ad
>   * the device descriptor directly, they can call usb_get_descriptor() wi=
th
>   * type =3D USB_DT_DEVICE and index =3D 0.
>   *
> - * This call is synchronous, and may not be used in an interrupt context=
.
> - *
> - * Return: The number of bytes received on success, or else the status c=
ode
> - * returned by the underlying usb_control_msg() call.
> + * Returns: a pointer to a dynamically allocated usb_device_descriptor
> + * structure (which the caller must deallocate), or an ERR_PTR value.
>   */
> -int usb_get_device_descriptor(struct usb_device *dev, unsigned int size)
> +struct usb_device_descriptor *usb_get_device_descriptor(struct usb_devic=
e *udev)
>  {
>         struct usb_device_descriptor *desc;
>         int ret;
>
> -       if (size > sizeof(*desc))
> -               return -EINVAL;
>         desc =3D kmalloc(sizeof(*desc), GFP_NOIO);
>         if (!desc)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
> +
> +       ret =3D usb_get_descriptor(udev, USB_DT_DEVICE, 0, desc, sizeof(*=
desc));
> +       if (ret =3D=3D sizeof(*desc))
> +               return desc;
>
> -       ret =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
>         if (ret >=3D 0)
> -               memcpy(&dev->descriptor, desc, size);
> +               ret =3D -EMSGSIZE;
>         kfree(desc);
> -       return ret;
> +       return ERR_PTR(ret);
>  }
>
>  /*
> Index: usb-devel/drivers/usb/core/usb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/usb.h
> +++ usb-devel/drivers/usb/core/usb.h
> @@ -43,8 +43,8 @@ extern bool usb_endpoint_is_ignored(stru
>                 struct usb_endpoint_descriptor *epd);
>  extern int usb_remove_device(struct usb_device *udev);
>
> -extern int usb_get_device_descriptor(struct usb_device *dev,
> -               unsigned int size);
> +extern struct usb_device_descriptor *usb_get_device_descriptor(
> +               struct usb_device *udev);
>  extern int usb_set_isoch_delay(struct usb_device *dev);
>  extern int usb_get_bos_descriptor(struct usb_device *dev);
>  extern void usb_release_bos_descriptor(struct usb_device *dev);

--000000000000386bc7060155c468
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNQwggO8oAMCAQICEAGy8e6bI55p/yISlXXG
SrAwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA3MTYw
NzQ1MTRaFw0yNDAxMTIwNzQ1MTRaMCIxIDAeBgkqhkiG9w0BCQEWEWtoYXpoeUBnb29nbGUuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA84UGa4X1/brS7/2vQRLnjHc/oa9+4lri
stpvdNGyJgDZNvJouUxTihNXyW4exVS4rkaD+DjMOTcoxFy+KEAzrIzotas1NbZt4P7DTJ9Dp6/1
20YUAt9rnWmZNHmuzZNGlRYhzAAOaDkGhKFnULS1bItsuRmuPA1st6vd7GiVA00TiflQ7IYni7ZN
fd1TDheOc7OGHW6PcHPW0P0HGTzzvTpgTKQi4ojKre0fW/Yb0lZEVpBiadSj9MeDn5/f0yUpeFYD
fll7rnq2bPGOfS3JjwLalgVSl5Ho6txXv9vlJVYxgnAoNZsZJ2EHvsT7eUQYNHg5an0nClXZYIF7
p2YQGQIDAQABo4IB0jCCAc4wHAYDVR0RBBUwE4ERa2hhemh5QGdvb2dsZS5jb20wDgYDVR0PAQH/
BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAdBgNVHQ4EFgQUKmFDbOAVaL0O
2d1HymA53tUP1hUwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADeZduKRV5+J7StRkfoY
hBDfCkyRbFphFmeJ+0A1fPxECLLkrXR2izyctzMAGZH2ceScAlECO1r3aEQcyx9n7/YlMc24ZF0I
++9b72/wv6J6POICeIj6MgschmHIUz4Rw4H5IdBLo62N0jBBzv2T9ASRAl7Yryl6tHUN5X5228Tt
3LJe5Gtb1cm22DdXBM3xnD7Kd59ls9j/tz5I+yEsLIK7zQk7hBt87a31T55CTVgMQZ4lTavG5vdz
vEb7YC0jFAT8SmYmtSOr+4aZJRIwVjXlI04Mfr3jcbqDnzfv0VgVp5UlzQK4aApofbSsSDeXsDR+
t30gEkeMNUvUqd6PaxYxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAGy8e6bI55p/yISlXXGSrAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFmOsHal
i3RUMlaPLLz9DHFdwfqCb7ntbSGGbYXXgUjOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDcyNTIwNDIxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDRCPGBL4zpzPffeNZxdu0WYpF6
saBG9cXCThfz5enZ2kp1MpoIjpP/VJ+utkzPWwc7+ewS78QegutbNBWrWDabUWGahCP1ip/jNkIO
Ll0TMtukz6gm2Wm2HJPU84y2i3HNx+oXPjKB1q7gVqUOK3qJCAcCexkeVRO//dK/2PnxGnaPFiOy
x2JRc1uh0THvTWEoKVipHHVr3nUZFEKhTgGHLyCfZuKIJUT90HfnxgEy7DIuzx1EqyduoWdumv9j
Io/pijygmbpnY10YjaFwz4g5y8XqfApBnZLwLave93Vnl32+PNGEm4jpyt1LGryJNH1QT0U0oCkT
LB4C7aCXy4CA
--000000000000386bc7060155c468--
