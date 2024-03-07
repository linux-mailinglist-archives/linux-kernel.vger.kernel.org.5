Return-Path: <linux-kernel+bounces-95787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80687529B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A40B276EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3312F58F;
	Thu,  7 Mar 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV/oQb4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92312F39A;
	Thu,  7 Mar 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823707; cv=none; b=dTOTn+t6Sb+V4436psHgvOjzK0L+X4TWF+3NBPBcAbjF7VliDKk0s0ZReWFQD7LxtISLxFcVRoLne9zMc3dHGhZE8S4UEa2BMM0jKpsqTypw8fe8YSVNk82wa7kSGz7lr3m0ctorSSXfZodAans1w11cdfLj8j8Wv2X8Sg6ojUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823707; c=relaxed/simple;
	bh=kFqwvVTOMTddqJpNVYpl581weLmfL4KpzIunFD5G2tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiEwYCB36WtNzxlluAey6yPtYXABtX0a/TGagKPMtgpQAimvmfGk1ibFxgFxZ5CvX6zq2BEjL2xi3XFMtAeHrozFyRCMJaz9lYIwxVNxONP+Q7r3T/Knjbj5MrRkTD6C1+ADLxs+c5N9NLlwHosd9/Pv/8BUyap2AxLtnEdXwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV/oQb4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9942AC433C7;
	Thu,  7 Mar 2024 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823705;
	bh=kFqwvVTOMTddqJpNVYpl581weLmfL4KpzIunFD5G2tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV/oQb4+7eegleUHG8zBIY8Iw8OQDCdYeNU9OPzTap0clCg6T0REN9AgbUgF8xoYz
	 ZxPdBZrIFtJjXyXPQtWHf0Is7BxkHGqckdVo7szCRpVDlOLyw1bJzULdliOv77QBDA
	 75Ux1TTwL8a1KS/tkC8oUbYowBdaZSMNeBCZjfzNKQREJ+ChV/iDVD94K5w2JL1jtd
	 owuCu0vHWnNwuJKUvFkf8h8zd9fOl2wNpPFvY8BtPRGihrOoLGZoje/5LDYBZMhPwy
	 /N1el+L/vusnR2hjc6MJySbZ6VKMcBqn4kxXOeGo+rKpQIQHDChP4Bd5sIou6A2GNS
	 hDYruaO2zQY0Q==
Date: Thu, 7 Mar 2024 09:01:43 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>, git@xilinx.com, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	michal.simek@xilinx.com,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: rtc: zynqmp: Add support for
 Versal/Versal NET SoCs
Message-ID: <170982370249.2592194.17824798576485392440.robh@kernel.org>
References: <5ecd775e6083f86aa744c4e9dfb7f6a13082c78a.1709804617.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecd775e6083f86aa744c4e9dfb7f6a13082c78a.1709804617.git.michal.simek@amd.com>


On Thu, 07 Mar 2024 10:43:46 +0100, Michal Simek wrote:
> Add support for Versal and Versal NET SoCs. Both of them should use the
> same IP core but differences can be in integration part that's why create
> separate compatible strings.
> 
> Also describe optional power-domains property. It is optional because power
> domain doesn't need to be onwed by non secure firmware hence no access to
> control it via any driver.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - make versal/versal-net fallback to zynqmp
> 
> Changes in v2:
> - Change subject
> - Add compatible string for versal and versal NET
> - Update commit message to reflect why power domain is optional.
> 
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml      | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


