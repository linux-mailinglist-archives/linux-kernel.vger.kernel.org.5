Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04707BC67E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjJGJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjJGJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:45:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7FBC;
        Sat,  7 Oct 2023 02:45:35 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S2gMY6H80z1P7j2;
        Sat,  7 Oct 2023 17:43:05 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 17:45:33 +0800
Message-ID: <fa567e0b-00ca-76ad-f9e7-a554714f813c@huawei.com>
Date:   Sat, 7 Oct 2023 17:45:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 08/10] scsi: scsi_debug: Add new error injection reset
 lun failed
Content-Language: en-US
To:     <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-9-haowenchao2@huawei.com>
 <fd68ba92-7736-4924-945e-4bb238a02860@interlog.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <fd68ba92-7736-4924-945e-4bb238a02860@interlog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/7 5:04, Douglas Gilbert wrote:
> On 2023-09-22 05:29, Wenchao Hao wrote:
>> Add error injection type 3 to make scsi_debug_device_reset() return FAILED.
>> Fail abort command foramt:
> 
> s/foramt/format/
> 
>>
>> Examples:
>>      error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
>>      echo "0 -10 0x12" > ${error}
> 
> These examples are misleading. Same with the one in patch 7/10 . The example
> should be showing an invocation that exercises _this_ patch. So the first
> byte of the echo should be 4 not the 0 shown above.
> 
> Doug Gilbert
> 

Would update in next version. Would you continue reviewing patch 9/10 and 10/10?

