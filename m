Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6807E1A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjKFG3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjKFG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:29:20 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919ADF2;
        Sun,  5 Nov 2023 22:29:15 -0800 (PST)
Received: from kwepemm000005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SP1ZP4P4Kz1P7x5;
        Mon,  6 Nov 2023 14:26:05 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemm000005.china.huawei.com (7.193.23.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 14:28:42 +0800
Subject: Re: [PATCH v18 2/2] Documentation: add debugfs description for vfio
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <bcreeley@amd.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20231028075447.41939-1-liulongfang@huawei.com>
 <20231028075447.41939-3-liulongfang@huawei.com>
 <356dd79e-9079-4bbc-9b64-9468b6f7b6a7@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <f0f1d157-a07a-c5ea-1353-a3400897f278@huawei.com>
Date:   Mon, 6 Nov 2023 14:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <356dd79e-9079-4bbc-9b64-9468b6f7b6a7@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.110]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000005.china.huawei.com (7.193.23.27)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/30 14:51, Cédric Le Goater write:
> On 10/28/23 09:54, Longfang Liu wrote:
>> 1.Add an debugfs document description file to help users understand
>> how to use the accelerator live migration driver's debugfs.
>> 2.Update the file paths that need to be maintained in MAINTAINERS
> 
> Should we have 2 patches instead ?
>

It is also good to add a separate patch.

Thanks,
Longfang.

> Anyhow,
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 
> 
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>   Documentation/ABI/testing/debugfs-vfio | 25 +++++++++++++++++++++++++
>>   MAINTAINERS                            |  1 +
>>   2 files changed, 26 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-vfio
>>
>> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
>> new file mode 100644
>> index 000000000000..445e9f58f924
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-vfio
>> @@ -0,0 +1,25 @@
>> +What:        /sys/kernel/debug/vfio
>> +Date:        Oct 2023
>> +KernelVersion:  6.7
>> +Contact:    Longfang Liu <liulongfang@huawei.com>
>> +Description:    This debugfs file directory is used for debugging
>> +        of vfio devices, it's a common directory for all vfio devices.
>> +        Vfio core will create a device subdirectory under this
>> +        directory.
>> +
>> +What:        /sys/kernel/debug/vfio/<device>/migration
>> +Date:        Oct 2023
>> +KernelVersion:  6.7
>> +Contact:    Longfang Liu <liulongfang@huawei.com>
>> +Description:    This debugfs file directory is used for debugging
>> +        of vfio devices that support live migration.
>> +        The debugfs of each vfio device that supports live migration
>> +        could be created under this directory.
>> +
>> +What:        /sys/kernel/debug/vfio/<device>/migration/state
>> +Date:        Oct 2023
>> +KernelVersion:  6.7
>> +Contact:    Longfang Liu <liulongfang@huawei.com>
>> +Description:    Read the live migration status of the vfio device.
>> +        The contents of the state file reflects the migration state
>> +        relative to those defined in the vfio_device_mig_state enum
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b19995690904..a6be3b4219c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22591,6 +22591,7 @@ L:    kvm@vger.kernel.org
>>   S:    Maintained
>>   T:    git https://github.com/awilliam/linux-vfio.git
>>   F:    Documentation/ABI/testing/sysfs-devices-vfio-dev
>> +F:    Documentation/ABI/testing/debugfs-vfio
>>   F:    Documentation/driver-api/vfio.rst
>>   F:    drivers/vfio/
>>   F:    include/linux/vfio.h
> 
> .
> 
