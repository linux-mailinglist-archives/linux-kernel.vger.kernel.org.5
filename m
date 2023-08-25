Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D77891B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHYWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHYWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:23:52 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D90211C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693002221; bh=g9vWFHhEYz3/Xtg33IfxkXNK2VQU0Dv1Fj6X1xf/VoQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WRD28Nm7lY/kn6tAu+EmwNCKgRaIA8pU6TH0mjCPaGik2t13V4IhoTeZRrBPHJ7uJy0ws6iYcUx4VqbCzvpi2vw8Fsl7yjkNfEqHctR3u2jaNlWFlvHlZYu9sjAFMkmyIU2gL9efHhz2uE5dIgjxWMWsoaSCOk3rO+kAGyoegPQL0Jr760XUzawwDSYKPb9jOn0tZbIM+9JCjgT9etefBtIZSrWHGQnbOBc9M0xxkXQFbGl0tcYV7X8UtHYuGzMAYhvDbIse+4Qwak8IolerfKEX5b6L3C0xkSQhU3PwxSI9l9HJeFBXMuRSxvWr0G3xeDqvxm4Tdi1BHnn3d/TScw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693002221; bh=Jw/HOjQvl8lzb564ccCZ6Q2aYlVXrqFJVZSGfqzVg3a=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PAXKA0CUXDflWPMOyDs69yYuE5Yt4VFHIGhqxA5SVfAgTAm6rjlJcPXCPVeCKQapzvjLxs3ftX72F89KGVz86e4TOOZN5ACMFQateZcKbT+lqiKqJU5YA5rk7cbDjRIiyb0IHAVI3BHE5tCbTL6vWZUeHIOLzqrbCuUoskLU8XQVhM9pIEA+KE2axVEfH+S4nmnziX5LBOPDnsOeokNQ7d3227WKtslxMOuapWYNZBCkuuUGQMkQiymiYr56Wam3cmGikFvcqA/C3IClBZ+rJJWTLwXBnt7eiLytBsBKmfUaPEOG/7icVGVGGZOh9J9fP5sL0qsHZmJHoV+x/pXYvg==
X-YMail-OSG: zglbCI0VM1lBie2HasRhlAaKa9798GiRE3kH5PHDYdTJmfeoSQdpgA9yK98qsP0
 sSa.wTGO.Egg3J24yavp0203mRZha96iaXlF1NdzzIcOCTnfffxXyKYhdWSJNqc9IRNA0yVbXV87
 h6WNS6io_mnP14VzaVjorPzvrXy4tCowt8gFYtN7XACr7wQVxKi.sqVpBy1Bk7fJWlS0rr4F8mQ9
 oDS_eoQdFyoNSYFhXIO6iZvGcya_OAZDw72USkhT0_5fwqlU3KoeILErods1CnDNBLq4wCFsroDR
 BpBhZfDv4Xyo_80fgO3qGAgWYsZBb5vfUzh7NF5dgvjTbDrihNngzMcZUkn9y7eS8pF2x6I_eRoP
 aBNKjUbmV9bUAmzcbuiCyKgYRSVvSbAZKYwW7DjxAFY79jVYagwxC80oth3Kz_A86QC6BthTGDD.
 HBnZWZk4Wv8Y1G5Z6ZJlZmSQcgqDs5Is035xg5kMl9O5g1xsaou2BMaIequwsfE9xbsjxBXGxAvS
 8EdbMsAfKotBFVSB3y_PsPyhSAYLRfBT1b5mjrZjEXbkklfIp61xOoVJaMa7opc89WbDn79fxwIl
 971yZAd2EK5wf7p5HNM4EXnQZz270FgW4i4r1renbN9acOgo6c_07rYdPzpsUnDkIS8bN67MInB1
 h4.RrKbv8gJALyecf7TTVDUH3niYm1AzNRor.HOBTcAY98v3DJsSQUqzoI0XGw5uw6xPMNsRN2Pf
 a3FKno9VGfXZDGY_zXzhs5_5rSqqpDjClxHtkhogJJqZdog67iBiVFJjbDSyEEyLa0dOKuwhHlli
 pEmpg1nXjCKH4GaBoertz1KV3gJkEZS3ang.nhZgbCPLzyCvnbEORpborGp2sunASEMiMOTQk2I4
 Ritd66RTMixOY9o.NTTS.5j_k2U.e7e_7kt59tWBkmke7l6BEPlhQXSNVt2KAMBKBOjNHiX60sUJ
 t2zXlG1GrAzrKQhMKj1HowuJP7Wz97Dtpqbhv9ZAP64QxUQwuIRUqoYafJyu_N1KqsuXmsLRGc17
 FkbZwHFwzt2MnsxJ5GvP0IuYwPS7Uhc27hzgJ2VunbuyoK5OvQKdVzZyygZuHdHjz79B8LtOK0Kg
 MaFu43Wl84VNpJaMOFEaAtXsCbDW_2MHoTe_PIY0XMo0Yl9OPNKgXUqEKJ6LTca8PCjuPzu11m_I
 BCBLyEsvwa4uuvbaDvJy5Buy4mANqJG1.9Ba6s.7FtRDo2ipufs6HS2k_TNumoVbM3nRcAs3rHWh
 Fa2sBZJQmA1O.d9ZFYMwj6dRRy2rZaZITepX6p0DL7vuMIgFpZ4Dz6kQuZkgtE1lWk48bDwdbILP
 1byPTMVz6Xq6U5WyR.m0DhD_gaHGAkQfSe3ZntxkeFjdwdtXOcC.UaV9O5UHVll..Jw.xpe8Txkm
 4Fr4amKrzxG6Jbz.smnyS8WnQfW3PScViDziV8IqbA3yU7yRW9jvG3_syZ68pPmptGlBQ9yP8QDb
 ueDtVLARRDfM98zGuiBe3FHJ7hSUsMU_sxQIrM6SMCuBrsZKTtjH.Av0qe_GKlSZE4bC.xE3aWIC
 HoMA7F0gNt.iRVdFRQ.DXhmnx.67LE8WGlO4CDE7kuxgNXJdbqFA7rgfjGGkOIZGR84uwcOUMfMV
 WKHHYmm7fALxwC7jsaRbmGpFktPq4._Sm2aE3pvy9nZbe4yS6J5n3a2NUpr1VOsNCTdXUEP9rXCu
 Ec7sT3HU2Gd6HdTWldpwucBpmJ7gIRmcEWipc_V.uQwGY4fYReBN3hrhllJG.PSisIpEpK.m69Wu
 VdoXAnK8DfxybrczLAy9hNzpk626k.hs11iwp_BgoV6BjkQMrYxlRohuVCBAofLguULRQFnDyqbe
 8auxfXV_43KlVGOHhl4rPT.LLKKxk7C_jhSwfMiryKDCRB0fEUQDjIVOXljrrSM4bFLnBycwsEn1
 0iRb0yveOoxZ6L6VtB3DiMlGqvfZK1Ho7JbtTX80OsPZdlrPKtFRUukFkSGcKNnkfO_61mHxmc3v
 C2il0FOtplcBEquIi62juBzF06OkNJOUq0mu_vRRFk27NWOKpCrlGbj.ri2uNuOF9pT_8GD5fA7w
 JM7oymdNMyG9ceu9bIrNZP_.nKAp6hBaYf6aIT5mecKUZsJNnV0De5q3bll8IKWQfdAZkq9p4RTs
 wXrJQaHt8tqWrYHYgqkpe5L0awI.O9L8B30PM_W3G4bfJ5i2CtgfPA_ROKubfpx_7gH4wohFWEkR
 IdKz3T0Ga6qGxqgH.KnsDxJYxsLr2YeR2Q876vTTBkDB7vc.AYB4jL7h8rWhF1_1AJFD8fPKZgg1
 E592GEwTcpZ.V
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ec81b218-b548-41b4-a7b6-cf07646b1717
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Aug 2023 22:23:41 +0000
Received: by hermes--production-bf1-865889d799-k5x9p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ad08512ea5bfad7b6cfedf243e8b0c68;
          Fri, 25 Aug 2023 22:23:36 +0000 (UTC)
Message-ID: <5d9f0e72-56d3-8f83-2e34-c0a27cbc0616@schaufler-ca.com>
Date:   Fri, 25 Aug 2023 15:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v13 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-5-casey@schaufler-ca.com>
 <20230825.xoo1uu1Ohsh4@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230825.xoo1uu1Ohsh4@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2023 7:59 AM, Mickaël Salaün wrote:
> On Wed, Aug 02, 2023 at 10:44:27AM -0700, Casey Schaufler wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifies the size of the attribute, and the attribute value. The format
>> of the attribute value is defined by the security module. A flags field
>> is included for LSM specific information. It is currently unused and must
>> be 0. The total size of the data, including the lsm_ctx structure and any
>> padding, is maintained as well.
>>
>> struct lsm_ctx {
>>         __u64 id;
>>         __u64 flags;
>>         __u64 len;
>>         __u64 ctx_len;
>>         __u8 ctx[];
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
>>  Documentation/userspace-api/lsm.rst |  70 ++++++++++++++++
>>  include/linux/lsm_hook_defs.h       |   4 +
>>  include/linux/lsm_hooks.h           |   1 +
>>  include/linux/security.h            |  19 +++++
>>  include/linux/syscalls.h            |   5 ++
>>  include/uapi/linux/lsm.h            |  90 ++++++++++++++++++++
>>  kernel/sys_ni.c                     |   2 +
>>  security/Makefile                   |   1 +
>>  security/lsm_syscalls.c             |  55 ++++++++++++
>>  security/security.c                 | 125 ++++++++++++++++++++++++++++
>>  10 files changed, 372 insertions(+)
>>  create mode 100644 Documentation/userspace-api/lsm.rst
>>  create mode 100644 include/uapi/linux/lsm.h
>>  create mode 100644 security/lsm_syscalls.c
>> +/**
>> + * sys_lsm_get_self_attr - Return current task's security module attributes
>> + * @attr: which attribute to set
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx, updated on return
>> + * @flags: reserved for future use
> This documentation is out-of-sync with the LSM hook doc, especially the
> flags.

You are correct. I will repair it.

>
>> + *
>> + * Returns the calling task's LSM contexts. On success this
>> + * function returns the number of @ctx array elements. This value
>> + * may be zero if there are no LSM contexts assigned. If @size is
>> + * insufficient to contain the return data -E2BIG is returned and
>> + * @size is set to the minimum required size. In all other cases
>> + * a negative value indicating the error is returned.
>> + */
>> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>> +		ctx, size_t __user *, size, u32, flags)
>> +{
>> +	return security_getselfattr(attr, ctx, size, flags);
>> +}
>> diff --git a/security/security.c b/security/security.c
>> index 5e9cd548dd95..cde7f3a13e7c 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -3798,6 +3798,131 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>>  }
>>  EXPORT_SYMBOL(security_d_instantiate);
>>  
>> +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space destination for the information, or NULL
>> + * @size: pointer to the size of space available to receive the data
>> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
>> + * attributes associated with the LSM identified in the passed @ctx be
>> + * reported
> The final dot is missing.

Will fix.

>
>> + *
>> + * A NULL value for @ctx can be used to get both the number of attributes
>> + * and the size of the data.
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			 size_t __user *size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>> +	u8 __user *base = (u8 __user *)ctx;
>> +	size_t total = 0;
>> +	size_t entrysize;
>> +	size_t left;
>> +	bool toobig = false;
>> +	int count = 0;
>> +	int rc;
>> +
>> +	if (attr == LSM_ATTR_UNDEF)
>> +		return -EINVAL;
>> +	if (size == NULL)
>> +		return -EINVAL;
>> +	if (get_user(left, size))
>> +		return -EFAULT;
>> +
>> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
>> +		if (!ctx)
> This doesn't fit with the documenation. I guess it should handle NULL
> ctx in both cases.

It's also not correct. I've reworked the single case logic.

>
> This cases should be tested.
>
> I'm now wondering if this LSM_FLAG_SINGLE makes sense though.

It does if you want to pick up the attributes one at a time in
separate code paths in an application.

>
>> +			return -EINVAL;
>> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
> This check looks good but it looks inconsistent with the
> non-LSM_FLAG_SINGLE loop which doesn't check that the arrays only
> contain zeros.

The single case is the only case where the data is read from user-space.
They're inconsistent because the use of the user-space memory is read+write
in the one case and write-only in the other.

>
>> +			return -EFAULT;
>> +		if (lctx.id == LSM_ID_UNDEF)
>> +			return -EINVAL;
>> +	} else if (flags) {
> This check is not correct. It should test if there is no value other
> than LSM_FLAG_SINGLE.

I've reworked the single logic.

>
> Please add a test with something like this:
> lsm_get_self_attr(valid_attr, valid_ctx, valid_size, LSM_FLAG_SINGLE | 1 << 9)
>
>> +		return -EINVAL;
>> +	}
>> +
> Please add a comment to highlight that only LSM_FLAG_SINGLE is handled
> for this loop.

I don't follow. The loop handles both single and multiple cases.

>
>> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
>> +			continue;
>> +		entrysize = left;
>> +		if (base)
>> +			ctx = (struct lsm_ctx __user *)(base + total);
> To be consistent with the previous copy_struct_from_user() call, we
> should at least check that the ctx arrays contain zeros too.

We don't care because this is the copy-out part. The user-space data
isn't being read here.

>
> We should add a test for this case.
>
>> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
>> +		if (rc == -EOPNOTSUPP) {
>> +			rc = 0;
>> +			continue;
>> +		}
>> +		if (rc == -E2BIG) {
>> +			toobig = true;
>> +			left = 0;
>> +			continue;
>> +		}
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		left -= entrysize;
>> +		total += entrysize;
>> +		count += rc;
>> +	}
>> +	if (put_user(total, size))
>> +		return -EFAULT;
>> +	if (toobig)
>> +		return -E2BIG;
>> +	if (count == 0)
>> +		return LSM_RET_DEFAULT(getselfattr);
>> +	return count;
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
>> +			 size_t size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx *lctx;
>> +	int rc = LSM_RET_DEFAULT(setselfattr);
>> +
>> +	if (flags)
>> +		return -EINVAL;
>> +	if (size < sizeof(*ctx))
>> +		return -EINVAL;
>> +
>> +	lctx = kmalloc(size, GFP_KERNEL);
> We should not allow user space to allocate arbitrary kernel buffer size.
> Limiting to PAGE_SIZE seems reasonable.

Quite reasonable.

>
>> +	if (lctx == NULL)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(&lctx, ctx, size))
>> +		return -EFAULT;
>> +
>> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(ctx) ||
> Because we only handle one LSM at a time, size should be equal to
> lctx->len right?

Unless they've done some of the padding Paul's so keen on.

>
>> +	    lctx->len < lctx->ctx_len + sizeof(ctx))
>> +		return -EINVAL;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +		if ((hp->lsmid->id) == lctx->id) {
>> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);
> It seems that there is no (shared) check that the whole ctx is used. It
> would be nice for the LSM hook implementations to return the processed
> size and let this code check that there is no remaining data left, or at
> least that it only contains zeros.

Again, it's the possible padding case.

>
>> +			break;
>> +		}
>> +
>> +	kfree(lctx);
>> +	return rc;
>> +}
>> +
>>  /**
>>   * security_getprocattr() - Read an attribute for a task
>>   * @p: the task
>> -- 
>> 2.41.0
>>
