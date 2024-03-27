Return-Path: <linux-kernel+bounces-121145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380288E48C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D7B335A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D76D1779A3;
	Wed, 27 Mar 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j39GwaqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F960176FDB;
	Wed, 27 Mar 2024 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542197; cv=none; b=OwmjKBc5JiPkHf+ft4oxnfxu4mTB6C1e2FDLBLQLRv9SwFBkn9N+HjmT/1NzAnoAhNBLnkFv7CzBZIAYRTxGH8SBXZFFcTUWlWFQO0aCv52ct7RSYDjrr1rj94GITFPfDbPXR4M+i/tCWwfOgS2YzUonmPUicVtOLoFERSWcfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542197; c=relaxed/simple;
	bh=RwigAQmafhkqcfjzheZMcdBby7iXvnOAGJQb4topJtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8+aDjljdElIbfEp8Sv0hjYON8B5r/VPTzrUkzkPZ192r7/a+KYK8F2LBJvYPCAG0NeWpm4VhvrqYRiTrqWCEN2tpDbhQgiWh7Bq7T+VGuUexiDTOAbZErT7U3k80ave8Leu5lr8AUhSlX//eTvcWdVSO3YqfcODt0ZPBHIMZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j39GwaqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515E9C433F1;
	Wed, 27 Mar 2024 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542197;
	bh=RwigAQmafhkqcfjzheZMcdBby7iXvnOAGJQb4topJtw=;
	h=From:To:Cc:Subject:Date:From;
	b=j39GwaqWNwuCMxbqBCeCZRzofWcJbM16RykA5LzgBd4FQuANjTrc0iH/uKXSUw5Yw
	 P4QS9Jg8EPbZfnEDqp5lPanVH0Mr7grh+fzIBNOcmeQLxK6HGgSllikbwkR3EG+L7+
	 zjD2oVSw15ja8+QjYaa6IKjnoztOxFhCL7ZqEqS3CFZO/S3qhe+rvEVOKQtSzoDF+6
	 Th3isEn9BX2uvdKlHBc6wsRNYGyYYQNLNvvO6UME+TEXP5NyUvxHrkZIhiY1LHKMZL
	 Zi0Ct9kRseG0/EwFhoia+2Uq6JO9RGZe6mkwmkV0jHzMk7RjE+Vx9ZMNHEAYQt+C6i
	 E3vaC9Qw1EKaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rostedt@goodmis.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "ring-buffer: Do not set shortest_full when full target is hit" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:15 -0400
Message-ID: <20240327122315.2838361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 761d9473e27f0c8782895013a3e7b52a37c8bcfc Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 12 Mar 2024 11:56:41 -0400
Subject: [PATCH] ring-buffer: Do not set shortest_full when full target is hit

The rb_watermark_hit() checks if the amount of data in the ring buffer is
above the percentage level passed in by the "full" variable. If it is, it
returns true.

But it also sets the "shortest_full" field of the cpu_buffer that informs
writers that it needs to call the irq_work if the amount of data on the
ring buffer is above the requested amount.

The rb_watermark_hit() always sets the shortest_full even if the amount in
the ring buffer is what it wants. As it is not going to wait, because it
has what it wants, there's no reason to set shortest_full.

Link: https://lore.kernel.org/linux-trace-kernel/20240312115641.6aa8ba08@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa332ace108b1..6ffbccb9bcf00 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -834,9 +834,10 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
 		ret = !pagebusy && full_hit(buffer, cpu, full);
 
-		if (!cpu_buffer->shortest_full ||
-		    cpu_buffer->shortest_full > full)
-			cpu_buffer->shortest_full = full;
+		if (!ret && (!cpu_buffer->shortest_full ||
+			     cpu_buffer->shortest_full > full)) {
+		    cpu_buffer->shortest_full = full;
+		}
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
 	return ret;
-- 
2.43.0





