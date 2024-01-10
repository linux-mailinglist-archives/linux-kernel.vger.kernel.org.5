Return-Path: <linux-kernel+bounces-21809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4B829493
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575B01C259B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5A3C464;
	Wed, 10 Jan 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AW8vNCAb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69E3A1CF;
	Wed, 10 Jan 2024 07:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA0DC433C7;
	Wed, 10 Jan 2024 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704873580;
	bh=ZEqI+gXJHz8/Lac8/QVhUoMKW2inqwzIYF+P/nz6p0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AW8vNCAb8Q+umIfmKlNh38Zvs5J6GRh2RvypVPvJ9TXJeFBrxJgmzFdiOEzXYjR6l
	 QJM7DCXxsWO5vNdeXgXL7TSeF707G5gmOgUL6OwTV6p3qpjaOVmI0fCKRNMqhk2Y2B
	 SqPdOEzQgTL17XT9OnAxz2ZSc1u/25NOkkWVanNM=
Date: Wed, 10 Jan 2024 08:59:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: fix syntax error in IRQ error message
Message-ID: <2024011006-snugly-poppy-8994@gregkh>
References: <20240109201102.299302-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109201102.299302-1-hugo@hugovil.com>

On Tue, Jan 09, 2024 at 03:11:02PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Replace g with q.
> 
> Helpfull when grepping thru source code or logs for
> "request" keyword.
> 
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Cc: <stable@vger.kernel.org>

I really doubt that changing a spelling issue is stable patch material,
right? :)

I'll queue this up after 6.8-rc1 is out.

thanks,

greg k-h

