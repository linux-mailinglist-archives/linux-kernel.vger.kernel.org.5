Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D587E96CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjKMG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjKMGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:55:59 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 389C710E6;
        Sun, 12 Nov 2023 22:55:55 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 19AC8605006E4;
        Mon, 13 Nov 2023 14:55:50 +0800 (CST)
Message-ID: <8a872467-fbf4-59dd-02eb-bc69efc5bcec@nfschina.com>
Date:   Mon, 13 Nov 2023 14:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: pm8001: return error code if no attached dev
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <f576b808-d99a-77f5-a1fc-f1366f6d6f4b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/13 14:43, Jason Yan wrote:
> On 2023/11/13 14:32, Su Hui wrote:
>> On 2023/11/13 13:56, Jason Yan wrote:
>>> Hi, Su
>>>
>>> On 2023/11/13 13:01, Su Hui wrote:
>>>> Clang static analyzer complains that value stored to 'res' is never 
>>>> read.
>>>> Return the error code when sas_find_attached_phy_id() failed.
>>>>
>>>> Fixes: ec64858657a8 ("scsi: pm8001: Use sas_find_attached_phy_id() 
>>>> instead of open coding it")
>>>
>>> This 'Fixes' tag is not right. This commit is only a refactor and 
>>> did not change the original logic here.
>>>
>> Hi, Jason
>>
>> Thanks for your reply. But I think the logic of this code is changed.
>
> I,m talking about the Fixes tag: ec64858657a8 ("scsi: pm8001: Use 
> sas_find_attached_phy_id() instead of open coding it"
>
> That commit did not change the original logic. So your patch is not 
> fixing that commit.
Oh, got it.
Really thanks for your reminder! I will send v2 patch soon:).

Su Hui

