Return-Path: <linux-kernel+bounces-133734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780F89A7DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04101F22E11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850891CAAF;
	Sat,  6 Apr 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy/QPqxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26A1B812;
	Sat,  6 Apr 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362205; cv=none; b=aftBzNdUdOyWCrREx0lJgNLOIwRM2F68JQj6n8YEyvZglfXtnlFBs1AK+JRCU1VY0R/8VXHDGUiYrB4VUtfps5Fl1/czklEHFL0mtK/jCB0tQsCJn+UD9oL5KBDBgZ/TWhj4uXUaDPGq606VfjZpWsXeI1Fes4h7/D4HMuE6O34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362205; c=relaxed/simple;
	bh=fUQcSTVKaARnTuRgrpsLLyNOizTOrEWuMGHWGyon4dw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u1/OkrtnU3WysJx0GVi7psXXxDSxHhryAm+kxGVMIHN6ITutdd1/ayTejv89ylsRrzP0cd5NE6iAWRv9GerOOkeMJzz1g9Q8k0ktF2M+pSx9ANsIcKhxE6P9VqQuQfNdulf7EJtZhiyd3nczQBC9t872ZxGcvkK0j+To97iopEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy/QPqxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CABDC433C7;
	Sat,  6 Apr 2024 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712362205;
	bh=fUQcSTVKaARnTuRgrpsLLyNOizTOrEWuMGHWGyon4dw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dy/QPqxARyQxKPGBCRLp5YCQdnedLQYdlnov5oSfQORPqaNUjfR54IZxtSumU1lNY
	 35hhNI4RVBo5NueddOJnvKJWsRISMp6YdJtCHnFgqI0oE4cXl9Y19T+vUnKpTZLw5S
	 bxkI7QsgieHtTLNqBuU6Womxhv8+vMGd5Qy2cSrWwxKfvufElCCcm8xCz5ME0XCCCY
	 u0E/VZP6edLrrwShZWvxWVSIriPJjUpXsM8y7Y0XiOOpsG+8pHUvkADKbQCv7qkB0D
	 K21IJJV3lefhTRDJG8tbHl+7hw/hwqkUgpodIOG8BdSBXTs1yjzWYTw8RpV2PUO1Dn
	 IzuHLcyJPBM9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 377E8DB1B10;
	Sat,  6 Apr 2024 00:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.9, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405204017.GA1394619-robh@kernel.org>
References: <20240405204017.GA1394619-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405204017.GA1394619-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.9-1
X-PR-Tracked-Commit-Id: de164a7f19248fb03229a4af9b0db333d9591e55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84985eb2c084676f974698cb19fb5a166650886a
Message-Id: <171236220519.3482.4923357444189456542.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:10:05 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 15:40:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84985eb2c084676f974698cb19fb5a166650886a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

