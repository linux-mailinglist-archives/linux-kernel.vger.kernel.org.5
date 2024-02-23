Return-Path: <linux-kernel+bounces-77577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9D8607B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C424A2867EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD42563;
	Fri, 23 Feb 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5QhEg8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6412372;
	Fri, 23 Feb 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648119; cv=none; b=iMrnr1O1RDKcTaEatDHm8K1xgbNgRry/dxar4tQRy2P2nhNEQOXt9IbTL7xaFJrBESaCXsOHp5cWs2SskMGqBEBxzRv7Z5VMn0dK5iz3WWITUAzjzq8Ev5kIzeuK3Y1uOjrTxX6k/LDE0K2SBs0g8W1pw9ljOK3iFpfCBYrYEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648119; c=relaxed/simple;
	bh=BIOShrfId+PvEScAHDccqecR5fsM4CjTGwPiQXwonvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrdJ+HiWhCQLVfTcPDUCoH3hTFTcFPXQSRAh0g7wshzT+kJsoT+H+9zjIXnIci/zMELgMo+YNR0aKARAnrB7IcTrp3h2PrPp5kItgTpKn+zw0oIKrAv5rkdogjhg1aK8awpgRgILwJr6BVuwuHSL6Hxxhs9nPbc5LCFZEffbLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5QhEg8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B646C433F1;
	Fri, 23 Feb 2024 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708648118;
	bh=BIOShrfId+PvEScAHDccqecR5fsM4CjTGwPiQXwonvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5QhEg8lYLfgHGOKjgLHo6tSne8/LTwZ5azFG7lFyilAjxip/d6iBXu9+fJFWMqPL
	 PFm581Emk9QWzSse2+F+vpiBeTjnFnf3S8kntyM7axnA48cnU5Uiw2rJeNwBuWDt+v
	 nmBlbkU39Nz9rGE56HCClBQK81Tf1vjWXdDGdd0beRo/vdyfDoySSz+UXgj6RjfY5u
	 Z1TsM8MfdZSEJV7FG2mwW320NplpUd3IcUIfSExX/O4ra9NziqUxe+qKVhf3WwAK4Y
	 pH/KmJ8SaVDY2F+bDagNIPjNc365gBAAwPYN9cN5b23Xv6qVN68QIUuPPKknu3F9d/
	 4mbjfL/DJs1LA==
Date: Thu, 22 Feb 2024 17:28:34 -0700
From: Rob Herring <robh@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: Mehdi Djait <mehdi.djait.k@gmail.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 02/14] media: dt-bindings: media: rockchip-cif: add port
 definitions
Message-ID: <20240223002834.GA3933946-robh@kernel.org>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-2-2680a1fa640b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-2-2680a1fa640b@wolfvision.net>

On Tue, Feb 20, 2024 at 10:39:12AM +0100, Michael Riesch wrote:
> The different variants of the Rockchip Camera Interface may feature
> various ports. Add a new header file with port definitions to avoid
> hardcoded constants in device tree sources.

We generally don't do defines for 'port' numbering. I don't see a reason 
to start.

> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  include/dt-bindings/media/rockchip-cif.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/dt-bindings/media/rockchip-cif.h b/include/dt-bindings/media/rockchip-cif.h
> new file mode 100644
> index 000000000000..37364ee1f7bc
> --- /dev/null
> +++ b/include/dt-bindings/media/rockchip-cif.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (C) 2023 Michael Riesch <michael.riesch@wolfvision.net>
> + */
> +
> +#ifndef __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__
> +#define __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__
> +
> +#define MEDIA_ROCKCHIP_CIF_DVP		0
> +#define MEDIA_ROCKCHIP_CIF_MIPI		1
> +
> +#endif /* __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__ */
> 
> -- 
> 2.30.2
> 

