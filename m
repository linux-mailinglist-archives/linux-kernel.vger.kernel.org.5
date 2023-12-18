Return-Path: <linux-kernel+bounces-4219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FF81793E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D7E1C2415E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24D5D746;
	Mon, 18 Dec 2023 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SNJgmnkT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530845BFB9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702922066; bh=xu+gxgVbINDvBxq7UqsA+Q+MM170MmIrIQ86tUk5Qo4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SNJgmnkT8VAX/gzXZb5FOZf1A+sBnVzFe3toujzQ64fy2UexwVzZsO5FrUND/5UnMJD1ms2XjMDOVE+P9LpVoWNQoa6zOB6BfcFQ5d3UFgu1h6u849LrajCX6avoJENL+HGLf/kZTh4vRpKrPVJwwm2GVRf2wrd3TGRJEPqS7REsZiyVc2oAy/Vel2WqgOGXK0TiPFkwSTfYTBH44AfxTx7jpYhKVH497CZJ1FzVfZIFP5lgWArPAJS77yDBkcZDWuUXc5+1ZDL6ZW0FVtGVbWdqSwiYDSb2cpfvMxUP8LptPKhM0APS+k24+4vwtivotoZFckNlLq5uKYC41P7zfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702922066; bh=yx9ePzsTtYb8E4QZ9/KDNGdmwapjpRai4mvg+R0X8OZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uI5VDjpa+bp5op2iugJV09P7RC4W3SdUyzqI+DDjz06eTfjVi2NtzpDZZ2+y7HSiidYzLy10LMbTv/e4T8i+A+UaDbNxu/a9l1s5th2DiPnh1LZv1JoMA+5onhE4QJiEGBNsN5qNaBY2eLW+IIUS9voUEsZIK406mwzxtr864tkeV6sOU/IpXA/ZS+UCo9oCnyTpI7q1vnRsCiVcJ9ZRFPzRif3vKSHpRU8613TWNYOpwxlbcwIyNUBVZ2svO+HvWdNtZKBy8HLOFu/xWKDAo5yavdHy6l+uA5MQgpmyYFrB6FJlfKJqfA2rEO2rwjRex32AiniIGOeRnxTepSj5PA==
X-YMail-OSG: 2cvT6jcVM1n4hW_KV5Kua6i7GP3IFU1TFwt2inIFHQQX3D68KGDu30WchiBvvdC
 YGVie9.er5KpxVuH5hTCjNBJp78FOz7aAqMTsJU8XKfuO96FO7eOmBntZkwOzfhRxdiTOKdt866p
 6QVJ.HJiC64.oW4LkRF_W2YBj97_OQcOtLtZsrJktEhGY5XrUR8bmAh4R_WurVJEPTH5xoiqY9Gc
 H0.KKoWC1vOvM9UI17b3R9Ajb5ELveqyjnu7Bo8pV5ZWF3rCeyY2fZtQdZ6ecioChnxLd.NyYMGT
 OX.4fIenNW4l80n82i_6L6U.89ygb2uTbmd2jPFfL4iUC4mYkZE6vHrUSJExlyP7WYkli3e3ZLs.
 0Xz_ReVsvOqnAxrEd5H_Z9Yp9WXZBYURxu1TpxEOtoU75fGbFty4MHmLymQThSz8UhJiXCcQTAik
 AhmJEPPEWksK1RMCGu6sIwo_srcD5zW9EloE46lLljNnFpWul1WNle.1gl0HeHDmHF63jQEkgLVX
 diW5WseoD9DiBCEyEADbS2Sjdhn9sbl.fu3Z1i.LPMYgRvVSXcHTOeTBhE8AUa44D.NtewlLDCPL
 sMeQnSG72wLJfQNK7xQoXKEXJ8pMGcFEe4tqZvNNnRMdMy6XrB.n6OsfW2ccjhk8ReeFCrFd8_S7
 ed42i1JpC_slzFdpw1qwg9sqV1BsXDry_qvvBciMqi99FWupdLCmlSHDVUtJCOL2uyaO2T_qU6Rt
 gfnrtKoUPI4uuQn7aSswz.hBuKxhDoedxv3janEuwxLi3qwzJJjQRxqTn8DfuQm.ez4hPwGsWP3Y
 6MABeiFZKdkg10VH8e.3so2a2p5HT13pwSLc3tCi4zyQsMR9bE2Oy2mLPSQFN5GLesg4F1Ilvwgl
 SITCMqgVIZBY4jZOPEjPTEclT13wk4lbwA3o1cBtnlj2leqDHrW5UmubusGDfdGNXv0habHckQiq
 EgAbHdj3EfF_USvefwxZyg3Puev9No6EZxarPDbv9WcnYvRrVUQgG62l0goagi.82vsidmKWg7fw
 iPq.he4Ouym_4rUxeU3oYrjbO8_AUTOhU180V1PuYSVDy6GEvta70AuugEkWL1j2D91KaMsNvlxz
 TEfICVln0Z3ipZLSMVGUWX6599OXzuOuUMoHsJbMhd8H2gxnWmAhvIm.Lqdv7J4Jk.VHelU8tRu7
 WD3U7XOyPpgQVFM7BOA.RDFIfhDQ0ab6bqSafkonigTc0bf_7kX8Am3OwfPlAV8blWpFLcHor8Bi
 qsj49LR9znZX6gYUKNQNjs3wF.FkwWKLE..k_HJLWa_aqlIMB2.hmMuxYvfVU8_IEbKJ7BxbOKAR
 9KrRlCfeLA9ap0gYk0St8X5xBywbPx93mh.UzKtlqBuKdcsRlfHgRUgIbf6S6y2tAp4_12eb.XA3
 Ejy3yZplArOY1sCd4S.yQ4Iz7.F1DtYYt5txe9NQ5QaDTD2usZuJG9eW5JgSWi84ZNiF3hkjlURU
 YW7BHqgyaGyfpMf2PXUWidinboKQwzX0aiMTRLL2uHJdHOKhPb9tR5PxUwuvfgycL8XQRudOVcSN
 xsd71ljcADQgmGLocRxQ.Y3nzS3sAfoOkhFJaXvONh._fVD5y.Fg7jKuSO9mRQ.Mb0RaYe1kFeqd
 rElOcA6iHP4pCGh_pQh_kya6dWgFU2OCLiaKJM8uX4GH.bocboO7ovhBvKdvucn1nrC5h.H82uu3
 GSedheKQxpdCec1WGIVlhGUDdvHgwdyIoezdl_JiyRY8rBmLX4g.9K3s.3_qmMewS1hWUlWVql1x
 A3bGmGpNJoM8nJ2Rg.CmEqrBvwTyHOJOy_AjFaGUboslLjVIGhzCMiBVI7Ym1GIm4CwPJG4I8b9m
 07ZACXNQ1GYf.hIvMAKt_yV1BiL_q5vSto2oZ3S_RbRgi.Sgc4ezmbi0PX4ovdqdfa0IU049JR3y
 dfL5bUg3jEjrO.nAl72gx46WrCvGT_VAlxKYb.e3zzPwtMvJX6s4nNpLtyDJz9FMhUccs8JSGtJt
 UMqWOpyx65dJYLAo9S.gUqbP0nOB4u3K8rIlMEI7IMwrqNbDzAtMMDJAMhdlIVzThOJbMpUoD6nb
 6PZ4vmOrjvALN2cT7gAkh.Jyks1O8.ANpLVQqlHuOPMVXdiQ9WkRPK4ObioPmI3fEZ6DQ4N_2266
 GmB8g71cmwHUvluaKKJVjAFYjue5Vspd3wPa24FwHItigkZLkSF2uRlXjZzW1VdjQG6nZpUeaKP.
 ISGMpV0mYFEUNv1Y2qkYmGeQqDEtJeeP2BFf0iuYo1PYqc3hX4U7ZqzLuokeHiL_eq0AsjLYsOCj
 E0xnZAhXp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: afa4c637-5a35-4b8f-8140-52bd182b60a6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Dec 2023 17:54:26 +0000
Received: by hermes--production-gq1-6949d6d8f9-x28h5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a479ca567dab365b133a6acbdb5eb595;
          Mon, 18 Dec 2023 17:54:20 +0000 (UTC)
Message-ID: <0a392ae2-9fd0-4a13-a4b1-5454b17701bb@schaufler-ca.com>
Date: Mon, 18 Dec 2023 09:54:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Alfred Piccioni <alpic@google.com>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231218141645.2548743-1-alpic@google.com>
 <6dce3020-14f0-471b-9b6a-c9dc761cfa19@schaufler-ca.com>
 <CAEjxPJ4tZAvch50i7Ve_7dPYUzCXK8ckDtmhwq81vjCf7pweQw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ4tZAvch50i7Ve_7dPYUzCXK8ckDtmhwq81vjCf7pweQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/18/2023 9:36 AM, Stephen Smalley wrote:
> On Mon, Dec 18, 2023 at 12:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/18/2023 6:16 AM, Alfred Piccioni wrote:
>>
>>> Some ioctl commands do not require ioctl permission, but are routed to
>>> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
>>> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>>>
>>> However, if a 32-bit process is running on a 64-bit kernel, it emits
>>> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
>>> being checked erroneously, which leads to these ioctl operations being
>>> routed to the ioctl permission, rather than the correct file
>>> permissions.
>>>
>>> This was also noted in a RED-PEN finding from a while back -
>>> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>>>
>>> This patch introduces a new hook, security_file_ioctl_compat, that is
>>> called from the compat ioctl syscal. All current LSMs have been changed
>>> to support this hook.
>>>
>>> Reviewing the three places where we are currently using
>>> security_file_ioctl, it appears that only SELinux needs a dedicated
>>> compat change; TOMOYO and SMACK appear to be functional without any
>>> change.
>>>
>>> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
>>> Signed-off-by: Alfred Piccioni <alpic@google.com>
>>> Cc: stable@vger.kernel.org
>> This *really* needs to go the the LSM email list:
>>         linux-security-module@vger.kernel.org
> Yep, pointed that out a little earlier in this thread.
>
>>> ---
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>> index ac962c4cb44b..626aa8cf930d 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>>>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>>>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>>>        unsigned long arg)
>>> +LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
>>> +      unsigned long arg)
>> Please add a flags parameter to file_ioctl() rather than a new hook.
> Paul told him the opposite earlier.

Sigh. Paul's wrong, but as he's the maintainer I shan't push further.


