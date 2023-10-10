Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1607BEF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379200AbjJJARY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379163AbjJJARW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:17:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FDDEA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:17:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so23178a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696897038; x=1697501838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbpsfjo6GOkC9l/3oGnFweGKSDLBO4JuGq7Dmzj4388=;
        b=QMDTg+NPIcTXOSgcmEaqAfIe5N1wq23pqCZzcQHGWR4ObkzlqwITJquwmXv5OaTzxJ
         /ILXblMQ3P2sBESe17GPGr9XNCaXVa1QDwFOm1R0ytdkaw78JxvZzb5Sf1T3Ypq3myUD
         Ny/2lhL2jgCPWMNjc35agHnF9dKbkpCgpA1WjGlVFjYX3iTSyrLGg9NrFpYMnc85XJbj
         xnIcE+w24QRA+MMK0bGXJefwdpaYbdqF3kr51Y/hbDxJbJlWxbA+dYgk0g2za/gQbahk
         kixcKSldAUmHftATShP2mcyiz0BE+Zk7jy2t2m6Q7Ky+iEnArv1/mvoB/Ku+CCpK4Pra
         JorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696897038; x=1697501838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbpsfjo6GOkC9l/3oGnFweGKSDLBO4JuGq7Dmzj4388=;
        b=YLZYnn928WzD3UKd5eHieJ76UXFF5yeeaAlEaZ0fWPi5DKM9ng3jdVGt/ilti2WfTl
         AGdcXl9QYXo2wyg1e0HEd9tWxaeMQis87M4c3/cUk1IvWEz8VBVqWFpHFBqQKhsvkwVK
         /WPRQn0oICpt+VOxgK6UmWTXkIfKMTiv49oyiDHIijc9k2my7XHyISwzbGhoSXgetJ/q
         xma2CKgQx39CEusWpmf2U3FhmQQDalR8cqxcCfcntNQxieEfw2BiaaOelLi0mEF063rj
         xn6ihwJfDkU+ddXIOdWN4JMwTyfFUo/C/8J32q13fzHu3T3MxSsWUbPefjaBtsTPSanE
         0JXQ==
X-Gm-Message-State: AOJu0YxcX3V1/jhJBbsoFpQwCLyzv+50kMSuwvxWpAE0j0OdCJ8sbGCz
        LBpnZ0fQZl88Pm9k/8/u/j0za5Q7rdou32QsuKSqXQ==
X-Google-Smtp-Source: AGHT+IEb7gxdmkBjFZXzY/fBb75uod5hRDT+1MLvij7dzpeqOEq6or3qdT1aKk63tNgo/vsO+Jauj8tCXru3q7NGz1M=
X-Received: by 2002:a50:ba81:0:b0:538:5554:708a with SMTP id
 x1-20020a50ba81000000b005385554708amr463667ede.2.1696897038268; Mon, 09 Oct
 2023 17:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231009142005.21338-1-quic_kriskura@quicinc.com> <20231009142005.21338-2-quic_kriskura@quicinc.com>
In-Reply-To: <20231009142005.21338-2-quic_kriskura@quicinc.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 9 Oct 2023 17:17:02 -0700
Message-ID: <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:20=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> Currently the NCM driver restricts wMaxSegmentSize that indicates
> the datagram size coming from network layer to 1514. However the
> spec doesn't have any limitation. For P2P connections over NCM,
> increasing MTU helps increasing throughput.
>
> Add support to configure this value before configfs symlink is
> created. Also since the NTB Out/In buffer sizes are fixed at 16384
> bytes, limit the segment size to an upper cap of 15014. Set the
> default MTU size for the ncm interface during function bind before
> network interface is registered allowing MTU to be set in parity
> with wMaxSegmentSize.
>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
>  drivers/usb/gadget/function/u_ncm.h |  2 ++
>  2 files changed, 53 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index feccf4c8cc4f..eab297b22200 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_fu=
nction *f)
>  /* Delay for the transmit to wait before sending an unfilled NTB frame. =
*/
>  #define TX_TIMEOUT_NSECS       300000
>
> +#define MAX_DATAGRAM_SIZE      15014
> +
>  #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>                                  USB_CDC_NCM_NTB32_SUPPORTED)
>
> @@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, st=
ruct usb_function *f)
>         ncm_opts =3D container_of(f->fi, struct f_ncm_opts, func_inst);
>
>         if (cdev->use_os_string) {
> +               ncm_opts->net->mtu =3D (ncm_opts->max_segment_size - ETH_=
HLEN);
>                 f->os_desc_table =3D kzalloc(sizeof(*f->os_desc_table),
>                                            GFP_KERNEL);
>                 if (!f->os_desc_table)
> @@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, st=
ruct usb_function *f)
>
>         status =3D -ENODEV;
>
> +       ecm_desc.wMaxSegmentSize =3D ncm_opts->max_segment_size;

I think you need byte swap here.

> +
>         /* allocate instance-specific endpoints */
>         ep =3D usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>         if (!ep)
> @@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>  /* f_ncm_opts_ifname */
>  USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>
> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
> +                                             char *page)
> +{
> +       struct f_ncm_opts *opts =3D to_f_ncm_opts(item);
> +       u32 segment_size;
> +
> +       mutex_lock(&opts->lock);
> +       segment_size =3D opts->max_segment_size;
> +       mutex_unlock(&opts->lock);
> +
> +       return sprintf(page, "%u\n", segment_size);
> +}
> +
> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
> +                                              const char *page, size_t l=
en)
> +{
> +       struct f_ncm_opts *opts =3D to_f_ncm_opts(item);
> +       int ret;
> +       u32 segment_size;
> +
> +       mutex_lock(&opts->lock);
> +       if (opts->refcnt) {
> +               ret =3D -EBUSY;
> +               goto out;
> +       }
> +
> +       ret =3D kstrtou32(page, 0, &segment_size);
> +       if (ret)
> +               goto out;
> +
> +       if (segment_size > MAX_DATAGRAM_SIZE) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       opts->max_segment_size =3D segment_size;
> +       ret =3D len;
> +out:
> +       mutex_unlock(&opts->lock);
> +       return ret;
> +}
> +
> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
> +
>  static struct configfs_attribute *ncm_attrs[] =3D {
>         &ncm_opts_attr_dev_addr,
>         &ncm_opts_attr_host_addr,
>         &ncm_opts_attr_qmult,
>         &ncm_opts_attr_ifname,
> +       &ncm_opts_attr_max_segment_size,
>         NULL,
>  };
>
> @@ -1616,6 +1666,7 @@ static struct usb_function_instance *ncm_alloc_inst=
(void)
>                 kfree(opts);
>                 return ERR_CAST(net);
>         }
> +       opts->max_segment_size =3D cpu_to_le16(ETH_FRAME_LEN);

and not here.  ie. max_segment_size should be native endian

>         INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>
>         descs[0] =3D &opts->ncm_os_desc;
> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/fun=
ction/u_ncm.h
> index 5408854d8407..d3403cf13f17 100644
> --- a/drivers/usb/gadget/function/u_ncm.h
> +++ b/drivers/usb/gadget/function/u_ncm.h
> @@ -31,6 +31,8 @@ struct f_ncm_opts {
>          */
>         struct mutex                    lock;
>         int                             refcnt;
> +
> +       u32                             max_segment_size;
>  };
>
>  #endif /* U_NCM_H */
> --
> 2.42.0
>

That said, I don't really follow what this is doing...

Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
