Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C537A7270
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjITF7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjITF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:59:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295779F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695189565; x=1726725565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1AFS0qlu86X69HdRueO8Qt7qnBiopMrULvB4gkTp+4M=;
  b=CHTEIpz9BAaaFZqspRkPnU1kkvp4s3F8aF+xM3u90VkLsNBz/+5cT8zG
   VIsb8YlQ/+jKV0ahpFP9ZtLo/7EZ4UnikSrNnUzzWSVpZH3qn8u7NFptd
   w7/fhkZcLNXPkcdoBeHKkAXLGv0xFDfUEcwjtlaV2l4pf1SneMqUMFt64
   HlcQZno6P7PQbEJsqTxhxdTE4B4fltVJ3Qnu3yt149b6kEjw+GrxXo9R/
   4eGpaRtPNkRwbc/1uMNq+U/RQaZbrG2MzkdoMRZ+vyfUXKvI6/lGnG+39
   +1HYzwZc3iVWhGKPn/qlFdNWLnc4ChYUK/hV6uCAjkH9R/AZfhYGhaFv1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444226203"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="444226203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="812013672"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="812013672"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5]) ([10.93.14.5])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:59:18 -0700
Message-ID: <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
Date:   Wed, 20 Sep 2023 13:59:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230919082802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2023 8:31 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
>> When guest vm does S3, Qemu will reset and clear some things of virtio
>> devices, but guest can't aware that, so that may cause some problems.
>> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
>> resume, that function will destroy render resources of virtio-gpu. As
>> a result, after guest resume, the display can't come back and we only
>> saw a black screen. Due to guest can't re-create all the resources, so
>> we need to let Qemu not to destroy them when S3.
>>
>> For above purpose, we need a mechanism that allows guests and QEMU to
>> negotiate their reset behavior. So this patch add a new parameter
>> named freeze_mode to struct virtio_pci_common_cfg. And when guest
>> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
>> devices can change their reset behavior on Qemu side according to
>> freeze_mode. What's more, freeze_mode can be used for all virtio
>> devices to affect the behavior of Qemu, not just virtio gpu device.
Hi Jiqian,

Have you seen this series: [PATCH 0/5] virtio: introduce SUSPEND bit and 
vq state
https://lore.kernel.org/all/3f4cbf84-010c-cffa-0b70-33c449b5561b@intel.com/T/

We introduced a bit in the device status SUSPEND, when VIRTIO_F_SUSPEND is
negotiated, the driver can set SUSPEND in the device status to suspend the
device.

When SUSPEND, the device should pause its operations and preserve its 
configurations
in its configuration space.

The driver re-write DRIVER_OK to clear SUSPEND, so the device resumes 
running.

This is originally to serve live migration, but I think it can also meet 
your needs.

Thanks,
Zhu Lingshan
>>
>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> ---
>>   transport-pci.tex | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index a5c6719..2543536 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           le64 queue_desc;                /* read-write */
>>           le64 queue_driver;              /* read-write */
>>           le64 queue_device;              /* read-write */
>> +        le16 freeze_mode;               /* read-write */
>>           le16 queue_notif_config_data;   /* read-only for driver */
>>           le16 queue_reset;               /* read-write */
>>
> we can't add fields in the middle of the structure like this -
> offset of queue_notif_config_data and queue_reset changes.
>
>    
>> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   \item[\field{queue_device}]
>>           The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>>   
>> +\item[\field{freeze_mode}]
>> +        The driver writes this to set the freeze mode of virtio pci.
>> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
>> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
>> +        Other values are reserved for future use, like S4, etc.
>> +
> we need to specify these values then.
>
> we also need
> - feature bit to detect support for S3
> - conformance statements documenting behavious under S3
>
>
>>   \item[\field{queue_notif_config_data}]
>>           This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>>           The driver will use this value when driver sends available buffer
>> -- 
>> 2.34.1
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

