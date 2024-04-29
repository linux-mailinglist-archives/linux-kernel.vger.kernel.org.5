Return-Path: <linux-kernel+bounces-161895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A48B52D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C228112F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A6168DC;
	Mon, 29 Apr 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hSrk45FH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6815E88;
	Mon, 29 Apr 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378242; cv=none; b=S2aXd1wfOOhKyhe0Kmobq6IIobPLkiSC1Keee/YDrY3zIoLFUwgbJor34sgG2KtN/rru+2jvr4J/Sd9hp0W995AXMqWVharmr/6ELNIXzXDvJtpNh3fxK7B21GBejvJM2sMI+BYZGR2zQPB8IKfwJ9ASqV56pj6siTjEs04Ry8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378242; c=relaxed/simple;
	bh=GSA7VNiSy9Y8LaNBcTBgfNorGDuUnpcHLRqx3xohZXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIBdwj8qD377LweeFa3QWjVxcWtlDXg9v779NktTcqGY4Evqmz10yGQTxA7GAczUcM16lL2g/YqAZVq0gy1/sUHoVUGK6NouVkG6qsaVYga/j5PoOc5MVxprW6Gdo2DwGT2PsSMRHMSxmwc/nE+azgWTpauezqxC82GxIjM8zaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hSrk45FH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714378238;
	bh=GSA7VNiSy9Y8LaNBcTBgfNorGDuUnpcHLRqx3xohZXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hSrk45FHZwVMl/H1e+7/9Ww+vW5aa9nMp6fCnYzFGR70P7UOOG1hgrUTRyh/hfMn+
	 Jrti+tJeho/e8J3CPtX7xoW3aZ3e2lGvuqmd8ba/9pvmIbOFXw36zzJ74oBZSR3wyU
	 mILRIonO7tCmC4lBPzC6VYKLTYInNB6iJ/tiUyKqw5/jSX7Uq3WPQxzPSrTL469kK6
	 ys/pefgAFLN4MkkzWDg5MhI12DdT3v1li8Mnkr5L3WP14uNXO8Q9AFAgPDvoNZL0pe
	 Ic9WuSv3Hv3TLIDcR4Ky2iqAiAs2P/RYzugZu+ZMM4gyZJ4r+AqoZjojQ8NACSZJ0C
	 kBfNlUy659vQQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 199CC378134F;
	Mon, 29 Apr 2024 08:10:38 +0000 (UTC)
Message-ID: <a6adaddd-733a-4cfb-ac73-1648f54babb9@collabora.com>
Date: Mon, 29 Apr 2024 10:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Drop unnecessary quotes
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240426195404.2771046-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240426195404.2771046-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/04/24 21:54, Rob Herring (Arm) ha scritto:
> Drop unnecessary quotes which aren't needed in yaml. This is checked by
> yamllint, but this case was excluded due to the comma and yamllint's
> mishandling of some cases with commas. That's now fixed in yamllint
> 1.34.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



