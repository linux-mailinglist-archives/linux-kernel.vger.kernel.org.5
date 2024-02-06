Return-Path: <linux-kernel+bounces-54601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FB84B166
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFFD1C21B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1741292CF;
	Tue,  6 Feb 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aSOH7z1V"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00415745D6;
	Tue,  6 Feb 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212175; cv=none; b=gqmOa8ya1OqGRk3qXf21ikxFcKktUkUuhPi3NLMzWxH0IFYMzsKPFzpk1OtSpo0F4GHX3a57O5ANlrv51xS5yQ6DCiuXj5qV3SiZOduno9tEpgfgq9+sNNv9KI4rbq4oxH/C1ctMnhnfY6wn/RXezPnx3yFvS4BtB9cajZ5uqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212175; c=relaxed/simple;
	bh=luROSI1t+DKF5ceyQuKSrABuZSi136QYuZumnfZGPPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1SOTWfhk4QH0pstAtCwz6w9QMafzxYsNCwbGPl7Hi8tIZAGnpdbTBU1e2jFb/xh2MLn9LJcXuPZemQb9HV0mxKMg51FrmCDiEyCeRVYT9iOIS1ixqmTKOc5v0i+Rc96sGdENwC9g2rreQ8OHl8uVLNMwuMTOseiVTL5Bo/mp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aSOH7z1V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707212172;
	bh=luROSI1t+DKF5ceyQuKSrABuZSi136QYuZumnfZGPPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aSOH7z1VxB4VvzEWSRLptEW7UztO288D3llYuxrHh2Thlop7wogU/Pu/VjRIXOHPM
	 Wxl1BTS6XbGFlNW4EJYD9MzCDn8xtLo1udQlMQOKamuXHkp+HU2IDgoKh83YTMdzRg
	 d0DcfOyesV/75xidwWm0mqt76H5oUKrseaTK7eShCQ24pyq/rP5vKS5KwW0AGtGnXl
	 j9oTT3oS0WE5CpemoNfmQwGpv6pADXLx40vjN0spOmUWVKkGtw+NF0Z8ijD32KAKyU
	 ZzXMoetCRkDBpUkgQHofJYxKJesC9wknBtNKy4KNNf/fNrveCcHCIAhHoE87Ar8TzY
	 2Iup6OK0jRrnQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4506E3782051;
	Tue,  6 Feb 2024 09:36:11 +0000 (UTC)
Message-ID: <bf4b8c00-cb21-4eae-9bf2-7941dcfae437@collabora.com>
Date: Tue, 6 Feb 2024 10:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] power: reset: syscon-poweroff: Move device data
 into a struct
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240205194437.180802-1-afd@ti.com>
 <20240205194437.180802-19-afd@ti.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240205194437.180802-19-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/02/24 20:44, Andrew Davis ha scritto:
> Currently all these device data elements are top level global variables.
> Move these into a struct. This will be used in the next patch when
> the global variable usage is removed. Doing this in two steps makes
> the patches easier to read.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


