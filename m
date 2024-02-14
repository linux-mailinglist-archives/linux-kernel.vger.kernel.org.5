Return-Path: <linux-kernel+bounces-65442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E13854D21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D201C20927
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263E5EE65;
	Wed, 14 Feb 2024 15:42:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848B5DF05;
	Wed, 14 Feb 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925319; cv=none; b=gPC1t2AdIwhEs6ymuEWdP8ShUjU1fPzGYokAWJSD+Nh2qJkoHQuRV9KSk5UOanjGmpMpwjWJihu5LfuGWxbKFEj2rErK23ZzhhyruSEgBpAJdDP3PVTS66A+qc2Y7dRnkq9itxi3IjtwPGO/tn29gLheDiWypfHlI+0CwOzAiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925319; c=relaxed/simple;
	bh=EQJqgCbsIzF1hi7yDHjrJ52K4ATuJYMSNA7gnDd1vY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPaPLS6nXUwlW+tjkZKqIqIaqDcJzVrVBrKWKQobxZHRwHI8FbryhezhAY53DargEGK2lSKF1Kez0BYinZ+MUu7TH1U43ctKGwavJxAOLP9EhkhJRRlKixpAqs+nvIwbBztFzEoaDM6fFn5E721Ik7T0XWzkLAvjvA0aRfGf9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBB0C433F1;
	Wed, 14 Feb 2024 15:41:58 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:43:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [regression] tracing: kmemleak warning in
 allocate_cmdlines_buffer()
Message-ID: <20240214104329.56a19586@gandalf.local.home>
In-Reply-To: <87mss3njvj.fsf@kernel.org>
References: <87r0hfnr9r.fsf@kernel.org>
	<20240214094617.1e6ec684@gandalf.local.home>
	<87mss3njvj.fsf@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 17:30:40 +0200
Kalle Valo <kvalo@kernel.org> wrote:

> Although the patch didn't apply for me as in my tree the functions are
> in kernel/trace/trace.c. I don't know what happened so as a quick hack I
> just manually added the three lines to my version of trace.c. Let me
> know if there's a git tree or branch you would like me to test, I can do
> that easily.
> 

Oops, I was in a middle of rebasing a patch series I was reviewing and
forgot there was some changes to the code around it. Anyway, that should be
the fix. I'll add your tested-by.

Thanks!

-- Steve

