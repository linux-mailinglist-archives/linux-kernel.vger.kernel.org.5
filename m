Return-Path: <linux-kernel+bounces-2772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA7816191
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F9F1F21E27
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1D47F47;
	Sun, 17 Dec 2023 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q6Uixddx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA9315B6;
	Sun, 17 Dec 2023 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H3Yg9Ks44h9xKxHznRP1HbmjN2e0OY+H92vAnJ0cCh0=; b=Q6UixddxCDy7gVGAHV27qsheGf
	Jd7EFu86koHVAIv7bZFLthsnvAftOIxQh4UtTzhOfPcsqmAZ+TZNvXGBGr2GrrMk3fK7jIl6QWyVA
	Ld+EoMuLG3+RXOg5ZWFFtSKxh1GqGoldy526reoKJMgBgZ6EORoh31GgUVM0b542unKU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEvel-003AIp-Ax; Sun, 17 Dec 2023 19:14:27 +0100
Date: Sun, 17 Dec 2023 19:14:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12 net-next] qca_spi: Improve SPI IRQ handling
Message-ID: <c5b81005-e309-46df-b534-b24814d10006@lunn.ch>
References: <20231214150944.55808-1-wahrenst@gmx.net>
 <20231214150944.55808-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214150944.55808-3-wahrenst@gmx.net>

On Thu, Dec 14, 2023 at 04:09:34PM +0100, Stefan Wahren wrote:
> The functions qcaspi_netdev_open/close are responsible of request &
> free of the SPI interrupt, which wasn't the best choice because
> allocation problems are discovered not during probe. So let us split
> IRQ allocation & enabling, so we can take advantage of a device
> managed IRQ.

Could you replace the kernel thread with a threaded interrupt handler?

      Andrew

