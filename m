Return-Path: <linux-kernel+bounces-42561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5E840323
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F9F284419
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1A56B67;
	Mon, 29 Jan 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0C0rvqis"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29561537F6;
	Mon, 29 Jan 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525276; cv=none; b=Uc5JnM2EIbutnLEAZ4U0AFLXokRSBZKZK+vla4j53Pqqt57RJDLfPSru8XpVmOt69OBqISIxqwUJjr4jfLmqUdYHuqB+wQYqCDAchtawhGe6azRFddwgNgxmEd3ki7wpYcFxXN9cshjwtfb6vyjuG+RjnuCXSKQerSXEijmlESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525276; c=relaxed/simple;
	bh=8Au+/H7E9o8ti3xE3u2gCsCzYHjbfhoH5OhsSjspxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7LvCjaPO4eT1jw8O2a4p+sVA5UZGVV2crBXayrIqqYVcmX9p1BO2mi+fCGBn46axZ0D2MSq7QVy5DykLOwYnKop9yanKxxdVBDaoVpuXJwUu4Z4D7X/1vBAvGspR5BlqBVwHerwaYF1IKzOnMFMnDAeBtQ7vX8lLCQqYVJ0Fnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0C0rvqis; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706525273;
	bh=8Au+/H7E9o8ti3xE3u2gCsCzYHjbfhoH5OhsSjspxj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0C0rvqiskSDGqyZG1knyWqrtpk+bGHC4dANO/XqqQ8pIbZK+5jHir+Fom/2ihzX2r
	 P2rr2NfMiZc/IO+YTd4qz7y4CmURH5LjUsD36HAHK1+WHqmwuSbWbjmh419yRsXmgk
	 xFKST7L1JsjYr+ypMyVV3h9I8jAE4EuAUvEeJ9u+3pmCLClBy/9VrNvfl1oqk1izAa
	 X+HF3L3lJLRVn609OYsayVO3DJrp9OdGVtLkFc6qIrnjW0+XZ8xnpz5YxPnm7NQSu8
	 3lWR+AQ0a3JDmJ8II7TEYDJzG56Q2dsSh591nfnGHBDDVFdxclKVAFKrigrZ2rpuuj
	 RROhr6N5EAeXQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A0793780C1F;
	Mon, 29 Jan 2024 10:47:52 +0000 (UTC)
Message-ID: <6f362f4c-7a84-4979-b507-2384363d63ef@collabora.com>
Date: Mon, 29 Jan 2024 11:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/6] video encoder on mt8186
Content-Language: en-US
To: tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <170652472371.127352.1415914611175058375.b4-ty@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <170652472371.127352.1415914611175058375.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 11:41, AngeloGioacchino Del Regno ha scritto:
> 
> On Thu, 28 Dec 2023 13:32:39 +0200, Eugen Hristev wrote:
>> This series adds support for the video encoder on mt8186.
>>
>> Few patches fix the binding, there is a patch for the DT node,
>> and one patch for the driver that fixes an imbalance.
>>
>> Changes in v3:
>> - removed the patch to add dma-ranges, because this was intentionally
>> removed (e.g. https://patchwork.kernel.org/project/linux-media/patch/20230303013842.23259-3-allen-kh.cheng@mediatek.com/ )
>> also removed dma-ranges and cells from the DT node
>>
>> [...]
> 
> Applied to v6.4-next/dts64, thanks!
> 

Sorry, typo: v6.8-next/dts64

> [2/6] dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
>        commit: b8248c4831787f0854e2e856fa83da68ad5afcde
> [3/6] arm64: dts: mediatek: mt8192: fix vencoder clock name
>        commit: 0157de54920b556d575ffc82ae5d16f2b4cb9494
> [4/6] dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
>        commit: 178eaba322868a75c2e0ad078fcf91c3a6f5abba
> [5/6] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
>        commit: 2a08dba6bf6637295175f48ad870a24833955cd4
> [6/6] arm64: dts: mediatek: mt8186: Add venc node
>        commit: f971c7ee301bbd423e06f82bcae768223a4dd602
> 
> Best regards,



