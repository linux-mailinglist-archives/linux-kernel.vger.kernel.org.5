Return-Path: <linux-kernel+bounces-46081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD86843A04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD781F23213
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FA83CA7;
	Wed, 31 Jan 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3aD75dZ1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA866B22;
	Wed, 31 Jan 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691121; cv=none; b=Ocf1C6vzkzeIwjFXJ7TQj+d5zUBgaS87tAhn6pMAcjXiYocAK6v8GTBKqI3kCNGQLEs21GsqzjEzYjFuqoJuiSUEj89QXQZ2Gb2Ggdf8fSngDgpIJEds7vI0ceJviXcdbMrpuGdiDI36N7utBxDpIKcm27MsKUEyZ1pGlkAMw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691121; c=relaxed/simple;
	bh=sZRwtejcYMIEZgWQriqWtikVuHIHGna18OXu9zMGt+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHq+X0wxbIB1Hi/doPTKVSn3GWLFyxW3l2ndTr58GHHjPs2FWwdZt39GZXpyb+ZvhKEo3kbE/KyK2DtJuuqXjFo0rtIsXb2EYkHsJZlVfOccEVcWGnBXr0rzrmeL9YQAc1VQUV2LOuF6KTaQ9W5CiNOmQmcBVKkauNAmY153B3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3aD75dZ1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706691118;
	bh=sZRwtejcYMIEZgWQriqWtikVuHIHGna18OXu9zMGt+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3aD75dZ1Tiz5t1wu15DjuxTcrDEFzNgyEpc7lpUD8aCqiQwIvigJTOFhFw8KnFzam
	 jH6JzJRt5ABEL7xbqk//fwUUtshQ+zAhCCvZU/YMh8SMjDqiVOKDedUAOADcBsxshN
	 lypYtjGTwQ8Fe9pDstbXQAoCPscw5syRcayrOs9O7ZowI5lVoCYwlJk6BTsX+VDzab
	 nMr1wpznNFp1HgmyAlcFZfxVh8RDbcuou2LwtB5gid7kxX+5nnZp3AVCp3zQ484gUz
	 iQxu44XhsQWs+UR9GAnWtB11zPJmkVjPZTREq9PaxaX0crUZsqzfjVacWOK7sF9/xy
	 Wbf3d/Y9tvYIw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B6FE378203B;
	Wed, 31 Jan 2024 08:51:57 +0000 (UTC)
Message-ID: <3561b91a-9e02-47c8-ba70-2b7f082b5ab4@collabora.com>
Date: Wed, 31 Jan 2024 09:51:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Drop bogus slew rate register
 range for MT8186
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Sean Wang <sean.wang@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131071910.3950450-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131071910.3950450-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/01/24 08:19, Chen-Yu Tsai ha scritto:
> The MT8186 does not support configuring pin slew rate. This is evident
> from both the datasheet, and the fact that the driver points the slew
> rate register range at the GPIO direction register range.
> 
> Drop the bogus setting.
> 
> Fixes: 8b483bda1e46 ("pinctrl: add pinctrl driver on mt8186")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Argh :-)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



