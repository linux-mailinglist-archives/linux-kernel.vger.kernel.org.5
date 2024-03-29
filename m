Return-Path: <linux-kernel+bounces-125280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD20892359
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236DD1F23E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0C139566;
	Fri, 29 Mar 2024 18:29:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B4137903;
	Fri, 29 Mar 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736961; cv=none; b=DfXU/k+4U5g3msx6KVbVhkDCjds+pZq68S0rkYRykpRy4/YEz7PITmMAOwx6ObHhECYrK3a9XVhaD64kz18HZ1TOLtu9lkOZp2CO5y4x8cAWWBLvQgGBNNdObPMPhctbvdY6Y2ICOhLDqZxA/lyx3Y4PhWDa5Rcq6u/L91U6zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736961; c=relaxed/simple;
	bh=SPUg+tRH5xvHEVcSWTYPv64Mi0EH+GD/KVONAzkIv9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIr384VPq1zQUSEOLuQBdcd/63Ywpnhef0KkvL8FAOxVfJtrpv/q6waxqqJT5Mq17sD0+ojVOX1Xv1Z0ffbi+hd9DExOJMGBB18lHT+3W98q8fjodkyncQ2znZ+6qld+KW9MQ4JJFuYkV2jJm/UnGzZBCNbj/02TAw94OldhTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0999DC433F1;
	Fri, 29 Mar 2024 18:29:19 +0000 (UTC)
Date: Fri, 29 Mar 2024 14:32:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <20240329143205.66c35f5f@gandalf.local.home>
In-Reply-To: <a6e236f3-60a4-48da-840f-c38d7ba02475@ancud.ru>
References: <20240328181914.869332-1-kiryushin@ancud.ru>
	<e3d3a612-4751-48ac-82c1-8bf61e8f3cd1@paulmck-laptop>
	<a6e236f3-60a4-48da-840f-c38d7ba02475@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 20:56:16 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> Maybe, it would be a good idea for me to add a comment with intent
> clarification, to reduce possibility of the same confusion in the future,

Yes please do.

> while I am at it? If so, should I do it in the same patch, or make a separate one?

I would keep it the same patch, but it really is Paul's decision.

-- Steve

