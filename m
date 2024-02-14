Return-Path: <linux-kernel+bounces-65453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D390B854D45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E9A1F2300C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1570D5D910;
	Wed, 14 Feb 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVV9pLFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586585D75E;
	Wed, 14 Feb 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925714; cv=none; b=KPp8T6jNZ5mqChFgS1VEjFSWya1ujM5H7mXD80nqGA0nFFSj8tRQvqhnVw53CRqygid63rFX6jHojPl5BCC26fKTIhFPyPmlkvkOfD/ckkJ1RfA1tlqjPfiDE5wPKFgWtFQ+POJeTyil68LIIcD/MZd4sb/fknoYzOy4j8NlXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925714; c=relaxed/simple;
	bh=z3XwdfOdEHfS4GV1GgNNK7GZS40lTdoLjyVB6nLYx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je70XZ0Oikvnq/qwEfxzf6lcMgKBUZU8RHeTvDLFFE23GHtaR6Ml1cPxdbjIRXshjg2682hw2s36orFxvT4UMlZe5e1OE7AsMmkykG6fj/s9F4Vr+AF353A76VK/8RbbSHxLo2hQ/iJQYk4akoKk2fuHxRn98tIoCvaBjKNW2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVV9pLFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D573C433F1;
	Wed, 14 Feb 2024 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925713;
	bh=z3XwdfOdEHfS4GV1GgNNK7GZS40lTdoLjyVB6nLYx3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bVV9pLFYnPUAZlhUY5y0ikLVaG0dOL0NIEnh97b0e4CXBb19J5aXXBTou6slwO4Ey
	 G0d6/tqvDjychPuL7COFamHwBmXGbT3Ui3cPcfOlyIx1ecUwb6eHLKtnm6CtJGKD2V
	 D48uxXaynCRnXZiNQK1RYvGmh2mi8pzxnfdVISf/L7BzGuIDelpelCr5tL3jz5pdf7
	 4NCBsbhoU97MvP5af5odCdH2lWn10msAPDCmMmG6SM/wCezxkmdmfzhXuk36bqDsT8
	 T0ihWfTFgyF4JLROqd1uy71GgXZbI/LUWNbvx5JQRiVxV5sywghopHJlIzDoUrDgj+
	 G9i3Mx3TFDwdw==
Date: Wed, 14 Feb 2024 07:48:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Leon Romanovsky
 <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Aron Silverton <aron.silverton@oracle.com>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240214074832.713ca16a@kernel.org>
In-Reply-To: <Zcx53N8lQjkpEu94@infradead.org>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 00:29:16 -0800 Christoph Hellwig wrote:
> With my busy kernel contributor head on I have to voice my
> dissatisfaction with the subsystem maintainer overreach that's causing
> the troubles here. 

Overreach is unfortunate, I'd love to say "please do merge it as part 
of RDMA". You probably don't trust my opinion but Jason admitted himself
this is primarily for RDMA. RDMA is what it is in terms of openness and
all vendors trying to sell their secret magic sauce.

The problem is that some RDMA stuff is built really closely on TCP,
and given Jason's and co. inability to understand that good fences
make good neighbors it will soon start getting into the netdev stack :|

Ah, and I presume they may also want it for their DOCA products. 
So 80% RDMA, 15% DOCA, 5% the rest is my guess.

> I think all maintainers can and should voice the
> opinions, be those technical or political, but trying to block a useful
> feature without lots of precedence because it is vaguely related to the
> subsystem is not helpful. 

Not sure what you mean by "without lots of precedence" but you can ask
around netdev. We have nacked such interfaces multiple times.
The best proof the rule exists and is well established it is that Saeed
has himself asked us a number of times to lift it.

What should be expected of us is fairness and not engaging in politics.
We have a clear rule against opaque user space to FW interfaces,
and I don't see how we could enforce that fairly for pure Ethernet
devices if big vendors get to do whatever they want.

> Note that this is absolutely not intended to
> shut the discussion down - if we can find valid arguments why some of
> this functionality should also be reported through a netdev API we
> should continue that.

Once again, netdev requirements for debug are - you can do whatever you
want but other than knobs clearly defined in the code interface must be
read only.

