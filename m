Return-Path: <linux-kernel+bounces-105520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B3887DFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6AE1C20B17
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308141EB35;
	Sun, 17 Mar 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx1U78B/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453B1F947;
	Sun, 17 Mar 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704047; cv=none; b=XwWFmIcG5ur1TkumHkTaKGqo37VorYXOdw9MCDscaKckWs3SE2KrJtwYjctj2A69JHBsIhnH+FJ/Dx93/k5NH9U5XuTe5SYfHrygMglEAGrrrtMG21Vgj3uyc3ZqzZ8hHWm5s+XYCV3YrQRazR76UK2lSWha5bGFLFp/onknv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704047; c=relaxed/simple;
	bh=Qt0tf6IJBhCU+85vFfK3nPwFLq0q3bAnMHqSePJuzP4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SH7GHfTiabzeGLV3wQdg+UKQo9BX8mDdxgqVsQgD+QoYWq+3G3eXDMugh8/0GnVXXHpb7zYLCq6FFyx4oyy0Ww81FwS+UgHx/3stdUHOv9CVxkrt5FNrXqJHCicGKlQPnO2QNX//e4jp4VGHfcpyLDQ6o7ANTzvu2G+ZzvaG09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx1U78B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5045BC43394;
	Sun, 17 Mar 2024 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704047;
	bh=Qt0tf6IJBhCU+85vFfK3nPwFLq0q3bAnMHqSePJuzP4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gx1U78B/lr5gsX/juNWoESuDqoYNJZlTWQsZRJkYzc/wYk91ITIZnqDEIzLK2xDgg
	 qTwtxSciNRF5uzzSz0yrVc1oDnNtcG6pxk10teZkUMluKwpLcikBpikNO/Sy1YPd7f
	 qwQJDtv4ftdz3qTkLF2psAxIa6oaue5mF8s/JV8IUeH0Rj1ds4lXuEePWiIgjmJq25
	 9jib7HfPQV6NentoWTCZhZtb4/Os6IBgHGYfy+GJsFdXSx3pJNqkjTufuDbjBkQpm1
	 H+GfZAxslGebHPI58rj9QXbDqyS+gmT2xCy37usJ6WlI6zQ+ku8ZQAUVOjjRxP7Ig8
	 PDCyHHStjqNRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42558D95060;
	Sun, 17 Mar 2024 19:34:07 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.9 release cycle.
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240317112437.GA9174@www.linux-watchdog.org>
References: <20240317112437.GA9174@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240317112437.GA9174@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.9-rc1
X-PR-Tracked-Commit-Id: 6fe5aabf7fc645562faec50c79c7a21a4dd1cab6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 032e22febfce848f913a1162b12028fc847f3f8e
Message-Id: <171070404726.21222.13677654908053946275.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:07 +0000
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ben Wolsieffer <ben.wolsieffer@hefring.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jerry Hoemann <jerry.hoemann@hpe.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Minh Le <minh.le.aj@renesas.com>, Stanislav Jakubek <stano.jakubek@gmail.com>, Varshini Rajendran <varshini.rajendran@microchip.com>, Yang Li <yang.lee@linux.alibaba.com>, Yang Xiwen <forbidden405@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Mar 2024 12:24:37 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/032e22febfce848f913a1162b12028fc847f3f8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

