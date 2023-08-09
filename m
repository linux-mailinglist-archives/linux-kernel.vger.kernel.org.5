Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BA775EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHIM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:27:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD541FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:27:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdf08860dso185962066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691584049; x=1692188849;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8ywn3mV6e+GJCfiiUtxI+ObwntWBtkLOtVXVTHY2kc=;
        b=o4HnDm0Rf40dlIzqHVdliEJs6BGofFUWEc82DCjJwpJKRMkyQQPvSPwCi67feDU0CJ
         i1QDPMUNWG2C8tI/5cAL+Q15LjM7vhcp5xCTshDElGI/j0Gzahw3vjkwn6T/vz26KpzM
         h8O3SeCLNpCj+woksb4E/vebTtxdM9z8j9izj8ic7RfEPudZQfnzt5GO72wLqh1iZJM/
         EimHohqFfRXFxBOidGmfG1nJwhfxRMdc1FKuu/8H6vvDeODVG8igaYUTw82zs28EkTn5
         8YNGPB34YMNEEMRLjIY7eLdZ/ZP0FLNXsjcZCRCt96PnDrBRi7PrQ06N/5a/ZxB7vENC
         rWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584049; x=1692188849;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+8ywn3mV6e+GJCfiiUtxI+ObwntWBtkLOtVXVTHY2kc=;
        b=T9zpgBL5vl7WDQ9hoT4p5DbiWym5Dn+zs/D+D38xfN5BNuI8bNBVlQp2ySwYq1Efy9
         FOeDlPTlXSMQppAIP/fgy+4lOflH45rz9CVZYTlN3JfjxY/6Kxz8xUgr3wGucDsluvpK
         L3K3QgFiU2XzDiVPSLifwZaq3UeU7y2M3B4VLbZiSijpFI1uQ+bmqfWdPK507CW0Gw8P
         G5nza9o1gtuChvUK8ORvmybZwCByVDH91WAAHFPkVl9F17IuU45WoButjwp4HxzcXWBr
         LCjsnA+zWQKisayY+RnYJlFekqA15EO2kSQxRHIhzZUzNbAmAW8cwonM1CW+SRpu1Sy5
         EBkw==
X-Gm-Message-State: AOJu0YwjWsIT4BOrZ9OqmD7kJORTCDV/RBdQtd1n3Qgd0o7n5/Vaamtn
        i0/Eg104hnfCyJepMTBj2Ts=
X-Google-Smtp-Source: AGHT+IFvDc9ngRHx4OdJfWD379IErdsU4/Et0nRr9jv0pDhSgIcyjdOjFh7oOXwvdAKUDchoLk6szQ==
X-Received: by 2002:a17:907:3f93:b0:99b:cadd:c2ee with SMTP id hr19-20020a1709073f9300b0099bcaddc2eemr15882096ejc.29.1691584049076;
        Wed, 09 Aug 2023 05:27:29 -0700 (PDT)
Received: from ?IPV6:2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3? (2001-1ae9-2f0-fa00-546f-93fc-49cd-cae3.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3])
        by smtp.gmail.com with ESMTPSA id la4-20020a170906ad8400b0099bd682f317sm7807491ejb.206.2023.08.09.05.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:27:28 -0700 (PDT)
Message-ID: <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
Date:   Wed, 9 Aug 2023 14:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Petr Skocik <pskocik@gmail.com>
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
Content-Language: en-US
In-Reply-To: <202211220913.AF86992@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Is there anything else I can do to help get this (or some other 
equivalent change that results in kill(-1,s) returning -ESRCH when it 
has nothing to kill (like it does on the BSDs),
as opposed to the current return value of 0 in that case) incorporated 
into mainline Linux?

It would rather help some of the user software I'm developing, and the 
slightly new semantics are IMO definitely reasonable (BSDs have them).

Basically, the current code:
         int retval = 0, count = 0;
         struct task_struct * p;

         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 ++count;
                 if (err != -EPERM)
                     retval = err;
             }
         }
         ret = count ? retval : -ESRCH;

counts kill attempts at non-1, other-process pids  and sets hardcoded 
-ESRCH only if no such attempts are made, which will almost never happen

for a nonroot EUID, because there will typically be non-pid-1 processes 
unkillable by the nonroot EUID, but the code will still count those kill 
attempts, and thus not return the hardcoded -ESRCH even if ALL of those 
kill attemtpts return -EPERM, in which case -ESRCH would be in order 
too, because there were no processes that the current EUID had 
permission to kill (BDSs indeed return ESRCH in such a case).

(The kernel shouldn't need to concern itself with possible racy creation 
of new EUID-killable processes during the kill(-1,s) walk. Either the 
system can be known not to have running superuser code that could racily 
create such EUID-killable processes and then such a kill-returned -ESRCH 
would be useful, or it cannot be known not to have such running 
superuser code, in which case the -ESRCH is transient and should be 
droped by the user).

The current code also implicitly assumes either all non-EPERM kill 
attempts return -EINVAL (invalid signal) or they
all return 0 (success). This assumption should be valid because either 
the signal number is invalid and stays invalid, or it is valid and
the only possible error is -EPERM (this isn't sigqueue so the kill 
shouldn't ever fail with -ENOMEM). If the assumption were not valid,
then the current code could overshadow a previous failed attempt with a 
later succesful one, returning success even if there were some non-EPERM 
failures.

My change proposes:

         struct task_struct * p;

         ret = -ESRCH;
         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 if (err != -EPERM)
                     ret = err; /*either all 0 or all -EINVAL*/
             }
         }

i.e., start with -ESRCH (nothing to kill) and any non-EPERM kill 
attempts change it to the last return value
--either all 0 or all -EINVAL as per the implicit assumption of the 
original code.

It passes the tests put forth by Kees Cook.

More defensively, the implicit assumption of the original code could be 
made explicit:


         struct task_struct * p;
         int has_last_err = 0;

         ret = -ESRCH;
         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 if (err != -EPERM){
                     if (has_last_err)
                         BUG_ON(ret != err); /*either all 0 or all -EINVAL*/
                     has_last_err = 1;
                     ret = err;
                 }
             }
         }

or dropped;

         struct task_struct * p;
         int has_last_err = 0;

         ret = -ESRCH;
         for_each_process(p) {
             if (task_pid_vnr(p) > 1 &&
                     !same_thread_group(p, current)) {
                 int err = group_send_sig_info(sig, info, p,
                                   PIDTYPE_MAX);
                 if (err != -EPERM){
                     if (has_last_err){
                         if (err >= 0)
                             continue; /*don't mask previous failure 
with later success*/
                     }
                     has_last_err = 1;
                     ret = err;
                 }
             }
         }

Thanks again for consideration. Criticism welcome.

Regards,
Petr Skocik


On 11/22/22 18:15, Kees Cook wrote:
> On Tue, Nov 22, 2022 at 05:12:40PM +0100, Petr Skocik wrote:
>> Hi. I've never sent a kernel patch before but this one seemed trivial,
>> so I thought I'd give it a shot.
>>
>> My issue: kill(-1,s) on Linux doesn't return -ESCHR when it has nothing
>> to kill.
> It looks like LTP already tests for this, and gets -ESRCH?
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/containers/pidns/pidns10.c
>
> Does it still pass with your change?
>

