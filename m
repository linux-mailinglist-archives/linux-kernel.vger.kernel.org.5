Return-Path: <linux-kernel+bounces-153165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A18ACA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B371F22BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8AB13E41E;
	Mon, 22 Apr 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UOmS5MQN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D213C3F4;
	Mon, 22 Apr 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781284; cv=none; b=Vs+CrUmFtI/fuTG8CuKzvxDPqm9HcUktRXrnGJh32lcJjiCjEZLM7r964o6cTm+LSVPANm8DMQAOZ3mr6Z6A+2qsxaY0QnHnKHNFm7IAusXLPlkF+XOYI1yqZWUhuYDZDCfGLuj4yvAxImV3nzXbDW8PaRtjF5BfA0WWFwqJ33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781284; c=relaxed/simple;
	bh=2be7ddOYKWR8xs1YeIaNBfdWx9fkiLTHGB9jAzYsguI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i8TVjRf0ua8hBohSiF/KXJf7zzBOMmfmgbyY3HCq4I7QrN5KnQ8X6reFm6ODhosbjlTcq+7ri58yhdgk/TYzi4UvlYp6/nhuWJQbt2U4pqGwx2QGYDd85u/2T5DtRorxAHYXvbj1DJene8csgmCndBiqj1NNfzfjz4aLopA367A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UOmS5MQN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713781281;
	bh=2be7ddOYKWR8xs1YeIaNBfdWx9fkiLTHGB9jAzYsguI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=UOmS5MQN5C3p5c1asHHFVKeXkqh2yyHEn6CJSRseym/mTQ5PR3gr7r4VQfngGlwi4
	 KHMax/dK23ukKtcC257YZXmdxt21PGvpfZix6J5PSk1c1WSEH7u1IcbXj+K2t7Dcga
	 B9JsCE614rMFqvOV/EERcknjMhyhr6nXix/ecrN1S+yT/lbDUmvst3MFbQUPvJW3ng
	 it7Xnno9rAi6HQ2Xv/NBmYcNekAb/lmzXnsiiTICw6yd2ZNS43xgGL0bYc7kvHdnYU
	 WpNlBVIo8DoqI1QD+/hVo+ns+rieu3ulrwu6Fx+GgP1lSgBoe1WTjCfp07sYHf+EbD
	 QuQlYhn/TBA/A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 081DE3780C22;
	Mon, 22 Apr 2024 10:21:19 +0000 (UTC)
Message-ID: <2aa41e46-be3c-481a-a7a2-04214ad2e4cc@collabora.com>
Date: Mon, 22 Apr 2024 12:21:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240419084211.31901-1-olivia.wen@mediatek.com>
 <20240419084211.31901-2-olivia.wen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20240419084211.31901-2-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/04/24 10:42, Olivia Wen ha scritto:
> From: "olivia.wen" <olivia.wen@mediatek.com>
> 
> Under different applications, the MT8188 SCP can be used as single-core
> or dual-core.
> 
> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



