Return-Path: <linux-kernel+bounces-89588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30586F25E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211DC1C20987
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAC40BE3;
	Sat,  2 Mar 2024 20:26:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAE40859
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709411210; cv=none; b=A/yrSl8o2Ma1xHTNYF6QEsi/ZDiV0s/DpumBOZr4x1wgTFSpgmQqryOX4q3MLl3YJ7aUzAKR4m0PAsetfGEpGuHK9xmTo6rRIt1k1e87AWmdGrSsOLW4H6VbpYbbkZyC+sYm1Yh4lJLu/dkGn8ChjHvNssjacIbbuLdUoM0jWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709411210; c=relaxed/simple;
	bh=x4K8pG45nWMX3nRc8yT1ZX5+E5p3NM5WaXMzX7xZv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r732vI1/hFH39LoCCcXTTu6/LrHuGCMR/dgSxujttDW4ub8otaAaE/tps526a5Igg906vinMJB5UHeOlTd4uXse5+XxZLfQih95pl6ami49mny2gkESPOyXc/Zgdk60uNlxiBsWFxQ+5hILnnAxzRX8YQoX8/OVa97oPJOfrZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370ECC433F1;
	Sat,  2 Mar 2024 20:26:49 +0000 (UTC)
Date: Sat, 2 Mar 2024 15:26:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240302152647.06d96616@rorschach.local.home>
In-Reply-To: <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 09:24:37 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Honestly, I suspect that a sane limit for tracing strings is likely on
> the order of tens or maybe hundreds of bytes.

BTW, the max used to be 1K, and I've had people ask me to increase it,
as they build up a log in their own buffer, and then do a "dump" into
the trace_marker when an anomaly happens in their application, when
reading it out, they did not like how it was broke up.

-- Steve

