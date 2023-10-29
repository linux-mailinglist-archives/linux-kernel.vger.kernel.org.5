Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D301E7DAD97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjJ2SAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2SAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:00:51 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD9B7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698602447; bh=d9TbxUpx26EKnkWpNYU/rdp9A4peNoGOp6uq/4KmJoY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jkUt75lmZk1ZCsdVBDVQt1JJXRTtRPievBYpesZoZA7wod2QsYAGMoFoF+gC9BzV4JHAaxFuwcWMw23+cB633q8hz41fgEQX0U2eKXiDZzC/Blru6Wa/HEw9Mh7sBvMn4/GaYtHBjTlSCLoje48zun+8roiBH2QLxtuHocobCPWwoI0W1kfqxgm6f325k+mjsYLFfySWOj4pG/+W1bIkBlfnxgWjFxOeci/9tMUsaw9Vyb8r0hxXGmZAcuxVifE8ojEARlEvtP7UdWVWNPHqh7EfI+iQPNUrzDytYF59a7wsZ+d+45XlOlOAAk9Lx7390qQ0crtaOHH5NwdY0v5PKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698602447; bh=gRD5xWM2KLUvbiBLsA//OlR7z1c2LkANoul+V9HJl7v=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=efD1HLkJ1OtnpO/6//YhudZYCHds4QbEcvohVgeCBjKI2xJp8mvhgJ8dUJWtm3cu0QB5Osi93Mi17F8UvIIL9li6uWgLtwySc5Ccio11b3C9AIrdZsWKx51Ur/tGGwEIFUdzMLyxc8SrwjMnAGV/vc0C+YEI/xQMye+eO7qyvdEOcYblTYed/q23xiLJgJEaQir7IOmQ0g99pyTNgQypU92RB9DGs5lEQbn4jeRpLlJT1yWkthSDUPJfUXnVWRDyoDaGbTjzG2myupsJtoc5W5tpaW46Zjep8vhzTL0UFj3SxSQaK+2OPSntOQd15rmf11L7r59eOPcZqnLRp1FoKw==
X-YMail-OSG: gwz5J74VM1n.j5UUXNIYGJ6U0m0vGOybAZdHn2ig.JTpBIUwSuuVdAQXCgdccgc
 2fkDtl4Ioo7GiW15zn4R7gXuK5SIez1g.bzXIigeGiI2PD3GCTworsHViRdYFX.ycrLUmP9fZJSG
 p0OY0Ak7HwK8x6KU_1BNnoXlRu7n5mtihw2RqU0IAi0PfOpsY07rRKmqvdvON.Q5srUH8.hDRkpm
 tQ.nMbJ8p9MEmFy14c4VK4zY5l7QD2tNh1SD3FcamU8nSHwqU3GR7debTjoE55w2xUZ06mbKvhCF
 skn2CQoEfbTllf8yeN30IdE3DAp32RJ5gvCYnpR01D5eSEspiyJ_lFRkoycBls4K3PlA70Uwb8i0
 3Ot2B3GBAwumTUJpUl1M3PxBpRPvNCtMjx3Oi3O0nDAX4LaYEaAE9xVfE0CaCz0ZXXzDoXvdK7OI
 eEQ6XxSJ6m8i5xBPlKakGAW7VMmoXUlgxL0KwOrKrTQFLZWLSPOK_mr9Nojeox2PXzCScCrrkZ01
 C3K0KNyoWoHHTs7zIYz9LfbqVIOrUWyR0xknax42ka7SQKE_is7kga6kJ2bNrO4RLVtxtt7GIFtv
 EaNlZA50wAzOQvqiycAS4uzZs2tGBxEDBi76y7pbLPdjaDAKFfyr4OoZuquL5TDDIM6grwk0mxlL
 E.2pqe2enX4SDBR2pz1Wi5pFXzkfUxj5k5IigTRERkJY3DhBh5VBLp8yuf2n1CYa.0gnNtucjRzM
 fdIhF42kdwY3BcGnHsx0gm25o0iYFwgPIyS5sj9y4wXHygPAgmdkE3sW13v8KX7rYP7cu6uqVIif
 hVqU.D7GKphAGuqYRWZ9VgdVB2xGEFLhera7WlJ_u6CBM9d6RexkIl6Br3EF81IJy0iO8qZNJF_k
 BhgGWHj2gnKZ7WBohAL8unFtpkdhZpFfyzAAVHH6Ie0kR9JO6EbN49sK850KeFZDzYpFkHGSejn6
 _k3J0a0ni3DaSsqRB2MmMVaTzR2Z9fdX6MH61f6of3SkUUBveN0yMn31jtWU._80FlkXA_tOOGLn
 74yKFc_TYPGO6ZvB6LbpvYHEKiX7e2vIachMdJOMIOO_JBENcnx1W4ozSbuKlzV_UhZRdGQUy3eZ
 JHQaTakjw_R7MZHu9XPaVORMqbM5MTEbWG15MMG2WOXhtHdPRdaEikS382kV1dQX0qPD2h8HMKr3
 sQW4r34h089yijw.UsyGiwthZTseeSlWUJixGHv53qyVEl29R0IcjbPZsaUoCOOtYSQKDc4BqQze
 8AUlxPMR3C8I868OrGsoko0IzxuJ49quLwww6tUWQeMNo7GOmaqCZwCURtrB2XeBzgFkDTzZCv5d
 sY_EZZAfUIdCPmm4MqC8Ix5GNxA5miHNGsiaKjnpOmhdlOkF2arVfQufWaMWlhJjLwCaNG47ZMn6
 DSitOMvQrv3R8Ddm3KRjPTNsYpJnPMadDSGsDJFXUBwBiEbVpRhypSPtMf4JonGMdfpuFM2Vmush
 vI7YsFstI5i1mB4TKa8g9c2AVhYpDYtgXABeDxyFJczlSix8KT.oxkas1jwXHorSPy_a2gqALtxA
 giwccNTz_JDOR4aqZcQxkhFf.opTLuv5Swx4w9CH5nqYYaMIXd8rCWttQ60BIhzQ2N20Vt00VvMO
 BJNyhZVTEfEnPgmnMiwnDOCBIHxbS9FmtzL1w4KmdWWGGsY1VwZksZ4aO93RopFv0PruF29yCOkX
 _qhAm2REX8IJQgefYYUiPDWFPo0QraYw4_ec4RCK89aCV5C5BCp0.Xy2VSdLkZMa9NORcQz9GfFb
 jq4qeRV1wBb7HFGd0HkXeJ07B4JHHWkjEC1o5ZnUQa2rTFItIQsxDMECMf7EPKyjrALaarE.HcKg
 .zMuL9BTKfkUzK7j_7xhL2ZfObA2yXNHvr.Qi4.p6cMyRYFlJqlmhb8xOMuGR.hr.LnBH9EgUsXa
 XosjQIowA1MvtB__1j2aFf.VzRwoWCxJ9e.GWW4vcfrN8_i.W_iXwCJkfLXC5iq0pG3_d_4wWnhv
 hTIWUddDuXPM3j01Sd4bjXJ8vMRxk1vU2LMc.JAzBqbxa7iqQA009TCb8NCelphYpcsp_F9grnKb
 C6l8P4sGVEcqAJzeEjqWmUVQpukuJxn_tnI59bQpN0ZDl6IZ2JD4i_pSdbAHzXGyL60GA3YjCHsD
 57HNiQf2vaVA7dSN1PWvWKwsAggDoYHDhRYICFhgz5o_4GZSyeeMdOnTSZOKClMqbXpBEkXWr6d7
 d0xV7k8aVYLrWyT1j89pfQGQ1iNBCo_Cn9..khNChM7fH62bxZq7Wf3qinHjTUAHptd4EVN0jzMw
 .0yE0
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 01317310-ef72-4b83-a9c9-6d44f2736bb1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sun, 29 Oct 2023 18:00:47 +0000
Received: by hermes--production-gq1-59b5df67b6-gs8xt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6cf590a92aba0e42ec70916e12a6deca;
          Sun, 29 Oct 2023 18:00:41 +0000 (UTC)
Message-ID: <f1608a96-e18d-45a8-84c9-8195a9bd9458@schaufler-ca.com>
Date:   Sun, 29 Oct 2023 11:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <e391877d-cd10-3c6d-1f57-0aaa32846a8e@I-love.SAKURA.ne.jp>
 <30d1110a-7583-4fa1-85c8-d6ce362f5ae2@schaufler-ca.com>
 <2fb1a8cd-88d0-40f0-b3d8-cfa8b71e7dd9@I-love.SAKURA.ne.jp>
 <29fe1e5b-4bf3-4bb3-b8de-fbd8dfc25be3@schaufler-ca.com>
 <c35322f3-3f89-40d2-a5fb-7226fb93d202@I-love.SAKURA.ne.jp>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c35322f3-3f89-40d2-a5fb-7226fb93d202@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21890 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2023 3:57 AM, Tetsuo Handa wrote:
> On 2023/10/21 23:11, Casey Schaufler wrote:
>>> If the system call returning LSM ID value for SELinux but does not tell
>>> the caller of that system call whether a specific action might be permitted,
>>> what information does LSM ID value tell?
>> It tells the caller that the LSM is active on the system. That's it.
>> Just like reading /sys/kernel/security/lsm.
> Then, the
>
>   The calling application can use this list determine what LSM
>   specific actions it might take. That might include choosing an
>   output format, determining required privilege or bypassing
>   security module specific behavior.
>
> part should be removed from the description. Instead, the description should
> emphasis that the numeric LSM ID values are there in order to allow
> identifying what LSM modules are active without interpreting string LSM names
> in /sys/kernel/security/lsm .

No, I stand by the description as written.

>>> What does "choosing an output format", "determining required privilege",
>>> "bypassing security module specific behavior" mean? How can they choose
>>> meaningful output format, determine appropriate privilege, bypass security
>>> module specific behavior (if the only information the caller can know from
>>> the LSM ID value were what LSMs are enabled) ?
>> If Smack and SELinux not enabled on the system there is no point in
>> setting up a netlabel configuration, for example.
> I know nothing about netlabel. But can userspace make such assumption from
> this granularity? For example, if TOMOYO and AppArmor start supporting
> netlabel configuration, your assumption
>
>   If Smack and SELinux not enabled on the system there is no point in
>   setting up a netlabel configuration
>
> becomes no longer true.

You are correct. If I thought there was the remotest possibility
of that, I wouldn't have used it as an example.

If Smack isn't enabled there's no point in running the Smack testsuite.
If SELinux isn't enabled there's no point in running the SELinux testsuite.
If SELinux isn't enabled there's no reason to invoke SELinux userspace features.

>  It is also possible that a new LSM implementation
> obtains an LSM ID for that LSM, and starts supporting netlabel configuration
> some timer later. I don't know if we come to the point where we can enable
> SELinux and Smack at the same time. But when it becomes possible to enable
> SELinux and Smack at the same time, the userspace might have already written
> code based on current situation that netlabel configuration are exclusive. Then,
> someday starting to return both LSM ID for SELinux and LSM ID for Smack might
> confuse userspace.

Believe me, that's way down on the list of userspace issues with using Smack and
SELinux together in a meaningful way.

>
> Thus, it might be safe to determine what LSMs are active from the LSM ID values
> returned from the system call. But it is not safe to assume what functionality
> is active (e.g. netlabel configuration is interpreted) from the LSM ID values
> returned from the system call.

That is correct.

> If you want to allow userspace to make such assumption using the system call,
> the granularity the system call returns needs to be what access control mechanism
> (not only LSM modules but also eBPF-based access control mechanisms) hooks which
> LSM hooks. More information than interpreting string LSM names in 
> /sys/kernel/security/lsm will be needed.

That's already true. You have to understand all sorts of factors, like SELinux policy,
Smack rule sets and AppArmor policy definitions. Then there's netfilter configuration.


>>>> I wish we could stop people from saying "BPF-based LSM". BPF is the LSM. The
>>>> eBPF programs that implement a "policy" are NOT a LSM. There needs to be a
>>>> name for that, but LSM  is  not  it.
>>> My understanding is that "BPF is not an LSM module but infrastructure for using
>>> LSM hooks".
>> As BPF is implemented as a LSM I suggest your statement is incorrect.
> Enumerating only LSM modules are not useful. "ID for access control mechanisms
> that can be controlled via LSM hooks" will be needed.

The BPF program set is no different from the SELinux policy in this regard.
It's completely user defined, and out of the kernel's control. I seriously
doubt that you want an ID for "SELinux reference policy 4.3.2 with Infiniband"



>>> The patch description lacks relationship between LSM ID value and data.
>>> In other words, why LSM ID values are needed (and are useful for doing what).
>>> If the only information the caller can know from the LSM ID value were
>>> what LSMs are enabled (i.e. the content of /sys/kernel/security/lsm ), why
>>> bother to use LSM ID values? (Yes, integer comparison is faster than string
>>> comparison. But that is not enough justification for not allowing out-of-tree
>>> LSMs and eBPF-based access control mechanisms to have stable LSM ID values.)
>>>
> I conclude that LSM ID values are pointless and are NOT needed.

OK.

