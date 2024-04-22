Return-Path: <linux-kernel+bounces-153166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16248ACA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22680B21B63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F613E885;
	Mon, 22 Apr 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uEdBGkmN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BD502B4;
	Mon, 22 Apr 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781334; cv=none; b=MrhaIwysNJTBQPAEW02oCUr96o8U02biQD5o/ka31KDMiOR1Andn6fEYXIOzcNxsIsKspKgZFgJtbLXGNZjr4hXfH+B4b4MCdmB/XDlm+0PoMO0v27FbY0yV3ZqHtP2WE5DTFu8clzYyPL/dbPaA/ZFBihqePIhWNKoizZ6dp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781334; c=relaxed/simple;
	bh=AQrDYKjCfdBFoCi8wbOPlT2hjQPA4gTSqxsxAy/egek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmc5blz5Pq2f8RNq1cA+1mWQdC8ZGkAx0Ci8iMSUabZZXq8PKbLuZILePMv+O2GdOVhW6/yOXOPMFwERXuXqne+In9MfhuN5VzpIuUw3Pn7m6xw16fyuagSunJL03gJC9srjPeQ1O0kMCUjlwtkoT5g+mEQXWDx1HW9CRFdf9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uEdBGkmN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713781331;
	bh=AQrDYKjCfdBFoCi8wbOPlT2hjQPA4gTSqxsxAy/egek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uEdBGkmNA6A4+zGo9iW/eW9F6u0l2tF5LrmH3G0Dsugm25hzGI8B+qO0HPqZJnnWx
	 8MJ2DrUAH+/Tv9lkDrMUM31wpoqvu3i5GG119W/dIF0N48KqtumkWEUSiugtjVeol7
	 WbsSw7Grg9cfd1IBQBO+vatCNoxVp8Gj3KbY11CkC0n/xttuGH9Om+1Cm4gUapbazI
	 EzKYdq/ngix4cHKeZR7549WcUl4Z73BRr3LSy166TGedHoDlQLLNii+oobwlcm+B1T
	 q4ZOePeuwD3GigcByr+BEAjc2KhDJGZPXIgIoPVtDtHm3/Nmy+jeHeF3QsLX1psA1l
	 WY5OOO5Pjmzvg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 922963780C22;
	Mon, 22 Apr 2024 10:22:10 +0000 (UTC)
Message-ID: <256e6f3d-9bb6-4237-aa1b-4a2b8e50da2f@collabora.com>
Date: Mon, 22 Apr 2024 12:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] remoteproc: mediatek: Support MT8188 SCP core 1
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
 <20240419084211.31901-3-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240419084211.31901-3-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/04/24 10:42, Olivia Wen ha scritto:
> From: "olivia.wen" <olivia.wen@mediatek.com>
> 
> There are three primary modifications.
> 
> 1. The struct mtk_scp_of_data usage on MT8188
> MT8192 functions are unsuitable for the dual-core MT8188 SCP,
> which has two RISC-V cores similar to MT8195 but without L1TCM.
> We've added MT8188-specific functions to configure L1TCM
> in multicore setups.
> 
> 2. SCP_IPI_IMGSYS_CMD feature
> This version also adds SCP_IPI_IMGSYS_CMD to facilitate
> communication between the imgsys kernel and the backend driver.
> 
> 3. Different code sizes and IPI share buffer sizes
> Each SCP necessitates different code and IPI share buffer sizes.
> Introducing a structure mtk_scp_sizes_data to handle them.
> 
> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



