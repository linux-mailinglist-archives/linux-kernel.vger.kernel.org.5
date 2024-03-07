Return-Path: <linux-kernel+bounces-95336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A6874C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D72C1C225CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D51272DD;
	Thu,  7 Mar 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NwAQ1Wvm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37E85626
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807592; cv=none; b=RmS+3X3jHFu0juLjxjeGx2bLW2x5rum2LjmJxqYOJ8zk5+o84DlWrWOfgtoeNkgwtstGUCCWZWc+Kn+yuqSZtLCO12X1x/9dDMqWS4QX02eYF0WBmRbHRkARKnZUU74nrtzSEguoNV/klEGFMmvPo42l4Y6h5Xr3zq92St0GZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807592; c=relaxed/simple;
	bh=L8L1t6vR3+FIcUH9lsp8UHwMW9LCHOizjMz2kHHqd/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/qDEU/hijXfWxVvrd+F7aMBgsuurIY1KCorr9fSlfQIaAneL9l4BW2gMFepcAj3LDOkN2vIiy53d/kXDfc94XrEuM39ioapw3tZbDmbN5LM0mWakZyWAtIOcFg/em5WO+dbyaNcbr7A9ryaFxIVAtRzhUN2g8Cbw0N2tl3anlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NwAQ1Wvm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709807589;
	bh=L8L1t6vR3+FIcUH9lsp8UHwMW9LCHOizjMz2kHHqd/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NwAQ1Wvm8vG6dt/M8t5FWhxZwSttfRhLhkS3Daza1zhVkAgyqxNE8iJmqh9ncTuut
	 yXTY7y66lAviwCcFPbTw8cBq2QTJpCAS/HWCZ/owCEhs7aPTGlZdm2gUiXFSICyYxU
	 91QqJRDcxtEwoPRndoNYMyI7NZs64C1FUG1cu2Z5kemIJT5StYPxW1W1+NIsLcZZdM
	 9Gu7lgMqP0XrQTxGa/YSPWLyVRHRbcxGiH7oon/RGNOYJCu8f2DPlsV3WenHukFUb1
	 Dlr8F/lD5K/lfceDEF9ZmqH4bQjd+PdXNKVEgTNRm8VqlNR+fhN6JaHiPl9AAatlNz
	 RmCRDsonNg+sA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4489637820E9;
	Thu,  7 Mar 2024 10:33:08 +0000 (UTC)
Message-ID: <54d746b5-a27b-4076-98cf-51c887741c68@collabora.com>
Date: Thu, 7 Mar 2024 11:33:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr()
 function
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
 <20240307013458.23550-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307013458.23550-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 02:34, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_poll_addr function to support CMDQ user making
> an instruction for polling a specific address of hardware rigster
> to check the value with or without mask.
> 
> POLL is a legacy operation in GCE, so it does not support SPR and
> CMDQ_CODE_LOGIC. To support polling the register address which doesn't
> have the subsys id, CMDQ users need to make an instruction with GPR and
> CMDQ_CODE_MASK operation to move the register address to be poll into GPR.
> Then users can make an POLL instruction with GPR to poll the register
> address assigned in previous instruction.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



