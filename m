Return-Path: <linux-kernel+bounces-90127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D043586FABA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709CE1F212FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081013AED;
	Mon,  4 Mar 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="abuKTDQO"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027C8F7A;
	Mon,  4 Mar 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537305; cv=none; b=SHkM15DjM90ZhbVCJAGc0dI/Hv24Ds3izvUbklSGHO8ZyaIyw59u11ON5seQvlrZO8AGOrISP+QbwRsaF0ywFhCLVthA9ViF8QraESH0XaUXeHwESWhLyGSZ00iatq5c47VdCLZMWN9jAc6oJXub742SqmXkLZ5qZSq1nxy0CNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537305; c=relaxed/simple;
	bh=kzBLzsrgt4cMz8lq+7FEQRl39sR85fyZ63GyU6Vma44=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gvt3Ja6/6gkIXD4Vicn4JZZvR4DMC9F20Xqpo+kTke8QDq1qpMPkIgH9qI4tBan7KTZwrx2FBNTYif7blX0TFP3nfMzvYZpnm7vPsfxnwPvXFQ6FMAopL4HU39TXaQ/rDwLJA40JHwFDfM80Pc4hjBTlsD7grVy5eJwxMNf4J90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=abuKTDQO; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C675EDAE4A;
	Mon,  4 Mar 2024 08:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1709537293; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=obt2UjzUlSFkhzsihV8MAs+WcZlC8QBBp7aRz+cg748=;
	b=abuKTDQO2rjX+2dOAZHo6ypVIhCo4YEDD03WDHp6voy2gi2oUAoCGZPDHiYtCVe6dxopQ3
	tZw97geiGSBq9KjWEvh6j2XiszTX2T2N/VplUYlYjMAmq8MaU9Kq7kIbHBsTm4FKsO4en/
	9YOzmErS53t/bpgBac+MudVLW8+MKLwr4VL7bIDS4kjiiOVHnt/O8tdOkPe5rfv86xvadD
	02NOhcqYFWo6n0eCuWlyGnoduz97rxE6jE6Agbd0PI5F2VuvpCT5FH5QdCeu3aX/cw/3dT
	ZwbtEgAyRTzKLjtNBQZLwx+hb0GKKpwJ/HnZzXOLK0KvUQXs7T9ew/TJR/KY6w==
Date: Mon, 4 Mar 2024 08:28:08 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.307-rt133
Message-ID: <170953721122.2407.5652698542810172517@beryllium.lan>
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

I'm pleased to announce the 4.19.307-rt133 stable release. This is
just an update to the stable release 4.19.307. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 4790d0210f1929d981659cd4e7ecfb34e0a6889c

Or to build 4.19.307-rt133 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.307.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.307-rt133.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

