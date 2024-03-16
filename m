Return-Path: <linux-kernel+bounces-105137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5287D98E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46223280BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20B168BE;
	Sat, 16 Mar 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SfkpFga/"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CC13FF5;
	Sat, 16 Mar 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581018; cv=none; b=Q93C9ltAZUqMEQI57q+CwcJipCV2pyalP55Fept4SVyMuVeaHoAU57YfhqJmLrPwo4IV+wfPSX4I/C+d3SWjPBlv8HyoYLLnKACneXyRMSaRce70bLpch4eZZgJgv9bOMg8Di7sgGTF7I6pmR4IKQ45jGKUc/XmRjTP5V8hn4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581018; c=relaxed/simple;
	bh=+Ed9m0MQ5qpNY57HNMa1omT9ZjSUBOrtUX5ffZgM4Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbjQou8z+cngQBga7YdCpXV8R99pid/LvzfugXUQIFtS/NtKCdc7FBYbwmFG+MILEn6YlafkhsCZxarCR1+7vPxHdHGk/9hwcHQatlmGNMOBkEYLi29qPhaPw6n1e57oxrpyc7/EPlsmps635HRuyW6g8uB1Ldk49ytFwhl2z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SfkpFga/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A309240004;
	Sat, 16 Mar 2024 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710581014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv3X1pivQQmEQc8jCyjDQOZ9uDlhTMOmx8v4Kc5Zhm8=;
	b=SfkpFga/aSCMm3InCemlprl4fls7jcb9m8//f67v3uzxoZn4miKGEbbBxTOABsZUI45g/b
	yoDo6QMoScWj5Ipb2Th+ZaGGkoisesShpaaevrGxSVTBAehCq+vkNhYBltn8WDsBZPN75S
	cZIGg2J/2mvoA4U02HH1eRroi68tcHOincmjnH9OXbfzMlAX88k1vVwUf9XW1LMHVuY3vb
	HAEV6Lx7eQ21Qgcd9tQFk+h+qqt2R97P1uKcfjYo9mWoyltWJpV5glsNFkFliUJADVTDm+
	cZ5aHLPRHJV73P9Xf+9P5k13xrV2Lo1xFafmVnrf35w2x0VcnUNOrEueK8Kwvg==
Message-ID: <268abd30-d3d2-46e0-a7c8-6f6d763ae304@arinc9.com>
Date: Sat, 16 Mar 2024 12:23:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] mips: dts: ralink: mt7621: reorder pci?_phy
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
 <20240316045442.31469-14-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-14-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes of the PCIe PHY nodes node to match
> what the DTS style guide recommends.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

