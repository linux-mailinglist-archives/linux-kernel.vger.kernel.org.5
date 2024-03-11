Return-Path: <linux-kernel+bounces-98731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A4877E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275E71C2163E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368323DBA8;
	Mon, 11 Mar 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjTcO6QR"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44273D970;
	Mon, 11 Mar 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154635; cv=none; b=nR1tXoczWGuFcpA8SPcUSN9apf0YBcMSefGPD8jAqnzym8vOK0JwwfJNg8xpRp6bojwvhKmi21TnzMpfdJrXwS+rpsomxCaCIUzlYmWitDmdxwAdlOaB6e79zCcYc4yzjuXAzTZkXEaQKMeZvAiQkPkhQmCeijF6x0PmuzjYI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154635; c=relaxed/simple;
	bh=ruIbWDbGWHQyV0jlvj/gD5/cVR1JSgtm1GcHOPtzuSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa/kNQlcyJTkQnksc2fXpkOLVzKnwwP0zidaBQRqfkSamIIHANHhwFRYP5nvUSeNN8BjBys0WeFIwCgsbNvdRLgK5ppA2/XgqNisyidEhMS5n/bqBxfCEuqnwIslmgJMvv9DdkewqsDdeCKwMTjHJmxU1v13zMj4KeT5gUyyL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjTcO6QR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513a06ef9b6so1992829e87.2;
        Mon, 11 Mar 2024 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710154632; x=1710759432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuFmZeg0UoxxqK14pMwKTOeuM5ft4agwVZ8ZknCI34Y=;
        b=jjTcO6QRT6s5kLx12JKai88EGnyh2SMmTYwpeULBPpPfHrW3SZOsQf/mnZVu7HR22C
         pyxpXWa/p0thYodCpC5mx4wb5qgH11kV0ySM8COeEome5Vu3ooBK2vUOyhHc45zcMGSZ
         NhVvKg/N9y3X67xI0DqryJ/KZcYlE5vO1fPnatLR5+GmLeGLdSjmldYulyos2a7WQylh
         ounx6wsP2bshZv3oxJMxK3ml6PWcwZAeenqGIeUGFnRELoqCZLdRJ9PwefATyQfT/fDQ
         49ysahq6w6hFzl4jfDxfEceEjg3mYRIjWXKFuFwCyyIKKi1AdBO7Fev9C+StvmfTALkx
         3Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154632; x=1710759432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuFmZeg0UoxxqK14pMwKTOeuM5ft4agwVZ8ZknCI34Y=;
        b=BcYCt78xFU4UNv6ZC8YGS2FV9VOstK6r65nY1X5N88e5tovfAy1TpPydSu9QGlxnzm
         si9GuvFvmICQM4snXf1ZSd5eP2dgH17UQPkuXIX4gNo2V2joRojPs4yBnQWER1SA7f6v
         DbukXCQdmU7UM3iJGmgBgOFcyGp/OfRiYNX8vsIgOSNdInV68e2r/UqMIYgrPZzGSqQJ
         Q92w6JFUeuoSA2Sl/l+IAoaSB6triVYdeCmH+byaO6uY3InmhNrzxSjx3zBZCoCtLQyT
         lXwqHLiIduEABUCzP9ASpgZ8T/s9Hig4lK+GVoLzJIJgeMZUKm7WlOCOfSy+3mgS+5hD
         H/Rw==
X-Gm-Message-State: AOJu0YyXqt7dJlnj7MK2lzryWGx8/JCafezdl/x+u7nZGFo8syNVxlt4
	D5hxNusV27l99Aqgo6JXMis6HOfM5jfGGbGOz/rLbjBYcf6KI+Uzfmj97Sn/K+M=
X-Google-Smtp-Source: AGHT+IEqCnTuFMtLhQAghBjsehzRatxDwHgEKuLR0O/KZbhz2/rWIOKbcOzFVaDjvKq0QVg/J5/bPw==
X-Received: by 2002:a19:3855:0:b0:512:e205:86ad with SMTP id d21-20020a193855000000b00512e20586admr3352933lfj.56.1710154631315;
        Mon, 11 Mar 2024 03:57:11 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b004132a34824dsm2956646wmb.41.2024.03.11.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:57:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 11:57:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: locking/core] locking/qspinlock: Fix 'wait_early' set but
 not used warning
Message-ID: <Ze7jhCaWwAd3U0di@gmail.com>
References: <20240222150540.79981-2-longman@redhat.com>
 <170912480380.398.9234775487451824502.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170912480380.398.9234775487451824502.tip-bot2@tip-bot2>


* tip-bot2 for Waiman Long <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     ca4bc2e07b716509fd279d2b449bb42f4263a9c8
> Gitweb:        https://git.kernel.org/tip/ca4bc2e07b716509fd279d2b449bb42f4263a9c8
> Author:        Waiman Long <longman@redhat.com>
> AuthorDate:    Thu, 22 Feb 2024 10:05:37 -05:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 28 Feb 2024 13:08:37 +01:00
> 
> locking/qspinlock: Fix 'wait_early' set but not used warning
> 
> When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
> set but not used. This is expected. Recent compilers will not generate
> wait_early code in this case.
> 
> Add the __maybe_unused attribute to wait_early for suppressing this
> W=1 warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/20240222150540.79981-2-longman@redhat.com
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
> ---
>  kernel/locking/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index 6a0184e..ae2b12f 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -294,8 +294,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>  {
>  	struct pv_node *pn = (struct pv_node *)node;
>  	struct pv_node *pp = (struct pv_node *)prev;
> +	bool __maybe_unused wait_early;
>  	int loop;
> -	bool wait_early;

On a second thought, shouldn't this be solved via lockevent_cond_inc()'s
!CONFIG_LOCK_EVENT_COUNTS stub explicitly marking the variable as used, via 
!something like:

   #define lockevent_cond_inc(ev, c)		do { (void)(c); } while (0)

or so, instead of uglifying the usage site?

Thanks,

	Ingo

