Return-Path: <linux-kernel+bounces-158017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96278B1A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A990B21CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57ED3B781;
	Thu, 25 Apr 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PrmBRQtL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="F+makd09"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEB2B9DE;
	Thu, 25 Apr 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022106; cv=none; b=LeSu7/Xbiql9sEO5XlGDX5NqiZi9TOYNkiiLRfgy8iMVy2Kq3aIXPyMXzR8QLhi/aP1WsuZN8YEHJ6mUVjA3bQfDmixyAoziPrQLWVXYypt/ydoop75zPDQ/2PBCMJBX5aHHQVv9jtzxcXFDpr9CdHgXQFXXYOXyrwconAXHY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022106; c=relaxed/simple;
	bh=iW8ATjleso1uM6oVbDeQRVFxVXqLdoVu5uZ3W7y/49I=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBvrbRzW7FjFVeibUmwGGNrCRutVuHuuVvOitVQlVulVMoiHsbd4B4pz06gcSt+rZVnzR5BNJzpIyaEnZBlDXh6bj9KEm9KU7vbqUaPFZ8+/cKGE8zHF/wIDtkmh45yoYeNqMwoK8gbsk8tiu8g2RbCyQC5XenW1ymGNuD6jgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PrmBRQtL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=F+makd09 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714022103; x=1745558103;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=BPkT8A48a6oXi458YKzL+nQT48iFaKKVvkLsK6sfIQ8=;
  b=PrmBRQtLU18tGvtdRqNaPYzfIobbHNakJBzhgQMXr4AnfxDSPcouCN1U
   cjnyJdqaRkLxIBZDJNb5yP0JFW7KJXOSyDYf8n3J82uTGbmDIr6WfMJoT
   ntggT+DJP6TbH2zb80s3J6rY+ZMlKlCnJq278Bp4P0Nq69ehxKVKjwXkn
   UEqEQuFnk/UzyZSUHW/7Oj2AE2e8Mrx3k5Tirl49Yangx9slVPpykY+Mb
   qggJE4S21QzhkyNpWQS1T1nvZ0lM9P+NR5cS6twJZJJ819swwvysFo1pr
   6OyYTBIkB5L+iKmwi8AyzPqSN/pJnzLd0mEErN/hJM66UU693ji4/iu4D
   g==;
X-IronPort-AV: E=Sophos;i="6.07,228,1708383600"; 
   d="scan'208";a="36602262"
Subject: Re: Re: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip to
 sleep
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Apr 2024 07:14:59 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55EDF16DDB5;
	Thu, 25 Apr 2024 07:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714022095;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BPkT8A48a6oXi458YKzL+nQT48iFaKKVvkLsK6sfIQ8=;
	b=F+makd09QV/2FCHjI+XH7QQZUn/V0xyGCU+yHRobL284y70ZbyQ4HJ5MCi1JEdH44/LEke
	e+OMl0VqEthNKUerZuKQa7fg7kX2EU4Fzx5lxoAakMZmySpqwxF2NhknjCxmGJA0T8tQu6
	UMlF1Vs5ufb8H7YV9zm+fqt41XfF65pQ1k9FEbJ0V4ZntBJEyH4YZTGYHYLQBI68QRWI5G
	Nh1iRYig8X8WWc0t2Jsju9LeY6Q9Cu48ovC8XcxJgyL/TnkbPZUUNROfQeqccDpSqkHFet
	OC25z7vGqXNoaIgi32ZhBi6vEW34TJJuvV7TPi8k2tlB8YyVdRipv1GP+jCdPg==
Date: Thu, 25 Apr 2024 07:14:47 +0200
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
Message-ID: <Zinmx6c2ITl3jQQm@herburgerg-w2>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
 <20240424-fast-sandy-jackrabbit-d289a0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-fast-sandy-jackrabbit-d289a0-mkl@pengutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Apr 24, 2024 at 10:24:58AM +0200, Marc Kleine-Budde wrote:
> On 17.04.2024 15:43:54, Gregor Herburger wrote:
> > MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> > is send to sleep and the timestamp workqueue is not stopped chip is
> > waked by SPI transfer of mcp251xfd_timestamp_read.
> > 
> > So before sending chip to sleep stop timestamp otherwise the
> > mcp251xfd_timestamp_read callback would wake chip up.
> > 
> > Also there are error paths in mcp251xfd_chip_start where workqueue has
> > not been initialized but mcp251xfd_chip_stop is called. So check for
> > initialized func before canceling delayed_work.
> 
> Can you move the mcp251xfd_timestamp_init() (which starts the
> timestamping worker) into mcp251xfd_chip_start() to keep things
> symmetrical? I think then you don't need to check for "work->func" in
> mcp251xfd_timestamp_stop().
> 
Hi Marc,

I realise now I confused mcp251xfd_timestamp_init with
mcp251xfd_chip_timestamp_init.

The only call chip mcp251xfd_chip_stop without call to
mcp251xfd_timestamp_stop is from mcp251xfd_handle_cerrif.

So it should be sufficient to stop the worker there and the check for
"work->func" can be also omitted.

Best regards,
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

