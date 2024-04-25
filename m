Return-Path: <linux-kernel+bounces-158573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFF8B224E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F83285D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7B149C69;
	Thu, 25 Apr 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0GZa0gQU"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A5139D16;
	Thu, 25 Apr 2024 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050765; cv=none; b=nmqesciStK3SQKJ4Sq28OqGkqMgRMry4I8bGEliFNk/v3665k/o3veeDn5+P/+nFgMbYHGzWidL+l6X+dZuaSg3daw9w5PIJRIBYjVswWySFNPuis3xPpk5O9zUSXqx+AWPIOtI9hEhaBqkDlI1g6woEmWzREcAGwsfuMS7FzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050765; c=relaxed/simple;
	bh=SWbsN8gb0T+55zIEnnjHmugKc2Hefu/p5fPeAaJnVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pOtXfDMnazh8+9QyrCn8gLWVSxfQQ7Y2tyhD3whZP1KvwKJdNN/XRrr2sm7kHBhi8ZqEcTmqgADFGME0dYQH9hrYbvvZJJ+VvpbrPLsgf3fKF0Eq04ng3TEJWAmlZpx2JvMfjz1LLgmhiW0/LXvl/uJFbOXvaFy6l8LzMDm2WKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0GZa0gQU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 569331F9E9;
	Thu, 25 Apr 2024 15:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1714050754;
	bh=mjjqNnQB3Y3PmO3eF7RCQ6exiD5LgwcG2Ut4A6E+9WE=; h=From:To:Subject;
	b=0GZa0gQUG+IjBubLquW3DLf34IruRGf2YYuTX+SKmE8vh0fYBcnrocw6OSc5Sgj1+
	 cTtKdsqUymXImgTdD4XxFy/ZmzGypggh0t9/bOYSqAdamNlntUSwPqvBnI2ZR/+SEc
	 PYJsRN6kuiCiPRfkD3Sr4uTkV3/IkzkWuuqT6Yy+IGiqrqmeKsy68rjY05WvBze+a1
	 jX5Az0VNqfOXfHjj6AxQ+CKgxxtiU9fFRfBMjynmyI9X7WgeDT5TS+X5GaKS0PKf1q
	 HXImYdeUeA3SKvuigNSUP6Y8ju+1ABoPe040XE75ZqFlNWYJM9MrDXSub6Uij1mJpi
	 h9txzP/TXhung==
Date: Thu, 25 Apr 2024 15:12:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: mkl@pengutronix.de
Cc: Vitor Soares <ivitro@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240425131228.GA15857@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311121143.306403-1-ivitro@gmail.com>

Hello Mark,

On Mon, Mar 11, 2024 at 12:11:43PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages, and the interrupt routine does not return,
> running indefinitely even after killing the running application.
> 
> Error messages:
> [  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
> [  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
> ... and repeat forever.
> 
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
> 
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
> 
> This patch resolves the issue by decreasing tx_ring->head if
> mcp251xfd_start_xmit() fails. With the fix, if we trigger the issue and
> the err = -EBUSY, the driver returns NETDEV_TX_BUSY. The network stack
> retries to transmit the message.
> Otherwise, it prints an error and discards the message.
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Any other feedback on this? Just reaching out to be that this does not
fall through the cracks.

Francesco


