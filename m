Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF27544D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGNWK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGNWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:10:25 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BF2726
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689372620; bh=9awcqrYuXfJnUHrkZt3zPg2MddDVeNL+pl1ziKRpihI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=o44Ni8Ka36BTv5Mv8PAtR537Z4WveQiS7OYhl4cKH1dXaDm6ipVhs2pkONmzw/WADuUFKnNtsg/KSMjM8iXD9FrA1sElz06NpZJSPvXDBVuxnzUNKFwq+1C0TL/4UFDu/a8lBQUaOI97+n2oWG5z2HX87dZAyfcEXZv07eOYeiHB2PgvBAn3KK28YEbX4yNx1gMO3V8TlZ0n/90+d0mXuptHrcuWEaYcFXjTNPKg7pX2DeXQkibQcefdliXXCUBtDdDEMBB225bCxLs9opAazMJBH4+gzJh2pwck759cz4Yd1qNm5rDhXFrW77lTOLnmrChleG5jgb+3ijXqUwf1kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689372620; bh=Astf+RCulySK4pQ7ueDHeBTiUuOjIj/XCsUuQlt/26b=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GkxG/uawyOPme/j2HL4Jr+RGQk50MuhU/dTHzXtf5gaPzTvNq5wLhxfbVLPLCUFqcnCPUUtpxgNsazQ48j/Md53mthJZZb9DUES62c/pBFb4wuYkJ6WdQhj05KMj9Awu5UCbMc3Iuimsdd4almTWSZdWdAnQfyMmGn8lvd+v6InQwo2LIerdhghTOF6A7uJ/fC2U71m55Bt0V21ENHvPp0N78zMhPEPg30GQzFblyYHMSGOfKFVEnspP3XNIhKa2+hVavya/LXVESRT7+uumIgCXf+RP4kHycn0PyB4hVSGpLVZgcU35QySBDwrpZO6Og6R7yqVMGjzIS9cthHC9lQ==
X-YMail-OSG: GTJ1fYgVM1lFMLIC3rO1F_.uXoZjklWVIWmK9TwufHzJr1lMXWvPrAs8hKsPpci
 7oO5nrf_9Bw_YEP2z6eRzR3HDUacmTjvxkPRjs3JhfQkOqGur6vCNebZ964iiI7OzZaWIqVIe1VL
 SRjcB1WUILmJ07Oznx2pU_bffOV97B_NxRoNlSXW_no3TtjL3u023hWsbJTUuPmu7cy0KZi5hBWJ
 qynV9dyF56mprAksrukWC0rHizhkxEASzak1Arb.wBsSeNjkiHJ88NNbzEdQqrAXmhdTo2WGi7Hw
 jaBjHHs_0iwUiGwFX.DKvoHMFgkGH1y8y4qU3uj6dKrOfXlwMKPJVgEvF0h6zZYhXD4LKGdCUFX_
 k3BlhqvPB6S8EHBRgNYwcdrGcdRDDk9zzxGCFlq31pwJbTWvHGTwMyNP059NS8LHMenLUgRfuE7Y
 CbGkWeFKb9jYbCNneMpODLMuIAOylQx4I4V4FuEVNk_bg_W3mgOjLUY7EfC5T7QjpR46QEo7wMyR
 L5kjpKpLpEKuvyCLhQerTsv_PHkRyV1FIch0100_Rd9OyVNIGv9wr6DiGetZ0JxgS7nLg_.WEljB
 jK4QKk_c4Gehyo7uwOzq_hy.ZlzsEJH9TfrIC0l1SDa7yfm4g3MJEztSyKBcPPRDCFDRnEB4I2x5
 hmnP1nORijF4I6ctfBqNNae3gd272quu85DlysseI_QZEeIOcQUx219ALZZcCu6JpBriL8XsPyNs
 ME81Yqi3zypJ5s2rxd8XT_WOXUWhVPO2nOoXO1LUB5LtJsp9qVSTmcEm.qu0FUnQ6KLcvYfypp92
 UMzOVJeb.kJ4RzUP1fHGIUUPKunh6tsBj65NbfNab0ZuqK5imPLccslWaPr2XKWRtB9Bol1hy463
 ._yBKnZumN2WfqwBX6fjgyPs4oeMktsUgOz_LnZUq8AgVBAnB8vOR3m1pboqN7qZruoj7bdJNz2O
 UNNPSSy2PcvyWC4BvpTh0bBfsYdB281ZyDWqfs2Vl4WPlYY9gBXDnV_EAEeiazdRdEAa4aXYTZAY
 9i5LYlN6BE2pT5.KMbcDvy242ENzhBwKji3TFmWJLA5WgPmQTfPPPIXCMyI7GxalKFBR8LQmQVVf
 7OZpOFHXt7_A6E28_tSisyjJc1HTUAwsr7REM4PJwIMuh22ks90SCGcRNZ0rZJJyGFZTnrSpRtn5
 Rawr2ANualSMxh617jfWo6WyJWi_NBVR.fJadkITp.chXUmIqFXhlMT4fgqDYQ9p76EA1hrJFdzB
 ji.Oa5V8Xnk5q8ZQtA.24DCHamdWL0FIoyDkB61cuM6WFw_xSsOu7N0XaWzTwMWTPK5EsJHlMnK4
 vtr5tAM1C_qBgZalAuRzTd4yJBOZNZJtj5WObfOkWmwlZwiACupexbc4lsyp575F6IH2Y887OPo7
 v2kqGmqWu0n3jh39gEO_0f8ownJ.gTm77_bc3QaXjOICzImvVqPDWO0nbm5xNP7a8J6sqLNt4XHX
 PnZoseS4WizqyZIsaZXiEZwc6JitFsVOp949AgXlKP2j6Q87cYD1rgAcfi7lCbtVaRxzhJuLsoKo
 pu3kS2ZQ5OPsbGHtvKCMHC36kwZ4xbSkC9u29BdfplJhv3.2RBSTtiuYC82EzcqkWFR6mjMMm5IX
 kbmuiM2gaLjcnDH34BCoeqNxRva2WU7WzZ4AYTikEA78jIn8uY5sWqu8EtYEq9pF7doNdqyge7C5
 mCTup9g7n47ikbFpdoGatxHws867..zMOHM_WDSAQaV4tOpIfXqUB1AFTHgvm495AWM1ZpzzKcG5
 xwMoKgx1Vxng0n53pUDLsM6h9DVapc.VfXcRsd4AbqtSTqinRsF8smgsc897zgvqVnTEO6cyb4lb
 Exn.YV.gFRUdO3lGfT0uPaK7ZiqIlhAFesA5To8eTOE3CdY1ulUFMA4m78LbCKkEyZC7.5f3Xg9X
 _EN94VJ5x85THOz3GDaOk5Lats3Ivv8bB8dzkSSktLkXYRxIDRl3WcVhQDUsg94nqGpcKCbU1rTP
 2WnKJmtyd4fZK1gXisWv2SPuuma9NRc2UFRW5fAJfYsaPGtJXs9gaHOdrpEMEj_AOXqGA_J5.OyI
 xLLRGId0DRlpD9BUnJ5K9AVEOsXx38flaOxG.zgHIsu2k2OMv9cbPp7vbSGCmIvONJmoAjZw_R8k
 AwQoy.6r0zVEX3rgPm3ttUkykbaWdzsaN75Jr.zp8n2vIOd5pF69hD1mnJiLPyycVdg2ZziCYJZe
 vaDAfwbz.Q3vZzOiyZai5tPyqO68N7R4LGoMRDhbPwXFgP0kjalSRyOrO3ebucaCWxWcFh1nixs.
 N3Vvnd5tttLXfXt4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a4d51596-7613-4fba-a013-8634123ff7d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Jul 2023 22:10:20 +0000
Received: by hermes--production-bf1-5d96b4b9f-nxwcd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6406e354afdfe220f20ce68de2be9533;
          Fri, 14 Jul 2023 22:10:17 +0000 (UTC)
Message-ID: <4be2b35f-964b-fac7-0ecf-ba0503128ee7@schaufler-ca.com>
Date:   Fri, 14 Jul 2023 15:10:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-6-casey@schaufler-ca.com>
 <191b9511-b2d7-aced-21bf-0efa68c3a24c@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <191b9511-b2d7-aced-21bf-0efa68c3a24c@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 8:36 AM, Mickaël Salaün wrote:
>
> On 29/06/2023 21:55, Casey Schaufler wrote:
>> Create a system call to report the list of Linux Security Modules
>> that are active on the system. The list is provided as an array
>> of LSM ID numbers.
>>
>> The calling application can use this list determine what LSM
>> specific actions it might take. That might include choosing an
>> output format, determining required privilege or bypassing
>> security module specific behavior.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> ---
>>   Documentation/userspace-api/lsm.rst |  3 +++
>>   include/linux/syscalls.h            |  1 +
>>   kernel/sys_ni.c                     |  1 +
>>   security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>>   4 files changed, 44 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/lsm.rst
>> b/Documentation/userspace-api/lsm.rst
>> index e6c3f262addc..9edae18a2688 100644
>> --- a/Documentation/userspace-api/lsm.rst
>> +++ b/Documentation/userspace-api/lsm.rst
>> @@ -63,6 +63,9 @@ Get the specified security attributes of the
>> current process
>>   .. kernel-doc:: security/lsm_syscalls.c
>>       :identifiers: sys_lsm_get_self_attr
>>   +.. kernel-doc:: security/lsm_syscalls.c
>> +    :identifiers: sys_lsm_list_modules
>> +
>>   Additional documentation
>>   ========================
>>   diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 9a94c31bf6b6..ddbcc333f3c3 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned
>> int attr, struct lsm_ctx *ctx,
>>                         size_t *size, __u32 flags);
>>   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct
>> lsm_ctx *ctx,
>>                         size_t size, __u32 flags);
>> +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32
>> flags);
>>     /*
>>    * Architecture-specific system calls
>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index d03c78ef1562..ceb3d21a62d0 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
>>   /* security/lsm_syscalls.c */
>>   COND_SYSCALL(lsm_get_self_attr);
>>   COND_SYSCALL(lsm_set_self_attr);
>> +COND_SYSCALL(lsm_list_modules);
>>     /* security/keys/keyctl.c */
>>   COND_SYSCALL(add_key);
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index ee3881159241..f03f2d17ab49 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int,
>> attr, struct lsm_ctx __user *,
>>   {
>>       return security_getselfattr(attr, ctx, size, flags);
>>   }
>> +
>> +/**
>> + * sys_lsm_list_modules - Return a list of the active security modules
>> + * @ids: the LSM module ids
>> + * @size: pointer to size of @ids, updated on return
>> + * @flags: reserved for future use, must be zero
>> + *
>> + * Returns a list of the active LSM ids. On success this function
>> + * returns the number of @ids array elements. This value may be zero
>> + * if there are no LSMs active. If @size is insufficient to contain
>> + * the return data -E2BIG is returned and @size is set to the minimum
>> + * required size. In all other cases a negative value indicating the
>> + * error is returned.
>> + */
>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user
>> *, size,
>
> As explained in patch 4/12, it would be more flexible to return a list
> of:
>
> struct lsm_entry {
>     __u64 id;
>     __u64 flags;
> };

Any additional information should be obtained using lsm_get_self_attr().
If there's a "flag" value if should be provided as a LSM_FLAG there.

>
>
>> +        u32, flags)
>> +{
>> +    size_t total_size = lsm_active_cnt * sizeof(*ids);
>> +    size_t usize;
>> +    int i;
>> +
>> +    if (flags)
>> +        return -EINVAL;
>> +
>> +    if (get_user(usize, size))
>> +        return -EFAULT;
>> +
>> +    if (put_user(total_size, size) != 0)
>> +        return -EFAULT;
>> +
>> +    if (usize < total_size)
>> +        return -E2BIG;
>> +
>> +    for (i = 0; i < lsm_active_cnt; i++)
>> +        if (put_user(lsm_idlist[i]->id, ids++))
>
> What about putting the returned fixed-size list on the stack and only
> call copy_to_user() once?

There are objections to using the stack, doing an allocation, and doing
multiple put_user() calls. I just picked one. There's usually only going
to be one call, so this is the best in most cases.

>
>
>> +            return -EFAULT;
>> +
>> +    return lsm_active_cnt;
>> +}
