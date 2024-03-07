Return-Path: <linux-kernel+bounces-95338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411E874C71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4632A1C22D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00661292CE;
	Thu,  7 Mar 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R/6V83PP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5F126F2F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807594; cv=none; b=MwEOobFxE+MTCMMOplE9tiekO62ImznZzqGUfC1jDEOTs5zcWpdenc/Aq28i/CSAfIP6JDmvbgpW1meyxIr/HJR1TFbd6CSDy8FxRQ0ylBXo3bKyVeSVjVbHL/02rYGEBxaf5dOmLSeQJaBNXPMblLQyAarBP5Mb1ZsxWlERqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807594; c=relaxed/simple;
	bh=/11EFGW9tQtxagiCeplNj5Vb/k8GC/IFhN6UfdT0euE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcydvdeQ4YLGhy4GGE7CBm9D/78gAccVTnaaBq5mCN3+oNkZ9w3SJq6u/SM+PeCP0WWyzMwYo2/ymD/lLg8TME1mjKQWsCNDeMn1R1w/Hwfo4kpHCYce12tyKOeVChRxJZWrDAL+/gnIGoZiNBISl3KPLsD4AwfpVQ15YPWpMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R/6V83PP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709807591;
	bh=/11EFGW9tQtxagiCeplNj5Vb/k8GC/IFhN6UfdT0euE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R/6V83PP5meBuhe9HRt1vcs5Q8prTG1KTb79kb65mqzRycYsq8/8tTx0fmbR90Knz
	 0YcVos1bK9zv8hlHpEhJyd/jjmDei9MRJyatL59R9UsOWnrkU5ephjLmA/DlNZGH9I
	 k4UyMPWEmRDwfpoXVq+ZiIy21vvPWy+x0IZlFtMUfHjYVpw1/pTxyysToEMnkkoWOH
	 Qb5M76eJOqMxkJfOvTnI7yNSyPh7OIU4pWpw0FROKLegE/UdWIos4UgiDfoVxFp8kv
	 Y6UvjgZVsmyVIQXV6Z4a3tK6265ZQrkdJXnazOmuU1OxlGzNCsYCgbTQWTd6c/yv9W
	 Ad7cU9UbGGnvQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 44DB037820EC;
	Thu,  7 Mar 2024 10:33:10 +0000 (UTC)
Message-ID: <fd556d8e-f863-46f6-80a6-4369088e8719@collabora.com>
Date: Thu, 7 Mar 2024 11:33:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: mediatek: mtk-cmdq: Add specific purpose
 register definitions for GCE
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
 <20240307013458.23550-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307013458.23550-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 02:34, Jason-JH.Lin ha scritto:
> Add specific purpose register definitions for GCE, so CMDQ users can
> use them as a buffer to store data.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


