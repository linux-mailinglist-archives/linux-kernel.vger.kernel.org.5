Return-Path: <linux-kernel+bounces-128225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206C8957E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBAE1F2369A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14E12DD92;
	Tue,  2 Apr 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kuU9vlb9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285812C539;
	Tue,  2 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070636; cv=none; b=GbmqoXfycE0NNF0FXn9ZBb7YGJSRIqJoixLHljxOyTOQ6A6lKoegW56iYQDw8/w+n+yA+j2Y4ORBzNlOMvEzkbUvwuK4XHI9ythaXvxHKui1m58fpEN+F9rlrCApwZb33gLs2qNB1Fd/4kSn5d6y5sl9biGWNS3ruyWj3OHsoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070636; c=relaxed/simple;
	bh=zEFjbw6jH0ERH+F2RnF4E/tJmEq7baboAoq4buDrfXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nMaUtiYIRUBDITF8A1NL0/QQGKyXrlPyxzlnH6C8siZDuTLE4lfkUltgLaDgnmdjYQ5UhZMRrqTx5iCJD1Awbp9VIiMR8a5CAzl9NZtmCsBPre8kcHKSXfyC8JWpUvmfx54xktUKOObRvyBpbcW6zytIAqJmTOt7Ze/Yr4JLhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kuU9vlb9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ADEDF47C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712070627; bh=KFvIEmjt/HBmwg6eLMZszRPJz6vHxblEGAnQbt1dl+4=;
	h=From:To:Cc:Subject:Date:From;
	b=kuU9vlb92POnufL/v4aVGv22A0SFHQ6PZ4GW6gHgE76PcB6Wr20dnRWOLv7TGnM/E
	 isBNmKYtA0W2azx+RdZF6WpWd/OlwyS5YveLDi5eWy6nWOi1l0FAPygidVMdJ9cjGs
	 Wd7+M5lToByxV7cewJ2eXSM9qMuql01siqFoMf459H25c2UuJU2q9jN+kt+matNJ/0
	 +Y9XRy9rreASEiIYfXGh18b27O2+Lt9VO+gNNa4AH2eRK7VfKAb3TKkXaZJUQGRzlW
	 UM7FRUoibijYO+5fJ6JJitlGi/rFnIFnBsg3LWnAxg6vQt45ORRKXmPL6D3nHpJVU2
	 h+SqosParaOmQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ADEDF47C1D;
	Tue,  2 Apr 2024 15:10:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.9
Date: Tue, 02 Apr 2024 09:10:26 -0600
Message-ID: <87bk6ryf4t.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.9-fixes

for you to fetch changes up to e9c44c1beaba623b12201d2028bc20f535464d9b:

  docs: zswap: fix shell command format (2024-03-29 08:59:01 -0600)

----------------------------------------------------------------
Four small documentation fixes.

----------------------------------------------------------------
Brendan Jackman (1):
      Documentation: dev-tools: Add link to RV docs

Donald Hunter (1):
      docs: Fix bitfield handling in kernel-doc

Vitaly Chikunov (1):
      tracing: Fix documentation on tp_printk cmdline option

Weiji Wang (1):
      docs: zswap: fix shell command format

 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/admin-guide/mm/zswap.rst          | 4 ++--
 Documentation/dev-tools/testing-overview.rst    | 2 ++
 scripts/kernel-doc                              | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

