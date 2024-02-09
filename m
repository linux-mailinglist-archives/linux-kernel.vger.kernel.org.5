Return-Path: <linux-kernel+bounces-59829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395584FC3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703811C218EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7684A50;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCeb2hpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71CE83CBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504382; cv=none; b=Q7LjCMaeiZwS7dhhLRp8EUYEEDDrG14CJNxXbYZicgSRuUVDz/1lff0vdqo1t6cgeUYVWy06mjRgyWj5Cj2NHBFSb0ywNk8Klkh8Mgk6RthTuxKs7p51f57mL35C/EwKe594qb/Lr1wRzOBnqlUarU8djVRwGkzT8fAchHnQMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504382; c=relaxed/simple;
	bh=UjGzbJnF990WfC0Wgu/z17brvharXCEJIuwvkJvTiTE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L7Jw5q536CJgO4SFohn84xuJmy+m0orrD5mn3EuKZ2yyIZ+jZSXPC1QsFKZGBKLRdJV8OUQtRknO59hIBnl/G5/mhJjxcqQuFiA4VgSP3YOjzPU3n/v8s5DY5mJ+aMMTRLWrE/LvIE/OIdQAdVO2yFHg1tqooutvOJGm7L6PA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCeb2hpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9249EC43394;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504382;
	bh=UjGzbJnF990WfC0Wgu/z17brvharXCEJIuwvkJvTiTE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iCeb2hpj4CN5OogHyH/B0Cq8H8ZlddWMH9DIqGbjLf70ghLF9cT2eZH4959+3zfDg
	 anV+9/ZtjKqBgsQ6ai1/YgUwqFHZyF57lAFUa9V01V4H7WYLgsHOgKBO5/9nThVVWh
	 /gPmjNGzdWX/IoHoUktlP/4ZDjZr2TItB6QM5MR6sf+sIzVcyC9/Es4gAkjasOs1PL
	 JzwNjbFBRmCrCtQw9o3JBIVgZgLCs8bADEiAv5JGn8a5+v3V9R/ghEgzpvDYAHzg6j
	 jepVO7sHScaAdtjjV5RmlxLeecUFtJ0yeJVIN0v2wA8zV//SZe47jLPXlbiPB7g8c7
	 CD/vBvJMC3Odw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE10C41677;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tykW0CySOLSBfxiopj2xSnBi18LtzuFHmabFY3kFhZ6Lw@mail.gmail.com>
References: <CAPM=9tykW0CySOLSBfxiopj2xSnBi18LtzuFHmabFY3kFhZ6Lw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tykW0CySOLSBfxiopj2xSnBi18LtzuFHmabFY3kFhZ6Lw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-09
X-PR-Tracked-Commit-Id: 311520887d7cad2d5494933bd19bf85eb5398ffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c76b766ec50d3d43e2dacea53a733b285f4b730d
Message-Id: <170750438251.872.15630540874101800153.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:22 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 14:28:39 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c76b766ec50d3d43e2dacea53a733b285f4b730d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

