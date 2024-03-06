Return-Path: <linux-kernel+bounces-94554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB887414C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F69288B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530E141981;
	Wed,  6 Mar 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9QKaFXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051C604A7;
	Wed,  6 Mar 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756294; cv=none; b=rGhAL82CWT9fVtdPvJ2L+1V8Jrx2yPoWxV+iR1cDk5ZO3WtgZQ5htZmiQ2OZe9THqkChgB+jp4kUxA8KbfmWvVJ89+21VjVDnD0/tXMyCE+0F8EhRH+h32+yRQfi4X49zb8TqCEwfRJO4cBVzYgX/1DACx6MiJQZgsLNhsGRbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756294; c=relaxed/simple;
	bh=QQAsomWqP0GIhv84NJxEWiZ9psxibVcEKS3Lk0WJtKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAZ8K4q8A8lEXH1FMcUCrPmaENeDV0GZPagQRvAGBGpWBeHCBUMgs/Jn6BoQL6vwUQgtP4I6e59y+YUXUCdZYYNm6NsYtEtY6LX/dpmPYe7DRCy29jafs/dAtW7YHXxu9YGOouVZ1nHn5J7BcaINUHwDOFv1j8Gx7hV1MjDWzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9QKaFXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66074C433F1;
	Wed,  6 Mar 2024 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709756293;
	bh=QQAsomWqP0GIhv84NJxEWiZ9psxibVcEKS3Lk0WJtKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9QKaFXEst0r8LcL0Kv3JdAQpjAMnN46eqidAlBs5MLyWsQHgtFN3Vclnt1XhEir6
	 X+kyEVIn63PLCqiVduy9MqnNEudVpb4aQvQJ89UMvNlZ8qoA++fTs6w8yYqOjJ0X5j
	 EgOid3pcgDyen1s8XxGDgpDtaYQBPALflg9FiILCB3bzNX4OywjdaQjyxrWt6efwcw
	 3KYlUXRM/a8ztH9MZ3j5IhpC63pN2ixjxw6IQCkK3k2FJ5nzqmelIxde9I58v7vySP
	 DbDMl/aZdOSRfz5n5StYSh7a7bX7nDhqGGJbjq2F/ph/PZOK3V8najJSK4EnOCjNxN
	 aeOXXo7v54okw==
Date: Wed, 6 Mar 2024 14:18:11 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Linux Team <linux-imx@nxp.com>,
	imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,intmux:
 Include power-domains support
Message-ID: <170975628978.586051.5157998037495552769.robh@kernel.org>
References: <20240229200911.712572-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229200911.712572-1-Frank.Li@nxp.com>


On Thu, 29 Feb 2024 15:09:11 -0500, Frank Li wrote:
> Enable the power-domains property for the fsl,intmux node. This addition
> accommodates i.MX8QXP, i.MX8QM, and i.MX8DXL, which utilize the
> power-domains property. Incorporating this eliminates DTB_CHECK errors in
> relevant device tree source files.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - Add reason why add 'power-domains'
>     - Use maxItem: 1
> 
>  .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!


