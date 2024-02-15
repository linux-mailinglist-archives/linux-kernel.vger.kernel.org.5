Return-Path: <linux-kernel+bounces-67081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA28565F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811961F24EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC3131E51;
	Thu, 15 Feb 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aurYxMTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BA131E31;
	Thu, 15 Feb 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007257; cv=none; b=Qdcyq55bryOSVMS30+26XWKnR6txnoRKvnHH5eD2p+iw787j4PPamdFS6ns5si8ffeRsc+dhWvGkI+4O8jnGSPrY1D7OnUQUBI8tjnO1M9v2RMKICLdew+EfqDyx1FC4w79Uhv20XNE5SRd9ow/jufmaXqmea0WKDFGOerF7Now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007257; c=relaxed/simple;
	bh=PuQ6kn112DYtORmup7aH2j73drGiFmg5nXdIDPUqDz4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=F9sSICYL81rjz4Q1Rsfl88AVknExYM/wAPqKsyC5BUBUWVi9z+heoefAh7fRfe+4G6vMIcJL9WTvSm+kltfzh2yCtZLB9EvFSL8rRtcz3uC4PXBpVHpylJUeJ6eaAwre/Z4sHJTbfx61Jw++aMavIQpY+8TIrvVkqOkRTa108TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aurYxMTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF3DC433F1;
	Thu, 15 Feb 2024 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007257;
	bh=PuQ6kn112DYtORmup7aH2j73drGiFmg5nXdIDPUqDz4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=aurYxMTs058gqHrdBNIWxOsfwJf/pt5vcKMslo5mz/HrjztIH8FWsaICfyyVSvWaE
	 DgDALkjYj8JXRNbbn3eplaTiJP4LVR0A4ilN4gmcWf6x3FE/n5vT51tZbC9T6JVslc
	 RgtnGYjD9lF89ml+6d+GgTvgvMMn43lYmr6/mP7ppOm0x9JtK6XYOkxH9jVOVF+Um+
	 eSIuqXvpKCeDKD1ua5RWKNjVlPUXz8XnZ5gkd6Pk9aonEPO8ZuyNWdC+be4H3BUWPo
	 OnND4IdQM8HKk1pJKZ6ejhRHnEl6IgIbNQjzU1mjaT1mwafw96uTlDTYAsbPk4Medt
	 9Pzs5bi716z8g==
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
Date: Thu, 15 Feb 2024 19:53:21 +0530
In-reply-to: <Zc05FiqYKgtNHUL7@casper.infradead.org>
Message-ID: <87wmr5n6p7.fsf@debian-BULLSEYE-live-builder-AMD64>
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

Sorry, I missed this patchset. I tried applying this patchset on top of XFS'
current for-next branch. But it failed due to merge conflicts. I would suggest
that you should wait until the "shmem patches" impasse gets resolved and
for-next branch becomes stable.

I will respond to this mail as to when you can rebase your patchset on
for-next and either send a pull request or post the rebased version of the
patchset to the mailing list.

-- 
Chandan

