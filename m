Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284B7FC15D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbjK1Pcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjK1Pc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:32:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3719810DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:32:35 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-423a125d23cso201511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701185554; x=1701790354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FQpu+gQGZx/HUmnzdPKYwdFMcPz6/CXU+VJJ2AKNog=;
        b=wNgPvYp0QvFO4cQ1PTqJHfGSO31VOQwr8tsapTgvc+d3qu2fUFfY3fhvBN3/0LAjU5
         tKaR0ffU8mpm50VGLwpufzzvW78p97M4i/j+MfstT/VZebm5ubPzuos8sSd3JTPDUgcR
         cPEsq9N5y+//AXZtJf4rkw7606bALeBV78RZzM6uhtLaXjeSAnPvB7c/7KDBcuciatwu
         CQiXQWoS0klpSOCaLJdO8uhse90u193vL9jpY+fMJ2LrXZclUchzt3y8TJK5v5grT4Iv
         A+sXI4uiQjL1Jp1FNKbUgPD4K7VD0tphUwllOya0R2OErfICzg+VBX+ZFVEoSwO5BI6X
         +7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185554; x=1701790354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FQpu+gQGZx/HUmnzdPKYwdFMcPz6/CXU+VJJ2AKNog=;
        b=BMXuoiT9F9J3t5wm/bjBhN5BTLAUc1jNSdfd0Yr6IYAy5C18t9OOx9Mn/4xHImjoRJ
         qMMIEzTcL22fSR+OPRD389GLnJRkGRytpQ/AfdfLvEtCbZE9Hq5rmsOieycvq8+RitHh
         2O7Wv8xGPrw6V0O+6hg3h4JBNlWg9RkhzammL0VM0U95rBkLf4uByBE/OobUtfeufLY5
         WAQMgprsPxX3KHK681/MpZogvh5cRaeDdJkvyXeE3gEj0BrpVpEJ/B9O6vy97+HwjB0z
         aVOQFJQwcRi8s7wYENh/3JX2PBMq4kcD7J/v3oo5gorWFGBw1o6z9mJwW7G7lMlnShLl
         L0Aw==
X-Gm-Message-State: AOJu0YxqRR4KXUpu31UKy1v2wOpHEPcei5gd7rKbtZMwvMCLvEgbOAyE
        1O5ItDzlDhV4LhKZ/ZrBqY1/hojC4MZAsZkwUkx12/5vcPRIzXxZvem32Q==
X-Google-Smtp-Source: AGHT+IHscMFMe234fY0HQueauYIa+yDhMXOf0niJQDE8hcYfUvRc0/0ycpTEyPOovwN/+jV6JBKsgXaJikkB2AE8wTw=
X-Received: by 2002:ac8:7f44:0:b0:420:e564:2fc7 with SMTP id
 g4-20020ac87f44000000b00420e5642fc7mr1233005qtk.7.1701185553980; Tue, 28 Nov
 2023 07:32:33 -0800 (PST)
MIME-Version: 1.0
References: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com> <20231128140141.1161490-1-mathias.nyman@linux.intel.com>
In-Reply-To: <20231128140141.1161490-1-mathias.nyman@linux.intel.com>
From:   Kuen-Han Tsai <khtsai@google.com>
Date:   Tue, 28 Nov 2023 23:32:06 +0800
Message-ID: <CAKzKK0psOFJdBsPkqdRi4_5V=5z9XMnFPCYbcE1Nj6A1zj8Gmw@mail.gmail.com>
Subject: Re: [RFT PATCH 1/2] xhci: Reconfigure endpoint 0 max packet size only
 during endpoint reset
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:00=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> The max packet size for full speed control endpoint 0 may vary. It is
> defined in the device descriptor, which is read using the same endpoint.
> Usb core sets a temporary max packet size value until the real value is
> read.
>
> xhci driver needs to reconfigure the endpoint context seen by the
> controller if the max packet size changes.
> It makes more sense to do this reconfiguration in xhci_endpoint_reset()
> instead of urb enqueue as usb core will call endpoint reset during
> enumeration if the max packet values differ.
> Max packet size adjustment for endpoinr 0 can only happen once per
> device enumeration.

s/endpoinr/endpoint

>
> Previously the max packet size was checked during every urb enqueue.
> This is an additional check for every enqueued urb, and also turned out
> to have locking issues as urbs may be queued in any context while xhci
> max packet size reconfiguration requires memory allocation, locking, and
> sleeping.
>
> Tested with a full speed device using both old and new scheme enumeration
> and a intentionally incorrect preliminary max packet size value.

s/a intentionally/an intentionally

>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci.c | 85 ++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 884b0898d9c9..df31d44498d6 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1438,10 +1438,8 @@ static int xhci_configure_endpoint(struct xhci_hcd=
 *xhci,
>   * descriptor.  If the usb_device's max packet size changes after that p=
oint,
>   * we need to issue an evaluate context command and wait on it.
>   */
> -static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot=
_id,
> -               unsigned int ep_index, struct urb *urb, gfp_t mem_flags)
> +static int xhci_check_ep0_maxpacket(struct xhci_hcd *xhci, struct xhci_v=
irt_device *vdev)
>  {
> -       struct xhci_container_ctx *out_ctx;
>         struct xhci_input_control_ctx *ctrl_ctx;
>         struct xhci_ep_ctx *ep_ctx;
>         struct xhci_command *command;
> @@ -1449,11 +1447,15 @@ static int xhci_check_maxpacket(struct xhci_hcd *=
xhci, unsigned int slot_id,
>         int hw_max_packet_size;
>         int ret =3D 0;
>
> -       out_ctx =3D xhci->devs[slot_id]->out_ctx;
> -       ep_ctx =3D xhci_get_ep_ctx(xhci, out_ctx, ep_index);
> +       ep_ctx =3D xhci_get_ep_ctx(xhci, vdev->out_ctx, 0);
>         hw_max_packet_size =3D MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_=
info2));
> -       max_packet_size =3D usb_endpoint_maxp(&urb->dev->ep0.desc);
> -       if (hw_max_packet_size !=3D max_packet_size) {
> +       max_packet_size =3D usb_endpoint_maxp(&vdev->udev->ep0.desc);
> +
> +       if (hw_max_packet_size =3D=3D max_packet_size)
> +               return 0;
> +
> +       switch (max_packet_size) {
> +       case 8: case 16: case 32: case 64: case 9:
>                 xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
>                                 "Max Packet Size for ep 0 changed.");
>                 xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
> @@ -1465,28 +1467,22 @@ static int xhci_check_maxpacket(struct xhci_hcd *=
xhci, unsigned int slot_id,
>                 xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
>                                 "Issuing evaluate context command.");
>
> -               /* Set up the input context flags for the command */
> -               /* FIXME: This won't work if a non-default control endpoi=
nt
> -                * changes max packet sizes.
> -                */
> -
> -               command =3D xhci_alloc_command(xhci, true, mem_flags);
> +               command =3D xhci_alloc_command(xhci, true, GFP_KERNEL);
>                 if (!command)
>                         return -ENOMEM;
>
> -               command->in_ctx =3D xhci->devs[slot_id]->in_ctx;
> +               command->in_ctx =3D vdev->in_ctx;
>                 ctrl_ctx =3D xhci_get_input_control_ctx(command->in_ctx);
>                 if (!ctrl_ctx) {
>                         xhci_warn(xhci, "%s: Could not get input context,=
 bad type.\n",
>                                         __func__);
>                         ret =3D -ENOMEM;
> -                       goto command_cleanup;
> +                       break;
>                 }
>                 /* Set up the modified control endpoint 0 */
> -               xhci_endpoint_copy(xhci, xhci->devs[slot_id]->in_ctx,
> -                               xhci->devs[slot_id]->out_ctx, ep_index);
> +               xhci_endpoint_copy(xhci, vdev->in_ctx, vdev->out_ctx, 0);
>
> -               ep_ctx =3D xhci_get_ep_ctx(xhci, command->in_ctx, ep_inde=
x);
> +               ep_ctx =3D xhci_get_ep_ctx(xhci, command->in_ctx, 0);
>                 ep_ctx->ep_info &=3D cpu_to_le32(~EP_STATE_MASK);/* must =
clear */
>                 ep_ctx->ep_info2 &=3D cpu_to_le32(~MAX_PACKET_MASK);
>                 ep_ctx->ep_info2 |=3D cpu_to_le32(MAX_PACKET(max_packet_s=
ize));
> @@ -1494,17 +1490,20 @@ static int xhci_check_maxpacket(struct xhci_hcd *=
xhci, unsigned int slot_id,
>                 ctrl_ctx->add_flags =3D cpu_to_le32(EP0_FLAG);
>                 ctrl_ctx->drop_flags =3D 0;
>
> -               ret =3D xhci_configure_endpoint(xhci, urb->dev, command,
> -                               true, false);
> -
> -               /* Clean up the input context for later use by bandwidth
> -                * functions.
> -                */
> +               ret =3D xhci_configure_endpoint(xhci, vdev->udev, command=
,
> +                                             true, false);
> +               /* Clean up the input context for later use by bandwidth =
functions */
>                 ctrl_ctx->add_flags =3D cpu_to_le32(SLOT_FLAG);
> -command_cleanup:
> -               kfree(command->completion);
> -               kfree(command);
> +               break;
> +       default:
> +               dev_dbg(&vdev->udev->dev, "incorrect max packet size %d f=
or ep0\n",
> +                       max_packet_size);
> +               return -EINVAL;
>         }
> +
> +       kfree(command->completion);
> +       kfree(command);
> +
>         return ret;
>  }
>
> @@ -1561,21 +1560,6 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, s=
truct urb *urb, gfp_t mem_flag
>
>         trace_xhci_urb_enqueue(urb);
>
> -       if (usb_endpoint_xfer_control(&urb->ep->desc)) {
> -               /* Check to see if the max packet size for the default co=
ntrol
> -                * endpoint changed during FS device enumeration
> -                */
> -               if (urb->dev->speed =3D=3D USB_SPEED_FULL) {
> -                       ret =3D xhci_check_maxpacket(xhci, slot_id,
> -                                       ep_index, urb, mem_flags);
> -                       if (ret < 0) {
> -                               xhci_urb_free_priv(urb_priv);
> -                               urb->hcpriv =3D NULL;
> -                               return ret;
> -                       }
> -               }
> -       }
> -
>         spin_lock_irqsave(&xhci->lock, flags);
>
>         if (xhci->xhc_state & XHCI_STATE_DYING) {
> @@ -3104,6 +3088,21 @@ static void xhci_endpoint_reset(struct usb_hcd *hc=
d,
>         int err;
>
>         xhci =3D hcd_to_xhci(hcd);
> +       ep_index =3D xhci_get_endpoint_index(&host_ep->desc);
> +
> +       /*
> +        * Usb core assumes a max packet value for ep0 on FS devices unti=
l the
> +        * real value is read from the descriptor. Core resets Ep0 if val=
ues
> +        * mismatch. Reconfigure the xhci ep0 endpoint context here in th=
at case
> +        */
> +       if (usb_endpoint_xfer_control(&host_ep->desc) && ep_index =3D=3D =
0) {
> +               udev =3D container_of(host_ep, struct usb_device, ep0);
> +               if (udev->speed =3D=3D USB_SPEED_FULL)
> +                       xhci_check_ep0_maxpacket(xhci, xhci->devs[udev->s=
lot_id]);
> +               /* Nothing else should be done here for ep0 during ep res=
et */
> +               return;
> +       }
> +

Could there be a race condition between the xhci_endpoint_reset() and
xhci_free_dev() functions, resulting in the xhci->devs[udev->slot_id]
becoming null?
If so, a null pointer dereference will happen in
xhci_check_ep0_maxpacket() when accessing vdev->out_ctx.

>         if (!host_ep->hcpriv)
>                 return;
>         udev =3D (struct usb_device *) host_ep->hcpriv;
> @@ -3116,7 +3115,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd=
,
>          */
>         if (!udev->slot_id || !vdev)
>                 return;
> -       ep_index =3D xhci_get_endpoint_index(&host_ep->desc);
> +
>         ep =3D &vdev->eps[ep_index];
>
>         /* Bail out if toggle is already being cleared by a endpoint rese=
t */
> --
> 2.25.1
>
