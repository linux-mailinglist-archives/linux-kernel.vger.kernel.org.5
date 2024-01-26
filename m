Return-Path: <linux-kernel+bounces-40563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A4A83E27C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95B41C22DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58897225AF;
	Fri, 26 Jan 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xXcRyGxD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88722224F9;
	Fri, 26 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297273; cv=none; b=B0vpQXYIR/HQg3s7sza+v/doVS4E0HN84ga3XuiZoezXW+WOby/bVYvpCuKFtPSyCo0GS74fIMKIEV5M60Oz/eV0TWog9JTeNbL7P8gQ5rOk4sa4etlvWkbroMya+AkCnjlI+5SnNXw+ELNSljxllnqhKjGjg3xBTWurPdJjmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297273; c=relaxed/simple;
	bh=NW9/Y1sMfKulS8DYavETlMP6KBNa2HphYFT4fmqYhiQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tjoqJySl7IQ8+g4R7bULuLG2OLlKg+5v8lKPVYWrirVEuEsY2K2g1XZUUjXnquPmtwq7RSOuo43Rjzq2hAlVW/4yrngZ6jvrWUVO/VY+CbHSdrzIChmp84RyFNVILJmPjuGL/0WjfyjEcw7NtUWgGlQ0RZLXexEM6w+CfVn7zN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xXcRyGxD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706297269;
	bh=NW9/Y1sMfKulS8DYavETlMP6KBNa2HphYFT4fmqYhiQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=xXcRyGxDv0Xqsfg6pHpA2QSKTxLhBF71dFtSwBxKkRD8WdBl+q42Mf+z8zNhPnrkX
	 xdkwzX62vOt84LBzrWfOeuzAhL7S9sseI8UAQgkpEK4KLkBrSgD944tYNZ4RkWuh/c
	 Y7VDLOVx+50q7qhGZ5jmgnKrO0/L5htnhq+3umjBlAZ70LYGpEebSnXGhQqsVRa23B
	 FmjXach9aOc1ngY4CPsVGyHYZ5Gczki6wZaTL48GzWbbSJBEXCB5fUGE5pzTWuci1p
	 L1EDNz+kWeoFwe5z3ft24OjFNxWe9+guyNdJuA7Rk/QJsKySv+Xnt9rljpcL7XWq5S
	 2UD7pnP/iZjHw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E22ED3780022;
	Fri, 26 Jan 2024 19:27:47 +0000 (UTC)
Message-ID: <920e764c-4fa3-4298-bb49-d31416fc3dd6@collabora.com>
Date: Fri, 26 Jan 2024 21:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] StarFive DWMAC support for JH7100
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please ignore this and use the RESEND version [1], as the binding patch 
was not correctly updated with the latest tags.

Sorry for the noise,
Cristian

[1] https://lore.kernel.org/lkml/20240126192128.1210579-1-cristian.ciocaltea@collabora.com/

On 1/26/24 21:13, Cristian Ciocaltea wrote:
> This is just a subset of the initial patch series [1] adding networking
> support for StarFive JH7100 SoC.
> 
> [1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/
> 
> Changes in v4:
>  - Rebased series onto next-20240125
>  - Added R-b tag from Rob in PATCH 1
>  - v3:
>    https://lore.kernel.org/lkml/20231222101001.2541758-1-cristian.ciocaltea@collabora.com/

