Return-Path: <linux-kernel+bounces-130155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B08974BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097F11F232C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66B149DFE;
	Wed,  3 Apr 2024 16:01:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088D14A4CD;
	Wed,  3 Apr 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160095; cv=none; b=iwU4RP+Aw3pUUugJkao/8yAZBmDES4Ywh+H1HNhOj1GplnjwAKsLksZ15Rl2uL4r3DqPznN/mqBD3vBU9g3y5FbOu+lXWSk9VpJCKT+5kqhTeGfmtSujhftFPD7wKM6jum1LSClXGrSHoQE4ZcpPZb/k22KWw+7EgnF1kL0AgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160095; c=relaxed/simple;
	bh=aMZo+m17UDjkDM728p4hgqKhx33v3jNtJzaJZLBGf5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuDw7iE8BEL3uH3L4ERiASzIdvIskl3ZVBYAysvjCRS9lp3Mr0Bgf604n7EByrXsIutAcKLHHH/2ev/YSxbct2NGcIJd3w+xj6HLdabgfAL/guzeL8VskfZrKn680A4imVo/SvqPhdpTxMeRqcjzn3Srn0YQrvc0qbwlSXKgtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E1DC43394;
	Wed,  3 Apr 2024 16:01:34 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:03:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH v19 RESEND 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240403120354.73689a47@gandalf.local.home>
In-Reply-To: <Zg1qMI7JYhdeY_z7@google.com>
References: <20240326100830.1326610-1-vdonnefort@google.com>
	<20240326100830.1326610-4-vdonnefort@google.com>
	<20240329144055.0ae2dd4b@gandalf.local.home>
	<20240403101352.08c83aa4@gandalf.local.home>
	<Zg1qMI7JYhdeY_z7@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 15:39:44 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Do you plan on sending out a v20 series?  
> 
> Of course, let me spin that this week! Got also few typos to fix in the doc and
> I believe an include missing for riscv.

No rush, I'll be on PTO until next Tuesday, and will not get to it before then.

-- Steve

