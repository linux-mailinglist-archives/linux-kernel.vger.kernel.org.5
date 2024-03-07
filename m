Return-Path: <linux-kernel+bounces-95335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A13C874C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87003B22722
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60E86636;
	Thu,  7 Mar 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g12ih/RF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09491EEE6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807591; cv=none; b=FCqUXxjSjrmO7z1FBBaiPrzV/XAfluWAkNraEpusQLjIHi9lciQHNqOoETGT2unjyO7Tg0AE4cjo3Yzw9HzE7+0BbOcF6ejllsGDybU6iDsyctPwME06kSJPUT8yWMnW5YT9q7TE4OO0vqt2QwQbpCJkgEGrpKppqd0wOoV0caw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807591; c=relaxed/simple;
	bh=w204slVxYNVadkZChPXCNGQajKtyqNyBZ5j9WXfP9X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3hrUhCht95LzxY9YXzeBoQXGppeL5Vt8V9sBT1KAkJIt8ly2bWozVQax6pw9atj9zGPox+UbkP55oYbwXGwcy3V9KCNPXI5s5lZixDqqY/D6w0/sEzDZEsC7YGHbnWzdN3KvQ6sdJ58Kb3wo4vZSydw6iFWBBp2HdFN1OsO1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g12ih/RF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709807588;
	bh=w204slVxYNVadkZChPXCNGQajKtyqNyBZ5j9WXfP9X0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g12ih/RFFV6IU9U1+yKEYX4YQ67QjswvMLP/0+FIn2lSaIjLGo/TOZxSsgRq//eaX
	 n0Be0wwzdBUjx9kMLSukwZL8d5jq90C/DN1V9zA/JoCRwyJ4Jjgp0Wcw3z2HkgI8T/
	 w3tS1fO+cbl1qZ4Nva7goipuVHCGbEJlnmuMo+ID58kFx6bjpR7wLauziCeyrbUXRJ
	 FDBSCtPcn/ylgo4/NcKnxWTh4vdmKKI3Kt/tRrPbkv+LoKggbgnqjMDnR5JsWMB3PT
	 75FZ2L1T6C52JzayTRxfN1nRRaE47JEiUe7ENQPM6w6nyjqNWhuZD8Ambl38FTwg38
	 b7yRIJq2JwvJw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 329B43780EC6;
	Thu,  7 Mar 2024 10:33:07 +0000 (UTC)
Message-ID: <ef1d901e-2bb9-46ec-b071-557c474587fe@collabora.com>
Date: Thu, 7 Mar 2024 11:33:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
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
 <20240307013458.23550-5-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307013458.23550-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 02:34, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_acquire_event() function to support CMDQ user making
> an instruction for acquiring event.
> 
> CMDQ users can use cmdq_pkt_acquire_event() as `mutex_lock`
> and cmdq_pkt_clear_event() as `mutex_unlock` to protect the global
> resource modified instructions between them.
> 
> cmdq_pkt_acquire_event() would wait for event to be cleared.
> After event is cleared by cmdq_pkt_clear_event() in other GCE threads,
> cmdq_pkt_acquire_event() would set event and keep executing next
> instruction. So the mutex would work like this:
> 
>      cmdq_pkt_acquire_event() /* mutex lock */
> 
>      /* critical secton instructions that modified global resource */
> 
>      cmdq_pkt_clear_event() /* mutex unlock */
> 
> Prevent the critical section instructions from being affected by other
> GCE threads.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



