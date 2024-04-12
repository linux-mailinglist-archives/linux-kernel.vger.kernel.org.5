Return-Path: <linux-kernel+bounces-143085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2548A33E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97EAEB28747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767D148FE5;
	Fri, 12 Apr 2024 16:29:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169953811
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939359; cv=none; b=mxTjt4KZavvwWXjlH8nR5Zh0Z1NHKC+50oK0eAf/w9DEOv8Zg737spKjfWjG34D77jZONtKEHVS9ZkdSVQCQBou0AG80YfNCtnzIwBx+hvuUMyZoaygHgETfyd/UbGjkd4fLDpa1fzPtRBFJEqIniGiXbSl+WEL2AWA0A2FoJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939359; c=relaxed/simple;
	bh=4VBfCln8aZung3Xeodgt6h/HIzk99B1WuJ7k9O/+ptg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjY9DCw2Aus/OTsTFkXLHqHQecUIyIAS/JIodLdXxSBNB9ckiUqeF4CpXcHEedhRE4dzK3U7/0CQ9cG2x+xozGi4sMiypgqEyqaZtXUeLFKFdLptjOLU04y8S33aFAqwrKdnOGps8nAl1R/MFzLydiN40ZbIQ3cf1jllG+FZM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9EC2BBFC;
	Fri, 12 Apr 2024 16:29:17 +0000 (UTC)
Date: Fri, 12 Apr 2024 12:29:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Prasad Pandit
 <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
Message-ID: <20240412122916.6e42a613@gandalf.local.home>
In-Reply-To: <CAHk-=wiJgRfOnt4TVFOaXfjkjTAh1AdY64zw1ohZxv7yzqzBxQ@mail.gmail.com>
References: <20240412103204.453d912c@gandalf.local.home>
	<CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
	<20240412121531.24669544@gandalf.local.home>
	<5ab77ba9-721a-413e-bb26-6c842679f61a@infradead.org>
	<CAHk-=wiJgRfOnt4TVFOaXfjkjTAh1AdY64zw1ohZxv7yzqzBxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 09:21:58 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Ok, that shit will now be broken immediately by me adding tabs to our
> Kconfig file.
> 
> Because no, some out-of-tree garbage is not relevant, and if they
> don't fix it out of tree, that's *their* problem, not ours.

Feel free to revert that one commit, I don't really care ;-)

I took it more to be "consistent".

-- Steve

