Return-Path: <linux-kernel+bounces-60699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AD8508AC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946C61F21D75
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B885A119;
	Sun, 11 Feb 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vu8yU5dA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532958231
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707648129; cv=none; b=O1uMdixnHHBEpYYCTFJNquZMaiU1qyJPORR1bKJuC5ENYko6oaUQ8P0Aedd2BKTgRN4NBfxB6+dldTH99Lnj3YFX21kshueKcUwGA5mYtM2/xVTa8gzm3MVa0sNVRQLHgds0LLfgAYaC9ReexX4h4GA2p708D7DJBeM2W11UC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707648129; c=relaxed/simple;
	bh=yqJTFHQKRuf3McMWjJjCtVjJDMny2ZXReTr5EeuBmk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EjzzBAvfOVH7pKN2ILLwN02fXR1jpg9lT6e4GCoSSaOuolO0eXbz22Oxp+aydWi2G8CYbW/7m1YYTEiCPGW6VGZDohp9HiewxgzYNsI20zGrn9c3rMRwWKoRGqHETH0Zs9jWNI3nGZ56tkNiKhHW+KZZB48IQtfOCi1XlaBBDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vu8yU5dA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 90F4240E01BB;
	Sun, 11 Feb 2024 10:41:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q3NjUKypKKOW; Sun, 11 Feb 2024 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707648115; bh=INX6uI+1dONLEWgYgztCUTuh9r0lrQ79ihh95+KUsSM=;
	h=Date:From:To:Cc:Subject:From;
	b=Vu8yU5dA57ikBNs/uF3IU5JPO0pqAmUIYJdZkZEP8EQcTGQvxw9TzSQ7528Mw5uA1
	 bYYunxr6c86W2nNrGiqcoBHWD1Fsc65+u5ahtd6/QPTqej+Lilsym1AY/qwg1pQwo3
	 2vcFPoNsMVE0Hr1g1LI3lzSrOFWJXPrsHeq1c+evzZveqg8lbA9Ti+jA7++YAOyOiq
	 rIhv4YzVaZdY4JtVcsRYaC2utrMZ0qEDgVcTkk1q6TqWBy9ZmD54MKKb1m3vdF2swJ
	 QsjCOj4VfX/5kT0WJCJKVewJPLOZPyFM06CQY0zVLtjyv/Lj5cJfz5DnYZliuReQWq
	 asIiM3Ks2vA3JeLgeq426xXfJ3slgt44tP4Lwxn5aXkP9RcMS4LC9jt1eKI7UlpQ8e
	 MhXm9nH3D5I0+Obt/yYdxidWhHuBY1QUlXaihaCKuFTGRfQRHNYgCJIE9u6UzmYDNY
	 sxAv0hmA2ehx7NooL0qU1nWtr7u3SfKiqXUj9lcwYMJNzhx5JPzi4ankMBxlmostTQ
	 lZegO6ukOVHd3545RAJmidADtpW/qdLfswMKEp5OE/zR8f6hVPjlW/YTLHsBy9dXku
	 jEAw62urQ0U7oSyzGr/sMlpop4qww8fL5rr8sFj01n4tqe4YKV97kcVLkhVp3kzXm9
	 F1VvR3VlJvMOrO8v6jfg1YvE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C37240E01B5;
	Sun, 11 Feb 2024 10:41:52 +0000 (UTC)
Date: Sun, 11 Feb 2024 11:41:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.8-rc4
Message-ID: <20240211104144.GAZcikaNw7Luaj4XZy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent x86 fixes for v6.8-rc4.

Thx.

---

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc4

for you to fetch changes up to f6a1892585cd19e63c4ef2334e26cd536d5b678d:

  x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6 (2024-02-09 16:28:19 +0100)

----------------------------------------------------------------
- Correct the minimum CPU family for Transmeta Crusoe in Kconfig so that
  such hw can boot again

- Do not take into accout XSTATE buffer size info supplied by userspace
  when constructing a sigreturn frame

- Switch get_/put_user* to EX_TYPE_UACCESS exception handling when an
  MCE is encountered so that it can be properly recovered from instead
  of simply panicking

----------------------------------------------------------------
Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Andrei Vagin (1):
      x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Qiuxu Zhuo (1):
      x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

 arch/x86/Kconfig.cpu         |  2 +-
 arch/x86/kernel/fpu/signal.c | 13 +++++--------
 arch/x86/lib/getuser.S       | 24 ++++++++++++------------
 arch/x86/lib/putuser.S       | 20 ++++++++++----------
 4 files changed, 28 insertions(+), 31 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

