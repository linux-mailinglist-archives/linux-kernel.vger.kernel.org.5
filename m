Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D557717D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjHGBdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGBdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:33:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9810FC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:33:11 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RJzJN4DSMzGprY;
        Mon,  7 Aug 2023 09:29:40 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 09:33:07 +0800
Subject: Re: [PATCH v12 4/4] Documentation: add debugfs description for vfio
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230728072104.64834-1-liulongfang@huawei.com>
 <20230728072104.64834-5-liulongfang@huawei.com> <ZM0SAfIHnMHndm8h@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <3c557239-447f-116d-3687-cc6e419f2dcc@huawei.com>
Date:   Mon, 7 Aug 2023 09:33:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZM0SAfIHnMHndm8h@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/4 22:58, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 03:21:04PM +0800, liulongfang wrote:
>> From: Longfang Liu <liulongfang@huawei.com>
>>
>> 1.Add two debugfs document description file to help users understand
>> how to use the accelerator live migration driver's debugfs.
>> 2.Update the file paths that need to be maintained in MAINTAINERS
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../ABI/testing/debugfs-hisi-migration        | 36 +++++++++++++++++++
>>  Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++
>>  MAINTAINERS                                   |  2 ++
>>  3 files changed, 63 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
>> new file mode 100644
>> index 000000000000..791dd8a09575
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
>> @@ -0,0 +1,36 @@
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
>> +Date:		Aug 2023
>> +KernelVersion:  6.6
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Read the live migration data of the vfio device.
>> +		These data include device status data, queue configuration
>> +		data and some task configuration data.
>> +		The output format of the data is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
>> +Date:		Aug 2023
>> +KernelVersion:  6.6
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Read the live migration attributes of the vfio device.
>> +		it include device status attributes and data length attributes
>> +		The output format of the attributes is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
>> +Date:		Aug 2023
>> +KernelVersion:  6.6
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Trigger the HiSilicon accelerator device to perform
>> +		the io test through the read operation. If successful,
>> +		it returns the execution result of mailbox. If fails,
>> +		it returns error log result.
>> +
>> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
>> +Date:		Aug 2023
>> +KernelVersion:  6.6
>> +Contact:	Longfang Liu <liulongfang@huawei.com>
>> +Description:	Trigger the Hisilicon accelerator device to perform
>> +		the state saving operation of live migration through the read
>> +		operation, and output the operation log results.
> 
> I still very much do not like this use of debugfs.
> 
> If you want to test migration then make a test program and use the
> normal api
>
These debugfs are just to get internal state data.
The test function is no longer executed.
The store file with test function has been deleted.

Thanks,
Longfang.

> Creating some parallel backdoor to work the same API is just
> unneeded complexity.
> 
> Jason
> .
> 
