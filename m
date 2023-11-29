Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2BC7FD4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjK2Kqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjK2Kqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:46:34 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 02:46:41 PST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9BD73;
        Wed, 29 Nov 2023 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701254801; x=1732790801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbU00ZlSBNX0l3gHoeLVRwt3IFr67F4reSXWY6JN9vE=;
  b=O7KWoYHaT3sMySUX9cVthzatsqsct3Zq+zBp3zmr6xVVzwW4tcHrZWkE
   W/GKh1HPYXBP/SHDPys7PBYt+c8q6h5WYJGzcLk+sSwwYe8GA34/KIYm5
   cREhpMxFZwyNUIoL5Ah0Xq0RPKMIlESAFX8a6pq+8gVHnI/zjg/GObSjX
   PtMZLwmNsRuHKyXWh9x0Y8obs/bflb4DFg6QT46VaX7jXxrLhmyCIFKe4
   6+FcOdkS4xkZELRsSccuHUFO++JgZ9xkxP+jkvqEPOPLOESOUabrxVhLc
   U4HJsIOiUxOZozDz1VEDF2P0J2IlVZPrbAWNMbm7jmlwSsaeMcdBaBl/v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="29567"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="29567"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:45:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859781936"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="859781936"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.238.2.21]) ([10.238.2.21])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:45:34 -0800
Message-ID: <f37cb55a-6fc8-4e21-8789-46d468325eea@linux.intel.com>
Date:   Wed, 29 Nov 2023 18:45:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, shannon.nelson@amd.com,
        yuanyaogoog@chromium.org, yuehaibing@huawei.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
 <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
 <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com>
 <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
Content-Language: en-US
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/29 18:20, Jason Wang wrote:
> On Wed, Nov 29, 2023 at 6:12 PM Ning, Hongyu
> <hongyu.ning@linux.intel.com> wrote:
>>
>>
>> On 2023/11/29 17:16, Jason Wang wrote:
>>> On Wed, Nov 29, 2023 at 5:05 PM Ning, Hongyu
>>> <hongyu.ning@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
>>>>> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
>>>>>
>>>>>      Linux 6.5 (2023-08-27 14:49:51 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>>>>>
>>>>> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
>>>>>
>>>>>      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> virtio: features
>>>>>
>>>>> a small pull request this time around, mostly because the
>>>>> vduse network got postponed to next relase so we can be sure
>>>>> we got the security store right.
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Eugenio Pérez (4):
>>>>>          vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
>>>>>          vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
>>>>>          vdpa: add get_backend_features vdpa operation
>>>>>          vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
>>>>>
>>>>> Jason Wang (1):
>>>>>          virtio_vdpa: build affinity masks conditionally
>>>>>
>>>>> Xuan Zhuo (12):
>>>>>          virtio_ring: check use_dma_api before unmap desc for indirect
>>>>>          virtio_ring: put mapping error check in vring_map_one_sg
>>>>>          virtio_ring: introduce virtqueue_set_dma_premapped()
>>>>>          virtio_ring: support add premapped buf
>>>>>          virtio_ring: introduce virtqueue_dma_dev()
>>>>>          virtio_ring: skip unmap for premapped
>>>>>          virtio_ring: correct the expression of the description of virtqueue_resize()
>>>>>          virtio_ring: separate the logic of reset/enable from virtqueue_resize
>>>>>          virtio_ring: introduce virtqueue_reset()
>>>>>          virtio_ring: introduce dma map api for virtqueue
>>>>>          virtio_ring: introduce dma sync api for virtqueue
>>>>>          virtio_net: merge dma operations when filling mergeable buffers
>>>>
>>>> Hi,
>>>> above patch (upstream commit 295525e29a5b) seems causing a virtnet
>>>> related Call Trace after WARNING from kernel/dma/debug.c.
>>>>
>>>> details (log and test setup) tracked in
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218204
>>>>
>>>> it's recently noticed in a TDX guest testing since v6.6.0 release cycle
>>>> and can still be reproduced in latest v6.7.0-rc3.
>>>>
>>>> as local bisects results show, above WARNING and Call Trace is linked
>>>> with this patch, do you mind to take a look?
>>>
>>> Looks like virtqueue_dma_sync_single_range_for_cpu() use
>>> DMA_BIDIRECTIONAL unconditionally.
>>>
>>> We should use dir here.
>>>
>>> Mind to try?
>>>
>>> Thanks
>>>
>>
>> sure, but what I see in the code
>> virtqueue_dma_sync_single_range_for_cpu() is using DMA_FROM_DEVICE,
>> probably I misunderstood your point?
>>
>> Please let me know any patch/setting to try here.
> 
> Something like attached.  (Not even compiling test).
> 
> Thanks
> 

Oh, this patch works, WARNING and Call Trace are no more reproduced in 
the same Linux Guest Kernel setup.

>>
>>
>>>>
>>>>>
>>>>> Yuan Yao (1):
>>>>>          virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
>>>>>
>>>>> Yue Haibing (1):
>>>>>          vdpa/mlx5: Remove unused function declarations
>>>>>
>>>>>     drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
>>>>>     drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
>>>>>     drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
>>>>>     drivers/vhost/vdpa.c               |  15 +-
>>>>>     drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
>>>>>     drivers/virtio/virtio_vdpa.c       |  17 +-
>>>>>     include/linux/vdpa.h               |   4 +
>>>>>     include/linux/virtio.h             |  22 ++
>>>>>     include/uapi/linux/vhost_types.h   |   4 +
>>>>>     9 files changed, 625 insertions(+), 90 deletions(-)
>>>>>
>>>>
>>>
>>
