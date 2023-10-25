Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35497D5F44
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjJYAyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJYAxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:53:54 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA310E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698195223;
        bh=7UGFKvnw2KURZTmA0bm82zgAp8R9Vc0bjiJxLN1Pros=;
        h=Date:Subject:From:To:References:In-Reply-To;
        b=BtYdrWqflZmEDeNbMb3JoTrZNoeNBSAhrJeCXl+yotLmjY10rMyXhtjeGlCUvZYaF
         /LY5uCUhNpk1F43uMLOgyrccZdEuDUgjWMqy0fuOY1lbeqVRJYgYEXGN0bRSQEKY+p
         CUbE2GMdoWgoaPDiEZr/rU67PQy/fuNPVfT6Tts0=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id D699C850; Wed, 25 Oct 2023 08:53:41 +0800
X-QQ-mid: xmsmtpt1698195221tqd5ypqrg
Message-ID: <tencent_D3E0324A65FA1569940651CEA0570820CB05@qq.com>
X-QQ-XMAILINFO: M3Q/Kj4zjy609r3o/1apa4PGY2BWj3wwQLGAA7W9rPL1gx8/t5AOrNnW+x0Lkh
         4fQHY27KSnoGvfyxL4sFs+0Dkzh5sYRIU2Iv2vvO6M4Sf68ozkxAYZxJZ64HK1XTSjL6SSkeq0zs
         /481DyG30bWqx8UQ96jQViqfFIG3iPW2S3vdqexgYzkReMBo+doiUY3lTykbe/WtXT+8F4NCbabE
         xoODG/f2kP4wo8U+wXtdadCRpk63z9E4ouHkX6WWcZT4+/antN4qmMxCvqxLrU8CgaPW1hx1GDfG
         7EZfWOXeGjpxnSzkqvispJzVb7g7M0zDsavph2p8dfqnWbRIvuB66ldTvfSTRGZuvWh4VYG5KAs6
         qGQrqt5Sc3wPwJmjTR9qQTLS+2KZHlQQwwE7SK8Jp+vKbCtRPKZZE1vxfRu+5J/FHMYUp0fzMUfQ
         xjTNFls7MTGzbQGgHzd4+1Z5V1kkmiCxiTV76DoCLxrp8jaIivb3RtSDmji8TrX3awbH5cwuqYvX
         B0Vi5K5mA3ByDBlrQujWGyo2ftdimIDPT0Vj2ixiSKQxCISO4fpEiGO383H2yNvnv1IOFXqv8ZU/
         /b0Pap0jdFBTU/nI4Qees4ZbJgzHq7OXHmOnPSj7Q5uhAMCRgQ3SdlLDLAx/dDdDK+4IAZTYs0Av
         SqetXmpPPMCDr2oaX8RO3dwnEr6sTdF5V93M1FErnCHJzJOoQDVUsWKV99jZTETEFPTfpQALIqbK
         slJvBVuPUcplyC+9vDjm86hun7c5VWAhjK+lu2V5NQ/wg6DBWzGJ0K68fkmdsD/sDgTJgNTWYI3r
         OBsijGAuN54z6G/2CIsbqvKTXIvaT5WTNKkaMlbx3Wjn96/BmN7P6abLJd8QWHTJryURL8HhKa4H
         q7YlrRYH9UacM/27GYN+3K9YnvsAwp2Ykq3SOW0PihtAr66yAwn2ZppVZZ7O8b5GU1F5YDlkF1X1
         BXZWmi1IGcSkdKRsp1GcOeOcKJ88M7vj3h1CMLtxnmzhsQwFcEmn0W7sC0Xl6OkgX22aE7HCpj7A
         IqwGSkgzrMHpeU5f7eQYxr4iSECUIzEKRCgTh3bOPEDhxa44PPR55PINUTG9s=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <c1695ea2-7d54-4796-9913-d205f698f286@foxmail.com>
Date:   Wed, 25 Oct 2023 08:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stop_machine: pass curstate to ack_state()
Content-Language: en-US
From:   Rong Tao <rtoax@foxmail.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Rong Tao <rongtao@cestc.cn>, rtoax@foxmail.com
References: <e2b302f9-5840-49e8-8176-c6c5ea725895@foxmail.com>
 <cdf3d6f1-5cfb-4bea-a19c-f523ec80eb68@foxmail.com>
In-Reply-To: <cdf3d6f1-5cfb-4bea-a19c-f523ec80eb68@foxmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/23 8:50 AM, Rong Tao wrote:
>
> On 10/25/23 8:43 AM, Rong Tao wrote:
>> The multi_cpu_stop() state machine uses multi_stop_data::state to hold
>> the current state, and this is read and written atomically except in
>> ack_state(), which performs a non-atomic read.
>>
>> As ack_state() only performs this non-atomic read when there is a single
>> writer, this is benign, but it makes reasoning about the state machine a
>> little harder.
>>
>> Remove the non-atomic read and pass the (atomically read) curstate in
>> instead. This makes it clear that we do not expect any racy writes, and
>> avoids a redundant load.
>
> I'd prefer if we make this comment:
>
> stop_machine: pass curstate to ack_state()
OK, thanks a lot, i'll try that.
>
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>  kernel/stop_machine.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index cedb17ba158a..268c2e581698 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data 
>> *msdata,
>>  }
>>
>>  /* Last one to ack a state moves to the next state. */
>> -static void ack_state(struct multi_stop_data *msdata)
>> +static void ack_state(struct multi_stop_data *msdata,
>> +              enum multi_stop_state curstate)
>>  {
>>      if (atomic_dec_and_test(&msdata->thread_ack))
>> -        set_state(msdata, msdata->state + 1);
>> +        set_state(msdata, curstate + 1);
>>  }
>>
>>  notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
>> @@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
>>              default:
>>                  break;
>>              }
>> -            ack_state(msdata);
>> +            ack_state(msdata, curstate);
>>          } else if (curstate > MULTI_STOP_PREPARE) {
>>              /*
>>               * At this stage all other CPUs we depend on must spin

