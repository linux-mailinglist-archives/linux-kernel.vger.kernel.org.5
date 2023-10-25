Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC867D5F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJYA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJYA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:59:40 -0400
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99411E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698195575;
        bh=/ipvEkoiTATZg1SCm1rY3bY1B3A7FEywKqJMQJwR7Kc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YB7/RGZv2+bwoOTJWhEHZBaACPqPy1Sr2zYZxYWLirssrkhIVyliD7B8eN+k0lkrr
         Lz2R3tenVEf6qgdsHaecAgNAL399E+CvGesaCMeEL28byFm6aiqvQLGkncd3Z527qx
         Fl5PxlfesQvTiH74EQE5/FKbfo6qhepMATq96H1A=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id EE1100D6; Wed, 25 Oct 2023 08:59:33 +0800
X-QQ-mid: xmsmtpt1698195573t4w124gfh
Message-ID: <tencent_E32CAACB0495A1D7CC5122443A035FA1BC07@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTLn39unGo1eV2ThFy5PzDvlrX272gBOxj7pAilsqjDUrSxOWTFk
         5KlIrxcSCTimhdWOG7/R03tDkar8KuldneD4kTsgMFura+wmXC+ff8lEzyHqN/AP/BFKXH4uVRS3
         v6RoAbW3iVNpPsCqV7C4yFh1amYVxVRNX8sRDiOGXUsZSsNTgnOTtR8xISUcbNYp2njAYQip1bEa
         4OP5qBUaE9VmrRu0JgdFKkZxpPFjiNkgqRfg7F/+mko+ybWPVsuoZlnVyjTLkJcNqXooSj3Ie5SR
         KIrSj8EKX9YpA+W6faIpO+JySqvJ/zObGfLh7amSXIINFRqnagDPwI7qyEMwUzcflvd4iyyKIM8u
         yvi7gttU4oq+vL8Lf+GgnRAl4USDb5+/OUEw9mazLcxHOiJam1g1vB8Ohdd6wRpQnpDppyssSwI6
         MEnC3sDjFXOXAiUz/CXWqJgtOE793/0Pwv8j5q2BVbpA1qo9ESG0tUEGNC47wqusmAYCTs4y3GL+
         aRyqLB2kKLzj4vhq21j0R2oJLZZeNYHbkPD6NmEUymZo6USQ4kcP95UfLE+D9cMVpKP8urREOCmG
         ePTL83oNpJK1dXwX+TlbwvJCs7VSLyaKPTmBf9NOoZBKvGAzi8P30o/DSJpxDMpEjsX/rFr+RLac
         L8k41G7Kam6Xehxf7KBB6mipdsAhJQzl/O4jb4Jpw+sHVBVpl94RFzQ6xtWJDe9yvEfaTmX3nW0P
         i1S1fJx1Sdh/idGfGnNG9DLAKoLs0ir5ozfiWgMN5iT/op9HUF5kElqFZUV9LFnHAQhJYupaDoi6
         IWcpx0Yl1ubrFxN3J3sc9wbSBD653KfJzXHDD2dbaRmP2RAzWarhpiNWh1wonH0ugxfM6E5v44jd
         uMJ+cG3JjAhfxFSPXJbVJD76bwNQ9uXHOPxEYKsXzvTovQfTiHuENMfkI6HbmkZts86NftH3p+z1
         J6rejrfgGNgWRX5Du6KUDu6co5wzBC+pd6wrVr93gGaXI2ochu0g5Rw0g6aLsbZFE+RV4KAaw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <b0f69fc8-d14a-439f-b838-d8e0bc6d31e0@foxmail.com>
Date:   Wed, 25 Oct 2023 08:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] stop_machine: Apply smp_store_release() to
 multi_stop_data::state
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, peterz@infradead.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org, rongtao@cestc.cn,
        tglx@linutronix.de
References: <cover.1697811778.git.rongtao@cestc.cn>
 <tencent_3B1BE2B20183906E56D9E58C4AE4EBC62806@qq.com>
 <ZTej8a0ieBAqjbfn@FVFF77S0Q05N>
From:   Rong Tao <rtoax@foxmail.com>
In-Reply-To: <ZTej8a0ieBAqjbfn@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/23 7:01 PM, Mark Rutland wrote:
> On Fri, Oct 20, 2023 at 10:43:34PM +0800, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Replace smp_wmb()+WRITE_ONCE() with smp_store_release() and add comment.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/stop_machine.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index 268c2e581698..cdf4a3fe0348 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -183,8 +183,10 @@ static void set_state(struct multi_stop_data *msdata,
>>   {
>>   	/* Reset ack counter. */
>>   	atomic_set(&msdata->thread_ack, msdata->num_threads);
>> -	smp_wmb();
>> -	WRITE_ONCE(msdata->state, newstate);
>> +	/* This smp_store_release() pair with READ_ONCE() in multi_cpu_stop().
>> +	 * Avoid potential access multi_stop_data::state race behaviour.
>> +	 */
>> +	smp_store_release(&msdata->state, newstate);
> This doesn't match coding style:
>
> 	/*
> 	 * Block comments should look like this, with a leading '/*' line
> 	 * before the text and a traling '*/' line afterwards.
> 	 */
>
> See https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
Thanks, Mark, I'll fix the comment in next patch version.
>
> I don't think the "Avoid potential access multi_stop_data::state race
> behaviour." text is all that helpful, and I think we can drop that.
>
> In general, it's unusual to pair a smp_store_release() with READ_ONCE(), and
> for that to work it relies on dependency ordering and/or hazarding on the
> reader side (e.g. the atomic_dec_and_test() is ordered after the READ_ONCE()
> since it's an RMW and there's a control dependency, but a plain read could be
> reordered w.r.t. the READ_ONCE()). So we probably need to explain that if we're
> going to comment on that smp_store_release().
>
> Peter, might it be worth replacing the READ_ONCE() with smp_load_acquire() at
> the same time? I know it's not strictly necessary given the ordering we have
> today, but it would at least be obvious.

After I wait for Peter to reply to this message, I will write a patch 
based on Peter's suggestion.

Rong Tao.

>
> Mark.
>
>>   }
>>   
>>   /* Last one to ack a state moves to the next state. */
>> -- 
>> 2.41.0
>>

