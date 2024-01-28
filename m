Return-Path: <linux-kernel+bounces-41885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC983F930
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F0B2183B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96492E85B;
	Sun, 28 Jan 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SKc0ZbB7"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE02E633
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467412; cv=none; b=HkYriH8dxRHRnavb3KmImTikUkOvp/YhhH7q4nc0DJX/D/99gmLABN2r7lzZtG1nWjOlqvL1BwDs7mnc2zSVybP/cEAcaT877614B77OZ348NCLhCoFUDul/zxMAhEn4NbU6pft3qq9Qzn0i57cGJjr6uu9wp+YLzKlb2LxbRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467412; c=relaxed/simple;
	bh=DxOxHX+CWe5H/6b5zX6ree8j+/K848dPV1IDUPcRTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=p5wVLUzN3OlBEm1Y87T7m5bHYyTtK2Q5YAAsHbTReLDnn5jOrLlVckwwVkSbGknQNrKqknFdVibm5+OUHNK4ArwT6pUZgCmZVnge2kCxow+FbNQKVpbwR7ZyIsUg1o7s8LuzrLTZwfoEGoaHqUfjPqR+Tu4dpFb8lGMvapckEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SKc0ZbB7; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AA7E6100004;
	Sun, 28 Jan 2024 21:29:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AA7E6100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706466541;
	bh=OBNGnVk83D4kYszuDG/0LrM2sFda2G2iLJdHMllKaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SKc0ZbB73SXdNh+AFN3yA/uyQqCSi8ZkBGj4MG+rNcjmdjRfDR7X6Wh4FIDMKcVAf
	 JjPIuN1mgaueGvnpt3u8SxiYi/QALqH4oDRJIouAoGpoT1YlKaCRiDrO4o+F6AaFjW
	 TDvWe7WjuOYdpAiNYcSDvlznLeB19GZqrPZlb8urBqd3caBe1SLD1wXr5k9tUnSEKv
	 b0uhW8Vips9QrEU267JMyOPzl/2mo3RbrHOU1sDIG/x1724wFpmVfm23sGIiuGAkIU
	 byaqAveOcavP2W4bGQ81/F+kvgGx4I5NgU5fvxHXs6CphZAgbBIwg371YQOzyXI+g0
	 bS3OI8W/UFTEQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 28 Jan 2024 21:29:01 +0300 (MSK)
Received: from [172.28.169.34] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:29:01 +0300
Message-ID: <8be5bc9d-9505-41c6-b2ca-654bfe1d809f@salutedevices.com>
Date: Sun, 28 Jan 2024 21:28:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/mutex: Clean up mutex.h
Content-Language: en-US
To: Waiman Long <longman@redhat.com>
References: <20231216013656.1382213-1-longman@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <gnstark@salutedevices.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231216013656.1382213-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182981 [Jan 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/01/28 18:12:00
X-KSMG-LinksScanning: Clean, bases: 2024/01/28 18:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/28 16:20:00 #23573603
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Waiman

Sorry for disturbing you. I just wanted to know are there plans to 
develop / merge this patch? We're trying to implement 
devm_mutex_destroy() and with this patch the solution would be 
straightforward.

Here is the patch series and discussion why devm_mutex_destroy()'d be 
helpful:
https://lore.kernel.org/lkml/c709e0f33da06db40127f3a0adcbebbd@trvn.ru/T/#m885a348ea3f7c8d9a30bcfaf025a08e053c02c18


On 12/16/23 04:36, Waiman Long wrote:
> CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
> can't be both set at the same time.  Move down the mutex_destroy()
> function declaration to the bottom of mutex.h to eliminate duplicated
> mutex_destroy() declaration.
> 
> Also remove the duplicated mutex_trylock() function declaration in the
> CONFIG_PREEMPT_RT section.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   include/linux/mutex.h | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..f3ae911580bf 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -77,18 +77,10 @@ struct mutex {
>   };
>   
>   #ifdef CONFIG_DEBUG_MUTEXES
> -
> -#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
> +# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
>   	, .magic = &lockname
> -
> -extern void mutex_destroy(struct mutex *lock);
> -
>   #else
> -
>   # define __DEBUG_MUTEX_INITIALIZER(lockname)
> -
> -static inline void mutex_destroy(struct mutex *lock) {}
> -
>   #endif
>   
>   /**
> @@ -151,9 +143,6 @@ struct mutex {
>   
>   extern void __mutex_rt_init(struct mutex *lock, const char *name,
>   			    struct lock_class_key *key);
> -extern int mutex_trylock(struct mutex *lock);
> -
> -static inline void mutex_destroy(struct mutex *lock) { }
>   
>   #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
>   
> @@ -220,6 +209,16 @@ extern void mutex_unlock(struct mutex *lock);
>   
>   extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
>   
> +#ifdef CONFIG_DEBUG_MUTEXES
> +
> +extern void mutex_destroy(struct mutex *lock);
> +
> +#else
> +
> +static inline void mutex_destroy(struct mutex *lock) {}
> +
> +#endif
> +
>   DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>   DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
>   

-- 
Best regards
George

