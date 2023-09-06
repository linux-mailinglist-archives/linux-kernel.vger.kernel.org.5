Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7166796DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjIFX6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIFX6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:58:45 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C0C10F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694044720; bh=tRjWz5xTmyODV3eJ2DcADpEY+4F+IbUA23RJut/dyxQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BsoBap4exTpmD0r0/roS3aSJdT4imQBkyc8oQYQzEOjCW/6BxlWAZ77I8N6rTivghAEBT66yf9hKHkb+SIzJX5wgSOnLBImf9eIOY7IL4/aXlsP1nb8JsdtYZAjN7sSBsfr/1vnoh+5hOfT3o58BtP52TBuf+khL4D75vlT897g+/Pw3yqnImFEhdOKNA61zFrPHwujLyD5vQ9lT9neodz9u3X6rMOwoO1ZkoqrZjgMK4lH2687Ly3ncbccay57zTWYpTG2qOGNwO4CKoIr25xEEUgh9o4u0ddPpXbGWpFifdzUa/uKZOu1Ejz1nHbd/btK5MpT2lYvADP+iSYL8oA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694044720; bh=bBRHLP7mwZwJGmy/2IRdLyEn5FKRbTHaC/dAANVk8Fj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MrMYPJcd3XDSVDwfOGzAXjF0/S18paFo6V2iVMhHAt163jg9Q1dxcfkVy7ndt8W68KWnHmJ1PnE+Q+ISJLx07D5OAaCjHbHnF7OLxLSpcl/YfUMjylVhmeo1nQoGU7X4vdOXOmF7z2Wmq6fIxNMcfZkTqtRCUBidFPRrMRyewW5z1/mr222pA8L7RJFfQ6ncngYhBLTIQHDs96ilHNk9o35E8u02S5vSAy2O/ozA4rvU5HZt6ypzCrFatj8H+rsxGpBBnq/ILvDBYlyT52ojx541FwBjckXR7BGw2ovmiV/1pQXCOKpN0LrS7XPYBa7djZBD6iZuE+c7WqwfzBMOXQ==
X-YMail-OSG: OWpzUS8VM1kb_Yu3Uho_kLA18HQLQrktdaWV38y52nuuGpU7Cwrg6PXSeanROFV
 99c_yxnMbXzF8GSvw.6dnlDGD5nDb5_G3r6XUVUgtf7A5Hla_Mn5pU8B52GOIGvLl4IswGvOgRjC
 B8Lkrk63biD9lrBfxn349F1ZCxIU_2vtrT9ai.n34qgcZVG_Oh3bSYTtc6xEgh7V0F0gBw3k4hen
 e5YL7eRqg1VJCbw5jz771ilbN.OXpwn2Xhu55ePXJZhbaBvkYqd.1BGK6GRKboi.a.cj4KynjDkE
 dK3WaD2t6nMW7Hjxhm59xj5Xdba9erpTpmtA_DIoHPGLUz4MalBe.uajjw0HyH2wYacZQzcj.Lm7
 yfSFzz9g9ZXPD22xVCXcWEKzeYBhvT7dspO.eLe3lZYr.gsX6Gqz5r81RKMkq5CjQjGPL_YIpO96
 vUiz_IYmMsJ1ho.OUeAlhnLdUyKuE7WqcbPlaSZwEFu9OmfyMENOfv0and9dmV0HXqYOV_eDY3V4
 F_IeR2nMjanoJ_dkgT0TFpnXRBkgpUTw.Yg7_sEJwBx.scG95_u9duimCD0baTgVJk3rw8SxrrdC
 hylJsxkXv7QjmPkwd7uF.0uFQ3tH5rqBg2oha5_vqrC.LAkJL55Zp9kjRyw2HeumV3MYZ8cRl4l4
 AIX1dC4.08GJDrgFuwltE71dgI_5D4zghcEXidSWDfPkuSXlvRn08FU9f5YSc3mB7oymkPHyRYrb
 F2KZj2QBHXBlErlC0kp4OX1h0yFK5YrilfqXyc2HCaLGEutgD6XZMjTe80cstt4bEZxTCPS3VFd_
 JeC1MEfaGsn6MZi1mV5NyRMThibxjr9QwPzSlkvDeev6awn4Y_EOmoSiejia.i7Za_6nMCOngV_a
 pb25aqxfl2f7qyyc3mE29LWJXXuPy3IHmOuBn.q9QRsxq7xTUZn1r1U80sEyGIRmrWzVaPAavVcJ
 7S9TMhr.dtppbxNIB5MfiFHiOPH3pt2Pb2DhijWZQNFYHcsKyQNWwfDJIXfYxjNYY8W7XAb67JB4
 eYlT.NUOEXmTVO1PH.6A5hYCe0qE.u19dpms2GF6x4QfxN1OHUQorplSBYipKTWv16bRbrlmk8A7
 cs.TnT9qxI8jvta19pJnc0AnsyVR_8ExZCNDYZ9A3_EfYbuzwXJGx9mA72ugKhlQUhTpx1Yv7eE9
 9UQm3.B_aNkDV8yU7Xe5SAT9W9CrleVztpUgf8bo2uvFtfRL207Y8LsjcKs_tuWXJyFfYllIlPOG
 A.wWNH5Et7AoAnjIHqa1V9OuKnPGQRH3S.Ww4dj_puleagfTmUMEBJ37ojCvUpS.2oXE4SJLLKgD
 fZjdSC7NX0xybhoNcWRxWxJjxOhV16UdwLHl..JR7HiDzUhxVZ86oaOurwQt1eEJOjXOIPo1Q7JB
 UAnIelZN25zlZfRc6TwIso_rpN6mruzPn5i0nYDYdFKKYMrK5Q3.wWTmiqGPKGSkuqgQAvvAXhUs
 0.ulNGqagUSgnvKi_08lslyB8dJKdM.ULQUF4wFZXn8SSAUTE5cPn6yabMplIDH4eHQ3lGcZlu5V
 qm4XP3E5xe6RNg7qzPz1thmv73IzJ3hw0q7SsDmvTbCpvBgnEfwWm4pv9fSAWPBixHUmnv92m2OD
 fJVUQ1zwC93g_clm9PWKpQIg7lWy9QcSwnIEjHTwxlcNJCY7eP.hkPM3TqBjpTOoIgIbxEp6P9gE
 soLAJPKJKUg9rzOGhVCAS8.AIiACsXbqN6dWX7amz4hQ5k2.sFj8_CnwEOWmm4bSOb69uvZHCGDS
 9LIX6NpZUihmCYXkxDCefx3malHkXQJE1XKwxfHhiIACKVGEm6BO_m3.qO.TZG8yaMI86PjyOcmC
 yw1v0LYgJs4qZ6SD7oTvXUkVoIPITTGEtHHhDdVRrv2m52KC7ZteVwpQRCnEG5O.dWNM4lZ_nO6D
 B_rhr.1KSELkI.pzpWksyAd9m47l9Dm4idJ_8tGbv72cA9AVG29KwXbfdIJUz8KfPhHBlTrccuhn
 3apGAS_UDYH8pmcWW8pDZWNTeOm0LV3f9ChxWWklBAgXy61KDLrbeEZEE89MNvFhAUxyFWm2clQo
 ZmOZeOe1b1jCG2uGZIPDwwa0xN9OOvS8Bv.0cPcGrXHzSmSSvahlDaY1ddFCjYeJVFB9XLbBo3qz
 iWJUUt4XElxbG.BWG7aX9kmF.4F.tL1wlwCw4BZAxQEKjwBU5leZvy95.EkkMGujgVVwt2EtkI9D
 pGF1W5RYyemrzZicbDC3xlKnCZBRqV0eMVU1eLMvBixVRrjmeYbadMOZ1nQ.6o5iy6pb358UQOmE
 xE_Im1wHRi2x1G.c-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9a27b2be-e813-4ee3-ad8c-a0d353044ee7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Sep 2023 23:58:40 +0000
Received: by hermes--production-bf1-865889d799-5m62n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ff25f29cdc434fda842453459ee2cee;
          Wed, 06 Sep 2023 23:48:08 +0000 (UTC)
Message-ID: <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
Date:   Wed, 6 Sep 2023 16:48:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2023 4:22 PM, Paul Moore wrote:
> On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
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
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 82253294069c..aa4ade1f71b9 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -3798,6 +3798,152 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>>  }
>>  EXPORT_SYMBOL(security_d_instantiate);
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
> Should this be something like the following?
>
>   if (flags & ~LSM_FLAG_SINGLE)
>     return -EINVAL;

Yes. I have a fix ready. There are a couple other touch-ups, too.

>
>> +		if (uctx &&
>> +		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))
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
>> +			continue;
>> +		}
>> +		if (rc == -E2BIG) {
>> +			toobig = true;
>> +			left = 0;
>> +			total += entrysize;
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
>
> --
> paul-moore.com
