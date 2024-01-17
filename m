Return-Path: <linux-kernel+bounces-28437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554182FE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2565C1C243F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B21C11;
	Wed, 17 Jan 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGRkVa4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E91364;
	Wed, 17 Jan 2024 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455797; cv=none; b=XeUhoYhwBFgZPQJh4deVvI3tOWuNTdGJmqj1BycrdXvWFDDf7yxDdAOgWnS0luYXANMlfDNHGNrUYJp7pE7LxCSMlO+k/UbFGVp9DdKwI1fFE0dRbsvhzOeHku8t1SNSkHbyzhVTQOPxderUc8jLgDbWj0db/TMvgyesoZybMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455797; c=relaxed/simple;
	bh=HBlVacBPS2gtzegM5iopkMScTOK/n0vk5gf2QfxARa0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=D9flh1hPihuTSw3na8KBOzDm4axJdyWEzekBKaN+xadAaMhGdoyny6LrVbWJEyu3ZC+MDl3ZSyWchx9drF/YS/kNEqQ6choYcLkF0XVm/1PJ6KkbE33wzS99c/kXW4zT6y3O5a9QqOz93GfzJWZNRoPsqrCjU3MnKY8ipl81jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGRkVa4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3315C433C7;
	Wed, 17 Jan 2024 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455797;
	bh=HBlVacBPS2gtzegM5iopkMScTOK/n0vk5gf2QfxARa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uGRkVa4aioWaNa1h27oLiRO9iebL7y9z6ANWjYql2ZrKDQ7/sINLqm68GnxVmAFX6
	 VURrIY5ea92M36CO+YbYq7vlCLZHBDlEV5WqhV6UoO8ZhIYEs9hpAH9oY3hserl6ZD
	 a9RVzcYugnnyjZ4rvuuB9Fcw8QnQWnUrODGyg4YsKHDo9GPJJ4eptMmPJTyNtAcZ5X
	 nL61hbNW0sS+MII7lnHO+0YieuWyXTEQ0bsj1qAryS3maHzFUS5xkESCkcwursETtS
	 ciogQcfAO2xsoMugjNLLUsJLVw7WzEvMGNNVFEaaXNL87MKP8NGHzEt+X9brcUly/T
	 /k/7ozbjmJt2A==
Date: Tue, 16 Jan 2024 17:43:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
Message-ID: <20240116174315.2629f21c@kernel.org>
In-Reply-To: <20240116194225.250921-21-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
	<20240116194225.250921-21-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 14:38:47 -0500 Sasha Levin wrote:
> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
> operations and the function code size. This can be further improved
> because the function sets a consecutive register block.

Clearly a noop and a lot of LoC changed. I vote to drop this from 
the backport.

