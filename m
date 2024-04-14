Return-Path: <linux-kernel+bounces-144398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333298A4570
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF2C2804E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB4136E06;
	Sun, 14 Apr 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6sxQoZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RONyYlb2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5238F83;
	Sun, 14 Apr 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127633; cv=none; b=ExMLp4xeUAR4w8UStmGPGcWlU7Fwe9BxdxIKCjUCA8rHbJuGCCas4YvA+E/5XklqwHCHzcWY/GspqXDqsOrF5SZXvRr0WcF7fhmzeu3sGNKL7xSr81WzuBixMnWOzAgYrhWc5BMjwRKf2N1xno0Kw7AFfkXRqzZV3RD1Jm7RaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127633; c=relaxed/simple;
	bh=cPmhdwRN4HaauBki4wOmwHcTfFwFqNR4AcVbjmxP0W4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WjpL+vsYMslTRxnGSzPm1eh8hxQfGMiv6Raok/ldswsOHWXgTcWH8KLCwza5XXJogz/CWg6GnH9pwW/G1gi7tlWcIcC7n2BFeZvBP0SG7oC/g+isp7yeV5Bnfc4L9Y8HPrM0Hu5QuRY7YMo5MwZAxCnugMpHxh6e3u8oo+aVWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T6sxQoZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RONyYlb2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:47:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713127630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mELcSZ1symfymfiloSd0fMYJkuQ+IV+r96dGGGcmOyc=;
	b=T6sxQoZiBXXOEiG60DMmAAG8W1wHt0rMW9f/TcvkqOwMLsuKQE1FMQfXhCJrWst10eTUdu
	tSnA9Ezxb0igMC7O6h+2lC3ZyoPfaMHmOdO/Z425SptlsYRPkLcSPyc/yinAXNvEWbWIWl
	MP/I+MFYeQrTYbOLnNRCyYE16OK7lX7KaqmM3RJktmPHCP0B1ExqfZJMixWUYNjmyTkROS
	1s63Ig0A7cwghPcLOoIyjxUk0QPjnF/Cx4KyguPb+qf1NXUMTVnPAmTZeB/Oaf/PCOYPrh
	f5dKpARF+mzFx/iZ7+BUGvUwYaNBKJVwvW7+h7TzMA4PI7l7p0CaAK99cnZWyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713127630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mELcSZ1symfymfiloSd0fMYJkuQ+IV+r96dGGGcmOyc=;
	b=RONyYlb21OgL6lILKAJwCCckS6Zu3W+J/RBiWREPyz21EXF5EfbYLKrqgwTyn17F+W8bVJ
	lEz1blxt24AvPiBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Mark perf_event_set_bpf_handler() and
 perf_event_free_bpf_handler() as inline too
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Kyle Huey <khuey@kylehuey.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312762955.10875.10129157513036950333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     854dd99b5ddc9d90e31e5f112462a5994dd31810
Gitweb:        https://git.kernel.org/tip/854dd99b5ddc9d90e31e5f112462a5994dd=
31810
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 14 Apr 2024 22:33:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:35:26 +02:00

perf/bpf: Mark perf_event_set_bpf_handler() and perf_event_free_bpf_handler()=
 as inline too

They can be unused with certain Kconfig variations:

  kernel/events/core.c:9622:13: warning: =E2=80=98perf_event_free_bpf_handler=
=E2=80=99 defined but not used [-Wunused-function]
  kernel/events/core.c:9586:12: warning: =E2=80=98perf_event_set_bpf_handler=
=E2=80=99 defined but not used [-Wunused-function]

Since they are both single-use, mark them inline.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index da9d9a1..6b0a66e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9583,9 +9583,9 @@ out:
 	return ret;
 }
=20
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
+static inline int perf_event_set_bpf_handler(struct perf_event *event,
+					     struct bpf_prog *prog,
+					     u64 bpf_cookie)
 {
 	if (event->overflow_handler_context)
 		/* hw breakpoint or kernel counter */
@@ -9619,7 +9619,7 @@ static int perf_event_set_bpf_handler(struct perf_event=
 *event,
 	return 0;
 }
=20
-static void perf_event_free_bpf_handler(struct perf_event *event)
+static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
 	struct bpf_prog *prog =3D event->prog;
=20

