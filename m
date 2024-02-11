Return-Path: <linux-kernel+bounces-60915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961A850AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0152830F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385965EE61;
	Sun, 11 Feb 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pZUGhqZp"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CA5D73E;
	Sun, 11 Feb 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677735; cv=none; b=edpM2nYJqEaSNP2r+7Q9351SXGelmbNSD+kWmcarTD3enJs0+bmgsJ9wYs+OnB3iso2F6KUqy8PP/dhceiMPsJ6FiI0nya58cvOb0YpxhUVG+3L9laHoI8OgjatmZ9hQILfCz99mpLbT0hR9juxSWRI/7N4gvkZ6QxKJb5Biuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677735; c=relaxed/simple;
	bh=hCS5SttW2PqeC3D5GyC/Be+poxBFjOJkbv5x3b8kwZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E96x1wk2ndGICisImZzQ73Msol4N1RyqbWjHAEfE2SMTjRXxM6V0UGtJJ5Fay08ozJtNYaYvl/aTGi4dW9FkzPx7wp2dRaVbJE9OE+PabvsvxWwtWPP7wVHlOkXkRUTuEN50XlcNPy0xorlXgfZje1WOKaUHu3eXYmiQDXh75+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=pZUGhqZp; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 17C5B87BCB;
	Sun, 11 Feb 2024 19:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707677726;
	bh=/N5fydO1BhWvU1R63Z0dW7DrKw+GkQnAGnQpZ7FBXPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pZUGhqZp0gb8osEz4ZaulUzfhER0c8v+XU1pTloHA2jAMcTHAtZ8hPtcvlFL3otF1
	 sP9gRuhcKhhz3aBVrgY6KSpgoARSLcKzOXwgOCMsGKlW9rdR1QqEIUbXK+h3vHJWd1
	 5YfN7L5CAl8E0tunZ8cvW9NLwIBD7jsKHWftq4Av/O61nD879WHVNNBJVUFywG5AZQ
	 WYlzFenpEcMt5mdnjzRZZnjHDc8s3My1Cn8PUKGDZvy6gSFFXBW7rqkOQqM7YjQEvZ
	 jZe94Ac6JUtpFe23ZfgSdrmBmEkrvvzvuAGCO1o8BXYZNDYIWd/3HmntI2jLznjGlu
	 77gAABU1rlVaQ==
Message-ID: <0128bac7-eac3-4b80-a888-90e6596320cc@denx.de>
Date: Sun, 11 Feb 2024 19:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/6] arm64: dts: imx8mp: add HDMI irqsteer
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
 <20240210204606.11944-5-aford173@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240210204606.11944-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/10/24 21:46, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The HDMI irqsteer is a secondary interrupt controller within the HDMI
> subsystem that maps all HDMI peripheral IRQs into a single upstream
> IRQ line.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Tested-by: Marek Vasut <marex@denx.de>

Thanks !

