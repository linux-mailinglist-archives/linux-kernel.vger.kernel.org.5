Return-Path: <linux-kernel+bounces-31552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B1832FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8AC1F21C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0445730C;
	Fri, 19 Jan 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imXH2EhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8956465;
	Fri, 19 Jan 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696921; cv=none; b=FMIxDumsIMV9QHbrFHrHcPagPPicQmF7YWsp9EGsiEg3Jbsv05+OCk5WwjgYRdyihtnu0pkyqX/te8eL0QU4QGR3mcAoh3HngcInBUwYaL4UO4FigKwc4IbNT96VBfJxbp8F9dpUVF6N4q1fAPYuQvTy1XldXErkzU3DSv6DEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696921; c=relaxed/simple;
	bh=TLrgAqL1NOTw+UjcDTBMzcNNHWGM1cnRBcPLLPNKhSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0wgpuqf0i3L8QY/O/ohfUqs8vKwi5FdXpbMi5KSCqqZXsrP3xPVQVxUpsVCVXnDze3tHnwABIFTVWp9m/d4BCKw898BkMU5/Z58GefI2wu6oDXu+iZguocPOj+cCIMI1cE+XVfV7qDDJe57/IXCkOgvmPe17QGXlFHglwZ2Dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imXH2EhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9837DC433C7;
	Fri, 19 Jan 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696920;
	bh=TLrgAqL1NOTw+UjcDTBMzcNNHWGM1cnRBcPLLPNKhSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imXH2EhEWKk2Jz7GdbEYP4pJq8JKV6/zyj37uMgODoL0W9kpiclc/rL21/YPMOBxu
	 I2P1SX/s/iuvZ2s5EL565NA1pYck5JqcZJ7cL0RK6B7AhFHvY9UI5vuuYWTVyaDMPn
	 ihbT18Zq33FtAGX+s8+TPtkfbDvJQLWYfRx5TYKTgPvFxenDdPiRkQjFCMYiAFAgh3
	 K3cUAaIoThIRggsC1OZINnkzWoJfkbZBuiQlzHztz4wayEGZuvAIWAmWj4Ka/2J/F7
	 +4WqROHG45U5etD4TXNV3n2qfzybRMTP+Jz60Gx3FvC6CTTpzksqshyQ6zNMltLuox
	 EzscKOT+mL1wA==
Date: Fri, 19 Jan 2024 20:41:54 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 3/3] net: ti: icssg-prueth: Add support for ICSSG
 switch firmware
Message-ID: <20240119204154.GD105385@kernel.org>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-4-danishanwar@ti.com>

On Thu, Jan 18, 2024 at 12:40:05PM +0530, MD Danish Anwar wrote:

..

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> index 48d8ed4fa7a8..90d0d98e0ef9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
> @@ -14,7 +14,7 @@
>  
>  #include "icssg_prueth.h"
>  #include "icssg_switchdev.h"
> -#include "icss_mii_rt.h"
> +#include "icssg_mii_rt.h"
>  
>  struct prueth_switchdev_event_work {
>  	struct work_struct work;

Hi,

I think this hunk should be squashed into the previous patch.

