Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7E754358
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjGNTml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjGNTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:42:37 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09F2D65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689363754; bh=l0rGytDiGCRVCZbAAcmCxtglkZvJz8nQZGXfKcFzPlg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U6rgyYNE4Y94w25EoMec7PvihKyVqC5k79VL3VHYbtDLDBlTFzzIyZrN94VVp726nRKcUE31EHT4z1VOqgfINtoZ67rOlBa5PJ/vzvqlNz7ieGz7E0tIY4woT0p+KAjcq3qQR/IQJEUp+ImF0vpFVz3CxHPQ4gqfy1ICkYNBIK9buW6iINF2eOstuCHk/i2OPyqv0gpMWnc1K0mEVDCNTHyXQXme0paLApqbrpGogP8fSX9EkIV7Iv+ti8lbqrR7VU2H48EnatPqt10BR0Q6T7KpUOcXw5GPJiPRANrEwThvymkzZoEoe0HQ2IgErimr5zeNoH8IKe3UNhgXvUCg9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689363754; bh=6t4cF07m9PwGaN4ZvSvhXzGOd19OtMk7MYP78TWpkCJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Hq3IDWopjWCB6c4m7MSdAgQkkmDP6U0Ny3pLqMorFkWN/FLV8XQha/rw3f7HSUUDfOoo1Gwh5mPWUPAYNlkoChUVG4BRh+uolzf2rEirigykJwn9TgIbh+NY8X64byc+vKuhUuAHKBq3XbGonK54aPstNmEQqI4sextjOdfHn0x3bC6VQg52+3BB35yz4UQSthomixNdY7eFsxzHR68JLUnjYEw41CxZbyw2SySuKm0o6VvqciDqop0bBlV09wRIX014I4v5JfyB2/6kqXlwonk9TwqVYThSu+8rxTQjHH8oxyWHHHaJG6L6PIAuOpQPtZmmjBjTkHwoBweozSElxQ==
X-YMail-OSG: yWjPgg0VM1n_byWVKQACOimMjXX_WbKl600Xtu0fGSrkuyHQ7I2QAHSlFajLT78
 uM6.no0F.WF.bqOLqgee1rnKBggIIvL0gtTaU3..fBryPB4zJwyfVAGm4ikRJYD.dr1Wz.XZQtoN
 ozeH2U5RBHReys6MRREe3V.4VaYIbxLlBL5f9Us51EVgJIK3cump36_eEmkNyyWIKHYtfxqk_q6O
 FPSlQznZKu9DGTt68hgpD2SwLUPfn5u8qIxanOCzN9nm8VlDFssa6oMzjUJaWUvBJq.yd8x.rDVn
 jAmiye_EF10om8RYhj0Y8189eFlp7spcBLE4jZtA9KCKq3snLeWA1Pe1nLLBvyXuqRvT1HGQD2AZ
 SLuSxzl5XT7Ku2LnMP.nSFrzGJXQ6QaS0OqLmXJoZOTQ0asGJIXzdLsrfHFQA6bpUU4dGCzesQcW
 6Gu.Cfn_zTTa6Zic0.H9.LSWkeQS7AI8ueSOtaqscoZ1Kb.fQLoV_acpGL7QVBcB64Hde2ln0JXb
 PmEmq4flkQn_V6atz.TYnJ_yd4DvI4U0UKjlblqRhrDUgQtgy..zIC3qN16mS4flDdtErT4OAg8A
 ApTQNER.SNDkdD72ctgc0jN76OcpBmSjDcm2o9J39qnU_nWdmQZ4T0Kxv3U3Ihx06rHo6LB2dpfo
 pa60PX1RDa7Ej2lNqsvmIz9qv4lmnQOsiww74rJcvCprw8xrgL.ulILNYC9qt4Kyu0foU4d_IOvn
 gZ5e0XLX6sQ7KQ4vgxuZYZb6enEwMG69Xt.bOs57vut4Qc0zpO_QdOvaSWXEVpgnrTd0DDaYEUkm
 kyb9yDvxFC1ygfyYxUZsGg6fx8BcertJTnVvnzza79WWqOweaaZrv8aziKSclc.GEJ_.3I2I5f0P
 MoVoaBgmzzQ1Pmp_rjyYdnJYdmAKsV.v7KU5IOQDJEV6Fi3dECV3buNZ0UgsmI4TTok3MDwqp0wT
 9NohgyI8CK_bSRjgMFD1Z8eV9iC2Sj6cCBc0ft3kvQipY1nOwIYi7AZLX.E0zlNJ1l0fjhc3Ku0K
 NMcqX0xlmL4zDr5heHwzWKTy2q_K_s2z87m5Hf7ZmQk_DrwyrLJ1L1fkKSHpgWXl23EYyd1CKItA
 MybLTJkzDTCEmRoE3cDzeFLSFv1JwxmgwP1LEHjzMjYQrwYFoC8O2JjG1mpo4FifOvP4l5TKMMjH
 35MJqc1kbIOo4WienEYktMWHoc1DiJN8TEex8ZwrA3S4QqmNluNnsAbyVEBzRby1g.0KLD7c1bjV
 QHfFJBfPJhpYZybZhX26Y_hIde5JBE6l0rMhJHgcFuHLOS08xJzSROSRVOav8q1Xgoe6N3FGIKGm
 vl36jr38H9iADK6A.2df63S_jnUDWaXfBxox6piaYVox_.SDAe7yyHuVLskHYK2qGU_znpEElP3u
 DIeVjWVqCajlkcvPNc.o1bEyv_MD1.Kecszg99Os3fl3DRNPvPDc5qlo9qF7Qv6YqnoQVhYUbPrk
 2QYYS6_wCopne9NZOHmhxX8NsVYiRf8VQaA86T02.fMotvpDPc7CM.OwzbNCQe43HNhfQUZX3QIx
 c9TUnOUpxEyVzLKXf0XfcVPCfOBztwLFkUNRvYq61Q09onWzxgqT7dW7B3s6T8GzycxjE9GgHbfQ
 Nc03NSVae88L7FQCVi5pect2lwiDDRn1nSt4tUGo7WJCWvOYmS9Hs2rxTK40oi1chZxaMLohKHOq
 zIkmKdpBne8BU0ZyN_65RTmHxVNM4_JeKGjVwN.dBIAnrfn68PUld5EJsPPu9R7NA.jwG3de6Kw6
 aXMW1SyuCnDNdG9MGPcgGFyMd4LLt_9bmJJ8QKn.EG5JLtXLpBie0h39eiAJknC6Q6Ms7ySS.2Fv
 ik_kgQOW2gbbuEIAqSATBPG8VLbkYVAWNBYtrzE9YtpIGTrs09HvVY0QXMLBSC5YjYbOm5Mcr0Jl
 J2XKDjKG_fdy2W5CAogOcjW4NdcXZvpHt29AF02rq7m61LrhsTXVGV4FyXr283vF8laH8yItn25F
 oKq5hxaS6N.o0CrmiMMyntnWVmuOtxc1MOAf9sQWEUqeX1sck8hNJ7oCFHS5PLDWybeYPFGp3zYR
 04ZqhBJW58UsbS6xEKWoJb.qvZ.2ir3IaEcCmHcv2p0A.0g2ay3Fq_OsRvc9DYEyb7CYFBRHPyJk
 3HX7rPXGTXgBsQ7YaNArC0e6MOP98kCQ7QVvbadLVzl9WQKCeOxutlhbrHtkuDKxOpaPoTMqC4j6
 n6Hsbp9.TrlcjEAo78v0T25femUxfl65CDywAsj8lOcDJLhjDB6N2sQQUhc6Nrb2UCOX0c5jRFDO
 l3v8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d538069e-f644-445a-aba7-f2d4eab3dd01
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Jul 2023 19:42:34 +0000
Received: by hermes--production-bf1-5d96b4b9f-chf5g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 242c6527f086c2338252c12f27d389d8;
          Fri, 14 Jul 2023 19:42:31 +0000 (UTC)
Message-ID: <b711f8b4-f624-bb2b-1caf-90c674245135@schaufler-ca.com>
Date:   Fri, 14 Jul 2023 12:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 02/11] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-3-casey@schaufler-ca.com>
 <9b09c571-9288-73e1-18c5-9023b909a5d9@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9b09c571-9288-73e1-18c5-9023b909a5d9@digikod.net>
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

On 7/11/2023 8:35 AM, Mickaël Salaün wrote:
>
> On 29/06/2023 21:55, Casey Schaufler wrote:
>> As LSMs are registered add their lsm_id pointers to a table.
>> This will be used later for attribute reporting.
>>
>> Determine the number of possible security modules based on
>> their respective CONFIG options. This allows the number to be
>> known at build time. This allows data structures and tables
>> to use the constant.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> ---
>>   include/linux/security.h |  2 ++
>>   security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index e2734e9e44d5..569b1d8ab002 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -138,6 +138,8 @@ enum lockdown_reason {
>>   };
>>     extern const char *const
>> lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>> +extern u32 lsm_active_cnt;
>> +extern struct lsm_id *lsm_idlist[];
>
> extern const struct lsm_id *lsm_idlist[];
>
>>     /* These functions are in security/commoncap.c */
>>   extern int cap_capable(const struct cred *cred, struct
>> user_namespace *ns,
>> diff --git a/security/security.c b/security/security.c
>> index e56714ef045a..5a699e47478b 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -36,6 +36,25 @@
>>   /* How many LSMs were built into the kernel? */
>>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>>   +/*
>> + * How many LSMs are built into the kernel as determined at
>> + * build time. Used to determine fixed array sizes.
>> + * The capability module is accounted for by CONFIG_SECURITY
>> + */
>> +#define LSM_CONFIG_COUNT ( \
>> +    (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>> +    (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>> +
>>   /*
>>    * These are descriptions of the reasons that can be passed to the
>>    * security_locked_down() LSM hook. Placing this array here allows
>> @@ -245,6 +264,12 @@ static void __init initialize_lsm(struct
>> lsm_info *lsm)
>>       }
>>   }
>>   +/*
>> + * Current index to use while initializing the lsm id list.
>> + */
>> +u32 lsm_active_cnt __ro_after_init;
>> +struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;
>
> const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;
>
>
>> +
>>   /* Populate ordered LSMs list from comma-separated LSM name list. */
>>   static void __init ordered_lsm_parse(const char *order, const char
>> *origin)
>>   {
>> @@ -521,6 +546,18 @@ void __init security_add_hooks(struct
>> security_hook_list *hooks, int count,
>>   {
>>       int i;
>>   +    /*
>> +     * A security module may call security_add_hooks() more
>> +     * than once during initialization, and LSM initialization
>> +     * is serialized. Landlock is one such case.
>> +     * Look at the previous entry, if there is one, for duplication.
>> +     */
>> +    if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] !=
>> lsmid) {
>
> Isn't it possible to have interleaved security_add_hooks() calls?

The initialization is serial and interleaving isn't possible.

>
>
>> +        if (lsm_active_cnt >= LSM_CONFIG_COUNT)
>> +            panic("%s Too many LSMs registered.\n", __func__);
>
> I'm not sure we should panic, but from a security point of view it is
> critical enough…

It's possible this should be a BUG() instance, but the panic() more
closely resembles what's nearby in the code.

>
>
>> +        lsm_idlist[lsm_active_cnt++] = lsmid;
>> +    }
>> +
>>       for (i = 0; i < count; i++) {
>>           hooks[i].lsmid = lsmid;
>>           hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
