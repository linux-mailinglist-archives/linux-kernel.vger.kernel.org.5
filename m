Return-Path: <linux-kernel+bounces-145943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAECA8A5D20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1801C20C31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217915748A;
	Mon, 15 Apr 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou9u5o53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D9823CE;
	Mon, 15 Apr 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217449; cv=none; b=XMsyWbN4EfgiWm7aB6nyolaRL0qbdflZoJkkBNhAjIcem4bpxDyP8dEWJ9eVVYXlrGWRuk2Gv3h8Zj8yraHYJh9EV07MyvzdBeIXk8FIgvBmlN3N9hd4I8XCaGsYFQeOQuxWezLnX6nvFvKU1syyxGY8xMkYAF3x+uGsHw79dyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217449; c=relaxed/simple;
	bh=swy2FSSjTCKS2MvNdsbxzXAB9D8aR5LyXTLIgRkoS00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWTg0tslcfJ8DwRPPDkur1WiUhRWWo5465twlMBJ0Pe4fEEFGxKGsezZ0NNpEa0CMhVDCmafi8new3HG0xPCu5SnC3EHxMjcSVy2eGUrDtoGEe5eG2r/X2OiGycxe1dAPBvicHOYuo/BRgu86hE6VFoKLNJ/WPflz+aJ+gVTJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou9u5o53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E49FC113CC;
	Mon, 15 Apr 2024 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713217448;
	bh=swy2FSSjTCKS2MvNdsbxzXAB9D8aR5LyXTLIgRkoS00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ou9u5o53zv+k1n6+O6hRjbZGyam9WowNV1hkdp/tSJPZ+ZfhsMNE3AM1u59P6+v9L
	 YMz1CEv0fwtTCA0y4i1qIb0glGqZoXUF9hISjmTwAjQTwQBjh8oPQBAovlHUgrvdLW
	 umBF5jwnp4J139MqhFfC8qEHeHCtLbh+468lBsu2VIn7Sq+vyW7ZHNexttaN4lJwES
	 g3yUc0Gmm/tmE0bTh7E57iO2bhvmWDb3CHJv5sj097ja6I3+VLJOZM52fM2Y2Em9s/
	 KJEj75YJSl+tqWhpMC3RVLTP1p0Z4SXLBtIV7wTfu7icg/jlazR0g2UH1610I+sTuH
	 G+hPqiAF8ZjHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Qiang Zhang <qiang4.zhang@intel.com>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bootconfig: Fix the kerneldoc of _xbc_exit()
Date: Tue, 16 Apr 2024 06:44:04 +0900
Message-Id: <171321744474.599864.13532445969528690358.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202404150036.kPJ3HEFA-lkp@intel.com>
References: <202404150036.kPJ3HEFA-lkp@intel.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix the kerneldoc of _xbc_exit() which is updated to have an @early
argument and the function name is changed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404150036.kPJ3HEFA-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/bootconfig.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 8841554432d5..97f8911ea339 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -901,7 +901,8 @@ static int __init xbc_parse_tree(void)
 }
 
 /**
- * xbc_exit() - Clean up all parsed bootconfig
+ * _xbc_exit() - Clean up all parsed bootconfig
+ * @early: Set true if this is called before budy system is initialized.
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can


