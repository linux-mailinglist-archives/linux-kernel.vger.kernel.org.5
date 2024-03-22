Return-Path: <linux-kernel+bounces-110824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586A88645E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D48281B84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87913138C;
	Fri, 22 Mar 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx5wcy2/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A14383;
	Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067559; cv=none; b=qtPvunAbipjdP8emEvlmdtjqFDi/2qoR/OK2MblBCBQaBwdE/Sas4A5o32Lf4OYuHpjbiUPhHtnm7rwpbzV4xIxSLaIF7IjoRDEnlTBjXOJUvxthoFOuFAQIcZ2u+xOM+fQPxd9Uq71rhrDdR+p2l9aVSxUcEo9Yc5U196MKv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067559; c=relaxed/simple;
	bh=x0+8AmzBRGviO8IPcOrFG2bqhWkOhGq4CzF5UveoHmY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IQ+dTerDWrtTwnU0w8C42bAQ7dp3J85QZBvRtFskwj/U/WN+zvEgP5pKQftAQ712/ES43MOtbE7Xy0zqhipNpOnL9TVmzyRmMxAxGTS72Q8tvyh/T0BQW6ZbldtVI3OwOhgaSoz7tvb5LKZigs+aloF/DE5PNArDTOcbx+Vm4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx5wcy2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 587E7C433C7;
	Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711067559;
	bh=x0+8AmzBRGviO8IPcOrFG2bqhWkOhGq4CzF5UveoHmY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fx5wcy2/JvFVK7RrPOjA7SC2kGcZqjcA+ANfF/zWJUu5oMl4F/2wGWrMQkTeEf6n2
	 vaYmE3NZGoukyhsPx1koaMD3P+DL7eGk4xlF+DgNTqHyapfEkK9ie2H4MtrrRHha+n
	 4ggbfkBp4GJcVA5t8XkQO3FUAmIa/z+oHjH/wF+REcqGvWRC3Txxjy1j8FpORn36R9
	 6uzI0AjDgF4TZj0SZI9v+hvWxyVZ70Gspsyb1MwvaC4Q6fZsUH6pO67Ox0xPQDa01o
	 d+tSbLk5HdWWE/1THFNLUxIb/vXYA3EDIovRmiOmv6c2DkOdJoKN+3jAt0hjgoqcp2
	 M9MAIaioQrtqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FD74D95060;
	Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403212253279f152664@mail.local>
References: <202403212253279f152664@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403212253279f152664@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.9
X-PR-Tracked-Commit-Id: f7cee094fb3b370e56b3c8aac89038de818d7aec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3faae16b5aaed284c7de6f4c12240da67497d3a3
Message-Id: <171106755931.26768.15494070991255004797.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 00:32:39 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 23:53:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3faae16b5aaed284c7de6f4c12240da67497d3a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

