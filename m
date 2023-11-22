Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94E7F3E21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKVG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVG3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918797
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700634548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYiLN+NYmm2FZNZ/E8JaY2OSPBJ8zf7Tpgxd2EaiTPE=;
        b=JXV6656i4321APe3JY3y90bO5sLMfMfJtvb/nXYb4INq6qOsLttCUR+JUjD4kUob5gC5YQ
        EtSdqT0WgyfcbBpX50jftSyQ3KUckdzcGVVAtVG5AKdEYXPazFInwNA5wGUQ03QWjEeDAC
        CnY/QtUoSYVGQFi4r5KAncj4FpCtGHU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-8-vdQTocPcC4xLOcqCp3kw-1; Wed, 22 Nov 2023 01:29:06 -0500
X-MC-Unique: 8-vdQTocPcC4xLOcqCp3kw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50943cb2d96so344113e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700634545; x=1701239345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYiLN+NYmm2FZNZ/E8JaY2OSPBJ8zf7Tpgxd2EaiTPE=;
        b=vsZyOlwALblf+7D8OryK0sFrjjrNvvqz7i1nguOQK1/aO+7sgeZmD3PYOqFQBIAZo8
         kAML/FzZRZENEQukl1b1POlFkJfzVuroctFXhBqClxuZfDXctB7w/AyyiJOwie4wk+sR
         SrobweJ8tCJYPF8QZfEa4ErNxcpcZNn9MSlCnRneX3HRzwiaDAXLLMgtUvqJaY+R3cQC
         sv8pncPJP9FJWHd4lZYW2QD7njoJb00WJ8kM96IjWuadku2HPFaKXnraaaZE0ZOmRbFR
         1QPUMG7fopgj4gBQETu0MNYFUnBehmjEvkWJC4rtNIeCFGmkDRtx7uVxDYqYCNPli0dQ
         Z52g==
X-Gm-Message-State: AOJu0Yy9asnboV198bl6a35opoiObcNyJToLEmAJDzxBtJ69BNi1w8+5
        fLa813vFQlHG6iEH9WuH1ptwOIHsdkfWXnqEaH8gzQkoM/ryz7eS1Jq2DW3+fqBVPtqq7MzjRa9
        Lq1gco8kSVepfhPHvXTSDxQMohmKD/RNOKWnE3Zs1
X-Received: by 2002:a05:6512:110d:b0:50a:a31c:39b1 with SMTP id l13-20020a056512110d00b0050aa31c39b1mr1682512lfg.9.1700634545088;
        Tue, 21 Nov 2023 22:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvukzDNEO0N6oG4H6cZSL9X6OKo9AVsWv7vX5eLwZzUxW6KlaAJVI+M87pwFQ2YCbl6xoT9JNPSxONO70h6Qg=
X-Received: by 2002:a05:6512:110d:b0:50a:a31c:39b1 with SMTP id
 l13-20020a056512110d00b0050aa31c39b1mr1682503lfg.9.1700634544737; Tue, 21 Nov
 2023 22:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-4-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Nov 2023 14:28:53 +0800
Message-ID: <CACGkMEtzXS8GwRN_anprGEEJhoGxSbj8pBCTF22RPVL484fhYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> and The number of mapping memory pages from the kernel. The userspace
> App can use this information to map the pages.
>
> Add struct vhost_reconnect_data/vhost_reconnect_vring for sync the
> information in reconnection
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++
>  include/uapi/linux/vduse.h         | 50 ++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index ccb30e98bab5..d0fe9a7e86ab 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1343,6 +1343,21 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                 ret =3D 0;
>                 break;
>         }
> +       case VDUSE_GET_RECONNECT_INFO: {
> +               struct vduse_reconnect_mmap_info info;
> +
> +               ret =3D -EFAULT;
> +               if (copy_from_user(&info, argp, sizeof(info)))
> +                       break;
> +
> +               info.size =3D PAGE_SIZE;
> +               info.max_index =3D dev->vq_num + 1;

It looks to be both PAGE_SIZE and vq_num is the well knowledge that
doesn't require a query?

> +
> +               if (copy_to_user(argp, &info, sizeof(info)))
> +                       break;
> +               ret =3D 0;
> +               break;
> +       }
>         default:
>                 ret =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..c0b7133aebfd 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -3,6 +3,7 @@
>  #define _UAPI_VDUSE_H_
>
>  #include <linux/types.h>
> +#include <linux/virtio_net.h>
>
>  #define VDUSE_BASE     0x81
>
> @@ -350,4 +351,53 @@ struct vduse_dev_response {
>         };
>  };
>
> +/**
> + * struct vhost_reconnect_data - saved the reconnect info for device
> + * @version; version for userspace APP
> + * @reconnected: indetify if this is reconnected. userspace APP needs se=
t this bit to 1
> + *               while reconnecting.kernel will use this bit to indetify=
 if this is
> + *               reconnect

Typos.

> + * @features; Device features negotiated in the last connect.
> + * @status; Device status in last reconnect
> + * @nr_vrings; number of active vqs in last connect

What's the meaning of "active vqs"? Is it the #active_queue_pairs? If
yes, couldn't we get it from the virtio_net_config?

> + * @struct virtio_net_config config; the config in last connect
> + */
> +
> +struct vhost_reconnect_data {
> +       __u32 version;
> +       __u32 reconnected;
> +       __u64 features;
> +       __u8 status;
> +       __u32 nr_vrings;
> +       struct virtio_net_config config;

This seems like a layer violation. The fields here needs to be type
agnostic or we should introduce a new device specific area with a
union.

Or can we simply invent VDUSE_DEV_GET_CONFIG() to do this?

> +};
> +
> +/**
> + * struct vhost_reconnect_vring -saved the reconnect info for vqs
> + * when use split mode will only use last_avail_idx
> + * when use packed mode will use both last_avail_idx and avail_wrap_coun=
ter

How about last_used_idx and last_used_wrap_counter.

Btw, vDPA or vhost-vDPA has a good uAPI for this, can we reuse that?

Thanks

> + * userspace App
> + * @last_avail_idx: device last available index
> + * @avail_wrap_counter: Driver ring wrap counter
> + */
> +struct vhost_reconnect_vring {
> +       __u16 last_avail_idx;
> +       __u16 avail_wrap_counter;
> +};
> +
> +/**
> + * struct vduse_reconnect_mmap_info
> + * @size: mapping memory size, here we use page_size
> + * @max_index: the number of pages allocated in kernel,just
> + * use for sanity check
> + */
> +
> +struct vduse_reconnect_mmap_info {
> +       __u32 size;
> +       __u32 max_index;
> +};
> +
> +#define VDUSE_GET_RECONNECT_INFO \
> +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> +
>  #endif /* _UAPI_VDUSE_H_ */
> --
> 2.34.3
>

