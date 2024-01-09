Return-Path: <linux-kernel+bounces-20733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93DA82845A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8DE1C23EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900C364DE;
	Tue,  9 Jan 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rTn/ffF8"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6431A73
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 453E2100006;
	Tue,  9 Jan 2024 13:49:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 453E2100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704797370;
	bh=YbVzIoHmYXsphWm6v0Ie3zp7beeYMmz4wikjeVGpQLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=rTn/ffF8tgpJr+04Axnw+wMDBQmQVIC84kSoz8BhSmahgiUKr5VNeskmp3jlyyz5q
	 Hc+dukizmc1pYXwDr+Jx2X+7U+HkjW9jjbzVfbNmgHFXsbyJB96eRxi9k32y1GSBf8
	 z085NUdXRKGaoTdTrQLXw/TZfsnofZu8fKGUY9/C2P+tLQl8qVI4ezIHXFaD+ukdZp
	 faYPZrmmRb501Tn9+0K1zZBYFklPGSTIUyKsi13niz3yYosvLAs5B5TQTbZNwGErY9
	 QdYcDD/+lmobx1JitgSy3dTke0g1dte+qDZAxxEnSvfCLuqTfn3wd9eF8QOzdhxqQP
	 qU8qPIaG9HHRA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 13:49:29 +0300 (MSK)
Received: from [172.28.232.210] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 13:49:29 +0300
Message-ID: <7636f75c-e9b0-48bb-a354-530728073b8a@salutedevices.com>
Date: Tue, 9 Jan 2024 13:49:29 +0300
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
CC: <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Peter
 Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
References: <20231216013656.1382213-1-longman@redhat.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231216013656.1382213-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182500 [Jan 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/09 08:44:00 #23037611
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Waiman

Do you have plans to merge it? Just kindly remind that we're trying to 
implement devm_mutex_destroy() and with this patch the solution would be 
straightforward.


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

