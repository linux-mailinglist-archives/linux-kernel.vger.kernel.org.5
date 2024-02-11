Return-Path: <linux-kernel+bounces-60914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E7850AED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E38282F30
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20505D75C;
	Sun, 11 Feb 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="br8ilUVq"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987503DBBB;
	Sun, 11 Feb 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677734; cv=none; b=YC+EeErrY6xnqP4kbRdEF+HSUc2FCi4bCS+W+6nYFiG+ymiCvQ0buAaJMSTkUDEeCGvEFOrY99CFWaSoxohV8PNsB+Os6b8lwslLttPrKdG9Uy1u6vyNZYpfwB+aRGC0eiYqDaK4uYdUusgSYljUxEPVfcyTg0CYo8LJN4xQpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677734; c=relaxed/simple;
	bh=6POhr5QCS1t9bNxSxcIN/2QQX03K8jr9m1DcXfa+Jr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTSEdiGY2Os86pIW2mzryUEpv4Gn3oOqXZaiHUhY5mmvkKVTJt+XwSKGQSuxBnBSgxB9soApGqlZe13mkcWSt5wYzFlornVpLdvntjODnUp+Hv5dql0fO7Hk8TZADvBnAyJ2PFGTIRUeF3VASWHhNoqtRrNxgalCXneQz47AX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=br8ilUVq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A4EC98798F;
	Sun, 11 Feb 2024 19:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707677724;
	bh=/1Fv1WUuurd4RZbD3EvEfTCQraflPLqv02/YWJiBxuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=br8ilUVqmF5UIP7Ky3iDjZm8JmjXe4WK+gh1kzVoXH2xmu7tJq/yhJNGnR5Gk4mLh
	 Z1AfDilHevMlWGjSeAWJ1+fbvaVU86aqTAJ48ZZ8NpYfc6DyZ7zKQOvIvoZcRSiCuV
	 9aItKdBt2hu8jG1PS9e8lzHEp0s0ptV3fsgagYXzYSQhPN19tDL6+XamwD25dNrZjl
	 eQb0ASqxFEuLE0gxp0hs+nH965pfcKFgjyiFi0CGCMMyyJBZqm4BE3JwJOs3nmmHFc
	 T0M2oMwUrK637wZP02MeUm9Rugr8PJmvPvVBm4yhqs3jbI5YFBn88altQT8gvVX7v8
	 Qa2AdJkDzdpFA==
Message-ID: <c7d50bc9-d6fc-4dd6-9db5-e88fcb19a5b9@denx.de>
Date: Sun, 11 Feb 2024 19:51:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/6] arm64: dts: imx8mp: add HDMI power-domains
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
 <20240210204606.11944-4-aford173@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240210204606.11944-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/10/24 21:45, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the PGC and HDMI blk-ctrl nodes providing power control for
> HDMI subsystem peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Marek Vasut <marex@denx.de>

Thanks !

