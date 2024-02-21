Return-Path: <linux-kernel+bounces-75254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA885E549
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D201F23158
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EE85C7B;
	Wed, 21 Feb 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPx2MTBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0085270
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=l2Uzd+eGr2jdB451uijMUsVp6uKXpTjUMSTeV/LeZXu5KABihNw14IOllPfbORaxDtfg8IkXgWzVQzAC3O5bOnOhy5s5htG7TyDaQWoQzLEgDIk7kbdI43NotOSg+wSV/VXbORMmQdoXxsP6XZGV5biZuhvUVwPCyJeWv83gvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=Cn+JRPN2wIDYM95v/oHS3oFCII1P7bQgJXAqhNcOF1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hrIf10wYPJlgRM8O5UCq4aNig8PPfHyxRcrfioMAuWNw7Bh1yG1CygXAzg/TewRYJMOpEjWHud++8fUcwrex6I+ur9GWU+YbJlItPcWiGM4PA02bShumywMG7Q4PUGBzgSkm0NInV4uleAl3/PHCAehjqSqAw6Jdba7Ul9jobZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPx2MTBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41AADC4166D;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=Cn+JRPN2wIDYM95v/oHS3oFCII1P7bQgJXAqhNcOF1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SPx2MTBPLj7p/PWWfcoRwENhD/ztj5c/YRViIOLzzFOgsPUKZ+ByAf/0SXiecQzV7
	 gA1p4eVPnMTXqB6wPWxWrZcbKtyFMFtMakcLuEXAzkgWZGO2NNgcIGCp4XQ0LqvAox
	 GgWCQuyRLseabJ0F4h4WEdFQi+r3uCVNEErjz9+gDW/ue6w+VZ179YhpoWCOETXbuZ
	 25sCSkVkSsFkrkP3rXem4DS7DMYQUmewjPQBVY/XH2zJT2wv85hUFnEn9SEEd+P2MJ
	 31wVhjmE5/P/Jm8ALP3ChfPH9QNwoOechiht+6Aku391lhnwra3Ya8fwGt2Mdq1Jti
	 fKR4BrxUxMAqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20489D84BCB;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to create selinux label during
 whiteout initialization
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903112.7043.10216556441891626581.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:31 +0000
References: <20240207070548.3095087-1-chao@kernel.org>
In-Reply-To: <20240207070548.3095087-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 Feb 2024 15:05:48 +0800 you wrote:
> generic/700       - output mismatch (see /media/fstests/results//generic/700.out.bad)
>     --- tests/generic/700.out	2023-03-28 10:40:42.735529223 +0000
>     +++ /media/fstests/results//generic/700.out.bad	2024-02-06 04:37:56.000000000 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 700
>     +/mnt/scratch_f2fs/f1: security.selinux: No such attribute
>     +/mnt/scratch_f2fs/f2: security.selinux: No such attribute
>      Silence is golden
>     ...
>     (Run 'diff -u /media/fstests/tests/generic/700.out /media/fstests/results//generic/700.out.bad'  to see the entire diff)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to create selinux label during whiteout initialization
    https://git.kernel.org/jaegeuk/f2fs/c/697c9124d70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



