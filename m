Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C997CC50B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJQNpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQNpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726FEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697550280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tLalsWUBQv2eaq8XqLFym011Xwo+8KxiqgnVaF0bHE=;
        b=irzrp/yG6RNf0nP9uQLrl522mJ/hSw9CBvonQDS1Vzi6NOc6zNi/n6oq0OC+MkwmA/7/YY
        aCO1AwZyC9D9T8NHrwGbMuKdSyyvzCObmyXrGBgvU2/gi8i7/4cTrWpR1MhjL8PQEesicp
        MJQAO3X4RaEqZ785zyf0IZvE6GxR+NM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-lzbKq7WwMk2eHGGP_8kcjQ-1; Tue, 17 Oct 2023 09:44:34 -0400
X-MC-Unique: lzbKq7WwMk2eHGGP_8kcjQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-775869cf2f5so1022524685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550273; x=1698155073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tLalsWUBQv2eaq8XqLFym011Xwo+8KxiqgnVaF0bHE=;
        b=B+6yY9TJ76f42Tf7a1nUtXi7ONdsVutHjpM1vaAyyGzwxch/ymH81GSwxDRJ7dPKUt
         fDV2j3IgnRXZcTBV5HBZomvdkmC18qE90/7HVrViAj+J1UFLxS5YqLpqHCPcDHiNuZJA
         DzEHuCpbQp4w+eLpRt4R1s2+UiclxhTHil5DG6MUzmqgICUAYuEvBD/aMIXas8poIyph
         QGJHeCCxZgFa8yviyt/p8hOu2vbY0BKooQDqZu2qa8t4mJxopq9VE5xjtFw5o5vCe3bC
         2nXoLanaasKX3fI//s1PY5ugKg3oYBP+Kd3Ey1vftvIIvm1AQlMR0ibTzQYRlRg1RnDk
         Ptaw==
X-Gm-Message-State: AOJu0YyaagSzZeuZ+cA8aSnJfSn8tKgbbSpGlls/bR8iBn0NCZQ4134t
        SjvDYYbq3fiRnGGdpFtuV2cpDYUF7VaKJlqSg6zcczmtp5MQwvbms/G1Hgaz1APycKFEbLhwL8j
        E9xVg8CEEH3hEbHvUe99Tu514vdIzXh6e
X-Received: by 2002:a05:620a:2805:b0:76c:ea67:38e4 with SMTP id f5-20020a05620a280500b0076cea6738e4mr2488826qkp.12.1697550273492;
        Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/+gx4ZMW+d11WxvZrwWfW/nhQceCO+qSf3H80xnXqpxE9FmqN+oFuFeKDByPH/ByeaqMpQ==
X-Received: by 2002:a05:620a:2805:b0:76c:ea67:38e4 with SMTP id f5-20020a05620a280500b0076cea6738e4mr2488793qkp.12.1697550273066;
        Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a149100b0076cbcf8ad3bsm649455qkj.55.2023.10.17.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:44:32 -0700 (PDT)
Date:   Tue, 17 Oct 2023 15:44:14 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Message-ID: <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
 <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
 <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:29:26AM -0700, Si-Wei Liu wrote:
>Hi Stefano,
>
>On 10/13/2023 2:22 AM, Stefano Garzarella wrote:
>>Hi Si-Wei,
>>
>>On Fri, Oct 13, 2023 at 01:23:40AM -0700, Si-Wei Liu wrote:
>>>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>
>>I can test it, but what I should stress?
>Great, thank you! As you see, my patch moved vhost_iotlb_reset out of 
>vdpasim_reset for the sake of decoupling mapping from vdpa device 
>reset. For hardware devices this decoupling makes sense as platform 
>IOMMU already did it. But I'm not sure if there's something in the 
>software device (esp. with vdpa-blk and the userspace library stack) 
>that may have to rely on the current .reset behavior that clears the 
>vhost_iotlb. So perhaps you can try to exercise every possible case 
>involving blk device reset, and see if anything (related to mapping) 
>breaks?

I just tried these steps without using a VM and the host kernel hangs
after adding the device:

[root@f38-vm-build ~]# modprobe virtio-vdpa
[root@f38-vm-build ~]# modprobe vdpa-sim-blk
[root@f38-vm-build ~]# vdpa dev add mgmtdev vdpasim_blk name blk0
[   35.284575][  T563] virtio_blk virtio6: 1/0/0 default/read/poll queues
[   35.286372][  T563] virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
[   35.295271][  T564] vringh:

Reverting this patch (so building "vdpa/mlx5: implement .reset_map 
driver op") worked here.

>
>>
>>>Works fine with vdpa-sim-net which uses physical address to map.
>>
>>Can you share your tests? so I'll try to do the same with blk.
>Basically everything involving virtio device reset in the guest, e.g.  
>reboot the VM, remove/unbind then reprobe/bind the virtio-net 
>module/driver, then see if device I/O (which needs mapping properly) is 
>still flowing as expected. And then everything else that could trigger 
>QEMU's vhost_dev_start/stop paths ending up as passive vhos-vdpa 
>backend reset, for e.g. link status change, suspend/hibernate, SVQ 
>switch and live migration. I am not sure if vdpa-blk supports live 
>migration through SVQ or not, if not you don't need to worry about.
>
>>
>>>
>>>This patch is based on top of [1].
>>>
>>>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>
>>The series does not apply well on master or vhost tree.
>>Where should I apply it?
>Sent the link through another email offline.

Received thanks!

Stefano

