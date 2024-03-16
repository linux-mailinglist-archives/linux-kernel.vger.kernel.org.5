Return-Path: <linux-kernel+bounces-105133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF187D982
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65B8281ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BAC14006;
	Sat, 16 Mar 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Ay7AQUhT"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B3134B6;
	Sat, 16 Mar 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580975; cv=none; b=IKPWWQnWdq31OfkTV8ndi2oAIuyvnI8GcpulQDKm0e8IjIzPBYiWmsEWcxN019qB4Ung2XnEz9R43YJWjSTA0BEsZNlYDuF/M0409uRL6cgYbYiHxklCeL5pZ0d75vi2rLq7YJ57uRTFyEmJ0F3bJ04AG1M4WsnJE4aSHUx9qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580975; c=relaxed/simple;
	bh=laGmhADcr+tapbKIR5I1Q6WQW6ns9Nn0WkqfN/KJXPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI5KDSgNU1pijP11X4FakdyMxpBjygnz1u+yOF42tSabiNmgDpTMUCZboSMivlS7L6OknmvVfvN3QIHvmHwkV0T3X7kL5P/9eKKNQ6qNJLytCY4ZGkVPNZKr+wazuYBc5OqjgFzud1RG2+P58VCZIsLV8Rk9YK0FqFmiR6sxNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Ay7AQUhT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91390240005;
	Sat, 16 Mar 2024 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcMIm27QOoVv2JlfVOePM6RaPAoVbu8M3ggV/C6vyxA=;
	b=Ay7AQUhTpRiXSQsyeHMwMdnG7HK5moMK1RiXDNA7NUdhES91qTAy9jrB2tK8fYHtF9pt35
	oC0Fil3ZejFQTLYz1CMu2iDgcJD5mjHGnI9hEiQEXrNmpXEID1b4dJ/7mqufhCaGypuzEL
	chBnkU0+AbBmaSOu8MGkm3ayYpf7mx1eYwruqrCNWwIbd/nk8F0O4PXzG+EHqeUkf6K3ig
	uqsi3KPZolnGBBaA6HtlHbPpGSE5/CBqWOIXclYG6kdxbAXQabjbLU8qSdZvSkdeL8ZZOR
	sNQGYFl+ifiHAuyQ42nT6qGhK0AnlcIGS1ImHKrGoW7ThDBWhe5jYNlVYk6YXA==
Message-ID: <75527305-d158-46e2-a51c-1f122acce183@arinc9.com>
Date: Sat, 16 Mar 2024 12:22:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] mips: dts: ralink: mt7621: reorder mmc node
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
 <20240316045442.31469-10-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-10-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Shuffle the attributes of the MMC node to meet the guidelines
> provided by the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

