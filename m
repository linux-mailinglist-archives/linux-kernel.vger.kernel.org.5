Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899877F332
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349538AbjHQJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349525AbjHQJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:25 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EF273C;
        Thu, 17 Aug 2023 02:25:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpzO9uF_1692264316;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpzO9uF_1692264316)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 17:25:17 +0800
Message-ID: <78348c02-6f5a-2d25-b417-089346f4d412@linux.alibaba.com>
Date:   Thu, 17 Aug 2023 17:25:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 4/6] net/smc: support max connections per lgr
 negotiation
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>, wenjia@linux.ibm.com,
        kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-5-guangguan.wang@linux.alibaba.com>
 <dcbb9692-0494-1161-d873-ef67b3e7cb6d@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <dcbb9692-0494-1161-d873-ef67b3e7cb6d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/17 14:42, Jan Karcher wrote:
> 
> 
> On 16/08/2023 10:33, Guangguan Wang wrote:
...
>> @@ -1163,6 +1173,11 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>>   {
>>       struct smc_clc_v2_extension *pclc_v2_ext;
>>   +    /* default max conn is SMC_CONN_PER_LGR_MAX(255),
>> +     * which is the default value in smc v1 and v2.0.
>> +     */
> 
> I'm afraid this comment is not going to age well. You already put this to the define itself so i plea to remove it here.
> 
> Thank you.
> - Jan
> 

Get it, Thanks.
