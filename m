Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354475EA50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGXEAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:00:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682BB0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:00:28 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8RHq5cyqzrRrk;
        Mon, 24 Jul 2023 11:59:35 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 12:00:25 +0800
Subject: Re: [PATCH v11 4/4] Documentation: add debugfs description for vfio
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230630092457.54902-1-liulongfang@huawei.com>
 <20230630092457.54902-5-liulongfang@huawei.com>
 <20230714160752.78735c4a.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <8d670c89-833d-ef9a-ce87-b46ef8915b37@huawei.com>
Date:   Mon, 24 Jul 2023 12:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230714160752.78735c4a.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/15 6:07, Alex Williamson write:
> On Fri, 30 Jun 2023 17:24:57 +0800
> liulongfang <liulongfang@huawei.com> wrote:
> 
>> From: Longfang Liu <liulongfang@huawei.com>
>>
>> 1.Add two debugfs document description file to help users understand
>> how to use the accelerator live migration driver's debugfs.
>> 2.Update the file paths that need to be maintained in MAINTAINERS
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../ABI/testing/debugfs-hisi-migration        | 32 +++++++++++++++++++
>>  Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++++
>>  MAINTAINERS                                   |  2 ++
>>  3 files changed, 59 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
>> new file mode 100644
>> index 000000000000..0dfc7008a3e1
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
>> @@ -0,0 +1,32 @@
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
>> +Date:		June 2023
>> +KernelVersion:  6.4
> 
> At best we'd be looking at introducing this for 6.6, where it might get
> into mainline in late August for all of these.
>
OK, so does this KernelVersion need to be marked as 6.6?

>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Read the live migration data of the vfio device.
>> +		The output format of the data is defined by the live
>> +		migration driver.
> 
> This attribute is specific to the hisi_acc driver, so should the data
> be detailed here?
> 
OK I'll add a description of the role type of the data.

>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Read the live migration attributes of the vfio device.
>> +		The output format of the attributes is defined by the live
>> +		migration driver.
> 
> Same here.
> 
OK.

>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Trigger the HiSilicon accelerator device to perform
>> +		the io test through the read operation, and directly output
>> +		the test result.
> 
> This has essentially been reduced to reading the mailbox value AIUI,
> should this simply document that and the resulting possible values?
>
OK,This can add information.

>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Trigger the Hisilicon accelerator device to perform
>> +		the state saving operation of live migration through the read
>> +		operation, and directly output the operation result.
> 
> It's unclear to me why we need to parse a returned string from the
> debugfs seq file rather than read returns zero on success or errno on
> failure.
>
It is impossible to know the reason for the failure just by returning true or false.
Through the string obtained by seq_printf, the user can know the cause of the error.

>> +
>> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
>> new file mode 100644
>> index 000000000000..e2132a2f602b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-vfio
>> @@ -0,0 +1,25 @@
>> +What:		/sys/kernel/debug/vfio
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	This debugfs file directory is used for debugging
>> +		of vfio devices.
>> +		Each device can create a device subdirectory under this
>> +		directory by referencing the public registration interface.
> 
> This suggests it's the device driver's responsibility to create those
> subdirectories, but we've delegated that to the core currently.  Maybe
> this is suggesting that each driver can create a driver subdirectory
> under the core created device directory?
>
OK This vfio directory file is added in vfio_main. All vfio devices share this
device directory.
Then each device creates its own device directory with its own dev_name.

Thanks.
Longfang.
> Thanks,
> Alex
> 
>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	This debugfs file directory is used for debugging
>> +		of vfio devices that support live migration.
>> +		The debugfs of each vfio device that supports live migration
>> +		could be created under this directory.
>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/state
>> +Date:		June 2023
>> +KernelVersion:  6.4
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Read the live migration status of the vfio device.
>> +		The status of these live migrations includes:
>> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ce6ac552d8f6..bdd6a5e7350f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22098,6 +22098,7 @@ L:	kvm@vger.kernel.org
>>  S:	Maintained
>>  T:	git https://github.com/awilliam/linux-vfio.git
>>  F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
>> +F:	Documentation/ABI/testing/debugfs-vfio
>>  F:	Documentation/driver-api/vfio.rst
>>  F:	drivers/vfio/
>>  F:	include/linux/vfio.h
>> @@ -22115,6 +22116,7 @@ M:	Longfang Liu <liulongfang@huawei.com>
>>  M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>  L:	kvm@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/ABI/testing/debugfs-hisi-migration
>>  F:	drivers/vfio/pci/hisilicon/
>>  
>>  VFIO MEDIATED DEVICE DRIVERS
> 
> .
> 
