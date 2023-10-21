Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CB7D1D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJUOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjJUOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:11:55 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35569D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697897511; bh=rG9FKnVoLG26ohHY0BM3wyyfU3oTLw+5BLolUdYjy2A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jS0PaQZcF0F6olJoKC2c9G0UZurxZftwVjMY3qZ34UyacArjX5nWGzomJn7/5CVcqGmKZ2VMtbju9tjM918yb+O5pGxKDgjZZTelfCzkRQ2AjFTC7LZUX2pzi0cTxGIhZw6I+d4qhlrn/to5c8VCqXH0SmTF/yhhWHuzlSJ9y/U61FOAcHVOrM95WSa2ywYN1PQqFV809N2EZM9hGSLEC0uXrywmuzoCHj2E3VR/CToSJPHE9XMhvYe6jM/g3+Rn1DSMljY6OD5zqYc57GP6s9APUW9Bln7MZAsn4ConFT9dLj5BbBbnvXQZd2nGeWEJNBF4ax8YWygzSECdvI2AQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697897511; bh=aiXpFsxA+HQUXrIgQeIfIEk7h80j7gdlf8kzjD8Exds=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BOqfDFSI56Deaxe6rlWu8GXO4isfzKC4ABo69udMTUPeY8IMKJfvLP25jEBg7jWekUC3yTWD4ELJU7qpgBKZupIMy+6fPPK1FjKjWdub1LtRPL885i29FykvV+eRwgiA0G/bzqGq93+vSQza5tbBhki+5j1/XciLYdY0M/J+JRqaA5KT2CfZpCy361F02cN6HpTkKvRGtomnK0sqZO3dWaleCjKYbWBZFQaJKpNiWNJ3FmbMpW4Qi2+zAdL08HfSzYqIpqCddUaz0QoG5gTN/WRxVXFFWIYn7JNcklZu2SL9NYTRwYksN6DfnjGieENaCg6u102oQZEe6i/c5CeyiA==
X-YMail-OSG: r.9TkjgVM1ksrFuXvWxgDq4qzd0PctvTNun4OVxaiW0hwMRU9S7MBeEjxjo_LIm
 VhpN6Zqor2GYAH8RthxKYRGD6gs7VkHfIBi94I9UZUTGM11y0ON7bt6GnxNokwq5K_XmocG1cktN
 Cgm_3Q9pyqe2BkqjBxNFhs_UR_tid7eorvrZj8ihILuM7Za5WW9g_nQAlrPu5uPvldJQcBHtLUSJ
 lS2Rd6SbOYXRwjhWMBZZ42Owug_iUUDbwSkwV1CtY6AJEK8Uy4PsamlH_OvwiemfsVW9mWDJBj5n
 fjqGRNMZ0h47YrlA0nD_IJLgpBw.QQHMwyu319zmC8AO_37apHJfmaxKjIxjQmKMGvdklftNi3vS
 8OC7ZB3_Xnhk7EY_zVCGmz_ocEP6hxu2Kh44YWP1kqhlyG_YmYClY4DQmnDkQEn1tXUPa9Da1Pog
 8o1lVFmsdf_IbQ3LLEKXTzVLXpsUbn6ZVOKHnAY0Y.EKAdVPPpIpVE_.EZzGGHAgb3i6EGrMB.78
 QGUjgq2ftoMJdShzNSRelP3j8EoGi1opf3yvHYjaVJAeJhXH00LvhOMpaf.uPIESJ9ZgIK0ZcY6b
 oXljEqxs8n5XpHqQ5wcSRLkxf9FDlp2_yMfsk8ohy1h8O3.ARpVMDbIerd1EkriVmrDRJMiMTCnl
 ZlvIuhncfUK2AZbDU8IrcmjZRHQtOczOrYUzjJPY_FwbQXVuTxpmCEtb_qpEi1vrK.YbXMV_x1mR
 0RECV.u4A8RbQEMW2RACRfhsVpZTQ0I2s21y4s39y4pQ86J7jH8zUoNcSLZA_t_XUJnWnT_o4k.w
 ZJdMdsc2OY5dVAAyYcjYTXQBZFuZF_opDM_L44pz5hIkVRbBfKJeHtb7BPCH8xIFFOOIGvAWFkQI
 YqOrfCOP7tvyTGWEMzkXQX6PBpGEXNs0tbDXKOYZ0M7YMyAJ3aHSXsutpW08dQpoiHvMLmP9i_w5
 QKDDKJjaluT3GWubQ2iHtaX8e426b06ical_6Yj2obRcZy3NiPKq0SyLkHQY_ZgiyXBViiipGMbK
 .FAfyCE2EvJIhcm32MptVlIflBNQdxoXVsMk808iKQX2ACq298qbUHopv_5kelBXnaturLr6nThl
 Ro7EDVH27MjFxquhnHe01CJisQi6vYEQLUDVCAYLKGNy62oS6C3yVKzHWPPjgwo5FBB3mk4KUdKF
 AReClvWkwyyo77zZiFFTy.NIqpNiG_kIgPsh1cklgCx.CqbADmWfB4YzrcS9Zfv3wkHLP_isbT5w
 lcrxr3r6kUogaOySdV2TQU0wjRF_X1m4ezdF9v746fzqg1gpvUFIt.0AtmWtCa594FCP7uREGJ9R
 tCY_7Wz4u1SPYY6WgS8FU_AnfaG.QDW_Kk5o_1XE0um4a8kVbNWepwmRXIVnTYn4rU1yhl9hU95N
 _vmFcj9wKFhSzVodyBK8hvbUQqGk07ZXpmmgeifFele1sTltj4KnHo4dJO3AVmL.oVPMcNbFTpP4
 ZG4BQ0i9MvJivyztSw.HhPrZfLjdusbuUM79vNFVZtmTKOofDARZzsFh_TcGyJeYOQlFTgl.V8wG
 flquV8W8qD0ozj5VjvJXSk3rpkaEc7VvXqqFUTYCo8jSxbnW2yjxC_q6EQqW2vKb.yxTS_HcJylu
 FsCpyBROEzJ5ef5Eej3818yiW9TcB0j3Fy6jTHVj2uFy75qNEiNy8MAyPEs2WzyERVCUxTDmEi5Y
 tU9WIF.9HekgCRdxScoQYz_AzX1U2Cb6PcQyDmXZ.0hb3qHDF9hbDs3UAG0tACVTZCo0X6GHCay0
 oljUvcp29O.1mxPj68TIY09tpPI4sep9_VKgrLwZdn83Nj7cHV_zytKwLbxWxxD0WE.DnQj_agf_
 nIShO1tk4XD0NKISOksGznPIihqpn.JTvCRneXomV3CRYRc9ImRP0Mz2_horQ94xe0osj8aVcw8r
 GD3DTDco7Em2z8RakjjqA_mR1fjGQcSdJJApNTM9y9SRugZxTE8OD8p19bk263xRU8lKfJdcmyd.
 W4Y_YN04230upYYXcrT5wRi8fd1wCtM5fK50EXLuCQReLmpTesO7wErBj8qlyRIlVIeuiKmpJnVh
 HxU2v6979m569wEoruN80TQCB2XX8l2AeCOID.UsP9JK6OqdqJKXaoW6sCRczxCRZSATMn2cETOC
 63xGc2wmtoptgE9WuYCZRt9Vhhj_kS7uvpLzQDqsRuZVjVsHxdOsc6TGFDrAq.gTc5la56FZXmaA
 Xqc6L97JYrYo9IzEtee6d50wo_lZHnE48uvUvJuyLaEl6jPMzeYQt1fBTEvoRoKSkGbn1YQKOyBX
 fxCwI48sQhQn.Gs_dGQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0b63f9ac-f7f9-4399-a9c5-1894b319959c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Oct 2023 14:11:51 +0000
Received: by hermes--production-ne1-68668bc7f7-bm5xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 392709123bffea66b938fdfa11ba752a;
          Sat, 21 Oct 2023 14:11:50 +0000 (UTC)
Message-ID: <29fe1e5b-4bf3-4bb3-b8de-fbd8dfc25be3@schaufler-ca.com>
Date:   Sat, 21 Oct 2023 07:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2fb1a8cd-88d0-40f0-b3d8-cfa8b71e7dd9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 5:20 AM, Tetsuo Handa wrote:
> On 2023/10/21 4:52, Casey Schaufler wrote:
>> On 10/5/2023 5:58 AM, Tetsuo Handa wrote:
>>> On 2023/09/13 5:56, Casey Schaufler wrote:
>>>> Create a struct lsm_id to contain identifying information about Linux
>>>> Security Modules (LSMs). At inception this contains the name of the
>>>> module and an identifier associated with the security module.  Change
>>>> the security_add_hooks() interface to use this structure.  Change the
>>>> individual modules to maintain their own struct lsm_id and pass it to
>>>> security_add_hooks().
>>> I came to worry about what purpose does the LSM ID value (or more precisely,
>>> "struct lsm_id") is used for. If the LSM ID value is used for only switch
>>> {reading,writing} /proc/self/attr/ of specific LSM module's information, only
>>> LSM modules that use /proc/self/attr/ will need the LSM ID value.
>>>
>>> But this series uses "struct lsm_id" as one of arguments for security_add_hooks(),
>>> and might be reused for different purposes.
>>>
>>> Then, BPF-based LSMs (which are not considered as in-tree LSM modules, for
>>> only BPF hook is considered as in-tree LSM module) might receive unfavorable
>>> treatment than non BPF-based LSMs? 
>>>
>>> [PATCH v15 05/11] says
>>>
>>>   Create a system call to report the list of Linux Security Modules
>>>   that are active on the system. The list is provided as an array
>>>   of LSM ID numbers.
>>>   
>>>   The calling application can use this list determine what LSM
>>>   specific actions it might take. That might include choosing an
>>>   output format, determining required privilege or bypassing
>>>   security module specific behavior.
>>>
>>> but, at least, name of BPF-based LSMs won't be shown up in lsm_list_modules()
>>> compared to non BPF-based LSMs? Then, the calling application can't use this
>>> list determine what BPF-based LSM specific actions it might take?
>> That is correct. Just as knowing that your system is using SELinux won't
>> tell you whether a specific action might be permitted because that's driven
>> by the loaded policy, so too knowing that your system is using BPF won't
>> tell you whether a specific action might be permitted because that's driven
>> by the eBPF programs in place.
> If the system call returning LSM ID value for SELinux but does not tell
> the caller of that system call whether a specific action might be permitted,
> what information does LSM ID value tell?

It tells the caller that the LSM is active on the system. That's it.
Just like reading /sys/kernel/security/lsm.

>
> The patch description lacks relationship between LSM ID value and data.
> In other words, why LSM ID values are needed (and are useful for doing what).
> If the only information the caller can know from the LSM ID value were
> what LSMs are enabled (i.e. the content of /sys/kernel/security/lsm ), why
> bother to use LSM ID values? (Yes, integer comparison is faster than string
> comparison. But that is not enough justification for not allowing out-of-tree
> LSMs and eBPF-based access control mechanisms to have stable LSM ID values.)
>
> What does "choosing an output format", "determining required privilege",
> "bypassing security module specific behavior" mean? How can they choose
> meaningful output format, determine appropriate privilege, bypass security
> module specific behavior (if the only information the caller can know from
> the LSM ID value were what LSMs are enabled) ?

If Smack and SELinux not enabled on the system there is no point in
setting up a netlabel configuration, for example.

>> I wish we could stop people from saying "BPF-based LSM". BPF is the LSM. The
>> eBPF programs that implement a "policy" are NOT a LSM. There needs to be a
>> name for that, but LSM  is  not  it.
> My understanding is that "BPF is not an LSM module but infrastructure for using
> LSM hooks".

As BPF is implemented as a LSM I suggest your statement is incorrect.

> Say, an access control implementation consists of two parts; "code" and "data".
> The "code" is written by developers and is determined at compile time and is
> interpreted by CPU, and the "data" is written by administrators and is interpreted
> by "code". The "data" part can be either built-in (determined at compile time) or
> loadable (configurable at run-time).
>
> eBPF-based access control implementations (which can be loaded via bpf() system
> call after boot) consists of "code" and "data". BPF will remain no-op unless
> eBPF-based access control implementations are loaded via bpf() system call.
> Thus, I believe that an eBPF-based access control implementation should be
> considered as an LSM module (like SELinux etc.)

And I say you're wrong. Your arguments are gibberish.

https://www.youtube.com/watch?v=-7cUnID7vFs

