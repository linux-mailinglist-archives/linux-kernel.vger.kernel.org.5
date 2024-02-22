Return-Path: <linux-kernel+bounces-75900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9785F073
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600FA2844F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F51877;
	Thu, 22 Feb 2024 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvTeefyT"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBA10E5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576440; cv=none; b=pVRtG0msYen6HRQyWlM3/oIpN+isUeJDVvZgMueOc53F/x+NXRnb9bULfiPbTR40mbVlMDt+jWNuYSPEN/cZ5G3B61v7cvtmTGHYLRW+TAngaxbDOoGKIoQzxNPs8DcNPCVkotWnfzK+UqcV2+uRN4Zis4rWidnjP28YemPp4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576440; c=relaxed/simple;
	bh=sVXz+f++d53qtpGRQym7t+k0uOPY55Nm6vRJJjr/34s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+AcvGnAXmyS+Pbw/b567NjmbWNKJ9pq1XuwP6wt651EYIN/8dGqey8dkG16IznjPyyEu19O6fLKIWeUnlUiFvQZGJAV+b6r8T08FTP5cl4R8/3GQtrSlDLGg4n+iCXH6TSOaQpC8WlQspGebOMRfiNEu1jsH4VRKrlAYeK7WPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvTeefyT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42dd9dfe170so27109891cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576438; x=1709181238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3tpSfmR2x5ajWcVpUjqxqmwx2Kltpoj+DQ1nUuQVkw=;
        b=lvTeefyTUikmN06rH26k2UPF2ua/d3TcxZmK1OVhQcLSHPX2YsAVrHG+YHETuhOGTm
         6gpqrJ3pHYeX7fHZJ6cqBMWb01L7xxsK3hQetcSFgXNdZ1ZQnUVEUDnh1JswXbhEWVaC
         KKqdz323fSFsnkfvsbF3xuJvuWP/+NhM4OhIDgnmSQo62/5oZvxuT8yq+W5KTGPVHGLZ
         UH/FrZgGsYmpbFG+g7iH8ENKrhBIpj1VSWEvmJiaPx6unVLv6uIwPpXGsgTUXxN09Pm8
         lpv4whM77fWd8a2HvaEKeFxz4Y7wB3o1vzGrAUouTLKAgWv1n6ZdAV5OybBglxirMQpV
         LFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576438; x=1709181238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3tpSfmR2x5ajWcVpUjqxqmwx2Kltpoj+DQ1nUuQVkw=;
        b=jogQTNPijDubvpgwsOaopgSrU9+ofCK7JHUtdckWTGTUpiugLS6orIcxOU6u4/e03H
         3AwOCzmgp+Yx1ro3RPOZCl7gE3pZDMf0mHkdsw6EHVvg70BNCqcG7sZryyTe+Qo6YmcL
         O+ZN+3iIewca5VI9bS/LkVEwiT37RCxBgR2VBzLM1GWiJHcjL+jztq1+5T2orQwzgTpo
         BBxorI+Owpk1RC2f2RNQ67wRPDjSgRZX7XkCkviLRBZHmCxyayj5JjVXP73t37OW4lRq
         IT9oz0jHixsjbWx345FPCecHPWPH4pb4hRV6ut9UQVroLDRlOBdqzo5qER+H4atC38i/
         WJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU11/JrXFLD2HhDYj4nNl9BypWRZP/Q+Lttg9lOfSboCUbyoGvNN+GAvKe6qmblYdBCzcu7Lv0rQJNi7btyL18ffgasVwYc9JJ5gciI
X-Gm-Message-State: AOJu0YwRzxQDj2aD5y32qX5cH3SDY8itNZtPmmhvWjL81XpJnMM+GfF0
	CdpHbedokh2QpjM/S/MMF3v0aUMkdxpO1S0i75lxMgW68irI3T00
X-Google-Smtp-Source: AGHT+IGGkD1p94lcW35/7sSCMJ4JChYFCjT5srkogfhp15iaswCVc7Si4PlNoj2OFjtmswkZi4I2rw==
X-Received: by 2002:ac8:5ad3:0:b0:42d:b5fd:3fca with SMTP id d19-20020ac85ad3000000b0042db5fd3fcamr19867293qtd.31.1708576438140;
        Wed, 21 Feb 2024 20:33:58 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a8-20020a05622a064800b0042994b3c20dsm5012742qtb.29.2024.02.21.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:33:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id EF1B227C005B;
	Wed, 21 Feb 2024 23:33:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 21 Feb 2024 23:33:56 -0500
X-ME-Sender: <xms:s87WZZ9vpl2EAU8QFGQygW5Za58jW5faATQYOqbXjC8y-16hhbj98g>
    <xme:s87WZdt8sHh7RJrK_EQYk96sHIB3zf9tmXGPhQv4k7_Tp4neSBRTcZWH5C7pSrmmx
    eEbcEc9F8V6oLmzCQ>
X-ME-Received: <xmr:s87WZXBDlu5vqNzX_63c_cKOaOGAdQPdaIenONvYz5NuBiwXecLyOwqgfQM5bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:s87WZdfCtCYLX6Y4RbbY4cWBP341FhdkkGtT1ps9PKhj61CiwsKiDA>
    <xmx:s87WZePjey6VsbNHWeM_7oZ8tjg1CnbPqoxymgQYz4W042Tt_QnWXQ>
    <xmx:s87WZfmVqImUICshbyFmg_A7fi6yeM0eDagMyoJ7-vCyuUFQlPOE6Q>
    <xmx:tM7WZdfzbqvcFBLE-NhU-qj3J96bKshSlu6eK-uNYLaM9IHcm_TM2g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 23:33:55 -0500 (EST)
Date: Wed, 21 Feb 2024 20:33:32 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH 2/4] locking/mutex: Clean up mutex.h
Message-ID: <ZdbOnD5NzUDdNnDS@boqun-archlinux>
References: <20240213031656.1375951-1-longman@redhat.com>
 <20240213031656.1375951-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213031656.1375951-3-longman@redhat.com>

On Mon, Feb 12, 2024 at 10:16:54PM -0500, Waiman Long wrote:
> CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
> can't be both set at the same time.  Move down the mutex_destroy()
> function declaration to the bottom of mutex.h to eliminate duplicated
> mutex_destroy() declaration.
> 
> Also remove the duplicated mutex_trylock() function declaration in the
> CONFIG_PREEMPT_RT section.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Although, can you move the first "#ifdef CONFIG_DEBUG_MUTEXES" out of
the "#ifndef CONFIG_PREEMPT_RT" and combine it with the second one, i.e.

	#ifdef CONFIG_DEBUG_MUTEXES
	# define __DEBUG_MUTEX_INITIALIZER(lockname) ...
	extern void mutex_destroy(struct mutex *lock);
	#else
	# define __DEBUG_MUTEX_INITIALIZER(lockname) ..
	static inline void mutex_destroy(struct mutex *lock) {}
	#endif

	#ifndef CONFIG_PREEMPT_RT
	...

Thoughts?

Regards,
Boqun

> ---
>  include/linux/mutex.h | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 7e208d46ba5b..bad383713db2 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -35,18 +35,10 @@
>  #ifndef CONFIG_PREEMPT_RT
>  
>  #ifdef CONFIG_DEBUG_MUTEXES
> -
> -#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
> +# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
>  	, .magic = &lockname
> -
> -extern void mutex_destroy(struct mutex *lock);
> -
>  #else
> -
>  # define __DEBUG_MUTEX_INITIALIZER(lockname)
> -
> -static inline void mutex_destroy(struct mutex *lock) {}
> -
>  #endif
>  
>  /**
> @@ -101,9 +93,6 @@ extern bool mutex_is_locked(struct mutex *lock);
>  
>  extern void __mutex_rt_init(struct mutex *lock, const char *name,
>  			    struct lock_class_key *key);
> -extern int mutex_trylock(struct mutex *lock);
> -
> -static inline void mutex_destroy(struct mutex *lock) { }
>  
>  #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
>  
> @@ -170,6 +159,16 @@ extern void mutex_unlock(struct mutex *lock);
>  
>  extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
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
>  DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>  DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>  DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
> -- 
> 2.39.3
> 

