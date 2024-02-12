Return-Path: <linux-kernel+bounces-61210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25F850EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E093B22A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BFF51F;
	Mon, 12 Feb 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="bvObkm5H"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BEEF9D1;
	Mon, 12 Feb 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726957; cv=none; b=hedxwRhQnN/FGrg/kQkJ4FFL0lBHg7Ona6xJnRknbj5N97RLAHVcM7wbvhLzQTP2Q6FzEvmZz6xUJQrFzRRIIexsNrXyLSN/vAbbZW3fqZr7QyvHzAnsiGzkIm8gF0WSC+MCrJkSd9IXSo2zEgNjH9PWGjUeRJlklY+XB39PcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726957; c=relaxed/simple;
	bh=w1ug5f6hUnfEuPkM0QkqCHBKv635l2fTPHDmLIaoiXc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sOGvHW0XoA3sUNQWbg9aG4yWR6t6JXwG1nwQZWR/0GpxZzMnmYXOBD5xotqR8Yrv5GiwlYkzjXVtsExFjeE2pGpiDDQTdfGtTDH+NVSctM+P/6lBuv75TVEU7/wxSyB2KL+Jgr72H5bIkvDpT4mQdOpLAKhoK+6zpxgskbhR7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=bvObkm5H; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFFD0DAEE5;
	Mon, 12 Feb 2024 09:27:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1707726472; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=gRQnEWypCadeqvbL+vmwS34Wbqw/hWUM4+gmTysCrSA=;
	b=bvObkm5Hlj4DbWiRPj50AjUY6QFGABn9ZqRna5CIudT9XdVY55TgmhjyysUdOj8DORd2tL
	Oeal/Hwp84p8ZFisn0NDYc1W0twNd94pSBK+5xgeLtP5ybXM+6eVq8dbjeFUwTGZVV+NcV
	pIR1wwHVhn+IUwdojS6RloSsUVPWYDA9EwmKxS0lz4mSZFKo3KLsNcGJUG76tFsPa8DsZc
	6PBTllc/MF2nD503KuoEeNj7vSz4as+fdxfW64EWzHFIIzYO7J2UuMplkhjqJJLjTxYCmL
	PrF6XkC3PzS/SsYSls+37BlKPDimdRQ8dIo77dsrufpN/XaaHRbcTBAB69OTjA==
Date: Mon, 12 Feb 2024 09:27:46 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.306-rt132
Message-ID: <170772427646.3451.12991319668074447665@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 4.19.306-rt132 stable release.

This is an update to the v4.19.306 stable release. There is a small RT
related changed due to the backport of

  f8f261f9ade2 ("crypto: scompress - Use per-CPU struct instead multiple variables")

I had to drop a downstream version of this patch

  "crypto: scompress - serialize RT percpu scratch buffer access with a local lock"

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 138ebc1820d1462c623c367c4d243855d8956bf6

Or to build 4.19.306-rt132 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.306.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.306-rt132.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.302-rt131:
---

Daniel Wagner (1):
      Linux 4.19.306-rt132
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index a328b97369c2..ecff281e807f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt131
+-rt132

