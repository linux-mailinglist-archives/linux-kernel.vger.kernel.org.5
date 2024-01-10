Return-Path: <linux-kernel+bounces-22812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B682A333
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8701C22D40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F934F5F2;
	Wed, 10 Jan 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PLcFdp9C"
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BA4F21E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704921648; bh=l5+KobhWul760UC4b7E+cA9g/7+mWN7ANTqooZq8SD0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PLcFdp9Cj9b3dOtcUx3Z204hBOy09s7ap0o2mkmReETQjHq2TFDbkoc0c8BMmawh7fIUA5V3EWxsWBzb8JaHvJnNr8kZlGyxaPn5atFHlyjShwA6fhS9xZ5ISaeLZvpIVxeEiiJu9EmP7Wx8Y3tLIo/Hbr7FkTi0inyvuZoBojw/BCse5/4BTJxztkUVx+6c7afFoxQ/D6Q31n4rRDoPtbMVvcec/hQnPDLZLbvnTMLyww9blLHI0tgDMPyVjv3IubZF1BHSO+1RuvqNQ3usvJi4JyNyPC6BgYkRpNy5/TasMIL+g574jHBHD1fTO6eTUIwnGRi3nnpfbJvuPlB7tQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704921648; bh=pWbwjxe+fWr8AWOaM9H99/ScF2UjNpawa7nCIFMxTaH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uWAdbu0qthRU1a8ffS1QCG6vA1+JWoXuHbE2Uxq/mBhLb26rwYFPi5hG0FsmBtrzXIcdcqahsJtOkZ1n9D2nq5j2Q++lMlLgI+y54vZDnlq2yNI0TUfeUnLDd4BK84nCSTASGo0ZXm9Jcd6rMLCgWs0Oe1tk8ISmdL3uTuBeIpQNV8nRXNrsUPryPhrAqY1lopy0ubCPTG3cqbqgis/N7LXn3G2c938ebEzMl40PcFFiqTZp5nQAvXLGA8E8heSMnKkGnOyT1+L6NJaMQ3LmyIDlkmxlQob3fIJTkr7yUXmuuRqg/XoUN5f18G9HEMFm9RUctiz75MUNtQ1spAc9mA==
X-YMail-OSG: dyKlW2AVM1leLBklMmzWtrGFpslxD54cNGy0.UbGgc9DjdBDBCZLH_vUYLgn.Wu
 HFaNX8e7S0WsVbwslOqtMHxZNWw94UoA9lsyFanYxvMlWLm503DQa9qgJ48SDhncFl17RtPeHbNg
 NUozce2wBRhuLOGlxYUgUDXeKlpzNWhC4YQTyJp6DuCwWdEATvjGgy_x4ddS6ed5WGNVZL0ckPVy
 iqsXpFMWaSVzQ_0zuMAma4J_gbfJNddjbDLPTxiXyyDiM_0ivx4xznfAy1cIKEm_KwAJ1V0dMsUq
 Wso8pEVF5iHmN75x7PbYW4F12wFzFSOzE1YNtM.DpWq6f4x6IXLSSQd1hoNMfe7UgBOhp.csk6Qi
 Saev27vpNUhEnOO3vfc1mGTmS7pcc9cYiKjNcblQTwXU1_x7Gj_T4bN3w3IjDIaLmCQ9fKKAkj06
 TCKYF4gbTkYajloSZRxdn8yIRv4Heo7Li.dd.1r95bnqD3KPvS8KDo7UlQm14bY69LRkzSkGiYN6
 ovn5BBsXo_d6zfwl05gjsfRbAkoffb9hHY5jK_yt98nemWtY0oiMMx.LYyYryOFGQTyQtTORUzKA
 R_dq8RY3v0QNJnHEfsCFmpQcSr5OS6iGNPli2tqUqQtT8DZBMnQPPlkm5kLppfMMI_dBePvZbPPy
 7RY7b_w5fzRS91tpuajCcnDd87SKQ5EC3O_bBmU6GdsmVZlm9RxsdTHPLYeA1T1q0Cgf71G4ZbGS
 .o87qq3rY9Sj_CF0QEdgqmqZjfrZXnyHzFjT0mr.zgEG36T4BXlr1LecB8uTS7tmRP2KEpaXoYCk
 e8ilhPuWNRr.SAYZ8EFsWLFZgfVd_Mr1gf6_TyBzWpMDNHARnnf06gK96XzGw5W35Zget.Xbot_u
 O8BVznhOMVP6WxGKlVZK2W_YvPKN7zwNENfoKM6GwCrdz86QyFFu9KHnkxf2StBezLvTCQe7pRxJ
 27lstRx5qo9atLmad8r8LQhQvsPIm970rfbOiwYUaLoF21kGPtjpBKbnMy7LG5CnCKCT7I9ItrH_
 8jHt2tkyxkYRZIRX82MALw04HmrCKqY3TU4LpSBCie7GVZomrJNxGvJG8u7wRgWJB.2dG.i1KsRd
 dP6_D8YpFPPOPh014pIFw3lij58cs2_M.YtHHMxUg_JGokvhMZTLEp1wh9pyIJ99ODfO6S9Vq_VV
 wf3.kFrcxE8tDSXT3W3GGVsvKiwMeQgA2v_3K9HDxm_Rs4hvHxlYFyrFijoQP0Mv8WWQLUK1Rh7x
 NEciYKo9SIjbSveCWtN4tAvvUpIya2jRB8Lm3pXVefN1EN1RJglwxl6gTvD2wtooiZvCeeOTLfOt
 KnS_yWywVIBnQdmvHb5y4eUT7VzQ5MxL.6oskLgQCpXF44a3KqMzkSJLDU3Q.UPLNlT8zZTy3YBx
 Y6Dx78SaThbqxDVNZGFIqK4ngswfl148C6GUQNnFfQyC9JrTvr.BoV41tnwTs5Njwi5eYD9kksiU
 vwWfSF_C98pNbz.a6p0dGGzzDkD6U79z8.Nd9waULSSty05PKqOSA5CpYHRuzm8IXWU.hW9kjTnR
 bfEkKIoips39dvtqBc4NcAzklJ2twDtjdtZdUVRYneTLKfe4ldKMO7vkErrIRrbSxuvLVNIgRIE2
 53NGxpasRan04Ih0tWD6uBOwfMjpbxjmqYRy20y6S5Vh.KxEZZFPNijioKk2YtB9LlLHiNGE3xIA
 _tEXHyWMtt6rF67lmVjWxHyVc0EYWkMgRv7lMB2uP9vpZS4dw5mVu8YCsBiSxIutFyKDZWcQ8ZUZ
 NYGvno0XVyOMTUvNAbdURYka.SQevftSgCc.7or5PPyN0gyWfH5dqi5mYge1jwLYIeAFzIvlFZPC
 E5BmXHdLEI8tvBO2B4339tNnmFNYRRYSnS45Ih6EmvTW_fXfJqy.reK0Ez.WIoRkI2Bt98IcDsPO
 MOX17bOz5dLw_nL9hbFmnd6mWBLTC7LC0GbX72uT0OrYKLXut4Yv6f6S24whzsFXt5uVYHv03N8G
 gE.QzGag8AP9Qakd3rP121U9D9L4dBYpGz9.atD7JNUSM2givGehhX8zBizFm_5rnEsG2oHnHzYf
 QPEjUCbAjaBe3X3s8UcqcNgvw86qOi1.CGebU9bN2T2ELpR09Vbfe3TYf17_.Inyav5J4ecFKld0
 gk3UUfTBOJ0EnKl2Fvg0wAU6F7jvBVDoIyZm386vCvUWxeon0yQPiknY8UWAwwNXudpPErNUnog9
 W9jjjjE49Tdt0M5LPLGs8dqTpgnzfWkdVXbeYk8MO8RdZNIHnNFDgeDn7OwFJ4m6tgTdzVQuW7KI
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 490d74c6-aa2e-4de1-a7de-c7dde27d1384
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jan 2024 21:20:48 +0000
Received: by hermes--production-gq1-78d49cd6df-xzd4p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c391b3f137e599abbd26c2364db764a4;
          Wed, 10 Jan 2024 21:20:42 +0000 (UTC)
Message-ID: <ed9a5c2f-2a67-41c1-b72e-a97eaebda1a5@schaufler-ca.com>
Date: Wed, 10 Jan 2024 13:20:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Paul Moore <paul@paul-moore.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
 <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
 <CAHC9VhRxG2jYayjpC=bLuBpfZsXnfYj_GoDBeK527sZWRe0ZrQ@mail.gmail.com>
 <CAHk-=winAVoX=u+uX1Cdf0ekmFHETumRr60rvC_z6jbno0ApPg@mail.gmail.com>
 <CAHC9VhQ6qcPZuL8jE0smNSeCfEbyk+6L0--t0iF4Awh7HHo1Jg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ6qcPZuL8jE0smNSeCfEbyk+6L0--t0iF4Awh7HHo1Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/10/2024 12:58 PM, Paul Moore wrote:
> On Wed, Jan 10, 2024 at 3:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, 10 Jan 2024 at 11:54, Paul Moore <paul@paul-moore.com> wrote:
>>> Thanks for pulling the changes, I'm sorry the syscall table entries
>>> for the LSM syscalls were not how you want to see them, but I'm more
>>> than a little confused as to what exactly we did wrong here.
>> Look at commit 5f42375904b0 ("LSM: wireup Linux Security Module
>> syscalls") and notice for example this:
>>
>>   --- a/arch/x86/entry/syscalls/syscall_64.tbl
>>   +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>>   @@ -378,6 +378,9 @@
>>    454    common  futex_wake              sys_futex_wake
>>    455    common  futex_wait              sys_futex_wait
>>    456    common  futex_requeue           sys_futex_requeue
>>   +457    common  lsm_get_self_attr       sys_lsm_get_self_attr
>>   +458    common  lsm_set_self_attr       sys_lsm_set_self_attr
>>   +459    common  lsm_list_modules        sys_lsm_list_modules
>>
>> Ok, fine - you added your new system calls to the end of the table.
>> Sure, I ended up having to fix them up because the "end of the table"
>> was different by the time I merged your tree, but that wasn't the
>> problem.
>>
>> The problem is here - in the same commit:
>>
>>   --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
>>   +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
>>   @@ -375,6 +375,9 @@
>>    451    common  cachestat               sys_cachestat
>>    452    common  fchmodat2               sys_fchmodat2
>>    453    64      map_shadow_stack        sys_map_shadow_stack
>>   +454    common  lsm_get_self_attr       sys_lsm_get_self_attr
>>   +455    common  lsm_set_self_attr       sys_lsm_set_self_attr
>>   +456    common  lsm_list_modules        sys_lsm_list_modules
>>
>> note how you updated the tools copy WITH THE WRONG NUMBERS!
>>
>> You just added them at the end of the table again, and just
>> incremented the numbers, but that was complete nonsense, because the
>> numbers didn't actually match the real system call numbers, because
>> that tools table hadn't been updated for new system calls - because it
>> hadn't needed them.
>>
>> Yeah, our tooling header duplication is annoying, but the old
>> situation where the tooling just used various kernel headers directly
>> and would randomly break when kernel changes were made was even worse.
>>
>> End result: avoid touching the tooling headers - and if you have to,
>> you need to *think* about it.
> Thanks for the explanation, when I read your comment about "tools" I
> was thinking of whatever tooling transforms the arch/**/*.tbl file and
> not the tools/perf directory.  I should have caught the tools/perf
> mismatch when reviewing the patches from Casey, but I didn't, I'm
> sorry.  My guess is that my mind was just in the "use the next three
> numbers" due to the lack of syscall number sync across architectures,
> but who knows.  My mistake, I'll make sure it doesn't happen again.

No, It's my mistake. I could have asked for help when I found my head
spinning from the syscall numbering scheme and its various implications.
I will have a look at how it might be improved. Sorry to have mucked it
up, and thank you for the explanation.



