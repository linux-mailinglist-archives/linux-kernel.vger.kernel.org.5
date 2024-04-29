Return-Path: <linux-kernel+bounces-161954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0628B53DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02B11C210DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C18A40BFD;
	Mon, 29 Apr 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVQwLACo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erzPJ3fE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB028374;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381327; cv=none; b=JneAY3PpdaLfXc/yNtm3yD8/DGb7EV1eRITfYXiFuCnt6siTI0cBkROCB2Bl9GNe8cZRg8vzapJWsbxi9EbVmSXvajvw1tgRhrZ9ik276MQ+m3/3RblKMX+c7h1TWEYECiyLA2KsJ8PPSs0gzks6qwNQIEeT6cuJWAqfhScYdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381327; c=relaxed/simple;
	bh=FNu4OZDpaifaqU1UAM6Hvf2ci30vtleDRMjd/58y1gY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VjNtekctWSinq4W1kneonhD5NHHxoAi0+5v8N23PDjZND2KMJwaQt6LM7leVvWQ0NCy6XbDnsE//oQMCAdN5Tlbmk4j2T8HKuap2XYZjf4+shrc6PprGrw8Dr87THQxQHlQiOQFu2BPaS6yHHiQx8l73wSn9nGDiYKvfOW+g8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVQwLACo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erzPJ3fE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lm2DDrCSYYnyCQ3ZBAlGvUoNcQKS5sIb24sdik9EYBM=;
	b=UVQwLACo+pwFvvaeknxVydOmlNjGcnOkkYiV/xaTPOXB0pWgUobHj5Ww76NpFejGRmt561
	uMs8VjS3iRMbsuzTr+TD60ZTpqmaqy/5VSnfHmBJcZxJUlstOoOch+LfdMaTI17bl/M52B
	z2W16rHF6vPamuBWDooZ/XhBVoL8BYqvYgFI+2qt6ArkUHzIoNH7pQIQtjMEIJ6G1J4BSz
	scZiz+nwniNSJ5r4TeWIY3sT463yYzNhAannBuxRoEj7gKCmHJMj+TTVOFSV7pYFgmR0VM
	n3MCwvuNSoGtmizNSILPMGZ1VwDR0YOMZ5pGciOdM4TwdcZf4RB7LZ3PzSFjkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lm2DDrCSYYnyCQ3ZBAlGvUoNcQKS5sIb24sdik9EYBM=;
	b=erzPJ3fE0BSU3hJiPfiIM0PRWl02XNZ4anhlLjNFpjSSaiPw+te/61Nqb7Z8s357TyPiUQ
	+ZwZ3pDsIrHtw5Cw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131471.10875.12730208932991816010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c73cd372210343b271159eab0bdc95820e5e7b86
Gitweb:        https://git.kernel.org/tip/c73cd372210343b271159eab0bdc95820e5e7b86
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:11 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:19 +02:00

x86/cpu: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181511.41753-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 2243083..8651643 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -25,7 +25,7 @@
  * asm/cpu_device_id.h contains a set of useful macros which are shortcuts
  * for various common selections. The above can be shortened to:
  *
- * X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, NULL);
+ * X86_MATCH_VFM(INTEL_BROADWELL, NULL);
  *
  * Arrays used to match for this should also be declared using
  * MODULE_DEVICE_TABLE(x86cpu, ...)

