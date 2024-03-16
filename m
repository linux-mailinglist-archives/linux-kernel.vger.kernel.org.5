Return-Path: <linux-kernel+bounces-105131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711387D97C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB41BB21547
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8B134B6;
	Sat, 16 Mar 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="eqqKdJCt"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C217BA6;
	Sat, 16 Mar 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580942; cv=none; b=WP98bGf3A95grrD18eBgUeSQYVpeDJTyhdpROKIf53SeBQ65gyGIhisF/WaxpJNEazNwXOhRg6maCBgQHX4rWos8nrH+a7l/NZY4JT/9S2PCUKIHRV1qbIK0jZ2rG5HjSuSLi+ghQQA2gnHeXjjlnyU3wcwa28If/R1Yw9wkbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580942; c=relaxed/simple;
	bh=EeyAxheYqNgmFELG8gWsbbUUH7PE0dQxM5km/cGFUBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRPWiuYHXW/x/dT02vsRx2GCSujP1c61Za4In5J7fUqsBA9UiPbbrqbTiywZvfGheS/qygE3+NDcKictEoI4fSmmArOCz8rut+hajL6FuRDnG6pmqblE3OytZOwfR80OvwHyoeo1f9godRh0h8FZCXP7t0ZYRLx28lse6TUFmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=eqqKdJCt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C1C720008;
	Sat, 16 Mar 2024 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/L/trZ1rIq6HALl4PkUwc0f8DkBKoOI9oc6gkVP10A=;
	b=eqqKdJCtrYlo3sVATDw1hXbAIBwIXZfwznpwNi8aCph53wMTY6NUxdbcaxzCBCN25Wecgk
	5Akd2iJYCAEuRfy5LDXQS8pJ1fdo1v9gsIyQXYkJYigBcJH62D5W4xiL+7CZggmDT64iMh
	16y6H/ESSO+nyvBbXgnwEK/xPJNDt+gp0uiUCTL6P5YB9XKa/quB1csraE8CoeRHq0Yu65
	FhctLGFphfH77svldpZvQ85CAlqbE1/3m26FJWM9JAeVj+pUjpipnCvSYTDFGjMvmMGfrg
	pjwvXpVKJ3JOG8fMqly1UAs8wth7njs+NNmNyDuWyJPOLmhOwxP8hBE4Wh1hTQ==
Message-ID: <44ac9459-e19e-4a2a-87a8-f0ac5209e1b9@arinc9.com>
Date: Sat, 16 Mar 2024 12:22:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] mips: dts: ralink: mt7621: reorder spi0 node
 attributes
Content-Language: en-US
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
 <20240316045442.31469-8-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-8-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes of the SPI controller node so that
> they're aligned with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

