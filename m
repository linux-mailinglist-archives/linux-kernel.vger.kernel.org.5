Return-Path: <linux-kernel+bounces-90372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7586FE4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310ED1F23003
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7822099;
	Mon,  4 Mar 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GqrZRx2u"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DC241E5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546761; cv=none; b=m/3HRYL7o5f20XCLAWe9efT51bTakuSDfftdXdjKwauaV0Ljt1WJPxBQkYA0GY/YZJVvcm8e8zwicD9ft7qYafipCts2aNKLGrhfXN1V7AXi94EJmW6o1EA6UrOdaztzibYLoON1+RyipcgxYqbbISYYRJ4oIQ/ODE2jUUooWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546761; c=relaxed/simple;
	bh=RWN2Ea3qOUjs6zLtAAXLBFQstrOSR//0aV6xqRJRRoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6LesYSu4wNaajNrMf+PgdJf6P13tL19i4OAkt/DNzCsWnm7q1BDgle2L/ertudmVH7EEgbU4a2zaZPNo7JbhCQ8BVmJ1wfsmbtXnB/gE5eXZG3K/oOcm1O96LYEhDpzIH55nig870mY0N0HeZJejFQB6iGt8wNPIply2HZa76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GqrZRx2u; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709546757;
	bh=RWN2Ea3qOUjs6zLtAAXLBFQstrOSR//0aV6xqRJRRoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GqrZRx2uqquFaYJnQ+ZQZ4Z5duNI4garPorJYbWGIcwBXVtikqwGmsSv+TSPAg24/
	 RXtRy6utMLXjpXYUgoqYIi3/d9O+yDEDdapjK8iyOOQWm95lkCw9vP+pqVAYSvaQD8
	 2MeMrgwT075yFyFqbgrhlhUourXnkm0DYcWti2SKsj7qwmwpzr5NkdzCU723O1qGkl
	 hsm+FVUUP+eKRI3nVfLaQw+qnAQ2d+V7KV28h+QT9kSsPpO37FbQ9Z+39g4eJeebS6
	 BZl01pEvqkNz72VepmGyH3Z82Mge3rfc4KlUMUxuOyG3FMtsearuwQFdR9Dq5xmou0
	 Zf8TRylfj2Qtw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D61573782091;
	Mon,  4 Mar 2024 10:05:56 +0000 (UTC)
Message-ID: <3dab3afd-7d0c-4bf1-b4f6-984f8d5d2d02@collabora.com>
Date: Mon, 4 Mar 2024 11:05:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event()
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
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
 <20240301111126.22035-5-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301111126.22035-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 12:11, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_acquire_event() function to support CMDQ user making
> an instruction for acquiring event.
> 
> CMDQ users can use cmdq_pkt_acquire_event() and cmdq_pkt_clear_event()
> to acquire GCE event and release GCE event and achieve the MUTEX_LOCK
> protection between GCE threads.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Change-Id: Icdae6b60345c7ec1d7541ac76d1f06da56959cde

Drop Change-Id please.

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 15 +++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |  9 +++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 2e9fc9bb1183..0183b40a0eff 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -342,6 +342,21 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_wfe);
>   
> +int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
> +{
> +	struct cmdq_instruction inst = {};
> +
> +	if (event >= CMDQ_MAX_EVENT)
> +		return -EINVAL;
> +
> +	inst.op = CMDQ_CODE_WFE;
> +	inst.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE | CMDQ_WFE_WAIT;
> +	inst.event = event;
> +
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_acquire_event);
> +
>   int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 2fe9be240fbc..de93c0a8e8a9 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -202,6 +202,15 @@ int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_
>    */
>   int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear);
>   
> +/**
> + * cmdq_pkt_acquire_event() - append acquire event command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @event:	the desired event to be acquired

What you wrote in the commit message is good documentation for this function,
please also put it here in kerneldoc format as a documentation paragraph.

> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event);
> +
>   /**
>    * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
>    * @pkt:	the CMDQ packet


