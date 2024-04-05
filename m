Return-Path: <linux-kernel+bounces-132601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F3B89971A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32ECF28316C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC67142E73;
	Fri,  5 Apr 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="otI2Il1x"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607E13CAA6;
	Fri,  5 Apr 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303766; cv=none; b=e8gFHFOUasp1V5FhjUJxgtb6WoM4t/TAaxKftUFQ5bzXG9DHPYhy19HxoqfIomV12cE62aPDRz8qj5ou9k6YzhDNxpj9+2bPX1QevJbUPqpUbSHDirOs8XgC730JX7CZrT6h9Zr43nfmAFyZ67kJpetxla4X3i0nhnZapc9JhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303766; c=relaxed/simple;
	bh=U9rsSCKUC8gz8UhuXMZOZpgixEY0N/42jL63zZvlBFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWoPbkjU51nOIb6fHejh8EZj2HYUpXFkFgtGKItcj1K992mHrAK4+JL948tH93GAf1JFOuiumihNVfYPWY6ZMhbR/OGDnU97Ii+iOW3aGvBTNZSYlFl3YJ14B05pB3Ziw1UBXWZzdHj+E+1LIOu4WifDMIWcXKf4akfLPd/vz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=otI2Il1x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712303760;
	bh=U9rsSCKUC8gz8UhuXMZOZpgixEY0N/42jL63zZvlBFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otI2Il1xKBK5K6CsaVm+OjgcJetPiMo0TCuhgrusOEd0CGHzwt4g7SsvLjEzh3V34
	 2lRa38NX50t1f8lNldeauIalI4ESg8RGceQA0TzFWV/6bEmOLIDLUwJK6ZsXftxOfG
	 HGBWB00m2oqeJvdM5RyPCLoFo/Wt31ZgFUcmXvkH9QvVTB/oMiZo1K4+V0bYhbevXv
	 KAMxaBnMsVBG8pW/8Gu/EqAxNIHAPpWhK3YaK6PCGnTqsBw6tHDG1fDcUz7GUgl5al
	 lFy3F2AzBF/i+dFTpOVUZfuRsW/tgzEN7wzYjA+/toHuYeo4p0Vl+1shuTQ5FtV7Fv
	 0MJOHeunxPNbw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E72B378212D;
	Fri,  5 Apr 2024 07:55:59 +0000 (UTC)
Message-ID: <ddff4cb1-5529-4293-97f4-97afb7db48b8@collabora.com>
Date: Fri, 5 Apr 2024 09:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add compatible for MT7988
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Golle <daniel@makrotopia.org>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213130044.1976-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240213130044.1976-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 14:00, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 SoC contains two on-SoC XHCI controllers. Add proper binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



