Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AB7A74C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjITHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjITHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:48:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9D132
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695196058; x=1726732058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6EIYxxBxmaM+623ONioCHxvpX1okslSwTEtsPJQ94lQ=;
  b=NhDR5M7Bn6RnDrXhT9dsuGgdc1ZlnunrOK8v0Nrf0EGWHnS10Vs3xS+9
   YqYOn1tJZHgXYc+EgMa93CNtd/jmLG/0mlYK1RPct9Cn6lkgPzTSe8ssO
   nEZdcwm2DSJgsDTnDvbEwcvi5uPzVOf153dvP6LNJrvxxtKLx0Ip4OU2D
   jF4mLmHkj7kaQkw+VkyEVKK1fT9M3KyfMbZdMK1wo9BWzf3RhqJgEYGdE
   SN36HIWYwzK0wmJ7cVlYmvAhqgR8TF0TWuIZ6aykOPX0ueKoj66gYsMoR
   jm4LlHGz+WTyt828+yqf5zgU26x3GtZBsWJvImmMyHvlaEEoyFv0jMaZs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444247258"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="444247258"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920180951"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920180951"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5]) ([10.93.14.5])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:47:31 -0700
Message-ID: <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
Date:   Wed, 20 Sep 2023 15:47:29 +0800
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
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
 <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
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



On 9/20/2023 3:35 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 20, 2023 1:00 PM
>>
>> On 9/20/2023 3:24 PM, Chen, Jiqian wrote:
>>> Hi Lingshan,
>>> It seems you reply to the wrong email thread. They are not related to my
>> patch.
>> These reply to Parva's comments.
>> @Parva, if you want to discuss more about live migration, please reply in my
>> thread, lets don't flood here.
> You made the point that "this is not live migration".
> I am not discussing live migration in this thread.
>
> I replied for the point that device restoration from suspend for physical and hypevisor based device is not a 40nsec worth of work to restore by just doing a register write.
> This is not live or device migration. This is restoring the device context initiated by the driver owning the device.
restore the device context should be done by the hypervisor before 
setting DRIVER_OK and waking up the guest, not a concern here, out of spec

