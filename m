Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461577AAAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjIVHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjIVHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:55:29 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3EDF7;
        Fri, 22 Sep 2023 00:55:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VschXEq_1695369317;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VschXEq_1695369317)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 15:55:18 +0800
Message-ID: <39f264e0-bcc4-97f8-57ca-8a8bee28c27b@linux.alibaba.com>
Date:   Fri, 22 Sep 2023 15:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v3 09/18] net/smc: introduce SMC-D loopback
 device
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-10-git-send-email-guwen@linux.alibaba.com>
 <2ab26484-3abe-f741-e7b1-83135dd95d2c@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <2ab26484-3abe-f741-e7b1-83135dd95d2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/22 07:32, Wenjia Zhang wrote:
> 
> 

<..>

>> +
>> +#ifndef _SMC_LOOPBACK_H
>> +#define _SMC_LOOPBACK_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <net/smc.h>
>> +
>> +#define SMC_LODEV_MAX_DMBS 5000
>> +
>> +struct smc_lo_dev {
>> +    struct smcd_dev *smcd;
>> +    struct device dev;
>> +};
>> +
> I'm just wondering why don't use pointer for dev?
> 

The 'struct device' is a generic structure embeded, used to associate a Linux device
with a specific device. So I think variable for dev here is OK. See also struct ism_dev.

Thanks.

>> +int smc_loopback_init(void);
>> +void smc_loopback_exit(void);
>> +
>> +#endif /* _SMC_LOOPBACK_H */
