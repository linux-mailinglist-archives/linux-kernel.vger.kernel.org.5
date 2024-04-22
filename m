Return-Path: <linux-kernel+bounces-153583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A68ACFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D325B285487
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB5152187;
	Mon, 22 Apr 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="i54aG8va"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D21E49F;
	Mon, 22 Apr 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797515; cv=none; b=TCXtD4e+uZJkxd8xxxr0fTOMqC8sY4JVWbmFOUp2atVaoVFD8kTOEkciEPqjwzkId9BYfhfzIdJ2yg9z3uxW7xOAuSyrN2bNjUMRoYXFRQ60fksq7hc9kKNRr5sqp5w1o7YWg+LVjRs0X82fXM+TJjNtatPpuiQKNukc3FMRIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797515; c=relaxed/simple;
	bh=2aqAiggZBYZSF6q+dv7makmdN5JW81N9+n16hV0dMwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ev/BtXcWOiQ8lEED1idx6Mn0VMyVlaIJHNfxRePTZLM+ati8appzN/6jt64k9nMSfmZRjYNBs7xL3EpPn10jJrYCmT/4oghpzvWdM1jm3Ei9bXyQzx6ZdCA7O8l051pdlrhaNKFKdzg1NvBsMuHNskiJeO0pqzAbqz0XFUPY3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=i54aG8va; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4123F47C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713797512; bh=zSYiN+wlryW0C+GvuOLiBHEu0XIfQ0lel0K6D2siPGE=;
	h=From:To:Cc:Subject:Date:From;
	b=i54aG8va6qXqTA9WtqWbkSFZ9s/7dUB9DoEpasI2CeyXLADo6mzlG/aaB3A4f+jwm
	 mihPDrV05PEm/dWukuH0JS5ir1ymjW8is8V/reWnnye8RkR2ounY96DE9Tb4lYTaqa
	 Xn6qrWVkeVPCkjFsu99vrjD1GJQixtZbLVA0Hhrswycs75bQj+BoWtA8oivz+5g2zf
	 2GX+vQlEDezXZdsfa0wBq2EZCbycr0PjimKWa0v6Pk+4viCSsqX1gNZcZfP+rmOqtE
	 8VxJI+iiYCbhccadqs0SCQE5EOEH05biNwefA5YDurx7wjHI2FTBQFXlXftssdYbf4
	 +useFH9UV3byA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4123F47C32;
	Mon, 22 Apr 2024 14:51:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.9
Date: Mon, 22 Apr 2024 08:51:51 -0600
Message-ID: <87le5530xk.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit e9c44c1beaba623b12201d2028bc20f535464d9b:

  docs: zswap: fix shell command format (2024-03-29 08:59:01 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.9-fixes2

for you to fetch changes up to 8d939ae349343b55984ea821164e2be526d48cd1:

  docs: verify/bisect: stable regressions: first stable, then mainline (2024-04-15 09:41:56 -0600)

----------------------------------------------------------------
A set of updates from Thorsten to his (new) guide to verifying bugs and
tracking down regressions.

This is a fairly big set of changes for this late in the cycle, and they
*can* wait if need be.  But they are limited to Thorsten's document,
which is new with 6.9, and I don't see a reason to not have it in his
desired form at release.

----------------------------------------------------------------
Thorsten Leemhuis (6):
      docs: verify/bisect: use git switch, tag kernel, and various fixes
      docs: verify/bisect: add and fetch stable branches ahead of time
      docs: verify/bisect: proper headlines and more spacing
      docs: verify/bisect: explain testing reverts, patches and newer code
      docs: verify/bisect: describe how to use a build host
      docs: verify/bisect: stable regressions: first stable, then mainline

 .../verify-bugs-and-bisect-regressions.rst         | 597 ++++++++++++++-------
 1 file changed, 417 insertions(+), 180 deletions(-)

