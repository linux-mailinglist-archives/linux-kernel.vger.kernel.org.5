Return-Path: <linux-kernel+bounces-105132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D843087D97F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CDDB21509
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994D134C4;
	Sat, 16 Mar 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="TOJSetxS"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F211CAF;
	Sat, 16 Mar 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580955; cv=none; b=K51FtTWe6rJpeBH+1V9xU0d8e5CN7ICyCCxHK3Oy27GWptUJOopHPdkW7vUP0kj6mxa3kW9JMjZJzjKby9jH158C0CLQT50YtqaZKewTp1YJFLZEsxdpt2yXctuwp3nUvmxhQULwXSvK/IWWSlsaUcq3+iK4dbtYDbmyMlPcXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580955; c=relaxed/simple;
	bh=Jgl2HGUpzufH7d2CWEQ8KPxy0drVqk9iRBfAwpGiNgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8Z2a+MWEi8bYl4ZquiD9MrPvgGcY7zMtfvMMu7brDaAwn1d7t8qSkPuoGT4d8ibfLEuH2plolzD2aThMrhOEZ3A5oYwvG3a0G4xqJg03PhROCSnGPR4LlkJ9P8jJd7vFp3AsQkh9aB3SggamvUbjGX8yKEAjaSlYX76U1FGQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=TOJSetxS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79D7720003;
	Sat, 16 Mar 2024 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaPc7n4hfgNrI9j78DPYDOh1dbNuzEEoPXl/wR9kJtY=;
	b=TOJSetxS7n1FQgLixlQdx2MGkuaTr2y1nt/E0sii2LJeR/ToGWQnfZlqNYS27AnKb8fb4C
	HCuOMV1uxUCWcB9qcNhlyboUMb5RJA7uKnK0NHCnrXvYkt5clpz/FokmwAnPdwMOk8Q38I
	V4vrwN9Ii3cVcwBs7PHFnxcWYGSy+WdpSdiUzOdq+3YjlwXzw4z0Z3PUDFvMupeO0oJq/h
	oLPrbKkHJTQMuFyjGrXVnLD27GK/jHmvkTAWTsFDWnly89KUBzChuVDRwO4FaA50nCtVgd
	L4FeLnfLpS5u2cw8TaHJ0Wdgi35MFr3mVMQc3Y4X4VcjJqYkPiPu6NPVRYcVJw==
Message-ID: <b02f1d1f-6a40-46b9-848e-35a9c758c8b9@arinc9.com>
Date: Sat, 16 Mar 2024 12:22:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] mips: dts: ralink: mt7621: move pinctrl and sort
 its children
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
 <20240316045442.31469-9-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-9-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Move the pinctrl node prior to the nodes that feature unit
> addresses.
> 
> Sort pinctrl's child nodes into alphabetical order.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

