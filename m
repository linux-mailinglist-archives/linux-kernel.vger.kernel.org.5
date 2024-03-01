Return-Path: <linux-kernel+bounces-89129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483586EAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700941C21413
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D98456B85;
	Fri,  1 Mar 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF195vfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112D20DCD;
	Fri,  1 Mar 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327008; cv=none; b=mFIIUVcjfQPoKBIV4BcKyphhyBSPYc4ByAb3S4x8SriFbRwJTowIVLzegU/ClIb/40ki9WgpkGJlN1yDxh1+Azzs/2mgfLw/iJvM8A3apbkSU8uG1qPZHWMeAQmyzUbZpQv+3FX6UM2HMCMlZkgv++XyvWTJgK16pOHZZgzlqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327008; c=relaxed/simple;
	bh=0+v0RJjRiOKpETqQHZw+J50p87NMv2euXCc2vzkh0sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2m57myyJhI9egUz0ecFWTxnYGPSMZjl2PvZouCJ9Wuc6u+OWwNujyyWRLSitR/BNIXqa1SxJoJkmPnKEUcuaraXi9TRt+qWHSwBq3KElpoemh6moAC209bl2Vwlq6g++A4Q1Yk8Yjbsii8+XgUeh+/heGU8vzblvZhPPA6e44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF195vfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F1FC433F1;
	Fri,  1 Mar 2024 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709327008;
	bh=0+v0RJjRiOKpETqQHZw+J50p87NMv2euXCc2vzkh0sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rF195vfH9NqLEfYBRFCJW8hJ5esSZkTil4aneAhIav6AwUyW0DSa8bDawy1Qrvywn
	 IaLwnqb+WLKU9+/Sp6FktJapA4IoB5x4bXLyxQ/WxhjVCZd/f7rJCdTSOqHp8xcFdW
	 pMJicdFX1aH8cgYXH5eU3zxr0Of2JOl9pHGsJQ9lkD2egeOblkQNPnrZ7HvdtfH3BH
	 ySgJFGTKqLIi57b9zPyZKetxTE+2eWX8Eo6k/RYPEdODIWFRdqE1+kPN28EBNZ4vMW
	 jAXq8UFjWKhIQQ+M17A2PJfxW4GdowfLT1OPXHlMeHQoC0xamiM0axa5/TYNQ+uMCT
	 RXrE7efNSvW4w==
Date: Fri, 1 Mar 2024 15:03:26 -0600
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] of: property: lower loglevel of
 of_graph_get_next_endpoint
Message-ID: <20240301210326.GA3020204-robh@kernel.org>
References: <20240223104721.4140880-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223104721.4140880-1-m.felsch@pengutronix.de>

On Fri, Feb 23, 2024 at 11:47:21AM +0100, Marco Felsch wrote:
> Drivers like the tcpm.c do search for a remote endpoint on different
> places to be dt-bindings compatible. The search is done on the device
> itself or on the child fwnode in case it was not found the first time.
> 
> This indicates that not finding the remote endpoint at the first try is
> a valid use-case and should not cause an error printing.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Hi,
> 
> I'm not 100% certain if this is the correct place but if our platform
> follows the dt-bindings we receive
> 
> | OF: graph: no port node found in /soc@0/bus@30800000/i2c@30a30000/tcpc@50
> 
> a few times because of the below pr_err() and EPROBE_DEFER.
> 
> Regards,
>   Marco
> 
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 641a40cf5cf3..155df04a9512 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -665,7 +665,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>  		of_node_put(node);
>  
>  		if (!port) {
> -			pr_err("graph: no port node found in %pOF\n", parent);
> +			pr_notice("graph: no port node found in %pOF\n", parent);

Already changed to pr_debug.

Rob

