Return-Path: <linux-kernel+bounces-89591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08786F268
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BE81C20AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F96225D5;
	Sat,  2 Mar 2024 20:47:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F5259C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412436; cv=none; b=OxWOZEaS0A1nT6TtyVARRD4kZwO4y/0QQfU+TZlucA1qHvA4QjZw2AV8/Ako9WL2D9edRywoiczGRA5KrOp+OChtSRxqEnUMt5Q25AdthCc4zSnY4OugUQu70MasLybBFjcEwU5uCbkQBgtP0jjJaCBSRhsgMB+isqH8VJRt9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412436; c=relaxed/simple;
	bh=v2XDf+DC82KSfCRA87//97uV/FF2NOuF89oT8Sn6XP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhXyMKf9GnleGePT5JHPf9J0bY9zkEv7DZFXeZFiLQTw4BQne05HWCEW9z8/+JQi/DPIS8QoeAuZ+ddOpY6dfttrfBBvsrPKuupi9b0ABY8zOKIgHiZUuQiTYsVhfm059cvsoQM+k/HiqT/VkC/y3G6v7O4vtAeqiruG2Pr5Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040BEC433F1;
	Sat,  2 Mar 2024 20:47:14 +0000 (UTC)
Date: Sat, 2 Mar 2024 15:47:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240302154713.71e29402@rorschach.local.home>
In-Reply-To: <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 12:33:01 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And if you ever decide that a sane limit is ok, you can send that in.

I'm fine with just making it 4K with a comment saying that "4K is the
minimum page size on most archs, and to keep this consistent for crazy
architectures like PowerPC and it's 64K pages, we hard code 4K to keep
all architectures acting the same".

-- Steve

