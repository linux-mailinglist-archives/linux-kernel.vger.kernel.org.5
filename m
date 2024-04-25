Return-Path: <linux-kernel+bounces-158020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57E8B1A45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DB01C214B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB33B78D;
	Thu, 25 Apr 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="j46R/NrE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m41kyz8+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25653A268;
	Thu, 25 Apr 2024 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022243; cv=none; b=RpPjCsqdDYlvqSVl1ruCcpzEegrTb2uaMHQRNQvuBYan/lx2a/xBuOn2XoiQbBG6ytqtGXX9Hnx71ypyGU/69BYp8S2jxSFV5azBAlt/GmXFN1nbmyRSo4jIVUiBNlCN2nELpe6D0ZMerZWrGMBNQuWdt2864XRXgVFUy8jLDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022243; c=relaxed/simple;
	bh=RK2YlCh2s9KnyoLCc1jJ8rRT18CZqFxUXklyFFkdZSE=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk1RY6Su6VY//iBE02DqXVnVpJ7UO7pJVIrPZze+INMIssNBEWawApFY9u2DEkIGX2vfynEb2BqM9OWQg76z9hGXPPETXZ5q5ZiMC/RFfyBrbVJm8lbHR0H6lecZG+QpnXxn91X6NSrCtrcofSp675BiGxvdmHjOZObS+IHW8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=j46R/NrE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m41kyz8+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714022240; x=1745558240;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=/xj/OOBC3+MsFiy3PYCAgX5GBgEu3yvNZiuEeiuPbtE=;
  b=j46R/NrErrdUiQne0KGY6LkJUm8xy0dvpDMvOMdPmnadVgoNjXg9InM7
   cU4tq6CdOUI0cHabWkK26YtKGn3QcXSWg8nWGy2w5ZxauXAXWF+0Y0pbT
   VD0OgEEZ3OxehwiHNIvggFsERSiebIqdBah+vnDGo2KLNh43+AIiKqWRs
   ISl4DfgWH8Wo/foxLq873fde+FmG9lREKggLNjnyPIySWpJYd161xhLw9
   pNzwhL1X5QxMqcziKHzV5GWKSLZXp5Bq1e41/z5AAT/5ohZFwRLMcQC7r
   OSebZrEeCAw0Yy4pr+HSOunDO7oAs5qQY3GQdJAMWWuGESlBvgPycefOP
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,228,1708383600"; 
   d="scan'208";a="36602300"
Subject: Re: Re: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip to
 sleep
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Apr 2024 07:17:17 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07567170DA8;
	Thu, 25 Apr 2024 07:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714022233;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/xj/OOBC3+MsFiy3PYCAgX5GBgEu3yvNZiuEeiuPbtE=;
	b=m41kyz8+Hl86bU/LuB0roKPfJ9HH4G9cxaI4h2qJX9AcbSqdCzSz6kMRfbfHehajlTMlpW
	ydzEgEhr15jSo6TSkOtWyrqtlzHnKC1hsxNWp/LdKQyyFWuw5Q9vdE4gOU3CATG+Q1BhzA
	Tm9vDm7aiTFYbMgR6ErSiVRZ52ZmyvEFw/RVxpSZdp1UyCtgp9xPBT0HqGlLF69N4iM7We
	235dcejgD5CPqcCUHy6BqnRDNh9eoouOXyqnnlqNHLDf38Sxr6vqhk7OiOfni1IVD5S4+S
	utTCAVEktHx5HRJE14DzJ21/TCuSUlCNg5nQ0ys94OsknXoOho3ddYJLPDMZQQ==
Date: Thu, 25 Apr 2024 07:17:11 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Message-ID: <ZinnV+GA20LWGUOV@herburgerg-w2>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
 <20240424-adaptable-zircon-badger-1fefd9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-adaptable-zircon-badger-1fefd9-mkl@pengutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Apr 24, 2024 at 01:54:54PM +0200, Marc Kleine-Budde wrote:
> On 17.04.2024 15:43:54, Gregor Herburger wrote:
> > MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> > is send to sleep and the timestamp workqueue is not stopped chip is
> > waked by SPI transfer of mcp251xfd_timestamp_read.
> 
> How does the Low-Power Mode affect the GPIO lines? Is there a difference
> if the device is only in sleep mode?

The MCP251XFD_REG_IOCON is cleared when leaving Low-Power Mode. This is
why I implemented regcache.

Best regards
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

