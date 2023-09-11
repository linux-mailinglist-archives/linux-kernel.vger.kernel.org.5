Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F079B47F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjIKXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjIKWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:53:16 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC761905C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694471442; bh=UUgz2B5wg4S6yAnMOKzi3AsEIZNsX57mspyGve0DwoE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QzVCmMmQ19oej/7CEtji2ZrslIFVrTsh9Gu4KPLmMdfJ/TeOYUc9BJ3n2KLsEdcGSm6L6dlN6Gta7b844LsjWJuxW6daDJWdGGDL9mntrbj6CYhfZ2CLho0jX5Cl0qOi1Z4koFrSMM5tBw09YJFczfxlG+Eisok/1Snc+aH+oiUxVzpaHCRyXTqBmAoU0kWQgEZvKeks8k0Oc41sTZGfLBgHARjrKWR0zaU1sCidGauuujkZlUqizoWprwpKbnYVY4kTOxAVJ1h+gfXwalXcTCHWaI2ZBB6Cizs2rq9F2u/gM5UMtMHgH9N/Jj9SkqO/HWx9YD094KghTvngokY+kQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694471442; bh=1FKl29MPUvgk6xbEcttZd530Y2DyPLxtUyXZYs2WALq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a+bo2daSvR4ocnfrT82kL3QW/JJ3pgYTE0QZPuGbyTJDeuDNSFQhIP3tGZKMmVN/8JHfrJnOhUuN0sp8lAvfegwbMz4t9Loc1XkveClhGAnh0s97avatyAMBlnzywEnI9LcUiLMxYBGJlgnmKtMTqddlS/ZxVJ0K8lK3ThTpeHIuF4K67waQpcF4EItgECuj0411m4HE3YPIv9BHAFsmyop26Fi7ISU8R0zKI9uVjCMloChtPaYFjKkfb9AgCthP80acygfz1TJZghX7wwhugf3YRAxfaMcvJl0oQ24G/g92ANDm9lnl0vfEspAJ5OjISBLian62LVsFjt4Wmr+L2w==
X-YMail-OSG: aRg8FcIVM1mwFl4uoud2FulZbKh97FKZ7mx06BUNUySGkRyruapt7sHJLeME0Jy
 YS.tus7zjnbg6Rsv06vHB8lWxXw6oRiOpSOFM1bd.EJX3gvfkL84Qhi3MgkIj.xD7.71rsfypGB.
 Q3ewyBCVMJCUX6ESacE5kEIwAWJMXQdaKEdmQJlgNPny4PEWnFnt_KqU5hireTbzOGgPxsev0._5
 0HzH8_yuUyGIQWFdXKsEhNZV.MhppAtBcd5V10zFYfVetNo6b3xQE16axxd6RV3jFzCptwO2OnSU
 uJA7owKGv6aQXETXTkF0nVqRj4.njXZ_APcbctcRrgogrXmWZrUDm.pEWrtWQ9pj88sAY0GHLYQT
 AC3erXfOB.b2Q8xeQt21GYzXJhNPGxGtKqO5JQmBdq.7mIhtFe9GzMpZo9ROZmmOrdxf_kUC.Gp4
 tDZAE2LfDrsuLP2rHypbdjQlz9NNstZugVBldrqocFtzhPeox4MWZKk6SriZRh8WWb27YH2.AODg
 9HfGVCb1aAcrbkgw8GZxg2kiW9FVPQpWimgn3G5e9PCwuoilSsGHYK6ZHgS3a4puMgrlfKhu0MF8
 dNjlwUwQIT8pGJg5CHQkoBsVXKDXNxWTwcCctxRZMkTpIBmAIDjl7awOIg__ev8nwEe9dTSTsSqZ
 xSts.768JzYlGzxtGJQ19q143kmQ6GZhFZcwP.X90m_X8Zsa1OQTF5kPdfeFVjWWKYCHO4q9gq8N
 7I9MbAq6mbxFJr2uyGt4Xhyz2TLLOaQrVfEcjR8utdGXJUti2.zSnUFjGM7tK4axBfwa3E5RYZ6h
 bhV0UurWTY4G53aLzD3iNLlyd.1Td9j_lpUJnLB0_e5OCpmuGm1zIzIHpnBVLRtvUC4ZR4GbqJzm
 zL6xRZeIQVeXzE6r_ajAh3WYLpBO4ZqjmFmRaCJCEThyBwj7Yz3iN6CCaf1lnXedY6PMAICoSYo6
 LB4kXJWkE4ZUd3EbZawAsC4aw_zmxXe0YbUCzE94XY.lAQiBWhBoxTH8rmuZXa0wD12CdXkWvqnm
 idwfu.UzqmnM8kP4__KPZjvk4AXuN374ztu_5PEJLlyGhN2U0qu3c8gWEqqaWxhZZciyoA4Ii479
 au.P64bZbpLbnrhOBA48CSWhFWZ_e2.ZUZcS6Jsan4ZlCi5EowNz659ydwcBmLFjdQLvjNVOdZqG
 9dE1lNrwsYPtDXlOKnAJ5IHcGpSZA8EV71U.C_QX7OKKcA9ndPY5Kt7uNDxhV6Q7Gs2DraIbePV3
 l7VEC0PNxwR8Ok.JRSg2lEMOvVSPBcdsf74kVgkEB5iAXs3L8gwCJ6gNiQI8NCdcNQlTM8hDpB68
 p.i5WwkNRiDQBw8ASUMNsrCGbjh8hnD.wCQmr3sBeGyG7UX5_3DNvANloNGjEX2qfbjrrl3n5jzX
 O6u2O9Kwb2ZWdMLZIBqQEfwNEyOzfz2HoTY98H_CNvQvQkr.s6A0u6QhxWWSFvwA7Dv7iTC6Rw2s
 XjVYjbzogiDUsxEPoYcucGiyXj1N4n7HKmFBBAniN9I.vRPjxkNJMbXldI_mnXj.JwdHlt1USohg
 36nErN2sOH2Z_5ems8X2a5yPKKi_Qr56JDxJ7mW7XlG8oNS6ZvsrGQdhaU9RfXVNaZCcheGS7uGr
 wsFRWBpo9TZPna7lFil6YYhFmtg0YuYaJTl3cn0g9ujauQL1m_ZqPwzmnUPllhXqSH1tPmmvDhMF
 aKB9e3YQoCut0bq.JMy3yFqI3Quzp8SaZ2jvSX8dySefQVYbJ3hj6HCEpdQmhPienMqeigcKIqn.
 lpk2EEXki7ioG.H5l2gWzO121SOO_Qhe5emM33oMSYETm.jtKaTSKjabIqzwTTEuNV.Ow62HS5M1
 G3m8JAJt4CSMwnrIIuFmDjgE20P1JqnPtx_FlpYMLTvamf7wB28.gBdsopjU_RkuBL89N39BW_61
 x8u7JMemM_bs3aVc4l8ELvPi7QKNyTcrkiMH5ANLYdFFGXST.uX.FYbxdIHm42PvfdoLgr_e.Xrf
 em1AXkHdtFGjvXHsbjyS75LgDdta5OVE.5m6EmuTmN10BrjMRcWIVdkbUalXQ_MmppX_2Y_.4l.t
 h7DlckOznnLf9NjKc7UZ.06tu5BqHHKUYLxjkejyBHQFje4W9kG._xLOkXg2CO0AJqyQPY4jZNqy
 W6ND4JL652redG5o_5eXWw0AeiBQy7cOZSL9geK.tEmyvXsefNQGZHhXlg07WlC74M47jy8fiTXq
 SxHZ5kPonod29nyebaL.OkkD1Tc94488MEV9eyn5KrUSsxg.8w.ZNif6Q3zmK1KZBXACX1_XKfyb
 Q6Qnv2w0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdda92d8-d76e-4d8b-8667-c1b92d795c98
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 Sep 2023 22:30:42 +0000
Received: by hermes--production-bf1-865889d799-5m62n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d3f1abcca143a9e2bba0e3e7669e2ea;
          Mon, 11 Sep 2023 22:08:52 +0000 (UTC)
Message-ID: <ebd82727-cc8e-d922-972b-ebd2cc47f1ee@schaufler-ca.com>
Date:   Mon, 11 Sep 2023 15:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v14 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
 <20230828195802.135055-5-casey@schaufler-ca.com>
 <20230907.go2eLeCo6ov1@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230907.go2eLeCo6ov1@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2023 8:37 AM, Mickaël Salaün wrote:
> On Mon, Aug 28, 2023 at 12:57:54PM -0700, Casey Schaufler wrote:
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
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> ---
>>  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
>>  include/linux/lsm_hook_defs.h       |   4 +
>>  include/linux/lsm_hooks.h           |   1 +
>>  include/linux/security.h            |  19 ++++
>>  include/linux/syscalls.h            |   5 +
>>  include/uapi/linux/lsm.h            |  36 +++++++
>>  kernel/sys_ni.c                     |   2 +
>>  security/Makefile                   |   1 +
>>  security/lsm_syscalls.c             |  57 +++++++++++
>>  security/security.c                 | 146 ++++++++++++++++++++++++++++
>>  10 files changed, 341 insertions(+)
>>  create mode 100644 Documentation/userspace-api/lsm.rst
>>  create mode 100644 security/lsm_syscalls.c
>>
>> +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @uctx: the user-space destination for the information, or NULL
>> + * @size: pointer to the size of space available to receive the data
>> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
>> + * attributes associated with the LSM identified in the passed @ctx be
>> + * reported.
>> + *
>> + * A NULL value for @uctx can be used to get both the number of attributes
>> + * and the size of the data.
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>> +			 size_t __user *size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>> +	u8 __user *base = (u8 __user *)uctx;
>> +	size_t total = 0;
>> +	size_t entrysize;
>> +	size_t left;
>> +	bool toobig = false;
>> +	bool single = false;
> Much easier to read with these booleans.
>
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
>> +	if (flags) {
>> +		/*
>> +		 * Only flag supported is LSM_FLAG_SINGLE
>> +		 */
>> +		if (flags & LSM_FLAG_SINGLE)
>> +			return -EINVAL;
>> +		if (uctx &&
>> +		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))
> Again, I'm not sure is copy_struct_from_user() should be used here
> because it checks that the user space structures ends with zeros, which
> is inconsistent with the case without LSM_FLAG_SINGLE. Anyway, this code
> should at least properly handle the copy_struct_from_user() error codes
> which includes EFAULT *and* E2BIG.

Further testing makes your point. The checking in copy_struct_from_user()
is really annoying. I'm going to fix this.

>
>> +			return -EFAULT;
>> +		/*
>> +		 * If the LSM ID isn't specified it is an error.
>> +		 */
>> +		if (lctx.id == LSM_ID_UNDEF)
>> +			return -EINVAL;
>> +		single = true;
>> +	}
>> +
>> +	/*
>> +	 * In the usual case gather all the data from the LSMs.
>> +	 * In the single case only get the data from the LSM specified.
>> +	 */
>> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +		if (single) {
>> +			if (count > 0)
>> +				break;
>> +			if (lctx.id != hp->lsmid->id)
>> +				continue;
>> +		}
>> +		entrysize = left;
>> +		if (base)
>> +			uctx = (struct lsm_ctx __user *)(base + total);
>> +		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
>> +		if (rc == -EOPNOTSUPP) {
>> +			rc = 0;
> Not a big deal but with LSM_FLAG_SINGLE, if the selected LSM doesn't
> implement this hook, this will uselessly loop over all LSMs.
> I'd add:
>
> if (single)
> 	/* Still try to write 0 as the total size for consistency. */
> 	break;

I'm trying to keep LSM_FLAG_SINGLE from being a complete special case.
Asking for an attribute that the specified LSM doesn't support is a
programming error, so I'm not concerned about a trivial performance
issue.

>
>> +			continue;
>> +		}
>> +		if (rc == -E2BIG) {
>> +			toobig = true;
>> +			left = 0;
>> +			total += entrysize;
> I'm not sure what is the desired behavior with LSM_FLAG_SINGLE in this
> case but I'd add:
>
> if (single)
> 	break;

I'm shifting the control logic a bit. I think it'll look cleaner.

>
>> +			continue;
>> +		}
>> +		if (rc < 0)
>> +			return rc;
> I think this should be a break instead of the return rc for consistency
> reasons.

No one has ever accused me of being consistent. I believe in using
return aggressively.

>
>> +
>> +		left -= entrysize;
>> +		total += entrysize;
>> +		count += rc;
> You could simplify a bit by replacing the first single check with this
> one:
>
> if (single)
> 	break;

As above, I think I'm making this clearer in v15.

>
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
> It would be nice to add a comment before all these three syscall
> documentations to keep up-to-date the related user space documentation
> in lsm_syscalls.c

Good thinking.

>
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to set
>> + * @uctx: the user-space source for the information
>> + * @size: the size of the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @uctx.
>> + *
>> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
>> + * if the user buffer is inaccessible or an LSM specific failure.
>> + */
>> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>> +			 size_t size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx *lctx;
>> +	int rc = LSM_RET_DEFAULT(setselfattr);
>> +
>> +	if (flags)
>> +		return -EINVAL;
>> +	if (size < sizeof(*lctx) || size > PAGE_SIZE)
> I would be better to return -E2BIG if size > PAGE_SIZE, and update the
> (two) documentations accordingly.
>
>> +		return -EINVAL;
>> +
>> +	lctx = kmalloc(size, GFP_KERNEL);
>> +	if (lctx == NULL)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(lctx, uctx, size)) {
>> +		rc = -EFAULT;
>> +		goto free_out;
>> +	}
>> +
>> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
>> +	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
>> +		rc = -EINVAL;
>> +		goto free_out;
>> +	}
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +		if ((hp->lsmid->id) == lctx->id) {
>> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);
> There is no need (at least for now) to directly expose lctx->id nor
> lctx->flags. It would be simpler to only pass lctx->ctx and
> lctx->ctx_len to the hooks.

No. Absolutely not. I dislike passing string/length pairs, especially when
they are both contained in a structure.

>
>> +			break;
>> +		}
>> +
>> +free_out:
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
