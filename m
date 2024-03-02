Return-Path: <linux-kernel+bounces-89334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7886EEAC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 05:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7363F1F22475
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216010A12;
	Sat,  2 Mar 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YF0UOb8Q"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD16FB5;
	Sat,  2 Mar 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354552; cv=none; b=ugI0VIh7op+rMSNC+oL3fZ/Uc4l22nq92gC0lknMi9UKx42K/491eyCf2Te+fZs+wHp7X9skUxNVaKL7Abm4LpTgF4vXPe1vZQb5+CI5Sv0uJG88CF0Jn7hl9E6MBxG8FU9lOLgnsWmTozEQ/RnFFezHPm4beh3gAZ11ohSInBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354552; c=relaxed/simple;
	bh=AYNv0Qa+glncn08+EPqSMHZm6uafarEkSus+rf9dSuo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=f0FbkAd151vgFZtR4hBGOtSOTyehD0ahDJLBIbDHkOffcbCqsIgwA6wTygQ2wu7c9kVe2qRH2vpOOnD5Sfj8LekSW9FGjiivzKEGU/0DVUszhm1n8HPluH++9VYmzSspcIhZqgZuPQvxIKn7jHHBALSHIe6jxU6O+JjGXE0Oy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YF0UOb8Q; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709354545; bh=QAYg13vLJCBT7+EvsgOXj1+cDzAIKbXlvs3Jgvb8Qe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YF0UOb8QiOa4mahLo7PdXZXh1anjru25EfSN2td0e5jADQJ6t+D59+i3oespw+WAr
	 xb5wGWAPuSFVbzxsf32QBSX7YpDXHp3fSOdctyhBrk4a+V1/utoQvMft7dNev4qFkh
	 kkwXS1YE+vEgRerlUW73nskjYQyKUv9NqS0aASxA=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id A979A8DF; Sat, 02 Mar 2024 12:42:23 +0800
X-QQ-mid: xmsmtpt1709354543t46hz37ko
Message-ID: <tencent_DFF7D3561A0686B5E8FC079150A02505180A@qq.com>
X-QQ-XMAILINFO: NXBlMEyQi3goJyrVn5XSQtitzC/kO4MLGqqSAWWC3LZ+U+w5hik6q17yobNOlr
	 s1fH0FSQrI0Y26toV6TSEIisPbPeMSTtDMt/ybCuVc7ocX7laYTLReTRMRU410PWXKfo2VvxkEm4
	 QUT8AaeoOcsNUpwvRFB0zulllc6W6f+gF2F7uh7/bgFfl5MpeJPGWDMEnxFNouZj7zgOMJ8ascF0
	 KYXGwa+o+C30badC5YuM74S7xzS0jzAeNf3vaLQhkcWYHUAe+O5UX/BAKwbJLaQC6Z/AUEyCjLW7
	 A5YiNe0q5sThH82vMGsqJ4hll4W2Ev8hpuXyMwwYjkpjqXPiVofplLPT/2n66Jb+eDdLeXeAfIhu
	 9WwabG4z7SLZXh1fuYXUz0bpPWDcrK8MK21W634Z6qt0rwmznl8MRbHm3X7RcaPFN2PFK8KwNOhU
	 M/djdlF0cjuJ3kb8hpmAakV+0gYhzZfZxH1itbFs+m12ynjb+0hQMtqyBx/9DjlaNXB2GYer8hrS
	 He8KwbncIYyHklFPsjM+ZSqPLzGbYfLNie6pSIyDvyAYLtwSX8/1CGOa6fC/i55R0XtQSOyEIVam
	 r2Mi41Pid4LlvW0ERygOBwgBHJaeE2P/sR3po4WpaclcWHmd5ev8GkO7z8rnbPJIF9m3bqxLIauS
	 Rp5Y7C6lltieZoQtiBzZFMH/tyju+IsOXH+b71xY2AvphYZl30ILK2s/XvZ/SB/K2EdzYgowSnE7
	 l+QvvDMAG/Y6JxLkI9JvZmn7XZ2emLeW8FgXzDEWr9PlKr4BxEhkaKUZox3M8lgDSV18giuSG8CR
	 g4+Kg/DSq/1MtL0QYisYtj479KIeJwUx1x4KKAhSSAQ9/tmCvBwxgGeBNe9D5deYkQkQVTDnPboX
	 i++HOT2VSrSqX3g8HiB2uE+9XLHO8TJXmGe/D8f72zc3tTMN5EKvlgggnW8MQuzwviTpOHJ7fkpK
	 Sc9R5ETOk+kFtFld96Ver6rHL1ajNbA/Oq7ZaQ5qt2i0xLInWuYM7sZI5pWUo6zLgtArzhA09oan
	 X9VTsAUTHcCOosOJEAFlurw7/+89rApd9M+Tnh3n61+I/fkSWD
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Sat,  2 Mar 2024 12:42:21 +0800
X-OQ-MSGID: <20240302044221.49277-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
References: <tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function ring_buffer_iter_empty(), cpu_buffer->commit_page is read
while other threads may change it. It may cause the time_stamp that read
in the next line come from a different page. Use READ_ONCE() to avoid
having to reason about compiler optimizations now and in future.

Signed-off-by: linke li <lilinke99@qq.com>
---
v1 -> v2: only add READ_ONCE() to read cpu_buffer->commit_page, make change log clear

 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0699027b4f4c..c7203a436d3c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4337,7 +4337,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.39.3 (Apple Git-145)


