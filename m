Return-Path: <linux-kernel+bounces-93221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F013872C79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B641C2535E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C8134B6;
	Wed,  6 Mar 2024 01:59:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8FDF51;
	Wed,  6 Mar 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690396; cv=none; b=JFcw1Yj4DAuNvL3SErBRpWIlfMYGF27JXs1qc9d4FKwvacs71JGR+4zpn3q74GModEwUXU0PO5YhjyPy5UtDPLXy1TKz95RjbDoYGdLj11vNYS/2TJwJEQ3lLZ2RQ70K6B5mrkV7+K+AxDgrqIS3bz8hGU5Dxh45JrRmGOU1trY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690396; c=relaxed/simple;
	bh=vlqplmEiuRi9zaL6P3HLiDmWdu8RoWyxiD2tS5NzYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HROg+pwR+algOi44weUxQEybJnyWlnCVjPvjDFNFm3EWrvwE8oJ2c3yLvwmDvnZSGIQjzhBQXZnbIkWp/GLEWJyPjNxIUDXQXb1N0AXmLv+poIrWO15vdaO6z8hk2UPPh2g0RhwuXE+tThU04u4mn8aeF/GO+dRip6BNPteOxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508BAC43390;
	Wed,  6 Mar 2024 01:59:53 +0000 (UTC)
Date: Tue, 5 Mar 2024 21:01:44 -0500
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

I forgot to add [POC] to the subject :-p

All these patches are a proof of concept.

-- Steve

