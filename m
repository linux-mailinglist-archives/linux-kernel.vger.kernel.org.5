Return-Path: <linux-kernel+bounces-66690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6258560F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0EAB38DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE661369B5;
	Thu, 15 Feb 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lvNejExa"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F7131E20;
	Thu, 15 Feb 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993643; cv=none; b=PxyUw1hW/UQlkcOY7WH1eKpSO1EnPCFwb7u1UbLDACnmEOIU71kb+tIE0lnOrSSB2HIECR1zxzHuICvRdPNI758SZCaVoZu0DJk4/SgQn6FbckMTVlqbW6gs1XcpSl5Ca2CdzvpvL+bf9Iecl2yIolkD4l6p1ngPTbE2NWEF2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993643; c=relaxed/simple;
	bh=nlxfPyXyS3DwmGG0BjGsvfTGa8VmVgMDtRQi5cpSk9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ss79X5S9cpLJpTnjBjQK9x/DouKzOFUxyV6l2ZuK6oTv05jNsXufNrFu1FC6j8KA2+2UR7WwEx1fCbDylMU04xNgz17FQbGS0NAWPOSeSJJ7H8hzEh3m10VK3WkNWfDl2erLRYus47XxTCWis00UftwQu7RE4wEIAA51QSikFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lvNejExa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993640;
	bh=nlxfPyXyS3DwmGG0BjGsvfTGa8VmVgMDtRQi5cpSk9A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lvNejExaB1qI5bWedf8hfgnoRDAu7TxJusVk/z7gT3DXCw2RO85eW9To3JW+1uG/f
	 4CLBzoNrZmESFPRgsA8Zjk0ZlOMULiBYQYH965sijPR7IydFwAhksybhj6s4WRi/19
	 amqFsPUd3Bse7TxQGPv5C6h+zEQzkAeRdReuPnPh6gEXhuSbUy5u+4Dvp1WdVOLpC0
	 InA3ywfYSCayXP3UnuMiprRyVphrBMfbPlJB6r/7Nw9uOagcz7Yo+i2vhYP9vjU8X7
	 rDoUdZkPMcC9LfEqhtQcWPsm2zM+3qnCs6G6RdLmFVbE2YWUtEBbey1RnMmo/Z5Znr
	 t3tXWjJeQn+dQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 50CDF37820B2;
	Thu, 15 Feb 2024 10:40:40 +0000 (UTC)
Message-ID: <602e4364-c65a-4a32-a411-444a40a5c1d7@collabora.com>
Date: Thu, 15 Feb 2024 11:40:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/mediatek: Do not store struct cmdq_client in
 struct cmdq_pkt
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-9-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-9-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> MediaTek drm driver has the struct cmdq_client information, so
> it's not necessary to store this information in struct cmdq_pkt.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

As said in patch [1/9], this should be done in the common function, not in each
copy-pasted function in mtk_drm and mtk-mdp3.

Regards,
Angelo


