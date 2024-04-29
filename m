Return-Path: <linux-kernel+bounces-161878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD598B529A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1351CB2117E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA514F68;
	Mon, 29 Apr 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eIcN00Ac"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A314A9F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377090; cv=none; b=G22wMZRCbbJDE4Tjzmvss8NW8hh9XHpcumR282pGKiQI1D5jDW3jVtUArr3MES66pzwdirPqPCqclJT74T0y0/VEQpuO0/1wWjgRcNlFK6O8/3+rnih8zy0cJ1E6/xPRaW3/987bnqbE5CFjOLCqMTShGA8N/Hqy9waHa+1rwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377090; c=relaxed/simple;
	bh=BWyVfoj+iRD2BnNonBeIbbnRWHTLN/2uky74f6rSTMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFSRPzU0kKg5X/dl9EwaKlgusQ4rOQDOe7N9PCIXqp2D7IwLRS5WfgYQZU1EpjOve1qCi+AjI3NDySRfFzm0p96oHfuB5kCAvuE01NzJeDLKwaMhg/5L+XHELg/vjKJdgekOxhtmgF7RihBzR8Usp3T7aWbNWjz3qTb4TJ9+5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eIcN00Ac; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714377087;
	bh=BWyVfoj+iRD2BnNonBeIbbnRWHTLN/2uky74f6rSTMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eIcN00AcO1/ueDSjKGy87DThfsuMl5E5GNHL0dRxWRtsy3V36PwaGFbPx7fvJYv2l
	 yJ3fUmYM7wPdbNfweFEsZdl0MHzL0PzgWMSN8KHL/AuBXHCZRA7UpMocxP5wJVG3j4
	 Te/Bay7g2F9lMl3PbDaUL3uVkuR6K/Pe6zSArOPzqz4RscaGmv/8u81PnEZu7pIbLc
	 KGiTgCzYlWz5TD5YUae9xbd1FC2fJEn9SVOeglEJdxPnMNsFBq1W8gmo8s5RwetOtP
	 O1NBeBpFXdMf3OHaOnVzPqKNm61XPuNPY5nolcTc1el7TOvwLeuHs25xGM4BaZ7uAp
	 4KnUgN7FaaOHw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 24F77378203F;
	Mon, 29 Apr 2024 07:51:26 +0000 (UTC)
Message-ID: <16ae9734-3c02-446b-9b9e-93c531c91f5e@collabora.com>
Date: Mon, 29 Apr 2024 09:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix pm_runtime_get_sync() warning in
 mbox shutdown
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240426020121.5273-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240426020121.5273-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/04/24 04:01, Jason-JH.Lin ha scritto:
> The return value of pm_runtime_get_sync() in cmdq_mbox_shutdown()
> will return 1 when pm runtime state is active, and we don't want to
> get the warning message in this case.
> 
> So we change the return value < 0 for WARN_ON().
> 
> Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



