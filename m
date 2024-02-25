Return-Path: <linux-kernel+bounces-80036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E8862A01
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3AB1C20A97
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22189FC1A;
	Sun, 25 Feb 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TBYHVhbM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B9D528
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708858022; cv=none; b=mMiVkXD9eq7tt4hquK9nAdlx+fLwFkbg2vLd9HvuVWvjFHw0cfSr45wmBpnw+QT+tWEls4x6ePFqskC8PVctIrNjIgtZlSNgJBOUU/qETPg0N45dye/sohlhtMDDM0xnKGNBB0ymyvwUdMsXESSwFJsemTZ0BFE3JF7XcDaw5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708858022; c=relaxed/simple;
	bh=BO4AiwQWsQ/NTNc9hAjv+tHy0UZ+LgIgao5FalbyKl4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NItC38ek4kAvwKjTFjoIqr3KBSlsQ5dJ3E2pVPcrKKCNG9UItkBAk63rzGnLUOxIJBIWqVyKW0ngtpu4PfgEdm3xm0tBW2cS4s0NFkZccrICQ5dVVE1O9qM2DDtxoD2+uoC1MjAktCaMcSxumpGmC73v8Lbh6FLIc3zOGn+74Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TBYHVhbM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C00C40E00B2;
	Sun, 25 Feb 2024 10:46:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qqvXSSXQOSM7; Sun, 25 Feb 2024 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708858009; bh=b5M5UMzTb6ZvTZ5Fe3UalurJ9+5PLjRl2ExnJnelVvw=;
	h=Date:From:To:Cc:Subject:From;
	b=TBYHVhbMmgrotugy2DfN12qEvdfqUQjB+mLTibuZqsD3BMDv31KCiUwZUo5Dw20H1
	 9UAksyudLuki/w+4hOD+cBeMGU3oo3Z2c49mdsHhenPXfZRHL0/bK4IUkLKPeVQx+a
	 XtSuo8OyuN/tyM2tzQEeSs52RbnhsJIiH9AeqGW45i5QpNfK68pK60nsaG3cyqLRiN
	 3AImOyfGwOlUFQb2Udc6lEv1jYjWoO5YFklkfax0lE9di8Y1+jZRTtArmyHOjhV4OK
	 vAnlYPNZgkx0dy/FeA2pit78ldxYgzNLhlYXS/sR8oVRXaSB9JUcVMxDK0P5xptmjO
	 L4MLwMsjPenTTX3bb/W72PzChEyTnE5tk44b5Ylif8O532gqlc33a6lrkLMZaODlqf
	 Yhe8MO6mwOuJNLTYbstqjJFS+wtRxOfMN/vBHZiK/s/2IBk91bjMqxYt/l1idRdHlB
	 Tb+1I0IpRBxWrqWyYgCnhboXZ55VfgRUMROLHBfS8n+tjaQZFZ2E/jbhCdeRH0IO/M
	 wkaKVrvwNVQoGIE0DOVOksM5seD5Wc5gncmFWO+5s/dIV0Mv9ZRBoL9e2X4LjLSTwK
	 IxwOor9TafIPT1yn7CYX9lxawDrmcIk2wR4ZZ5U5rAMh0TKGolpADZyXJcFz2Uj2PU
	 z63yaW+o032vy/D9JOjhi3VM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1490940E016C;
	Sun, 25 Feb 2024 10:46:46 +0000 (UTC)
Date: Sun, 25 Feb 2024 11:46:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.8-rc6
Message-ID: <20240225104638.GAZdsajv3v8YcNNqJt@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent IRQ fixes for v6.8-rc6.

Thx.

---

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc6

for you to fetch changes up to ec4308ecfc887128a468f03fb66b767559c57c23:

  irqchip/gic-v3-its: Do not assume vPE tables are preallocated (2024-02-21 21:11:20 +0100)

----------------------------------------------------------------
- Make sure GICv4 always gets initialized to prevent a kexec-ed kernel
  from silently failing to set it up

- Do not call bus_get_dev_root() for the mbigen irqchip as it always
  returns NULL - use NULL directly

- Fix hardware interrupt number truncation when assigning MSI interrupts

- Correct sending end-of-interrupt messages to disabled interrupts lines on
  RISC-V PLIC

----------------------------------------------------------------
Chen Jun (1):
      irqchip/mbigen: Don't use bus_get_dev_root() to find the parent

Nam Cao (1):
      irqchip/sifive-plic: Enable interrupt if needed before EOI

Oliver Upton (1):
      irqchip/gic-v3-its: Do not assume vPE tables are preallocated

Vidya Sagar (1):
      PCI/MSI: Prevent MSI hardware interrupt number truncation

 drivers/irqchip/irq-gic-v3-its.c  | 2 +-
 drivers/irqchip/irq-mbigen.c      | 8 +-------
 drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
 drivers/pci/msi/irqdomain.c       | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

