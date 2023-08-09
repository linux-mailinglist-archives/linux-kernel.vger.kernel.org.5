Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45E27764B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHIQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHIQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:08:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA181FD8;
        Wed,  9 Aug 2023 09:08:54 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379FtUEs028265;
        Wed, 9 Aug 2023 16:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zKxh6ZOMdNfOb1OFxY4GuRlptUFa7cawBHbwpKLHMA8=;
 b=fYuTwY6Co+H/HbwXGuba+V5CPQcAhzWnKiteiB1aIx0jmJBkqfNAXKml6KT9/mcJx6lp
 iFPsBwnLTHN527pI4NPmS1Dsa2rj7eQ2mJhbi+MSZ1+UaXz7PR2iKj8Q/z+AqGLrtfeN
 6ku4rqaal5yy7rCAlAYavOKwdyqReNcVbzAp6PkohlGDRZcx8VQ+0zlszy4NicexX/9H
 J5q4GZaDGRDc9gZf9tpDVSKeoiMkwIP0e+155EcnbEugE2LYFH02eL71ys/k+MJO7ykm
 B4OwYGPgZ5WyjIfwo45RFEf2GpKd7w0/Uss30Ch8mbmGBVwSY1J+bAHjkCFJFAocsIlL Pw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdvbra7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:08:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379EepMV001801;
        Wed, 9 Aug 2023 16:08:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f21641-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:08:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379G8amC41419212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 16:08:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D79E58056;
        Wed,  9 Aug 2023 16:08:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACF7D5803F;
        Wed,  9 Aug 2023 16:08:35 +0000 (GMT)
Received: from [9.61.73.158] (unknown [9.61.73.158])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 16:08:35 +0000 (GMT)
Message-ID: <50fca36f-6c0a-341c-aaf3-51f3b76bd48b@linux.ibm.com>
Date:   Wed, 9 Aug 2023 11:08:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/14] fsi: Improve master indexing
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20230612195657.245125-1-eajames@linux.ibm.com>
 <20230612195657.245125-12-eajames@linux.ibm.com>
 <CACPK8Xe1OmLtLrONZmqib6BhDyPHzj+HcOd15MXyK0QVHPTOEg@mail.gmail.com>
 <CACPK8XcAeiLRKZJi0ceekwVeDBX2EVw4kmMsvQWT3DfFpxJXng@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8XcAeiLRKZJi0ceekwVeDBX2EVw4kmMsvQWT3DfFpxJXng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qFJn97VSnMt98hFZUGAaeSlf5EZFa1gf
X-Proofpoint-GUID: qFJn97VSnMt98hFZUGAaeSlf5EZFa1gf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/23 06:55, Joel Stanley wrote:
> On Wed, 9 Aug 2023 at 07:08, Joel Stanley <joel@jms.id.au> wrote:
>> On Mon, 12 Jun 2023 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
>>> Master indexing is problematic if a hub is rescanned while the
>>> root master is being rescanned. Move the IDA free below the device
>>> unregistration, lock the scan mutex in the probe function, and
>>> request a specific idx in the hub driver.
>> I've applied this series, but taking a closer look at this patch I
>> think it can be improved. If you resend, just send this patch.
> On hardware, it did this at FSI scan time:


Well this backtrace is without this patch, right? The hub master changes 
that went in are dependent on this patch. master->idx is 1 for the hub 
but it's not being allocated in the ida and the device name isn't 
getting set. So device registration fails and then trying to free the 
index in the ida causes this warning.

I'll reply to your comments in your other email and rebase and resend.


>
>   WARNING: CPU: 0 PID: 761 at /lib/idr.c:525 ida_free+0x140/0x154
>   ida_free called for id=1 which is not allocated.
>   CPU: 0 PID: 761 Comm: openpower-proc- Not tainted 6.1.34-d42f59e #1
>   Hardware name: Generic DT based system
>    unwind_backtrace from show_stack+0x18/0x1c
>    show_stack from dump_stack_lvl+0x24/0x2c
>    dump_stack_lvl from __warn+0x74/0xf0
>    __warn from warn_slowpath_fmt+0x9c/0xd8
>    warn_slowpath_fmt from ida_free+0x140/0x154
>    ida_free from fsi_master_register+0xd0/0xf0
>    fsi_master_register from hub_master_probe+0x11c/0x358
>    hub_master_probe from really_probe+0xd4/0x3f0
>    really_probe from driver_probe_device+0x38/0xd0
>    driver_probe_device from __device_attach_driver+0xc8/0x148
>    __device_attach_driver from bus_for_each_drv+0x90/0xdc
>    bus_for_each_drv from __device_attach+0x114/0x1a4
>    __device_attach from bus_probe_device+0x8c/0x94
>    bus_probe_device from device_add+0x3a8/0x7fc
>    device_add from fsi_master_scan+0x4e0/0x950
>    fsi_master_scan from fsi_master_rescan+0x38/0x88
>    fsi_master_rescan from master_rescan_store+0x14/0x20
>    master_rescan_store from kernfs_fop_write_iter+0x114/0x200
>    kernfs_fop_write_iter from vfs_write+0x1d0/0x374
>    vfs_write from ksys_write+0x78/0x100
>    ksys_write from ret_fast_syscall+0x0/0x54
>   Exception stack(0x9fc51fa8 to 0x9fc51ff0)
>   1fa0:                   00000001 01a01c78 00000003 01a01c78 00000001 00000001
>   1fc0: 00000001 01a01c78 00000001 00000004 7eeb4ab0 7eeb4b3c 7eeb4ab4 7eeb499c
>   1fe0: 76985abc 7eeb4928 76848af8 766f176c
>
>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   drivers/fsi/fsi-core.c       | 41 ++++++++++++++++++++++--------------
>>>   drivers/fsi/fsi-master-hub.c |  2 ++
>>>   2 files changed, 27 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>>> index ec4d02264391..503061a6740b 100644
>>> --- a/drivers/fsi/fsi-core.c
>>> +++ b/drivers/fsi/fsi-core.c
>>> @@ -1327,46 +1327,55 @@ static struct class fsi_master_class = {
>>>   int fsi_master_register(struct fsi_master *master)
>>>   {
>>>          int rc;
>>> -       struct device_node *np;
>>>
>>>          mutex_init(&master->scan_lock);
>>> -       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>>> +
>>> +       if (master->idx) {
>> Why do we allocate a new idx if there's already one?
>>
>>> +               master->idx = ida_alloc_range(&master_ida, master->idx,
>>> +                                             master->idx, GFP_KERNEL);
>> If we can't get one in the range we want, we ask for any? Should this
>> print a warning?
>>
>>> +               if (master->idx < 0)
>>> +                       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>>> +       } else {
>> If ixd was zero, we create one. This is the "normal" case?
>>
>>> +               master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>>> +       }
>>> +
>> We check the same error condition again.
>>
>>>          if (master->idx < 0)
>>>                  return master->idx;
>>> -       dev_set_name(&master->dev, "fsi%d", master->idx);
>>> +       if (!dev_name(&master->dev))
>>> +               dev_set_name(&master->dev, "fsi%d", master->idx);
>>> +
>>>          master->dev.class = &fsi_master_class;
>>>
>>> +       mutex_lock(&master->scan_lock);
>>>          rc = device_register(&master->dev);
>>>          if (rc) {
>>>                  ida_free(&master_ida, master->idx);
>>> -               return rc;
>>> -       }
>>> +       } else {
>>> +               struct device_node *np = dev_of_node(&master->dev);
>> This change looks a bit different to the idx changes. What's happening here?
>>> -       np = dev_of_node(&master->dev);
>>> -       if (!of_property_read_bool(np, "no-scan-on-init")) {
>>> -               mutex_lock(&master->scan_lock);
>>> -               fsi_master_scan(master);
>>> -               mutex_unlock(&master->scan_lock);
>>> +               if (!of_property_read_bool(np, "no-scan-on-init"))
>>> +                       fsi_master_scan(master);
>>>          }
>>>
>>> -       return 0;
>>> +       mutex_unlock(&master->scan_lock);
>>> +       return rc;
>>>   }
>>>   EXPORT_SYMBOL_GPL(fsi_master_register);
>>>
>>>   void fsi_master_unregister(struct fsi_master *master)
>>>   {
>>> -       trace_fsi_master_unregister(master);
>>> +       int idx = master->idx;
>>>
>>> -       if (master->idx >= 0) {
>>> -               ida_free(&master_ida, master->idx);
>>> -               master->idx = -1;
>>> -       }
>>> +       trace_fsi_master_unregister(master);
>>>
>>>          mutex_lock(&master->scan_lock);
>>>          fsi_master_unscan(master);
>>> +       master->n_links = 0;
>>>          mutex_unlock(&master->scan_lock);
>>> +
>>>          device_unregister(&master->dev);
>>> +       ida_free(&master_ida, idx);
>>>   }
>>>   EXPORT_SYMBOL_GPL(fsi_master_unregister);
>>>
>>> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
>>> index 6d8b6e8854e5..36da643b3201 100644
>>> --- a/drivers/fsi/fsi-master-hub.c
>>> +++ b/drivers/fsi/fsi-master-hub.c
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/slab.h>
>>>
>>>   #include "fsi-master.h"
>>> +#include "fsi-slave.h"
>>>
>>>   #define FSI_ENGID_HUB_MASTER           0x1c
>>>
>>> @@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
>>>          hub->master.dev.release = hub_master_release;
>>>          hub->master.dev.of_node = of_node_get(dev_of_node(dev));
>>>
>>> +       hub->master.idx = fsi_dev->slave->link + 1;
>>>          hub->master.n_links = links;
>>>          hub->master.read = hub_master_read;
>>>          hub->master.write = hub_master_write;
>>> --
>>> 2.31.1
>>>
