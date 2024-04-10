Return-Path: <linux-kernel+bounces-138279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EB89EF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A372D1C21488
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FA155733;
	Wed, 10 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IxlPIgoC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E775158D95
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742590; cv=none; b=l0O/yCryaFMiCVeCdAKzuxQzky6KDstXX61FA1BaLEZWEmhAMc+eJJ2qu1i/VNsxKQBZM0ihX2SSB01WhUUTI3e4tGis4qkOVyTcb2WMFewTbaFU1Q4/wHD54oyy+ujxBFni0z9xC/Nt/Oq3xap49auY2RhoIrqkNp553hnDrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742590; c=relaxed/simple;
	bh=6VlEmFeCzeMqMlidOOqawofjJtPNiIYfWbo5jJ4khEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GWCGRxzbxAO1nMFO4cnJoRsFVgzrANZynfrTye0amAtvfDxAT6++5oNmPVObKrMxQbDRyU5CM5CFJzec4SihfGveOxkC0F/c0Qns4A2o3weNAhb/dENKveRgdee5o6MKeamU3D+qqu5exna6fKVH1sI/3+5xRWCkqS8X4Uf6oSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IxlPIgoC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712742012;
	bh=6VlEmFeCzeMqMlidOOqawofjJtPNiIYfWbo5jJ4khEU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IxlPIgoC/HSFkYXu3u6msNCLCwyYZXqBy83qPPE6KGVaqnLZTahUnipe9wTpeLklh
	 sSoi0FhBGGWcuwBgt0J7XBWgEEFXYnEptr7IMv0Q4Ws0GsB44FlH7kTLkBMZPNlmcK
	 nH1g39ZwOR9TckMK3Lb2i+VLtllA5Fx35pjfOvbclX5CucStq/RQlWLiEFleLz5xD9
	 3txG89fvMiEujHDvZv6ieeBslookfAsIFSd/jpt6q7bwpw2m54niNWCIod0ctZK+cD
	 jrb50Mw00fek3IaAZnrKjNixpoqntSeWIRdiqbyZrtvaekRbNqH1e02Hm1SR5HM9Fl
	 NUew8OwZpUA/g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 066273780480;
	Wed, 10 Apr 2024 09:40:11 +0000 (UTC)
Message-ID: <9488fe6d-8828-469c-bb48-5fd8b87f9cfe@collabora.com>
Date: Wed, 10 Apr 2024 11:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: mtk-smi: fix module autoloading
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240409204615.83928-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240409204615.83928-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 22:46, Krzysztof Kozlowski ha scritto:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


