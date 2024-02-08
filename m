Return-Path: <linux-kernel+bounces-58022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842084E053
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DD71F2DE7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F966F06C;
	Thu,  8 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCE2WEam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181005427E;
	Thu,  8 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393896; cv=none; b=mgputIfAEWsnt5Xeoe6MCDcMqbFf9YKSy9X4jjRGZ28KFhg7MSdx8XR9Zp7FDlIxZ4Sr0EThw7gX9exMOiM3haQ1iJEfaoPGYY0Ed6wWtQtvt+CKMaMtAd9MkGGs2R0c37CXNQTpEIMs7XQJZls6Q7P31B98WiS/i6Dy5e5hb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393896; c=relaxed/simple;
	bh=0ZcUDPuGVE+L+b2vzZdil+JCvG+Tk9rlnQF0zUG9ArA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9MtCloPhmRNUojcaNIasK4GCbFIlvdm3UZJ6vLJmyvaEKaCB+f7LT1Jn+aq4XeXqMLsazlbuuWjR7Zb52fnUhyOqKWQYO8Mq9Qq74WhdMFRzLRCYp6QS/qr/bHdf16GNDBCPBWXaHsjzbygcZtTKrxD9j+ZSRYlxZIzf3y3cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCE2WEam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48009C433F1;
	Thu,  8 Feb 2024 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707393895;
	bh=0ZcUDPuGVE+L+b2vzZdil+JCvG+Tk9rlnQF0zUG9ArA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCE2WEam/i08AQDmxUE102VN+HBPzxWBu6GKB5NSY3GeM2idVe7UgWdpZyrIIqMal
	 FuVdpOxHNV7rahS8jYPI1Mfevttd1GWZuR4WyY95CcCgEmBCw/ijK4Jk0EDkWRPUD6
	 CC9u7Ql75qRYGrqTklmW2OPYqRwBqwfa5KB/809uu20r+UXtYA5WDJw20M2rMPvmeW
	 o1hY7SiC+XUIa9K6c0A7p1gNvsdRmLq0DQrP7530utnlXnPjcmRZyYoSrRblZg5FzT
	 mOXIEM/ZYCMOLeeBjbSRBLnPqYZ7CnSnrpedGltSZG0MiSdXzEmGmvXEgN7YggIbh9
	 gqyhN6jY15vmQ==
Message-ID: <ce5cc093-be51-419b-9560-541bde00e2c1@kernel.org>
Date: Thu, 8 Feb 2024 14:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com,
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
References: <20240205090546.4000446-1-danishanwar@ti.com>
 <20240205090546.4000446-2-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240205090546.4000446-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 11:05, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
> to manage/generate Industrial Ethernet functions such as time stamping.
> Each IEP sub-module is sourced from an internal clock mux that can be
> derived from either of the IP instance's ICSSG_IEP_GCLK or from another
> internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
> instances. The IEP clock is currently configured to be derived
> indirectly from the ICSSG_ICLK running at 250 MHz.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

