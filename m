Return-Path: <linux-kernel+bounces-88112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2286DD73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27D82813CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBE69E19;
	Fri,  1 Mar 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="etN8nzlp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55469DF7;
	Fri,  1 Mar 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282915; cv=none; b=FzaeuwmBsKHgS4DI8SUmawmjwUQQNu0g1uVeO+uOpzzEJgoCmnD/UMOQVB9h5wzTrz6eYm31kkN+pVG6OCaA2ngGIQBuwl8cqdNyQUJ52xKlLKex9H5ymQODfbnsyuGtjzB3DAj4xey9jwngF00kj1bikiAce09B6u+wZmwVnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282915; c=relaxed/simple;
	bh=FNk79zFXeYWQnbnsxxWTrbJ6d8shuW3/xi5dNaAa0ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USYC/8ws9eQNGUq99xW8wvFeDU1uHMNTcnC6xx3hyucBcsGEP0V/EfKOvbD22J1+tl0qQyMPOLfZc+1cgdnpCHyudbst4uompbJpO41+QhwBGGsXJiWBd6m1iseerxS3hKEgUdW80jwrtmRu6ZHV0LLlWVQREy3lZ5BkFmlnuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=etN8nzlp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709282912;
	bh=FNk79zFXeYWQnbnsxxWTrbJ6d8shuW3/xi5dNaAa0ZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=etN8nzlpQ0m7Q0Ks13XRtJumPGgOkExxuY3wrNoGTAppx6S6sxRmN3rD7OWTKkYTF
	 cDpzmlFzmAlBtQq97XOSj/tWoftQVsNNGherQg1/v66FP6Gorii83H+wvthjBfGdSd
	 5ik6Ci4TVpvhvhemG9VOX1HJto/vZDlgmZ0Mr8VidLJ2/RlfCVXMxBlzsKcTbGUTCt
	 zdKO7ZXHxggdXOpRR9FN9cX3Ht72tnkl7UQhLiF/bAPtNapjdrQGvtVL22ZngQ6+Nb
	 cbfpaR3eZoLirifB+qHV+5wNaoshXcdXzkd234Jqsuqsz8aI5/jxZXUWD2aFpXS16w
	 5Vi9T8/NXl6yw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEF0737814A4;
	Fri,  1 Mar 2024 08:48:31 +0000 (UTC)
Message-ID: <48962bd6-3d46-4d3f-b722-1820b8b9530f@collabora.com>
Date: Fri, 1 Mar 2024 09:48:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8192: Add missing
 gce-client-reg to mutex
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 "Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
 <20240229-gce-client-reg-add-missing-mt8192-95-v1-1-b12c233a8a33@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229-gce-client-reg-add-missing-mt8192-95-v1-1-b12c233a8a33@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/02/24 20:44, Nícolas F. R. A. Prado ha scritto:
> Add the missing mediatek,gce-client-reg property to the mutex node to
> allow it to use the GCE. This prevents the "can't parse gce-client-reg
> property" error from being printed and should result in better
> performance.
> 
> Fixes: b4b75bac952b ("arm64: dts: mt8192: Add display nodes")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



