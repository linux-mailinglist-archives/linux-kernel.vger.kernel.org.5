Return-Path: <linux-kernel+bounces-63794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CCF853473
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4918CB225F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B095DF02;
	Tue, 13 Feb 2024 15:21:00 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE195A7B7;
	Tue, 13 Feb 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837660; cv=none; b=dTR/SkXgh6ZOZHlNwomTWj4tq2voKBKj6AcDS5umXKWoZYQzjm+46bMgh0G2FlovNCplYeXVOlU5RiomUhc/0zRvFbZ6HZp3vpbUMMzH57onlpTJ1mBz1mcHlxJaaWAnKFKT9oxSyrD51Oz/zvTWnrdr7yvJyOu2tZrKFvGrczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837660; c=relaxed/simple;
	bh=mLLi2YG82DuMTVToqNT+HyWTPw09yqklzX/sT8xj/Ns=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sy5Wtdf6sZS3LByir1H0ZE+C9KfbE7OtS+f9ULt6MemD3nictFJpSOjkrRgouiTrAuvdy+9H8gaIom3w70RkajXuGQEYwQrgWjc2pE+Ge3V769Kn21eaoIIQP9X8Wq3oL706VqSMnwBILheJtS2OEhjbHgK60/mLE9pX+l/BObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B0F3592009C; Tue, 13 Feb 2024 16:20:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id AA08E92009B;
	Tue, 13 Feb 2024 15:20:54 +0000 (GMT)
Date: Tue, 13 Feb 2024 15:20:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tc: make tc_bus_type const
In-Reply-To: <20240213-bus_cleanup-tc-v1-1-5ed32393a73a@marliere.net>
Message-ID: <alpine.DEB.2.21.2402131507130.2376@angie.orcam.me.uk>
References: <20240213-bus_cleanup-tc-v1-1-5ed32393a73a@marliere.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Feb 2024, Ricardo B. Marliere wrote:

> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tc_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

 It builds, therefore it works, so:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

Thank you for your contribution!

  Maciej

