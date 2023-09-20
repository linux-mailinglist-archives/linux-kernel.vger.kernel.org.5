Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A47A740A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjITH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjITH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:27:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C3C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695194860; x=1726730860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c//2mqr4QCDnboufqfxvs3v0ljEejNOYFoTJbE1+at8=;
  b=R9WW70+gho4pqxFqCzld0/kgaekb54qloIAoeMvIbLX6nNnZuNW8k0Xg
   tTbVoLrjuseBQjm+CXQUuWjftKTPO5boIEYWnORNyMdZjpQBXkNu5JQ0i
   UNRTum6fOdO5SiPDpyZdhV1ShUaVK4N8mktoLTzScyMjl7bfq2YPDUXho
   5QDjg8Qpmy3bhH/mzeJE2TlLKPyZ6cQuWQfET4HQ0IzsB323wNvRvgF8l
   23Nvom41yWbcPZCcDIbY5EBsFBPjbo3s5Q3Zno0Q9f2Zwd3Hl0C2hmeTV
   5JyD2EGjjRhSo+iJ7jWpnjupbZ+Ldx3eMUZgJ2inF0+4+86+M7CSxh9c+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411088297"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411088297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781592828"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="781592828"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5]) ([10.93.14.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:27:32 -0700
Message-ID: <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
Date:   Wed, 20 Sep 2023 15:27:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>,
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
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2023 3:10 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 20, 2023 12:37 PM
>>> The problem to overcome in [1] is, resume operation needs to be synchronous
>> as it involves large part of context to resume back, and hence just
>> asynchronously setting DRIVER_OK is not enough.
>>> The sw must verify back that device has resumed the operation and ready to
>> answer requests.
>> this is not live migration, all device status and other information still stay in the
>> device, no need to "resume" context, just resume running.
>>
> I am aware that it is not live migration. :)
>
> "Just resuming" involves lot of device setup task. The device implementation does not know for how long a device is suspended.
> So for example, a VM is suspended for 6 hours, hence the device context could be saved in a slow disk.
> Hence, when the resume is done, it needs to setup things again and driver got to verify before accessing more from the device.
The restore procedures should perform by the hypervisor and done before 
set DRIVER_OK and wake up the guest.
And the hypervisor/driver needs to check the device status by re-reading.
>   
>> Like resume from a failed LM.
>>> This is slightly different flow than setting the DRIVER_OK for the first time
>> device initialization sequence as it does not involve large restoration.
>>> So, to merge two ideas, instead of doing DRIVER_OK to resume, the driver
>> should clear the SUSPEND bit and verify that it is out of SUSPEND.
>>> Because driver is still in _OK_ driving the device flipping the SUSPEND bit.
>> Please read the spec, it says:
>> The driver MUST NOT clear a device status bit
>>
> Yes, this is why either DRIER_OK validation by the driver is needed or Jiqian's synchronous new register..
so re-read
>

