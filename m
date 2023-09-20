Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAA7A7387
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjITG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjITG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:59:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A97F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695193142; x=1726729142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ffnKPVyNxy55r7abNlxMw5Gbvsj5jCv6UNFrWk2dtDA=;
  b=Sruqn48PgKLWMEq7nUB6UfTC/etyYWnQ0VYCPf2NmxgZFmUSavmNIELO
   l9UeQhm5ZnlrL6osiiB+CJowW+bY4STka36kFs7OQdvkr3FuKw/N8Juwj
   Ked/WyKAeILgEo3qQYrXz7PA7z7U7tk9uhblCz3sDTaNdY9RWVG2gR+3G
   jP2cF4dmbBi9QI6mUKHg6xkURubfi64blSn4214ahrzYKscEt8KsbGYd4
   ASY7tk3eWjZ9hoDS17s8HyfnziLebdCTnyDufZY7HlRoaxVQ4UkE9Ob3G
   WxR/hJm31BlVZsuALx+3qMEqbJTXg8SqoNhuakLI46J2/sPUO+7tn916X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411079657"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411079657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="696197650"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="696197650"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5]) ([10.93.14.5])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:58:55 -0700
Message-ID: <badb53e0-513c-f88c-67b9-ecd59d1cf051@intel.com>
Date:   Wed, 20 Sep 2023 14:58:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Content-Language: en-US
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
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
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2023 2:33 PM, Chen, Jiqian wrote:
> Hi Lingshan,
>
> On 2023/9/20 13:59, Zhu, Lingshan wrote:
>>
>> On 9/19/2023 8:31 PM, Michael S. Tsirkin wrote:
>>> On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
>>>> When guest vm does S3, Qemu will reset and clear some things of virtio
>>>> devices, but guest can't aware that, so that may cause some problems.
>>>> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
>>>> resume, that function will destroy render resources of virtio-gpu. As
>>>> a result, after guest resume, the display can't come back and we only
>>>> saw a black screen. Due to guest can't re-create all the resources, so
>>>> we need to let Qemu not to destroy them when S3.
>>>>
>>>> For above purpose, we need a mechanism that allows guests and QEMU to
>>>> negotiate their reset behavior. So this patch add a new parameter
>>>> named freeze_mode to struct virtio_pci_common_cfg. And when guest
>>>> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
>>>> devices can change their reset behavior on Qemu side according to
>>>> freeze_mode. What's more, freeze_mode can be used for all virtio
>>>> devices to affect the behavior of Qemu, not just virtio gpu device.
>> Hi Jiqian,
>>
>> Have you seen this series: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state
>> https://lore.kernel.org/all/3f4cbf84-010c-cffa-0b70-33c449b5561b@intel.com/T/
>>
>> We introduced a bit in the device status SUSPEND, when VIRTIO_F_SUSPEND is
>> negotiated, the driver can set SUSPEND in the device status to suspend the
>> device.
>>
>> When SUSPEND, the device should pause its operations and preserve its configurations
>> in its configuration space.
>>
>> The driver re-write DRIVER_OK to clear SUSPEND, so the device resumes running.
>>
>> This is originally to serve live migration, but I think it can also meet your needs.
> I noticed your series, but I am not sure they are also meet my needs.
> If driver write 0 to reset device, can the SUSPEND bit be cleared? (pci_pm_resume->virtio_pci_restore->virtio_device_restore->virtio_reset_device)
if the driver writes 0, it resets all virtio functionalities. So SUSPEND 
is cleared.
device reset can also be used to recover the device from fatal errors, 
so it should reset everything in virtio.
> If SUSPEND is cleared, then during the reset process in Qemu, I can't judge if the reset request is from guest restore process or not, and then I can't change the reset behavior.
I think when enter S3, the hypervisor/driver should set SUSPEND to the 
device. And when resume from S3, the hypervisor/driver should
re-write DRIVER_OK to clear SUSPEND, then the device resume running.
> Can you send me your patch link on kernel and qemu side? I will take a deep look.
There are no patches for qemu/kernel yet, spec first.
>
>> Thanks,
>> Zhu Lingshan
>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>>>> ---
>>>>    transport-pci.tex | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/transport-pci.tex b/transport-pci.tex
>>>> index a5c6719..2543536 100644
>>>> --- a/transport-pci.tex
>>>> +++ b/transport-pci.tex
>>>> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>>>            le64 queue_desc;                /* read-write */
>>>>            le64 queue_driver;              /* read-write */
>>>>            le64 queue_device;              /* read-write */
>>>> +        le16 freeze_mode;               /* read-write */
>>>>            le16 queue_notif_config_data;   /* read-only for driver */
>>>>            le16 queue_reset;               /* read-write */
>>>>
>>> we can't add fields in the middle of the structure like this -
>>> offset of queue_notif_config_data and queue_reset changes.
>>>
>>>    
>>>> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>>>    \item[\field{queue_device}]
>>>>            The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>>>>    +\item[\field{freeze_mode}]
>>>> +        The driver writes this to set the freeze mode of virtio pci.
>>>> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
>>>> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
>>>> +        Other values are reserved for future use, like S4, etc.
>>>> +
>>> we need to specify these values then.
>>>
>>> we also need
>>> - feature bit to detect support for S3
>>> - conformance statements documenting behavious under S3
>>>
>>>
>>>>    \item[\field{queue_notif_config_data}]
>>>>            This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>>>>            The driver will use this value when driver sends available buffer
>>>> -- 
>>>> 2.34.1
>>> This publicly archived list offers a means to provide input to the
>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>
>>> In order to verify user consent to the Feedback License terms and
>>> to minimize spam in the list archive, subscription is required
>>> before posting.
>>>
>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>> List help: virtio-comment-help@lists.oasis-open.org
>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>> Committee: https://www.oasis-open.org/committees/virtio/
>>> Join OASIS: https://www.oasis-open.org/join/
>>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

