Return-Path: <linux-kernel+bounces-81486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCCE86768A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2411C296B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62647128800;
	Mon, 26 Feb 2024 13:28:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208CB127B6E;
	Mon, 26 Feb 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954114; cv=none; b=g/tm5jAZSE4F18s4LxAQh88Qclh+gLcq2iLtr8oz/+ouKiizbynBelVZ4rXx89qQKAWjj9ZWUmXXq/0XK97SJEbi2fkoPX4zVhxQpDJcTUMRKvIFmFBYB/Xv54rmBzEXBo1Fl9iwPI4J7y+A3rgOPBhvzjCzif+oE00DdpQa6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954114; c=relaxed/simple;
	bh=lsekurNfDyoNoAst1mZ5iBeo8IP3IhL5tJmzXViCPVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctRzRby4h/SoW0MYkl+WnMk1svIeRb7UeU6s/3lCWiWwp6ar7Uy/jPBEV3m9SLbI6k5NAqmULUfdyEAGGKtb0bhX2h/EEj5ana7+Xg4nrv539P3n2HLKdVFS9t30xp/DUbx6LJT37XFZF4BwcLqzyEIWD9eADlqX9q3FhC2R2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15BB7DA7;
	Mon, 26 Feb 2024 05:29:10 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343433F762;
	Mon, 26 Feb 2024 05:28:30 -0800 (PST)
Date: Mon, 26 Feb 2024 13:28:28 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Message-ID: <ZdyR_MWeqOWga8iQ@pluto>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226130243.3820915-1-peng.fan@oss.nxp.com>

On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
> 
Hi,

yes this is something I spotted in the past it was missing and I posted
a similar patch but I was told that a protocol node without any specific
additional properties is already being described by the general protocol
node described above.

Thanks,
Cristian

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 4591523b51a0..d99f1577476e 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -141,6 +141,14 @@ properties:
>      required:
>        - '#power-domain-cells'
>  
> +  protocol@12:
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x12
> +
>    protocol@13:
>      $ref: '#/$defs/protocol-node'
>      unevaluatedProperties: false
> -- 
> 2.37.1
> 

