Return-Path: <linux-kernel+bounces-48842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639A846240
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DF61F26A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682CA35;
	Thu,  1 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3AL3ffb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FE3FE36;
	Thu,  1 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821351; cv=none; b=gD7oO5uKE7UErmEx2DryQTOXYTR6mpLjyIh09PMVzZGWST60kQ7KXXdkDUK1WNVKA7l5QPZP3fnTOX/nNegUDprchuIgGaM+teOJ4BNd9AnGKDTyJjaDeJVhV9xweyBpEO+jAfYBLG96yeWJ0Mvxrm/JMAl/4euRGIWBqka5+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821351; c=relaxed/simple;
	bh=op37+Q5Oa4HbKg1MoPEYNH5UTRUX/lJK324kABRVz5s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XmmJk55Y+BGVjVcJmNylBZ+r0TmN5c+yU7S50qLQ/3dEPeJTtyNPevkWMWCRF8Cene9Ein+eVzsV39EQrQVjzWwQ8eg5OoOfoABPVyaLdZfthJYjZeXsyhU4ezdIzQRgjXuTYXMogWQuJBwTk/MlF4WaRxChPbvEowDzlxeedr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3AL3ffb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1FD1C433C7;
	Thu,  1 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821350;
	bh=op37+Q5Oa4HbKg1MoPEYNH5UTRUX/lJK324kABRVz5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X3AL3ffbE5R0Tf4AmVH++p6xToiNsFB65LaEA/m/E71rj8SiEC0eRtKA9eybhHNxo
	 QwFa6rSPV7824VQ1WCO++kGPExg15KY63aoKbZjYHpXlUQ688NhESsr/XCJsFt6/Dp
	 SUHNLErJWkBRvzseZmTcy5Ay5ii2jclx1tNTeEBqI/prTYn69pLcRGsmPYcDTn9fX6
	 a9lC/ZwzPk2XIuAJ4LpR1FF3yOKmfBol2YYA18ElQP8WLfv+WwLDeJsOJh3T2O7/38
	 iP0xcBrD/PMXR2JxcnLMiTFgL0f+WLmpy98lhCsGj9VmcuBjxPDzVo/JnSqj+qOciQ
	 NPHXqIZZVbKNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA0E7E3237E;
	Thu,  1 Feb 2024 21:02:30 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.8
X-PR-Tracked-Commit-Id: bfef491df67022c56aab3b831044f8d259f9441f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a412682659b3832ac6f1a301e1c147027926f605
Message-Id: <170682135068.25707.7865607496878684331.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 21:02:30 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 22:39:45 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a412682659b3832ac6f1a301e1c147027926f605

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

