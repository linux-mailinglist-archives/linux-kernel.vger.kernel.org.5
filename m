Return-Path: <linux-kernel+bounces-27088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4182EA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E131F2375E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227411701;
	Tue, 16 Jan 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGyolOc4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECF111AD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPJb7cadTIjcWryPVz+kharVhiS/ZoG1eeWlNYM9Uak=;
	b=gGyolOc4kY2tavH0/vQihn9pQcu/zp7INJaopgUMH3XslI4bY0hwMnUgX0cNRa3bzNEWlY
	rAj+Z6r+MkVlHkhop6Az3UYFDVpVDYOpDfnxHUTuxC2SMVDwxJcb1wz6lSu5/UPudGhK4O
	jat9YQfWDI2Kw7ralJnbp9dGwe87CcI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-iiOZ5s8ZNniHQ21THwcW_Q-1; Tue, 16 Jan 2024 02:37:52 -0500
X-MC-Unique: iiOZ5s8ZNniHQ21THwcW_Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67ef8bbfe89so207095536d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390672; x=1705995472;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPJb7cadTIjcWryPVz+kharVhiS/ZoG1eeWlNYM9Uak=;
        b=uf44cT7gLlcVyLzS7fhFCpHTbHn3m0ppajc3mvqVddXMN2y2WpcG5Dj+0fHrBsSI7u
         VMLCdzQkRwWAur1PEJkf7GG8CanKIKAKW53p35tXAoVdUlYbQfhdJV6Kbzu050pcS2UO
         64WcMS8WLTtjyWPdPSnTz4d1okwdOKQhQCSpQjwobqtqp6WnnUvUhNGoNR3RaLUb9fv0
         Ag/ih6sKnD8kvs+VO+HpXlD3/urYOVfxvSsKzBFlFChnvnLiqcbV6UuL01U6v48xxRhF
         yPXHg6WLVkPxLZ6MwKf5sG0kH4YMi3A5juuOTiKATiqhjo0ykGi0soi0uryo6/DGVmRY
         2aMQ==
X-Gm-Message-State: AOJu0YxPA1DFCjYT7four+AFLBcReptM+L1pnqymlAcpDDbPeTXeUyjf
	xeMX/2tNCG2MogtQ1Nin/Zqq4JE3hB+EHNOaKlCpIXaOptFbah2+t58f9QgLmIKbowKmpj8Lvnv
	iAGxlPDjCWdV0CFQlANjm4QGjGaRnbKnD
X-Received: by 2002:ad4:5f8a:0:b0:681:23ef:9b2 with SMTP id jp10-20020ad45f8a000000b0068123ef09b2mr9108952qvb.54.1705390672382;
        Mon, 15 Jan 2024 23:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzNVPOVK5WUwki2xRcl/qqtOEgixBSzvyPbGkgE8FwdFmWowCPeLaA6V4n48GMgyR44mAHFw==
X-Received: by 2002:ad4:5f8a:0:b0:681:23ef:9b2 with SMTP id jp10-20020ad45f8a000000b0068123ef09b2mr9108944qvb.54.1705390672165;
        Mon, 15 Jan 2024 23:37:52 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id mx13-20020a0562142e0d00b00681756b66e2sm28438qvb.35.2024.01.15.23.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:37:51 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spinlock: Fix failing build for PREEMPT_RT
Date: Tue, 16 Jan 2024 04:37:48 -0300
Message-ID: <ZaYyTKgmwsUP454I@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073234.2355850-3-leobras@redhat.com>
References: <20240116073234.2355850-2-leobras@redhat.com> <20240116073234.2355850-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 16, 2024 at 04:32:32AM -0300, Leonardo Bras wrote:
> Since 1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> spinlock.h") build fails for PREEMPT_RT, since there is no definition
> available of either spin_needbreak() and rwlock_needbreak().
> 
> Since it was moved on the mentioned commit, it was placed inside a
> !PREEMPT_RT part of the code, making it out of reach for an RT kernel.
> 
> Fix this by moving code it a few lines down so it can be reached by an
> RT build, where it can also make use of the *_is_contended() definition
> added by the spinlock_rt.h.
> 
> Fixes: d1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> spinlock.h")
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  include/linux/spinlock.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index eaac8b0da25b8..3fcd20de6ca88 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -449,6 +449,12 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
>  	return raw_spin_is_contended(&lock->rlock);
>  }
>  
> +#define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
> +
> +#else  /* !CONFIG_PREEMPT_RT */
> +# include <linux/spinlock_rt.h>
> +#endif /* CONFIG_PREEMPT_RT */
> +
>  /*
>   * Does a critical section need to be broken due to another
>   * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> @@ -480,12 +486,6 @@ static inline int rwlock_needbreak(rwlock_t *lock)
>  #endif
>  }
>  
> -#define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
> -
> -#else  /* !CONFIG_PREEMPT_RT */
> -# include <linux/spinlock_rt.h>
> -#endif /* CONFIG_PREEMPT_RT */
> -
>  /*
>   * Pull the atomic_t declaration:
>   * (asm-mips/atomic.h needs above definitions)
> -- 
> 2.43.0
> 


Nevermind, sent this one by mistake.


