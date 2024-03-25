Return-Path: <linux-kernel+bounces-117479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8E88ABD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6E2E803C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157682D83;
	Mon, 25 Mar 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnselrVa"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A611190;
	Mon, 25 Mar 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384539; cv=none; b=DFu6Vr4ce7e4DmTSav2OPvdFL4Z5OY3GQbi5d49jvKg3Mo/gysWQIMgsMmMYW4bRdUSR4TTsduT4UYcTKnhrny/sxtXKWTuolzUvqSLYXSRJADvWKTQrKqWZRwYnbD2YEJdur3sSIMk5yYkxPDyNo40xAPGwHNIXCL5Vt7LQ4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384539; c=relaxed/simple;
	bh=DKXtjIJMfK0GsHhFxZ4sUuSiShL/f1Nn/zJ11TOOI8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89rkuRRoqwRxU6Lfm7RiXqKn16aYSk/J82VTepfr9HKUSzafAxqw5YIYNEfpA/wpd7K4x9T44Ob26sj9d9+W7kjqJshze2+dT0tfc2vEYfEE+yHF4m+qdJDKTsbi3+XXGR3A8azUmiwLa6+VzutfLgJYv+JVWZiwq1JhVVYFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnselrVa; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430dbcfc2afso33326551cf.0;
        Mon, 25 Mar 2024 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384537; x=1711989337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9xcZb/gco33wzCgRnGopr7VfxMhSDEYJqdrsUjuBgs=;
        b=cnselrVafFJP/zAj7/pnJCQuurUc7UFsozMGxxve9yqNEk+zjfQzShdSDyCQB7Zcip
         M/3XiENIPduA/EO1DA+bJyZHFhZc1mIbS6GosPBZz9sn9P0o4vsFZkmIu2PrBXqHRcdM
         HT0BTptYmhCpP/WGiIU/6VR0bHwNOTYChD7ynYGC2F24fnxbBeMK5UKJNaavt0ETevvx
         CjKQibQjWTpFo9/VC8KIi2LK8iQUlOy10JqsYsmyfHXAvHT7ZcOtRrfVbbA+wnc03roq
         +076Rz1K8YMf6QV4v8/vG6AiJl759dP6dWi1XTT2vMDBp32JBCjTFTDBcp1ihhR/ZOCY
         /tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384537; x=1711989337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9xcZb/gco33wzCgRnGopr7VfxMhSDEYJqdrsUjuBgs=;
        b=MNE6TD24N/73JHG4+5sC3+3+x85R61RmWotkqF2JWTytI2bTr7jTfuV1YJDwJpV/vY
         UwYoAaESYtEXwdpI4/8GegzB49SSHARyu2XfNOuXFgj/MOBc4P7qWq+JbwhTQ6YED21Z
         63U0WMnmgJBwsVYt+3G93BcaPEVnz3wK82nrE9Fbz2VNa7873td4h3eR7cpSSJenFSFQ
         g+iQS1sUab9o4XCZA8+tuUmFrdXJglbXdvhYW0q5EQPWlRey6d9XqNrrCKat7CCli8Wt
         yMDBlQbBU7JA0SQ9gtiJMekL/H/4ZC0YLQEjoYWazyBMOI6e4HVAVvfKYbc14x+edVNv
         QqFg==
X-Forwarded-Encrypted: i=1; AJvYcCWV/Fmik92HAeET5mr78wkOT5o4Io8BsVb4OYln9INmdn0Jp8nULpIQFR0x6sNgjwwA2i3pK2xwCg+pmWDKnmomovtXsie4zwQefzk5
X-Gm-Message-State: AOJu0YzI1DelAop/LxWQ+tGOLLLpZe94NK+rpk8elOeEHeqPy9L880OA
	YHDo8KLyrTX/1aW36SYBpcUL0mtRiKM4EAHpzoXPWqU76iAiLyet
X-Google-Smtp-Source: AGHT+IE8/dhtaRnZrATkRFvqI+iD4hGEw2Wg6wmrap3LBrZL1UPFU+53Ey4psccvLJBkMmtsybQBhQ==
X-Received: by 2002:a05:622a:cf:b0:431:3fee:9d53 with SMTP id p15-20020a05622a00cf00b004313fee9d53mr8248578qtw.24.1711384536887;
        Mon, 25 Mar 2024 09:35:36 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id ch8-20020a05622a40c800b00431662b2309sm225534qtb.62.2024.03.25.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:35:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 772651200043;
	Mon, 25 Mar 2024 12:35:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 12:35:35 -0400
X-ME-Sender: <xms:16cBZhQbgycrhYqMzBSgY6OTMGxD5PhtTHL21kO69BOm52ocEIwOig>
    <xme:16cBZqybjDPUyRJPP2rZ9ZCWsHU3KWYx3XbZjzuaD1xx3vRp_yLb0hXfuDeyFAnRv
    THo6t-471Xy-S91Mg>
X-ME-Received: <xmr:16cBZm0oq-j0kX4JwHuh6VVDAKizXAA57R_5jdM3vGqb1PhwoD9NI8p_0AbVcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:16cBZpCQkeY-erVVOW5CqHIkB_tRBpgOLVtA6nk3_KfxZISAlzmEAA>
    <xmx:16cBZqix31RV1qSKJ7IQp4vmfPvz1YRO09wexkg1R5E84Kebu75AAQ>
    <xmx:16cBZtowohSejjUyGXCNZCGIo9RoS-caETW1YLLEQknbP3z4kMx0jg>
    <xmx:16cBZlg6iAhSmNXlpacNrrRallYKryilzj2OfkmKnl0fmY_kmY3muQ>
    <xmx:16cBZlP1a0wCROPcG3Th0PejdZNg7u4j9aw99pmqRfJSC1jMXxCy5JKWOy8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 12:35:34 -0400 (EDT)
Date: Mon, 25 Mar 2024 09:35:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <ZgGnuFJiTX5laS7c@boqun-archlinux>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325101626.41584-2-johannes@sipsolutions.net>

On Mon, Mar 25, 2024 at 11:16:27AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When using "guard(rcu)();" sparse will complain, because even
> though it now understands the cleanup attribute, it doesn't
> evaluate the calls from it at function exit, and thus doesn't
> count the context correctly.
> 
> Given that there's a conditional in the resulting code:
> 
>   static inline void class_rcu_destructor(class_rcu_t *_T)
>   {
>       if (_T->lock) {
>           rcu_read_unlock();
>       }
>   }
> 
> it seems that even trying to teach sparse to evalulate the
> cleanup attribute function it'd still be difficult to really
> make it understand the full context here.
> 
> Suppress the sparse warning by just releasing the context in
> the acquisition part of the function, after all we know it's
> safe with the guard, that's the whole point of it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/linux/rcupdate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 17d7ed5f3ae6..41081ee9c9a7 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1090,6 +1090,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  extern int rcu_expedited;
>  extern int rcu_normal;
>  
> -DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
> +DEFINE_LOCK_GUARD_0(rcu, do { rcu_read_lock(); __release(RCU); } while(0), rcu_read_unlock())
>  

Hmm.. not a big fan of this. __release(RCU) following a rcu_read_lock()
is really confusing. Maybe we can introduce a _rcu_read_lock():

	void _rcu_read_lock(bool guard) {
		__rcu_read_lock();
		// Skip sparse annotation in "guard(rcu)()" to work
		// around sparse's lack of support of cleanup.
		if (!guard)
			__acquire(RCU);
		rcu_lock_acquire(...);
		...
	}

and normal rcu_read_lock() is just a _rcu_read_lock(false), RCU guard is
a _rcu_read_lock(true)?

But before that how does it looks if we don't fix this entirely? ;-)

Regards,
Boqun

>  #endif /* __LINUX_RCUPDATE_H */
> -- 
> 2.44.0
> 

