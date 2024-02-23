Return-Path: <linux-kernel+bounces-78132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046AD860F56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CCD1F24D89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F775EE75;
	Fri, 23 Feb 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h8KqeDAW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C535D496;
	Fri, 23 Feb 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684216; cv=none; b=V+MuTTan+lrUnelKtupjmtc4Dk7tLguwiJ4zfQXfLDA8OkIC0TI5wROeQw1M/NwDB6p1HSi+/YAvmFI9jkWaRsPRuBYxFNwtBtkIijwe6cvKI9HpysDuUe5ygaHTVpXImQUZmeLY5PnugUcKvOn8bDAKs9R4FvOiPpWQ1eZnAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684216; c=relaxed/simple;
	bh=lG1vOEdIEIT+tsgIXj2hsQ9c8Cdoi+8MMRDj+wt4ZPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qQii8rTAKer4XFHL0bgwb6iAorY0HRRM62S6+MRDTjMNa+o5I8cLJYzIB7kSCai0G2mY7SbLsFiBLpCifO8nNHLgGRbUh8laLTmDv2acEvO0fQ+aIL2g/TovyI5sJM+HdPup0fva/yIz594D8BPEFezMdn92DhEK/MMkSBc9mP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h8KqeDAW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708684213;
	bh=lG1vOEdIEIT+tsgIXj2hsQ9c8Cdoi+8MMRDj+wt4ZPE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=h8KqeDAWWeFaJpGwqiONHdV9Xi3WVCrM6hy6olAK3cb+8vBzr5zL2QvguPXI79lol
	 DOC2+LkW9RCSc4fVFNJd3Xc9D4EC+R6UDL8zbO19mNWsuiR3LAah8rdWRwIZ5L+Pd2
	 rhjrnKX9CQkip2+pMvdRnU3CxYACKGgiNzu9FOgXPEf2wvWvZ2mFOow2PmxGrg9jka
	 d4pMInAoS+wdvHHVYYRkmfd7/wgVfSAYqazaT0JsXb86XSj/LzJVFerOZ/Sa6TgWsT
	 YwBT/vSGwpV/OcPIN6FYWuXR3XZ5cedN5BpwO2gY9+TBkCVHTUZ+aF3AH7tCkkxyVk
	 CTZmlupxnvnLw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9174C37820DF;
	Fri, 23 Feb 2024 10:30:12 +0000 (UTC)
Message-ID: <0a98ae3c-6d89-4a93-94bf-542092ae8e1d@collabora.com>
Date: Fri, 23 Feb 2024 11:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] soc: mediatek: cmdq: Fix typo of
 CMDQ_JUMP_RELATIVE
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Moudy Ho
 <moudy.ho@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
 <20240222154120.16959-2-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240222154120.16959-2-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/02/24 16:41, Chun-Kuang Hu ha scritto:
> For cmdq jump command, offset 0 means relative jump and offset 1
> means absolute jump. cmdq_pkt_jump() is absolute jump, so fix the
> typo of CMDQ_JUMP_RELATIVE in cmdq_pkt_jump().
> 
> Fixes: 946f1792d3d7 ("soc: mediatek: cmdq: add jump function")
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


