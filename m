Return-Path: <linux-kernel+bounces-97925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0CD8771BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151B6281BFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACEE43ACD;
	Sat,  9 Mar 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYB331rD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B361BDF4;
	Sat,  9 Mar 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996176; cv=none; b=J+l39YNEwrKNFh64Cj1pKdoU0GB8Y/XlxAH9ZqfJgQCwCId+7qKhhhlqyXNmTtso2RYv12jRMcU6XaMge8oB9px+ujdsE+Vx45LHTqzHBk2QOCCe29Tu6FkaUQJi8CPX3ZA4dvmRXNvs0V2ypWHWTnKp+GaonHcibNrK1qAax7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996176; c=relaxed/simple;
	bh=KBygGl79mgaURge7K4LetcAdkwIssOLeohMMAFX3q2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY9OUYj5piy4uoUNp5QTpVUV0VKifILrkzsO97/tVlx/pfPM0dHqdDL+bxA7N0C942duBdoPqtJPRqYw8G1q74S0/mjdmCVq8Lr/ThhbVOGrFNORSfKILLckbjXr4mdP6tDxKQXoQjILhjFMv6kp3oVaVC2rbVLh3g3p5VXmofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYB331rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF47BC433C7;
	Sat,  9 Mar 2024 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709996175;
	bh=KBygGl79mgaURge7K4LetcAdkwIssOLeohMMAFX3q2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYB331rDgVyzvJ1jxivyu5GlC+MMjdqMpT7ZkmjFbpJzVEITaXblE30IrFvzl5Twd
	 5Po7ocReeh8BJtW758Xgh+6Zfr4vL9i3txE8JkPcv38+uuuw2jmqUidU8ZzDL10g1s
	 JBACl93u+Md2A1dbt9DDl+eGifPnCxF8NnFQNgrjL0rR1i8abFkogZ/hn4b93q9kBc
	 DmCcspTxmRW59OO6wdmV7kPC8HHLp7HG9zWRijZ1ZQKmplqGZXP/Uynd5zSWEi++uI
	 cFZqOIjIlqft9sBl3yHKmACnDrC9o9s2zBcGHes/MX4k5MCnkapS/umNcXsOUHOZ8E
	 TCDPSoXkeRzGw==
Date: Sat, 9 Mar 2024 14:54:41 +0000
From: Simon Horman <horms@kernel.org>
To: thomas.perrot@bootlin.com
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macb: remove change_mtu callback
Message-ID: <20240309145441.GA4701@kernel.org>
References: <20240308155330.1610616-1-thomas.perrot@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308155330.1610616-1-thomas.perrot@bootlin.com>

On Fri, Mar 08, 2024 at 04:53:30PM +0100, thomas.perrot@bootlin.com wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> Because it doesn't allow MTU changes when the interface is up, although
> it is not necessary.
> 
> This callback has been added to add in a first implementation of the Jumbo
> support [1],since it has been reworked and moved to the probe [2].
> 
> [1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
>     jumbo support")
> [2] commit 44770e1180de ("ethernet: use core min/max MTU checking")
> 
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

Hi Thomas,

Perhaps it is worth mentioning that after this patch the core will set the
MTU, regardless of if the interface is up or not.

