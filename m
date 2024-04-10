Return-Path: <linux-kernel+bounces-139341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3408A0199
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60136B269B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DB181D05;
	Wed, 10 Apr 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kAw7RbSv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904C181BBC;
	Wed, 10 Apr 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782808; cv=none; b=AifLbD02DtnLKpFbbkbdXUuqm91uQYFvp0B40zy55XDplXbs7vQapNmCPSMrD2gT72gpw2Uaimo1yxO9LRzb/dI75pNrPrYLZu5F5+lNibhf0kzAhhwASLVoiiNmxSmxokigYMa21lEPiaQWuHwE6eJ77a3uUlxWMDOUFOdWFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782808; c=relaxed/simple;
	bh=NZxSmvOIrL+98WYQwIqbcfn2nyl5N/8M638PLwCqKpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVPk8x6HiH4lYRPCQiVs2hYgw7fOJ+kDBCd9+g4hkOZD1W+S5ECSn2tu4bOoTHRS1com671jgSoxY7yFzjtRyJrMKJQ2xcN6rv431dEAM5cJ2/UWUoXTfhWnpPDdZas7TOf0JtWqqVpRW0qieR1Go0wdACL1+Q0Wqf7ND82JH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kAw7RbSv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 08CCF47C3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712782804; bh=bBiHyQknYVefwGowYX8X98+sWwdYwknbIEfcbgt8MVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kAw7RbSv9BcBu6s7oRnasuRvyvN9sgglhE1xceLaBCStyIXPzVUEfEV1mN3h3GNnP
	 pnS8SsZgOyt+cSOYYrcYdAKSkRHX1HD87wvo9F91Rsf2fQ/NSTATSyTNhXlk/SGq0B
	 w321qbDUaYD6BdSycet+3dSY6ICKDwILgCTyOdZ8Wjinrk5/f9gaI/TLMFRAluTySB
	 GKUlHGc+tW77Tnd+G5eOG+Egrt1cfv4buCTF7D/aA7EAYc9RgylsZSvls4p7sCObX9
	 XVtROmBWJ9sAlqheyJEsfJzkmxddRDvymDxOV/TdYTUwrszJ+3JjVj86yGoHs2P8sr
	 B0Xej9WywdOWg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 08CCF47C3E;
	Wed, 10 Apr 2024 21:00:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] docs: reporting-issue: rework the TLDR
In-Reply-To: <2f5a78745cbe0a99a4592612d6ffd57a17619fb4.1711455295.git.linux@leemhuis.info>
References: <cover.1711455295.git.linux@leemhuis.info>
 <2f5a78745cbe0a99a4592612d6ffd57a17619fb4.1711455295.git.linux@leemhuis.info>
Date: Wed, 10 Apr 2024 15:00:03 -0600
Message-ID: <878r1lszl8.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Rework the TLDR (aka the short guide) for various reasons:
>
> * People had to read it entirely and then act upon what they learned,
>   which from feedback I got was apparently somewhat hard and confusing
>   given everything we expect from bug reporters; this partly was because
>   the first paragraph covered a special case (regression in
>   stable/longterm kernel) and not the main aspect most people cared
>   about when they came to the document.
>
>   Use a step-by-step approach to avoid this.
>
> * Make use of
>   Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>
> * The 'quickly report a stable regression to the stable team' approach
>   hardly worked out: most of the time the regression was not known yet.
>   Try a different approach using the regressions list.
>
> * Reports about stable/longterm regressions most of the time were
>   greeted with a brief reply along the lines of 'Is mainline affected as
>   well?'; this is needed to determine who is responsible, so it might as
>   well make the reporter check that before sending the report (which
>   verify-bugs-and-bisect-regressions.rst already tells them to do, too).
>
> Not-signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 104 +++++++++++-------
>  1 file changed, 62 insertions(+), 42 deletions(-)

From a quick read, no objections here.

jon

