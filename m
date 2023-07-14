Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868ED7544C0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGNWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGNWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:00:09 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE062127
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689372003; bh=M/zSqBc+f2NgBtj08vVfRiRgdch27jlkBvWrYqmSmYg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QxNUS0cohkH5hMc34td1ZlTxFRaJuoHHSinmFYaL1RpfVuYMtqZLNM1AC3FnCK0PR28NPkIeIA3KTDECUxKcZvW5yiIXd1vtbrLo/+jH5F/0qSLPZUmB9L763vKSLRE9pqPwgFXjsq2YteW2kG/Ke1QTx5Anjt0tMyevpoadPNEDKvMdE3dvHQTameF259e1lXtL/aind/4At0qNYbms8IOaLAyddBDu4dXn0EfvMwOVObacsktknrFC1Lxmh7io0Wsh0xQZ0gg4+rtQd5/sC12m5w7OvhK3z5B28690b79K7GsOzBZbxNCIa5mutQPVmlvoP6fOzHBPur4ZJ8iLZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689372003; bh=olkEOQXxi8F+yeVggbcSW/d3N2EoZtAgSyPFF7nILN4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b39T8kh10FMKMaAfwJhWnZAyBNYc+8l21mp8exyxX21O93Qvx/wdGhpuvvX9HpAKfOVSttVdE9UwB/u7BUEDMnzdyXj704r2jzJtUj32CA6CJ5/T+z4yByJAo9yzfGcgj/JvSDhrMqT/ZCb+yFsRLG6b3Og7YTz5b4smyyQhR8eWtg5S4rSAjud5w/RB6TdIwg1WmNnLVv+/cn79Qqp44cLd8fOl9b64cPq9HCsuolMlEh9X8fMoE9HFh0BsYaZKKApGNsN/RUSj9p5DsBVUu670kZMjOQDRfFuQG+fmLcgoftanfWm6lkSfICAZJNiGSHShj5zP/fipX0pYHOSdnQ==
X-YMail-OSG: V4iyQPgVM1mpOuPNVyaCqAaSmGIdLfQ5WfNlx7xjRE4LIlmBV4erDrYXcbmAeQi
 Z1utLDqB1_LLOfW8eG0YBAigZ507WuoSFHePuUlT9oDLnltgDZgXehn_QdhRigBCW7UmFWVF_8rY
 cl0dYoqnKwIaSa3VSQ83rDT.lNshmK85bcSaWAeEggMRflv98fZaY480huq.1eiOxEnGu.6cc__w
 b5Y0Qvg0.qKRrpRAcMwMmNPWshcvoJBJ5Rt4Hk6s7XzhIsA3v5ZJDEJKUPZXFLw.MME2X2.OAmOE
 t7KHhnHc3TMVwv0ycDOs5vh1Q4Rsbrx9M3EA65HMmij8F_lWg0Ml3pdEVUmuyBQXamBTejQZ_Xfl
 OzORVVRRMlul6XzG.VT7YKmP5HbzhDnlMFqX.nFZMr.LZO3Mrt9zt7NuFS0gi5VpnPWs7wleNH5a
 n8EFDqZuLECULJZlj4KHrdIsVrXhK0Lq.340ZNeg3ISOAlh2JAvKQFQQwvtY8FETX.XiyyzlQ.Iw
 WzyGjKCBQQ2BBSUIdy_HB_H5jMrM5X5kR49KD0VUergx9nn1y8p4IlHruTEs6o8Qc4QWCwX65gKK
 puhlIJL35x4H1oZZV55P91r9X1XmsQKaRLoUFxxCPUQdtxKOH4g6wmcLZwUeZkvlwnnAHyw_aDGU
 pJWJR35RUWvfJKAqgzvaPlL50H65WVNcpUsENAMRKAnQk141u.SZn5zEmpTM6zF_4HFYNZ9Mxnd0
 0.ir2e077WwA8N.W99RkNT8x6RI28dj0ai0cr8.GBvH958B6IMK2ASl3FR.IuSF57nA3_UfEtqpS
 0A7Z4yLpX2WXoQdmHHyjzqIAbd0ijO9zPS8r7..tuCf8D7tOFMWKvsLK2D9R_eulOnr0HdRk4_aO
 cOXBtjVKcI4VhwYjI5czKsytrDiGA3NCn8KWZFo8rj8KF6P5yTAPRI9BfCP7pxJXQTpbykQWQ2Ii
 et0V_4_OS9U1u5e7ubsZDqOwhtnd4IWkNLH1rIWnTXQUkHQ.hT5fovKPd7.d7Td_NJYBMcUedbE.
 4SzJDZcJYIBKqMxFgTIHRDoeofqLTVtSnTHB1qr7iDCixu2ccls0M4AuNFIwtdR6l0btjIwBTcJn
 Cuem0l8KmNCQINCf6J31_CrGgNUu5Yq9jZlss1M3ojwjqa140iRvKXuBuYai4D4dGCBLDB.RKZnL
 r7DdqZrbM9yliPo.vKW_D6_Ec0bviFOGn6irjuKjsGCdvp6cMx.gMSFlTFXZKOsPCCF9Df7xCtbn
 7dgwv10gZDck1r.vgYq.Nxcoc29885tlSH4yglb_7nkjuwizoynhq.j8KkqiG3pLxP1P.eMzeL30
 oDlHf96_IYtrgv7mZcnizxzqMaAqEQYWDWy7OO1UTCwQjKOK_l077dhUxuer_qJeM9wtmC3h.oCi
 GSK44GtIDGRBOIxoI8_FoXtk1v7rQC6kMxnM3AI7xSHx1uR7E5ohZNGQ4RGsCRKOb7FZmOD_5l.z
 BzPpb_AeXx8DZB7sMiA_mC3HwzNSNj5jDmT47XHyfr9ldhPz7U5hZYNcR.fsw4FeKymF3DlnQgWr
 imTSYxkmVm_uFy53WokTn2lPNyMkbYDMjGTjjsOEskPs.J.X_..QYK6.lnPLuXS_A12N3RK8Ddp_
 qLn97MwQEinvinFO2e_zqPJCYBb5kOzLOtT8MMXXmvk20MnGMOfBYoYo4RfiPgFjMIYf03wtEB0t
 doOmrxAQiYTqnK1GJUPI51rtMh01RSwb7Ffv2FO_bDB.RiqjxJzUtY1weZJ.IOhCiJi.qU1vl5QT
 v2nxTi692Mj13NlcwRHZlThZbj_Fbe.o0W4AFFAkC9pL_Wsxp54.X6ZbCS80Yy1phA0SPIOYrHq0
 oXzuFLjyjVZrxN8XZbbjPn8ZHh7e9r2jnJYb2SzHvbEQDmHAodpe7r0WZyRoyBmwESTqGnW3IOLd
 lgXCG0W7yhWIHNJn6l4YgfFrIVwRG9aMTbGILVCFAp1izzCLkwZ.tlBqgbSRBrFae1_uPqhJe8G0
 qJqElgtgKpMmeQ.0byeI_tPcNnoEqDWZEbP271r9FZDHPtrBAOw8QSGFCp2icBZPA2Dp1Bex3A30
 7QH2lYuKtWzqzKlRA3.FYyUMQV6cWtCJK_pY1lmrOuhtF0.NgMEUYlgXcW06C72ddKbxsJuwd3s7
 fxqKVnh1ELg_C8tHrm666GH9V8HtAn4Y3Y0jHsy2n_DLyjLWoBveyMvT3tUIEOt1gPlnUdLDt3o5
 ND6N3GR6izu6.LiiBWrayqGPrcvpE22L295mJfJxulgMXs6FGtk.V8M4XznRWbGlLXa0kceggC59
 2sjlrVXmspL4u8yatdA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ed29c49c-0216-499d-a396-11c3e74d7564
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Jul 2023 22:00:03 +0000
Received: by hermes--production-bf1-5d96b4b9f-jv67c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4e9158a89a2aa93478dce59226f9f0b6;
          Fri, 14 Jul 2023 22:00:00 +0000 (UTC)
Message-ID: <02988d71-8a6f-023c-12ec-eb2a73e4ea88@schaufler-ca.com>
Date:   Fri, 14 Jul 2023 14:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-5-casey@schaufler-ca.com>
 <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 8:36 AM, Mickaël Salaün wrote:
>
> On 29/06/2023 21:55, Casey Schaufler wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifies the size of the attribute, and the attribute value. The
>> format
>> of the attribute value is defined by the security module. A flags field
>> is included for LSM specific information. It is currently unused and
>> must
>> be 0. The total size of the data, including the lsm_ctx structure and
>> any
>> padding, is maintained as well.
>>
>> struct lsm_ctx {
>>          __u64 id;
>>          __u64 flags;
>>          __u64 len;
>>          __u64 ctx_len;
>>          __u8 ctx[];
>> };
>>
>> Two new LSM hooks are used to interface with the LSMs.
>> security_getselfattr() collects the lsm_ctx values from the
>> LSMs that support the hook, accounting for space requirements.
>> security_setselfattr() identifies which LSM the attribute is
>> intended for and passes it along.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> ---
>>   Documentation/userspace-api/lsm.rst |  15 ++++
>>   include/linux/lsm_hook_defs.h       |   4 +
>>   include/linux/lsm_hooks.h           |   1 +
>>   include/linux/security.h            |  19 +++++
>>   include/linux/syscalls.h            |   5 ++
>>   include/uapi/linux/lsm.h            |  36 +++++++++
>>   kernel/sys_ni.c                     |   4 +
>>   security/Makefile                   |   1 +
>>   security/lsm_syscalls.c             |  55 ++++++++++++++
>>   security/security.c                 | 112 ++++++++++++++++++++++++++++
>>   10 files changed, 252 insertions(+)
>>   create mode 100644 security/lsm_syscalls.c
>>
>> diff --git a/Documentation/userspace-api/lsm.rst
>> b/Documentation/userspace-api/lsm.rst
>> index 6ddf5506110b..e6c3f262addc 100644
>> --- a/Documentation/userspace-api/lsm.rst
>> +++ b/Documentation/userspace-api/lsm.rst
>> @@ -48,6 +48,21 @@ creating socket objects.
>>   The proc filesystem provides this value in
>> ``/proc/self/attr/sockcreate``.
>>   This is supported by the SELinux security module.
>>   +Kernel interface
>> +================
>> +
>> +Set a security attribute of the current process
>> +-----------------------------------------------
>> +
>> +.. kernel-doc:: security/lsm_syscalls.c
>> +    :identifiers: sys_lsm_set_self_attr
>> +
>> +Get the specified security attributes of the current process
>> +------------------------------------------------------------
>> +
>> +.. kernel-doc:: security/lsm_syscalls.c
>> +    :identifiers: sys_lsm_get_self_attr
>> +
>>   Additional documentation
>>   ========================
>>   diff --git a/include/linux/lsm_hook_defs.h
>> b/include/linux/lsm_hook_defs.h
>> index 6bb55e61e8e8..f69a7863dbe2 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm
>> *perm, struct sembuf *sops,
>>   LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>>   LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>>        struct inode *inode)
>> +LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
>> +     struct lsm_ctx __user *ctx, size_t *size, u32 flags)
>> +LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
>> +     struct lsm_ctx __user *ctx, size_t size, u32 flags)
>>   LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const
>> char *name,
>>        char **value)
>>   LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value,
>> size_t size)
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index fba8881d2bb5..9a3ae6b33d7b 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -25,6 +25,7 @@
>>   #ifndef __LINUX_LSM_HOOKS_H
>>   #define __LINUX_LSM_HOOKS_H
>>   +#include <uapi/linux/lsm.h>
>>   #include <linux/security.h>
>>   #include <linux/init.h>
>>   #include <linux/rculist.h>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 945101b0d404..475d0abfebda 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -60,6 +60,7 @@ struct fs_parameter;
>>   enum fs_value_type;
>>   struct watch;
>>   struct watch_notification;
>> +struct lsm_ctx;
>>     /* Default (no) options for the capable function */
>>   #define CAP_OPT_NONE 0x0
>> @@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm
>> *sma, int cmd);
>>   int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>>               unsigned nsops, int alter);
>>   void security_d_instantiate(struct dentry *dentry, struct inode
>> *inode);
>> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +             size_t __user *size, u32 flags);
>> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +             size_t size, u32 flags);
>>   int security_getprocattr(struct task_struct *p, int lsmid, const
>> char *name,
>>                char **value);
>>   int security_setprocattr(int lsmid, const char *name, void *value,
>> size_t size);
>> @@ -1331,6 +1336,20 @@ static inline void
>> security_d_instantiate(struct dentry *dentry,
>>                         struct inode *inode)
>>   { }
>>   +static inline int security_getselfattr(unsigned int attr,
>> +                       struct lsm_ctx __user *ctx,
>> +                       size_t __user *size, u32 flags)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int security_setselfattr(unsigned int attr,
>> +                       struct lsm_ctx __user *ctx,
>> +                       size_t size, u32 flags)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static inline int security_getprocattr(struct task_struct *p, int
>> lsmid,
>>                          const char *name, char **value)
>>   {
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 33a0ee3bcb2e..9a94c31bf6b6 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -71,6 +71,7 @@ struct clone_args;
>>   struct open_how;
>>   struct mount_attr;
>>   struct landlock_ruleset_attr;
>> +struct lsm_ctx;
>>   enum landlock_rule_type;
>>     #include <linux/types.h>
>> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int
>> flags);
>>   asmlinkage long sys_set_mempolicy_home_node(unsigned long start,
>> unsigned long len,
>>                           unsigned long home_node,
>>                           unsigned long flags);
>> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct
>> lsm_ctx *ctx,
>> +                      size_t *size, __u32 flags);
>> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct
>> lsm_ctx *ctx,
>> +                      size_t size, __u32 flags);
>>     /*
>>    * Architecture-specific system calls
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index f27c9a9cc376..eeda59a77c02 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -9,6 +9,36 @@
>>   #ifndef _UAPI_LINUX_LSM_H
>>   #define _UAPI_LINUX_LSM_H
>>   +#include <linux/types.h>
>> +#include <linux/unistd.h>
>> +
>> +/**
>> + * struct lsm_ctx - LSM context information
>> + * @id: the LSM id number, see LSM_ID_XXX
>> + * @flags: LSM specific flags
>> + * @len: length of the lsm_ctx struct, @ctx and any other data or
>> padding
>> + * @ctx_len: the size of @ctx
>> + * @ctx: the LSM context value
>> + *
>> + * The @len field MUST be equal to the size of the lsm_ctx struct
>> + * plus any additional padding and/or data placed after @ctx.
>> + *
>> + * In all cases @ctx_len MUST be equal to the length of @ctx.
>> + * If @ctx is a string value it should be nul terminated with
>> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
>> + * supported.
>> + *
>> + * The @flags and @ctx fields SHOULD only be interpreted by the
>> + * LSM specified by @id; they MUST be set to zero/0 when not used.
>> + */
>> +struct lsm_ctx {
>> +    __u64 id;
>> +    __u64 flags;
>> +    __u64 len;
>> +    __u64 ctx_len;
>> +    __u8 ctx[];
>> +};
>> +
>>   /*
>>    * ID tokens to identify Linux Security Modules (LSMs)
>>    *
>> @@ -51,4 +81,10 @@
>>   #define LSM_ATTR_PREV        104
>>   #define LSM_ATTR_SOCKCREATE    105
>>   +/*
>> + * LSM_FLAG_XXX definitions identify special handling instructions
>> + * for the API.
>> + */
>> +#define LSM_FLAG_SINGLE    0x0001
>> +
>>   #endif /* _UAPI_LINUX_LSM_H */
>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index 860b2dcf3ac4..d03c78ef1562 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -262,6 +262,10 @@ COND_SYSCALL_COMPAT(recvmsg);
>>   /* mm/nommu.c, also with MMU */
>>   COND_SYSCALL(mremap);
>>   +/* security/lsm_syscalls.c */
>> +COND_SYSCALL(lsm_get_self_attr);
>> +COND_SYSCALL(lsm_set_self_attr);
>> +
>>   /* security/keys/keyctl.c */
>>   COND_SYSCALL(add_key);
>>   COND_SYSCALL(request_key);
>> diff --git a/security/Makefile b/security/Makefile
>> index 18121f8f85cd..59f238490665 100644
>> --- a/security/Makefile
>> +++ b/security/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)            += keys/
>>     # always enable default capabilities
>>   obj-y                    += commoncap.o
>> +obj-$(CONFIG_SECURITY)             += lsm_syscalls.o
>>   obj-$(CONFIG_MMU)            += min_addr.o
>>     # Object file lists
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> new file mode 100644
>> index 000000000000..ee3881159241
>> --- /dev/null
>> +++ b/security/lsm_syscalls.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * System calls implementing the Linux Security Module API.
>> + *
>> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + *  Copyright (C) 2022 Intel Corporation
>> + */
>> +
>> +#include <asm/current.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/security.h>
>> +#include <linux/stddef.h>
>> +#include <linux/syscalls.h>
>> +#include <linux/types.h>
>> +#include <linux/lsm_hooks.h>
>> +#include <uapi/linux/lsm.h>
>> +
>> +/**
>> + * sys_lsm_set_self_attr - Set current task's security module attribute
>> + * @attr: which attribute to set
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx
>
> I don't understand why we need the lsm_ctx's size in this argument and
> in the lsm_ctx.len field as well. It makes sense to use the syscall's
> argument to set/get the size but I don't the the point of the "len"
> field.

The .len field is more interesting in lsm_get_self_attr(). We're using
the same structure for both calls. Part of the purpose of these syscalls
is to create a stable API, and the common structure is part of that.

>
> I may have miss some explanation but I also don't see the point of the
> ctx_len field if we can infer this information from the size argument.
>
>
>> + * @flags: reserved for future use
>> + *
>> + * Sets the calling task's LSM context. On success this function
>> + * returns 0. If the attribute specified cannot be set a negative
>> + * value indicating the reason for the error is returned.
>> + */
>> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct
>> lsm_ctx __user *,
>> +        ctx, size_t, size, u32, flags)
>> +{
>> +    return security_setselfattr(attr, ctx, size, flags);
>
> Why not include all this lsm_syscalls.c file into security.c, or
> implement security_setselfattr() here instead? Ditto for other
> syscalls. This would simplify code and avoid duplicating the
> documentation.

The security.c file contains the infrastructure part of the LSM hooks.
The lsm_syscalls.c file contains the syscalls. The code is layered to
be consistent with the LSM conventions.

>
>
>> +}
>> +
>> +/**
>> + * sys_lsm_get_self_attr - Return current task's security module
>> attributes
>> + * @attr: which attribute to set
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx, updated on return
>> + * @flags: reserved for future use
>> + *
>> + * Returns the calling task's LSM contexts. On success this
>> + * function returns the number of @ctx array elements. This value
>> + * may be zero if there are no LSM contexts assigned. If @size is
>> + * insufficient to contain the return data -E2BIG is returned and
>> + * @size is set to the minimum required size. In all other cases
>
> This is not true with selinux_getselfattr() (and without
> LSM_FLAG_SINGLE) at least. -E2BIG is returned without updating *size.

That's not what I see in patch 0010. 

>
>
>> + * a negative value indicating the error is returned.
>> + */
>> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct
>> lsm_ctx __user *,
>> +        ctx, size_t __user *, size, u32, flags)
>> +{
>> +    return security_getselfattr(attr, ctx, size, flags);
>> +}
>> diff --git a/security/security.c b/security/security.c
>> index d942b0c8e32f..199db23581f1 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -3798,6 +3798,118 @@ void security_d_instantiate(struct dentry
>> *dentry, struct inode *inode)
>>   }
>>   EXPORT_SYMBOL(security_d_instantiate);
>>   +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space destination for the information, or NULL
>
> It would be useful to explain the use case for NULL: to only get the
> number of attributes. Also, LSM_FLAG_SINGLE is incompatible with a
> NULL ctx.

The *size* is updated, not the number of elements.

> It's also a bit weird to still require size to contain a valid
> address. And size is always checked by the hook implementations even
> if ctx is NULL. I suggest to require size to be NULL if ctx is NULL,
> or return -EINVAL otherwise.

Then you can't get the size, which is what you really care about.

>
>
> I'm not convinced this trick/exception to only get the number of
> attribute is useful though, especially with *size that needs to be
> large enough. Or maybe we should require *size to be zero and return
> the required size to hold all attributes?

That's what it does.

>
>
>> + * @size: pointer to the size of space available to receive the data
>> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that
>> only
>> + * attributes associated with the LSM identified in the passed @ctx be
>> + * reported
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +             size_t __user *size, u32 flags)
>> +{
>> +    struct security_hook_list *hp;
>> +    struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>> +    u8 __user *base = (u8 __user *)ctx;
>> +    size_t total = 0;
>> +    size_t entrysize;
>> +    size_t left;
>> +    bool toobig = false;
>> +    int count = 0;
>> +    int rc;
>> +
>> +    if (attr == LSM_ATTR_UNDEF)
>> +        return -EINVAL;
>> +    if (size == NULL)
>> +        return -EINVAL;
>> +    if (get_user(left, size))
>> +        return -EFAULT;
>> +
>> +    if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
>> +        if (!ctx)
>> +            return -EINVAL;
>> +        if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
>> +            return -EFAULT;
>> +        if (lctx.id == LSM_ID_UNDEF)
>> +            return -EINVAL;
>> +    } else if (flags) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +        if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
>> +            continue;
>> +        entrysize = left;
>> +        if (base)
>> +            ctx = (struct lsm_ctx __user *)(base + total);
>> +        rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags); >
>> +        if (rc == -EOPNOTSUPP) {
>> +            rc = 0;
>> +            continue;
>> +        }
>> +        if (rc == -E2BIG) {
>> +            toobig = true;
>> +            left = 0;
>> +            continue;
>> +        }
>> +        if (rc < 0)
>> +            return rc;
>> +
>> +        left -= entrysize;
>> +        total += entrysize;
>> +        count += rc;
>
> Would it make sense for an LSM (e.g. eBPF program) to return more than
> one? If not, we should force 0 or 1, and probably call WARN_ON_ONCE()
> if it is not the case.

No. An LSM that supports multiple values for the same attribute is going to
have to have some internal convention for specifying that in any case.

>
>
>> +    }
>> +    if (put_user(total, size))
>
> This might be useful to get the required size, but if the original
> *size is not big enough the LSM hook implementations (e.g.
> selinux_getselfattr) currently don't update *size and just return
> -E2BIG, which is then propagated at the end of the syscall, after all
> hook calls.

The code I'm looking at updates *size.

>
>
>> +        return -EFAULT;
>> +    if (toobig)
>> +        return -E2BIG;
>
> This doesn't help because we don't know how much space is required for
> a specific list entries/LSMs.
>
> I'm convinced this syscall should only deal with one LSM attribute at
> a time (i.e. only support LSM_FLAG_SINGLE, but then without this
> flag). I think it's not worth it to handle a list of arbitrary-size
> elements, especially when they have a different semantic.

Nine months and 12 revisions in I am NOT going to re-architect this again. 

>
> If we really need such list handling, I think it would be easier to
> have a syscall argument pointing to a header part containing an array
> of LSM IDs (and potentially the flags field)), and another syscall
> argument that contains an array of (simplified) lsm_ctx entries
> (without len). This would look like this:
>
> struct lsm_entry {
>     __u64 id;
>     __u64 flags;
> };
>
> struct lsm_ctx {
>     struct lsm_entry entry;
>     __u64 ctx_size;
>     __u8 ctx[];
> };
>
> int security_getselfattr(unsigned int attr, const struct lsm_id __user
> *ids, size_t ids_size, struct lsm_ctx __user *ctx, size_t __user
> *ctx_size, u32 flags);
>
> This enables to use a big buffer of packed lsm_ctx elements because we
> don't need to allocate an array of fixed-size elements anymore. When
> an LSM hook implementation return -E2BIG, the lsm_ctx array filling
> will stop and renturn this error, which enables user space to know the
> problematic entry. In this case, user space can get the required size
> by setting @ctx to NULL and reading the returned *size value.
>
> This types would also enable to use the same lsm_ctx variable as @ids
> and @ctx arguments (with sizeof and real size) to get one element, or
> just fill the buffer with a list of lsm_entry entries and read back a
> list of lsm_ctx entries. Using different syscall arguments makes it
> well defined and documented.
>
> The lsm_ctx type can also be use by the setselfattr syscall, without
> superfluous len field.
>
> I would also prefer to replace the `size_t __user *ctx_size` argument
> with something like `size_t ctx_available_size` and `size_t __user
> *ctx_written_size`, but it I guess it's a matter of taste…
>
> This struct lsm_entry could also be used by the lsm_list_modules()
> syscall to get more informations about LSM using the flags fields.
>
>
>> +    if (count == 0)
>> +        return LSM_RET_DEFAULT(getselfattr);
>> +    return count;
>> +}
>> +
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to set
>> + * @ctx: the user-space source for the information
>> + * @size: the size of the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @ctx.
>> + *
>> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
>> + * if the user buffer is inaccessible or an LSM specific failure.
>> + */
>> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +             size_t size, u32 flags)
>> +{
>> +    struct security_hook_list *hp;
>> +    struct lsm_ctx lctx;
>> +
>> +    if (flags)
>> +        return -EINVAL;
>> +    if (size < sizeof(*ctx))
>> +        return -EINVAL;
>> +    if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>
> I'd suggest to handle all the user space copy here and pass a kernel
> pointer to each LSM hook calls (and handle kmalloc and kfree here, if
> needed). This single point of copy would make the LSM implementations
> (setselfattr hooks) easier and less error prone. For instance, we
> could limit data copied from user space to PAGE_SIZE (as done for
> Landlock syscalls). If one day this limit is too short, there is
> always the possibility to add a dedicated flag to the syscall or set
> exceptions according to the target LSM.
>
> A global array containing the maximum size of such context per LSM
> would be nice. I guess current LSMs don't accept unlimited attributes
> (strings) size.
>
>
>> +        return -EFAULT;
>> +    if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
>> +        lctx.len < lctx.ctx_len + sizeof(ctx))
>
> It should not be sizeof(ctx) but sizeof(*ctx) or sizeof(lctx).
> Positive and negative tests for these checks would be useful.
>
> Why not `if (size != lctx.ctx_len + sizeof(lctx))` instead? If this is
> correct, ctx_len and len are redundant. Otherwise, a comment should
> explain what is going on, and what is being checked.
>
>
>
>> +        return -EINVAL;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +        if ((hp->lsmid->id) == lctx.id)
>> +            return hp->hook.setselfattr(attr, ctx, size, flags);
>> +
>> +    return LSM_RET_DEFAULT(setselfattr);
>> +}
>> +
>>   /**
>>    * security_getprocattr() - Read an attribute for a task
>>    * @p: the task
