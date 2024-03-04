Return-Path: <linux-kernel+bounces-90414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2D86FED3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0CC28312D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46023CF75;
	Mon,  4 Mar 2024 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fb11IaKc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA4241E5;
	Mon,  4 Mar 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547436; cv=none; b=TBzlZraY1SI2XsCYBcpchtbPVgCjnG6N3fGAcaQOG7dXizrroS2Kf+9XnisQJnNH+qnylo8v6jfVqvsfyqpgUgudzCl8rPAG5PgFCeF7FrnP0qVIloYMAioE22f8SmHcj8cG9trD6W9liZ45ybMlbmlw1JEZjNw2FFotvzXB5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547436; c=relaxed/simple;
	bh=ltcyOw+TgqviIKZ8PQUG8CPcAe7I74uGtSNAStThC1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJOpuJ4Kb7F501R/AL3cTwe/+2P2gzOhLay28fshaUIk+kUrT3oliZTQpss/sHa2QLq8fMpZnbPSyYGhGcht/E1JbxFm797QHUyWzOMLjFvlCfV727IJ5Otr3tMNDn06rpSktSkF0ZoHS6XEzN70MlWeT8nlwfpLcBuaqLx4c4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fb11IaKc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547432;
	bh=ltcyOw+TgqviIKZ8PQUG8CPcAe7I74uGtSNAStThC1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fb11IaKccd0sn7CyPKu2BXQKbFW2upyD39noI5TM03TJBBiM5ye+aWnCUUD2VbkIq
	 2TnHjnBrpEVsp4dAD81Wujg/2j3bYBUPN+PI1ui+pqh3XqbQ9AS1HyWi5D+Tm0y9Tl
	 NXav/eWcHeq9xhcHxEkGYzaSJGHAt9AJ4EHlVVVOCSkNGkqR4NwznUGaNk+vUJaiDE
	 IvaQKjCwcb0EBo5VHb7oK2HPqb7UUoSsCo+BnT+j04XQmITA8I8pylgLfe7w4TJCjv
	 GVclBtl4+0/QhrYVEDW+AR1QYgVcXe+cPtL2ufpRyVs+46CSb+DPwSEyEoDusH73BK
	 xCWmU2AHLwU7Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D33AE3781FE9;
	Mon,  4 Mar 2024 10:17:11 +0000 (UTC)
Message-ID: <fcb78476-d1e4-4354-99a6-0bb92a2ec3b6@collabora.com>
Date: Mon, 4 Mar 2024 11:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: connac: check for null before dereferencing
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240301144406.2808307-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301144406.2808307-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 15:44, Muhammad Usama Anjum ha scritto:
> The wcid can be NULL. It should be checked for validity before
> dereferencing it to avoid crash.
> 
> Fixes: 098428c400ff ("wifi: mt76: connac: set correct muar_idx for mt799x chipsets")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



