Return-Path: <linux-kernel+bounces-125891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07C892D79
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EF41C20D35
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E29482E5;
	Sat, 30 Mar 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoG92uf8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ih3gkHa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0A17D2;
	Sat, 30 Mar 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833791; cv=none; b=N60ZmogJcIrY2L6MU/GRXh8t0VDW9S1abCOo4sQlXFcD6zL8NQi4tuNRdBre1E0aZPSlGtcaHK/Dm/vagHxq1C1ZnVOJoBS79H4zJToADw/r0XmdLVxRdQH/3XF7SY2i60hEKYuX88gnJPfBg+SdUdNGTk/NfjscCJRY6BRN5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833791; c=relaxed/simple;
	bh=kI2RgQKIy46E4/XMESMBolqMfp3inpi7STqcXxY3bTc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NlPsmfyHkpTTQczfzqwZ5gghbr4Yfpvy1r9m1YwJ2VfZgh2tp/yLaSxgVolRrMwsyEA601cTAlpzXTjVCGO2T5zMSVjL01QzaeLkBRvAuGhRh5V+RoxSb52hwRuJSwqmfEGacFGdETjFydSlNgc/Ha7NTiFrQD6OLu8wSg+JP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoG92uf8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ih3gkHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Mar 2024 21:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711833787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cO9DAoslNiaRo5wWS5uXMV/wBejmz6LP19eIIxQWH84=;
	b=LoG92uf8MRxCmeUIR8y99oipc+Ec0zFD01sBvcCvF4kvwqhzYticOJLJI2Imw1G5vJo48K
	Bhf+RiMe9EgjlzZmzkGKZ82tPKRa4isU0H5U59l7Aah0dn0cZjEbtzqXVjFssNM/ZS+gTX
	75e/I4LlhP+L2LPHGaQiQw0YW7UiJy293F51HKFjcxZPZVnTZl9+nygJ/8mnoElJP8/jRe
	krQzC0A9e5CCsisk6s9o87MvmiS5RwCmOnay9T8/ZhxXCRdIq9GI6UnWS/2ngoR740U/xp
	mDIfcTPjXqgRfw0MXOVBb5pnpGmIQ5GYU7ghBmVb9aLbof0ilhnTmtYYzfXUbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711833787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cO9DAoslNiaRo5wWS5uXMV/wBejmz6LP19eIIxQWH84=;
	b=7Ih3gkHaVxHnnSi5Qq66j9ZfM9NojoK8BpYL4FzLlJjZxysHt8r/Wxfv5+ofYJr/fZNw/e
	732gzNiSePILIuAw==
From: "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix compile failure when using the x32
 compiler
Cc: Mikulas Patocka <mpatocka@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171183378642.10875.5605747277159898590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     6205125bd326ed0153e5f9da3c4689fe60ae885a
Gitweb:        https://git.kernel.org/tip/6205125bd326ed0153e5f9da3c4689fe60a=
e885a
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Sat, 30 Mar 2024 20:23:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 30 Mar 2024 22:12:37 +01:00

objtool: Fix compile failure when using the x32 compiler

When compiling the v6.9-rc1 kernel with the x32 compiler, the following
errors are reported. The reason is that we take an "unsigned long"
variable and print it using "PRIx64" format string.

	In file included from check.c:16:
	check.c: In function =E2=80=98add_dead_ends=E2=80=99:
	/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:46:17: error: fo=
rmat =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long unsig=
ned int=E2=80=99, but argument 5 has type =E2=80=98long unsigned int=E2=80=99=
 [-Werror=3Dformat=3D]
	   46 |                 "%s: warning: objtool: " format "\n",   \
	      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
	check.c:613:33: note: in expansion of macro =E2=80=98WARN=E2=80=99
	  613 |                                 WARN("can't find unreachable insn at=
 %s+0x%" PRIx64,
	      |                                 ^~~~
	...

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0b10ad0..0a33d91 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -585,7 +585,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
-	unsigned long offset;
+	uint64_t offset;
=20
 	/*
 	 * Check for manually annotated dead ends.

