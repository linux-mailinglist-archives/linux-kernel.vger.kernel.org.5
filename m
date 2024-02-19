Return-Path: <linux-kernel+bounces-71559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3785A711
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3448B1F21F85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DA39840;
	Mon, 19 Feb 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNUr435o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4A381DE;
	Mon, 19 Feb 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355351; cv=none; b=nJSjc8vUaCs1/NvZwHOJICarTfuYPbqCaUBRE8NBVgMqSZf2pHqNpuZc7lo7207PYpD9+x6xzPh86M/iecBjajFU0ScGU9+7crBFOgJfr0Yl9YZJRh9cY676KvXL1FqfxuOOS4lyJ+Hpb8bO5jv4wtPTbQYhOpqcUT4sS9B3raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355351; c=relaxed/simple;
	bh=vwU122EsZI7GM86mUhwhec2H/tFBMMY5n/4hGJl/DMI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=O9r0DB1ivDUCl4XmWG5ClDyVrWe5a26oyypIidatTIkhzMeacJiIKkIF1h32Efiv5L27xkv9IaFoMkXLPGLqCB+DidUpSq3R8bgoiDey0LdreDU47YXKEm3QGtzWXm73eoE8tcQtBMuxDm1yie2dVWifFL1E5KZquKoxT3PHHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNUr435o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7381FC433F1;
	Mon, 19 Feb 2024 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355351;
	bh=vwU122EsZI7GM86mUhwhec2H/tFBMMY5n/4hGJl/DMI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=tNUr435oV98n7qCZUhUiFc5gOkNDElGmzVGSCL6kQJahSAaVILeMfKPKBx6qO1Ay+
	 6U0+5gWfz1eJxWP3Y3VqFSm+w+r2OiznmCAvUXeTHVpqbXSomzpOEeLMBHb6hmvyOG
	 bs5Ox9FbYFZ0/U3SSxX1Cmo4ckpilkoYFUVElQEf4mPcRZxTkGB9KJBl3ezdvvRK/K
	 /vE/t0txeB2YiIDSZAnawS65qSMefbpmDqO045NcwXF1V0iWiuyhHUfxQuPUK/rlEo
	 NuXBPr1TttVZxnDQjnqaEmN33iNoD+CNsfS8KV1Q79DJvMgXOxujV4CYh6OUHNI8n8
	 neGQg0wslmdPg==
References: <20240111212424.3572189-1-willy@infradead.org>
 <Zc05FiqYKgtNHUL7@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, "Darrick J .
 Wong" <djwong@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/3] Remove the XFS mrlock
Date: Mon, 19 Feb 2024 20:36:26 +0530
In-reply-to: <Zc05FiqYKgtNHUL7@casper.infradead.org>
Message-ID: <87a5nwwkx7.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14, 2024 at 10:05:10 PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 09:24:21PM +0000, Matthew Wilcox (Oracle) wrote:
>> XFS has an mrlock wrapper around the rwsem which adds only the
>> functionality of knowing whether the rwsem is currently held in read
>> or write mode.  Both regular rwsems and rt-rwsems know this, they just
>> don't expose it as an API.  By adding that, we can remove the XFS mrlock
>> as well as improving the debug assertions for the mmap_lock when lockdep
>> is disabled.
>> 
>> I have an ack on the first patch from Peter, so I would like to see this
>> merged through the XFS tree since most of what it touches is XFS.
>
> What needs to happen to get these picked up to not miss the next merge
> window?

Matthew, I have updated XFS' for-next branch. The HEAD commit is now
49c379d3a72ab86aafeafebe6b43577acb1ef359 ("xfs: use kvfree for buf in
xfs_ioc_getbmap"). Pleae rebase your patchset on top of for-next and either
post the rebased patchset or you can send me a pull request.

-- 
Chandan

