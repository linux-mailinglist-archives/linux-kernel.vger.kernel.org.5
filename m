Return-Path: <linux-kernel+bounces-22690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7482A1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAF61C22363
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47F4EB2D;
	Wed, 10 Jan 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSfff3oE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A794CB55;
	Wed, 10 Jan 2024 20:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640F8C433C7;
	Wed, 10 Jan 2024 20:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704917266;
	bh=y8gRDNj3LTBwuUunKK4u2OGjAjtah6c02pmVK/4+c/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSfff3oEdt365FxjIMOOR1hT38YAwR8vdd7032PvdN+lTOJi4oVjwoLejRncJIw/n
	 zXxwlGrbt9nBV9WN2pt2TYlVBVQYgByfxHqDBjwHTn8xK2AjpYVkNWBIwFOmEGkfiI
	 WpDxXFU1w25a7g6HbU8nvRYHZVEYmGbAfxmTrspQ=
Date: Wed, 10 Jan 2024 21:07:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pci1xxxx: fix off by one in
 pci1xxxx_process_read_data()
Message-ID: <2024011010-knickers-blighted-c177@gregkh>
References: <ZZ7vIfj7Jgh-pJn8@moroto>
 <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>

On Wed, Jan 10, 2024 at 02:46:05PM -0500, Hugo Villeneuve wrote:
> Hi,
> it is not simply a matter of adding "fix" to the title.
> 
> You must explain what and why vs. how.
> 
> Please see:
>   https://cbea.ms/git-commit/#why-not-how
> 
> for some guidelines on writing a good commit message.

Sorry, but no, Dan knows how to write a good commit message, this patch
is fine, I will take it as-is.  Please do not nit-pick stuff like this.

thanks,

greg k-h

