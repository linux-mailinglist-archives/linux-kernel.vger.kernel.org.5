Return-Path: <linux-kernel+bounces-93220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCBC872C78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD61F25D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CBFDF42;
	Wed,  6 Mar 2024 01:59:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2BDF49;
	Wed,  6 Mar 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690385; cv=none; b=CKiDaqvEXf2oEMSCKLQHsHogr3qRSAQjnbZKmzcritOPwwdR/amIClsX7Kmje5C6nYlU1+VWvjM8RBsCkCa3IaTjqJx08QOPQmCs3cAixAEhfV9RJ3rD626DIqKUAE/80JgTVyuFY5HlIsIpqQqINd3LfbpUjZ9nPHMXcM6GanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690385; c=relaxed/simple;
	bh=nHQ8Md6bByC0dc+OiDTwcZww00+8qBJ/9Yu0mwE+xIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sn8c2NuSb8jzWsnIF9srdo9Se3jNwiJIJ+c3T7q1loJWOIBDNggXfthh29SBXld7PYFb0PS65xU94ztFovSOxx1BUScNtAe0RdA8hfhQnFBXwgMoXusQM8V5IOw6YYIw9gxZsl9fPVghuHEArWVVycXhMZDwTtEc78gT6tOV+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FADC433C7;
	Wed,  6 Mar 2024 01:59:42 +0000 (UTC)
Date: Tue, 5 Mar 2024 21:01:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, Joel Fernandes <joel@joelfernandes.org>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>
Subject: [POC] !!! Re: [PATCH 0/8] tracing: Persistent traces across a
 reboot or crash
Message-ID: <20240305210133.125a1643@gandalf.local.home>
In-Reply-To: <20240306015910.766510873@goodmis.org>
References: <20240306015910.766510873@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I forgot to add [POC] to the topic.

All these patches are a proof of concept.

-- Steve

