Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F27FED75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjK3LCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjK3LCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:02:04 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053FD50;
        Thu, 30 Nov 2023 03:02:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VxRQVSY_1701342127;
Received: from 30.221.130.31(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxRQVSY_1701342127)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 19:02:08 +0800
Message-ID: <319ca57a-c89b-ba37-c5ca-e1eafc73392f@linux.alibaba.com>
Date:   Thu, 30 Nov 2023 19:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2 1/7] net/smc: Rename some variable 'fce' to
 'fce_v2x' for clarity
To:     Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
 <1700836935-23819-2-git-send-email-guwen@linux.alibaba.com>
 <298442c7-40f0-42ab-b5cb-07603d8689f5@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <298442c7-40f0-42ab-b5cb-07603d8689f5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/29 20:50, Wenjia Zhang wrote:
> 
> 
> On 24.11.23 15:42, Wen Gu wrote:
>> Rename some smc_clc_first_contact_ext_v2x type variables to 'fce_v2x'
>> to distinguish them from smc_clc_first_contact_ext type variables.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_clc.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 0fda515..c41a249 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -418,15 +418,15 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
>>       return true;
>>   }
>> -static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>> +static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce_v2x,
>>                   struct smc_init_info *ini)
> 
> Since this function is only used by v2.x, IMO, this function name could also be changed to e.g. smc_clc_fill_fce_v2x.

Thank you, Wenjia. The function name will also be changed.
