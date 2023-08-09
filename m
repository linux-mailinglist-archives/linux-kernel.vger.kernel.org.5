Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3607776557
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHIQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHIQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:46:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A02135;
        Wed,  9 Aug 2023 09:46:03 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Gg8FQ006981;
        Wed, 9 Aug 2023 16:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XJybMffimcFGN7eCMAqWauVy/nSvh2D7EsoqGt/F+TE=;
 b=N6YP0UL2/TzeCXhsVrK78L/ezPfq+6IlHaaAKI95T4QB/qRimVORvQ1Jcw//2u+Zo3FT
 Sb/Q4UtqxD1rcMwu13qfhIxIYiZS4d5nVwDlUMeaolO9PfFqvS7JvaOPcFxH1LjyFABO
 s3J27izaJz6Bd/F7e9Go9mlTNGq54WAmgIjRFxQnOsiwQeGWTEhZ+kEyIAsFmM60sqho
 2duirDy5GxNN/v2yIQF/lwvTezX+aLYi49JY7SM+ejW5DCloPes8+6SjsjWm0nVrwf85
 6CQVo0oZqEkDOzPw2E+8gt+J/7vRaXfa3SZBL+lbIgt5swobpd7lf1yVPDkFmEJ1qOYs fA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scebdg6d1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:45:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379EPc4t001802;
        Wed, 9 Aug 2023 16:21:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f218xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:21:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379GL6IQ34996950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 16:21:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE1358054;
        Wed,  9 Aug 2023 16:21:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B83D75803F;
        Wed,  9 Aug 2023 16:21:05 +0000 (GMT)
Received: from [9.61.73.158] (unknown [9.61.73.158])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 16:21:05 +0000 (GMT)
Message-ID: <23dc749b-5c7a-6f9f-9237-6f32af2d4fa4@linux.ibm.com>
Date:   Wed, 9 Aug 2023 11:21:05 -0500
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
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xe1OmLtLrONZmqib6BhDyPHzj+HcOd15MXyK0QVHPTOEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 24FHYUMLGZsknN693dmQk5fjxXbGP5Vt
X-Proofpoint-ORIG-GUID: 24FHYUMLGZsknN693dmQk5fjxXbGP5Vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090145
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/23 02:08, Joel Stanley wrote:
> On Mon, 12 Jun 2023 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
>> Master indexing is problematic if a hub is rescanned while the
>> root master is being rescanned. Move the IDA free below the device
>> unregistration, lock the scan mutex in the probe function, and
>> request a specific idx in the hub driver.
> I've applied this series, but taking a closer look at this patch I
> think it can be improved. If you resend, just send this patch.
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-core.c       | 41 ++++++++++++++++++++++--------------
>>   drivers/fsi/fsi-master-hub.c |  2 ++
>>   2 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index ec4d02264391..503061a6740b 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -1327,46 +1327,55 @@ static struct class fsi_master_class = {
>>   int fsi_master_register(struct fsi_master *master)
>>   {
>>          int rc;
>> -       struct device_node *np;
>>
>>          mutex_init(&master->scan_lock);
>> -       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>> +
>> +       if (master->idx) {
> Why do we allocate a new idx if there's already one?


At this point, the master driver (aspeed, hub, i2cr, whatever) might 
just be requesting a certain index. It's not allocated yet, so it needs 
to be allocated so that we don't get overlap.


>
>> +               master->idx = ida_alloc_range(&master_ida, master->idx,
>> +                                             master->idx, GFP_KERNEL);
> If we can't get one in the range we want, we ask for any? Should this
> print a warning?


Perhaps, we could also return error here if we decide that the requested 
index is needed and not just wanted.


>
>> +               if (master->idx < 0)
>> +                       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>> +       } else {
> If ixd was zero, we create one. This is the "normal" case?


Yes, the assumption is: zero is the default due to zero-alloc'd master 
structures.


>
>> +               master->idx = ida_alloc(&master_ida, GFP_KERNEL);
>> +       }
>> +
> We check the same error condition again.


Yes I might be able to make this cleaner...


>
>>          if (master->idx < 0)
>>                  return master->idx;
>> -       dev_set_name(&master->dev, "fsi%d", master->idx);
>> +       if (!dev_name(&master->dev))
>> +               dev_set_name(&master->dev, "fsi%d", master->idx);
>> +
>>          master->dev.class = &fsi_master_class;
>>
>> +       mutex_lock(&master->scan_lock);
>>          rc = device_register(&master->dev);
>>          if (rc) {
>>                  ida_free(&master_ida, master->idx);
>> -               return rc;
>> -       }
>> +       } else {
>> +               struct device_node *np = dev_of_node(&master->dev);
> This change looks a bit different to the idx changes. What's happening here?


This is just restructuring to get the lock before the scan. It could be 
a separate commit, yea.

Thanks for the review!

Eddie


>> -       np = dev_of_node(&master->dev);
>> -       if (!of_property_read_bool(np, "no-scan-on-init")) {
>> -               mutex_lock(&master->scan_lock);
>> -               fsi_master_scan(master);
>> -               mutex_unlock(&master->scan_lock);
>> +               if (!of_property_read_bool(np, "no-scan-on-init"))
>> +                       fsi_master_scan(master);
>>          }
>>
>> -       return 0;
>> +       mutex_unlock(&master->scan_lock);
>> +       return rc;
>>   }
>>   EXPORT_SYMBOL_GPL(fsi_master_register);
>>
>>   void fsi_master_unregister(struct fsi_master *master)
>>   {
>> -       trace_fsi_master_unregister(master);
>> +       int idx = master->idx;
>>
>> -       if (master->idx >= 0) {
>> -               ida_free(&master_ida, master->idx);
>> -               master->idx = -1;
>> -       }
>> +       trace_fsi_master_unregister(master);
>>
>>          mutex_lock(&master->scan_lock);
>>          fsi_master_unscan(master);
>> +       master->n_links = 0;
>>          mutex_unlock(&master->scan_lock);
>> +
>>          device_unregister(&master->dev);
>> +       ida_free(&master_ida, idx);
>>   }
>>   EXPORT_SYMBOL_GPL(fsi_master_unregister);
>>
>> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
>> index 6d8b6e8854e5..36da643b3201 100644
>> --- a/drivers/fsi/fsi-master-hub.c
>> +++ b/drivers/fsi/fsi-master-hub.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/slab.h>
>>
>>   #include "fsi-master.h"
>> +#include "fsi-slave.h"
>>
>>   #define FSI_ENGID_HUB_MASTER           0x1c
>>
>> @@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
>>          hub->master.dev.release = hub_master_release;
>>          hub->master.dev.of_node = of_node_get(dev_of_node(dev));
>>
>> +       hub->master.idx = fsi_dev->slave->link + 1;
>>          hub->master.n_links = links;
>>          hub->master.read = hub_master_read;
>>          hub->master.write = hub_master_write;
>> --
>> 2.31.1
>>
