Return-Path: <linux-kernel+bounces-132907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C9899BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBFC1F22AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6EF16C68D;
	Fri,  5 Apr 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="l/U8l5VY";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="l/U8l5VY"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC916C457
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316648; cv=none; b=B36wBaY5P555BN1QpHlJJGC4FmbEKCDFcKi+hVG87kUTBv5W2L3Jw7wvhu6SsSLlI4/ICGeLaQHPoR+TPhEhBM4sK+J59pNqM3PtSc56KRoVCvlk3RDI+DT4iiJljsA1gfS82LlDkZp6ENbcMzsl/gIG5Ob5HOJo3H58BmoTJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316648; c=relaxed/simple;
	bh=wLhTNgOUiN7N0RylDeS2vmMKqNBh9y3uJy/BJN47Ok4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KVo+0N34Bvu1syie6MxSdEjcihwBos2DG1aPABBznHlSlkwIMRGoaAgcq6E2ivmq8XJkSaLdTy2HHQzjb2ZSgx59VlqEYEUD0YcF9CimOVrH+rUTfS7S7//HRvb76gC50dkvoQ4pViB5/gwcGDcjiRMU0ibtWG3sFHAsR6KQhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=l/U8l5VY; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=l/U8l5VY; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id BB83BC009; Fri,  5 Apr 2024 13:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712316637; bh=JwFGQtuIx9nBtXhUEYCcPHTriiYWg5V9szkMeALJdlE=;
	h=Date:From:To:Cc:Subject:From;
	b=l/U8l5VYoVAm8pdneMe1XFYNdC7XBDLqTy0sIzKcOs33wm4aDRCRpdvzAl6FK1M2k
	 +rm5XVemlziKY+of4YDuN2/vy3oKPrXOXq83XrLIgebwsjx1RzJcP5KKJ8pKh/lwcs
	 01Wow0Mp0kEKqybOFxG2ltk4DWjrfS5TEW/Xlke+fzMIMEfBQpaEiK06voIzo520IR
	 cd6szDg35/bVrMIQ2DAgdoUTmGZ/OIeSS7gkRzULQDAte04v29RFjVxPrLIT6i+rk4
	 v6MEV5yb2eOHrBlLLxc6ow6ciymcCu4NW8Sod56agRiICGpouueVtsIg62BaqNV0bL
	 4TukFGeQbBhdg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 31831C009;
	Fri,  5 Apr 2024 13:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712316637; bh=JwFGQtuIx9nBtXhUEYCcPHTriiYWg5V9szkMeALJdlE=;
	h=Date:From:To:Cc:Subject:From;
	b=l/U8l5VYoVAm8pdneMe1XFYNdC7XBDLqTy0sIzKcOs33wm4aDRCRpdvzAl6FK1M2k
	 +rm5XVemlziKY+of4YDuN2/vy3oKPrXOXq83XrLIgebwsjx1RzJcP5KKJ8pKh/lwcs
	 01Wow0Mp0kEKqybOFxG2ltk4DWjrfS5TEW/Xlke+fzMIMEfBQpaEiK06voIzo520IR
	 cd6szDg35/bVrMIQ2DAgdoUTmGZ/OIeSS7gkRzULQDAte04v29RFjVxPrLIT6i+rk4
	 v6MEV5yb2eOHrBlLLxc6ow6ciymcCu4NW8Sod56agRiICGpouueVtsIg62BaqNV0bL
	 4TukFGeQbBhdg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1ac11b80;
	Fri, 5 Apr 2024 11:30:31 +0000 (UTC)
Date: Fri, 5 Apr 2024 20:30:16 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: torvalds@linux-foundation.org
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs/9p: cleanups for 6.9-rc3
Message-ID: <Zg_gyHsrkjDiz7lR@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Sorry, I should have sent these back for rc1. There's nothing that could
break in there and the kdoc cleanup patch caused some trouble with -next
and another identical commit, merging something should help a bit...

FYI there's some regression with the cache rework that came in rc1, if
we don't figure something out by next week it might make sense to revert
some of these; I unfortunately couldn't reproduce Kent's report but will
try a bit harder this weekend.
These commits have nothing to do with that and won't conflict.

--------

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.9-rc3

for you to fetch changes up to 2a0505cdd8c8b12670f4b5a6eb5c996c0861c2d5:

  9p: remove SLAB_MEM_SPREAD flag usage (2024-03-04 22:04:32 +0900)

----------------------------------------------------------------
minor 9p cleanups:

- kernel doc fix & removal of unused flag
- some bogus debug statement for read/write

----------------------------------------------------------------
Chengming Zhou (1):
      9p: remove SLAB_MEM_SPREAD flag usage

Dominique Martinet (1):
      9p: Fix read/write debug statements to report server reply

Randy Dunlap (1):
      9p/trans_fd: remove Excess kernel-doc comment

 fs/9p/v9fs.c      |  2 +-
 net/9p/client.c   | 10 +++++-----
 net/9p/trans_fd.c |  1 -
 3 files changed, 6 insertions(+), 7 deletions(-)


Thanks,
-- 
Dominique Martinet | Asmadeus

