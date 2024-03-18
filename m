Return-Path: <linux-kernel+bounces-105984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F187E71C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D45A1F22107
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4F374C6;
	Mon, 18 Mar 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CX9y+yxD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2F3613C;
	Mon, 18 Mar 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757221; cv=none; b=ShynHFKh1Qwa27Ezz63mfSGIszgR1xT/0FoRfatS0Su3GHncGr++ghA5CHuK5+9IBFjz+RZk+0BXkUUI06bebzw8UA5Fa/8fTjrPm8b2J7ufeItlg5+m63D+4rybI3BxDbfHA5X9+OdZJJHxVprNvZcpHvxkW5EgbcJoRfv7Pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757221; c=relaxed/simple;
	bh=8Xw6moakbo9EA/7rPM6NZSwkws8780u6vH4gEDzGTZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZhYPFewqAGDBrWa/snrGorqKiM2LR7rE2eIQsfK+4ypb92jAK9qBx/iY50fy20Qj56EcDDKnvWZw70TftdN5xvpm7r4+87abcMbcfpIBMfyalfncXTpH777+8FVlYm4Hk2KfaRmA+q3J5pJQH12WtojCmMZr0f4IduIKS3kQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CX9y+yxD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757218;
	bh=8Xw6moakbo9EA/7rPM6NZSwkws8780u6vH4gEDzGTZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CX9y+yxDZ761CLddzxlBlBCvIsXgVSAo+z0ZTyyvMq/yiCv8xPQXoXKvfkbIFwUWG
	 Ir0kITFTf/9xSL8xI4Y6nDLojV07A/6zmuJf6XFEk0MGB/Q0wf6zDDjgi3kgt7weFv
	 E8YAvCT1PX4W3tjgLADHrffJADFQFf8fMrrLp3x5p9qmFMNyLyam0d385ul4H20gIJ
	 FPxB4hbdpDwnXg/wzG7cYPUD3qIjL4BPsoG5938wOy7pj2mmqDPM1u/4hS2xxCunt2
	 lEtYLj7DtwTD4d7Zt68KfS9jE7SfgrIcCVsetxkuJoUEOFWk/OT+Aqm3dSAhUKjmoF
	 4ptpJ0kGGWGeg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12D933782087;
	Mon, 18 Mar 2024 10:20:18 +0000 (UTC)
Message-ID: <858c09f0-60a8-46e6-90c3-6e20494faf4e@collabora.com>
Date: Mon, 18 Mar 2024 11:20:17 +0100
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
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-10-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-10-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Shuffle the attributes of the MMC node to meet the guidelines
> provided by the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



