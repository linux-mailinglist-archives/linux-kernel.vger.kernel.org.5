Return-Path: <linux-kernel+bounces-98711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A53877E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB851F2114E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F37152;
	Mon, 11 Mar 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zeCPiw2N"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40032EB08;
	Mon, 11 Mar 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153906; cv=none; b=OPMf7B8/1TqLBrxjorDow7qZxiUlasAHSnZye8T6jfO5csp2SJ38pCkoaGYKpY+fWlOP6JyV0/1PkyOmjqJCqEJJcmukvSpus5l4NeygFFA1+p83+TNGIzsjuLcVJMoFLSAMHYRba2HN5VlCp7SkG/VYG9YUXBWTxIM4Pi2aM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153906; c=relaxed/simple;
	bh=AYELuvmy1IHugw4HnM4ONirROKH+Pk7pIjRURZ1g4/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvB6onFSl0PMt29i44xZfMXA8tTfkMJ/AUU4Plo0KJSJiS5lcGaUxs/V59MFu1VqRpJ67qRQZWwAWxMBmpFeEO85PK/sN5IjLjR32hLnNgf3jx/A057pWLkT2LwL71Dbz8T8SqyUw8jtYNtIgQW2jpmG9T+SLcWrfAneT8HlEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zeCPiw2N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710153902;
	bh=AYELuvmy1IHugw4HnM4ONirROKH+Pk7pIjRURZ1g4/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zeCPiw2NaTtpPrHbsVrCZtJJz0H/3f+tzrBmZBeX6ynqRj5bpIEBKF0UB2Kst9hr4
	 WQF3hylF9IJ5raWGfDj7LlwR/wF+jy/BIj/VI1zG4sm6+L5pgVW/ON3XMSDWMleLt4
	 setlWC8CoO4YdIHTY9Q43Qip7E6vh940JsbyF28hcAl81vFcm3XmtLnUT5f2pSAQ13
	 b1+ZqZpILojANIxMQ1tY6r0mhNPJ7omXdbLVbybpPORXB7Im7LIxPUrMpWCIbSnAit
	 TsoCVTQV0I3+8DHHfmRF7cM95Vx+tfodXxVpZf173T980V2VXyQXSRNRcfllj4OKcm
	 1Eq8M63hRraog==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F9F83780629;
	Mon, 11 Mar 2024 10:45:02 +0000 (UTC)
Message-ID: <3cb2528a-6e09-45c8-a590-f38d37660b91@collabora.com>
Date: Mon, 11 Mar 2024 11:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240221155905.1217340-1-mwalle@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240221155905.1217340-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/24 16:59, Michael Walle ha scritto:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



