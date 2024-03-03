Return-Path: <linux-kernel+bounces-89709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B886F488
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBF1F21CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBABA33;
	Sun,  3 Mar 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H6k8g3vg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689BB65C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463202; cv=none; b=fdx44MpGGZCaM2znhx69MKzxdAFmWfa6aIBD2C0+XP9TDtwssMu4Z5mMTPPVBQDjUanhcNvLVrFaKhwQPffOqqygHoTmpMfF84rEsAnUDnhM1b+Sm7tqAHc008B29WUya98P7jCPxPNkPrjxczqdIiXAXYtptSnL3wLduQYy1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463202; c=relaxed/simple;
	bh=wI4SKiW9XGcYzr0DP68rQ1sMkcqlqq03Ki50dXLEyDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZI3xaDHLrA1CqS67LQPtz4mNIzLbHW+Ouh4/1g83id6RlCfPf+HIsohNeeSCSLbrU92W7ss7UroBQO2xQM4pqnJshs2YzDz04TUlP2VABsAJzNM/QT/BxqRinifBVCevRqOf/THralRD6E6GviWuORJGUqRDNqXQ1fuRI8+6jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H6k8g3vg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12D0840E0196;
	Sun,  3 Mar 2024 10:53:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UPCERyjmOdvP; Sun,  3 Mar 2024 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709463193; bh=yzCITtHvXH1Imu68iSDIhhg9QvZ8rYfdfo2tZEbUclw=;
	h=Date:From:To:Cc:Subject:From;
	b=H6k8g3vgDoA1N1HOZVSHqenx1MrtPKG5h0jPNFiCyldDbeT/uzcaZmArESQeO32/H
	 vFgrzWB+afX/mIEHyHSlmsbRiddS5Xjev4EWAwqIGPrcSjWS2NFfA5Qj0gnAdNV1e+
	 fokZIKsgLQgrWa+8lfd6v0EHY7y1oXqqVgcSGCBAU1MSWCRQ7Ow35et2fhJNnnjn6O
	 fAmEAMLAXdz9s+CqxKgJ6yIl5G+tft9ni8JiSvUFj683P9MGrOa2wN29zdA7LKAlnA
	 p/2kam88w7FgVK+KCF+XYJ4BfKrQzOyA9ZVgRr7jAHJ8lBuon9kwc2C3sLW8WQogI1
	 +tlMqcXHKMsFA3pLVzB6n6/0F8xU+gdyfFnPnJS4sAPihFPRBVM2RCDDR7D5rPGlRJ
	 aMOHKg6gzJt/O9tO19/2/seftc52Qn52D+pFObTJMrmwLgvgXb7XebgkdbylFZFzik
	 rTuyX46mHFvhDEH3FLZJRU2PBogTqIy4Aj6YuqXGxrn5HxdHtUE1y0iUItWa65SehP
	 FdX+Rq1/T5wgtRE7iiZjdif0mZdqDJ5iUmMxBlLcmUnsrz+77QC6PTofNfxRLuCuWk
	 oPMkaDpMXH9pkk5hXaEYbLYPaE9OmqFi6z+cx2m6BE7k/GQ0LnjAPuX7lstPfa5J1V
	 2JcFTYrYEwCT3UfLEQorgwmI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8A6040E016B;
	Sun,  3 Mar 2024 10:53:10 +0000 (UTC)
Date: Sun, 3 Mar 2024 11:53:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.8-rc7
Message-ID: <20240303105304.GAZeRWkNr8xmllFHr1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull some x86/urgent fixes for v6.8-rc7.

Thx.

---

The following changes since commit 43fb862de8f628c5db5e96831c915b9aebf62d33:

  KVM/VMX: Move VERW closer to VMentry for MDS mitigation (2024-02-19 16:31:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc7

for you to fetch changes up to 7fd817c906503b6813ea3b41f5fdf4192449a707:

  x86/e820: Don't reserve SETUP_RNG_SEED in e820 (2024-03-01 10:27:20 -0800)

----------------------------------------------------------------
- Do not reserve SETUP_RNG_SEED setup data in the e820 map as it should
  be used by kexec only

- Make sure MKTME feature detection happens at an earlier time in the
  boot process so that the physical address size supported by the CPU is
  properly corrected and MTRR masks are programmed properly, leading to
  TDX systems booting without disable_mtrr_cleanup on the cmdline

- Make sure the different address sizes supported by the CPU are read
  out as early as possible

----------------------------------------------------------------
Jiri Bohac (1):
      x86/e820: Don't reserve SETUP_RNG_SEED in e820

Paolo Bonzini (2):
      x86/cpu: Allow reducing x86_phys_bits during early_identify_cpu()
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

 arch/x86/kernel/cpu/common.c |   4 +-
 arch/x86/kernel/cpu/intel.c  | 178 ++++++++++++++++++++++---------------------
 arch/x86/kernel/e820.c       |   8 +-
 3 files changed, 98 insertions(+), 92 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

