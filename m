Return-Path: <linux-kernel+bounces-166479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C04C8B9B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5A1282B51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EB883CD0;
	Thu,  2 May 2024 13:03:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D25824AB;
	Thu,  2 May 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655003; cv=none; b=bBsmZX87NVM1JJJf4sxD3GPhEOg8qnw2f1acG5cSLZnRfhwR3ajMuUTqCRgXlD3nl/zWWCW/tbalHHWaud1ROnPU2Qh7b4k6HtWKt+/ZRMV0NDQtu4Z8f+gjtDhWewOeLx3BG5Z1NDrRUStxAUJYUfs54CtLromChmRgjQLyHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655003; c=relaxed/simple;
	bh=BJvqNIJnKQx/QQ1NkDS186Ew7vZ155HdR9WHQJ7ugv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUX9dz9qwAezze4j7TrkmJfPdcDpBtySQ3QSm3oS/xXGfiS/DxcBZ15iK2tZgxhpIfeaDycm/AhKoMKv6pDFIOWEprok642/No4AyELWOz+qqKptBRXFARh2KByT7+bUFSzyE+mBAE1DAxilGu1td7UapRDaC6hzVRtH/6ZbrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652D3C113CC;
	Thu,  2 May 2024 13:03:22 +0000 (UTC)
Date: Thu, 2 May 2024 09:04:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tze-nan wu <Tze-nan.Wu@mediatek.com>
Subject: Re: [PATCH] eventfs/tracing: Add callback for release of an
 eventfs_inode
Message-ID: <20240502090408.19bc5815@gandalf.local.home>
In-Reply-To: <20240501235626.81178236dc8826c038089c0c@kernel.org>
References: <20240430142327.7bff81ba@gandalf.local.home>
	<20240501235626.81178236dc8826c038089c0c@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 23:56:26 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks Masami,

Although Tze-nan pointed out a issue with this patch.

I just published v2, can you review that one too?

Thanks,

-- Steve

