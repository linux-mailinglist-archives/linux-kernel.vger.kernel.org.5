Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74177B7A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbjJDIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbjJDImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:42:46 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A1A7;
        Wed,  4 Oct 2023 01:42:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VtMTZNd_1696408958;
Received: from 30.13.48.40(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VtMTZNd_1696408958)
          by smtp.aliyun-inc.com;
          Wed, 04 Oct 2023 16:42:40 +0800
Message-ID: <0af36858-5141-4e7b-744d-ec446993010f@linux.alibaba.com>
Date:   Wed, 4 Oct 2023 16:42:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
 <1fc9a6aa-019d-f3f5-7cac-3b78388c2730@linux.ibm.com>
 <4bac8bcf-5507-0982-fed2-c507fc3264c2@linux.alibaba.com>
 <da1d0698-ea4c-12b3-3e20-fc9b65e56a3a@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <da1d0698-ea4c-12b3-3e20-fc9b65e56a3a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/29 21:31, Alexandra Winter wrote:
> 
> 
> On 28.09.23 19:29, Wen Gu wrote:
>>
>>
>> On 2023/9/28 16:56, Alexandra Winter wrote:
>>>
>>>
>>> On 27.09.23 17:16, Alexandra Winter wrote:
>>>> Hello Wen Gu,
>>>>
>>>> I applied and built your patches and noticed some things that you may want to consider in the next version:
>>>
>>>
>>> FYI, patchwork basically complains about many the same issues:
>>> https://patchwork.kernel.org/project/netdevbpf/list/?series=787037&state=*
>>>
>>> In general you should run those check BEFORE you send the patches and not rely on patchwork.
>> Thank you Sandy. I seem to have not seen the specific content of these checks. May I ask how to
>> run those patchwork check locally? So that I can make sure everything is ok before send them.
>>
> 
> Citing from Documentation/process/maintainer-netdev.rst :
> 
> "patchwork checks
> ~~~~~~~~~~~~~~~~
> 
> Checks in patchwork are mostly simple wrappers around existing kernel
> scripts, the sources are available at:
> 
> https://github.com/kuba-moo/nipa/tree/master/tests
> 
> **Do not** post your patches just to run them through the checks.
> You must ensure that your patches are ready by testing them locally
> before posting to the mailing list. The patchwork build bot instance
> gets overloaded very easily and netdev@vger really doesn't need more
> traffic if we can help it."
> 
> HTH

Thank you! Sandy.
