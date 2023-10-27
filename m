Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB417D96EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjJ0Ltw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbjJ0Ltt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:49:49 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E0C1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698407385;
        bh=vovYC7XL/z97oRsMWqemvOzOIpZfGfmSdXKAPD1GtMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qBSPu9hNCFNoAxjCLazNHpTbcCrb8ksYefrLio37TMHORlDBhlGFXNY5LcNrpNBWA
         VkKSH5nSvd+RMNItV7tk8VEjLjIVKM26yPP9NaG4XG5GAwF7H4oyljpkYtCi+w5/Hd
         ppY+q9XXSiY6dijo4hQGUBwdUjtn6R/aEHyekizk=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id C6B2E448; Fri, 27 Oct 2023 19:49:43 +0800
X-QQ-mid: xmsmtpt1698407383tcu8w1450
Message-ID: <tencent_3501158CD78C510DC4628352A1E9AC98CB07@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwyapd5mDfNjVG3GVyBw/QJahB3RDGob+3+rhq6i/POFBG+8tzhM
         jG9tqAHnDeFMADQy5WqG1qatWPfa4JtQubM8j+fywthnx8s8Oo4H0RxOHWmYL7BvMKUCU1sEGyl6
         8fniJenjtSeInxCobv9u2h9jK8m/hUKKzLqpmmRvh3BbyvTPQBAiVHyMx8Rpt0XiaCLHMHaVMLyw
         87sC+hvWlUgqcSYgiToHT9w3BuFuV5GJQ9rXle9zdiIX73FKSfcnpqJgjIOCKjWP6Wp6xByQgCfU
         Zpl3FYpFYRZP5I8j4aJ8fQMi6RSvnz3zernuqn4o7E2+HWP05QREZp3qrnWqJzQEIVNTWK//xmKn
         YQt51GJd4mtHlMqT9TrGiQqtgyqq8OyRvYrEXeTTq8DSa7ODMGbTkcv0GMsETKS3C2h8LcVeSBqb
         EwM4iAxnX6VwBPbPMFxp+il7CquVqNm9t0DWjzMN02ne2ElK4umq7d1wGB/1EABOpiQ+XO1CbySu
         qJldcL/QMn1Zc5QEnxHuj74f07a0n6GQ0zVF7W4L0yXsXVOBUGsKCpxA8yVWWKYQwwrJ6mdupzHC
         DzebYZjdyG0LHCK9t6GMK9pZnJBxObBaEZjDYrnSdIv0nHJ8neA/n43n3WpxO82H/EuigJH/7S56
         VKsSmO/5hNvSk+9q2bGhjAW1rImp8glsjmnsT/2tP1UIxecwgjgN3Nw1y2LCkUpNhNmXbBwybSjS
         ubg+vDDg+5TFubrCKgdK3Pvc2M61G+lvfr/wyRGvnk105H4UvL6FM0jK7ppSaZ/gPQrS1qHczHnT
         7Zs0FlojoO565Hp90KwtRj6O4v0jkjCEdPLmzD8lzzUalSDJZ5agrbs1qvVURh+jpFmO77cHHWoj
         Xw+PglSoKbeudtfCHXjaa0EJxFJsKb3TJMZBcX4s01GZ5hcoXbOJVsto5I+iSbq5KDNUZHsZZ+l/
         nnH4XAp+xWL1iuSsFj6yNaQ/QECpRlktqE1tTxFBCE1/4WS5vWqJCZ+hKvmqCZ
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <a22ab6fe-47ca-42db-ad5e-013d015bbf3f@foxmail.com>
Date:   Fri, 27 Oct 2023 19:49:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stop_machine: Use non-atomic read
 multi_stop_data::state clearly
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rongtao@cestc.cn, tglx@linutronix.de
References: <cover.1697811778.git.rongtao@cestc.cn>
 <tencent_49AFDBA31F885906234219591097D42ABE08@qq.com>
 <ZTegiFbGQUAp1l0p@FVFF77S0Q05N>
From:   Rong Tao <rtoax@foxmail.com>
In-Reply-To: <ZTegiFbGQUAp1l0p@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/23 6:46 PM, Mark Rutland wrote:
> On Fri, Oct 20, 2023 at 10:43:33PM +0800, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
>> solved the race behaviour problem, to better show that race behaviour
>> does not exist, pass the 'curstate' directly to ack_state() instead of
>> refetching msdata->state in ack_state().
>>
> I'd prefer if we make this:
>
> | stop_machine: pass curstate to ack_state()
> |
> | The multi_cpu_stop() state machine uses multi_stop_data::state to hold
> | the current state, and this is read and written atomically except in
> | ack_state(), which performs a non-atomic read.
> |
> | As ack_state() only performs this non-atomic read when there is a single
> | writer, this is benign, but it makes reasoning about the state machine a
> | little harder.
> |
> | Remove the non-atomic read and pass the (atomically read) curstate in
> | instead. This makes it clear that we do not expect any racy writes, and
> | avoids a redundant load.
>
> With that wording:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.

Hi, Mark, I just submit a single patch [0] individually, not as a patchset.

please review. thank you.

Rong Tao

[0] 
https://lore.kernel.org/lkml/tencent_FB1D31CEC045E837ABE5B25CC5E37575F405@qq.com/

>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/stop_machine.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index cedb17ba158a..268c2e581698 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data *msdata,
>>   }
>>   
>>   /* Last one to ack a state moves to the next state. */
>> -static void ack_state(struct multi_stop_data *msdata)
>> +static void ack_state(struct multi_stop_data *msdata,
>> +		      enum multi_stop_state curstate)
>>   {
>>   	if (atomic_dec_and_test(&msdata->thread_ack))
>> -		set_state(msdata, msdata->state + 1);
>> +		set_state(msdata, curstate + 1);
>>   }
>>   
>>   notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
>> @@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
>>   			default:
>>   				break;
>>   			}
>> -			ack_state(msdata);
>> +			ack_state(msdata, curstate);
>>   		} else if (curstate > MULTI_STOP_PREPARE) {
>>   			/*
>>   			 * At this stage all other CPUs we depend on must spin
>> -- 
>> 2.41.0
>>

