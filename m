Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9844B7D5F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJYAuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:50:23 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E4E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698195018;
        bh=45eCgoBDJWM1cLlzIrUFrDR5YahR8JmJM/HT9lRcsUI=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=n4mqCO0zvtrdC/Y95bAB/w3+Q6wRLkWD0AUslFreFg0XIriLX9Iktj+BPWWXHK6uj
         ie367ZTU0jyU263L7znY0Wwy+wHGkTcQWXX2Acfbs6ECjNCVPyamIl3OWo0fW6rWZp
         1zOCbUksU7Eo3+nmBrfunXqOEc59eKiE9eJW23Z8=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id C90A145C; Wed, 25 Oct 2023 08:50:16 +0800
X-QQ-mid: xmsmtpt1698195016tczu6fp14
Message-ID: <tencent_8BA39A88B7064A427B59AF97B42A6EAFD808@qq.com>
X-QQ-XMAILINFO: MmCmH9jyqHC2rX88bCSOHJrV8cQgBr8qe3/ubY+JnhXD9J1IZH7glBrlM5cK7r
         SPdU5Ey3lx8a5AXXFrJ4Y78SGqvxm3PRliWLCn+V/tx5RC+aqqcBr45KdLiwtkimZ1LvPnOqYc3c
         xgNkrUP9486LsqsRV6sy2wV6+NgYxxq34M/kwvhkzPWw4wMGJLXahB0/bcQHBwVj/pQaik2d0qnW
         tQIml7/Z+MGYzoFYtH9yC26tsJdZR99OwNthITXY9IApnfCsB7h0zVhHp2TbtX+e8u9ndjbms4Pn
         VgbY1ESJlx5P2c/p/iBsFEyiGDlVqxB4uRFjCxwOPIZGpy5pMsukZs/YAHSw49YT6mNJXFIMbyl+
         Aa5ytd5btJoQE7QJAN+G2fIRpBt//GlnekpVNs88OP370AZ9Z5iDzAnkGRgEaubIUCnM2iwYU1JH
         eedw4akOOvlIxL2KDqeaiXEE7+HcSne+7Etd0f/gM/fxqVRu7auwfTTlzjX/1KuyjMZw4qKh2UP2
         ExSyhXQ26tyZHulgEY7xPB3TH/KBlDBF52bRs+jOyeH0wLUzOpMpMitCiFZ4GHiTI+bAVOUWfw2/
         emS60F3w1DEW7DPRnS/srRApww+Uyr5tn1GK5QNHuoCNCOFP4Xj942Z+02V56NEeYOGlqDOZcM4k
         /HwSh0ueR1x2DyfRdHoz2vMGTDmzVqs5is4H9TkQBadLRc0h2+f6MjOrnfMqmq+36tLGiSyQI25Y
         svTSj0CIjAn76zezViXlbU/lU6g8Tfg9RJKddKH0C7z65UJDKOHz+Mwe9pzAVes9TOyPcze/MmLt
         junLsg5cb7sLxn1RFH4H1OePOlICrgf6t9KBst5JRhFMn0oMyvhphftHxeIOB3EesxKCYu8+JAd2
         F67Rij7XwX/QoaI2II/MhJXzO7nk/bXY9zuhZN8CqSMSB2m9FGDYKMCj47oKaOJY5Xqcz0J7/F80
         gWUfH+SQQ5aLxAQDYndCGORjcfWNKvhSeaPeIs3gynMs7OtzDq7ft2Xe7C/G+N
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <cdf3d6f1-5cfb-4bea-a19c-f523ec80eb68@foxmail.com>
Date:   Wed, 25 Oct 2023 08:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stop_machine: pass curstate to ack_state()
Content-Language: en-US
To:     open list <linux-kernel@vger.kernel.org>,
        Rong Tao <rongtao@cestc.cn>
References: <e2b302f9-5840-49e8-8176-c6c5ea725895@foxmail.com>
From:   Rong Tao <rtoax@foxmail.com>
In-Reply-To: <e2b302f9-5840-49e8-8176-c6c5ea725895@foxmail.com>
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


On 10/25/23 8:43 AM, Rong Tao wrote:
> The multi_cpu_stop() state machine uses multi_stop_data::state to hold
> the current state, and this is read and written atomically except in
> ack_state(), which performs a non-atomic read.
>
> As ack_state() only performs this non-atomic read when there is a single
> writer, this is benign, but it makes reasoning about the state machine a
> little harder.
>
> Remove the non-atomic read and pass the (atomically read) curstate in
> instead. This makes it clear that we do not expect any racy writes, and
> avoids a redundant load.

I'd prefer if we make this comment:

stop_machine: pass curstate to ack_state()

>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/stop_machine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..268c2e581698 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data 
> *msdata,
>  }
>
>  /* Last one to ack a state moves to the next state. */
> -static void ack_state(struct multi_stop_data *msdata)
> +static void ack_state(struct multi_stop_data *msdata,
> +              enum multi_stop_state curstate)
>  {
>      if (atomic_dec_and_test(&msdata->thread_ack))
> -        set_state(msdata, msdata->state + 1);
> +        set_state(msdata, curstate + 1);
>  }
>
>  notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> @@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
>              default:
>                  break;
>              }
> -            ack_state(msdata);
> +            ack_state(msdata, curstate);
>          } else if (curstate > MULTI_STOP_PREPARE) {
>              /*
>               * At this stage all other CPUs we depend on must spin

