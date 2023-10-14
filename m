Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE097C9536
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjJNPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 11:49:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E32A1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 08:49:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so5230526a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697298586; x=1697903386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRaP3B8APc0QjJRRLVqcvono0/aZBTuKQ1vWSapHFgk=;
        b=FwDrlOZsPYloFtl9w86+Ft6xNu+58vU0G1DBMSs7PSFlhFaIttZ9gpf3xfknrocCIP
         C43ct91OBWy5qvFfYoWuNVim8xfT3o6qdd/y+XpVks6GnMWUuNpNT+xs70nHcqlx4rNv
         19w6Pkez+Wtnxno/pj6VjPA7+5uGFDUkSLHXM4DnsmWT8p7dNT6TDWTokdPq2Ny+Zrex
         2n34aCqaf4mAzzUfJYp+u8ln8vOHFvf5tUoAW2ynz1ufFHaE9dofUVsE3SRmCHteMvuV
         HWg6vy/J4BGwUkwHv87zLuarf8VDYD+3S2bbLCTLqW6VVmHmBCS/HHKSN/y7kFlakE0i
         3cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697298586; x=1697903386;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRaP3B8APc0QjJRRLVqcvono0/aZBTuKQ1vWSapHFgk=;
        b=kQeQwCQH7R9OUbN8x7xiDoCNOwZgNJMg2B6YzoMczAhGtEFDUjlTxMwPRwUo1Qw5mp
         qbhBAErc2Oi2Skg2JRWft3w4qjWtzF6ebfUOZG9jfjV5+omW+M4xiglc0R7ydNvgkEGa
         KAWn9lf/z+miiND7MRvvZ2lDYs8bB3ZklMviMCq/LLbP8ubs9DT18oB1Fuvyac2aLEKI
         1RGQ1GXW30faCYiVOsH6UN9Vw9TrcBhLW4i6ZsYSvok9Kjt4wWpovVZWOPpn8cdB6jB6
         YY2Z4XP+ue0cDIzAfzlviParEMzW3NNsSofgxByUZ0mTvwTvQwKBgV/CzclYV9R7TaAn
         u/fA==
X-Gm-Message-State: AOJu0YwKs23u/mx0IddiwF206mAqPs388hTpzo6JnJ3Ufe6LvhGy4EH/
        snaQPZC/ByHD6//6gr//2+NWPA==
X-Google-Smtp-Source: AGHT+IHOPLIM5HFm5fcWPLjz5lPglOLQqXJt1+y7SX0ijIjWPGhqc2RNXci34nt+pri9vzCQwWrx8A==
X-Received: by 2002:a05:6402:1859:b0:530:74ed:fc8a with SMTP id v25-20020a056402185900b0053074edfc8amr25516936edy.41.1697298585500;
        Sat, 14 Oct 2023 08:49:45 -0700 (PDT)
Received: from cloudflare.com (79.184.153.26.ipv4.supernova.orange.pl. [79.184.153.26])
        by smtp.gmail.com with ESMTPSA id dm9-20020a05640222c900b0053db1ca293asm5240698edb.19.2023.10.14.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 08:49:44 -0700 (PDT)
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
 <20230929-jakub-os-90-trim-v1-2-a3af0c08f812@cloudflare.com>
 <CACGkMEsFYJ7VsyLua2BuCbCCrntkrJ4eUrCUrojCrirRpNT4Aw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 2/2] virtio-mmio: Support multiple interrupts per device
Date:   Sat, 14 Oct 2023 12:49:38 +0200
In-reply-to: <CACGkMEsFYJ7VsyLua2BuCbCCrntkrJ4eUrCUrojCrirRpNT4Aw@mail.gmail.com>
Message-ID: <87o7h1dx0n.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in my response. I've been away at a conference.

On Tue, Oct 10, 2023 at 02:52 PM +08, Jason Wang wrote:
> On Sat, Sep 30, 2023 at 4:46=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Some virtual devices, such as the virtio network device, can use multiple
>> virtqueues (or multiple pairs of virtqueues in the case of a vNIC). In s=
uch
>> case, when there are multiple vCPUs present, it is possible to process
>> virtqueue events in parallel. Each vCPU can service a subset of all
>> virtqueues when notified that there is work to carry out.
>>
>> However, the current virtio-mmio transport implementation poses a
>> limitation. Only one vCPU can service notifications from any of the
>> virtqueues of a single virtio device. This is because a virtio-mmio devi=
ce
>> driver supports registering just one interrupt per device. With such set=
up
>> we are not able to scale virtqueue event processing among vCPUs.
>>
>> Now, with more than one IRQ resource registered for a virtio-mmio platfo=
rm
>> device, we can address this limitation.
>>
>> First, we request multiple IRQs when creating virtqueues for a device.
>>
>> Then, map each virtqueue to one of the IRQs assigned to the device. The
>> mapping is done in a device type specific manner. For instance, a network
>> device will want each RX/TX virtqueue pair mapped to a different IRQ
>> line. Other device types might require a different mapping scheme. We
>> currently provide a mapping for virtio-net device type.
>>
>> Finally, when handling an interrupt, we service only the virtqueues
>> associated with the IRQ line that triggered the event.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  drivers/virtio/virtio_mmio.c | 102 +++++++++++++++++++++++++++++++++++-=
-------
>>  1 file changed, 83 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 06a587b23542..180c51c27704 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c

[...]

>> @@ -488,6 +511,18 @@ static struct virtqueue *vm_setup_vq(struct virtio_=
device *vdev, unsigned int in
>>         return ERR_PTR(err);
>>  }
>>
>> +/* Map virtqueue to zero-based interrupt number */
>> +static unsigned int vq2irq(const struct virtqueue *vq)
>> +{
>> +       switch (vq->vdev->id.device) {
>> +       case VIRTIO_ID_NET:
>> +               /* interrupt shared by rx/tx virtqueue pair */
>> +               return vq->index / 2;
>> +       default:
>> +               return 0;
>> +       }
>
> Transport drivers should have no knowledge of a specific type of device.
>

Makes sense. This breaks layering. I will see how to pull this into the
device driver. Perhaps this can be communicated through set_vq_affinity
op.

>> +}
>> +
>>  static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>                        struct virtqueue *vqs[],
>>                        vq_callback_t *callbacks[],

[...]

>> @@ -519,12 +544,51 @@ static int vm_find_vqs(struct virtio_device *vdev,=
 unsigned int nvqs,
>>                 vqs[i] =3D vm_setup_vq(vdev, queue_idx++, callbacks[i], =
names[i],
>>                                      ctx ? ctx[i] : false);
>>                 if (IS_ERR(vqs[i])) {
>> -                       vm_del_vqs(vdev);
>> -                       return PTR_ERR(vqs[i]);
>> +                       err =3D PTR_ERR(vqs[i]);
>> +                       goto fail_vq;
>>                 }
>>         }
>>
>> +       nirqs =3D platform_irq_count(vm_dev->pdev);
>> +       if (nirqs < 0) {
>> +               err =3D nirqs;
>> +               goto fail_vq;
>> +       }
>> +
>> +       for (i =3D 0; i < nirqs; i++) {
>> +               irq =3D platform_get_irq(vm_dev->pdev, i);
>> +               if (irq < 0)
>> +                       goto fail_irq;
>> +               if (irq < irq_base)
>> +                       irq_base =3D irq;
>> +
>> +               err =3D devm_request_irq(&vdev->dev, irq, vm_interrupt,
>> +                                      IRQF_SHARED, NULL, vm_dev);
>> +               if (err)
>> +                       goto fail_irq;
>> +
>> +               if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wa=
keup-source"))
>> +                       enable_irq_wake(irq);
>
> Could we simply use the same policy as PCI (vp_find_vqs_msix())?

Reading that routine, the PCI policy is:

1) Best option: one for change interrupt, one per vq.
2) Second best: one for change, shared for all vqs.

Would be great to be able to go with option (1), but we have only a
limited number of legacy IRQs to spread among MMIO devices. 48 IRQs at
most in a 2 x IOAPIC setup.

Having one IRQ per VQ would mean less Rx/Tx queue pairs for a vNIC. Less
than 24 queue pairs. While, from our target workload PoV, ideally, we
would like to support at least 32 queue pairs.

Hence the idea to have one IRQ per Rx/Tx VQ pair. Not as ideal as (1),
but a lot better than (2).

Comparing this to PCI - virtio-net, with one interrupt per VQ, will map
each Rx/Tx VQ pair to the same CPU.

We could achieve the same VQ-CPU affinity setup for MMIO, but with less
interrupt vectors.

Thanks for feedback.
