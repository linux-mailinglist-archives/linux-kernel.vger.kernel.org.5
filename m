Return-Path: <linux-kernel+bounces-62861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A28526F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8828F1C257A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38912B83;
	Tue, 13 Feb 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQjrk+9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8310F5;
	Tue, 13 Feb 2024 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787669; cv=none; b=W9p1iyiU/KUOKeApvmSMfysSQQ43ygF3wJ2ymBU6m55URa1Qux+0Y7+R0C6TDAc30vMSACyoSSIHBP+NhNWd8LE9AMpsT5uLSLw1Vg02aBEmqgLznHk7hhJqzY8625W6ZxBnQ2+aluONg3G9yQQIwopVVL/gLMA5XOiZzYhUo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787669; c=relaxed/simple;
	bh=Ne4T7tGo0b1UQNiQeAgOuYPKLol9FMJk/e2QuPkEq/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hqyuF+aVg01TCST31XKDsHWQi+vLsiMa6VX73j7wSae++CneNpZqJw434kmGzXWB8Cv0vxcVt50s9eBO79QdwcjtuIJZ8nbmJvJNyXaX+KdtHs7x8QwGOeiV+TjyE0kso2m1bNjaLUxftmEpvvL7QFBNh00ALFqwvjh/amwIHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQjrk+9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C8C43390;
	Tue, 13 Feb 2024 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707787669;
	bh=Ne4T7tGo0b1UQNiQeAgOuYPKLol9FMJk/e2QuPkEq/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQjrk+9baCr53AJB7ey+sXnWkifkV4DF0jCKx3pl0oN5Rvq45bbxcaxvtk1Iy+FgL
	 e8eJMV3ZXIVZ0kTlvVEkjglSbM6EuuJQik/WObtpVBRxmsvnocTUePfRPgUIXuA0Pb
	 F+BrLKx0kSt+GUH2C3N8omWMugpR0Vy92WXBWn9I=
Date: Mon, 12 Feb 2024 17:27:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Qian Cai <quic_qiancai@quicinc.com>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] configs/debug: add NET debug config
Message-Id: <20240212172747.53b4c744759073a32db8be70@linux-foundation.org>
In-Reply-To: <20240212170253.77a7be7c@kernel.org>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
	<202402121039.E14DF37@keescook>
	<20240212170253.77a7be7c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:02:53 -0800 Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 12 Feb 2024 10:39:55 -0800 Kees Cook wrote:
> > > Notes:
> > >   - It looks like this debug.config doesn't have a specific maintainer.
> > >     If this patch is not rejected, I don't know if this modification can
> > >     go through the net tree, or if it should be handled by Andrew.
> > >     Probably the latter? I didn't add [net-next] in the subject for this
> > >     reason.  
> > 
> > Adding these seem reasonable. I touched debug.config last, so I can take
> > it via the kernel hardening tree if netdev doesn't want to take it.
> 
> I'd prefer to have it in net-next sooner rather than later, because
> when our CI hits an issue we can tell people:
> 
> 	make defconfig debug.config
> 	make
> 
> otherwise I have to explain what options to twiddle with. And the
> refcount options do catch bugs, I had to do this exact the explaining
> last Friday :(
> 
> So I'd offer these three options:
>  - we put it on a shared branch and both pull in
>  - you send to Linus within a week and we'll get it soon that way
>  - we take it to net-next directly
> 
> What's your preference?

It's a net patch.  Put it in the net tree.

