Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC27A136B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjIOB7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjIOB7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:59:06 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727AB3586;
        Thu, 14 Sep 2023 18:59:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vs5Dx3L_1694743137;
Received: from 30.221.129.81(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vs5Dx3L_1694743137)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 09:58:58 +0800
Message-ID: <482c24aa-ceff-6bb9-a14e-b6dc4ea775e2@linux.alibaba.com>
Date:   Fri, 15 Sep 2023 09:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next] net/smc: Introduce SMC-related proc files
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
 <2b1d129c-06e2-0161-7c8a-1e930150d797@linux.ibm.com>
 <a0a4567e-07f1-91db-50cb-bbfc803f5969@linux.alibaba.com>
 <30bbcc92-f5ff-cbda-7a3b-cc801aa560ed@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <30bbcc92-f5ff-cbda-7a3b-cc801aa560ed@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/14 18:29, Alexandra Winter wrote:
> 
> 
> On 13.09.23 11:53, Wen Gu wrote:
>>
>>
>> On 2023/9/11 19:54, Wenjia Zhang wrote:
>>>
>>>
>>>
>>> Hi Wen,
>>>
>>> I can understand your problem and frustration. However, there are two reasons I'm not really convinced by the proc file method:
>>> 1) AFAI, the proc method could consume many CPU time especially in case with a log of sockets to read the pseudo files.
>>> 2) We have already implemented the complex netlink method on the same purpose. I see the double expense to main the code.
>>>
>>> Then the question is if the lack of dependency issue can be handle somehow, or the proc method is the only way to achieve this purpose?
>>>
>>> Any opinion is welcome!
>>>
>>> Thanks,
>>> Wenjia
>>
>> Hi, Wenjia. I agree with your concerns.
>>
>> My initial intention is to make these proc files serve as a supplement to netlink to conveniently
>> check smc connections in an environment where smc-tools cannot be easily obtained.
>>
>> Yes, proc files won't be the first choice for diagnosis, but can be a convenient backup.
>>
>> Thanks,
>> Wen Gu
>>
>>
> As /proc is an interface to userface,  we would have to maintain the 2 redundant methods basically forever.
> I personally don't think we should implement another interface without a very strong reason.


I understand, thank you Alexandra and Wenjia.

Regards,
Wen Gu
