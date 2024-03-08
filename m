Return-Path: <linux-kernel+bounces-97283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268387683D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A9A1C21DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504942D058;
	Fri,  8 Mar 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dl/SRWri"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B517745;
	Fri,  8 Mar 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914696; cv=none; b=o85wnzUQW4J1tPyf2uRbBST7oVTEH8Z/aItGBqBjTHzoCmEVeFB5S6BDMiWC5MD3BR0o3UIVBNnDW4X36OktIuYMD1FA190ONDstG37z1HZ1lCDnwOTjcMxxdjZ1RCKB9EqrVC32AQemtmnpQg9bVPKfo4Xb+YuVh7tSZhK7waQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914696; c=relaxed/simple;
	bh=+5j6dBCMMraYYQcFTDRpMYe5DxL2zEk3x6zrkGGMBUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEUIh2iuZSkHzUSu8WCFATOvbOGnSLTL/oMyrEE8KgFKppyOu4dE3+/S7oxTDq0PLCZkDAu/m7WwQGEMmmYZu5UoyZUrHTF2bP362yBqBkN6Pc5IArpmrbogSB0rtTZF6jGQWH/cHcQCQz/XqWHxe2uZkolTrRKnvnb2G4leenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dl/SRWri; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43189FF807;
	Fri,  8 Mar 2024 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709914691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0S6dSKiB8zFSBf1O2VOcQH4KdQm9Wkws/HG1/AEyaY8=;
	b=dl/SRWriu4aZz/xXON+51qcKE3Wa9xX44fyBVTqwjx62WLp2cPcwmcB4rol6BG9SDlZCgu
	qb5/tY0+A100U8vav/gMSdEYGamy5nYAZq66AiSAj9iZfH/uMBvjTTF75H/YVGOfupO2rF
	iT6ITCb4MA6mGilxDFIiM74BCTaz4aUE5rKWQ5/5LAV0yfIvQuLlt3orv6ptTlKtnffZOm
	nayMa5MdBxBTLMpEIzB9MwlFgE8eCPaCrBMuC/2mJBaR+yk346cuP5S/u5pMvi/6534opV
	PcR92F3GD/hg5OA3MLlRduW9Oi11a8kLJStD5Fcu2fIQevrAg7uy4aA+Rv7pZQ==
Message-ID: <1a76dc7d-d0d2-4f11-8408-f60d7fd8b6d6@arinc9.com>
Date: Fri, 8 Mar 2024 19:18:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mips: dts: ralink: mt7621: reorder serial0
 properties
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
 <20240308155616.11742-3-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240308155616.11742-3-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 08/03/2024 18:56, Justin Swartz wrote:
> Reorder serial0 properties according to the guidelines laid
> out in Documentation/devicetree/bindings/dts-coding-style.rst
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

