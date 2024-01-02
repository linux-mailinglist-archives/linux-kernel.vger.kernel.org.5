Return-Path: <linux-kernel+bounces-14172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34E8218BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F6D1F21EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029863D0;
	Tue,  2 Jan 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lPv38sIr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B81D507;
	Tue,  2 Jan 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186798;
	bh=B+g24IYiBKORcfZQs1hoAavc4iFduekqDsr9toXcU+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPv38sIrIyOx5QurwJmCJW1n3tFAcAidBfIeLyGrUDIO95QkL/6usSSP3retXr2jA
	 ZBsUxnoxjgHSCUzlyybC//aWBaHo6F+w6I77sXGm+DgG1e1QSBHUvdctlqyhRJHLwJ
	 PQ/JqdFkMxtur2GbXZEXQnZdUh4hfcEMLAUjarN+tzrY3bLeiXbyTNskhU1IjKgE0w
	 OUAo5VLc46dC1aLlzRcsZiQrAZCxCymBIEYk5Ek+RpXwo/Z488/o8ZtieHBdLNjZZB
	 enZ77+Z97j9jAxpCbYREEqMm6qIqAFgZ35eMt5JMMjKoBtVaRbG/1YlKhijxmHEP2T
	 S8xU/Lp+2gBuQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E222337804B2;
	Tue,  2 Jan 2024 09:13:17 +0000 (UTC)
Message-ID: <b2b8d64d-c975-45ed-a4ec-ff1b9a14708f@collabora.com>
Date: Tue, 2 Jan 2024 10:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: mediatek: mt8192: fix vencoder clock
 name
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <20231228113245.174706-4-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231228113245.174706-4-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/12/23 12:32, Eugen Hristev ha scritto:
> Clock name should be `venc_sel` as per binding.
> Fix the warning message :
> arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb: vcodec@17020000: clock-names:0: 'venc_sel' was expected
>          from schema $id: http://devicetree.org/schemas/media/mediatek,vcodec-encoder.yaml#
> 
> Fixes: aa8f3711fc87 ("arm64: dts: mt8192: Add H264 venc device node")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



