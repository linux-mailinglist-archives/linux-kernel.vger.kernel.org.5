Return-Path: <linux-kernel+bounces-60912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCF850AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590BC1F2256C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4545D487;
	Sun, 11 Feb 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Cxxgr7NE"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB443AA0;
	Sun, 11 Feb 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677732; cv=none; b=dA5dxwt2kxSiVU6CXeIdzojImBX9i8m/CEkc1pQNU1QIpsWAQCzvNt6MTjb+cBlD/AnBBujB7AIDJGA2O4g+i6JVDSiDUYMZSqVEeN6ds+iAGwq8CC/3Hr+5hWKO6KIYXJdHXslPZ9Jv5bSrmSES7GWpo3AQUkp1Xx1ebsgUY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677732; c=relaxed/simple;
	bh=lqk4STgRpueQJ7qWa///ySfTaWOZBBJd17euwFJH9iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g897J1ze0SlNdn7DWb4pE24ZtYHA8mxVK21HY5m1IXWgyeytr8wjzXDYR8obvYEV5MhGYEUqdDwdgQWgw10ionBVtAmBhl9PAVfihO8Rl1l3rD6NjJwdYdaDp7Vit/n5ev6+yWzBSkMT72DBMJytks79iR7uTyqVBbL+c0ryYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Cxxgr7NE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8406587C4D;
	Sun, 11 Feb 2024 19:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707677728;
	bh=58z4CTvLg4x4eiEhzPFwwwmKQDV91lyZxL55+eo8WVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cxxgr7NE5mYdOvBdyFh75MncEiEqoLzzhlINwgbL5LhtJEubLqkHTGQPB8D5gG5Zc
	 9HmptjBpTccJ06HFRwy9UXpebGperRrK34s5yb4qdFeA8CvUS+ivrQpOOVn/ZZs6Hr
	 IGMS9Yop9MOuFR7WDDDVfOv55XWSwytTUellHnWi+6M+qN9kv5XCYxEQZb4qFDYSHL
	 UK26pmkhyzEy2zhM3Cw2GEpXrDWj7CzU+87jA1isx5Y1rpH/bRmcTEXY3ULKjdCi53
	 2Z2BEfc09wjIeNNcP07B16oiV2jiq6PwGTiXckmznatOoF1y4/pVf0Gno0iOsQikkA
	 7/NE6rl2M5jhg==
Message-ID: <6ecffc5a-d464-412a-9bd7-c98a5536092d@denx.de>
Date: Sun, 11 Feb 2024 19:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210204606.11944-1-aford173@gmail.com>
 <20240210204606.11944-6-aford173@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240210204606.11944-6-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/10/24 21:46, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the DT nodes for all the peripherals that make up the
> HDMI display pipeline.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Tested-by: Marek Vasut <marex@denx.de>

Thanks !

