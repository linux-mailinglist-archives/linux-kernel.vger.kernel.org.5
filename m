Return-Path: <linux-kernel+bounces-105138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF087D991
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15851C211BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE2179B2;
	Sat, 16 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="LK+pFDDh"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777713FF5;
	Sat, 16 Mar 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581028; cv=none; b=jG8yVpRjcbIcu+diT/5VMSrLiPyfnB97ziSv3enKw5q9SP8ru2qryxVdDzU/6mrcVJSA7BVzd7c3j1RZf60xErvG3jnoPpUXDG6yHxIson6TL7rMqx4hfcP68ZngYNZBEbjbd31dxheX8KncbidytMgeAElww75MCT/Fn+Z6XxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581028; c=relaxed/simple;
	bh=/QmT9wtjefLeTaguQ3nQHqmfXwt4bYHuxmn58Sdumi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StJYsWitxZpjNeBycteU39RDubY3fz/NAII26eU5oJ0c6KQOCinZKtVn2Lo0856lW0kxZthHwvT03daWyTdDb2v/68M8cS7XAMXphjx2ubmYuzfUO2UizGaJvoUDYj3xdHlzhNDAmHSOC1F1K7N6d6v+srOZWbAfa4f654OcL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=LK+pFDDh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87E28240006;
	Sat, 16 Mar 2024 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710581025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVypSm5WOYQnRTTJtNXMYtpKc/D1ytiRhewAQtyGd5M=;
	b=LK+pFDDhvH2o+mZc58S2LIvqxpyWDt24PIfP4v0R1NWV9PSM8K7PvNwpYVgAMptWTzlYLN
	xLGFa7g3GGP3caRtaSeWYF1dJxwVTLvIAmSwh9XT0eeuJKGL3bPjCv5hJt5tEBwVqNFk1N
	0JbVcVnaWkiIUPpuuLuiQv/wmxpcRdLBrf6xZWQJVsw1HZy17cdZsZ0qGwb5SzsH69vMz7
	y0/Hn6ck1gD+L+bY2kWt1BoO7mZkvoHPRv97hnyRwc4Dg1ZJRR2HrD0lLidQVP21xjQ1Oi
	63Y6YmHE6bDGHXDQauqbeqPk7LUdFUqvOPg9PwPqgyqCbkaDhIvPI6Pk8cq6IQ==
Message-ID: <36c59748-74d8-4125-9556-d909d884b225@arinc9.com>
Date: Sat, 16 Mar 2024 12:23:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] mips: dts: ralink: mt7621: reorder the attributes
 of the root node
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
 <20240316045442.31469-15-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-15-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Move the compatible attribute of the DTS root node to first place.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

