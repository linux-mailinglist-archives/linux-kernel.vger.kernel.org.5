Return-Path: <linux-kernel+bounces-16845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074C8244D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F461C22210
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF0241F9;
	Thu,  4 Jan 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k226NRWg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09250241E9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E73C433C7;
	Thu,  4 Jan 2024 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704381542;
	bh=T4eAgLLCkdtEIRXCRmMJ3i4ivRxDa9+5qVzkXofrqCU=;
	h=Date:From:To:Cc:Subject:From;
	b=k226NRWgLi4JjzejJ4uiMmPCKow5MeTcunbe2jn7xMSzPYmBCTTbwnZhDFmTl26Ca
	 3ElH2flg2iC8xPfuhWjFYHDJyH8B778jPf96fQ460BsQIIbO3d671R7nV26qmjjcIj
	 1Qhu7hmUwj8FMr7gW0ymzbdNXyY3zAK1TIfAp3SKyIzF5YfBEQMUJzGh2mYUjoQlwS
	 4lubrI5tBQSydiPU4hHsAwAb0e00kNTu+JpJNDyV6FC6YdB8nvJ6VEcGA08nb3UWkT
	 VmoMm8pRNmtxWAugPBqRxlYETEm37nJV+vtp4PmTa6qcc7vXbFNo1sHtqPaXmfQeiS
	 munmkyvfZHtCw==
Date: Fri, 5 Jan 2024 00:18:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jinghao Jia <jinghao7@illinois.edu>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.7
Message-Id: <20240105001858.865e3794558a326e146e9c3a@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for 6.7-rc8:

- Kprobes/x86: Fix to emulate indirect call which size is not 5 byte.
   Current code expects the indirect call instructions are 5 bytes, but
   that is incorrect. Usually indirect call based on register is shorter
   than that, thus the emulation causes a kernel crash by accessing
   wrong instruction boundary. This uses the instruction size to
   calculate the return address correctly.


Please pull the latest probes-fixes-v6.7-rc8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.7-rc8

Tag SHA1: 71ce71c6c329bd3f2ba52bb0a7373f23d8da8f59
Head SHA1: f5d03da48d062966c94f0199d20be0b3a37a7982


Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

----
 arch/x86/kernel/kprobes/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

