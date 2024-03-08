Return-Path: <linux-kernel+bounces-97285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C9876842
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF761C21326
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E03FBAD;
	Fri,  8 Mar 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SeJ+Jjd0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743592C862;
	Fri,  8 Mar 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914791; cv=none; b=YrXZPaHgleaYH+z3V8B/1iFtDS8ss6T/d4Ru44QD6504oCrxKI+fSidEsbz+o4THgKk03BNtO/SpfuQ6PXlNFtE7d3Gvb4eSWmKr4fGM1zY4+FieJm19lA5Rrz0ZRG7c0b93tUp11CQ1UF+YmlkEfzg6SFhhF/aGdAKHLCNvx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914791; c=relaxed/simple;
	bh=kR3fOpVm0Wu1r/QtePkS/CtzsAxdrcTI6dF9WfYd7QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgjlCtG2ux2hQKo3yY4BgBg+M+G0B+mqRhYl8HFDgRZ8BgaLA5mPNd8TI38PIaLiTHnYOoqnHSoRrIaS1/D8Rd9rwQq3Al8YPWNAlUF121eYZGBmsvDzMmkBr1AYSnkzs0TUdqtWVHrW4OZNnYMCuzlmAHOyzcXKf4Bb3zH6WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SeJ+Jjd0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E5C6E0005;
	Fri,  8 Mar 2024 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709914782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEi4vkq4/ZbcRnurVhVV+qrtb49Z3GiZi5T9t3PQDgU=;
	b=SeJ+Jjd04YicsVMPPsq3yMAae+MZmdCgBaC88fTaJGH4yCwwvKSIwONCbdy4RZx9RS4X8j
	i1iGTnnDqvB6JR7x9I0kAN0XgK8ELIF1xGLOvPKujDDqSTP0AH/2q1cYUuO3WqeTNROLII
	ieZ+k9ses3PiMEMcuOWTvXwwwoB74B6fDkFR5d+Pe2Ln8ULLmP796ZQFXsBvsSaViBLOg/
	J/J830YF0onRfWo2y9OXd2LjqoAYxruDKQZ79nsiK5Ws2htDp/TQWVlXdYzKHAQZn9CFu4
	tkY/UUReoLZhOyfoILsZHbZ0PfwaXAZhO8OBkcthZKDtN5nJ6VBkYM+4rDKIOA==
Message-ID: <88c2035f-bddf-4dad-8aa4-1d8f02631af0@arinc9.com>
Date: Fri, 8 Mar 2024 19:19:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mips: dts: ralink: mt7621: add serial1 and serial2
 nodes
Content-Language: en-GB
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
References: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
 <20240308155616.11742-4-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240308155616.11742-4-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 08/03/2024 18:56, Justin Swartz wrote:
> Add serial1 and serial2 nodes to define the existence of
> the MT7621's second and third UARTs.
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

