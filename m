Return-Path: <linux-kernel+bounces-105125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C287D968
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EEA1F21669
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D0125BA;
	Sat, 16 Mar 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="DnBrpbD4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17456AA1;
	Sat, 16 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580844; cv=none; b=dA4cpx+DFmTL4/PuZgWWiJDLLhcf4kzl0IJRWgrqDMe2fa7GEIkHgvaGVwO4F3GvuBV95625wd+xzq96uJnb4beJAoBNGyE5F9o0gkJiPjPGxh2lXS/dligj7vnaHvtTsb96/rIZiMuO6EJagSDHo9rfx6VCPqMDkkLzI6uFId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580844; c=relaxed/simple;
	bh=ST98Mhz1DlDnjzofsIuQLnDH8pxs3yPtBgzLPJzYcNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIdKiAWe/3IrBs8m6by6lM2VvphrIfyxa92BfQrXjifz/4qUQH8IUmrN8mByVxm37BdJrub2YP2pwJ5KCyAlwnYx9hokPU3GcF3twEvSvkrv7PzHGY5MMWh5ZVbrAVMaYH0Ziz9bD3Tsd3tbx8QxRwavjx8GhN0xOfQyQQEFO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=DnBrpbD4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4807B20005;
	Sat, 16 Mar 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBPA4EVa/HJzRpygIlTKSRICJil351AjIuBMiSIsloY=;
	b=DnBrpbD4qlmsmkkcGjPzBuPKmsmsS5vgoaOP1pUvkdYBqlpqTnHiodEQrsxfR9l3adwelP
	xsFr8QLuB89V1Zk2/Mv0kuN4Q1N7+VImT50/iolPSrHW/nFtmhUrhf4LGawl91+fZTIrcl
	e/058UILPk73WCcikKgtCbA65UwmGyMNaKFCyBMG6E8TD6KFpMIGwsGNrD7e2UoU0SElh5
	yXd+rStnTVXJgFVW+Wor5CviJX4APqfr9kcbtIvK05Tq6pKA3njhLMzgtLUC/92yO/bQwL
	WBosVquxmmwBx7TIEQbRgAQ9blm2vCwKaDJzykXoWFJjZD77ZRgJRg04EhMjKQ==
Message-ID: <b30700dd-25d3-4815-8a3d-dd78810fdaa4@arinc9.com>
Date: Sat, 16 Mar 2024 12:20:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] mips: dts: ralink: mt7621: reorder cpu node
 attributes
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-2-justin.swartz@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-2-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder cpu node attributes to fit the DTS Coding Style.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

