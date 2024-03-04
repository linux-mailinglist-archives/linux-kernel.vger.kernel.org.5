Return-Path: <linux-kernel+bounces-90688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64225870367
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF041C21E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA53F9C3;
	Mon,  4 Mar 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9K8S3N9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D43D97F;
	Mon,  4 Mar 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560515; cv=none; b=dOg1NpNprCiwwO+mC7zLm7NK9RtCCQNwomqsJKY+xqVhSPAEh07R24Ovrl5skjjBNhcSJWJwMq4RWttJknw7lDceddFW/SX+9Ta4sb0wWTyD84bUo/vyNRnZfVuDq31fOl132KeLGXmBt1F99+zx8kc6HiyzMDPAioxqmyVw46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560515; c=relaxed/simple;
	bh=JUZYfNWqeyu8ax9/CquXg+BUUuuvENf3/WvlTt7mlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBmFwSpHRoIYSkXRmHLFCUrTwYg9an2PebJAJMZ+NwFL0pb9j/iNYwjRNzUdCMsp3C3RjI59oRTmIGUPo/xZtBocwdX6Ghx/yUhBLH4aom7RPuxWrHRELlrOUdPcKk9hRZb8sZyFAPOZI3O72AZg0dxbVek4nZ498uGC61gftGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9K8S3N9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA7DC43390;
	Mon,  4 Mar 2024 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560514;
	bh=JUZYfNWqeyu8ax9/CquXg+BUUuuvENf3/WvlTt7mlvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9K8S3N9URDm+X7z2jypotzkYL8LSs2LjKWeGlAnwAMSB4izfdnJcLG+5fKlzJ03f
	 j7Tcuky8aipYB/OzxP51i7SFrvNpv8pMRrJDItdfMiaPN14bai6lCEl2yqu03WlFvF
	 2qGKZTGyrUDKKtcr2bBz9xPVDoSCxCuB5738Q7EifYU3c+7v1qoMHCAGCFfA05yVSI
	 GOMYRLc7OWUKLLWyanL+KDgqxrGA0M6G9Kzw/6U0HBjyse8zCFrBZdolzSLUFf2mx2
	 lNATCEOA6+eOPiWkit3C3lVLPScI2+VQJ4p9zjpU670RxvAP/s18uRQKX9UUO63UsX
	 tpPRkitG4xNtQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh8mo-000000000yW-2VPm;
	Mon, 04 Mar 2024 14:55:23 +0100
Date: Mon, 4 Mar 2024 14:55:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: keyspan: Remove redundant assignment
 to pointer data
Message-ID: <ZeXSyit1fq5CFJSc@hovoldconsulting.com>
References: <20240207104128.2441210-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207104128.2441210-1-colin.i.king@gmail.com>

On Wed, Feb 07, 2024 at 10:41:28AM +0000, Colin Ian King wrote:
> The pointer data is being assigned a value that is not being
> read afterwards, it is being re-assigned later inside a do-while
> loop. The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/usb/serial/keyspan.c:924:2: warning: Value stored to 'data'
> is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.

Johan

