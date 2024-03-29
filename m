Return-Path: <linux-kernel+bounces-124058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B547F8911A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69DE1C2B301
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FA2AF13;
	Fri, 29 Mar 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxN7uau/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C769225A8;
	Fri, 29 Mar 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678832; cv=none; b=TItej8WkShHyFhp/+D0JpO+ggkKH2IXeTMRjoKrN9lY8xWEKWo7ItK74I7w1icWzYReSNJCIsDQUKzQz5PHV9uqt3bzXg8L/QXnQ4501qx6DJthSIw6F/Sq1W13JmkflInZWu2ExzA5ELFeFfB36/2yNJVtiF7GqyGPFnt/wS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678832; c=relaxed/simple;
	bh=scq+zhfqrpSEmaQVeGCdzdWPMSoFu4I0JJu2jmYEKVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPzffhpd1exm9l0x/rqmkp31yIekgXXwzrLkIG1XD1URaRKnf1fxsw/4EO6ah0zDVABi8Yx64XD7RkwiDhDSyMHwOYKalsHQOqM2dIBgn59sMwLnn1hveh4gJzCWUXJoMTWD9u7yW4IBzsiDTMuDv8uGawK8OqIVZLljUHKaLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxN7uau/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEBD5C433B1;
	Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678832;
	bh=scq+zhfqrpSEmaQVeGCdzdWPMSoFu4I0JJu2jmYEKVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UxN7uau/0swIpwP1Gpd4TqeL1OK7pHUj2QWM2Y5U9HDikHfmdEz5BSItnmI3CWuBS
	 JoD4eFjjP0PiYfv14912z+N136MzmkhUCtfN5T9jPjDrsgy+gEU+m4p0rZ1Mm78Qn7
	 Ug0z7zeExywdsB5z2WO/EkV/WFy8ARvLttW82sTwVY9dyoyamRuDcy3kLuOaEyy3UJ
	 htPl1jbR9hZI9DnJtQJM7+a2FRnG2Ovb3weLX1ys0qtapMQwKsbWgQEeS3nXaFRn25
	 CZ2p4nRK1MMx29QUwcjTdQ9vYot/isqRgLfj1bP+Kay4QcNL/C8k5yw2Q2/GxljYNp
	 zPYGp3uVobJlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2D31D8BCE9;
	Fri, 29 Mar 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] compiler_types: add Endianness-dependent
 __counted_by_{le,be}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167883192.31897.5391383378639622485.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 02:20:31 +0000
References: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, keescook@chromium.org, gustavoars@kernel.org,
 nathan@kernel.org, horms@kernel.org,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 15:22:38 +0100 you wrote:
> Some structures contain flexible arrays at the end and the counter for
> them, but the counter has explicit Endianness and thus __counted_by()
> can't be used directly.
> 
> To increase test coverage for potential problems without breaking
> anything, introduce __counted_by_{le,be} defined depending on platform's
> Endianness to either __counted_by() when applicable or noop otherwise.
> The first user will be virtchnl2.h from idpf just as example with 9 flex
> structures having Little Endian counters.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
    https://git.kernel.org/netdev/net-next/c/ca7e324e8ad3
  - [net-next,v2,2/3] idpf: make virtchnl2.h self-contained
    https://git.kernel.org/netdev/net-next/c/c00d33f1fc79
  - [net-next,v2,3/3] idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header
    https://git.kernel.org/netdev/net-next/c/93d24acfa05e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



