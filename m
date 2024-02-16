Return-Path: <linux-kernel+bounces-69279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9249C858689
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AA51F22007
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0451386A1;
	Fri, 16 Feb 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EIsTpwWx"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A11E520;
	Fri, 16 Feb 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114407; cv=none; b=lSXmZsEgrO/QYMSaeUS6yjhOM7MkK+VFA5yFv9UoeDBxAjPWNy2C5jHrG/PyPflGJXh6dt4XSvURp23aNXJNFkWceLQ01mmoErLiVkv2l1MjezPhdFdY83HNOArVmZSSW7jQ96WHt9BKxQl6cSkT4UgDn0hapgyVH4GhwxfvmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114407; c=relaxed/simple;
	bh=VHh3A/a2nR3iSQNoSou/NkN5vDVvHJHc6cRd27gcQSQ=;
	h=From:Subject:Date:Message-ID:To; b=BqHi9qy6bX54YG8LDMyoP4yYJxcstIUIJ61z5VAizE41tXgv2I4Ux4x9G9PoRkPPCkzCSKuyxjYMoUkdH+bbbhIAmW74rRmZYcCSErXEdwe1gsOVZBK6f3NRA5dD/gKktu+Omcg/QJfgULR0cHL858fWsUvmhelvIn3tAKYEi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EIsTpwWx; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4750C40ED9;
	Fri, 16 Feb 2024 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708114396;
	bh=mNXMXJpB6SYOKdJVIlb1vORS5AD/OoZy5hFTQSrzUiY=;
	h=From:Subject:Date:Message-ID:To;
	b=EIsTpwWxel+CCLCm+yIeVX341Km+y8gtnFN4efHT+jV5BHiYMLitx3Z0fDdIXPl+j
	 sSIXmROv0bzCuvqENZAWYMvHy8fzx5eBtiOPUs6Rn4IBQTYHGDMIO33pfUTIPjLSFn
	 eBuHm8pdlgsNR9msizzcPvPzN1Z+xzVMEy8FOyAREKfjdfdstzs2SvfixknMBvk/hd
	 ubY6LuuKkjPn1TITQPznaKC3ZV/BsCCI19K1EeUdPDAH/UofW5aYHQmxHPQhWPicYg
	 axqqZDwzTXGRIVSIUJKTZnAnpfuHLOxLk3VKCLdqu5SRVcjB9NSjLMxFtIVYGNVam0
	 ujfwKemAAeIqg==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.148-rt74
Date: Fri, 16 Feb 2024 19:34:38 -0000
Message-ID: <170811207811.495171.1435664719831296032@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.148-rt74 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: b24880f53d0b955d6c02a98f6c23c9c6837803fd

Or to build 5.15.148-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.148.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.148-rt74.patch.xz


Enjoy!
Joseph Salisbury

