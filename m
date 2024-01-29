Return-Path: <linux-kernel+bounces-43225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB803841119
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52165B25CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E676C62;
	Mon, 29 Jan 2024 17:45:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFB76C84;
	Mon, 29 Jan 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550303; cv=none; b=Qkr5zOfad8g6VHY4OlEQ2CLV88HRVf6fue3OgXXG7rYSkGSSA6EJhFYZ7YZmHYvAp3+Mt5TazwAX71tbgaocgsAwZreE8fMMyrrr4dQwzShmAD9hMpiDOCsl3x3BiNFjUycfIfd8R3d9VqCWicwqjxnsBKoYjFZqRzfhJE6r5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550303; c=relaxed/simple;
	bh=+HmAcI+OHaJO1R/YCxcCxo/x4k6NmFfEK9ciOkM4IIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTZqwqqX7LkEpsscDjtiZ7VFLSQ9ykptSidUdrWxc7vkYfUlkCILe8v7E9yZUpd8fzonbD3EBbTVA9cn3roD/i6ujuPZNN7gIsOWViGCulhAz3WomkhISfpPA9hL05ZQUowybpJ9yNX1CgIeME6b+u+o2ArgAU/fX85ex4tX/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4003C433C7;
	Mon, 29 Jan 2024 17:45:01 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:45:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129124511.37c0ad19@gandalf.local.home>
In-Reply-To: <20240129124436.4b7d0129@gandalf.local.home>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<20240129124436.4b7d0129@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 12:44:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 29 Jan 2024 09:40:06 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Now, I do agree that your locking is strange, and that should be fixed
> > *too*, but I think the above is the "right" fix for this particular
> > issue.  
> 
> Would you be OK if I did both as a "fix"?
> 

In separate patches of course. And I may even give the same tags to both
patches as well.

-- Steve

