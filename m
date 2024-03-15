Return-Path: <linux-kernel+bounces-104894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA187D515
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854342884A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485E59B70;
	Fri, 15 Mar 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHknGuV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3BE56B8C;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535057; cv=none; b=TfXqsRpJwRoJHvUzx4UXzh2woE6Z94C2qN6NL4WvW3OAC+Ok/j4L+Dy67TJQG8qthnvHdYWeIaQvpwID26LJxdtPKxeD4glsS1wtd6ExCHicg+sRM163fUd7p2mlEAjuh+B6MfyxyCeabnUaX+jjc9+05oFuGIF5rLy8ZiNk8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535057; c=relaxed/simple;
	bh=j2djVRRDrnIy0eeLjKZfmY8VlD2NhtFj4rzc6meChE4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d3hxG9+ofXFOzQYik1tG9TSYyJGIiK3cfOJMhQhNyJJYZ+7JzttV/gu4VDgQ3x64PGV3+TESHZ+XgEMOrse6imMo33ULCW5szD9p+VoZZd9m+4tNY6ujVfh2j1eWd11Gy5wgERtO0dhohZYZ0goBz0t1nCkZJVkI57WzvlZ1l7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHknGuV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F45C433B1;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535057;
	bh=j2djVRRDrnIy0eeLjKZfmY8VlD2NhtFj4rzc6meChE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dHknGuV3Dv0QDPlCvgchXxFWPxRNMBANuSWzpZc9YzZhlJIDJkNIaB3fpEtFQvY1m
	 KgDdhOeMn5II/tkV7UsfpZVi1ypONVWp8Vd/dzLJZyQzZKZnHvo/YMTNUNwj/TC68+
	 lTds85kX2TByz7WUw0PbE8e754Vsyg+8mf9hxUxq+e081nvHVvC7JeopMmKgKMej6w
	 0Et/t3mAlgJI2UcRA8TiZCUuH4EB90Ayrg9+J53+MxrOhYf02pXU7Eqm2/YxIMLsnr
	 5XR8gBzjI+BcAsdTWk4DcGzMBfRmhxEUSJGHTueJKG8nu9opsQ9lkhXnvyDMMxVfHl
	 M4DGj0w/f/QTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40BE9D95053;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240315172224.GA1479929-robh@kernel.org>
References: <20240315172224.GA1479929-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240315172224.GA1479929-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.9
X-PR-Tracked-Commit-Id: 7e98fe49f8896cc60c2a88c60bc535aa3e0e2564
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab522e1478e3191114535f454a1c41ba3b2d1cb9
Message-Id: <171053505726.29375.10718904153959548946.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:37 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 11:22:24 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab522e1478e3191114535f454a1c41ba3b2d1cb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

