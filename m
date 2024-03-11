Return-Path: <linux-kernel+bounces-99652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D8878B71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2074B1F2235E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC459177;
	Mon, 11 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d86AI0Pv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577D58AD3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199102; cv=none; b=J1l8aoHxw5qWOfP5aOJXlHIXEzpOUjaxJopUyEwt+RnVHPehe/LOYoD5H/ROB5caN2NUsviTOX22/O5+J4o649+DOCpHKge0hA/wVsVcLCErpHWae1Pd7Rmq8qFM7S5cyQcnh8GkIes7uy9u/s7iwc3kAsdD30vyCgfV6wuG2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199102; c=relaxed/simple;
	bh=kcHpKLOTWSyakDyehWjKlreMfqFrEkrbB0YTK19KFJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DwXfo0XtRPTvfrY/iW8sUB/V37GFaBeVgvICGLW1LA1ng9AWXT4p4DCwWMDrLzWit8j2JiQ/ghufLLaT+ycVrLW99Q7PotwN7mEXqogwJf4nHk8oAk17lW0EiOWdDH0EyFlTf/UgPsKpaA8U18rXrCHXtfma1L1qtBd/q5z6Ac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d86AI0Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A271C433B2;
	Mon, 11 Mar 2024 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199102;
	bh=kcHpKLOTWSyakDyehWjKlreMfqFrEkrbB0YTK19KFJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d86AI0Pvv5l5VhMM6KseJSJfGjiYmDmIFH4fJQMwWWeggXki9O42PBeRAhq4rn4ug
	 KZB07c5c83HWRKcn/KTtPfcHASPpqVRiOnU6XViekaTIxJRZlb342yUQVtGkmEBcr8
	 kfAtAcF62rFa94C7hkBv+qq4GAFAyKW++0w7CBBIYbhTkoRV8MjvFwOxjJ7TzZE8yH
	 BKL/S0M2f0UQ423YTVWD6535nVLj4cGfO3TaIfWNbaeME1ppLykTY+ot20w52Ugy0w
	 dcVcoA+nLRyrEQG9LgJkZqjjEQsT/8IB8MNmdCxfk8rsOO++dFsU6Psy36Yv36aebc
	 PnLK5KCKVq4Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED758D95055;
	Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/entry for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <171018178863.2492473.12231985539041412452.tglx@xen13.tec.linutronix.de>
References: 
 <171018178863.2492473.12231985539041412452.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <171018178863.2492473.12231985539041412452.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-03-11
X-PR-Tracked-Commit-Id: bb998361999e79bc87dae1ebe0f5bf317f632585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86833aec447939a886a13bbdbdf21c9628c5c8c5
Message-Id: <171019910196.25831.11398126920069470692.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 23:18:21 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 19:30:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86833aec447939a886a13bbdbdf21c9628c5c8c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

