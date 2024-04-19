Return-Path: <linux-kernel+bounces-151014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE68AA7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CED61C21D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB640D30B;
	Fri, 19 Apr 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRcGCPCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B6C129
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504776; cv=none; b=lAqcum5YaWgUVM5KWhavrCGItYL1oac4BcXMst0SNptv69KGfViZ4CeNfUbyo4+9hcd6o5jmZZWoR0xDc4J48rSbDZ54wLZ+Aq2w2uNOZFx2WhcrLM8DatqjJop5VSiQ95Z0MbffwfMqA0l/MTLrIm05NheoutlVqZ01EDb62lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504776; c=relaxed/simple;
	bh=lq/Xv4M4vBSSNiRLOhVKPr3gqTFV6zc5MfUV4fIHH/c=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=aSeRTFH/+mww+Bu9owfq3yHICkkZIPHFqdjZt3IxbIV1Njt7NeFmn8mBs0KDeWbYVZFA1Oa+Mi4q7+GK7rFBTiE/8Vwtz2ezHiV0AwLKYnWhugH4A7T9LqCWaKjRfNqcWMR7okhQlUkRuqtqp0AP3a7dVw8KXBxt+RW8Ifesma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRcGCPCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99907C072AA;
	Fri, 19 Apr 2024 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713504775;
	bh=lq/Xv4M4vBSSNiRLOhVKPr3gqTFV6zc5MfUV4fIHH/c=;
	h=Date:From:To:Cc:Subject:From;
	b=JRcGCPCjTRKDDnoUo4qSXTcltDidvV2qNz0n8S7Lb+Xve3zqPf9Lw7WczjOAUF6oI
	 BrlRi92Fv2wpf5Y3wIAJ7F67zLG8nHr3aparnlysFENojlfU/FxR1fpKKWrCH9S8Lp
	 cYVmkPKqdk4VBAppiLQPPa15mjZCDD0gbsRShYYek9cb2yMxfaUzPIRoUmGeFf2/oy
	 xkXHVqwy1y5Enwyi9iUWmF346HGShfPOCUHSECQnaGG+2LaxfKRL2FdHzLaBcSMFZw
	 jpfz6hdWktjfe2OTOJREDE5ATVEXHRgoIQ97uF7deKINHMb/f2RhQdcWmoFtuyILIq
	 6PMCHYLb4NYDw==
Date: Fri, 19 Apr 2024 14:32:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Qiang Zhang
 <qiang4.zhang@intel.com>, Yuntao Wang <ytcoode@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Fixes for v6.9-rc4
Message-Id: <20240419143251.35ba9e253bb5fa07ad9b71dc@kernel.org>
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

Bootconfig fixes for v6.9-rc4:

- Fix potential static_command_line buffer overrun. Currently we allocate
  the memory for static_command_line based on "boot_command_line", but it
  will copy "command_line" into it. So we use the length of "command_line"
  instead of "boot_command_line" (as previously we did).
- Use memblock_free_late() in xbc_exit() instead of memblock_free() after
  the buddy system is initialized.
- Fix a kerneldoc warning.


Please pull the latest bootconfig-fixes-v6.9-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-fixes-v6.9-rc4

Tag SHA1: 7b37e0d614e8989ec4163385fe76fff290f005b9
Head SHA1: 298b871cd55a607037ac8af0011b9fdeb54c1e65


Masami Hiramatsu (Google) (1):
      bootconfig: Fix the kerneldoc of _xbc_exit()

Qiang Zhang (1):
      bootconfig: use memblock_free_late to free xbc memory to buddy

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

----
 include/linux/bootconfig.h |  7 ++++++-
 init/main.c                |  2 ++
 lib/bootconfig.c           | 22 +++++++++++++---------
 3 files changed, 21 insertions(+), 10 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

