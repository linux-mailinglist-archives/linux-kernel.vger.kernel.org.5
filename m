Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281027844AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjHVOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjHVOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:49:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209B126
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:49:08 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVXGL1lj2zLpFQ;
        Tue, 22 Aug 2023 22:46:02 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 22:49:05 +0800
Subject: Re: [PATCH -next] greybus: svc: Remove unused declarations
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <johan@kernel.org>, <elder@kernel.org>,
        <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <20230818124338.37880-1-yuehaibing@huawei.com>
 <2023082220-washbowl-shed-6be9@gregkh>
From:   Yue Haibing <yuehaibing@huawei.com>
Message-ID: <db71380f-c84a-5f11-5ec8-4e81a0a061f0@huawei.com>
Date:   Tue, 22 Aug 2023 22:49:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2023082220-washbowl-shed-6be9@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/22 22:32, Greg KH wrote:
> On Fri, Aug 18, 2023 at 08:43:38PM +0800, Yue Haibing wrote:
>> Commit 84427943d2da ("greybus: svc: drop legacy-protocol dependency")
>> removed these implementations but not the declarations.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/greybus/svc.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/linux/greybus/svc.h b/include/linux/greybus/svc.h
>> index 5afaf5f06856..da547fb9071b 100644
>> --- a/include/linux/greybus/svc.h
>> +++ b/include/linux/greybus/svc.h
>> @@ -100,7 +100,4 @@ bool gb_svc_watchdog_enabled(struct gb_svc *svc);
>>  int gb_svc_watchdog_enable(struct gb_svc *svc);
>>  int gb_svc_watchdog_disable(struct gb_svc *svc);
>>  
>> -int gb_svc_protocol_init(void);
>> -void gb_svc_protocol_exit(void);
>> -
>>  #endif /* __SVC_H */
>> -- 
>> 2.34.1
>>
> 
> Nice, how did you find these?

Just use grep to check like below, then filter out known false item

grep -rP --include=*.h '^(?:\w+\s+){1,3}\*{0,3}\s{0,3}\w+[\t]*\(' * |grep -P -oh '\w+\s*\('|sort| uniq -c| sort -n| grep -P '^\s+1\b'|sed -r -e 's/^\s+1\s+//' -e 's/\(//'|while read line ;
 do
        CNT=`git grep -w $line |wc -l` ;
        if [ $CNT -eq 1 ];then
                git grep -wn $line
        fi
done


> .
> 
