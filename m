Return-Path: <linux-kernel+bounces-62446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3A8520CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F1528675A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A84D12D;
	Mon, 12 Feb 2024 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="so6fhtMf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31A48795;
	Mon, 12 Feb 2024 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774974; cv=none; b=Dzucfz8AIIwybi1Wx4+U0gWZH4Aw64a3KdjUFjIciZkrAaphLwlqFpGU1vIGmhFVp+txIA1+9Ul9FJYmYzXbyhWfBxGJlRXjTUanTzBvNhzluprbBPUhYffXX2d9QZ9AyOUXqAIctlBAMd11X+Otl5OmuyQWSsaAuDZZ9WcOSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774974; c=relaxed/simple;
	bh=ylcswwu0/V7Cg6VIYKTuBr0I1uHFFTucMrk1MaPdYRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D6OiP+52U0bHOR5i60SH3TB+JR5pTCp6CHKvRxR8t76SkN7xxa0sZESMBnj6b7gPSgAHGL3IbsdOiOinNstVlDHssTDd8Qd5NprvL2vtXwlp5tO3wvskaRF++G+r7bUf8Ec9A3V74UmoHRfrpV3Sd0HTq2PO4Mkx3Jjlt6h16o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=so6fhtMf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 85ADE45ACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707774971; bh=Tu2V/uWZ4dmE/6XzFzoNQKXQCk9fdy2J4SN/80ToWec=;
	h=From:To:Cc:Subject:Date:From;
	b=so6fhtMfLj4MjG3QUykSNvnrS7N4S2N+eusnB/pPTPuANUtRVLJLldA+lzkxqSKku
	 JyYVPENqcMhH2dHHGFhTMorwFIj95o7JX8TJP6yxcqCGFasLQwm8Yyk5KFzrxB3+9A
	 Izn1KsTBmFRto/G6/Xc5zdpnUBFEAJZ6aNen3DOLsC9yWlmS/NHte1PbrrcXOvvGLS
	 aGiaCMDFoC1nXQzbITkBRKtq21Zwdd/53ndiT5G2nNxKNgSQ8csdG0EtxicjEyPzEm
	 lu96pBUOIM7eRFe/RO74mvNQOvEmIPE/TgcxJdz5YgJwC2znq6GvzAnMw4hBNx4Z//
	 dqNk44gsv/gOw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 85ADE45ACA;
	Mon, 12 Feb 2024 21:56:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fix for 6.8
Date: Mon, 12 Feb 2024 14:56:10 -0700
Message-ID: <871q9h8hz9.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit d546978e0c07b6333fdbcbd81b2f2e058d4560b5:

  docs: admin-guide: remove obsolete advice related to SLAB allocator (2024-01-23 14:52:37 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.8-fixes2

for you to fetch changes up to c23de7ceae59e4ca5894c3ecf4f785c50c0fa428:

  docs: kernel_feat.py: fix build error for missing files (2024-02-08 11:05:35 -0700)

----------------------------------------------------------------
A single fix to the kernel_feat extension for a bug that will crash
the docs build in some situations.

----------------------------------------------------------------
Vegard Nossum (1):
      docs: kernel_feat.py: fix build error for missing files

 Documentation/sphinx/kernel_feat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

