Return-Path: <linux-kernel+bounces-29943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1383159B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B9FB21237
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB71D53B;
	Thu, 18 Jan 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2eKbhW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB21CFA4;
	Thu, 18 Jan 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569412; cv=none; b=fhK3sZuVl4EmC7Lg9aYxQmagg8mHq+hIN98dtYoQ15Jzd6Qc79LbYawgxltmjBBrac6RLibnrKUudtyoQE1j3mkBXmX/+3W50ZuOijQTcokpWL4WuF+94FGHB2YTOPq96r5CaDI/fiGxwO1jzoXWbFMpm2FxCPZH5NLACb2SVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569412; c=relaxed/simple;
	bh=hkSwAwQRpBVseHgROkd3gsrJJPpKcp0eBJDtMHc3a+E=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=iLgoCSD3KXY2zfjnGCI6zYkpbwrUBBRmuUq7jICQTMPV+cHG8l1Q8Lc99H+q51ivFsQIyT9Y1Rc+Ozrl89KgF1V8d8X8hiCHjz7lE+Ja8Fq4LjZd+XoLLYOASEDTOWzqBWs5AO0051UYkK6l5296OxLbCKuTndgLtSBDto6ka/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2eKbhW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC78C433F1;
	Thu, 18 Jan 2024 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705569411;
	bh=hkSwAwQRpBVseHgROkd3gsrJJPpKcp0eBJDtMHc3a+E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=c2eKbhW8+VELAfIZkBmxFmTtcVYAYHVxudUEoUa8C6BT7UDa7CrtEx0hOzD7ynmy6
	 PEAJS2VtbXTXLbbHR967Pwj18CzcqAuJynlG5N1Q4aPpDmz/6Cgs5zFfzjw3kuyqEH
	 AKJoyVXLr6iRk+TL7r1uJ6wQ6eFNLZyF+i+XQQhkZh816wzUMLJeS+liBDirGxIsXg
	 qIUcstuK9WjTxY3oLcZHNBS5R4i59Ry9EVGzTnWotr1/9S8OjMSXG9dWTIzxgzyJB9
	 Srj9nY8LweUGWVY0hVRO1xLGbGsT5x1i6RW1piRzz2e1LLT4XCWLHJDbNjYWLIA76B
	 N+g+PN+BZlD1w==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  "open
 list:MAC80211" <linux-wireless@vger.kernel.org>,  "open list:NETWORKING
 [GENERAL]" <netdev@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>,  Jun Ma <Jun.Ma2@amd.com>
Subject: Re: [PATCH] wifi: mac80211: Drop WBRF debugging statements
References: <20240117030525.539-1-mario.limonciello@amd.com>
Date: Thu, 18 Jan 2024 11:16:47 +0200
In-Reply-To: <20240117030525.539-1-mario.limonciello@amd.com> (Mario
	Limonciello's message of "Tue, 16 Jan 2024 21:05:25 -0600")
Message-ID: <87il3r3ssg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> Due to the way that debugging is used in the mac80211 subsystem
> this message ends up being noisier than it needs to be.
>
> As the statement is only useful at a first stage of triage for
> BIOS bugs, just drop it.
>
> Cc: Jun Ma <Jun.Ma2@amd.com>
> Suggested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for the patch.

Tested-by: Kalle Valo <kvalo@kernel.org>

It would be good to get this to v6.8 but we cannot take this to wireless
tree yet, only after we have fast forwarded the tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

