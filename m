Return-Path: <linux-kernel+bounces-137748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2B89E6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D843DB2316B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC8621;
	Wed, 10 Apr 2024 00:11:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66519E;
	Wed, 10 Apr 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707912; cv=none; b=TjzN8xyAKVbVGs3bcpqJDNghyHWFHL9mMmT9lMY2zmJq3+mlxwUzdFS7o4oSXW24TwPQbR4jLY+Tg/j3iM0o+zWYhq9pj8iyb4+zBupEm0bbwuKqHg0jJ5S/Qfu9c853Frnn8TnarDtRbfPv3C1VeBIBWZecuZukAb4r0lNkJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707912; c=relaxed/simple;
	bh=cNZeGZ/65OwERzSfuxbYVGkUaCy7OOfWW6eKXwFvmww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klF2ws6vjpK4VB2fOmgVLIprGYJHYh5nE066VPiZSpXUJHdod5JhkZLkT5hPgi3iHCvmVekBDXSrHbe1VPXfoZzh/7t9JwN/KfS5iOpIBp2Rgxd0rF7BM3yXERcvCxn2xvpG8l7Htwo1JmZ0msUUU3pxIPoqHbad6ckdNyC3L+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092DFC43390;
	Wed, 10 Apr 2024 00:11:50 +0000 (UTC)
Date: Tue, 9 Apr 2024 20:14:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, rsavitski@google.com
Subject: Re: [PATCH] ring-buffer: Only update pages_touched when a new page
 is touched
Message-ID: <20240409201426.73251bc4@gandalf.local.home>
In-Reply-To: <20240410084400.d08b17cc846c233619e3c9fd@kernel.org>
References: <20240409151309.0d0e5056@gandalf.local.home>
	<20240410084400.d08b17cc846c233619e3c9fd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 08:44:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks.

> 
> BTW, isn't this a real bugfix, because the page_touched can be
> bigger than nr_pages without this fix?

Yes, I simply forgot to add the Cc stable.

-- Steve

