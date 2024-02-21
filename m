Return-Path: <linux-kernel+bounces-75223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261E85E4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56DE1F22362
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4784037;
	Wed, 21 Feb 2024 17:46:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646D83CCE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537605; cv=none; b=mK6OUW2c7PcivmuxWlrsw5YK/1i2cxBRjwRylrt4SP7XrNvZZ6wv1ZNgKBtp9XZvyzRW9Oz32mJJ2ChpVdMpr74pa5rpPuOFvSdfgZF5ppH+AHQeEXKsKyFmL/3LyU+yQnVqghIE6Rt6bkYF9NHwAmug6ppWvHVS0WiaZUKIxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537605; c=relaxed/simple;
	bh=toIQ7g+qE+iklazK71DzxFyAf3qZhh4eIlVYKF6s5VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYix7tOlK2WTPeXhtZ97OQRiLJKBqemddmpGUaFukwUeIf/VHaCwAYso4WYXBGO+73nfggoduzsSFKNJUFqlpOjMG6D07DP6lByDCYvdwkG/km6A1g3efwYupDMw7kOf+GVcMqZBu3l59CajqL0cuD9OYw4+00s7nYPALU8Eld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91721C433F1;
	Wed, 21 Feb 2024 17:46:44 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:48:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240221124832.14a10f80@gandalf.local.home>
In-Reply-To: <tencent_649330BFF9D93CB7540D508B05514FCEA40A@qq.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
	<tencent_649330BFF9D93CB7540D508B05514FCEA40A@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 23:45:58 +0800
Wen Yang <wenyang.linux@foxmail.com> wrote:

> Thank you Oleg, thank you Steven=EF=BC=8C
>=20
> We could first put trace_sched_process_exit() aside and take a look at=20
> these three patches:
>=20
> 2d4bcf886e42f0f4846a3d9bdc3a90d278903a2e ("exit: Remove=20
> profile_task_exit & profile_munmap")
>=20
> 586b58cac8b4683eb58a1446fbc399de18974e40 (=E2=80=9Cexit: Move preemption =
fixup=20
> up, move blocking operations down=E2=80=9D)
>=20
> And the original: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>=20
>=20
> Could we add a new TP similar to profile_task_exit()?

I have no problem with adding that. But others may have other opinions on
the subject matter.

-- Steve

