Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E57EFF37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKRLTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:19:33 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5907D6C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:19:30 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35af6c7d651so25725ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700306370; x=1700911170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mXzei30XPfojsWoW6UyD1YAWlbEa6U1UF+CvYmj/CQ=;
        b=ibfoj5mIeTND+MC5MZ502LSUUMxEJ9udPGWnJSp8CyMguXbkandINcT6dQhudtieRC
         yl2X5I6hajmfkkjy1JmmhkyoyY1YzthsQ1DdyaZBk45D/jVtSsJJbi8HzEBnP8G6+UYU
         qq+QKiD3zyZNWmYAZdJDZ87M7ZYeJ/xlxeWB5G9alE2vSHc1PPa5LgwjG0T+4qB0Phhq
         /SVYIJXNibhBN3nS0nmHcDkA/YoX2XxoHztUmTl7l5rzWwHyUTjO51MqIEujEq97YwOA
         fSlGgMa5Cqx/pZJCyHSw46Oi5fmx5WjYe5Sg+UJlEiAERPDElLardk3s1s/XVW7gb+bf
         kXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306370; x=1700911170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mXzei30XPfojsWoW6UyD1YAWlbEa6U1UF+CvYmj/CQ=;
        b=qrKIHyNY8PJj/W5jH4MAFjx3YbbBV+5I9JJe+wrsxutREs7waRfnOL4La8B8fSvj0b
         dqljVKNWtNO4pNrqCUNtqvfiCi7GXQH6bJADZG9F2qAdowJL8Rg6fZeiBmCbHMiFzNLB
         T971mE547Gr1gDZxjb6FK3IjItPy84pCLCkgQ+oahA1sBbgmRnqjaTvmperw3ei2hhDT
         6gLI5jrgPukaXEg2smK2qS/Fjy961c9BY9vHLTy2qxqC9zpLXAfcZgTUbVtLZbO05SVo
         STTPKVymYLzXSQX3KXl8D/8CmX+6Qa5n3mX5bEjQ+s8qMgAWXbSH7ecvZt4NPnfh2VkG
         p54Q==
X-Gm-Message-State: AOJu0YwhNUutcZZys8jU8FuX6YlDSJNiPip3KHGHrLj78Dx2cGQSr9AM
        wv+w/GcXzTHsk+HAiOpyFVyhKKQVsZiZw6pI1w8odyzpjSJ5/wM2Q08k12d4
X-Google-Smtp-Source: AGHT+IGOn/zzQ7G1UK58Zj6xuIf5lsPrUjWReoW3D9N+rmfxmKFTGNEa8xKW+VgR5ZRTJS+ZPW3gS7qZy29C5p7K97Y=
X-Received: by 2002:a05:6e02:1d0c:b0:35a:f9b0:10e3 with SMTP id
 i12-20020a056e021d0c00b0035af9b010e3mr14099ila.13.1700306369808; Sat, 18 Nov
 2023 03:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20231117072131.2886406-1-khtsai@google.com> <2023111705-showroom-consonant-7a7b@gregkh>
In-Reply-To: <2023111705-showroom-consonant-7a7b@gregkh>
From:   Kuen-Han Tsai <khtsai@google.com>
Date:   Sat, 18 Nov 2023 19:19:03 +0800
Message-ID: <CAKzKK0pB7V52krSzGL4f2C_dxwM8Au=8tgrcNUO0zvXz6Uwzcg@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Greg

On Fri, Nov 17, 2023 at 9:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Nov 17, 2023 at 03:21:28PM +0800, Kuen-Han Tsai wrote:
> > The null pointer dereference happens when xhci_free_dev() frees the
> > xhci->devs[slot_id] virtual device while xhci_urb_enqueue() is
> > processing a urb and checking the max packet size.
> >
> > [106913.850735][ T2068] usb 2-1: USB disconnect, device number 2
> > [106913.856999][ T4618] Unable to handle kernel NULL pointer dereferenc=
e at virtual address 0000000000000010
> > [106913.857488][ T4618] Call trace:
> > [106913.857491][ T4618]  xhci_check_maxpacket+0x30/0x2dc
> > [106913.857494][ T4618]  xhci_urb_enqueue+0x24c/0x47c
> > [106913.857498][ T4618]  usb_hcd_submit_urb+0x1f4/0xf34
> > [106913.857501][ T4618]  usb_submit_urb+0x4b8/0x4fc
> > [106913.857503][ T4618]  usb_control_msg+0x144/0x238
> > [106913.857507][ T4618]  do_proc_control+0x1f0/0x5bc
> > [106913.857509][ T4618]  usbdev_ioctl+0xdd8/0x15a8
> >
> > This patch adds a spinlock to the xhci_urb_enqueue function to make sur=
e
> > xhci_free_dev() and xhci_urb_enqueue() do not race and cause null
> > pointer dereference.
>
> I thought we had a lock for this already, what changed to cause this to
> start triggering now, all these years later?

Right, there is a lock in place for xhci_urb_enqueue(), but it doesn't
protect all code segments that use xhci->devs[slot_id] within the
function. I couldn't identify any specific changes that might have
introduced this issue. It's likely a long-standing potential problem
that's difficult to trigger under normal situations.

This issue happens when the USB enumeration process is complete, and a
user space program submits a control request to the peripheral, but
then the device is rapidly disconnected. I was able to reproduce this
issue by introducing a 3-second delay within xhci_check_maxpacket()
and disconnecting the peripheral while observing that the control
request is being processed by xhci_check_maxpacket().

>
> >
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
>
> What commit id does this fix?

Should I include a "Fixes:" header even if this patch doesn't address
a bug from a specific commit?

>
>
> > ---
> >  drivers/usb/host/xhci.c | 38 ++++++++++++++++++++++++--------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 884b0898d9c9..e0766ebeff0e 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1522,23 +1522,32 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd=
, struct urb *urb, gfp_t mem_flag
> >       struct urb_priv *urb_priv;
> >       int num_tds;
> >
> > -     if (!urb)
> > -             return -EINVAL;
> > -     ret =3D xhci_check_args(hcd, urb->dev, urb->ep,
> > -                                     true, true, __func__);
> > -     if (ret <=3D 0)
> > -             return ret ? ret : -EINVAL;
> > +     spin_lock_irqsave(&xhci->lock, flags);
> > +
> > +     if (!urb) {
> > +             ret =3D -EINVAL;
> > +             goto done;
> > +     }
>
> Why does this have to be inside the lock?  The urb can't change here,
> can it?

You're right, no need to place those inside the lock. I will move them
out of the protection.

>
> > +
> > +     ret =3D xhci_check_args(hcd, urb->dev, urb->ep, true, true, __fun=
c__);
> > +     if (ret <=3D 0) {
> > +             ret =3D ret ? ret : -EINVAL;
> > +             goto done;
> > +     }
> >
> >       slot_id =3D urb->dev->slot_id;
> >       ep_index =3D xhci_get_endpoint_index(&urb->ep->desc);
> >       ep_state =3D &xhci->devs[slot_id]->eps[ep_index].ep_state;
> >
> > -     if (!HCD_HW_ACCESSIBLE(hcd))
> > -             return -ESHUTDOWN;
> > +     if (!HCD_HW_ACCESSIBLE(hcd)) {
> > +             ret =3D -ESHUTDOWN;
> > +             goto done;
>
> Note, we now have completions, so all of this "goto done" doesn't need
> to happen anymore.  Not a complaint, just a suggestion for future
> changes or this one, your choice.
>

I'm not familiar with the concept of 'completions'. Can you please
provide some links or explanations to help me understand it? I use a
'goto done' statement because I follow this pattern seen in many
previous commits. However, I'm willing to modify this approach if
there's a more suitable alternative.

Please forgive me if any of my questions seem overly basic. I'm still
in the process of learning how to contribute to the kernel community.

Thanks,
Kuen-Han

> thanks,
>
> greg k-h
