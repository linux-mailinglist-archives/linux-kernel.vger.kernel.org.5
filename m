Return-Path: <linux-kernel+bounces-67247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1085689E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DE1F230C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AB13343E;
	Thu, 15 Feb 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOI5aQCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2213342A;
	Thu, 15 Feb 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012671; cv=none; b=g5I2zacKyIE7dFkagh7XvaALXqhw3IeyOw90SwH5yacnzfaFiO9tNx5yIrKu/38kWdf4dkhJBc7TME/PHqGBnhSb70pYQAYiLvoryuKFpvaqqoVzfUzLgy4viMpLGL0+z8pPLTtIDP3mSmvgSPjRu8WXWRTsLCR4BJrDtO+Tm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012671; c=relaxed/simple;
	bh=9EX9jPvqFAvyjUBCps/eEytir8Ftg1wlyBTqud2KIzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAFlaCDe4mGODzWj9b/NLSJwyjHaIlK0D6I85muZeQSIkyG80Scwxm6+9wlVHRbk+z3YQSympI8A71mg4rd4O+fLsDnGPB/hrStdm4LL8EXbXfD0KA5JSS8SryGuCdNB1YbG3nMtcadR3iJzYeNGC7xBzZR0FoI0OtrES3+1A7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOI5aQCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24899C433C7;
	Thu, 15 Feb 2024 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012670;
	bh=9EX9jPvqFAvyjUBCps/eEytir8Ftg1wlyBTqud2KIzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOI5aQCyPXj8CawPNruNCcI1r+/1MZsvdkOCXPHZFsv+iDeR67jktysjLi9LI20o9
	 fcrUVzp23hGMhJ662bdPaozNwZXLf0stEwFQfWFyy//q6/CMkpFNAKd71dsvsEW48K
	 vG8lJ117ervzUUf4b7fy4Y4+34vAzZwymy6wHgE3e/Olqb+1X/NiYUWvOTcIdWs9Um
	 AGOt6JFSFou/VI0as8Z/rF0L4jencRtd3BbvFV7Wv58ojiuAChsBuWZpO6jllfh5O0
	 2XiVmNK4Up7eflGqVIRbzLeu8U6lohBNAIG9r34KhoI+baCacNnfUz2h4Z0g80FVf6
	 2/gxc5lQrthzQ==
Message-ID: <71adaabd-bb24-4181-9fdf-f7191e93edb5@kernel.org>
Date: Thu, 15 Feb 2024 17:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay from
 ICSSG nodes
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com
References: <20240215105407.2868266-1-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240215105407.2868266-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/02/2024 12:54, MD Danish Anwar wrote:
> Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
> property is no longer used by ICSSG driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
>  2 files changed, 6 deletions(-)

What about the DT binding document?

-- 
cheers,
-roger

