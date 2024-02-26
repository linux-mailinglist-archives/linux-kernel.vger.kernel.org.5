Return-Path: <linux-kernel+bounces-81756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07728679C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819B11F2FAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDFF12FB14;
	Mon, 26 Feb 2024 15:02:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228980049;
	Mon, 26 Feb 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959752; cv=none; b=jval2lm7UtpX2OvR6knQges/ct7k3bx8/dRJNkajLgv6WvEHucDNri4SUiOV890Y7ROC9IVgAEL60tdjLKor8C3JgiQrdLrZenWe886fRxVOJHMbDyUgLkrY667IvBOB2OtvLTY065hluDYbH5DuHvsHAf0DEhtZhynOncEB7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959752; c=relaxed/simple;
	bh=lxru2RLpQGafW/DK//nd6H7g0aV878wnKDx+n+iQDv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw54RVy2pvKNswjM0Q/MOLMnhYbEZ+eIUCdBNNs+yUqqWcubO1SdpFZT4ZFutyD5AAxc+CcI4n+H/VgasvC0Now3O88eGEKveLrPbD3Nv1jNafoZEEIAj4qmO31/4aXpUqbZxVyGwXkAZcz9ub+a1u/aSOzASTn20m+EViOj/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F664DA7;
	Mon, 26 Feb 2024 07:03:08 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F893F762;
	Mon, 26 Feb 2024 07:02:28 -0800 (PST)
Date: Mon, 26 Feb 2024 15:02:26 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Message-ID: <ZdyoAsYGXK9GjHVx@pluto>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyR_MWeqOWga8iQ@pluto>

On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
> > 
> Hi,
> 
> yes this is something I spotted in the past it was missing and I posted
> a similar patch but I was told that a protocol node without any specific
> additional properties is already being described by the general protocol
> node described above.
> 


I was referring to this old thread...

https://lore.kernel.org/all/20230124222023.316089-1-robh@kernel.org/

Thanks,
Cristian

