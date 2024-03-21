Return-Path: <linux-kernel+bounces-110754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7188633F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795F61F22BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C4136992;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks6d0ogO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB662136664
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059921; cv=none; b=aYZaOVNkBatfmum2teq533ZhDskf13deAg+s2CHfja5ZOzBH1e/GVhDE/entmJZ8MSEQZ0V5Gz/jHLcdOAGrrF8ERpCsrZgLLjlFvE9R0cmeuYNKq5fIXuqtezaiZxyUp7diq0Ci3GcxnQTIz5t6u7hhW1zYkUH5yFah4V291A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059921; c=relaxed/simple;
	bh=soPv1CzKuRTfvt5xQaBRG5/i9ExgZJukU0v0Jidz55s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HF9KSw9cas7P8q8Zzj/dTdayJ78yCD2EzlOMkV2bgqdRjDT1LxyhOhpyr8FxAEG9florMRVSHB5aOdgB6I0cQej8IQHE77YIXWxkH6PnKznr0z+LriUQ3y9HYaqWFXSTAoIPg/2jCcyKoVqcx7xNyrT3vDCPzn+uMQoacSANJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks6d0ogO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC3C4C433F1;
	Thu, 21 Mar 2024 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059921;
	bh=soPv1CzKuRTfvt5xQaBRG5/i9ExgZJukU0v0Jidz55s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ks6d0ogOCMAuh70pHS3c9rkM3/pjDaVxG9S39Sg8hh3I6qQ/dpvueu1hXNeS3FuCS
	 I60wl8gePpWB7s9kcqlJyG2eXVnjnZaFvQ5CIV2ZlEGY5wfezu64KyWsIk+Ez8D91Y
	 Aa9qCEjY/79LgSe0UGlpMe+f/0N0pKsxPDquF0Q+S/nU9URouAXQa50itERykSudnY
	 tZTqHkFbyteUH5mrDoE+WbhCV5ldmEgqPG5kXnO3x62Hv+haYvlhvUA/UZViJtGAa2
	 NXmbI91JnNY+1Kx/aYIGsEVRnu8V64zU4w55o32bkug+6mYxwTGwcRk3XHrI9bt7cM
	 Qn7OiT1DsS0EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5B26D84BA9;
	Thu, 21 Mar 2024 22:25:21 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240321131100.GA755005@workstation.local>
References: <20240321131100.GA755005@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240321131100.GA755005@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc1
X-PR-Tracked-Commit-Id: bfb1ad3c6aab2341ace13222ac0a78e5b4c239c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88d92fb1c034922572bab93482ac9cc61d4ba43c
Message-Id: <171105992167.29795.17088008792095885675.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 22:25:21 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 22:11:00 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88d92fb1c034922572bab93482ac9cc61d4ba43c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

