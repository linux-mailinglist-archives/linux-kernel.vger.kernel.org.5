Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB77A73AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjITHGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjITHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:06:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02736C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695193605; x=1726729605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wZTukaWgYQtoMGWXkRGQVIiyv0OYLx0f+YV06SI2gq0=;
  b=NI8JYQnM3NlqVwUQr7B70XbrR4qfGfGEtZpod0xzxwJzCC4oewPZ6Tt9
   pQlY/28ASk3CdAazLOUhVF+yAVUvuAQr8AyA/6gkqoqCZbjmrfLM7jcBz
   hmQzpXI6qc+M6c6iMXkPOWnrO1JN1Y4GddMRMRBkJ0wPhkqCqihvIRwUz
   P5ARZq5fDdN6DrRIcMf2nPE9kAeeDeVvf9Q0qHl/1wdl60wPZDThC0rPU
   uqQPIQUNz5iTcIAawDaHfc3RWvV+IQ9HBWCbXbEzLVh1IT1fBa5HY/5B2
   whuUog8+/rikU4ffaHfVsv02aF8M5UICkfWkqJhgPs+KItiTcpQyc2Vbu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359533474"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="359533474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="812032857"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="812032857"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5]) ([10.93.14.5])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:06:35 -0700
Message-ID: <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
Date:   Wed, 20 Sep 2023 15:06:33 +0800
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
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2023 2:58 PM, Parav Pandit wrote:
>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
>> Sent: Wednesday, September 20, 2023 12:03 PM
>> If driver write 0 to reset device, can the SUSPEND bit be cleared?
> It must as reset operation, resets everything else and so the suspend too.
>
>> (pci_pm_resume->virtio_pci_restore->virtio_device_restore-
>>> virtio_reset_device)
>> If SUSPEND is cleared, then during the reset process in Qemu, I can't judge if
>> the reset request is from guest restore process or not, and then I can't change
>> the reset behavior.
> Reset should not be influenced by suspend.
> Suspend should do the work of suspend and reset to do the reset.
>
> The problem to overcome in [1] is, resume operation needs to be synchronous as it involves large part of context to resume back, and hence just asynchronously setting DRIVER_OK is not enough.
> The sw must verify back that device has resumed the operation and ready to answer requests.
this is not live migration, all device status and other information 
still stay in the device, no need to "resume" context, just resume running.

Like resume from a failed LM.
>
> This is slightly different flow than setting the DRIVER_OK for the first time device initialization sequence as it does not involve large restoration.
>
> So, to merge two ideas, instead of doing DRIVER_OK to resume, the driver should clear the SUSPEND bit and verify that it is out of SUSPEND.
>
> Because driver is still in _OK_ driving the device flipping the SUSPEND bit.
Please read the spec, it says:
The driver MUST NOT clear a device status bit


