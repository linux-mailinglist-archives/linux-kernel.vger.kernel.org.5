Return-Path: <linux-kernel+bounces-99280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700918785D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A122D1C21614
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336DB495CB;
	Mon, 11 Mar 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LSV4SPeR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9BF4D9E7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176194; cv=none; b=LIyc6KauBDTx4ugfjacYe0XsFIWwLDiYTC0sx+RQlMcMvOfae047hVFFCTU7pNjO7B4JYq4V4dlqHgZb/j3H80kem+71O4NhvlAMRa2gEl7ymGgjZIB7eq8gNlTP/D9FP338omf39RuNlAo6qnga9P/xSbuSSvPM2tnlpYuKgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176194; c=relaxed/simple;
	bh=MdKeo4cTm8SNFTwAngB+4+RNHWXpiq6bRG24KDvGvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Moomd88kaxBJyrvrdmqlGV01MIAe9WhNbFGpPEyb3YLzjlFniXw2OfxKCdFJk3IpOUT+pNDpe7QArsRT8lTZj1Onm36pEP3AJOaP5mfLcVod1WHBp7bGJJHLV5SlDZDle+Kr1Z3PPFIaDcH4yuLqmIx1BF8DoQsfI6upuh/Jer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LSV4SPeR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8842940E0028;
	Mon, 11 Mar 2024 16:56:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9y8Fy9mchXEl; Mon, 11 Mar 2024 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710176186; bh=wu/eZQwLUhGgvuZXlANArkDVudwpTIJlsyphkpZc+FM=;
	h=Date:From:To:Cc:Subject:From;
	b=LSV4SPeRAqp5J6WHCRvsYl/X1aQlUvnuPtAT4SUgly/HdJMMjbVZlS46BcGjhYxSo
	 S4uSAe0nCTUsm3PlT+D4GfaW+N1Dfm/Wt0jvTorYdYTnVNsdSFMKrqit+1b1oQ+Qmv
	 EEf3FpQlPbI0AX+JeTLulCmXwUuooIFnBguQ3vqQnyAOMnQRKHC+HhobxV39LyYbBn
	 S0KjpDA6QiSUqsU3B8SduwHUfcObt/eC0Yzz6Zk52yEXq8GyH2WlJnKOf/Kwtb7XLl
	 zxEcokJKbBgq127YX3ZFSd5U3HNd+zyp5mMZmMayDEg4Th/ZVv/ooHDpgMMqvS4y77
	 sXQNUF2p5lLzLPI/RhpqE/PWD3ECEG3930yKLhz8sFBHxYCfnTW2KJe59Y7hiMMH4L
	 UGmSFpV/TEQKL72l8asoJbtyHi6I+v6mM0ORW2dUQt1GRFARsWdohhIYpUw+aNGF+h
	 hcvVyDtRzs/F2OStUx6SZg6WNJ9+J1sL9yiBpglTeyl1on4bWnTnzrckICXfaqRGG/
	 ARo+AbNk48pgmAGFIQfZgxfHjqnbOfbYK5yKZ8BU6xd5WyDXTFB16AEL3+Jz/2WIby
	 DIZY2IuNGFH0ULPcB7MJfIN/IXYUfrRWs8x1Y9fRnzLe9iBnnWiXvbz+VpVai+2Def
	 9b/IPjZnFPyeBiXNOLM6Wa6k=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24A8440E0173;
	Mon, 11 Mar 2024 16:56:23 +0000 (UTC)
Date: Mon, 11 Mar 2024 17:56:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.9-rc1
Message-ID: <20240311165617.GAZe83sS8q6IWRhLhz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a pile of the miscellaneous, garden variety fixes for v6.9-rc1.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.9_rc1

for you to fetch changes up to d54e56f31a34fa38fcb5e91df609f9633419a79a:

  x86/nmi: Fix the inverse "in NMI handler" check (2024-02-26 23:41:30 +0100)

----------------------------------------------------------------
- Fix a wrong check in the function reporting whether a CPU executes (or
  not) a NMI handler

- Ratelimit unknown NMIs messages in order to not potentially slow down
  the machine

- Other fixlets

----------------------------------------------------------------
Borislav Petkov (AMD) (3):
      Documentation/kernel-parameters: Add spec_rstack_overflow to mitigations=off
      Documentation/maintainer-tip: Add Closes tag
      Documentation/maintainer-tip: Add C++ tail comments exception

Breno Leitao (1):
      x86/nmi: Fix the inverse "in NMI handler" check

Namhyung Kim (1):
      x86/nmi: Rate limit unknown NMI messages

 Documentation/admin-guide/kernel-parameters.txt |  1 +
 Documentation/process/maintainer-tip.rst        | 34 +++++++++++++++++++++++--
 arch/x86/kernel/nmi.c                           |  8 +++---
 3 files changed, 37 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

