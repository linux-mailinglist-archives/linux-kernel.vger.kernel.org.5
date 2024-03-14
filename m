Return-Path: <linux-kernel+bounces-103855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D801887C5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EAD2822D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC3FC05;
	Thu, 14 Mar 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjMUOS9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7060DF59;
	Thu, 14 Mar 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458029; cv=none; b=bK+T9687xXb98C7X51VvewmPGAR9ODSxOQxM3p8k/LnwGZbbkfVcj+1waz+xRwhlbykqqNS/eNQFDcGKNYq2QcAMLC+kKU5aw7QtDZsba70G5m3Vuwe6WwWf8vl5P4+Pk1JYvhWHFNQY0d+lSXvvAAPdlGyQIvVtIrpYUXfrf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458029; c=relaxed/simple;
	bh=JBRy97wfO2g1OdHXDt0WfQFfabm7MseFJiPxeGnzPxE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OQaQZotwdx4JvScg9Em5pDOD89D6zR4xJHhDPT8ier97sbRQeNH47iL46tCWCO2vcNXoN3QxPCaOKa8Epna0dcK8zTIG8Mb3vy06WSS7dc024z/q8wye+fNHb/HTk1qRskvlIoPvzuF7mgrtAjOV4c/xJlYjkbU4cheQkbnR/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjMUOS9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B500DC433C7;
	Thu, 14 Mar 2024 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710458029;
	bh=JBRy97wfO2g1OdHXDt0WfQFfabm7MseFJiPxeGnzPxE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WjMUOS9wu7JkEchLS7R8RTLTzQuZ4GEjjcvFUC7D0wLoLXo4XRrmlzX4uysdZDj65
	 2OFm4Ibln76J/xckAIL2pxmwDvfTh+LxCaSlAGNv8acaMn8ZpcHQvdXTvadJosIgcp
	 Y8SFQK2Ifgd9ejh8XBjmoH4UyXMxvex9KJHWpiV9dURczb5VUTqQqmHDSKQ6dV9N+e
	 GTNWLkM3wsq09FsTpvlHP3GWo8jqo/lHhc6gsWJ8j6ZrW6xQ8Ghu3TvHCeotIjIGLM
	 w9JQz0cp3gjrsvx9t4h4nlAGx9GmsMEFvUUIsUjZIbkPvUzgaOgZffY0c+duiTursN
	 kqJZ49DgUNSew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACF3DD95055;
	Thu, 14 Mar 2024 23:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfHWyzu2sVF6kno6@antec>
References: <ZfHWyzu2sVF6kno6@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfHWyzu2sVF6kno6@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 7f1e2fc493480086fbb375f4f6d33cb93fc069d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29da654bd20842d4c1e17c6d4dc1b12642ca16ac
Message-Id: <171045802970.7563.11901264672759040447.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:13:49 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 16:39:39 +0000:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29da654bd20842d4c1e17c6d4dc1b12642ca16ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

