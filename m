Return-Path: <linux-kernel+bounces-153536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A753D8ACF50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D77B1F21C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBA1514D4;
	Mon, 22 Apr 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO30n1Wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802A1509A1;
	Mon, 22 Apr 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795971; cv=none; b=gdt6rQUXNit5n7iISLkFAAnTko4xBFHsXiI2O6A9dvQf9EaQgKo5cBV2yrFeEy+hy4GNAUD/86mS/pnwVD2YfO9aOVD3iBhvhDdzlZ4JZ+YmXBz7pOtCEsOfRCRJDVh+c+nu6XiAHUVil7v6PV+Znrxy5r9sABNVl28lDYhg74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795971; c=relaxed/simple;
	bh=l1HxNx2eiULXODLs9ISL/NgUbofvNatwk21BeZlWLZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvXX8jjPV8A1Rk1N1sYrf6cpMRMtaOD246TEHKjvnA1sxa4jFpafyQ5Puk+/+8yliJlyiqCQwy8GQ/QvwXF2BpEIYARQdjVUV5QQ67pONZbCfRgNjrCBYKQnfwnDbv8JYUVjkaODwpRPUN1d1fseEtMJBQndCd2SQ6QY5mf0kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO30n1Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB46C113CC;
	Mon, 22 Apr 2024 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713795970;
	bh=l1HxNx2eiULXODLs9ISL/NgUbofvNatwk21BeZlWLZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SO30n1WuRsp5x69ZDXwesLSeWAr2HlgsUx7e5PR/mJ6vUy0CfRPJ9HhYCe2cp8hYr
	 686lp1B9UTQPjCCceHZRmQFUwm1r5TGyEF54Wa5661swc3nUry3inN8qAzGwkH6Zj3
	 /waxA+qUQXrBxPinq0MnOHYv8juJ49Wc59D9kYnERdPYUz5pQodZCFM6kOmvxGO+6X
	 YMGNicgA/4ojTIrF4AgRK42poO9b3uTeOlCpwiNVD3b46FJjWFYAYhZgB9dJIQ3F9Q
	 4WmGweMNkZVzoNqJZMxhQRJOrrp6NzXyJ7lXKlwFeDrVVlDFfRQLA4bfszOSBf/naN
	 saDC+ymOlZHYA==
Date: Mon, 22 Apr 2024 09:26:08 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: dsp: support imx8ulp dsp clocks
Message-ID: <20240422142608.GA1207218-robh@kernel.org>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418203720.8492-2-laurentiumihalcea111@gmail.com>

On Thu, Apr 18, 2024 at 11:37:18PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> i.MX8ULP DSP node needs a MU clock, but doesn't need
> a debug clock. Change "clocks" and "clock-names" properties
> to allow for this case.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 51 ++++++++++++++-----
>  1 file changed, 39 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

