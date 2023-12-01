Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB08002ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbjLAFPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377434AbjLAFPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D50310E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701407753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHwmJNsb+e2xdb/Uv7JTIMOAPZD+rYanzUJIDl9T/t0=;
        b=Asuarcxwquj4hxA/WL97CdQvCe04Zx3H5Opn6MrIgwkHo0NE13UDavWcRlfl3ZKdwB2pPl
        xOPiwBVXgHYXicrloohIVXnmza08MJmsEyREISxj0SZ/CRKME3RsfIZleot3VzF2RWPxdB
        xqQpvEnKZal4peFRskqRS4B3Td4jmtI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-NcYGog6lPu-96e0ZmB_uyQ-1; Fri, 01 Dec 2023 00:15:52 -0500
X-MC-Unique: NcYGog6lPu-96e0ZmB_uyQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bd74b7869so569993e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701407750; x=1702012550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHwmJNsb+e2xdb/Uv7JTIMOAPZD+rYanzUJIDl9T/t0=;
        b=N//642EXmAozttVn0lgXkqAcQzyhnSEd5kco1AWo16OPwSjXcSKj7ZezVTI7oelZF5
         O6BYv/0PRKdvivDgRj1MQyWKlp06Sxm+LgMwWV5QZCAw0O+xYYTmZsv1nd8LO1omrXWK
         2JeK/Dnd5JHhWQrtHlNjrrcc7nKvAucK+4IrAl1KSwjau4OACHV3CT8/8MDdwoIXQonO
         vARP2rNlZ80WO5rJVpWFHDbGUer8ZLMAWbCPRKcC7s5LcVYSrpvgE90SzqxF7QbP4iLO
         L0qjL2BTDdpXevxCZGgOpv0XxYjgB6YCab+yijczr0iMG6jG3FkPfoSgGQWnA+66BRU8
         Z4hw==
X-Gm-Message-State: AOJu0Yz2K2IMV4OmqNKR+Xe0yUlaALZAV4uBTTWQqIfIn85bATkmmtKK
        5Rql9BeCUox8CYygoczmu7JocMtBICLQbjol5Zjktfc1tyvO43qMowQrboAGXjCp02Cw83WX7ky
        e3+evpYgkPcpPwiAKdRK+Jq6Gw7eSHtMSb+uizvMWc0UZpl+7fIw=
X-Received: by 2002:a19:5507:0:b0:50b:d944:c01c with SMTP id n7-20020a195507000000b0050bd944c01cmr120851lfe.222.1701407750231;
        Thu, 30 Nov 2023 21:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDBmetXyWF5RpBUSGtpgeHdSYlEbcjte2vsAB88zgUOH9Pe6a2lbEGXksrcRpWFGOS8rAg498bSWjWs3JsMxo=
X-Received: by 2002:a19:5507:0:b0:50b:d944:c01c with SMTP id
 n7-20020a195507000000b0050bd944c01cmr120809lfe.222.1701407744848; Thu, 30 Nov
 2023 21:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com> <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
 <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com> <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
 <20231130044045-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231130044045-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Dec 2023 13:15:32 +0800
Message-ID: <CACGkMEuvnmif_pBJRqAER3wuYmF_ebzgRnKwwUnHMH4kv2XrFQ@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        xuanzhuo@linux.alibaba.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, shannon.nelson@amd.com,
        yuanyaogoog@chromium.org, yuehaibing@huawei.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Nov 29, 2023 at 06:20:31PM +0800, Jason Wang wrote:
> > On Wed, Nov 29, 2023 at 6:12=E2=80=AFPM Ning, Hongyu
> > <hongyu.ning@linux.intel.com> wrote:
> > >
> > >
> > > On 2023/11/29 17:16, Jason Wang wrote:
> > > > On Wed, Nov 29, 2023 at 5:05=E2=80=AFPM Ning, Hongyu
> > > > <hongyu.ning@linux.intel.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> > > >>> The following changes since commit 2dde18cd1d8fac735875f2e4987f11=
817cc0bc2c:
> > > >>>
> > > >>>     Linux 6.5 (2023-08-27 14:49:51 -0700)
> > > >>>
> > > >>> are available in the Git repository at:
> > > >>>
> > > >>>     https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git=
 tags/for_linus
> > > >>>
> > > >>> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb28=
81b9ab:
> > > >>>
> > > >>>     virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (=
2023-09-03 18:10:24 -0400)
> > > >>>
> > > >>> ----------------------------------------------------------------
> > > >>> virtio: features
> > > >>>
> > > >>> a small pull request this time around, mostly because the
> > > >>> vduse network got postponed to next relase so we can be sure
> > > >>> we got the security store right.
> > > >>>
> > > >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >>>
> > > >>> ----------------------------------------------------------------
> > > >>> Eugenio P=C3=A9rez (4):
> > > >>>         vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> > > >>>         vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backe=
nd feature
> > > >>>         vdpa: add get_backend_features vdpa operation
> > > >>>         vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> > > >>>
> > > >>> Jason Wang (1):
> > > >>>         virtio_vdpa: build affinity masks conditionally
> > > >>>
> > > >>> Xuan Zhuo (12):
> > > >>>         virtio_ring: check use_dma_api before unmap desc for indi=
rect
> > > >>>         virtio_ring: put mapping error check in vring_map_one_sg
> > > >>>         virtio_ring: introduce virtqueue_set_dma_premapped()
> > > >>>         virtio_ring: support add premapped buf
> > > >>>         virtio_ring: introduce virtqueue_dma_dev()
> > > >>>         virtio_ring: skip unmap for premapped
> > > >>>         virtio_ring: correct the expression of the description of=
 virtqueue_resize()
> > > >>>         virtio_ring: separate the logic of reset/enable from virt=
queue_resize
> > > >>>         virtio_ring: introduce virtqueue_reset()
> > > >>>         virtio_ring: introduce dma map api for virtqueue
> > > >>>         virtio_ring: introduce dma sync api for virtqueue
> > > >>>         virtio_net: merge dma operations when filling mergeable b=
uffers
> > > >>
> > > >> Hi,
> > > >> above patch (upstream commit 295525e29a5b) seems causing a virtnet
> > > >> related Call Trace after WARNING from kernel/dma/debug.c.
> > > >>
> > > >> details (log and test setup) tracked in
> > > >> https://bugzilla.kernel.org/show_bug.cgi?id=3D218204
> > > >>
> > > >> it's recently noticed in a TDX guest testing since v6.6.0 release =
cycle
> > > >> and can still be reproduced in latest v6.7.0-rc3.
> > > >>
> > > >> as local bisects results show, above WARNING and Call Trace is lin=
ked
> > > >> with this patch, do you mind to take a look?
> > > >
> > > > Looks like virtqueue_dma_sync_single_range_for_cpu() use
> > > > DMA_BIDIRECTIONAL unconditionally.
> > > >
> > > > We should use dir here.
> > > >
> > > > Mind to try?
> > > >
> > > > Thanks
> > > >
> > >
> > > sure, but what I see in the code
> > > virtqueue_dma_sync_single_range_for_cpu() is using DMA_FROM_DEVICE,
> > > probably I misunderstood your point?
> > >
> > > Please let me know any patch/setting to try here.
> >
> > Something like attached.  (Not even compiling test).
> >
> > Thanks
>
> Forwarding it inline for the record - I am not sure all the
> 0 day machinery handles attachments. Jason given it's reported to work
> can you please repost properly with a full commit log etc?
> I think we also need to fix virtqueue_dma_sync_single_range_for_device -
> please include that too.

Yes, want to sent something like this yesterday but it was interrupted
by other tasks.

I see Xuan has posted a patch, I will ack on that.

Thanks

>
>
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 29 Nov 2023 17:14:15 +0800
> Subject: [PATCH] virtio_ring: fix DMA dir during sync
> Content-type: text/plain
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 81ecb29c88f1..91d869814373 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3220,7 +3220,7 @@ void virtqueue_dma_sync_single_range_for_cpu(struct=
 virtqueue *_vq,
>                 return;
>
>         dma_sync_single_range_for_cpu(dev, addr, offset, size,
> -                                     DMA_BIDIRECTIONAL);
> +                                     dir);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
>
> --
> 2.42.0
>

