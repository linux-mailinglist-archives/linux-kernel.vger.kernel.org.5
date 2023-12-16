Return-Path: <linux-kernel+bounces-2387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E0815C19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303631F21ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB841364BC;
	Sat, 16 Dec 2023 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nqbWYhZh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220E2E63A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 17:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702765247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sJMd1xwCaMZYEX5xzl+9vlhUbg9rRemwcyPkafmbZ4=;
	b=nqbWYhZhhwske5tEGiQcbSv56j9Q90k5T9QPHAdYJgai97F1cJSS+les6osSNkZtX2tlk+
	oB2NLkL3WyNWGPXI08pzXvhoZI9IVUXPWcikBV5pAQc7vgxmcSKJMNiFxhHLS8mOaNWVpt
	W1/CokZc08/7IMqflkmiH6mH4NIyvcE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	keescook@chromium.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 50/50] Kill sched.h dependency on rcupdate.h
Message-ID: <20231216222043.xxle6iugpbrwnhbe@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-7-kent.overstreet@linux.dev>
 <a22b69cc-40e3-451c-a18e-ee610aef5150@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22b69cc-40e3-451c-a18e-ee610aef5150@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 16, 2023 at 11:35:04AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 15, 2023 at 10:35:51PM -0500, Kent Overstreet wrote:
> > by moving cond_resched_rcu() to rcupdate.h, we can kill another big
> > sched.h dependency.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Could you please instead move the cond_resched_rcu() function to
> include/linux/rcupdate_wait.h?  This would avoid breaking Ingo's
> separation that makes it possible to include rcupdate.h without also
> pulling in sched.h.

Yep, will do.

